Return-Path: <netdev+bounces-275003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCD0CQ2pz2lxywYAu9opvQ
	(envelope-from <netdev+bounces-275003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:48:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E119393CDD
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A80DD300F5C1
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F88E38F63C;
	Fri,  3 Apr 2026 11:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfWlkBIn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BC30AAD0
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775216873; cv=pass; b=HFGvPN4F6THF2PH8cyDdofs4S7kELnuvoAsS7qya75Z20fCk/cQSBl6dDydc9GYciHnACTLy7hU/bp8TX4MeGC9C3iAdySoeOBGyxzIbvU7TaHpg2PG+QleffnYkE7oV6DRrOWD/6nP73D99MuKC3jUY5yolU4tgUjr1ff7ZxX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775216873; c=relaxed/simple;
	bh=zR+yrlnjVUiKXda1qmyDEVL3anmPZD/Q8XtOqpkb1ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKS/rsRUyWD2t9+hmwB54UnNMv0f/UdIp8cGS47Nm6urjPcPdQNyzOd/T9grqTHd5bl8/6rGUwyR7gJGbrqb2SQ8YoTefGh0jixkRrSMEGljxySmRqHO/0bqqzDABEQ7jlIYbRvTL70hYfOPl1vNDkObTV/Pgc5fQuPw/OWQoMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfWlkBIn; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40438e0cba6so1215806fac.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 04:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775216871; cv=none;
        d=google.com; s=arc-20240605;
        b=PU8rA1EzsIqKDstZyq4laIMLGfLzdi77knf20ayEpfQu9ZSLez0nIsNqyxyBr0DEG1
         qpsGn8vR7N/XPI96OO3UABPC2Q124GZL/pL1PO8kH5K/gpwC1oMfYJz7IZFU1WLsAE5L
         eWaRWLU5vV4wnFBHpW/0JXTyg+aQiD5uwPHxuKZhqbECzH+gfbbXvadztqIfNJpLzdST
         ATbT9uceDznhNB2PESCZDiiLPOk0d82CKxZjs593Kufu9TDDy9uImJmQ76qixT3sfYtS
         7Fqbl0twhYKIV9rMhaujiRlvZpRLxR3M8n7C+x3ligaUVG8YPWPYNB3HloA0P5vO8yyL
         KA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zR+yrlnjVUiKXda1qmyDEVL3anmPZD/Q8XtOqpkb1ho=;
        fh=/V733/2j0uXJXGGDZMhFb2OczJ8cNllIoiVmUUv9wKM=;
        b=CEEdaUi0LEwy7YiLxLCksw4jzX+aqffpP72/3T+PbzrTxUMkWrkykyUhjkx1GMCq0L
         iED6n7knX/nTwN6cM8BvDjgC2bCZ8OE+9EGGBmtZf6PeMFMJwO5cP///I9ptwjz5yy2v
         zIW68Lwh1/fvurDQ8mhmXHOaWGJnetF3Ban58melPg4OEE3t5IGrpzo3eKFce8FkaZjV
         7JJevn8Y+TMP1RLkSWWU0rXopB77zVw6aXBKxb72JHbg7jo/4PqwDehrpJ8po8DhbWJK
         Nu1pYIJkSY3sW4hBifTrPKaEGl787Ph7pKSqUuLUxtgP+COaxVq1yRN/4VA0UaSBT6dG
         o9kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775216871; x=1775821671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zR+yrlnjVUiKXda1qmyDEVL3anmPZD/Q8XtOqpkb1ho=;
        b=sfWlkBInQ5uqr/C7oavYoGDTEY5IB5YUN1mQNyvMrp3tM4Sh/7Uw8Mb99ElfwOJq8H
         4IjiRbBNM9yrMJHQKMStWruWSHxvG4FE+yoO6lu2vEDqjYz0+LAbzXOUx+gapZeFNwra
         QTZAKXruzz1qjfqAwBKzH7gJv0t6NLyqzdSdbYucLMaBiyz+7De/G9lBgXxkgdVE+xUJ
         ropMCL70dCARZXvjFtf2ghuprM+DNdcR5oikxTzK8NzgMgJXLLyhGoYKOt8ydXz1qXWx
         7XtgoILjRqNTybQwkHee5XaDyTE7CDYnYXRVGBijNhrVlP8uwTqpdhb/oLXQrHQdl9xb
         LCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775216871; x=1775821671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zR+yrlnjVUiKXda1qmyDEVL3anmPZD/Q8XtOqpkb1ho=;
        b=TniIYVlX1mQNq/xa62bobOXzccNd5yYDg3R+7tLyrpv4pBiGWqiWed4CHY9eA7RPSv
         sc+N2mXE8iu+Ir+rc/bkng5h+niGdyMXZOkIUUEap/zvS/sU7ZzRj9g0FUi2VzZTU0Tx
         KGAtJETZ82cWefSlCayCF2Dj5kJnWjk1UHCwkFnKLKXt7pVBoQ70mEfLZcxs060N0BwO
         buep8t2Wf5+xApOZj/RlKlzK/LryXzUnEvZSt7TtCvKT+1Y1GwmM42TB0OAuSErj4dO4
         MO05u1eY6tTdkS6xsFIRjHQeJkbAaVjazEjzx+/ZR4DfxpUSfPHvpfgNoELV9tjL9Jb4
         P0/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVodSdWV5H4mDoddXc7K9r9gHpTSVh5B5+ppZADhbEj/XWCkqHHgQjzLPxAf2VFecffbH/ykS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVmz6iG8ixKMy+oB5UhhyK6/IMO7nkOkTLnlhPIsVPoOHdEmdt
	VC1YwFkU/H7mR5Jd/3FwkoF0o3aGZAHzq+unkZqiLF6otEOLx1kTcyO5SYxuA9eIxFhJLsK30jr
	1gbzgKmApT2/NscN6I7gamPysH6kx3QM=
X-Gm-Gg: AeBDievaGlgJlmo3CsWBWFiNqEt1wSFvNbvO9ffEa9MKSsdV4omJ0+7HcuZnibWBImL
	hjDjjxKQ2rAH1T8x0swnVe4wb6eb06DjuiesoVJnUAryyxYdd6sFtPCkGWAKchbQKhS8zO5oOlF
	p7Q0MJT6I6vWzm0twRNSiq52UjAekYxbpOwO81PulN1TPkM5N7QFYQ+ilJp1RDfWO7227aXRmoW
	kPSyd3AhGFoT2DOhNC9WunKcm3cPRZGUKDMd0+kNfcpprOam1wGipjY9R4xp/jSsh5qRTNRx5UP
	qXPqxb0btlvQXTXAdilcW28sNdmNMSoKD724Fg==
X-Received: by 2002:a05:6870:210d:b0:41c:4c64:8e60 with SMTP id
 586e51a60fabf-4230fd8f1d5mr1292627fac.16.1775216870881; Fri, 03 Apr 2026
 04:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403103654.15304-1-devnexen@gmail.com> <CANn89iL-4-JBQLsumT_XGv6DYXUWtgKHYKVztec1pj3w8ksuDQ@mail.gmail.com>
In-Reply-To: <CANn89iL-4-JBQLsumT_XGv6DYXUWtgKHYKVztec1pj3w8ksuDQ@mail.gmail.com>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 3 Apr 2026 12:47:38 +0100
X-Gm-Features: AQROBzBBrrCy_gk2cqIFEgf8V3DuehlezYtYwv5mogcT5MlkSX1cFCLSXbe6DjY
Message-ID: <CA+XhMqzgh2uUQJGfMDyJ3LfmLm8g=KxAexTMOqqj8Ek-8b2HmQ@mail.gmail.com>
Subject: Re: [PATCH] net: use get_random_u32() for net_namespace hash_mix initialization
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Qiliang Yuan <realwujing@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275003-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,suse.cz,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6E119393CDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sure !

On Fri, 3 Apr 2026 at 12:34, Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Apr 3, 2026 at 3:36=E2=80=AFAM David Carlier <devnexen@gmail.com>=
 wrote:
> >
> > Use get_random_u32() instead of get_random_bytes() to initialize
> > net->hash_mix. This is the preferred API for obtaining a single
> > random u32 value, as it returns the value directly rather than
> > writing through a pointer, and requires no size parameter.
> >
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
>
> I feel a tree-wide patch could be attempted ?
>
> Thanks.


Return-Path: <netdev+bounces-291419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AXqHG2YFGr9OgcAu9opvQ
	(envelope-from <netdev+bounces-291419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:43:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FFC5CDBCB
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3560D3025927
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999B03750B2;
	Mon, 25 May 2026 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JX/IfKvP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EC6370D58
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734534; cv=pass; b=rpG5J+gYKu9eDXkZ2cCClP9TGg0LhWBB+fDZXHbRlOmw2gCRUzdGKuSm7Gd2K2QHDmi5tcRIlY9QcflkZtrhbMP19FBuQm3gvPA3wsdauoL9hzYx9+2f/yQIwGyiEmvzVCrre561D7viqYVq9a+iNrYkPH13SCBWkjgLizVa9FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734534; c=relaxed/simple;
	bh=FiiY8kOT18ZBCN//xs6x+BHEBTs9tx42Sf39TQeTxGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsPZn2VQyfgGAPZP31tAS3czaGT794L68S5sXv9C0E3S6+BJGeUWHGsQ9PKSpU71f3ff4VNd/hNwluLlc70DJzATu2SIf0DPYBNwxEolNflj5SbX1kgsT15dWdUrg3wVEed0sj6qyYg0m/NLfA7DNMG0plmFxkoazIoJOgHGMyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JX/IfKvP; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50faeb8317bso90705921cf.2
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 11:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779734532; cv=none;
        d=google.com; s=arc-20240605;
        b=gFAAMpc5oMIrdIHJWSYAXCemsUIs2pXf+r8RZMwk46NNLAL/LST2xYOnY7yoQb7O48
         erAP2bSFidkBWYKVY7q1s53mNeGMPqniUqesUg8rKEL4UTETTuE/zTVlWAuZoROuAj8F
         Fu9vsmSoejpV2Jsx18VrgWpsb6NGZJ2m+GuX+6FnuEA98qfs8b061NeeUAjVwDllfNtW
         eLwhuKZjvQwyC2PKDtVbQraqt9dls4jd7XXd7mnvgISPfIX4C3NujpesVK7aFslYd9jG
         T++Jbu0zyv5phy5IQPC6Dl8ujByrlgXJAZVg4iwOSjS/BZMa67VEk4rUrxpds61LLc3O
         aB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FiiY8kOT18ZBCN//xs6x+BHEBTs9tx42Sf39TQeTxGI=;
        fh=+M2dxghUV7exs4DDzCRZ28xtJgpQjHEvo/HvlXeYloU=;
        b=UcpoI1dyhNHGFqyotavevIjfE94NQv0JlTaAOJjiPh/rnHNEVKlBxd+QBv0BjOQKPI
         61F8oHSXEJeVi6AgfsmQdkaU5ovSCeZQXwv55bgn7XpSV91sIJZukjiIR0EtkOtMrqAb
         TUcMFRxY9hn+gNz67pK674RVqkaxbQ6o1xCYG7aWDE0IKChDY5oy5+8N6ovWr0cIoVpy
         bUieKCQUnb77k56ZmQNmgxAgsFTn7hVLr/Br7Fv1w0m2mos7URfSq19b5OXzFKNv+jU2
         fv7mk71K+cvlE/H/MjQQYUeyRhhxwxTVb4OLgpN3Ntm6xXvAmXULbqc8EE2F7umWQ2bo
         N/CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779734532; x=1780339332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiiY8kOT18ZBCN//xs6x+BHEBTs9tx42Sf39TQeTxGI=;
        b=JX/IfKvPjk5r3tB50ypFWRE6YuBDiYsIOVnAa8BvPGLDzmKcugs82GwcFBT+ItFiNW
         KASmBJXaVuGftznffrfwOtaJD9xKIS491p2F2VunimPN6VrIKevhRRUAWyKGQFzaTSSH
         qIB0ETFzZySQO5llXQv6qu2gFOWuEBNkKyi+tXe850Av7/GxRPFqHs72DAKbaR+vcmNY
         jDok8AR+PP2CAUnRxlTAWUvB0d6rl1JBhAX8kn5HGD+by3fP3Z+vYnwZXp2J7uA/qQZl
         W/FaUVv6a8CdlffEXRUgMA0z9CAxcy8X/yRBqsCCLzTnB/uWhY4SY6PAEGZW5VK2aWkJ
         o4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779734532; x=1780339332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FiiY8kOT18ZBCN//xs6x+BHEBTs9tx42Sf39TQeTxGI=;
        b=G564E6mjcmTl6u2CFSQ7QpAn+Cxj/JF1gncwanV47aZAsGIFGGh72CLiUctQ2xm7xp
         z9cqmvwR93GaxP4y198rIjuApeeSjCHB2sV2858cwTdUZnWTJyPzUz+GuYxfbLf/so9i
         Z/9V0SfQXp5j5gQxRaMe6b4bTJtgiRs2tClWcjha3KlbTwEAW11YUed36QmCXZbF0abr
         F13i8aP2JNfQorHInk4yKfQ7DYVQnwPVCaABBqW7mXr1xbRvCFkqv1j5fpel9FzTHlv0
         si05dKg9471E9zoPCztSGqgpXgtITpw9+9JPw+PWjiNy4h2DNRs9AtYTrtQ1xRQU66qw
         bCiA==
X-Forwarded-Encrypted: i=1; AFNElJ/LOC+TgwxmZDHkhfDQ+bxH69wnBQ6TAD+4ofWusHW5IswXYtHZ5FNFV7MWxyOGPpjrMZCb2G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJuwOdAufEr/W89lLVGpkgHqj2k5xOkzsyQ9r8Uy/vX11GQtcX
	VdYQU/qOqY2E+RGXXVuvQ0Pnm7/4ayRW57NFOIqLcJnY7WzalxVOCMplDKLNg7lvWNGjJfoGInY
	rW5hFz/yLtaYKzAYvcmwJi40pNDR/tdFbyzUcbVgC
X-Gm-Gg: Acq92OH/T8gE76hvmpUgKS9Xyi0ajEKisy1auxzfaWbtrA1ZVifUCPaLywmy79im/ub
	3+5OiULLUhHuc3BKt4qRJxkRK33eaaQ65HIb4IcqKYiOkV3uIt9g0hXz7Is+htqseQrD32uKyBD
	d9hDn83rMi6e6DPgTs+bLcptgZh3CLJkf3EZ33QwifQERWDy9x1gNwRFVyoSuDX+ijzXS41qp53
	cwCumpwyG35GbMNvTtDQHyD6pUEeErJAX2UvMROFTgvD0LI40q3wXG9JsZaN5slmAAt+RXXSA0P
	qbU0+thjw/0U+5LMbGds0VQ96Pb/cT+ItESteO6YERa9vNg+W/l0yCwZrKPxgQfK/RXMbyE2gcF
	WkpBDGkswWpgxmv6tcIC1RQU7JhfyHeWOsujQtrE4BHvXUH6hTvxzt4Ib741fwzo=
X-Received: by 2002:a05:622a:130a:b0:509:4406:44e0 with SMTP id
 d75a77b69052e-516d444f66cmr217005491cf.27.1779734531294; Mon, 25 May 2026
 11:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522115512.1519110-1-edumazet@google.com> <CAAVpQUA=kJ-Ne0zDniRehpebv51MuBnvKcAL5DpT2ofk8Ad12A@mail.gmail.com>
 <20260525112011.38a93f49@kernel.org>
In-Reply-To: <20260525112011.38a93f49@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 May 2026 11:41:59 -0700
X-Gm-Features: AVHnY4Knp1QcMhbIZvlTHaxAhsHjRh-RyPCFmXJmDkxKYKuZ6NUti4jnq-OYOkM
Message-ID: <CANn89i+h3d=SoK4S3iUFvQ8fb=iBbBTX+yoM-Ey6ya+BnsAJTA@mail.gmail.com>
Subject: Re: [PATCH net] tunnels: do not assume transport header in iptunnel_pmtud_check_icmp()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-291419-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C6FFC5CDBCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sun, 24 May 2026 19:55:50 -0700 Kuniyuki Iwashima wrote:
> > On Fri, May 22, 2026 at 4:55=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > In some cases, iptunnel_pmtud_check_icmp() can be called while
> > > skb transport header is not set.
> > >
> > > This triggers an out-of-bound access, because
> > > (typeof(skb->transport_header))~0U is 65535.
> > >
> > > Access the icmp header based on IPv4 network header,
> > > after making sure icmp->type is present in skb linear part.
> > >
> > > Note that iptunnel_pmtud_check_icmpv6()) is fine.
> > >
> > > Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly br=
idged IP packets")
> > > Reported-by: Damiano Melotti <melotti@google.com>
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Are we okay with what sashiko is reporting?
> If it's legit it may be better to fix in one series

Maybe, but iptunnel_pmtud_check_icmpv6() is also calling
pskb_may_pull(), and always had.

Perhaps it is time for CONFIG_DEBUG_NET kernels to always reallocate
skb->head at every pskb_may_pull() call, just to expose these bugs.

I fear that a series will never be complete, sashiko will keep finding issu=
es.

I can try a V2, but will probably give up soon.


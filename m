Return-Path: <netdev+bounces-303821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A5shFrF5RWpCAwsAu9opvQ
	(envelope-from <netdev+bounces-303821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 22:33:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D1E6F17CC
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 22:33:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=XdApi4HK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303821-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303821-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 602AF3048DF7
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 20:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1832D0FC;
	Wed,  1 Jul 2026 20:33:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CAC431E68
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 20:33:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938031; cv=pass; b=a6A6Mrgg3JqzIsv3puQCI1TWyf6c0cNN3RxacmaDUJyeHeEQ42Sy1mVx9OO5NvtWbAqONRJQPYIku1zskkbwcbzdO3ZbIaJQQ8AmEwiDmyOlZJ3lsPjYzAsJm0qUqBwYQAgWehXEclI3kDl7DOVAIp+hEl/Z8XuLWzHKvslpavc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938031; c=relaxed/simple;
	bh=Up0tRfswt+77mjFqWVZX5W7neMwaKjOkcEe3Ahf+TVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RneQh+fsvkDXs8HY2zVtVQ6r1klO8axGSgBxThFO6VCW9pLPeSnT9YHhViNiDpJDtP5VceCP3Ar33K8IJ+PpiAyyuHVzp2uT3iVW+/L8O2oE1fLcN+sFehux4RO65SEFrZP8MRtFFDomeuJl3tjckA2GoaYPtaz4blFcgNqRKbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=XdApi4HK; arc=pass smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37de8008910so719849a91.0
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 13:33:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782938029; cv=none;
        d=google.com; s=arc-20260327;
        b=OGfaqnqNgMb66TqRmpHkcFLxckDZ9+tQQi6yiqfD/Hh/eqgA/0VFxxXhfmUAtCPta+
         veOO7fjzGQAkkeylgW+VmJnsTn+DqHNDs0wfWAfBXcK1wqkIXnB+xhGART/m9Jnllaa9
         Jnzlm6z3LdOEUKqkYYN8vVjYdgikLlNpzUN59+uPlKiPHgnOuJNwzUWPCvMrIqw2KPhq
         p5JhHVMBX/Z0EMwMkWWP/YXuy3FpKE1U7O2kY1Q5wqeHSJfn2imLfTrFKwpo2qkdXxls
         jOIGrXgpGR3B3PtQq5qIPV5xIiY2Q6r3r/Rawvj7SeLZFDjL2+z30TJjf/c5JROewP84
         TlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Up0tRfswt+77mjFqWVZX5W7neMwaKjOkcEe3Ahf+TVs=;
        fh=eHEX98iP+rW1fEM80zXJ1fREOI7CHyRAtdbFOu/KvEI=;
        b=elRgM27HcmobkwwD3D/prNHALf5ZC3UqhzTs02Qq3htyNkgRjlbZIaZp6Ug0SU4pRv
         MRXR/UXNqGhG/A3S48r6oWSLMASZdWCrOilcZEVWEMLjWF4MAMxQsq94oI5z170A64i2
         NYH3JHLFzopP0HVzb9B2mGFz6S8Cv7dKev9m2SIx29WrWU2plnjSaKH2hgdT++yawvDd
         rh+ePGub4ORUY8ANfHdxrCN1L0HukCCXK4pOmn36NheGBdERQx4LylWV3usNgeev/hOW
         wdiRcKNvJgjtq5VNuFiKoRM7JVcQF4IFfbpZqyP1E4LLF0vtQeDdPPmF3TbCvsg16D11
         +1Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782938029; x=1783542829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Up0tRfswt+77mjFqWVZX5W7neMwaKjOkcEe3Ahf+TVs=;
        b=XdApi4HKez9CjQJPYdQr+A/fLFMgqKRmxF/6j/pOxWpHPBiCdMgXtk6kSsCpFuDtHO
         xAREFsYmoZdr1h2MXlgBH5a7wIJrMZEpcTB28g0xzcIxAd6puuGhxc/P2sznQlfqA/d5
         2tA2thAtJUu4BTeoD5kA4vW2693L4MGdHJmhGuaVNxbrQAq3zsCwyQAy8Nk3XXnFUCwW
         Zn6cHd9phNz3GQCYHuD7YHh/sUHaXjBU6vov2Glf8Bbtx2OBolGFc//Ywr4t/9H8JbFn
         YvWUuMcjWqnoke/U9ScpQbP0oFUGpNIhueD3MD4OFadK0CK5DUbqx3pPbwJA1ufdidhY
         X2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938029; x=1783542829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Up0tRfswt+77mjFqWVZX5W7neMwaKjOkcEe3Ahf+TVs=;
        b=m8kfEFQaRwGMhZpdrSKjZuFNRsVcbssKYVFt/NE3/6AgB1Z+ZBTGIvYNIQog9nQj1W
         b5+Rz/sRqcv9kuyjoFwpJ4Za/gN9eyVEJL7RvFiSsDkWu9teoNN/qP8DG426RAR6rgA6
         CNHD4FC3KVciv777K8COmyA02UZx5QRKhM6u1sJj3VrLZUym91SAiBrhbhp6n9kIMBgk
         mS1XK0cnLSdC0NdmKfCTD33QFDoA05HEZWOgtJB9VNpErMG3QWKnZK5okXrA3mcAOmzo
         3FLqURbSbYkdZoeyZAqBg0sv1fLjoloL9FC1MTbsGrcA8S3OmjCLuWaOWBfrIvqpaMkx
         9DUg==
X-Gm-Message-State: AOJu0YwQ+vKABt7rmOytQLVs++8xEYRxUOquhvnMaGhuqyatlEtfoN6E
	NbHdMvdzuIH11clx6rarOxsL2/kMsbQP5ICdlQdq4y+uAXy79K4krE8DXyEeRSnZmC8muYdX23N
	7V4Q+WwQTiP/JhLtr8pmcQnflhU50UibOJ+5cNtEc
X-Gm-Gg: AfdE7clKfelvkIvBs0tjnGnkknNEi7GCD9h2vpYwjChqGD//r+ZJrYUPI7bgwH1kDu3
	9FUxM/tdVBd16zvJzrocObv+q80SpmG3xhGUChC4d7zCDBS27m3MG84IPGTPs7qk4obKZ5at92c
	za4VZlU60kuF4cLNFMbSocUpUHrdD9r01szFNcViW8PuiMHH3i8XcDDwt5qyy/MmNj+DkXm0EUj
	HpzfSc/SlEVBCCU++4GeSKtd2sGAzjFe/STY5QbkJg2MeyeiVC4jgZDMmLa3tYoM/Ac9mF6FBkp
	PKuIhYjlI3mgS9srIwGmmYmF4mxu
X-Received: by 2002:a17:90a:d44f:b0:37f:133a:3e07 with SMTP id
 98e67ed59e1d1-380aa0fc88cmr3135081a91.2.1782938029026; Wed, 01 Jul 2026
 13:33:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630045243.2657-1-fw@strlen.de> <20260630045243.2657-4-fw@strlen.de>
 <akShGOr3YKg1bs3r@strlen.de>
In-Reply-To: <akShGOr3YKg1bs3r@strlen.de>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 1 Jul 2026 13:33:38 -0700
X-Gm-Features: AVVi8CdAP4E5HbEEHn2Qa8InlB22fwub2VUQjNn1UnK_2DY9jxOTTw931Ja-CW4
Message-ID: <CAPpSM+Q0jAO7F_NOTsRngOkkvzFZNoULGvf9pHi8OVp9Co9+4A@mail.gmail.com>
Subject: Re: [PATCH net 3/9] netfilter: ipset: fix race between dump and
 ip_set_list resize
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	kadlec@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303821-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:kadlec@netfilter.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3D1E6F17CC

Thanks, Florian,

I'll deliver an independent patch for that issue.

Xiang

On Tue, Jun 30, 2026 at 10:09=E2=80=AFPM Florian Westphal <fw@strlen.de> wr=
ote:
>
> Florian Westphal <fw@strlen.de> wrote:
> > From: Xiang Mei <xmei5@asu.edu>
>
> Xiang, Jozsef, could you please have a look at
>
> https://sashiko.dev/#/patchset/20260630045243.2657-1-fw%40strlen.de
>
> AFAICS it's correct but should be handled in a followup patch rather
> than a v2.
>
> Thanks!


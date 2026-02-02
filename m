Return-Path: <netdev+bounces-255704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IacBAQmgGnF3QIAu9opvQ
	(envelope-from <netdev+bounces-255704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 05:20:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 33103C8252
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 05:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C72FD300107C
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 04:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516F828CF52;
	Mon,  2 Feb 2026 04:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aX9jt42l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873F287516
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 04:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770006012; cv=pass; b=alJMK4c2b6uSr5obtSveXbMYeHIoi9vL7221UlyXd11umdLLDmxpdH2H0ykiNXsxeqC6YGLu5LWjtSNKmMsyxesgC4nIPnByy2YHDEpDMtPG+N/i68ooFOCKgRF61cdQESJJxraS6cCMtFD/Tr1duZ0hn5zSYoYzJqX0jrKkto8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770006012; c=relaxed/simple;
	bh=MlC502H4mtzxv/Iv+kvgIwAd80Ce/PNP2XjJa9d1K+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcTN0O9LwyZiVXx+rc1kFK8rAGLgSIfqarMkypxLEA58ebED67RqQcNIH/OAyLJmPa05wDUz+EKSbEVRHbduC7cNweTl+ym/VFksCLHdLNnGPeaa+p+qktvyT5X0UnPd2ET0hHE22Lx/DEtwYASfoc/hATaiiG8amnCCA3bPzAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aX9jt42l; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8947ddce09fso32233736d6.3
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 20:20:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770006010; cv=none;
        d=google.com; s=arc-20240605;
        b=eObIhgu/GuYHy9HucDL5EIuT4/HuUQfdCtOi6QBBXgYrjQEa8U20CrGfEw+D9+VIrO
         YceDB3lSkDqhAMfPZIKRAEgQVWeGH7vaN6EHv4qpm4IiWv67mRnhIRToIGnKpHwOFzCF
         zEz7zRAqm0KxzAK9nbfv6BvgIwm2J5ueAhZYJ3hQx12MSjBpjInkNWfrnU7pfEDp1m1M
         aPOgtWwEAUTQaDxvEvLn3yJUYiGS/Ei0FUo6Bvr0wOO73s5o1n0w86gpT0TOVPey9BgB
         BbW7gmmYae0HqJB4w2p20DfsDFJExNiuY6wgElhmyOwngAAzmyLbUUZ2B97DsbtmkS+L
         rX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MlC502H4mtzxv/Iv+kvgIwAd80Ce/PNP2XjJa9d1K+E=;
        fh=EXvIki7nP+lPrm1n7Wo31SULqATn7ZXfe9ZXH6oXFfg=;
        b=PvT7g5dcjGhG63KLCtn7DH/vIZnONcHu409rq0Tx8eA5D0fVJ45/dXMkyN8RkFiKGO
         FUUYSYsptJ1n64hh+x3Nodpv3oBmZ/nelBCImj4LACZDuQbXlE8QnutlBNqWQwf8RdeB
         aol9CqzeOcwgEODu36x85Y883KddfNdfkEcq/Vtdu6evAtd6Qav2OdTpcRPvMwqN0oPa
         C53R4euAivQ/mxxSV9TTbngsdFc2aEMwmIEZHTfRFM5RVjvvcir+jAX4nTW+NPjufpqS
         P7cGo2hmr/p0OxUstG1B9oHQxcb8sITzMZeSAyZ7nIlfo98lbcyCrGuYzuK4gKbR/8ku
         QF7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770006010; x=1770610810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlC502H4mtzxv/Iv+kvgIwAd80Ce/PNP2XjJa9d1K+E=;
        b=aX9jt42lzTiSMb356EWVWtcDyyJQ4xs9uw8UaT4mOcP8uSPjMyPYQY+bDKNWtMvHL9
         NBZECvJWfFFVDMbToM9LSdtmdlmbBVug+ipXM+DMi+BmRJMC32Dsm/lW6AtM0t2uwZVV
         xpmgdli39LF0HDDRZIbhKZIw5grDPDDuuBBFUXyEdtDjG8ZvEP/Z1u0LT3LKp0tvKgZm
         v/XWGYiU2Avt0w95qB1iC8vmGrWz6Sjvs5GZg9iKZnnMDKWVTejtZXANnBuekX59Y2Tg
         xU+65X5euxQYbHN9i1V73IdhGWGa4Sev8zlqfNI/Eza90FXNFTX0Nv6Xbn8WQP9lF5nI
         1evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770006010; x=1770610810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MlC502H4mtzxv/Iv+kvgIwAd80Ce/PNP2XjJa9d1K+E=;
        b=cT/RPKy4SfVtpLIjEMBzooWc9kaezitSPNJQnywOkYNpCamMJ3NWcBACVMjwdeWa0V
         pRIoihdneTu3QR1HfPxNccmMZGaGG+0NLgTvQ3bk1+fLm7NNvqtIlbpVwddMSQn3pSbC
         ngg1wdNE4E/c7WwnHluJQ0QlMNTsLHSK6TCqBIjWdp5FEmKtsTDQvR3Q1+PofyFnG9f3
         OZbFyZBp0OwGZBz0xkVeiE/lm917Jpw0lZpASuTTy8DaQY3BLHRenDPDYmAuEOYeOeAl
         J687VSOryhs+TPRAadDgOiz9fpixLbxQLavfa9Tp/1yPNCZzyehN8FTJgLC44nQCSMlD
         s9LA==
X-Forwarded-Encrypted: i=1; AJvYcCV2kj1SGY77c7ntjFBPaZnJ7qzpz5En4Q1A4WsQth1AzdfafkBPV2ZPiMulKLN0Qs9f0D+ZVoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPlMsXZDJSqMgQvk4GkxzBOCAdfXVFxd87mkpSaZfzt80ytbMr
	WhDi07ogPqQHpUhfSGYRhlh8rpak0kx0B1/7oY3Dn6wcW4MIUliIeUrGpcko30EiKPA4zSX3RON
	vaSG42yNGxeqr/q8aVfc4BUOk+yg7PgnsEI5ABCleNfYQXMd6tleAYVEj
X-Gm-Gg: AZuq6aIY8ZKXGksAUUxvT2hTsLCv5JQUeNXzrxQREYJQ4JyDqyYEdAj2dvWY3uUHjaM
	QWXgH9nX9wP9gCb/q6IfnhpMyq3uLCPss6nGZsq1MK2fIWCwV+c4dpppJJhLRal2kYwRAUSQ1Gu
	5p3yoJyhu+NO8ANvokadHjDBWZMAyWAT/x1QZlRXcRrq0D48J+nsUrmQ5MFfrgRNt16cL1GWbh4
	jnVt3kRQ6AO55PgzPuq74pAioVeWAEhoXt9nvGRUZZ76hWkQRXjcYV8HDLvW6kjuF/LdF8=
X-Received: by 2002:a05:6214:1303:b0:894:2f28:54b9 with SMTP id
 6a1803df08f44-894e9f891f5mr142539646d6.27.1770006009563; Sun, 01 Feb 2026
 20:20:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131212934.2547995-1-edumazet@google.com> <j3fofrzb4c3xcckk55y7rdpc7x5m23mphkksnp7vuijimzqpml@3nzu5xyfuyer>
In-Reply-To: <j3fofrzb4c3xcckk55y7rdpc7x5m23mphkksnp7vuijimzqpml@3nzu5xyfuyer>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Feb 2026 05:19:58 +0100
X-Gm-Features: AZwV_Qhok4iJ4P9AqtKrya9WRM6ecyliUtzvLo4EixwpwlDdAHOrYBDTESqVkbU
Message-ID: <CANn89iJh67=bSTS_ziVuQUS-ht0yqeW_Q8eaFCV=8M7zuETAsw@mail.gmail.com>
Subject: Re: [PATCH net] net: add RCU protection to (struct packet_type)->dev
To: YinFengwei <fengwei_yin@linux.alibaba.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	dongchenchen2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,huawei.com];
	TAGGED_FROM(0.00)[bounces-255704-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alibaba.com:email,prot_hook.dev:url]
X-Rspamd-Queue-Id: 33103C8252
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 4:16=E2=80=AFAM YinFengwei <fengwei_yin@linux.alibab=
a.com> wrote:
>
> + Chenchen as he hit the exact same issue.
>
> Hi Eric,
>
> > Yin Fengwei reported an RCU stall in ptype_seq_show() and provided a pa=
tch.
> >
> > Real issue is that (struct packet_type)->dev needs RCU protection:
> >
> > ptype_seq_show() runs under rcu_read_lock(), and reads pt->dev
> > to get device name without any barrier.
> >
> > At the same time, concurrent writer can remove a packet_type structure
> > (which is correctly freed after an RCU grace period) _and_ clear pt->de=
v
> > without an RCU grace period.
> >
> > Fix this issue by using proper RCU on pt->dev pointer.
> Still can hit this issue with same backtrace even with this fixing patch.
>
> Look at the __dev_remove_pack(), the pt->list is protected by ptype_lock
> while prot_hook.dev is protected by bind_lock. Could it make sure the
> procfs interface see either the list element with prot_hook.dev not NULL
> or can't see the list element with NULL prot_hook.dev?
>
> Regards
> Yin, Fengwei

Please share the new stack trace (with the symbols), or the repro, thanks !


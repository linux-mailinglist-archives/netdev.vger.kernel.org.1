Return-Path: <netdev+bounces-244618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7C2CBB974
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 11:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AF5630056DB
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 10:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598F127B359;
	Sun, 14 Dec 2025 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1gH0XsH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA351155389
	for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765708176; cv=none; b=HyGOam6R29y84Oe7wemGD65Z9ak6TJ+SIAmZToNUwVxpPo98Q5lmW8rJRnbuHzJpgk5+zYYey57gOTD0Ue1hZVbX3ks/iY+uCVXGFilUn+JHZB9SQs4rDq1yD0/g8uYJ53DKQoV4XAnpk+SKB8daH3Vj6JE4FT2/gCfexNJlx4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765708176; c=relaxed/simple;
	bh=C6l1ufEOemw8wDjqnO0b4oa6vhXSfwQ33CIk4d9RKuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrArqTgQEYG/UBlhYm0m3qZOJPVTiMzccArcp4kcaoydifbu3yC0ll1Uj8fnP0KJpC+xBBnham49+uuwT/j2YAPbcMO7D9ak/AQoP8tNTfRcv6u6rWTLjAxaqyuHVVJrO6L/VoTe/nDKEPbTOw42myLfOnXM7AWhXMmhT+KejFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1gH0XsH; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6455a60c12bso1388662d50.3
        for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 02:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765708173; x=1766312973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APUZ/fpPVqueV9oc4vPO3W1N5VqnQjnZ6bozLKKB4IQ=;
        b=f1gH0XsH/iWjY9o1V4MoEFNIQ+t7ueGDT3Y/IuMeSfB9zhYtaH3/gLv0G64+pkiKlO
         mnqtwEwkJkWjibZ4q8F/8XoES3yd0UtbTwvN96e8tqlFm/FLUacPiWmXirawM0YLuCPV
         IApa1QVjc/NPnKWAQA6C2zYH3Ol3HmhbKyfLvu8MH3qQsJnByTZj676DMYnJCsxAl2U2
         oiQRKWyXpHN5ogYX0RLw8DQHa76VKkA82WgiXLT5tu7j/CDqeo0HATmblXl1OKmv9U5U
         pN5a0AwU7D4z353xTqWlA8Zd1SslePUkEYok+/fqYLYJ1UCgp+9MSRRlNT1pyxfDlnX+
         5jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765708173; x=1766312973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=APUZ/fpPVqueV9oc4vPO3W1N5VqnQjnZ6bozLKKB4IQ=;
        b=qL128NVmPcTdCsepk1Iv1ssB7yOn12a8PzkrIrEwSawSCpJoqA1iKV1g1P4uG0INw6
         f5YjJPMaPXFrA4dOUbiQhzRPPk6eQeEaVVRYuvhs0bELAB9CpHXSw8reJ4PXyZDZ832Z
         Zez1RUwOXnaORxMxtxkzk6HZKAtCvfDwANzevRFxVZxLPGWQt/9sFM+aLsh7RjQxWrPn
         jx6w9hUmwiDGsvqnXJ6FzZSMVlpoWVCg9Ycf0gh6SE9LtLwUB+kavkB8BwKS1C0/Zr37
         DnZn8mF9DxBTCBApzV9pAYdCPE2DEVt9jIHJGhOqy2F7GkhuDt/yCrg/Wt5WH9vCXrwG
         GK4g==
X-Gm-Message-State: AOJu0YzPi/K0CuTKwePsbauf6+/IDYqsDSWMCRlfC3sua1LI2qcEizm1
	+UH0Qi8waIZNCtPNbtyQBvn4Hc0ZslrQnnqHDwa+sSV/3n/xn0jbOQAuj6iSc5VUQHsIrmWHN9w
	dF0Vy3Rn+tCBXPm0PV8qIzI3+TC+/N6Y/EDLCw9g=
X-Gm-Gg: AY/fxX6Is7+Q784HPiFpiUcIjC0FXe+T85yrRc83zRlP+UA8mRoVZXqC2bX42QRE7I2
	hb+PxZ44KRULtXTQcRvNqOrMmogWnFgcm/IdBB6BExwRxWTbwBVTqZPc6YSygwDg2dpOhLf8NbB
	/cAOlrfp+RZ6eEZmR/v70IRpECBqzuSVes6gxyIH29pm/mEMVIfGXNYWrsrmcGp/29AKyFiVMqF
	JG+OYy9mw+ByY7tfBvwYV3kLfeejhB9+rrFPRY0sN/JrIgzpGvv7k4nTR8hoVPOaOWpFevzwumP
	KVAQRA==
X-Google-Smtp-Source: AGHT+IHWM0wLbnNx0jcHZQuSLepq0Mvn6Fta5xO8cU9QkuFapBBoQpQUqTNX3qWiyLQKPXX8KvCRgc2UGbSWdCbRdxg=
X-Received: by 2002:a05:690e:1206:b0:63f:9979:2f9e with SMTP id
 956f58d0204a3-645555cdb95mr6343827d50.17.1765708173577; Sun, 14 Dec 2025
 02:29:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251213121024.219353-1-mahdifrmx@gmail.com> <CANn89iJnV=ea+bP3LCF7FKVAXrvc5qHd9j9yrgv50-rFaPO0ig@mail.gmail.com>
In-Reply-To: <CANn89iJnV=ea+bP3LCF7FKVAXrvc5qHd9j9yrgv50-rFaPO0ig@mail.gmail.com>
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Date: Sun, 14 Dec 2025 13:59:22 +0330
X-Gm-Features: AQt7F2rNdfQfa8AknrZ4WxSZT2zCPtgwOMzclM-EDjxbp73eUTID5q213-LKsvQ
Message-ID: <CA+KdSGO_KoQBR0OOa7N7-5d=iRRNbfynundh53zsz-wvzOt-5g@mail.gmail.com>
Subject: Re: [PATCH net] udp: remove obsolete SNMP TODO
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 13, 2025 at 5:06=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sat, Dec 13, 2025 at 1:11=E2=80=AFPM Mahdi Faramarzpour <mahdifrmx@gma=
il.com> wrote:
> >
> > The TODO comment demands SNMP counters be increased, and that
> > is already implemented by the callers of __udp_enqueue_schedule_skb()
> > which are __udp_queue_rcv_skb() and __udpv6_queue_rcv_skb().
> >
> > That makes the TODO obsolete.
>
> This is not true.
>
> Please carefully read commit b650bf0977d3 ("udp: remove busylock and
> add per NUMA queues")
> And perhaps you will see what needs to be changed, thus the TODO .
>
> hint : to_drop can contain more than one skb.
>
> >
> > Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> > ---
> >  net/ipv4/udp.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index ffe074cb5..60d549a24 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1797,7 +1797,6 @@ int __udp_enqueue_schedule_skb(struct sock *sk, s=
truct sk_buff *skb)
> >                         skb =3D to_drop;
> >                         to_drop =3D skb->next;
> >                         skb_mark_not_on_list(skb);
> > -                       /* TODO: update SNMP values. */
> >                         sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PRO=
TO_MEM);
> >                 }
> >                 numa_drop_add(&udp_sk(sk)->drop_counters, nb);
> > --
> > 2.34.1
> >

Hi Eric, thanks for your response. Yes I read that commit and now
one thing remains: SNMP stats are per-cpu. Is it necessary that
the counter corresponding to the original cpu which put the skb in
the prod queue be increased? Or can we just do with increasing that
of the cpu which drops them?
The only place that I saw we use those counters is net/ipv4/proc.c
which calculates their sum with snmp_get_cpu_field_batch_cnt, so
their individual values does not seem to concern us at this point.
Sorry if the question sounds noobie, it's actually my first time
contributing.
If you're positive with that, I'll submit another patch.

cheers
Mahdi


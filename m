Return-Path: <netdev+bounces-236372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25440C3B2D0
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 14:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1236F18832F9
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 13:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE2C32D7F0;
	Thu,  6 Nov 2025 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bgV11jk8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EDF22422A
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435051; cv=none; b=Tl2FSbyjERLMXsY3BsxIgViWpWzlBqAw5sFQwkQKFSNPBfArbqM4b0nZtHgyVYiujTjTB67wiz5zkpV3VcLAHtyg46reh96jOKJWGFYmKO/w2j2ss2wOnhaeUSPLjSKMMV/spYa4Gc2GSH6rkcnVE+0hYxI9hSNTwxKIBYglPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435051; c=relaxed/simple;
	bh=8xyayUNeX27WinogYM/STcDgXHhgPSZqFVuRAY979CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPqCAm/u66SXANK2Z8zHJ3+x57FiFPYu0HObFc9YRGJc8q0vqW2dhL/xYFnTN0DTFvfb7uqn4VeNvtQC/GyiS+07x6kWeH/fM9ksaIEnJuESIiJxk9d0tvRhs0IsxLR11+T2faUWYGfXkcQrVZvWnSi+jLnzoiT+aiyI6vtltxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bgV11jk8; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed75832448so7517711cf.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 05:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762435049; x=1763039849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yKqqA00jwTc/irIUDNF5NewMs+/9jewFrwR1l5Pykk=;
        b=bgV11jk8QoNsIbL82roahyKlhtYwGQ3Qcrzog2usjpeA6WcdA6jXVATLPLyqHdWXng
         MYymRswIReG/mABBRLgtxA9mJUzY3au35c3b5N8gc/a+/JvXHK6Or0L8Cdlo8TB2+HRI
         2GzOQP4qirU80Vwvo9hVkdkL2YcRsqanDkikuv9z7XRBCsurV54xzIDmcfSbT3FMW2F4
         i3qP/WHPFQNrEmESWGMos6UVDEEpOkZLyp++MeHWM1EIRg+YhO2ZJd0kbWLRLJXt7wkU
         GXbFUymwBz1bFNySGLzXI64qktUf+r6fNr6dbRHSJXZWuYWNWeY6IkpEvt/Rw2nN1l5j
         VTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435049; x=1763039849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yKqqA00jwTc/irIUDNF5NewMs+/9jewFrwR1l5Pykk=;
        b=r5QYbFc1PoLCNpJFgB1ReZxX1aWvgHcIpsVtd+lTg6ugho/WxvRQ9HXHywjjCJ5Flp
         ygwNtzvaR5EEO6Gp4/vy3mlCRRk+3TCKlkL8z63/cUnma2EX3fj9qWaAwYrMY2kpBiUw
         IQCCywpSgoDnbMYLYrfTwfF3Gw0QFqBHyKEKz1Dug14JVb6EhKAldMEi/QupPhGBhZl5
         0dqJKzUPWcLE+h2LV3XEjfXO8mT8cxgzwTO3aB4Uw0bGsqhw9pxLKAs6fR7eJjnYZR3S
         VKcMj6qP0Nc2rvjhbulgWEbINC6oyAnLnLyH9fe5KsHpcq8yd9O3Di6KF8hovgYP/vx9
         svjw==
X-Forwarded-Encrypted: i=1; AJvYcCX8YUZJ204dbSaIkr7ibMXjVaU9pBEtwFiXJENVP1ts7zAbF28ffpFgohzlbLiJlh/7VgywmfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyvzI3ctkeP0KvOJLloaMLaxHejtp9X7pBUg+EWqWr0nDQtAeE
	W3A7VVIrO8yrZnDs4O465Ro5cqWLIuC63zv2xBR06VsOVXoDszETVPIONRydELZNK6t2zrc5alc
	hTPKz1FKv/mkYkgEmLgVqVAYid16ynikwLNzooxIP
X-Gm-Gg: ASbGncu2lEbdXAWxIp2K6MuN5GdFcUF5hAJ6ymMWH7zTdEuMvKscQWrCnQyuw5UfNxY
	C6qkTpaw3FkmxgOr/ixSXwoDtWG9OzWzBsYbtdOei2IkCv8CyKJLAZZ73UVSQvA5h36qNQoXbyv
	3+9xy+lUFTk/wJIBBnIqOK55+GBN5/v/AIP/gXRggOo/hJvV5RS2BtibdMH7KSD+0bqAQzxGlyh
	Rn5J8nJdiAgMZ5RDUZJaNejAri1yhxYv6kOSsEjhIG+9nfIgOTzgRCOo7P2rBPR8XpD+ADg2Wlw
	tQB6bw==
X-Google-Smtp-Source: AGHT+IHoVZY32WaUUPLhhY4TIgToxdwsHfeGByBPVatw4n/WThQoOgUxSF+0rV1ygA7KDRf83XJehc/SzmchYE2halI=
X-Received: by 2002:a05:622a:4a09:b0:4ed:5ed:2527 with SMTP id
 d75a77b69052e-4ed72330515mr88050901cf.3.1762435048365; Thu, 06 Nov 2025
 05:17:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029131235.GA3903@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20251031162611.2a981fdf@kernel.org> <82bcd959-571e-42ce-b341-cbfa19f9f86d@linux.microsoft.com>
 <20251105161754.4b9a1363@kernel.org> <bb692420-25f9-4d6e-a68b-dd83c8f4be10@linux.microsoft.com>
In-Reply-To: <bb692420-25f9-4d6e-a68b-dd83c8f4be10@linux.microsoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Nov 2025 05:17:17 -0800
X-Gm-Features: AWmQ_bkBBaZsd-rIT26BTjS7cW1vwvaDIkKAjz7m89rgLrJMPIY3CSG-aBEvnJU
Message-ID: <CANn89iJ8QKbwFfLUExJvB1SJCu7rVCw_drD3f=rOU84FNvaPZg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, pabeni@redhat.com, longli@microsoft.com, 
	kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com, 
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com, 
	dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com, 
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	gargaditya@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:01=E2=80=AFAM Aditya Garg
<gargaditya@linux.microsoft.com> wrote:
>
> On 06-11-2025 05:47, Jakub Kicinski wrote:
> > On Wed, 5 Nov 2025 22:10:23 +0530 Aditya Garg wrote:
> >>>>            if (err) {
> >>>>                    (void)skb_dequeue_tail(&txq->pending_skbs);
> >>>> +          mana_unmap_skb(skb, apc);
> >>>>                    netdev_warn(ndev, "Failed to post TX OOB: %d\n", =
err);
> >>>
> >>> You have a print right here and in the callee. This condition must
> >>> (almost) never happen in practice. It's likely fine to just drop
> >>> the packet.
> >>
> >> The logs placed in callee doesn't covers all the failure scenarios,
> >> hence I feel to have this log here with proper status. Maybe I can
> >> remove the log in the callee?
> >
> > I think my point was that since there are logs (per packet!) when the
> > condition is hit -- if it did in fact hit with any noticeable frequency
> > your users would have complained. So handling the condition gracefully
> > and returning BUSY is likely just unnecessary complexity in practice.
> >
>
> In this, we are returning tx_busy when the error reason is -ENOSPC, for
> all other errors, skb is dropped.
> Is it okay requeue only for -ENOSPC cases or should we drop the skb?

I would avoid NETDEV_TX_BUSY like the plague.
Most drivers get it wrong (including mana)
Documentation/networking/driver.rst

Please drop the packet.

>
> > The logs themselves I don't care all that much about. Sure, having two
> > lines for one error is a bit unclean.
> >
> >>> Either way -- this should be a separate patch.
> >>>
> >> Are you suggesting a separate patch altogether or two patch in the sam=
e
> >> series?
> >
> > The changes feel related enough to make them a series, but either way
> > is fine.
>
> Regards,
> Aditya
>


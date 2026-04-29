Return-Path: <netdev+bounces-282459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEMOL8ZH8mmTpQEAu9opvQ
	(envelope-from <netdev+bounces-282459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:02:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7BA498819
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1459A301A931
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F87338BF8D;
	Wed, 29 Apr 2026 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0Bsz5fe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5F38D688
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485743; cv=none; b=I0ePBLIuSMDo1qwqIe5zGJ0UZVv8frWeaocDb0IT6kNUp3e+5MYZQ2VsM/fGHs9xq90fv7I+OExLx3EQYtIPONpZeYtt61ikkPKbBCoaZVTnB7ABUY1Bqbn+yPg00eGjhayBl5yyPn4WhB3O62m8JoZXOhxauE6Epm4X/61aaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485743; c=relaxed/simple;
	bh=ZYDm6LQjx6z8qEP8enhW6C4tZcrjPsHDjbFGVaexpiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqyvofqeIp6kJ4MZ6PtSKQi5KOIPN/NFnUDBhawDourc75xb1A4C4/zaddM0Z0mDNJGu2P8sij1LhPi/qFqrJMvQYssA4Xe8rkf0CNBtrR6qU07HJh4C7V1uNNN6jyNvlVJVVNJk6D6PRsVV/HCSSoZ8QlRElgzglXkUKkv5HzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s0Bsz5fe; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a2c500750dso29541e87.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777485740; x=1778090540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxhOyUtiJJnwjvooR0tpgz13ADxv2UwdgT9k4qtUzLg=;
        b=s0Bsz5fe6dZgzzw5hk9TYVrgCyD33/5e07jskNoWgSTYXo4LQu32VKvYKCVSm4k5YZ
         Sog7syc/qZKJf2qSrcPuyrzWf6gxgC5nqBBBERKmJFaGRsmYUJ7rH4Bkx/rvyr3H+5wh
         MEaWegpsNwGW/z48eDQXmmuixAQnyq0crK/eKNUl9tHNZE+tNYuVHlH4JrQ2Mo33EFKG
         nEqmmQzUul4R4iKl2B6eMV4bT0qkn18uk4rc3eIOIhCv5bsOa9rOtRVtZuYuXsJr5ZcH
         Sglj+roz0JFuHkgSHC+dDW7B+37AM6mzlRLuwZPd7dRWHhVTEXSgvbzc6HDiGOyeqeuj
         6Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777485740; x=1778090540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OxhOyUtiJJnwjvooR0tpgz13ADxv2UwdgT9k4qtUzLg=;
        b=nbaL8eLQ54ClSHWqs7SUttncsiPqLgCGdSd/IoDsTNGZG21HKmwguCPXxrt6YvMHKt
         /6Rmcp8jmIkrXykrhW9czqLepVuU1ECS/eGE+GV5kYA9ecw4pr3zYW4rucmwbRwT3ZfK
         EsS3OgspV1VPXWB524LpUuOB+yrOjXPvH+3FGE8ZhZUuhB71a+GZZtucMz6hUZ1dlXxM
         MIekRdyJeC3BQVOENuMQ2eWv202ypxktU1ngWWOZY0qJX0A77LHK0K2iWvomMHceIga0
         B/r7qVRfNJAjDY0DOyTM90f/QbD4UGTW4Uet9Y8mBhlIRw+Opm5Dr/k5fmb5NZ9QvwL8
         cf9A==
X-Forwarded-Encrypted: i=1; AFNElJ8Q40fN4StF+GIi3JEEzTjzGOZ2j6R0XTCbkluST6kqA/VyK+V4+Aqnza0U2IwVEPkg+rcapZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyK6kFrxAWzFgv5jwBXnyDDtbh01P8BtVBGQMxeQPvSefoh5mG
	cfSFWu1nDR5etS0THjl/S3lwGxRIoNUnztw9/FQvc3II3b5txGc2iQMl
X-Gm-Gg: AeBDieuMRppGYZp2LV1f8zePFZq+fRXHqTz2EnI4PKZFtNgS2z801WGuWxbyId28oZc
	9tGLcFVryikOKgiczLxMpfXqaRkqQwPW/P9GYae0STWWVzgspaIIAc5mrKiQvQbbohBN5k3TUiG
	M7iUej0msQMPcI7FvmowHrwFDe3z3+nEaf3m0Zo66yTQAV4QrVXfGLhnItzjHrzqTdVhPWB6HYs
	sP7pHox0hlnVMXi8rzySQSXJZXGEOIQBZ7RfI+3qY/yoSjV/rYkD9TPx9ZMD99nGxkYr8nAp1in
	uWM35bT9b683yJ1asxsetY6CYtafHQeAklBozVK4YM4O5KFW9BEfBCiYvS4dMflPLoHlTQil+Uy
	E42g0hIgQR3B93O7O4Zfh7HxrvOwgSmzf6Qqk0KSt21UCtaHRYpNySlp3RFSJzjfpajNIal2pxf
	LM989ZiqUzg6SSaPE8y7lI6SRqcSJvqfpZ+Xnp9X76/QQa90QgcftxFA==
X-Received: by 2002:a05:6512:1394:b0:5a3:ecf7:71c0 with SMTP id 2adb3069b0e04-5a746409f38mr2777358e87.5.1777485739988;
        Wed, 29 Apr 2026 11:02:19 -0700 (PDT)
Received: from foxbook (bfh75.neoplus.adsl.tpnet.pl. [83.28.45.75])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a74a756c8fsm729425e87.38.2026.04.29.11.02.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Apr 2026 11:02:19 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:02:14 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>
Subject: Re: [PATCH net-next 3/4] r8152: Add irq mitigation for RTL8157/9
Message-ID: <20260429200214.3e8dee67.michal.pecio@gmail.com>
In-Reply-To: <9feb0bc1-b817-46f8-9092-e2beff30ec9d@birger-koblitz.de>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
	<20260428-rtl8159_net_next-v1-3-52d03927b46f@birger-koblitz.de>
	<06a42ba1-b714-45b1-be30-4a793752e495@lunn.ch>
	<9feb0bc1-b817-46f8-9092-e2beff30ec9d@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2A7BA498819
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282459-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:email]

On Wed, 29 Apr 2026 06:06:30 +0200, Birger Koblitz wrote:
> On 29/04/2026 3:56 am, Andrew Lunn wrote:
> > On Tue, Apr 28, 2026 at 05:47:23AM +0200, Birger Koblitz wrote:  
> >> Add interrupt mitigation code for both RTL8157 and RTL8159 that prevents
> >> USB interrupt callbacks with urb->status ESHUTDOWN being triggered. While the
> >> issue is rarely seen on the RTL8157, without the mitigation, it is
> >> common on the RTL8159:
> >> [273.561863] r8152 7-1:1.0 enx88c9b3b5xxxx: Stop submitting intr, status -108
> >>
> >> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> >> ---
> >>   drivers/net/usb/r8152.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> >> index 8255261d73148a7b4dabe0188faf07cb1f356437..08cc3c1dae0facb2400890ba4d093c97ed56d40b 100644
> >> --- a/drivers/net/usb/r8152.c
> >> +++ b/drivers/net/usb/r8152.c
> >> @@ -8444,6 +8444,12 @@ static void r8156_init(struct r8152 *tp)
> >>   	else
> >>   		r8153_u2p3en(tp, false);
> >>   
> >> +	if (tp->version >= RTL_VER_16) {
> >> +		/* Disable Interrupt Mitigation */
> >> +		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
> >> +				  BIT(0) | BIT(1) | BIT(2) | BIT(7));
> >> +	}  
> > 
> > What does interrupt mitigation do?
> > 
> > Is this a different name for interrupt coalescence, where the MAC
> > delays interrupts for a period of time so more packets are in the
> > receive ring when it does interrupt, so reducing the number of
> > interrupts, and bigger bursts of packets are processed at once?
> >   
> 
> I do not understand what the mechanism behind this is, there is no
> more documentation in the original driver. I experimented with this
> for some time and the effect that I see is that it prevents
> interrupts after shutdown.

What do you mean by "after shutdown", driver unbind? You shouldn't be
seeing URB completions then if the disconnect() method unlinks them.
And if it doesn't, completions may be using driver data after free.

Or maybe you have pending URBs while calling set_configuration() or
set_interface(), which is dodgy too but at least not asking for panic.

Other cause of ESHUTDOWN might be serious host controller failure, but
you would likely get other log noise with that, at least with xhci.

What shows up if you repro with this enabled?
echo 'module usbcore +p' >/proc/dynamic_debug/control

Regards,
Michal


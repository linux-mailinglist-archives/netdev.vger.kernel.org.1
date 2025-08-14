Return-Path: <netdev+bounces-213665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27038B26292
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 12:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B4EA253D9
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09362305E07;
	Thu, 14 Aug 2025 10:16:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B1303CBF;
	Thu, 14 Aug 2025 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166577; cv=none; b=ezxRGcEXZWL0IXknnanky8Jxb6HJTYH2LRPnn2SAU0NVCE3ZzD9EreQopGXfN2pkunK1WiUoVLt+lTOsXase1JxGYhp7Pp3BKm9H2/cnS4zWHjDjwEWqJ8eAnq/6UgdnbyeJzhw8wmA3Fli/E62qKS6hCmiAVA+VxypDRw2iL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166577; c=relaxed/simple;
	bh=42FK0BY+1s6jcXyb8t3Udhj7/VLzDaliWnV2XjeBMgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RILP3V0eJebCQjr1uO3ymgND9ubFgXhouY1gIapOU6avp2F0K4vx8ttY/P2mUvM/8XI3nCgfsAYTsDrXZevhrUKeOtm38Mre84aL7CHxB42/uskSi+czKb2V0KYQEtpcyQQy6ZcBbkhuCR9zaugfUSGHoeJyU9SVVOuoZGWAIsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb79db329so101127666b.2;
        Thu, 14 Aug 2025 03:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755166574; x=1755771374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6Z5ubfLyVZZXTdXNGBFqlTLAPufFl9Lto7OQhyz+W4=;
        b=w9tsV2esDNAugSy5bmkQeJWLG5nFVUhmU2jxnIQ1eL2orrPf6St4l1Tm0ew36BDVa2
         UTvOxx39k8fWFWkJCSAfwW/amrrByPV2dxofBvvLLv6aFIRHelvkY5jqI5nkQ0tWTnbf
         LN7NHMHoJCKsi+rx3Cry2euT2vFEylMyQfWf7R9SV6Ph1pORnXdwFmRNmAMl2atElh7p
         jwTyEvwTWXboF8VaM7qv4w0u4ANS6uuzC9o2KcA2D4VGoSfwyYAh6YJDZhOHENBN/oop
         yNivDNyjHO4Ft4ajuH2FO6KY+NbFsnZbWxaF0X9vl8J21rM/tuAyRPAZ+mAuKo7Cqytt
         4+/A==
X-Forwarded-Encrypted: i=1; AJvYcCU3Yh5sUGYzC5L8qJjNY+YwezlLnxWXPGhFMi8EfLPTbjF1wZLjw6hlS1iD5R2G0DaWyNzeKp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLEOOrnyf7vi2UGBzxurd4nov2oek2mw1sclxkSA0+cDkuwHvU
	r/L5sYoqvAAJyZXmAnkb0xVsoMcGDxAlX0RG3mOapN1WVTYoEGX0LBLv
X-Gm-Gg: ASbGnctUTAZp70lIaPFNm49VJH2pdFL6k7r3gTC7Tw8VNECWDUE2epB/VI12t5HdJMm
	U+NL3W73sqlI4MYFEfbvAufsckoBjXKTy/R4tAW2mF5Do0NCkBorxTTsQz4+o917gAKPZMepAJd
	JYbgOoDyHKvbD8w5tVj2ETWswxnruTB19z8dSPsJlje+HHBOczUsj9FQODlgb1y9+1aN9o4YGBg
	7TnTdMTuC6rC3ZRhYKWeNZSoqnuMJvZyYyQEtQ9/OUwQFToVRemdWxvMMnT/+p3BDiu1EeIfW3N
	yIMaNUCshJ0hZwhuBXYuOyiV2+2uvAngJGzYkdjaaXgG9pjMbU0YiFLKvypYStMoutrYXMsx4rD
	oYmH/+N14FGomufRg4dH1GUg6
X-Google-Smtp-Source: AGHT+IEFBcNgo2o77arxWHp0s1z24PzlB6hstzNDpW+7TPhuotEJLBhfxSzPkd2T1TWQqZpWMWEYuQ==
X-Received: by 2002:a17:906:115a:b0:af9:bdfd:c60c with SMTP id a640c23a62f3a-afcb996b21dmr182569966b.47.1755166574042;
        Thu, 14 Aug 2025 03:16:14 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23fec4sm2562607566b.121.2025.08.14.03.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:16:13 -0700 (PDT)
Date: Thu, 14 Aug 2025 03:16:11 -0700
From: Breno Leitao <leitao@debian.org>
To: Mike Galbraith <efault@gmx.de>, paulmck@kernel.org, 
	asml.silence@gmail.com, kuba@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	boqun.feng@gmail.com
Subject: Re: netconsole:  HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>

Hello Mike,

On Wed, Aug 13, 2025 at 06:14:36AM +0200, Mike Galbraith wrote:
> [  107.984942] Chain exists of:
>                  console_owner --> target_list_lock --> &fq->lock
> 
> [  107.984947]  Possible interrupt unsafe locking scenario:
> 
> [  107.984948]        CPU0                    CPU1
> [  107.984949]        ----                    ----
> [  107.984950]   lock(&fq->lock);
> [  107.984952]                                local_irq_disable();
> [  107.984952]                                lock(console_owner);
> [  107.984954]                                lock(target_list_lock);

Thanks for the report. I _think_ I understand the problem, it should be
easier to see it while thinking about a single CPU:

 1) lock(&fq->lock); 			// This is not hard irq safe log
 2) IRQ					// IRQ hits the while the lock is held
 2.1) printk() 				// WARNs and printk can in fact happen during IRQs
 2.2) netconsole subsystem 		/// target_list_lock is not important and can be ignored
 2.2) netpoll 				// net poll will call the network subsystem to send the packet
 2.3) lock(&fq->lock);			// Try to get the lock while the lock was already held
 3) Dead lock!

Given fq->lock is not IRQ safe, then this is a possible deadlock.

In fact, I would say that FQ is not the only lock that might get into
this deadlock.

Possible solutions that come to my mind:

1) make those lock (fq->lock and TX locks) IRQ safe
 * cons: This has network performance penalties, and very intrusive.

2) Making printk from IRQs deferred. Calling `printk_deferred_enter` at
   IRQs handlers ?!
 * Cons: This will add latency to printk() inside IRQs.

3) Create a deferred mechanism inside netconsole, that would buffer and
   defer the TX of the packet to outside of the IRQs.
   a) Basically on netconsole, check if it is being invoke inside an
   IRQ, then buffer the message and it it at Softirq/task context.
 * Cons: this would use extra memory for printks() inside IRQs and also
   latency (netconsole only).

Let me add some other developers who might have other opinions and help
to decide what is the best approach.

--breno


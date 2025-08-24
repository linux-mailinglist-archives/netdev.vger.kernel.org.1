Return-Path: <netdev+bounces-216308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AEAB3305D
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 16:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C878E189DBA9
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 14:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9851F4161;
	Sun, 24 Aug 2025 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="DDsGHn0h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5051B54791
	for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756045404; cv=none; b=um6wOGXWoUQ1zVQknR67KFvvb5bPkIGHN1je1chIxpt8jj2OY0YrKkaQ9a7psWQ7IIjFjRTHQQA4i9dzMybZUKDatsgxhfiWjHM8A/8aGTfMtZnbqladGzw7TuASwErU0oWBM3HDZR4mPkNLnK5CUeDDIthvUUdQPxg5JGmicGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756045404; c=relaxed/simple;
	bh=HbQDTUxdlU+JsjRT8oqHgD+pS0+PFIkKYqRZs+w2w8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aK+D/6IbKeR4a7dxNGz7I/tulBNtErsuV420S7nn/FMiH/P3svmzDIkQ8rEDkLvWBJYO6tOcqJ0unFJd6ueevcsFVin1vD3vxMtBnlqHA5ANZ6MV1dsAw7ROEaIR7m///FUst8OnAHQNxks8FKL56WJsglhuvyvMbDf8QmUmKsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=DDsGHn0h; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso20360425e9.0
        for <netdev@vger.kernel.org>; Sun, 24 Aug 2025 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756045400; x=1756650200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOuIHfjTex0fBkNdxEPBGnrXuEOZ2EKaD8EW46826LQ=;
        b=DDsGHn0h2MxSIOQaroNzN4uIqgd6F6pSmFRYVzQsXsWKi7pNnOn3dwkbCozQYIMllt
         HZJRcksfmqubQU0W48mlpAkFsyQH2vroInzLgbRV3Uux7AcAl6SB4QegIjYN+uv4+0KV
         BqNPyy1ObsNj/UYXM3RBu4XxORhbep6QVRPexKAFLL/dSlUfjlETgMtQ2s33nscYha+x
         uoVQ3A6W9HtHZCkRsXrJKBFzPuSfhObZa9VglUaXD9IUpiVX4OWptnKE45W+svLjuQw/
         lZ5tyLFHnE1Ja5OprKgLXLQeHLJQictw+ex6cz5GFFvvI55IkA0qGFjgdRW5nWOS7ZVQ
         Yd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756045400; x=1756650200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOuIHfjTex0fBkNdxEPBGnrXuEOZ2EKaD8EW46826LQ=;
        b=sb//zzvuT1zX+ivBiJ1Q3niO+m2mC2kyvgD6erP2KCWZe9TmW5ThBJhY6fyvHpLmhc
         6KOCG7h0yYQyZky4oxHaAXBMV+p3ZkUT/0StVWusrnelAsFih55N4NQCVP5ZUo+4HIz1
         nHibKay1h4tbxZ9xq0hqQRGI2j0BFgc02/sjw57oFJqHTB4xLWtbViQmSBCdjDrfft1z
         pHgXtJ4mPoOcWt/n4C1xCZfGRXEcVkyaBD4y9PDBy44tV3/PfVdkEfxXYv8y82Gic1kk
         zwqNcRERx7NpVNuX3LlaQkOUG6DyCV7lBQplK4i6VkxBQaN73qF4TXY74fM/Zw8bPwkB
         /FKA==
X-Forwarded-Encrypted: i=1; AJvYcCXSZA/h4zCZ5J8pMXWRDmuT1PQPopATZij6eJhxrfg2udFDx41UGBAcIFaotsavMP87IQSNtSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDY566YxOLI/hFcvLJkNqnKFE1yO+TRSwHRXeGfRDbjIjiKYEL
	R4DGsF+C/gWDuarRlZeckTB006O4QwyCbAnYxr4be40T4wk2Lxbiy2unWAyFP8IxxVg=
X-Gm-Gg: ASbGncvGs6fMV2E+gb4JhmYovfGVENUPaR2rdnQO1PCBcIUXLJpRuOaIJa6ux+Uf/P5
	JkEZy9BU4afM4QIV2IXeeZSGyDAS/2DIZWnmd9r8vZmek7ir4AlMr3IrPeGxc9CqWK5EAmpknCW
	orinUefHZx0AuBp/D9TdFEM0zHmQxuPDy+T004QVT3isHr278+PhRJ5f3g4SOMHYAt7maVJ3z7P
	nEROQ6WqkGXlvP3zELq6edfcais350EwrXjJI0dOD3RzsonYb6lU8OEAgrpmvAv36CJS5PTIP7s
	lgffu9HhriTihHgEAKb7T9aw8ZieHXPU4olwkEyqJYod9vYKfPcyin//dnNL9fNaAzdUh4mMI+/
	eh20ZK9zh/91Rgp1aT5zeroqfVj/IDWZqMXPIP9kAizNTb96UkhESbabvhMoa6HeSCEsnG5W1yf
	M=
X-Google-Smtp-Source: AGHT+IEPSUa+s2m+8fnU+ske8jyl8Z79aTfheJiuojVxru9/st56BKH/EacK52HG02Muzl4w3JZ6/Q==
X-Received: by 2002:a05:600c:3ba3:b0:456:24aa:958e with SMTP id 5b1f17b1804b1-45b5755a6famr44387195e9.0.1756045400295;
        Sun, 24 Aug 2025 07:23:20 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b574e607bsm71483455e9.0.2025.08.24.07.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 07:23:19 -0700 (PDT)
Date: Sun, 24 Aug 2025 07:23:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>, dsahern@gmail.com,
 netdev@vger.kernel.org, haiyangz@microsoft.com,
 shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
 dipayanroy@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v3] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Message-ID: <20250824072314.01f35db8@hermes.local>
In-Reply-To: <20250824134017.GA2917@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1754895902-8790-1-git-send-email-ernis@linux.microsoft.com>
	<20250816155510.03a99223@hermes.local>
	<20250818083612.68a3c137@kernel.org>
	<20250821110607.GC7364@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20250821071259.07059b0f@kernel.org>
	<20250824134017.GA2917@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Aug 2025 06:40:17 -0700
Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:

> On Thu, Aug 21, 2025 at 07:12:59AM -0700, Jakub Kicinski wrote:
> > On Thu, 21 Aug 2025 04:06:07 -0700 Erni Sri Satya Vennela wrote:  
> > > > Somewhat related -- what's your take on integrating / vendoring in YNL?
> > > > mnl doesn't provide any extack support..    
> > > 
> > > I have done some tests and found that if we install pkg-config and
> > > libmnl packages beforehand. The extack error messages from the kernel
> > > are being printed to the stdout.  
> > 
> > Sorry, I wasn't very precise, it supports printing the string messages.
> > But nothing that requires actually understanding the message.
> > No bad attribute errors, no missing attribute errors, no policy errors.  
> 
> Are you referring to the following error logs from the ynl tool?
> 
> $./tools/net/ynl/pyynl/cli.py
>  --spec Documentation/netlink/specs/net_shaper.yaml
>  --do set 
>  --json '{"ifindex":'3',
> 	  "handle":{"scope": "netdev", "id":'1' },
> 	  "bw-max": 200001000 }'
> 
> Netlink error: Invalid argument
> nl_len = 92 (76) nl_flags = 0x300 nl_type = 2
>         error: -22
>         extack: {'msg': 'mana: Please use multiples of 100Mbps for
> bandwidth'}
> 
> If yes, would it be reasonable to add support in iproute2 itself for
> displaying such error logs?

other parts of iproute2 already use libmnl to display extack messages.


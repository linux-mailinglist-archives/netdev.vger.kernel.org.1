Return-Path: <netdev+bounces-156419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A55ADA0654D
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 20:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4763A15FC
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3266F1F03C3;
	Wed,  8 Jan 2025 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="rZrPUDFH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11D12B94
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364317; cv=none; b=tFdPfDQG+0PsF42pNJhH4LoFGV8QXfPAqXMhSCgbMdkwGYEOGpaqLWT52hV/JxiO6zLIBPG8L0O9NGrZrNCU5M9XFN3NF9pEoO3LtWI3Ml0cBIuSiFAAuH6tNSJfdju0wTGjDXByGSZNEZv0qXV57b6AfojCcAlqJ0eBpddc1Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364317; c=relaxed/simple;
	bh=wpcXe7Zr+r8+UwJbPV/iybseP436/a6biQGlCPIGXYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocxShom4ATM1HPeiJMnTO+M8gHpWiBVy3ujUS2LwMxnSTugEwr0422HJmWx3BI+hZ6jsSEnqWKJWIiTDlTlqIMRCB4gJOXdU7axj7IQfLX9+Bbew7f/rVdO/jZAXgLzTa67G2lMZt/n69JdlNPSHe+BwVoTxGA57Qp9IugtuVys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=rZrPUDFH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216728b1836so1483115ad.0
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 11:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736364314; x=1736969114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MmmpI9O7APIVZntoa+OtAGDGd0MotSY9b2lam7QhOqI=;
        b=rZrPUDFHiXE+kM9cot3/cC4z6b8JTXLz260hBrsknSPWt5G5Snw9FyGvZJV4STmqdC
         3jt7AliqIps5re2t2ff3Vqwxt4CB1iKVt58vmMF2L3eKIuVp0k3nZ4EXMVDIxLrLMgCD
         F6jYeO4stnzEJ15V85TyRqTHkEQ09goPvXxLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736364314; x=1736969114;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmmpI9O7APIVZntoa+OtAGDGd0MotSY9b2lam7QhOqI=;
        b=bQnvSD1EyzBv/7sW80VFfTbKM5d3Eqa7ZjTPo2tizC6Q9DjfOkKeDbCYPZiXTEkIdv
         0xy6mqi+mKxIxu5G/O32oKG4OaVst8D4lOPFZqwtzC/RjJZhSEgFKEp+hws3iOfAMui7
         Na7AmtEyca0ygAdNqerqBpZ3q/B0XuR/oSnGKKsZn8vIU+dFiwrittWjZ6eznxiP/nKq
         RkNB9EPMElHigND7edqrSqtraE9rFLNdjufY4qLOK2wZRI6NTKC2sajJX0zCnSJzKMbw
         ZAUoW1LMP2jp6JugV9PF9itqwV/KlkAsv8H1IF67j9NHEZ4eTSyqG9KdRgpreRPczsFB
         4PvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGKvIb3nZg4mjxCT6t7cmzD4YS3Cb1RSS8k36MC66rRBYas9GkAvohaqzpHTgGGku7trg6MSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YygFocrUjiO69Q2/zpIWlvuY7YgyuDyd3IYdOoLZbI0dBAfNWbH
	xGR+Z/w4vIFoJxL3hSYSkBfBas2+NiBLNbhEWdMm7Bw2GYvOgFDpN8pArvKOUwk=
X-Gm-Gg: ASbGncti8Ci1ZOJnh+faLMZdAtEfLffREMwwbmRDHcU6WQtW8ijwFL//g7bReqc1A92
	ppAWX1s93nBP9AIv/4JTDoeiuRns+78f3XS0GrpX5Njpw3lo35yzG4G1FUgkTu2ZeNzAcb6GIWQ
	ybPCQmDt0W2y/Kl9uCqeWiwfaPfVxpSElSDmB003G3L/3XmlCLIDuZstRBDgn6JVGqaaGQ+WXyf
	nJ8A0QeXPX2JR1KY/8bPV0bh0IKddkkSoC8BFIcbtSacO+MuIhDElV6VkCurhFNolCCdiLeBqQ5
	/qiNiwNJ4tsFAagplR9KVnY=
X-Google-Smtp-Source: AGHT+IFDi7aFQhaap4f98ZR83rOfMEcShTnfdo7sIK9QzpWMBp1KyBtuE3iSUG38wrH0fqFAZoaYDg==
X-Received: by 2002:a05:6a20:2594:b0:1db:f68a:d943 with SMTP id adf61e73a8af0-1e88cfa87e5mr6892660637.17.1736364313827;
        Wed, 08 Jan 2025 11:25:13 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b821da83sm32833944a12.40.2025.01.08.11.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:25:13 -0800 (PST)
Date: Wed, 8 Jan 2025 11:25:10 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, mkarsten@uwaterloo.ca
Subject: Re: [PATCH net-next 0/3] Add support to do threaded napi busy poll
Message-ID: <Z37RFvD03cctrtTO@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, mkarsten@uwaterloo.ca
References: <20250102191227.2084046-1-skhawaja@google.com>
 <20250102164714.0d849aaf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102164714.0d849aaf@kernel.org>

On Thu, Jan 02, 2025 at 04:47:14PM -0800, Jakub Kicinski wrote:
> On Thu,  2 Jan 2025 19:12:24 +0000 Samiullah Khawaja wrote:
> > Extend the already existing support of threaded napi poll to do continuous
> > busypolling.
> > 
> > This is used for doing continuous polling of napi to fetch descriptors from
> > backing RX/TX queues for low latency applications. Allow enabling of threaded
> > busypoll using netlink so this can be enabled on a set of dedicated napis for
> > low latency applications.
> 
> This is lacking clear justification and experimental results
> vs doing the same thing from user space.

Apologies for chiming in late here as I was out of the office, but I
agree with Jakub and Stanislav:

- This lacks clear justification and data to compare packet delivery
  mechanisms. IMHO, at a minimum a real world application should be
  benchmarked and various packet delivery mechanisms (including this
  one) should be compared side-by-side. You don't need to do exactly
  what Martin and I did [1], but I'd offer that as a possible
  suggestion for how you might proceed if you need some suggestions.

- This should include a test of some sort; perhaps expanding the test
  I added (as Stanislav suggested) would be a good start?

- IMHO, this change should also include updated kernel documentation
  to clearly explain how, when, and why a user might use this and
  what tradeoffs a user can expect. The commit message is, IMHO, far
  too vague.

  Including example code snippets or ynl invocations etc in the
  kernel documentation would be very helpful.

> I'd also appreciate if Google could share the experience and results
> of using basic threaded NAPI _in production_.

+1; this data would be very insightful.

[1]: https://lore.kernel.org/netdev/20241109050245.191288-1-jdamato@fastly.com/


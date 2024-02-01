Return-Path: <netdev+bounces-68028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE8D845A9B
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD1D1C2374B
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17D45D473;
	Thu,  1 Feb 2024 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg0Dm5nU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3932953360
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798989; cv=none; b=N7s2z0xwTXi3cMv3CO49IxrX5btRiC6HTrsT9K/YsJPCv9RTs27LlbLFsmVe3nruk4Z9C5hGf+eIO7X5F4UAR8M7s5YqiQFpGKjv3n6L8fnnlAqyF8AF8dgs1y0mSip78zUafUS1hX7MpNnZtO0GNwrhiNJOt/F4JNTDCHeET6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798989; c=relaxed/simple;
	bh=BYSG2sJZlvcj0G/nKltGEpoeonQAGGKrdAHxKjh85eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfcn1vMtdeoLI4aUK0eFiIM54hFI+/d2QyROxTVDZzwMKl65GKdav88qUaR5LVvhpfXGN/t+MD78h+MmUWAtL6g5lEKyzbHQX96rdnE01FvN+XTpx6CSi8P8c6WEm3ml9YUPsTGZk0XMpYV5HePL3pEkUtfUJtJkRTaAK8prYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg0Dm5nU; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bc23738beaso126694b6e.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 06:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706798987; x=1707403787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GePObV89NOcmUaK5iNBDX3evEM3QdxMdGC4OCZJcCxk=;
        b=dg0Dm5nU/a7AqnS9C17dvQ7hw945YJGQmBVaYEh+WYZaFCDbhVQsB4r8dRAKyQhmzo
         Pa17J/xSn7a+mbagGRWODUT6+eBHnUp0b+XcG+YjO9PwW8g1GbLPDsgrWIH04ZZxXvqC
         7UQrYp4kcSN0qE5MGm2SXgCX2mGw24qwoKuSw/CzEaOVwLubiQo0ykXOOX/SfUBVtq8z
         zd4PCzhf/RxIOCvFT9peD2hg31B/nM+Rq9yCraKjFOogHMcI9t5BEmbn444NR4NpoFXr
         xaTgE7uY7BSJudMbGuCnprDhahWgc5qATe7Tf6srM+HgulGstkOw0yRcI3zbR/iR1aS5
         qQFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706798987; x=1707403787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GePObV89NOcmUaK5iNBDX3evEM3QdxMdGC4OCZJcCxk=;
        b=FklHkYE7GyBqCXrZsyHgKGC5IWfqdBh/KrrUFfpIdwwvM713BFVdlaSeP1TJz+4nSG
         pHGoEKZIfpnWtI6wjNin0ve4/DFXaTPYFzfQTLaaw+l2W3t/4EOwQZIvkE0I/NUCObzE
         0ZY7rGBptplKB4vg+agLsdJXRfntf9fbNvbJH4WrFm7qbkHTaem6xqtf96X8Rz2uRDoR
         7QfdXNh1vW4tFRr/jqlpMrmMQC12PuyTWMym4fwRrxtxWOB2nuRiRKMKAFy5DCVTYjUd
         li3PWuL8oT/BIQr1VzQqkyk9dg+0iWIIRD7vzEbnJuRPdbaShtq0dVfY+G5GMrZOij8n
         5RRg==
X-Forwarded-Encrypted: i=0; AJvYcCWT3upw83DHxvJqq6Bs8NSY0J4TUrPTfz8azmkYS1YGJO1SEj//ucdb3cqYcpwr4HEoTtSQk14MIoEFi1s6eV9IprKk8ckP
X-Gm-Message-State: AOJu0YzPiQBpe+5qeUMEXqFDyV+ZEZgc1gZJz+26BV6xKAWV3R3794+Y
	0/bXX226+PIcEZjIRkc720KCk1HgWRqNtd/rKwStn1hQPLUPF8U3
X-Google-Smtp-Source: AGHT+IHo5jk5H08asfPHWj9WSMBxGwUV7qBfWedOXCVDUa0mMI7nZ2qZ7OjM6L+83fs4GhsIFe+YoQ==
X-Received: by 2002:a05:6870:4694:b0:204:5ad3:e6ec with SMTP id a20-20020a056870469400b002045ad3e6ecmr2683476oap.4.1706798987123;
        Thu, 01 Feb 2024 06:49:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUVm+c6CtBjTrPUVmf+oALXy6JEDyyG6EaWVMdWnGlhkaFRmQ9t5SmiwmMthXibg70GDd44nWLNHlalRrmtkPGKmUYAxCRLEMJWbchBuitYlfnmV1JJoYGODu+0DrQL1ro3U4Ue3HznKf/iadoKR+7QRqx/NfSsNHhep2stQx60H2RMJ7oW3ihtihABjlpvZdKTzXI=
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id n1-20020a056870a44100b002185412083bsm2970365oal.0.2024.02.01.06.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:49:46 -0800 (PST)
Date: Thu, 1 Feb 2024 06:49:44 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: "Bernstein, Amit" <amitbern@amazon.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Arinzon, David" <darinzon@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>
Subject: Re: Add PHC support with error bound value for ENA driver
Message-ID: <ZbuviFaciTADMkMk@hoboy.vegasvil.org>
References: <8803342f01f54ca38296cedafea10bde@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8803342f01f54ca38296cedafea10bde@amazon.com>

On Thu, Feb 01, 2024 at 07:24:51AM +0000, Bernstein, Amit wrote:

> In one of the upcoming releases, we're planning to add PHC support
> to the ENA driver (/drivers/net/ethernet/amazon/ena/) To provide the
> best experience for service customers, the ENA driver will expose an
> error_bound parameter (expressed in nanoseconds), which will
> represent the maximal clock error on each given PHC timestamp.

> As our device sends each PHC timestamp with an error_bound value
> together, gettimex64 is the reasonable option for us and our
> recommended solution.  We would like to ask for your recommendation.

Sounds like gettimex64 won't help you.

You will need to extend the socket time stamping API.  That is how
time stamps are delivered to user space.

HTH,
Richard


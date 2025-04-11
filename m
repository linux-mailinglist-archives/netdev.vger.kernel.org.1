Return-Path: <netdev+bounces-181839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F03A868EB
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 00:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79DEC4C2243
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE0E29DB97;
	Fri, 11 Apr 2025 22:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8/5oaNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965EA298CB8;
	Fri, 11 Apr 2025 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744411332; cv=none; b=GA1J+GwV//ikGfxZf5TFJRhlo9DBZn9psBst9WGVQkKmMq4Y8xHDnXcWaE3sTVBbPe3jQjVgn2fL5mxBLCk4soeI65JEeSY0aarxBPD/eN1aV8Tp0Odtp4zPbv7pyh+7dAVf3QB8kPYmwam69/btivz69JEVAkPFM78QDi08m1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744411332; c=relaxed/simple;
	bh=FdmqUISjZIZYic0y2KPJOx0P3SF4CBgysTj/yfKiVqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cjv0SUyIKyuhiTZO4uclICAc0VTk/BxifnQLL8dJCTSM0aecZRVXpTZ9CZoiCKReZh3TKHQkGfF112G7Bh0F09IGXtWvOjFu8ENu7vkVqWZ9LkYcTR6PIt50gQg53r4pG82x233yRPXhsXASImiJO56nj0awrwhyVig914TI1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8/5oaNi; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so23316621fa.1;
        Fri, 11 Apr 2025 15:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744411328; x=1745016128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfMPFZIkxa9RCg5uonUpCWP0daSFj+rwBDcLLo/EAvE=;
        b=h8/5oaNiemUloyZTdwfjutWHxRM3GLW34JoC445Blj91HNnDvk7uorBVcv+N6X/vqk
         k4oGrLbawF+dAIR5z6sW/QnIRXPm9V6hQp0cELQuKsjcbAqrjj5h288OJJc+6YZ+RRnP
         4v/GMhlXWkNtKMgaTyGav2AgvvhlGbtImvTWBKsX2vLHmeIAFv+GFD8YJPdfAJqnUU0N
         tmMnUWTOxjuali1LZ88nUBzDklPpQAUlNaB0X0OVJWkoruGFByPCK3kpPm/HzKRjelEv
         pZa8KnWlxiQGxYKEFA9RVNrvhcv03XYdS/9rXTwoJLA/ViLFSjRLE0lqQkiP547c/SXb
         OQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744411328; x=1745016128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfMPFZIkxa9RCg5uonUpCWP0daSFj+rwBDcLLo/EAvE=;
        b=fR5cDotjuKLWtlyv8A1EhF963qdPGFQw1yraY/PxAtt9fa5tPVzgcoo2ybmvOQdsq9
         PwPSrTBezAEtjZgtldeXZFYm+JypZlf2ttmuZEJWpjAL6aQhF0qaO7w+2ca5vLpRMT9w
         1YA5unSBn9P8zYCgy3fPRsX98Ovgq1t1UnP8qs6DRHixfdYiTIMfInnFftusaoUxuZD7
         kefjUuCCVZF36e2oVWh5yE3UU2aYSNYEaeVkD65SHXKcR8eiz2R4N7aRVudfAc2IHdLu
         hbsptGljBtJqjzq+Rc6TD6OXh/r1AKhlPgRZrzMrjBeTGAH7X9FYsvZW/YZhYGjiftgW
         njqw==
X-Forwarded-Encrypted: i=1; AJvYcCUl9xqe/3BanFHV79/v7hD9tg8a3iDHn9MTcUoK1aKETCyn9mBijl6bi2RSB9ZHvsipQXWwGZnX@vger.kernel.org, AJvYcCX0H+KdYm/ZFXeYIGPOVyzckMXAN6JzaqhMrZZ64NECSvOtdqwOomr7YquQzklYbQ975+1VvHaspNzi0/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYanBwdXmcQXpgBndzP9KMfZ2G34I+IPmoM143trVgsA0vrPxw
	SiM3lccP0NCvOwvKGKQFBG0jrC/YCpcrHPpTdI0mYrGagYkBi35T
X-Gm-Gg: ASbGnctxG3qWu2eQAojgCMBRIXScrZNH/3OPjwrtYaeUV0ghRnsN55VkBUpldkycend
	9bkxOOBlqDtdtcslqSW4UOM5rNUqfH5TLTuwp3OoNQDgiNNjd2YKALx1FKkI9M33VaTmAJzR5xe
	CdCYjQgrjhsOuueLRaa5gEGvICFkYAl8mGPIoF9RieJuGA7AmRtRLktsoG+Vzkp04CnByb0x44l
	BkztZhOYpDsKLEQUCELfNdF2opR4CAblTdD5yK2wSvvAY2mEO8Cj1IqA+439afodI9G9lzngwgY
	Tvie/SuoYnex9VnFmqHGp6YiuxpXVmPw1IOpsuOYltLZQvTAvR+vtAt5uRq3yQK+Lfmt
X-Google-Smtp-Source: AGHT+IHXaq0sN8vDq6Hffwl9NXo/fpZhZOHJ9IKz9rM+MPatzUdCqfXnSbOzG6KtZ8jFnj3rt45NZg==
X-Received: by 2002:a2e:be88:0:b0:30b:fe19:b07a with SMTP id 38308e7fff4ca-31049a8085dmr15182781fa.25.1744411328302;
        Fri, 11 Apr 2025 15:42:08 -0700 (PDT)
Received: from foxbook (adtq195.neoplus.adsl.tpnet.pl. [79.185.228.195])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f464cbbb0sm9044391fa.30.2025.04.11.15.42.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 11 Apr 2025 15:42:07 -0700 (PDT)
Date: Sat, 12 Apr 2025 00:42:03 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-usb@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH v3 net-next] rndis_host: Flag RNDIS modems as WWAN
 devices
Message-ID: <20250412004203.099e482a@foxbook>
In-Reply-To: <20250325095842.1567999-1-lkundrak@v3.sk>
References: <20250325095842.1567999-1-lkundrak@v3.sk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 10:58:41 +0100, Lubomir Rintel wrote:
> Set FLAG_WWAN instead of FLAG_ETHERNET for RNDIS interfaces on Mobile
> Broadband Modems, as opposed to regular Ethernet adapters.
> 
> Otherwise NetworkManager gets confused, misjudges the device type,
> and wouldn't know it should connect a modem to get the device to work.
> What would be the result depends on ModemManager version -- older
> ModemManager would end up disconnecting a device after an unsuccessful
> probe attempt (if it connected without needing to unlock a SIM), while
> a newer one might spawn a separate PPP connection over a tty interface
> instead, resulting in a general confusion and no end of chaos.
> 
> The only way to get this work reliably is to fix the device type
> and have good enough version ModemManager (or equivalent).
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Fixes: 63ba395cd7a5 ("rndis_host: support Novatel Verizon USB730L")

Hi,

This patch appears to have caused a regression for some users,
who opened a bug against the USB subsystem here:

https://bugzilla.kernel.org/show_bug.cgi?id=220002

Regards,
Michal


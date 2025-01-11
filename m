Return-Path: <netdev+bounces-157440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF9EA0A505
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 18:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C31518809C7
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 17:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C8F1AB6D4;
	Sat, 11 Jan 2025 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBcyP61B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643441FC8
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736615747; cv=none; b=MYyePnZCEpQcNwdRkjRhXN0CTihTOWGxwd8lw3StaFtywEj6hpoCSnKKJXK6ac/+kLwZ85rbgdllG4zvIGBWDmOexCf5TcA2rxVwi5xtaYbv7H/FHBAYyqeQ+zM3RJT94UiMAwIAfzv77XzS9AZcCE+5Xg/TGdIKmZZ92pjHLxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736615747; c=relaxed/simple;
	bh=Z7gZbOkVNzYqyhcJ1tPOttxErH6nckoFRirthKL1B8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZODDs9y3VWvtBj8/zJIyf08vJAzKvNI0x0U6yvduMVLE/Nvz3ehEDM0EGeky1RLClnluRZcxo6C6huRMIIhLaQm9Fxk4n8/oJmDnTjibk/R6TI8B0KztX3tvKWn6Kfnmd3SuGR6x4YrAn0hGmKppXvCJqIYSXE2h5s0vKhL/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBcyP61B; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21634338cfdso24824555ad.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736615745; x=1737220545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gdJKMHnE9zGPspMBxK/9Q1Jq3I0zrrkYL+qIlSHwkjk=;
        b=kBcyP61BvpJggFvhPFGoN7vsn0OF8bf4HPtW4GNIQuJS6CY+zByVLtuEDs61fAT0/c
         A3nLpOk8MHzTWdV2BrHE2SMxkoYWkRIjH2qg2QaBmmdyVoQDdUqeR2yS463BUKILrE8v
         5XgoR3xQESFaGSoXprqRWciL/QH9Dk8oI8v58sexZHvE0WgUgSv7QteUfOSWQmGZr/gR
         vot+Kogw9cABfRwslGryfulwWe9N9UZdSwtWkks8jQxt+BlZ48PrbeiT50TFAHm8L2SG
         GFngI0c4wLcp4oCblYmX1MKsqlQPbFm3iPB9bRCmv8O8edIRYueoKYKo3bJqeiJg7WOb
         caFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736615745; x=1737220545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdJKMHnE9zGPspMBxK/9Q1Jq3I0zrrkYL+qIlSHwkjk=;
        b=dnFN/yemhHkrbjoK2w86MmZN/zD6zcVdWgVRVlz2pNXOwjIu73nlypQdsltpJEUoBm
         rbKbmIWLe9oYU8C1Yb2b1bV9fL4OgMJIoWKCL20Vq5qFxnKUQTgY0vHrvNzS+ftrfTWn
         gedpuu4mNpVEFekZdKrr3gWdZJbXfUIUSXhfwBVhmycZF81NRS0UMbg1WKNqpnJ/ArPH
         c+qlIt6QFyQlLcdpFiRKPqYQZ96n12aSENFyIXGJGOKNuMeFj6rSDET2SVFHbnMPBTGu
         sLhSUSaq8WWSIYZqmcbv9vqWbTgg5iR+lc0vNC4wG34v3SALthajPHDoIxT+KYC/1+Ag
         0mLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUovthLO4UAZ9MzFf1Z2MkkfWXyzb5rbD0dmPvOx14sKpsr7Whn5WFikVLv8oJPCGLulEDHK6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaBrCpMPR/nidW7XCh2J+Hj+6+P1b1DS2ArVsRWowjmM0BtoyD
	e7IH8DyEX4MMbkBificwyWK0p7ujf1Ot4MxbzLgcxtiE9mym3Han
X-Gm-Gg: ASbGnctV+y2U7w9qS9BE28Bo+svS/zR4Ss/NWkRdQB8IUq1CUFwzS4ZqsXQA4kh81Br
	u9zofMTUpw9Hmwk7u27LteD8oyv5+b4UQpMr27OcYC1rlJuiFwDpKh3j+4EWdh5HYApFjVSBgaI
	b1uipBHNxjmaUTko7ucFsftz6mMOXcaFuicLn+xbMHGE8aQS+90lLydQ/zvZEy4EFonnrmjTuWl
	Qfh/kAFukckr+JRumroYarQY8piCxUyIB5hnK0IZBa7JcTwKvD/HQN5YycPemvMH46+FsaSHGBU
X-Google-Smtp-Source: AGHT+IFhvCnEyNH3MTNIAqoYLczK55T+7mmhQQG6YOEJHvs4mN3lOh+1hkX4NaFQxk/aVL0/07NZnw==
X-Received: by 2002:a17:902:cf09:b0:215:97c5:52b4 with SMTP id d9443c01a7336-21a83fc3b18mr220583075ad.39.1736615745546;
        Sat, 11 Jan 2025 09:15:45 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f252518sm28980855ad.214.2025.01.11.09.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 09:15:45 -0800 (PST)
Date: Sat, 11 Jan 2025 09:15:42 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 4/4] net: ngbe: Add support for 1PPS and TOD
Message-ID: <Z4KnPlCtlhHjFI6z@hoboy.vegasvil.org>
References: <20250110031716.2120642-1-jiawenwu@trustnetic.com>
 <20250110031716.2120642-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110031716.2120642-5-jiawenwu@trustnetic.com>

On Fri, Jan 10, 2025 at 11:17:16AM +0800, Jiawen Wu wrote:

When I quickly scan the logic here...

> +	/* Figure out how far past the next second we are */
> +	div_u64_rem(ns, WX_NS_PER_SEC, &rem);
> +
> +	/* Figure out how many nanoseconds to add to round the clock edge up
> +	 * to the next full second
> +	 */
> +	rem = (WX_NS_PER_SEC - rem);
> +
> +	/* Adjust the clock edge to align with the next full second. */
> +	wx->pps_edge_start += div_u64(((u64)rem << cc->shift), cc->mult);
> +	trgttiml0 = (u32)wx->pps_edge_start;
> +	trgttimh0 = (u32)(wx->pps_edge_start >> 32);
> +
> +	wx_set_pps(wx, wx->pps_enabled, ns + rem, wx->pps_edge_start);
> +
> +	rem += wx->pps_width;
> +	wx->pps_edge_end += div_u64(((u64)rem << cc->shift), cc->mult);
> +	trgttiml1 = (u32)wx->pps_edge_end;
> +	trgttimh1 = (u32)(wx->pps_edge_end >> 32);
> +
> +	wr32ptp(wx, WX_TSC_1588_TRGT_L(0), trgttiml0);
> +	wr32ptp(wx, WX_TSC_1588_TRGT_H(0), trgttimh0);
> +	wr32ptp(wx, WX_TSC_1588_TRGT_L(1), trgttiml1);
> +	wr32ptp(wx, WX_TSC_1588_TRGT_H(1), trgttimh1);
> +	wr32ptp(wx, WX_TSC_1588_SDP(0), tssdp);
> +	wr32ptp(wx, WX_TSC_1588_SDP(1), tssdp1);
> +	wr32ptp(wx, WX_TSC_1588_AUX_CTL, tsauxc);
> +	wr32ptp(wx, WX_TSC_1588_INT_EN, WX_TSC_1588_INT_EN_TT1);
> +	WX_WRITE_FLUSH(wx);
> +
> +	rem = WX_NS_PER_SEC;
> +	/* Adjust the clock edge to align with the next full second. */
> +	wx->sec_to_cc = div_u64(((u64)rem << cc->shift), cc->mult);

... that appears to be hard coding a period of one second?

> +	wx->pps_width = rq->perout.period.nsec;
> +	wx->ptp_setup_sdp(wx);

And this ^^^ is taking the dialed period and turning into the duty
cycle?

Thanks,
Richard


Return-Path: <netdev+bounces-104085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9922090B1C5
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBD31C20404
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A55F1AB8E0;
	Mon, 17 Jun 2024 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RSuya5hQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2CC1AB526
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631388; cv=none; b=VXVCI69/rWWdkWvLrBqx2r4Yw2kgdcW0M2ZT/4O8w/+9HT8ZyFUb+OjD3Cp4tKalPEkPl9957KXr3uRAU+74cdG67F7airZKUNYQ+wV/OTkMcSdZB4OumJKAsjkxuB8m5b3Ym/c9ElR29hOI/7JbGVGY+z2J9hIhL1utFpcz93o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631388; c=relaxed/simple;
	bh=fkadhAyonb7RymKr0Hwj9qGiWcoaWFoudlddldfbojY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlexTxEqe5ZWsB9Co8efKjhLDjEW5pZJbEJ/y5MVKo5F60nOVflYoygVrHKdoRCOZWmcle4g9cAmrUieJK4GwhQyFemEzBgN6uQ0T/y38fsRhUpj7uL1lFbRequq+yq7ecUKoPNRvvPaQ3GC8JAjg0CVoqyP0stupfxGl83w7fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RSuya5hQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4217136a74dso36220805e9.2
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 06:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718631385; x=1719236185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+FTQb5W5/GJ/Nb4LvauMZmPKUHXtT9dcXAWj/SvSDY=;
        b=RSuya5hQGrSTTwFtuBl6/rYKn0k7rEetc7C6wa05py67lGIzR/fbqmVDhimOcIRaBG
         7RwakKGjGsMaKVOboJFC1+LESpkzRkTnjQwfH378O35qHiWOTFjjAOKkNUFyIFD51xuq
         PvKe5njleoOP0wDETKSDt+r+pkI3CowbJKFegbDGnnyu16ZcPs4UUvMLcdQCj/x3u1S3
         koGIWbpIAQd8CT0x2B7O470E4HLeXjA7XaQ97LZaW7rxx2WIEerzzYf8iSMqFO+c0mkJ
         1wdWiaJTV1Yj/gG26UtsjDtglxY0mWaAw95ta7iRSb5y1xj9/dNB+61jVBGJmhgDlTP5
         0P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718631385; x=1719236185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+FTQb5W5/GJ/Nb4LvauMZmPKUHXtT9dcXAWj/SvSDY=;
        b=XekirrW2OJXA2+JQMvGK4qbhjGNr9lw5UUC8x/EzyuGJjLxAWtMH/h1aM3zDJurc9B
         xMt/2DfNY+QCr9+xnONcMTsmf2Q7ymhFdn/DPZ3ncktwD/1/uDgHFjBbmnk6aF9fB8gK
         AhyJ+ah24HFShJfO87X6vnNPLnQ5pePupHYdtPgdhKZN1/LrHeMROd+aILr0UZJsigDU
         VCQfEX23HgoaDhG7OSEHxT67lhoQnZ92Rge0uRzU6eMz/kIktjnUB+pz0a1XQLamb2hY
         AJp5XOloKMWbJQFYBzImrfrwCrjedVDT7/iI3THg1kCBC6pVzjIn7FutGq0sO4D/B8Xz
         ycdw==
X-Forwarded-Encrypted: i=1; AJvYcCU5/1URaHKjp2rbhzGoLxEIUoTQwVQrka2mobadeVBE+Z9rkzf0cszfZfEFlOd2aURJ6wDFIjXtpr8OV8uW+PmO/xw1Xe4i
X-Gm-Message-State: AOJu0Yw5PSbFPv5xy6thOz5F5ocdHrNmTxEr+YlgdBeUzjEMO8Q8QBZx
	aMrcx1xPIUkeIhKjzrmz6XEZ7THM5i7utvFvyBr0iYiyeLQYx+j/eymW9Q4ftTM=
X-Google-Smtp-Source: AGHT+IHgsgd/TPVM+18WkZs2+AeqnSk2SRZRbmmdW0ObBeSJuDLzDBQ2FjqSWprz5A6LjcnamvKJ7w==
X-Received: by 2002:a05:6000:bcc:b0:360:7a01:6afd with SMTP id ffacd0b85a97d-3607a74e760mr6960206f8f.10.1718631385486;
        Mon, 17 Jun 2024 06:36:25 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36074e0e5adsm12011860f8f.0.2024.06.17.06.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:36:25 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:36:20 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yangbo Lu <yangbo.lu@nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v2 net] ptp: fix integer overflow in max_vclocks_store
Message-ID: <ZnA71MTiaESQTUMp@nanopsycho.orion>
References: <ee8110ed-6619-4bd7-9024-28c1f2ac24f4@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee8110ed-6619-4bd7-9024-28c1f2ac24f4@moroto.mountain>

Mon, Jun 17, 2024 at 11:34:32AM CEST, dan.carpenter@linaro.org wrote:
>On 32bit systems, the "4 * max" multiply can overflow.  Use kcalloc()
>to do the allocation to prevent this.
>
>Fixes: 44c494c8e30e ("ptp: track available ptp vclocks information")
>Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


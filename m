Return-Path: <netdev+bounces-81002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D5E8857AC
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 11:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBCEB2177D
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 10:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807A557304;
	Thu, 21 Mar 2024 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TAaoyP98"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E3F5645E
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711018568; cv=none; b=E5pBO1SxjOX/59asEcJSnhqqzfYLkNePtnUN9xHUn/4+tVR1MWfOjS8aIBJcJndbqxf+2SbviIEG0ygJ42OqxQCLk3bFXdwK79SD4roABO5vIWXJtc9NzmHXgY179Xth7Uz1DxDW6W+AtoQR62D8qs16zkGDhy2aPWmmmxpUOew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711018568; c=relaxed/simple;
	bh=7f4eip5JEJW6TLMZgvqhzGTrSnJn/FcmClI9rkbbgzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKtb2pAurrBrqAD/4sQXDj+QmHnadipTK1OovBkrCfaMenmRhZKPuB1Nnm3kvunrVYWT1vuQmJB0GKs620llqvxOp0LisrY+Sjz7VwzUbwgC7CbOJ6XAqU8SVGpfrxJAuru87JH8uGrHzUu1prghPymzo0Ft4RpRaZB7b64hs0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TAaoyP98; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-414701303f7so7911045e9.2
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 03:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711018564; x=1711623364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7f4eip5JEJW6TLMZgvqhzGTrSnJn/FcmClI9rkbbgzE=;
        b=TAaoyP987hOhLZSPKB3K3k7zw4Q1FGORnZM8hSS6VC8auxHi8VoEJH/bCi0L3V3zm6
         vGt2cPsYo9kqsTfmQ3Ix5Qr/aLoLL7D4wkeEpbObF62dQKnyC5mkRhCyNy5nwWe9foUf
         p13SfhTWaZxpJA/ZlAKWaqbmcTymFdjLdjfSDfd45DVGjcYuIra0oW3yIjxaMT1C4l/c
         2nFPkFvKQUbmVb62IwNqkgQOlTSVYVcHeGvYO3aGH669JEN1WeSOZ+aebusYYaEc2tWR
         T1KQVD9u1lZsFkbveKiL7mDLmKei43Jzj3N7R66WG1xd/e11oQletXzlyx/wYLiADMwM
         Bx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711018564; x=1711623364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7f4eip5JEJW6TLMZgvqhzGTrSnJn/FcmClI9rkbbgzE=;
        b=NGVLDp7Ck/DWc6D6sqMV0tL527Dw6Dw8BmOyNLLEFA29qXDqI9TODH1aoNPMMBgSJ5
         6leOadDGG1X582BrEEGQJTqJe7vRNFIsVL6V9IBuXkYOAmvO5VGciW+OmC0jTeZWVYUE
         +uVv/P+GwnxSuD0ZWzGRtiYJFgxtqegH9s3m3A6pJ0f1J40xsae4JRkrf7Fol9jSKIP8
         0YzWsQ3MG/w/hfryV45jO6FlFCMM/jzN5iZ9UmHb+PH2CCIBIn2nppQ9yqQWaiXO1Y2h
         bo+JjcI+DEiJvhzVPen6y66iQIASIL+m63+eGgY5rY72aGPtNgTbCsuv3NMmX/MxpEkI
         Tvdw==
X-Gm-Message-State: AOJu0YzVCtxHBqGzxr0cIGOM2ok0qkEj6tGIXUJIkFlvmlPu9FBfl6QL
	TxpQr3QGQrkW4zTQ8s9v77rO5gjQ0TTu/UAwFg2JVZ9io8taRcWjFqX5HJmqkuU=
X-Google-Smtp-Source: AGHT+IF95q2KYQIcfSxFavafFREETN51D41DItEvcPJDVPif2jYc0myp6Gj6jwpAwpJ98fKIrTYHzA==
X-Received: by 2002:a05:600c:4f94:b0:413:f033:e1ee with SMTP id n20-20020a05600c4f9400b00413f033e1eemr1381399wmq.9.1711018564140;
        Thu, 21 Mar 2024 03:56:04 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id iv11-20020a05600c548b00b0041463334822sm5227207wmb.26.2024.03.21.03.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 03:56:03 -0700 (PDT)
Date: Thu, 21 Mar 2024 11:55:59 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Duanqiang Wen <duanqiangwen@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maciej.fijalkowski@intel.com,
	andrew@lunn.ch, wangxiongfeng2@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: txgbe: fix i2c dev name cannot match clkdev
Message-ID: <ZfwSP5-mZoKIFaTV@nanopsycho>
References: <20240321054742.446481-1-duanqiangwen@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321054742.446481-1-duanqiangwen@net-swift.com>

Thu, Mar 21, 2024 at 06:47:42AM CET, duanqiangwen@net-swift.com wrote:
>txgbe clkdev shortened clk_name, so i2c_dev info_name
>also need to shorten. Otherwise, i2c_dev cannot initialize
>clock. And had "i2c_dw" string in a define.
>
>Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID limits")
>Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>

As Jakub asked you, could you please take a break and read
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
?
Thanks!


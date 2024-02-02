Return-Path: <netdev+bounces-68364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B443846B4D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9051F2BE33
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 08:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD8604DC;
	Fri,  2 Feb 2024 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MgxgUKUo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90F604D9
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864045; cv=none; b=n4iu3JWBryCInoGC0AqT3zEdTX65tNA+GgN4onrI4cG97swFSP8clLLGh929fDMADYGyO1ZJ1Uk/bygDVlt0KgXGIxZtWuyqxsVCBloGhT37aFKBs6guhWjHKmaa8LTt+IxGFjHm5NKr5tm18AP1gRx1GT4gejVqlRcybCqaLGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864045; c=relaxed/simple;
	bh=T7bq3xHNg/s9HVbFl23MaqFRAUuwGoXpxNYtAFiCK1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rixm1YhL+mWpYykghPfurEOY4zz4G7WLAyTvU69/sm0Rf2tyfHAhm0yE1uiyxNRTRFERYO9IF237CmbKAWK+xx4ajLDFidnFDnRXLPZTcAbNdYk9Up8NMRCNxh7z8uAhDmXhLzWdtfN5YK66EX86qAGQrPV/LkpqGhwCzFcqWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MgxgUKUo; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51109060d6aso2762137e87.2
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 00:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706864041; x=1707468841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T7bq3xHNg/s9HVbFl23MaqFRAUuwGoXpxNYtAFiCK1U=;
        b=MgxgUKUoybkftKJYwtrVTUpdXvQiFPmesMOe+CrojPKIkCn2b7JN+hzsMJbHghNiDC
         1IkeOe4MIgTEp5Z85xDfzEVaNSLkCJvbPWQELg6Ft8SpwEYD1MKHCWwTuQ54jg/oo4VB
         UR0m9NXYDqCcB8manW61VFfsbpauXD82eVG6uBSkohOsf9sPe3wn/llBq0VM3MLZPxDB
         OTipZngbDDp5IwdmkpbY66vvWih69UFmgvPTVqmij03gIXN4wTWq7Inxm2gh4AJTsXq4
         kOKCnx6LtKsI73XyPObr0em05oAmZsbbASr7uJ1S00tFE7BjSEjwBg1AyKWOLvQhuymI
         lPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706864041; x=1707468841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7bq3xHNg/s9HVbFl23MaqFRAUuwGoXpxNYtAFiCK1U=;
        b=n9T2OUKnTFqkaeZwgeAr9+XQcCJmxMVqrA6eQ7UPVYA4BKHAV5DlqGuO5aWs9en98u
         siFvlDLq4TOeL7sCYUkllYTQQtq1LkVW3AHB7dUUldgZz7Iv0WHZcZox1aZ8j3W18W0L
         57fskW6FLEF56ylkg3hY/Nn/9WkMbnKxWm8YZK9CXMrUKwlrPEdAFBz7K+Kgxu+dEJDf
         A65DDdXFmLIzuVN5wjijy+rw+PND0X5SifYMpO733KaSPXwylmwrAEVftMB0QJL+CSE1
         cCOAqWcF5S1oWv3qY2M1sUQKR3oNoDfKLRdVANTEuZ2CBj7L/kCcfblDHeM01wreUs5H
         ewGQ==
X-Gm-Message-State: AOJu0YwChTVodDURG8IjA9TnxmlSqjGHU74904ep6TukbLi7c/nTz5tT
	ZTL8B44I86Q+p9K137+oESH+j1Ux/NneXC+8o+qHWDKSKuox9e5Gcx0dnjEGo70=
X-Google-Smtp-Source: AGHT+IGGcuR/FmrpM464UyvI6H3Eyhpd/m6ye0bQ69xFkZtDy/71p/4rT1CfWc0HyDm0L3IJm3P5NA==
X-Received: by 2002:ac2:549b:0:b0:510:c7c:5a6a with SMTP id t27-20020ac2549b000000b005100c7c5a6amr3159338lfk.61.1706864041563;
        Fri, 02 Feb 2024 00:54:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWWH0XyF2UxwKgL/eAajxL0PSFAXt50MADFBXGSGEwKxkMpWv7cPoSi9kW440OyTJv6v5yPlfxfGapBjMVKL2LeiVBma2Edhf3YGGUUqcVsLyLl2oiGABA3jvlN6UjACG9D0iVhaBAKbYIbAUOyuZFGWnz7O9ky7zfStCvfR9Bv7NzTQ2HQAj5d3UfflpcFu1mOTtUhhPSY8E3gW54gs1WD0ilAYZcUHdvEcfnUaqxuqyilQQX8xFX5js/BEdNYG+LII3ycKbI=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id d29-20020adfa41d000000b0033b137d8dbdsm1432924wra.103.2024.02.02.00.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:54:00 -0800 (PST)
Date: Fri, 2 Feb 2024 09:53:58 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, kuba@kernel.org,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xudingke@huawei.com
Subject: Re: [PATCH net-next v2] tun: Implement ethtool's get_channels()
 callback
Message-ID: <ZbytpnvfrN6xzKtR@nanopsycho>
References: <1706860400-61484-1-git-send-email-wangyunjian@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706860400-61484-1-git-send-email-wangyunjian@huawei.com>

Fri, Feb 02, 2024 at 08:53:20AM CET, wangyunjian@huawei.com wrote:
>Implement the tun .get_channels functionality. This feature is necessary
>for some tools, such as libxdp, which need to retrieve the queue count.
>
>Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


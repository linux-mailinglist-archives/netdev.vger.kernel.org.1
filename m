Return-Path: <netdev+bounces-172529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7C1A5529F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0930B3A2A73
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8014211715;
	Thu,  6 Mar 2025 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gi2rVjDD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84E1FC7F9
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281202; cv=none; b=VrekchNbxrvlOjTSA4yjRT+l07cQE48bIDFc2l91KHv/DVjLbX5nH0mwO6BzAoKfXUljadN++r5eniP6vvnq++uVrL1zLhOHIT7bfbXYF5chmeCXTJ1crziHM3yClDE6Iu3LAjRmkobOvqHARV6SQIErdSM5Z1LzePOmD+kXQVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281202; c=relaxed/simple;
	bh=MH3s5DdSDHXEdvDP8RcxBUpc4EYLp2CT+LTc9GnFEFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d75GJVeKf2G2kXUebk/alSQ7zbP7ty826gMIcXmeely8s8WZPnDl92Gm9kEhFEzBFWqy8cwzW/LJrxKACwR20I+DwzBrUSCye8W0F18Vnckq1To1kmpS202tTWx5GvawWstmTvqhPlTSzTIAd/BsrZqGQznvYAa0W0qG0odvKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gi2rVjDD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2234e4b079cso17156535ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 09:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741281200; x=1741886000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYHGtShHI8Y1FRWheLy0FMLjBiEAmtWyzjjd3SdlDjY=;
        b=gi2rVjDDuMepBoDO7NE46MK10MFCrqbrwOe6vNYToZGoSsvEs3+lf7vVc8Dsx7quop
         Oyxzt2Ad+3R6qaVNvQClSQ1/P5kT7vd1QfN13u42IM2teSVv9RxzK8cc+GGSNv5UaNht
         kPKDv/9St3OQ+zc+O98rlC3a7n1PGzF1WE7w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741281200; x=1741886000;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYHGtShHI8Y1FRWheLy0FMLjBiEAmtWyzjjd3SdlDjY=;
        b=emSkMF7NE4+LrzNyPXmRhit0nRpeuq/Uc0A0JMOhjl1qMVeh8w6T+zM4DzDA4EsAVZ
         kb3GZv2Tjkn18BpETVU5MokTTNRruYWVBYENlcDMUDA16pWxlZYITij8Y0IuKU1zTTdY
         mbpMyPher0sLRVGjSrsfGk89cmAXZ5lY8a1EoxAivsYBFv/vhBzjY/ECmhdUP2qOVTVa
         MULGXlEZysrPZ4hNyoX0iGZL2SCafacvjDdKfP5vE7gxxO6W8aUTZPGqjKOkSe3cv0Ak
         tNBTAACMocodKSVNUqAaqonqQ3+vW2W+aknuXXWkEETZ9/8p52oYCT1OBdbK6G914bgv
         mpUA==
X-Forwarded-Encrypted: i=1; AJvYcCXP5ayGt3P8redGnMIKPkAOiWsRLvVMNL38Ji181po/QalUpQFhlRAbJkK/6+le1mhR1Y2KemE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjhcZ2w12XSKLBY8BID174etoxWtU92F6oczKi+UN/Ypcjsy9W
	TuVzCB5esAp7X8Vr2PV9JUrca0uu6X7FB3iCaoulkmGYT7bhg8M7Pn5C4ylRlH8=
X-Gm-Gg: ASbGncukYQcnnVwaX1dMo14cnUF9dMReM4tM/w/PoL9v2qi2qnpuavX/ZQhDVRmLJbm
	bxirBDxPzYS5cquubqr9AhEHDw1dARB6uWchX3RihBCt6+vKeme4TCvUW3OfsPmHTJfndSidWCM
	2LUIu8+rwUtdDEn08ItenlJ316virmAdErHnM3WimFGA7EFkC6ARa0Z2cVb/rXsKCq/simSt/SQ
	Uv+7zB+rARfI5zWe4jMHcCUDa/QP5p40nOS5DoBRILhDx9WNbIer8CT8Ja+5JYsBti+2/boVxM8
	hEBxHpwgl1hyOUNl+QoXLyZOX35pKUIyzXF9+i0gY4/elzTz3oPXMAjFcn2CNhwxqMLI/rbuaBQ
	Wky22asqmg5o=
X-Google-Smtp-Source: AGHT+IFToTHN2fxWtQ5a96RQFVbx7zYf+xyYUNJ1uZLz7vUPxS9kZFdYCeyP5QugHQwd75ZpKhdpxQ==
X-Received: by 2002:a17:902:e80a:b0:224:6ee:ad with SMTP id d9443c01a7336-22428c01371mr178775ad.44.1741281200529;
        Thu, 06 Mar 2025 09:13:20 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2f01909a6sm246144a12.7.2025.03.06.09.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:13:20 -0800 (PST)
Date: Thu, 6 Mar 2025 09:13:17 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	alexanderduyck@fb.com
Subject: Re: [PATCH net-next 2/3] eth: fbnic: fix typo in compile assert
Message-ID: <Z8nXrbFjvFo-d4hH@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, alexanderduyck@fb.com
References: <20250306145150.1757263-1-kuba@kernel.org>
 <20250306145150.1757263-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306145150.1757263-3-kuba@kernel.org>

On Thu, Mar 06, 2025 at 06:51:49AM -0800, Jakub Kicinski wrote:
> We should be validating the Rx count on the Rx struct,
> not the Tx struct. There is no real change here, rx_stats
> and tx_stats are instances of the same struct.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Good catch.

Acked-by: Joe Damato <jdamato@fastly.com>


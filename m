Return-Path: <netdev+bounces-187581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9A4AA7E36
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 04:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B407AA7F2
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 02:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCBC433C8;
	Sat,  3 May 2025 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="XnHqyumD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E3417F7
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 02:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746241099; cv=none; b=ejOBidrZo7i7ZUcjr3KWsiIttEZrHvlMX0TWDbjKk8GRFJG97gAm6KPTnVpqPIo6IQUx9/FiP4rXF4qdv0hohEz/ONjjlfcfqHZbAMh93dNyMqJI+j/LGEFV7m9Pu8Ec4HqkqjWgDc2W3JLT7epmcqtjmiEqrK3loDkr/roMth0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746241099; c=relaxed/simple;
	bh=YLWG/NkjTiRF6ZRN6D4cx2Y2Q/fMJ4QayYeQPoa3wlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fn+hw6mB/IxYYfVV6IpKayyLqcFaM6w6N/IPB1G1IXczFrwWANsFocx7BLR14elSsEI8LZGldT0ryWBBmFWUG7W/ivb1Y+8OkQwXlN+dZ74QPDZnQP1/Fspm/CvC6zM+88f7H8TwS4+tIlU8PaxGyfC2pq+OvAv6LL3R3sc2GwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=XnHqyumD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240b4de12bso45259715ad.2
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 19:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1746241095; x=1746845895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74hDxlu4/JT1D17RPgXEv0tlMfM7iudpMVItMZQSKkc=;
        b=XnHqyumDl4ZEl1Gis6SP2xa2kM/p2G14s41zJjUOcsj/2Hqy29amM6r3iLDfOdC//E
         /KHfa3/hEm9T2m+oSdYmHgDSnaEj3Rv+Q2/ilNriZxz/Zrya8ATma+F5ZqCSBuhoq4Dt
         e1PvBlQFjcJ+tYv2ygLcMpuU6he7KgsOZ/mNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746241095; x=1746845895;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74hDxlu4/JT1D17RPgXEv0tlMfM7iudpMVItMZQSKkc=;
        b=hm/gFcLZAwr2kEyXEmlP+2lFI9gOblDEX7nXaABlA2rDCdJKeAekO0oUfS1suiAVJg
         +gTMX3lPDC4pFGH8Tu6de9cPMXaIQnonX3U8GUbmgB3328BnBlMoALIdd5FGdAeWBohU
         gtjDiVEcpAbPHhOxLOcwwlT+/8EKrh38mv0nKL4Y5MXVrWVkI5YewDAY8YV09wTG3pt3
         ok0pxCN8qRQ2I7RKtYRAGRHYLcfZvH0o2EyxqleCrXKhtop4nM/7AROtW/5NQYb9DSn6
         nFb7oUhl1tuSoYp93aNp/oC7HIrJd0Toad+iQXrlKSZtEkx5kb42pM2VhLugZjJFNJc7
         Ez+g==
X-Gm-Message-State: AOJu0YwkA+udwpv/O+XM9Adw4HVA0mk/TbRFffFQDbp+TR6YDKSIHlAT
	bGQ0P3lIpyCw+2INWKL57Ptuhms7QaQc+CIHq1q12eTvCVBUbMxQbfV8JZ9fPQ4=
X-Gm-Gg: ASbGncvLt3eGxox+EMeSpO1QAr+vSrIg9ipx4ekEgJkG++u8m+QEb0ec6+qY2f6R7oS
	lowBeB+wXtUA2fFKiEsI04o1e7ZHB24BxzBPv0zkDJ9pqRP7+z/34chGNvmstd4NJXtoYM+QFAK
	qdrojruy2UFj0f2YN/ghRNzla6wAnQcPn0z6MGItROeaoJoAqid96ugYvOmsIjjPinzqpExhXYk
	u4F69++4JjF7FPFZE4euJ4H4B8sz+SMaHwY5SUfVBPK2ibvJPhVb9IexsCfwMANmksnrWQNd0Dd
	ogN3MypHEHtQ9IZp/ofTLPW8I2P7Xc3d3OcbYdRoEIeZ01Sk7hX2A6uu75sRnvWCk0n8VMNOKur
	C1CE50XY=
X-Google-Smtp-Source: AGHT+IFulk1T5ECHNGOeA92YpMMjIYKUKSrhC5x/BnwQOUqn8y5TkmGUKch3DzLRY9r7g7U7WPsMkw==
X-Received: by 2002:a17:903:2352:b0:220:c86d:d7eb with SMTP id d9443c01a7336-22e1032ebc5mr78662865ad.36.1746241095116;
        Fri, 02 May 2025 19:58:15 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a476267d5sm3892793a91.33.2025.05.02.19.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 19:58:14 -0700 (PDT)
Date: Fri, 2 May 2025 19:58:11 -0700
From: Joe Damato <jdamato@fastly.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
	sdf@fomichev.me
Subject: Re: [PATCH net-next] eth: fbnic: fix `tx_dropped` counting
Message-ID: <aBWGQ_27ZI7Ti-Z5@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
	alexanderduyck@fb.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, vadim.fedorenko@linux.dev, sdf@fomichev.me
References: <20250503020145.1868252-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250503020145.1868252-1-mohsin.bashr@gmail.com>

On Fri, May 02, 2025 at 07:01:45PM -0700, Mohsin Bashir wrote:
> Fix the tracking of rtnl_link_stats.tx_dropped. The counter
> `tmi.drop.frames` is being double counted whereas, the counter
> `tti.cm_drop.frames` is being skipped.
> 
> Fixes: f2957147ae7a ("eth: fbnic: add support for TTI HW stats")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>


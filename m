Return-Path: <netdev+bounces-242950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DACC2C96BF5
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 11:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C98BC342B09
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 10:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F683307491;
	Mon,  1 Dec 2025 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="05CaYIxV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC20305062
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 10:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764586264; cv=none; b=H0smaJt+5x5NCV6jvtgAKGAQWTTZBqR7sN6BvYl/3aTtAQ1+/cWVqiSpAS0GHXGhRi3o4NNuLNeXE5vA9d38H5+FefkWy0E/DlEud2BSxIPjf1Mp6Je7191TiqO1y7UI6j4v6I1hBtf8xjgv67e45ad16ICgq22O5jhxyh/H+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764586264; c=relaxed/simple;
	bh=Fqr6qpy2QHYm2GjegQoamThXNI95Ygn9oib3niTm4oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AY5Xq38UMaJ0Kv/l//iifw3u0pT+qHZ8GV0t39XzW8tFvjM/Hh1IAjTkGl5ma4JpQirCMUseMQdTamJ1TPbqAXaUIELw+q4CGpT33VnYoXRf71ktv68AZTpPF8GhPD9tRO388DJ/xGUYveImML/4UWiSy0urK3dk5BMLeP3HS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=05CaYIxV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso18136285e9.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 02:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1764586261; x=1765191061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fqr6qpy2QHYm2GjegQoamThXNI95Ygn9oib3niTm4oM=;
        b=05CaYIxVm6ACdnxmzpYIE14vvzHoql5xA57TIZ6LUeqBdjNUgyl5ZnHq3uEy8lAri3
         n82gv7bTzBXax8eiMd+qbQ6FcYrGSsYFplM0WnagzUzkGVp4jkLRCjrudTumwWDxe78c
         Q5kb6c3wQjhi9cGRuwkAVMgePbPXkvfHIv8ItDcgTCc1VJlf8izQ5hp8oj47vqjwsp1B
         Kxe2MemxzYFLGX40ZHymnz0F/bKreHiixvX1+VUOeCNunW4G8Jpgj0BiNiZCU9Uc1sMn
         Wj2vIiXa4ODqAvefhoj2B/1s+mZ2x0jmG3f9rKZlFm4JJnQld5JJN0EmZbNadVqbtQgi
         YlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764586261; x=1765191061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fqr6qpy2QHYm2GjegQoamThXNI95Ygn9oib3niTm4oM=;
        b=bmPDSd5uHVeo7ylS3l1n6BAPGjHGVnzwidfOWtQghINKcGnAZHIvi42pdyPBYnTH4B
         2BKBD+OoY74qOhLd8brjbkJwApdqHfh/YJnu/eJKTGbColQhWtmavLuuLioDTnvlkuZT
         lsRVVKnQobBalpwM4Hqw+Yhl1Ngju/kC3+kwjxle6WcwLRjx2EY6obZqpDLl+jfVJE1M
         IZx8sIFhj/9F7cSJiDyB3pzUmN985cU2kxZdj9Tk1uBDN7vgWL2TT10FRfUHUNFaPxFQ
         rDAen4PwYvANBw7ehbkXHr1x1GBwNk8VvYr1D77/Q6QIEmyttqYvJHTPw2K0ijxn2GnT
         pBow==
X-Forwarded-Encrypted: i=1; AJvYcCUTrg0jqvDBFDQfzDT0VDuToYoHWydVH9fZESwT2JPG6vvViSu01b5WzfZsO9rMMXRlysgpKT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLLX3MiuYkcdzaPoQJt90DrvSTCX7OicItoOrlhqISwJjo8fLV
	nz4Pct7H9cc96cIk1Jix7D5puHpotUyP3y+N87141fOaM95YMVNxinvG8XG5cssqTUQ=
X-Gm-Gg: ASbGncs2S/ptl1WzNDOlNk+k/caZyOuYrJARFVFNEIIAHyt2d37taf/Z85oHZl0HXRx
	AIgZkXlr6z8z7Sjt05+qFapge3LRTaQqMXRx8E61rmxdcSlpPEn8pTnC/yxCv2RNd+Lzv8SLQvR
	nM7K+bcS8K64CFTk48mjJOSQhpcwpNdIOW0Z7+aQZpbcrjfQXohIUr3s50XAlI2vRLK22tPaTwa
	eN5gG/PE1dj4Z9iRDm6elDPDf0NwhAqPX9XTv3sWIXUQid/2r6J8i7DiJ4G3+CKDQLELTlfgPx8
	MT4HQW5pNu5ApQSJVIpvPKK4M3JwUm8tRKYGCy/lAKbQkCS8VwAfinX/eZ59Z3CixekoGFN7+pO
	T9ObbxNYc1WHT6OrNzilk+h1Vjnfs123Y1151qS4ElM7aQvf1KUQSPfr/4O1m+bUW7zGBcSXOVN
	2E4XaY1BAQV7sGFtbu1LA7w6swOaKbXTHp
X-Google-Smtp-Source: AGHT+IHDMrqX/K8K+NlPhHfHYNqhShQOpD5sAr4CXR4vDEef6ED23rYcb//HGm9GwLyaFTWyCcDhFA==
X-Received: by 2002:a05:600c:1c25:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-477c114ed70mr523856105e9.24.1764586261487;
        Mon, 01 Dec 2025 02:51:01 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791163e3dasm234443755e9.11.2025.12.01.02.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:51:01 -0800 (PST)
Date: Mon, 1 Dec 2025 11:50:59 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next] team: Add matching error label for failed action
Message-ID: <wneutmbnj5ie265wee6lssijddfomagyrkckepjbeexei3nqng@as5icpm5f4km>
References: <20251128072544.223645-1-zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128072544.223645-1-zlatistiv@gmail.com>

Fri, Nov 28, 2025 at 08:25:44AM +0100, zlatistiv@gmail.com wrote:
>Follow the "action" - "err_action" pairing of labels
>found across the source code of team net device.
>
>Currently in team_port_add the err_set_slave_promisc
>label is reused for exiting on error when setting
>allmulti level of the new slave.
>
>Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


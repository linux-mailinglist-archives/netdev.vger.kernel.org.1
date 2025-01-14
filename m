Return-Path: <netdev+bounces-158286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA965A11519
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E37D3A3213
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34515213245;
	Tue, 14 Jan 2025 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Qkgbge2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CED1216394
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896257; cv=none; b=S/AO7Ns1kURI5TsbZgZf9shqIfWfzcH9S1GYzmf2EWOvFSqmVf9vsgHNijta40N6DaDgvpK4fXu8xeY18ZzgiDlxKliCnMoEYWD99ZttA/Mw6WNsQtQKlegIkMQ+9e9Hh08aD7O2nPv9PuOPZStbt+G/12Zp+4S8F/0Tdp+6VPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896257; c=relaxed/simple;
	bh=Hmm0NRWTgTEaKP+6VEgBu42rzF3JLKrrc3b9MMvgjx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuPRH8QX/MjFWv6bC6JlE3XxSASTP2Sm0KvNL2ph9vhUO9ZUpqXIU1GwxmCR6wakM7OZP52SucCnwl4EKvbMVEElxa+SMtUwPmyw42UH/ZsWGH2g6UaeZ1F2d1ufawX5VAXmwROWylsK+L3AJAbmmKhxFloZMoof5GEuDCFv4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Qkgbge2C; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21669fd5c7cso111138265ad.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 15:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736896255; x=1737501055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00PKn3LgO/rO7pjDL757XYluDL9dW1lAljtlB/rtyus=;
        b=Qkgbge2C8KpoLFYWwZvZVYcTszEmD4HbdHqh8cxwmpR21r5yZTyfl2M8i2FyFIl2+i
         tnGhB4OMiUgdQr/D9MQo8/vbnO1T7yOTiC8Ek7cmV7nIx3eqgamgd5ESw9WVmT0xp7hW
         q+S3Dw3N7BXIowQ8rUdg5tm4NQNsBNrczceZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736896255; x=1737501055;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00PKn3LgO/rO7pjDL757XYluDL9dW1lAljtlB/rtyus=;
        b=QG5r712k7oNC/qfXcWpTp5bYyqyBR3W6q1+XFJChO+Zra48o2anvlSYyLSTq1crgPs
         Xu94qbnaBWnkuuFBu7JYDJ0OZ5MSAU9cye7Q/pc121Yz5jdUaTd3NKlbY9w5t2E2Hkgu
         LPaRGesUP/WJAnz/1YcQKN+c/Hulzgj2DWczhA8uAQoIINHI4Wnt5GLCYBN3LIlaJcB5
         V1qGZcbXNAcha+5fBEsPmdpbivFzCfWVL24SyuPYx6ip57wOa1/13aDi+sF9bKXEzxVE
         0cfAsN/UCnyGmFA0o9Wt7cjeZuWEDL5fzaP38gZ4jxwpHZFBkF2A3YHVY4kOoI3TzBuU
         0+aw==
X-Forwarded-Encrypted: i=1; AJvYcCXdJDXuB+ZfPy3rUGPFxKPR2bQ/YVOqkwb8Qp/UokeKaWUTTXwzkhBJzPb+bLKJuhPrUMKtT7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7t0xSOb2m2HCdWu8wg+EtixMks85EMxjCgyHHvMW9fvFepLK
	/nrRCggIYP+WLM8Wel+EAE9LjvG4GotEz5U7BVb5xzeYeBwYTMDWnvJGX7iipNw=
X-Gm-Gg: ASbGnctfwnmfmdOLN7tCgQccCG6sMw9066Bq7rzwZUWTrXdG7vX2vSEnvb3As7hxljX
	xTzuU7yCSLwdyCeo/oW2ZpET4oOvqr8hl9ldMnDVyUl9uCZ/wDE/gwgLCNF7YWKQUnbIt9xCCFL
	Qqi9u/SXBxfoAOeDX73LOgbRBMls/b5m8/1OvafjUQdiWhtZrWEaHtTp7sKoNoXceSZhS4xysAa
	rJqb2mnuDDpx/VHZSSgIxgsewD15kSFPy954dFBw27g8Zw37QrPbYor4SUiUrvgwfB3m+4A0GIc
	crEfYzN9/YwQviz5DdRv8+Y=
X-Google-Smtp-Source: AGHT+IEovD7WstLOv8Ou2S/si78C4mlnxGE6nnbPNZ/DcN7m3B0i6tSiOJwpk9hRNwEpbhMaiWbmDg==
X-Received: by 2002:a17:903:2308:b0:216:779a:d5f3 with SMTP id d9443c01a7336-21a83f546c3mr451933985ad.14.1736896254998;
        Tue, 14 Jan 2025 15:10:54 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f21bb48sm71604655ad.144.2025.01.14.15.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 15:10:54 -0800 (PST)
Date: Tue, 14 Jan 2025 15:10:52 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 05/11] net: protect netdev->napi_list with
 netdev_lock()
Message-ID: <Z4bu_FxxmOZutPp-@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
References: <20250114035118.110297-1-kuba@kernel.org>
 <20250114035118.110297-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114035118.110297-6-kuba@kernel.org>

On Mon, Jan 13, 2025 at 07:51:11PM -0800, Jakub Kicinski wrote:
> Hold netdev->lock when NAPIs are getting added or removed.
> This will allow safe access to NAPI instances of a net_device
> without rtnl_lock.
> 
> Create a family of helpers which assume the lock is already taken.
> Switch iavf to them, as it makes extensive use of netdev->lock,
> already.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/netdevice.h                   | 54 ++++++++++++++++++---
>  drivers/net/ethernet/intel/iavf/iavf_main.c |  6 +--
>  net/core/dev.c                              | 15 ++++--
>  3 files changed, 60 insertions(+), 15 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>


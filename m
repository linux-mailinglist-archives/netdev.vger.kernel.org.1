Return-Path: <netdev+bounces-198134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62893ADB5AF
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67ED188DB2A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0EA23BCEE;
	Mon, 16 Jun 2025 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="g/tcpNQS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817C420F09A
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088540; cv=none; b=RHSLC/++rSHDVatk8w8GBtUKECh2GTaQrnhyvT9cezhUSuH0KOnOcrooOtiWqSQBzF7eZqErLezEBc6FPTBH0JD8FnFyX4zTkEnzcm8R8nsJ4tLeGjVDwMcf45pKaTTv432wnLmyZMPH+xPl9KFWlym0nXjhmS4d2R3flFuDSvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088540; c=relaxed/simple;
	bh=di8xudatdp5SMy7eHmZefJhZ5PeWDPFTRDk8xQCxU20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChIatpFZxCxgORbJchqtoSvtCN3/Tzyat7RAuevTsn/Zxfg5VbQ8ejfu6cIzZxAAOg+om4mTI7LJyITaYySpAFg8trD+YxU7HFuLhKpmcrZINYC9i8p3hIjkW8SirDL9LAHKbfQwCLp8VOTKo5/wwHUZ1+fnEWZF+3q5YfLLX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=g/tcpNQS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so26198525e9.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750088537; x=1750693337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yP/CQ5X3qQ+mpgXoALhvLq02Vdqe/xFaFqGX6GUODjI=;
        b=g/tcpNQSto44OBu5ZPyJ0TfYU72cr7/vgKA9n+bPHE3hKBnaIdIHnkik0uCxJToRrg
         HWFTCtl1EVZ36FDaNZEZyH27VfEaq0ueY5PEI/gggqzgAFYaQMtPVNGxrdZOgAzFqZAI
         CPXlR5F0nC/o/PyjmX3rdAXMKXeLHI8eXF7pStcG/SK3B6ZvFnT1a24iLuMj3XI1sQRY
         jxqZKq+p5nfFWZ1BcgMdz/a0ijGU77RfC+179A+t4MoZE5C5Ekcu4rhmt3il6lsququF
         YMv6dZIH1/JoWQFwIz+CnJXVqUZKmgAF3bKWjos+lWIV2vcnAmAVzKk6WE5dOqirXqpZ
         AhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750088537; x=1750693337;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yP/CQ5X3qQ+mpgXoALhvLq02Vdqe/xFaFqGX6GUODjI=;
        b=t4Xv/0cjfEvYL/k4TcVvXWMRxMgq3V4krpCwGp7UJEJxic+Scjz0JIVr6Aou3Hj21Z
         phEitbp39nRdYaDYrcCymbPEzCAyJcWU/leCnvn/ZZowl9x0qnG3ZemhKz6Vf8Hfhu6z
         3Vm7IjkP+k8azDe+ZZL5yiMsqgRBUYrqX0RnVHdWRu6GOJAjOENq46ZYAo8gosagqlMT
         Mh1O06cnkdOKgHXMTIFUMEQPv2Gha9uQsk4sH+36Kkp89SzTYBcBP6XfW3AFX67wxsEM
         Uis2oGdNpS110cHxeXDeBMYQrjxOSUC5zWRggo7BUQAlWTUPkQfxxoFcpVObaZXZ9Vyu
         PIug==
X-Forwarded-Encrypted: i=1; AJvYcCWhaYhWIgNayNw/zaG6u8Yz1/q3oD0RRQ4xEllTFkM+xgkXo+PV+9emXch6bnNP3amuPgOix+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfaJzuWThnngfHxJ3x3KmdKPzNi0OzJR6LH0GW3kBhwXxGni6g
	gCLaHNY2ppdeSDSXCreV05CIIYZHMj5kUVkYFfvAGrJV1yAIKFNFEuAkm5hwBV04e2Q=
X-Gm-Gg: ASbGncuYPyjuR99DHV1gI8EU8lP/SwvWNcRYyBSTS87t8DU4noBBM6HLooWLFzWQXzR
	d8TFwi4Ba/UP0E9uISr70ghzHd6+d/07qfgGtSWynmQW/5AY4vulNgd14Psw1FIQrRHT/nEQcWH
	8d4wFJSy4awSrJ4WwXEoWMBzlC9k/Kpk8xbJzAcOOEWP/tDpMlGk7eXjHZG1jSLXAk4VI3EPLyV
	dmqaW2+qFLHr4pUBlr2JS+sLyw0zRnsuvFnh4u0Yod2XpCVDDFNdZiu0tcDLZ9yVJOCsZ8QKpRO
	HK/y/VA2y2FvdYXNbVsZhhiDL84LxmgYSuBi+SmtoTQISNWYE4iyIpXx7BB6VPxqYBM=
X-Google-Smtp-Source: AGHT+IFy6UZIT7ibKTKBEfFAC0y/576cRTmSYSV0MMDa6HeLuamo7ZHSBOMvKASYcuA96i14m1MBRA==
X-Received: by 2002:a05:600c:4e14:b0:44a:ac77:26d5 with SMTP id 5b1f17b1804b1-4533ca572f5mr98219285e9.14.1750088536696;
        Mon, 16 Jun 2025 08:42:16 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e22460bsm156250815e9.6.2025.06.16.08.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 08:42:16 -0700 (PDT)
Date: Mon, 16 Jun 2025 18:42:13 +0300
From: Joe Damato <joe@dama.to>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v2 1/2] rtase: Link IRQs to NAPI instances
Message-ID: <aFA7VdI7BWQOKW0V@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, horms@kernel.org, jdamato@fastly.com,
	pkshih@realtek.com, larry.chiu@realtek.com
References: <20250616032226.7318-1-justinlai0215@realtek.com>
 <20250616032226.7318-2-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616032226.7318-2-justinlai0215@realtek.com>

On Mon, Jun 16, 2025 at 11:22:25AM +0800, Justin Lai wrote:
> Link IRQs to NAPI instances with netif_napi_set_irq. This
> information can be queried with the netdev-genl API.
> 
> Also add support for persistent NAPI configuration using
> netif_napi_add_config().
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 20 +++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 

Did you test the persistent NAPI config on one of these devices?

Reviewed-by: Joe Damato <joe@dama.to>


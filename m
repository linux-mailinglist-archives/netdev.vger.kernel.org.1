Return-Path: <netdev+bounces-214931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B89B2BF6A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066DE1703FC
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6561731AF01;
	Tue, 19 Aug 2025 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bivRkAID"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A461F8722;
	Tue, 19 Aug 2025 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600812; cv=none; b=CYAbx9O0lf//aibLCp6L9PuYqLSjj5uHWxd0mPhtwGRalfrAODIrvgN5fkEfQxiBGukYNgDG5pDsfZDQpjbBpdgs/b2wDfastugFuVfqx5AcSQ/uumvXXFSIIU1HZf5XsFmcy9GNLgBQ/XtnnFQz9kq7n7LsjPkHJuUVlzgHj0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600812; c=relaxed/simple;
	bh=Lu8+FLgRBE2mWiUP/dZpUYRLl6TgRKYLZSvIGCaaHcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCY55ei6E33NUiknUM+l/Gly5p3p/rdaa70NXzXlhmGjO0C+gFYSx02/h2Jgq6CJnjixo5YZnXAAm+lRa6qpAP+KFhLCBAsFMkncf1bqfmq7waCobMEGFuArS908Zw958pc8LIN+1BSkWIzPl5mVNbhVdHrla/OykP7STavQCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bivRkAID; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-afcb7a5cff3so95608466b.3;
        Tue, 19 Aug 2025 03:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755600809; x=1756205609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ3WWCvJpdSlBjQe+gLB+6Rijmqm2XbNhbFSLgz2eKU=;
        b=bivRkAIDeU4y3QAHSNonD4xmlPqAqhgFHYzUiSi8bGsWXJiXcB8HXhWw2jpNcJIlNP
         kXlSQK88exDdDvWMtRCxZ6Iq0LPk1deQdyZE+/oUdg1v4rt2C9LYZITjTIlSmvSxhCQ3
         SoxSF3Ac3yUzj4WXgi9bS7TJ9tcRpcU8M+L8GWicEdfx4489u+Xky25iD4++QpvDuHBA
         /geaOuumzfKmTuhcD78B8JPTM+Jaooy0b5H4Tw6fs9FvCojOs90ephQ9oFaHffMkuGMG
         g7VxT2NwOgyfhzqJPNspjnenCjew0dP0G/0LiGCFkhpDft01PnrectiYfwraSDfrs3uE
         DHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600809; x=1756205609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQ3WWCvJpdSlBjQe+gLB+6Rijmqm2XbNhbFSLgz2eKU=;
        b=mA3LgZoV9mdmnS7+Pp0sKYPbQbIT7ztjTP6tZ1lnPXbOIOSaUFQqaO9mCXESZM8iUT
         ck9+leJsGna887JcqYDDvOU845MZnEubwvxGmkwSQeEp1WbgIxyihBqe+x183SfP6Fg7
         4yYrXUxZgR7CNbiVRhHvAPN5DQuFim+QDy4yFuOpKUvEi/rmgzP7BECAlJKiDwfou8iT
         pv9wwTf2Sj2Tcaoges0dHeCvDzXrtgbdaPuU2ikPR9jbYU1J3tFe2+9iFFDYVFYb72x+
         yTXRS3sUQXukIhI+fE4A8smf94aTpZiYydya1uuRGfCXnfaltMwONg1nq8H3u3pqHUfD
         YTTA==
X-Forwarded-Encrypted: i=1; AJvYcCUH1d0/2ZQOkUzL0r8E0r9fB3s/d8VXUv0NyYARAN4tZrI6LR+nCakrKIfwyaTUeEX/FNRRmCT2@vger.kernel.org, AJvYcCUUgvoCx+7FemCITa156L9x4IYlpJMzoIFi84FUuONmsBDcQ46QXzh3qnDGJqVsqbjjx7RNKTjsVRti824=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzUMiMmZhPbtBc3e4kp+dbhPges4K9L+av7DH0ohjP177GLz+O
	x3PVG4qsPYKOLwLkpGODA6x/kPUmYEbVXofXZW9TlCNmoGygHAYArher8YUCWg==
X-Gm-Gg: ASbGnct9Ko3eKM4qE1wAmQMKErhZFnMgVURyODIjsn0az38ykZaBgXv/9Rx2aYgqgVI
	uOXmFTI/qbMirmz8aLqZx2tR/b+y41OJKzMrJdRgXlfCkSka9lWOyiWXO6ixKQcgZ9uEKNvaY7b
	r6Q1n/xAbTeXJxAhESKEz8lAv9ZRad+6szU2CkMSLBXvGkriNx/U54e3YLbxSsofbgeVvW5i29w
	WVj8r8i2cfYi3ImM24Sb2ElAlB1vNlFZ0EGCwzilr1vEug8LSxG+PHSNhUFgJJQhs7CbHx6LB+r
	vWa4+Jjc/fGaJkDdx5xPv7TsP0kXiHVOk263wPVfmsDFm4m0DUQY4JDR9GwcssMVXKOrS6ZLtY9
	jok/1kLwfKeIndRQ=
X-Google-Smtp-Source: AGHT+IHYHSHOrGl15203O0R9iDrM2r0QMVlszncbwITNXUNTXHG022X2whTrHOYFUN9Hmzo4j7v+YA==
X-Received: by 2002:a17:907:3f1c:b0:ae0:ba0e:ae59 with SMTP id a640c23a62f3a-afddd1e4384mr104347866b.7.1755600808611;
        Tue, 19 Aug 2025 03:53:28 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:5508:97d1:7a8e:6531])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd04e0c5sm981587266b.117.2025.08.19.03.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:53:27 -0700 (PDT)
Date: Tue, 19 Aug 2025 13:53:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v2 0/8] net: dsa: lantiq_gswip: prepare for
 supporting new features
Message-ID: <20250819105325.2rvgom5gpnfmuozo@skbuf>
References: <cover.1755564606.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755564606.git.daniel@makrotopia.org>

On Tue, Aug 19, 2025 at 02:31:17AM +0100, Daniel Golle wrote:
> Prepare for supporting the newer standalone MaxLinear GSW1xx switch
> family by refactoring the existing lantiq_gswip driver.
> This is the first of a total of 3 series and doesn't yet introduce
> any functional changes, but rather just makes the driver more
> flexible, so new hardware and features can be supported in future.
> 
> This series has been preceded by an RFC series which covers everything
> needed to support the MaxLinear GSW1xx family of switches. Andrew Lunn
> had suggested to start with the 8 patches now submitted as they prepare
> but don't yet introduce any functional changes.
> 
> Everything has been compile and runtime tested on AVM Fritz!Box 7490
> (GSWIP version 2.1, VR9 v1.2)
> 
> Link: https://lore.kernel.org/netdev/aKDhFCNwjDDwRKsI@pidgin.makrotopia.org/
> 
> Daniel Golle (8):
>   net: dsa: lantiq_gswip: deduplicate dsa_switch_ops
>   net: dsa: lantiq_gswip: prepare for more CPU port options
>   net: dsa: lantiq_gswip: move definitions to header
>   net: dsa: lantiq_gswip: introduce bitmaps for port types
>   net: dsa: lantiq_gswip: load model-specific microcode
>   net: dsa: lantiq_gswip: make DSA tag protocol model-specific
>   net: dsa: lantiq_gswip: store switch API version in priv
>   net: dsa: lantiq_gswip: add support for SWAPI version 2.3
> 
>  drivers/net/dsa/lantiq_gswip.c | 404 ++++++++-------------------------
>  drivers/net/dsa/lantiq_gswip.h | 268 ++++++++++++++++++++++
>  drivers/net/dsa/lantiq_pce.h   |   9 +-
>  3 files changed, 363 insertions(+), 318 deletions(-)
>  create mode 100644 drivers/net/dsa/lantiq_gswip.h
> 
> -- 
> 2.50.1

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>


Return-Path: <netdev+bounces-197860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 866D5ADA13A
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 09:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCBA3B30C9
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 07:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263B726158D;
	Sun, 15 Jun 2025 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="zILTqGCg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833BB1FF1BF
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749973289; cv=none; b=f9g0fm/EnSktP9zBc0EM3fFFsnGMkDCwAXI76ij9vTC8EVhfee7IYiRuwcntW4urdB/fyUUqTFeLsHWEWcLC4eMRVkDDL6FqZdrT0ZdhrGNkp7ODW7+43N+MJIW46RQE/1n18xW3Sb0lZSb0K7+GrQS7QrDinvXiwSOLX7She2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749973289; c=relaxed/simple;
	bh=w49Ia7nLZK5BATZbhja7+FbxaKXzLeK7IEP4zr/0bu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGcn3vGLR1JxZx/umIHVBECyJp5BBNFaN0dMYSSjNqd7BolFIOw4xRNu/drLzA30IGRdZWwlAKl7ZAdYfC1vsqsDLEh6enQhnksZGNg2huA6s8/ssp6P4s6G/aBqBjgjy0o/G25HoeR0Ykhn8GtVcziHkgWAgleqwpxDubsT3UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=zILTqGCg; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450cf214200so29210645e9.1
        for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749973286; x=1750578086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15crHfYFg0c3yN9UDEf5GY+yILB0/x4l44MtFuPKz6c=;
        b=zILTqGCgqRw72N05mTHPtvYjeRZexe7Ba03+M28yyRBav5pMp24FvAv6KYNoT3GhoW
         +qFic/XRiaGQbcNWbPum1OqZ15bhrGe/VeEbjIk086eGdVTQUf/boJYS39L2z/QSM6pN
         4Nx5S2MaUmL/ozaUTugQ8bDB8Lroe47qO/UaaRbux8tHk2qU0rINOOtfsP4oHZlNmmhs
         19GSWtwwmbsijAcAuDV8TnQYq12Lje5h5fmlbOePZRry+r8ZRunchCNJhV7sx+uK1g1p
         jWjzmjsbVwOw1ri1kayfBDOetQ4iio5YeSjsh9Rcu2kT05JfXin4Be+3rbPKJK70xNv8
         zwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749973286; x=1750578086;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15crHfYFg0c3yN9UDEf5GY+yILB0/x4l44MtFuPKz6c=;
        b=XeKmdbU7BZrCqBL9IpZbfxMcddc+AKSxm5tWtn3dkHd8tsD96OoVsguzcEnTCkvuqE
         qXVbX69mCi24MlXMKHAoQqPrCOClNOiCKrxn6LD0dEiBYBojZZAe68zp+ot7kzVOV4Fq
         BwxSYdp5zSTYA8KdajqxMrbenk5zo3E4RUq6JgHIqWVQolvHGs10K8IoncQrkmE/SB2A
         zBjWfdvDzviLCgWFE+XSndHis4ajJB9gv9xd5k8Ju9G0hy6zgro+dRPxzUK63ffyXo+J
         MIhO2BjI0GRSwT+2KWfTjv4+PDpXPLEqv2XME1RL1QG8tK10bsiEGBqEgc5QT+wNn3Fo
         FaLA==
X-Forwarded-Encrypted: i=1; AJvYcCWkKPFG6JDkRNf2vRmi59CE+gZrQuBvmBRoiShbUHRzOX2YGDGFhooDK5M3th6Nqe5Qip/rd9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgFFxQkeCaGzGb1dKJ1OWUR+TZvNFcWnBsM0XezY/pIkEZGVyd
	PGyYnHJCdgO699f7wasmbx8l25JCEv3kNH52B40zDUjlCt70aJyVe5baU46DuuLf2FE=
X-Gm-Gg: ASbGncueMy0wuTGk9Pg/NOYISSYNG1M7Vh0qlyBBotLjrLoxFDEiiFUN2gpkJrF/JmN
	DGflBIWJ849/kSt1L6MACDD8G6obHFc8kO6pHWnPwlEFBUWHJE1JGps393YJWK4cmGwautyfOUu
	Al0qSD14LtSQtA8PbXUVQ+VY8YsHuLP7/awf2XP0xqJITMvDAKHk9+XK31ulKuVcvdtRCWhZHRL
	O8Sv/ehUtRZuMWWJUTD+/C8D9ccVrqozur3IiZQKBqygc7pMrHlHuTHvdGOrqfbcE6tJC1ieVqf
	GBqw4tyyyZlBFFTn+GU0Rm8/Zr+3fn7G13J7Sglno5V7MDr7sam2XsUfbkshzhv4xyk=
X-Google-Smtp-Source: AGHT+IFkqUoRixLle1xv+ipidpI8Wlfsv3yhb3f0P7DkHWCnYQQa64tQfvQew1w3Lcmx1RZCZ782Yg==
X-Received: by 2002:a05:6000:178a:b0:3a4:dfa9:ce28 with SMTP id ffacd0b85a97d-3a572366767mr4802586f8f.5.1749973285894;
        Sun, 15 Jun 2025 00:41:25 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a734b5sm7289017f8f.33.2025.06.15.00.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 00:41:25 -0700 (PDT)
Date: Sun, 15 Jun 2025 10:41:22 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	bharat@chelsio.com, benve@cisco.com, satishkh@cisco.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
	xiaoning.wang@nxp.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, bryan.whitehead@microchip.com,
	ecree.xilinx@gmail.com, rosenp@gmail.com, imx@lists.linux.dev
Subject: Re: [PATCH net-next v2 5/5] eth: enetc: migrate to new RXFH callbacks
Message-ID: <aE55Iulol5QTZMMQ@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, bharat@chelsio.com,
	benve@cisco.com, satishkh@cisco.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	bryan.whitehead@microchip.com, ecree.xilinx@gmail.com,
	rosenp@gmail.com, imx@lists.linux.dev
References: <20250614180638.4166766-1-kuba@kernel.org>
 <20250614180638.4166766-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614180638.4166766-6-kuba@kernel.org>

On Sat, Jun 14, 2025 at 11:06:38AM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> This driver's RXFH config is read only / fixed so the conversion
> is trivial.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - add get_rxfh_fields to enetc4_pf_ethtool_ops
> v1: https://lore.kernel.org/20250613005409.3544529-6-kuba@kernel.org
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>


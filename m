Return-Path: <netdev+bounces-197340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7080AD82B2
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 07:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F477A3A7F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 05:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAEC1FDA6A;
	Fri, 13 Jun 2025 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="pnlkFpS+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6238DF49
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749793620; cv=none; b=fARG7RuYvfY7jxPQlQvJ2UyHC8u11G8KkSY96S6Qos54P6xoYLREXpyZk2VySYB8J+19DPFw14jQlQlvqUgsRw2OmCmMmC/KBnaFdI75v5psV1pXybRyD+ccNNHQ6JT1E/gWoyHSOuvyot7RF55gDTm+ef0p/TvsAOLrdEj4Rkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749793620; c=relaxed/simple;
	bh=1tL574St+l0hhqNeNJRDByJY1z3BVGHZirhTQ29vGZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ+HDxuC1JTu1NMXgPmZRVNBPj3ViyvoieABJ+LhkrwdV8ZWjYf6mUUXvJdS2IobzjwjDdVa9ErOVYnOJFG+sRtR+O/q4nbGdeCJ8uq9/zAh74eSYHUQj2yoAAMIMZhHKu4RW/lHEc7h3LV5sZ70oWd6EQ50q99etIXgBndqWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=pnlkFpS+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45310223677so14895105e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 22:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1749793617; x=1750398417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEwgX9L9/NZFybt++vFWWEkABvQHG7NaD8RX8Gt7I2Q=;
        b=pnlkFpS+dm9NvfnxGUaSUtSTX2+ZpwNzkg93GJc1DgXfUCjiLmbkD5Zo21cZhuZ6VH
         z5eMOgHON2bTiroVfQg4frXxZkBZBK49gf5hUYRayJJOfhLUGTzl1wuyojWy0VTCH/1n
         g3+yzspVSCAMFPru8rtj/nTnhcRp5IxEOm9leaMj3zxQkgO1IVDG3Sr6wjJudfm9mkKM
         2QxNhKfYQBnDeDPKEOQ6swE4K1uDPb8HeE3bMB/XbRGZDaBirNos4Em2FDbztRm8mL7B
         8RtpRPvOfefVta00yvjLXQ8B2lm7iK7ELESCo99o8sZGR0+2yKPtSvcXGW9afM7vq1Zo
         VnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749793617; x=1750398417;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEwgX9L9/NZFybt++vFWWEkABvQHG7NaD8RX8Gt7I2Q=;
        b=c+WxI5Ue+mMMxFJkWP7kWOqEGpl9AcEIGBqn0sJ0fRWxS80OXQDPa9EwWRiAlk/4aI
         ISd818hmFGjiLjQ+1TYKqp495XuLXyva9jXf4+7Qm1NQQELwMaG6HI8Fhux84332YjzW
         bU31nYXQ1zPhWj0lzhaf9X9/rX5qQWfJrdQK6w0F7N8lqYxGPGjcyxuJjO9npMiqv1pK
         DULvdUndJGlzjfNTEXsq2sK0l4/h6OaAbQ3bOS64DnCOKODMcts6hpu5kExhnb/aSiFh
         niFljkSzbnyVNilGp04Yr+uAbIPsuroXjDt6bZr5MCfmmz70m/sTJDR6j+cnr1CLMk1r
         gWpw==
X-Forwarded-Encrypted: i=1; AJvYcCXBgGH72pA3OtQJTaTdxI7ToTLsPLq7bmlPwMyCDlBjg11Z0o3Ukq3hRrRZOhZBx16x+6ro5D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYdIowD2ZvlckT+H/lO7QapyiW3hHZ5eY0rSj0s290R8w8Flgp
	QA8mbaeuw8rOThuPnx+mbIf/aK0MjnIuvefcAPHLxmX7tmmT2jKn2M41qmbc4CjffzE=
X-Gm-Gg: ASbGncvP7886qE2Z3k9EbSfbL2Vb6a3O8V6WF/7qSxkO4CNqX7VSQF1d1kMEnAxMSka
	082xj7aNJ9GUu626kGVQFM3qLdSS8dMrk1K7rsrwcI5UyeP+Z0qyTxw2MhgPM6LJLNIw0s6cnV9
	y3JpC11xp1NW0XqgYBROt0SToAhybIv7DNG4K8BIcOPdwiyHtFq/713UgDLf5H49vwa3V7n9eEv
	c0GcIw5pvxZIZZ6Mp5OkLYsf+/pghtEQkUH1ED0ukJtjueuU+3AnPsV5m89kgPSoQHQ4SCoL60O
	coB16E1nxY8Tg2sOmsgt6+4PJZfzK97qVxLhmWCEE5EhKRsTMs/R8iEuYWlMXw63w4w=
X-Google-Smtp-Source: AGHT+IH6+Yv88UzWNVVtuhEJAUQypxvKjQTlMb2Ja3qKZUBUZoQXBTZb8QCbRmLiQf+ok+wu2ZKobg==
X-Received: by 2002:a05:600c:3f97:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-45334b19564mr14025915e9.18.1749793617033;
        Thu, 12 Jun 2025 22:46:57 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e268de2sm40936085e9.40.2025.06.12.22.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 22:46:56 -0700 (PDT)
Date: Fri, 13 Jun 2025 08:46:53 +0300
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	bharat@chelsio.com, benve@cisco.com, satishkh@cisco.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
	xiaoning.wang@nxp.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, bryan.whitehead@microchip.com,
	ecree.xilinx@gmail.com, rosenp@gmail.com, imx@lists.linux.dev
Subject: Re: [PATCH net-next 4/6] eth: e1000e: migrate to new RXFH callbacks
Message-ID: <aEu7TTei6ggKpS0n@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, bharat@chelsio.com,
	benve@cisco.com, satishkh@cisco.com, claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	bryan.whitehead@microchip.com, ecree.xilinx@gmail.com,
	rosenp@gmail.com, imx@lists.linux.dev
References: <20250613005409.3544529-1-kuba@kernel.org>
 <20250613005409.3544529-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613005409.3544529-5-kuba@kernel.org>

On Thu, Jun 12, 2025 at 05:54:07PM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> This driver's RXFH config is read only / fixed and it's the only
> get_rxnfc sub-command the driver supports. So convert the get_rxnfc
> handler into a get_rxfh_fields handler.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/intel/e1000e/ethtool.c | 77 ++++++++++-----------
>  1 file changed, 35 insertions(+), 42 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>


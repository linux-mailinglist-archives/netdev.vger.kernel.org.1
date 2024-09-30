Return-Path: <netdev+bounces-130552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A2698AC81
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 21:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F1E9B2451F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D934B1991D3;
	Mon, 30 Sep 2024 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oG00S9an"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A16194C92
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 19:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727723198; cv=none; b=fzB72IaI4nh6LuSVcbnNOtBrw9dycKzIaPtDfh0xI4vKwZqq4K6Y30lxOSpzQzoRVo2QLz/f6/9Ec7I9Q0JNfZiEYF2OA/erSQtE8Ws777b+bbKhrLUzYqOSqJ2mIg9mtLPwH1zcRtrmOf4HOTKFf5TPc04152+LsLSEBasiIk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727723198; c=relaxed/simple;
	bh=R6rO7y8uNKUPlo7zKHwxmNFqKP5cep3FaTP4WfQXXZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SK6z5Jcus/nwKDrb3hMQ9IYP9ceBT8ycSFLM2ilX4OgdQv+rHHP+UQWFGLfYUGsbi0W/Oybk47kqiQ99H4OPETNxYwwyZTki+GI97H40x2MV0tjUZKniqH3wEmDMfI1GWV11PVTMiuXov497ng8rqWu/nO32sKxJWjrg79ZvaUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oG00S9an; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xfnpayxvbHckI5Fb2Y/Fma2x8Bi6li2C2F98JErB9oA=; b=oG00S9anb4B/Y+eAgvLpBarUcE
	jBX8kYNPUYiG+pwbkF6olY3nsudc6v/1QqGfkI6MB6Z3iELQtrjwSJlsMsy/kjdnoQQid7xcvMV5B
	Qn2P9o7vYjbz0YYJ49injjViejgSeXO+4Nxhr104bPjtEyli2PYbsZtix8eZ1NYUlMPE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1svLj4-008ehw-Dg; Mon, 30 Sep 2024 21:06:30 +0200
Date: Mon, 30 Sep 2024 21:06:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: wojackbb@gmail.com
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
Subject: Re: [PATCH] [net,v2] net: wwan: t7xx: add
 PM_AUTOSUSPEND_MS_BY_DW5933E for Dell DW5933e
Message-ID: <e2f390c7-4d58-47fb-ba86-b1e5ccd6e546@lunn.ch>
References: <20240930031624.2116592-1-wojackbb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930031624.2116592-1-wojackbb@gmail.com>

On Mon, Sep 30, 2024 at 11:16:24AM +0800, wojackbb@gmail.com wrote:
> From: Jack Wu <wojackbb@gmail.com>
> 
> Because optimizing the power consumption of Dell DW5933e,
> Add a new auto suspend time for Dell DW5933e.

Please don't send new versions of a patch within 24 hours.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

You commit message is not very good. What makes this machine special?
What is wrong with the current code? Do you have any benchmark data to
show the improvement?

     Andrew


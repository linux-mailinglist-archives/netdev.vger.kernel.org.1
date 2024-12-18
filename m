Return-Path: <netdev+bounces-153117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AABE9F6D15
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 19:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA44F1894723
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 18:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EE71FBEA0;
	Wed, 18 Dec 2024 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xj08/SEo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63851FBC94
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546014; cv=none; b=lYyAvVLwfGTXBk494z905TzPxkjZnsHjdKM87b+6IJitBLOKmTXWmmsIPDqy8gJWYYW/xdsr35DT7LZHgrfhBbnWF6vcda1huVLkRj8xnszF2/kufsnn2xyI5l4u1036w58+4MDN5ph1g1N1E+BOEMnbfZ3H96etH1lleBkFpos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546014; c=relaxed/simple;
	bh=4p1AsyLjo2x7S/EkOQVNcmO6NQrVF6KRKKcV+az+qz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUG7n2HWFBHxMhQlXcFPhuMUzEO0vBgqRStaPeYYFK1XovyEKur3ZYIK0Edcq32hwMZRstYl+2U20FlNHKskP/v2yb+awYTIFQxu3LbinySoweiTR1ckljXxtYoNce3sTZDZtZcjlQ7cDm8dRgO1zhvJG1TU4P0z70wDD3T1ZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xj08/SEo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Kt7Xbnanqrj52TOQQ3oC1wR0pVJPfIogCKDlu0+TXOI=; b=Xj08/SEoLQOF1Ip91qn12vzctm
	P5zOSsEl34KYPeRI7//PhFJOqfUETCEtM6ZaiZErH0gPQqex/hEYs6lWb2+GlC31b5CzHoVgx9ZrE
	kQfc3rZ5mo9KubPgGEW7Y0jlMkmCJvvp7s307vxU9LNf9SinDJHEbsL55KRL9Y6c+zDw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNyeU-001MQ0-7a; Wed, 18 Dec 2024 19:20:06 +0100
Date: Wed, 18 Dec 2024 19:20:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	weihg@yunsilicon.com, wanry@yunsilicon.com
Subject: Re: [PATCH v1 01/16] net-next/yunsilicon: Add xsc driver basic
 framework
Message-ID: <2792da0b-a1f8-4998-a7ea-f1978f97fc4a@lunn.ch>
References: <20241218105023.2237645-1-tianx@yunsilicon.com>
 <20241218105023.2237645-2-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218105023.2237645-2-tianx@yunsilicon.com>

> +enum {
> +	XSC_LOG_LEVEL_DBG	= 0,
> +	XSC_LOG_LEVEL_INFO	= 1,
> +	XSC_LOG_LEVEL_WARN	= 2,
> +	XSC_LOG_LEVEL_ERR	= 3,
> +};
> +
> +#define xsc_dev_log(condition, level, dev, fmt, ...)			\
> +do {									\
> +	if (condition)							\
> +		dev_printk(level, dev, dev_fmt(fmt), ##__VA_ARGS__);	\
> +} while (0)
> +
> +#define xsc_core_dbg(__dev, format, ...)				\
> +	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_DBG, KERN_DEBUG,	\
> +		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
> +		__func__, __LINE__, current->pid, ##__VA_ARGS__)
> +
> +#define xsc_core_dbg_once(__dev, format, ...)				\
> +	dev_dbg_once(&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,	\
> +		     __func__, __LINE__, current->pid,			\
> +		     ##__VA_ARGS__)
> +
> +#define xsc_core_dbg_mask(__dev, mask, format, ...)			\
> +do {									\
> +	if ((mask) & xsc_debug_mask)					\
> +		xsc_core_dbg(__dev, format, ##__VA_ARGS__);		\
> +} while (0)

You where asked to throw all these away and just use the existing
methods. 

If you disagree with a comment, please reply and ask for more details,
understand the reason behind the comment, or maybe try to justify your
solution over what already exists.

Maybe look at the ethtool .get_msglevel & .set_msglevel if you are not
already using them.

> +unsigned int xsc_log_level = XSC_LOG_LEVEL_WARN;
> +module_param_named(log_level, xsc_log_level, uint, 0644);
> +MODULE_PARM_DESC(log_level,
> +		 "lowest log level to print: 0=debug, 1=info, 2=warning, 3=error. Default=1");

Module parameters are not liked. You will however find quite a few
drivers with something like:

MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");

which is used to set the initial msglevel. That will probably be
accepted.

> +EXPORT_SYMBOL(xsc_log_level);

I've not looked at your overall structure yet, but why export this?
Are there multiple modules involved?

	Andrew


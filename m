Return-Path: <netdev+bounces-154128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E599FB8AE
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 03:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8772B1645E3
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 02:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DA215D1;
	Tue, 24 Dec 2024 02:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dzQY+mB7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E9B946C
	for <netdev@vger.kernel.org>; Tue, 24 Dec 2024 02:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735007276; cv=none; b=YvI3RewKLURnM2EZQVlbCrPJFzp+5Xss+sR/Rm5gvnKSZV0DWjz3DhoMVNaesJXq+Dm5BMh7NiqaQWHZyj+zkUi0tISVfWngWQmOIK8f+2PJlPgRCfOwhTEsLvNFmoXkv0zdSjgYLKB97T6pjqZLfIOyM22OXQkY/98S5vq7am0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735007276; c=relaxed/simple;
	bh=dZbXOmYT3MrKOgMZlvyCMHvflAlq/IHhDSJ0kCfGMnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLgT4pjj9x0aoBHYTs83bCYm4aOBAV/lTyif9FcBp3GPYZ8ysU9QoQelYb9R69FsSvdVHtt8hHAO0Za0nCFIM3w6Odfryrob10VNW8bIKjyMxa/1chEpFt6eVHn9ttXgv3y3Y67SJhtU6/x+adFqomzjbgeEG3oIbrssMZj721s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dzQY+mB7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=R9OdG0sEwiEi5pjz3ELAcAQlCGf8TDVUP78Y2EuCrn4=; b=dz
	QY+mB7+aCJRe5mBTflSSpASY2jqev+dmsxOAZ0/3xwStTtqRPwUgv/U36bOg7LbZ4tA96dCBd42r/
	STjkYgH5bH499xTA2/C9IE4/DeAguN+CCHdawTN/iJTT4PW8rd/iUyx41VT5YB8TLGSLMVYStWmFK
	D68UMtqvmfD8ALQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tPue3-00FdAI-UU; Tue, 24 Dec 2024 03:27:39 +0100
Date: Tue, 24 Dec 2024 03:27:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: tianx <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	weihg@yunsilicon.com, wanry@yunsilicon.com
Subject: Re: [PATCH v1 01/16] net-next/yunsilicon: Add xsc driver basic
 framework
Message-ID: <94a63b04-a3ca-48c5-bae9-bf01032fb260@lunn.ch>
References: <20241218105023.2237645-1-tianx@yunsilicon.com>
 <20241218105023.2237645-2-tianx@yunsilicon.com>
 <2792da0b-a1f8-4998-a7ea-f1978f97fc4a@lunn.ch>
 <e219e106-72ef-4045-9fc0-db2639720aa6@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e219e106-72ef-4045-9fc0-db2639720aa6@yunsilicon.com>

On Mon, Dec 23, 2024 at 11:20:20AM +0800, tianx wrote:
> On 2024/12/19 2:20, Andrew Lunn wrote:
> >> +enum {
> >> +	XSC_LOG_LEVEL_DBG	= 0,
> >> +	XSC_LOG_LEVEL_INFO	= 1,
> >> +	XSC_LOG_LEVEL_WARN	= 2,
> >> +	XSC_LOG_LEVEL_ERR	= 3,
> >> +};
> >> +
> >> +#define xsc_dev_log(condition, level, dev, fmt, ...)			\
> >> +do {									\
> >> +	if (condition)							\
> >> +		dev_printk(level, dev, dev_fmt(fmt), ##__VA_ARGS__);	\
> >> +} while (0)
> >> +
> >> +#define xsc_core_dbg(__dev, format, ...)				\
> >> +	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_DBG, KERN_DEBUG,	\
> >> +		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
> >> +		__func__, __LINE__, current->pid, ##__VA_ARGS__)
> >> +
> >> +#define xsc_core_dbg_once(__dev, format, ...)				\
> >> +	dev_dbg_once(&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,	\
> >> +		     __func__, __LINE__, current->pid,			\
> >> +		     ##__VA_ARGS__)
> >> +
> >> +#define xsc_core_dbg_mask(__dev, mask, format, ...)			\
> >> +do {									\
> >> +	if ((mask) & xsc_debug_mask)					\
> >> +		xsc_core_dbg(__dev, format, ##__VA_ARGS__);		\
> >> +} while (0)
> > You where asked to throw all these away and just use the existing
> > methods.
> >
> > If you disagree with a comment, please reply and ask for more details,
> > understand the reason behind the comment, or maybe try to justify your
> > solution over what already exists.
> >
> > Maybe look at the ethtool .get_msglevel & .set_msglevel if you are not
> > already using them.
> 
> Apologies for the delayed reply. Thank you for the feedback.
> 
> Our driver suite consists of three modules: xsc_pci (which manages 
> hardware resources and provides common services for the other two 
> modules), xsc_eth (providing Ethernet functionality), and xsc_ib 
> (offering RDMA functionality). The patch set we are submitting currently 
> includes xsc_pci and xsc_eth.
> 
> To ensure consistent and fine-grained log control for all modules, we 
> have wrapped these logging functions for ease of use. The use of these 
> interfaces is strictly limited to our driver and does not impact other 
> parts of the kernel. I believe this can be considered a small feature 
> within our code. I’ve also observed similar implementations in other 
> drivers, such as in |drivers/net/ethernet/chelsio/common.h| and 
> |drivers/net/ethernet/adaptec/starfire.c|.
 
Did you look at the age of these drivers? starfire has been around
from before git was adopted, 2005. Chelsio is of a similar age. You
cannot expect anything so old to be a good reference of today's best
practices.

Please just use netdev_dbg(), netdev_info(), netdev_warn(),
netdev_err() etc for the ethernet driver, combined with msglevel. It
is an ethernet driver, so the usual ethernet driver APIs should be
used.

For the PCI driver, pci_dbg(), pci_info(), pci_notices() etc.

I don't know rdma, is there rdma_dbg(), rdma_info() etc.

	Andrew


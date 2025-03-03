Return-Path: <netdev+bounces-171243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D39EA4C208
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 14:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C941893FBC
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE417212B0A;
	Mon,  3 Mar 2025 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UCozM8cR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6886347
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008681; cv=none; b=cmhok9D0h/R7RB1d2Zk5ed7pTPtSBOOqTPxxd6jlaEaTTNo+cs7uvKYR0yCAQUMlNJG4Amtr6wh3vT23OTbs9djpIRruHJ3qAxsof6swTxtltZSscEVptoF0Eut3LNsalG7YtfiocBIngn1DvWqoOYx855K7JSzIunihG3jZcds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008681; c=relaxed/simple;
	bh=WnGMallghhPd6rWvSuB2PdrMqCjxLwrwLZwX5QF726k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCBDcNnhAiNVAk9jkPpLDhXBF21sj6RT6yQ7Q1X3x3Yd/3K1mS2cWFP8OkrtJ4nl7xl42cpSxNjSS4RR+VPWH7qc+WXYi7JNYAdxPvJp6t7/H5lHyJzkM8g5iv517R3UYNhGR3QK6r1doOQUQyPs6AssKXY4eTgVPa78bhef3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UCozM8cR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yRptjpdwQ2Ylj0tapqxnqN4uLms0bOujEob76dd9TbM=; b=UCozM8cRYNL3bIfVCeScBaF3x2
	pc9d7bXAu4pFLNxMEQPdkhxTrbMyjY4zRgFh/hgLlLZjwjRLcwCWH74CIAZFn6l3I0uBVNZBbj+Pw
	gBAy15ew5DB409YvofrP1TGmyu6Q4UIc8i1tgQXmd/y6R/YFH/PAcLznzonK0+xfY/ho=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tp5t3-001oWy-Bl; Mon, 03 Mar 2025 14:31:13 +0100
Date: Mon, 3 Mar 2025 14:31:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Viktar Palstsiuk <viktar.palstsiuk@dewesoft.com>
Cc: hkallweit1@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net: phy: dp83869: fix status reporting for speed
 optimization
Message-ID: <3a80404e-9baf-423c-bc5e-22c3d80a0cec@lunn.ch>
References: <20250303102739.137058-1-viktar.palstsiuk@dewesoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303102739.137058-1-viktar.palstsiuk@dewesoft.com>

On Mon, Mar 03, 2025 at 11:27:39AM +0100, Viktar Palstsiuk wrote:
> Speed optimization is enabled for the PHY, but unlike the DP83867,
> the DP83869 driver does not take the PHY status register into account.

Is speed optimisation another name for downshift? When the cable is
broken, the PHY will find two pairs that work and use 100Mbps over
them? In the kernel we call this downshift.

	Andrew


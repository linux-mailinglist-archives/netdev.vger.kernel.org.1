Return-Path: <netdev+bounces-191029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A68BAB9BF6
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 14:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE3B1BC635A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 12:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243B623BCF0;
	Fri, 16 May 2025 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG9xI1CY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003EDA32
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398376; cv=none; b=TdoD50qXLNeTf9daVrFrAP8MkE+cQGp3mM+RgU3kEyoEvg2N68Eqw9OktZT2h85R2Hkw7eRRtE/KoI2o8D4mlpvM73EdGcuymMRAgmQzfIFeRX+IgmtQz6uD+NSfvBH3MlBz4SEjcQlsIfVtuXMT4nVGqSuWkcpBYGNycX+B92U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398376; c=relaxed/simple;
	bh=CyM4S9jfL8h2B2XiLu19YmvBFt4ZtyX71KO11OJNNnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiYYg16Lx4ycHR8bOMSzDTnftOg47F+s3xjBQaFzSrvjjpU9cawzk3vLPvHQVPAvZHEkq58iAmsgRExsx2ukoa596YhWOKJ2iJ4SBZ/2J6zrDWABvVG+lSmfuRN9xwP8nZgjyDqTJSybzPcShCQ4Uf5Ddb2UA8ld8/gB5IbRlIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG9xI1CY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C94C4CEE4;
	Fri, 16 May 2025 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747398375;
	bh=CyM4S9jfL8h2B2XiLu19YmvBFt4ZtyX71KO11OJNNnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iG9xI1CY4GYCevM2jgFfDr1rJM63qtMSB3WV6tDK4klkdr1Lgvhcre+oqU03umkE8
	 q71vdNCX+c2XHqxLnLM3bbSsSQha1THzMuV4Djzqz1mQcgwYQrg8aJzrgWsvPqTJZt
	 LaG6U8hPrGhmxaCOM0wDLMVNbSRaG/biDUu5UOHZjtoYEiwxj3fQHVsoh3o6Qkccmk
	 +OiW31rHu4DQt5ljz4r34TO2mMY3Vp38r4CTn5oQ/PpxfFvucH5vpnKCLazT5gwWbG
	 Holl2CQIO5BoeX9Ik7UGc+0z34EKbBkn5Kne8kpJ55mEKAdiHrKQZe9WL3fVdsMNk0
	 IGxl+3j3PdtAA==
Date: Fri, 16 May 2025 13:26:11 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH iwl-next 2/5] igc: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20250516122611.GA3339421@horms.kernel.org>
References: <20250513101132.328235-1-vladimir.oltean@nxp.com>
 <20250513101132.328235-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513101132.328235-3-vladimir.oltean@nxp.com>

On Tue, May 13, 2025 at 01:11:29PM +0300, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6.
> 
> It is time to convert the Intel igc driver to the new API, so that
> timestamping configuration can be removed from the ndo_eth_ioctl() path
> completely.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>



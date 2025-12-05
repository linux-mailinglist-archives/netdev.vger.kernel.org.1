Return-Path: <netdev+bounces-243826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7EACA81CD
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 16:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B9D630E5A5F
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 15:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14711346762;
	Fri,  5 Dec 2025 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DC/jq4ub"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483B7347BC6;
	Fri,  5 Dec 2025 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947486; cv=none; b=f9/HKR59O5mhyJAXmYA1tXh8STDPxGidpCGUb/HxvVQ23ANPxDPEjzAj6TgnAQYmsFQj2YlGVIWaPpCEA20uwWtqC0IN52bQXgUQ+w/n+lpAMsuyR3yqXMXLnxZnbsprDEKidBnQUWbufghAPv464icmRExxuSYXKw/lKfejOvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947486; c=relaxed/simple;
	bh=rTYz3X8IR6znjVFq2ide3bkVAPpgJHTwjknKT+LXwqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZts/z4760cyQD3nYWC98RUciUH9lpHJ4SDNLpNKRndoyaGMsXDJf4HMOzk8dbwDUnKqA3jrUIiMR0VEHPlFJnt3S8Zui+CfdfRPea9I348/oiANaxm4ZWfxQMKm2qusLAi5dMt6eE+PvlQcwDfjEpK25Gf+qEL5iue1V8iMZsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DC/jq4ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61291C4CEF1;
	Fri,  5 Dec 2025 15:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764947485;
	bh=rTYz3X8IR6znjVFq2ide3bkVAPpgJHTwjknKT+LXwqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DC/jq4ubJMaW+v+fns6X79hLZyq370HP4m1mPStWc8Yt0epL71c9d1+sdj0L2BMIj
	 zRVIX6tkO9mwcbJjAkL1WgD39SYBuOP4y6eAtOSBCMiGaFAhWkCxmBSbxM3IlEu0+B
	 YCQZ6euQGUSVkooiHbJhMmghqUNNPI5ffa5IgxnyYkffbzz2aYqYlXaMSoOxykqIcG
	 hoEal5Wc3ctm+zCNlCRjx8qH4zv6tO1ciaG4QbBoFS1hhoUuDjxUGENPO7SNmXKdue
	 kJ8EcIVnzi5hzKDZOlMRvAfXUfEQlZLievVCc5Jc+E7CMawqqojh717fnK2fPPLgbA
	 62Mbic3jG16Tg==
Date: Fri, 5 Dec 2025 15:11:21 +0000
From: Simon Horman <horms@kernel.org>
To: Aaron Ma <aaron.ma@canonical.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ice: Fix NULL pointer dereference in
 ice_vsi_set_napi_queues
Message-ID: <aTL2GcF6CTXRU5Wt@horms.kernel.org>
References: <20251205082459.1586143-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205082459.1586143-1-aaron.ma@canonical.com>

On Fri, Dec 05, 2025 at 04:24:58PM +0800, Aaron Ma wrote:
> Add NULL pointer checks in ice_vsi_set_napi_queues() to prevent crashes
> during resume from suspend when rings[q_idx]->q_vector is NULL.

Hi Aaron,

This is not a review. But a request for the future:
please don't post revised patchsets to netdev more than once every 24h.

Reasons for this include: allowing allow time for review; and reducing
load on shared CI infrastructure.

Link: https://docs.kernel.org/process/maintainer-netdev.html

Thanks!


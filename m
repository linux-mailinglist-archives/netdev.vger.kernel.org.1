Return-Path: <netdev+bounces-191028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B725DAB9BF4
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 14:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3343A8BF0
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 12:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C60723AE9B;
	Fri, 16 May 2025 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHysM9fO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18687A32
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398361; cv=none; b=pATL/ZBBrefMDQtUqY51fj+IodnHiZ6YdZk49UFI2RSJcaSbTx1FegImj8ojK5UYoaLT4EEAyoZkKkfHsZVuGPKs9tnEDS1DPOhB1qhjJsZBtSkxiDbvN+21YWoOh2/uYu871MUkeKeqxnaNLcDbta7FuOEsgjfF4MFYwqDtw70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398361; c=relaxed/simple;
	bh=GVIAK1h6hKOXMHM9V/6Z35jdHgeimGcRUB6GqQMU5wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jg5o3K+3mpNIPW0Gr7wkvorhtJxPnO4GHwHwa6p3oiI+Ssi2Zz+SgdS+LIw8xWPYtq2o4UGwN4JP7Tg8cfgWVh9lmwGElM9bknZ5nJprbyrZbi56AN7U4zNgyHl+y1izT1HUExLsJXa2yePvW496Bhmppt+ax2sjHbKixNyMrlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHysM9fO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADF2C4CEE4;
	Fri, 16 May 2025 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747398360;
	bh=GVIAK1h6hKOXMHM9V/6Z35jdHgeimGcRUB6GqQMU5wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KHysM9fOSJqqIEHgrA9LA3rqysX3574Zjk9WA8YKDYBeTAL4bh3k0plnObB4au+4h
	 mr+6p9F6HmTqEq8AlQWcxAv5VntO/DbC29LAnb9Qjh6914zxoNUs89Dy7NxzKFSfmz
	 3Tyo8UrMs1g93Hp5laNJzhrUK8h9epW+ATxzz31GB7bSSwkhO1fDu6NIE+M3q7BWr9
	 cI4Ewid30S3GoAfqiUHXSbnyyVmp8xskmpu8uxnwjUlFUmd+kH1HhX+QgJvwqNwEfv
	 XgXq1VHXFP4lLo3AKo6FgXcjqG5kkWdia7+vRE+r5xJ6IXZK7X1ZghAJCxqGo/lqYs
	 bdERBeryv9rTQ==
Date: Fri, 16 May 2025 13:25:56 +0100
From: Simon Horman <horms@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH iwl-next 1/5] ice: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Message-ID: <20250516122556.GZ3339421@horms.kernel.org>
References: <20250513101132.328235-1-vladimir.oltean@nxp.com>
 <20250513101132.328235-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513101132.328235-2-vladimir.oltean@nxp.com>

On Tue, May 13, 2025 at 01:11:28PM +0300, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6.
> 
> It is time to convert the Intel ice driver to the new API, so that
> timestamping configuration can be removed from the ndo_eth_ioctl() path
> completely.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Acked-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>



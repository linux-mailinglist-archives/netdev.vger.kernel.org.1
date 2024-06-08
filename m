Return-Path: <netdev+bounces-102021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3EA90119C
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 15:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15BF21F21DCF
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 13:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8CE179663;
	Sat,  8 Jun 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKPQqLxv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589BF178379
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851607; cv=none; b=pAikeVE9mEtXzsQp1t6tFt7hrj8zaUb0hYOd6xPahiVlB3zHk2Y1Dt3/F6zxTPcserb99LqQ3oKNPhltQNw4Ir5lRS9p7P+0v568Cpo57nx6ptFkooc8IwOlZacp8VdhRhUM4a+bzRUeodQMS1x3eH4cGVaqUEY2ut8BUZL+yFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851607; c=relaxed/simple;
	bh=Ko2dva2R0y33Pjh2cNh4af7X+bEVHxW+/W5sDQ09gG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5wd7CGfA8/z8kFTiW9YUvODArxH8b1dlieYR77D7+nC5eZ4Wkt1pORrYVOGmhu8fDPrSXa2TIm7k6uuYe+vyV0guFXHPK6t4rdDHDnnR80ZaXJliwVFkokdk4gkxa6gREGbam8RF4GT1my33o/ImiBkxlNs6AiwGppkhmI7jtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKPQqLxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82912C2BD11;
	Sat,  8 Jun 2024 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717851606;
	bh=Ko2dva2R0y33Pjh2cNh4af7X+bEVHxW+/W5sDQ09gG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKPQqLxvj8+7ChKgF2jJGcPwLEhJ7C7pM2KxjbdgvYJwVDEo5gKvEe3Pmxx4IGXlb
	 /Q82TbXoU1l+2qCau2DfbnukcJzI560nqH4ODQwIBleKx5a/+xdCh0xbfAS6iI8fCJ
	 Xn/yAO9M1Oe5KG3esfxxYfXxZ6uH8WB1ZnYOcFif7X/gk7nNPch5YEj7PRZ1/dvwL8
	 GJca/iMQWuc22MqV9Qk98my8yada43o2fja0wKMyZ0387D7Hkh5iDtWxzmmVLPAwup
	 BLtqoUaoFM8xBoXjnL6pO+hq6EmHebS9FxFQKRuEgL1O1h76WujnLiviDhZoRmcDOD
	 TVSfTaF3RENSA==
Date: Sat, 8 Jun 2024 14:00:03 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 11/12] iavf: handle set and
 get timestamps ops
Message-ID: <20240608130003.GD27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-12-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-12-mateusz.polchlopek@intel.com>

On Tue, Jun 04, 2024 at 09:13:59AM -0400, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Add handlers for the .ndo_hwtstamp_get and .ndo_hwtstamp_set ops which allow
> userspace to request timestamp enablement for the device. This support allows
> standard Linux applications to request the timestamping desired.
> 
> As with other devices that support timestamping all packets, the driver
> will upgrade any request for timestamping of a specific type of packet
> to HWTSTAMP_FILTER_ALL.
> 
> The current configuration is stored, so that it can be retrieved by
> calling .ndo_hwtstamp_get
> 
> The Tx timestamps are not implemented yet so calling set ops for
> Tx path will end with EOPNOTSUPP error code.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>



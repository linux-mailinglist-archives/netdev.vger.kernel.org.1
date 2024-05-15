Return-Path: <netdev+bounces-96533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 126488C652F
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 12:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F531C20FD7
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3014C5FDD2;
	Wed, 15 May 2024 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQtFtcoc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEE65BAFC
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715770438; cv=none; b=uOu3O1FWgjPa7zF/wB9A9152r4kLOBLHKreSSfYQAe8mFImImNEm4g5Y1GeZ+qC/69gUp4l3P/8COkSqoPW1AAhnwYPbWvTSld/lA+HGGGZrEeIxDtgZDVUnP67pGxe3P3GmMYLatvGmRz5eqCKt5F6izu0LqinYr0b51XzF8Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715770438; c=relaxed/simple;
	bh=QRw6nwRXyqsgD3nh5DvfIUqZjW7P971Rcz1253oIkog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuGiTBpmuh7aeM9HWaZMf14D5uialTSdJ86aorRsSimSLJ55GMJWsiQ1kzO+UoSo2vtSZdbrVQM6NjvPShv9ZxldUrKEYYwm6LMACT1f9aulrOs5dYL48EWDUzFkqtgy0fhSvjvv1YfbIT7omJTLHB8MiKg+QRxGVgTg3YyYbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQtFtcoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE13C32781;
	Wed, 15 May 2024 10:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715770437;
	bh=QRw6nwRXyqsgD3nh5DvfIUqZjW7P971Rcz1253oIkog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQtFtcocSBKa1+7HU5Lh2w0c+w0PIRtPBcAhoGdf/JqL9Wy+otYSZ+T46+IUoe/2z
	 maZhxkjZgUjPK/M4geG5nIbwPTorXYxN3xDdU2rAyMk7hTix1grK/s9osnOpJBzbxP
	 HkDYzNrX/+SyB1A0dx00vDkQaM7/1G6NJQiALCjUMTcNaK7vPalcTJIlPV1+5tU9YA
	 h4Fe8d0HMOiXKMCbYhFF9pYOCPjSrmGEt8YuoQxtdj6Y5SMFwNzUvzY8Bey2OZ6JKJ
	 d41pZGyXyQtRJYirAE4WjdxHZyDyQHkZCukEJerV+7TRwYm/b+dQ6SSMr1LpmAItDA
	 uhgQH4BsEMvjA==
Date: Wed, 15 May 2024 11:53:53 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net 1/2] ice: Interpret .set_channels() input differently
Message-ID: <20240515105353.GI154012@kernel.org>
References: <20240514-iwl-net-2024-05-14-set-channels-fixes-v1-0-eb18d88e30c3@intel.com>
 <20240514-iwl-net-2024-05-14-set-channels-fixes-v1-1-eb18d88e30c3@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514-iwl-net-2024-05-14-set-channels-fixes-v1-1-eb18d88e30c3@intel.com>

On Tue, May 14, 2024 at 11:51:12AM -0700, Jacob Keller wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> A bug occurs because a safety check guarding AF_XDP-related queues in
> ethnl_set_channels(), does not trigger. This happens, because kernel and
> ice driver interpret the ethtool command differently.
> 
> How the bug occurs:
> 1. ethtool -l <IFNAME> -> combined: 40
> 2. Attach AF_XDP to queue 30
> 3. ethtool -L <IFNAME> rx 15 tx 15
>    combined number is not specified, so command becomes {rx_count = 15,
>    tx_count = 15, combined_count = 40}.
> 4. ethnl_set_channels checks, if there are any AF_XDP of queues from the
>    new (combined_count + rx_count) to the old one, so from 55 to 40, check
>    does not trigger.
> 5. ice interprets `rx 15 tx 15` as 15 combined channels and deletes the
>    queue that AF_XDP is attached to.
> 
> Interpret the command in a way that is more consistent with ethtool
> manual [0] (--show-channels and --set-channels).
> 
> Considering that in the ice driver only the difference between RX and TX
> queues forms dedicated channels, change the correct way to set number of
> channels to:
> 
> ethtool -L <IFNAME> combined 10 /* For symmetric queues */
> ethtool -L <IFNAME> combined 8 tx 2 rx 0 /* For asymmetric queues */
> 
> [0] https://man7.org/linux/man-pages/man8/ethtool.8.html
> 
> Fixes: 87324e747fde ("ice: Implement ethtool ops for channels")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>



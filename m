Return-Path: <netdev+bounces-46048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CD77E1011
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 16:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D961C20957
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33CF1C68A;
	Sat,  4 Nov 2023 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFbreeA4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79231BDD9
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 15:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C433C433C7;
	Sat,  4 Nov 2023 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699111537;
	bh=RXC0aVEzXpNQmrr7IVwVsn2Tuc9ENbNnCqjKZnXeNuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vFbreeA4celmK7CrhDLD7TDVutpD9Zl/06XOmuhANy00F0FjW+htciPxTCMz9PbTt
	 C7ht5vYsiO+I5zEuFao7Cc1PDhw3sagdQAdSbFOUolNDVNiYl2+/rX+O0Q/QmRzsR8
	 s6VR94JRGX9eBaDNb1iI3yhK8iZATpW7S2BUS4pipVtB2zHvGnZOsOTJFI6Ntee0Rn
	 OwPS2hbvSQpEGcvfiBWV0W6COmLAPqFf/Y4PC83rYFiqy4ICx99yfFMdL1bmdvoQhd
	 7ir2RMNGXTWeqpkDtGCPfn0fzEGCvueXn4Buco5G5HwoLVjIBWgENif4f8pRnWvaRI
	 DDqLO3yUZoXxA==
Date: Sat, 4 Nov 2023 11:25:23 -0400
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH iwl-net 3/3] ice: restore timestamp configuration after
 device reset
Message-ID: <20231104152523.GI891380@kernel.org>
References: <20231103234658.511859-1-jacob.e.keller@intel.com>
 <20231103234658.511859-4-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103234658.511859-4-jacob.e.keller@intel.com>

On Fri, Nov 03, 2023 at 04:46:58PM -0700, Jacob Keller wrote:
> The driver calls ice_ptp_cfg_timestamp() during ice_ptp_prepare_for_reset()
> to disable timestamping while the device is resetting. This operation
> destroys the user requested configuration. While the driver does call
> ice_ptp_cfg_timestamp in ice_rebuild() to restore some hardware settings
> after a reset, it unconditionally passes true or false, resulting in
> failure to restore previous user space configuration.
> 
> This results in a device reset forcibly disabling timestamp configuration
> regardless of current user settings.
> 
> This was not detected previously due to a quirk of the LinuxPTP ptp4l
> application. If ptp4l detects a missing timestamp, it enters a fault state
> and performs recovery logic which includes executing SIOCSHWTSTAMP again,
> restoring the now accidentally cleared configuration.
> 
> Not every application does this, and for these applications, timestamps
> will mysteriously stop after a PF reset, without being restored until an
> application restart.
> 
> Fix this by replacing ice_ptp_cfg_timestamp() with two new functions:
> 
> 1) ice_ptp_disable_timestamp_mode() which unconditionally disables the
>    timestamping logic in ice_ptp_prepare_for_reset() and ice_ptp_release()
> 
> 2) ice_ptp_restore_timestamp_mode() which calls
>    ice_ptp_restore_tx_interrupt() to restore Tx timestamping configuration,
>    calls ice_set_rx_tstamp() to restore Rx timestamping configuration, and
>    issues an immediate TSYN_TX interrupt to ensure that timestamps which
>    may have occurred during the device reset get processed.
> 
> Modify the ice_ptp_set_timestamp_mode to directly save the user
> configuration and then call ice_ptp_restore_timestamp_mode. This way, reset
> no longer destroys the saved user configuration.
> 
> This obsoletes the ice_set_tx_tstamp() function which can now be safely
> removed.
> 
> With this change, all devices should now restore Tx and Rx timestamping
> functionality correctly after a PF reset without application intervention.
> 
> Fixes: 77a781155a65 ("ice: enable receive hardware timestamping")
> Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>



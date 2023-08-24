Return-Path: <netdev+bounces-30381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837147870D9
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14172815D0
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A92100C5;
	Thu, 24 Aug 2023 13:51:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657428904
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D787C433C7;
	Thu, 24 Aug 2023 13:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692885110;
	bh=IGrWYq/ZXmDjQ6zqpDz+u4Qc6Ytf4FoiHtj5an9v9hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ke9N6X77gHD0roWs3QMIT4U7Ywbm9BSbYE6C9DsAZzYk+DBrZSUVhivAZ8rHL/AFq
	 /ou1Vr58UJmDyAcXNflwznxXQdcQyLeYylTpcP4Ha5yDGqajJHLBL1QcHcrTRL0o7i
	 DKWWJLbo1acxBvfPYEHsY2ICxvKz0t66nIrxfj9Jkn3rNVzuI4aDHMz+ISK05atZHn
	 yRxDD5N4kg8+uvE9mGEEFMfQqxP1fTeoffo5ZpAZbK5P98MJAOkUcu5lWLh9I/Wkaz
	 THWqNpasZ5foE4j+0ijTEgfRfA8TlPOgfF0bv2wVZpE+Nm+VtwKaxCGuiGzdqFNNHi
	 ieAfdBe4onQJw==
Date: Thu, 24 Aug 2023 15:51:39 +0200
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>, richardcochran@gmail.com,
	Siddaraju DH <siddaraju.dh@intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: Re: [PATCH net] ice: avoid executing commands on other ports when
 driving sync
Message-ID: <20230824135139.GH3523530@kernel.org>
References: <20230823151814.3492480-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823151814.3492480-1-anthony.l.nguyen@intel.com>

On Wed, Aug 23, 2023 at 08:18:14AM -0700, Tony Nguyen wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice hardware has a synchronization mechanism used to drive the
> simultaneous application of commands on both PHY ports and the source timer
> in the MAC.
> 
> When issuing a sync via ice_ptp_exec_tmr_cmd(), the hardware will
> simultaneously apply the commands programmed for the main timer and each
> PHY port. Neither the main timer command register, nor the PHY port command
> registers auto clear on command execution.
> 
> During the execution of a timer command intended for a single port on E822
> devices, such as those used to configure a PHY during link up, the driver
> is not correctly clearing the previous commands.
> 
> This results in unintentionally executing the last programmed command on
> the main timer and other PHY ports whenever performing reconfiguration on
> E822 ports after link up. This results in unintended side effects on other
> timers, depending on what command was previously programmed.
> 
> To fix this, the driver must ensure that the main timer and all other PHY
> ports are properly initialized to perform no action.
> 
> The enumeration for timer commands does not include an enumeration value
> for doing nothing. Introduce ICE_PTP_NOP for this purpose. When writing a
> timer command to hardware, leave the command bits set to zero which
> indicates that no operation should be performed on that port.
> 
> Modify ice_ptp_one_port_cmd() to always initialize all ports. For all ports
> other than the one being configured, write their timer command register to
> ICE_PTP_NOP. This ensures that no side effect happens on the timer command.
> 
> To fix this for the PHY ports, modify ice_ptp_one_port_cmd() to always
> initialize all other ports to ICE_PTP_NOP. This ensures that no side
> effects happen on the other ports.
> 
> Call ice_ptp_src_cmd() with a command value if ICE_PTP_NOP in
> ice_sync_phy_timer_e822() and ice_start_phy_timer_e822().
> 
> With both of these changes, the driver should no longer execute a stale
> command on the main timer or another PHY port when reconfiguring one of the
> PHY ports after link up.
> 
> Fixes: 3a7496234d17 ("ice: implement basic E822 PTP support")
> Signed-off-by: Siddaraju DH <siddaraju.dh@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>



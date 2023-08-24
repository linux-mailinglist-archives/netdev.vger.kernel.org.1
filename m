Return-Path: <netdev+bounces-30417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA9578722D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8D42815B5
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 14:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E82B1119B;
	Thu, 24 Aug 2023 14:49:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE011288EC
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 14:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FF9C433C8;
	Thu, 24 Aug 2023 14:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692888562;
	bh=JHO5XVOq1X6JltauUfgGpAsDE8mIiAO0JKHrq9w2P0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZEKa14a2pU3qdt6cIfXE0T6L6Jt2XAUlYGZg/NGIgjLhxfzULY+xbVl+xj+BVd8t
	 3mKXVe+t82h4PkBYF6uZGU4jNNdFMCSUSZF+YbPiSITfQrLPIVbVlG1JscGSzLSQln
	 kCOtDmgpuQ+0A4V2n97TTe7ZTMbIPSCwg3R0ggKW/vtvHaW2U9xJg8nnN+ZFMAi7q1
	 IH62qNNeL831aguE44N9VkyLM9JuO0Bn44a0BcJH/tsOzBW3h5UGNWLZ54o8JuW7Hd
	 szDC4nkcSW7nphXx8HELPuQXUnH7S+cxrmtc8OGNshDgSwS9itTyBS6VsTMjkcaHBs
	 87xhZyOqjn1xA==
Date: Thu, 24 Aug 2023 16:49:07 +0200
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Mark Rustad <mark.d.rustad@intel.com>,
	Darin Miller <darin.j.miller@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net] ixgbe: fix timestamp configuration code
Message-ID: <20230824144907.GI3523530@kernel.org>
References: <20230823221537.816541-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823221537.816541-1-vadim.fedorenko@linux.dev>

On Wed, Aug 23, 2023 at 11:15:37PM +0100, Vadim Fedorenko wrote:
> The commit in fixes introduced flags to control the status of hardware
> configuration while processing packets. At the same time another structure
> is used to provide configuration of timestamper to user-space applications.
> The way it was coded makes this structures go out of sync easily. The
> repro is easy for 82599 chips:
> 
> [root@hostname ~]# hwstamp_ctl -i eth0 -r 12 -t 1
> current settings:
> tx_type 0
> rx_filter 0
> new settings:
> tx_type 1
> rx_filter 12
> 
> The eth0 device is properly configured to timestamp any PTPv2 events.
> 
> [root@hostname ~]# hwstamp_ctl -i eth0 -r 1 -t 1
> current settings:
> tx_type 1
> rx_filter 12
> SIOCSHWTSTAMP failed: Numerical result out of range
> The requested time stamping mode is not supported by the hardware.
> 
> The error is properly returned because HW doesn't support all packets
> timestamping. But the adapter->flags is cleared of timestamp flags
> even though no HW configuration was done. From that point no RX timestamps
> are received by user-space application. But configuration shows good
> values:
> 
> [root@hostname ~]# hwstamp_ctl -i eth0
> current settings:
> tx_type 1
> rx_filter 12
> 
> Fix the issue by applying new flags only when the HW was actually
> configured.
> 
> Fixes: a9763f3cb54c ("ixgbe: Update PTP to support X550EM_x devices")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>



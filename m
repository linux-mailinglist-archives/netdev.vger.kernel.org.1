Return-Path: <netdev+bounces-48731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ECC7EF5BA
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B136EB209B7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA21632C76;
	Fri, 17 Nov 2023 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7w/wMwB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02BA49F9A
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99717C433C9;
	Fri, 17 Nov 2023 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700236423;
	bh=5sv8AgB+c3zuhrgWq7AbigyX4SovbkctenvH7VkPmvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7w/wMwBeZCE8OeSBdDQThcWVBtITP4HrDu4mQ0enbndkMiK+W75I8Eb+vhddzFg5
	 vWXQYUz3ab2sFk4Ri3jOBtz8x55Fhdxej0iCOdfLfU0M/6WCJ16x7Csg+yZ5XUQ97m
	 MqwQoBoTJOC1OXyvuApzxnYAmwA3r7lKDIgSqtVHLDgoKwyTSN58E1wEUdTjuTXL4X
	 jLfHs7/rwtMSvJe/vMywooOdZluovl0+4nzxaXMHykwrJniL0eyPVv0EUxsE7+Y/wi
	 taXuErPRPcqQQq/Cd7CWOpR0lXYXBE3EYmOTwt/Jt5m/mtVTAkGA9CqzAFWhpL4IbX
	 iAsLRXgJ9m8gQ==
Date: Fri, 17 Nov 2023 15:53:39 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next 12/14] mlxsw: pci: Add support for new reset flow
Message-ID: <20231117155339.GM164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <2b6629170e815abed5dfc7f560a69a1accaeb1f2.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b6629170e815abed5dfc7f560a69a1accaeb1f2.1700047319.git.petrm@nvidia.com>

On Wed, Nov 15, 2023 at 01:17:21PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The driver resets the device during probe and during a devlink reload.
> The current reset method reloads the current firmware version or a
> pending one, if one was previously flashed using devlink. However, the
> current reset method does not result in a PCI hot reset, preventing the
> PCI firmware from being upgraded, unless the system is rebooted.
> 
> To solve this problem, a new reset command (6) was implemented in the
> firmware. Unlike the current command (1), after issuing the new command
> the device will not start the reset immediately, but only after a PCI
> hot reset.
> 
> Implement the new reset method by first verifying that it is supported
> by the current firmware version by querying the Management Capabilities
> Mask (MCAM) register. If supported, issue the new reset command (6) via
> MRSR register followed by a PCI reset by calling
> __pci_reset_function_locked().
> 
> Once the PCI firmware is operational, go back to the regular reset flow
> and wait for the entire device to become ready. That is, repeatedly read
> the "system_status" register from the BAR until a value of "FW_READY"
> (0x5E) appears.
> 
> Tested:
> 
>  # for i in $(seq 1 10); do devlink dev reload pci/0000:01:00.0; done
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>



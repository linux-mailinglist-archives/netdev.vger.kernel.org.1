Return-Path: <netdev+bounces-55611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0423380BA80
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 12:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CB41F20F93
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 11:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50768883A;
	Sun, 10 Dec 2023 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOxVeJgH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7ED8BE1
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 11:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5138C433C7;
	Sun, 10 Dec 2023 11:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702209013;
	bh=nQSIKETL4cIFCIbVW5Lsz+1L3/MB2QWHSDc0NxIJQEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MOxVeJgHOOMRna/HW4cFKZIIYcRQqETPNwvF0zXDgqFI4dn5tqk2147+EmWvmlrXd
	 BC+uXMXZ++0JryrqSN6UURjhctB9bjEdTl2fGWg3y8C2vaGWHaxeUu0hyDgrOjj9Qj
	 HlxcwYAlJgdjgYtuTAaADFDOp97yM7/UvQ/Y74W+K0tWh0fkg4NCw5cgJgGY4fo9Lh
	 4TNrR+hDMQktsBtbO6aEAcEmL4m5m5JT5k9/cBQMPXlie4jQa7L0JYYGpaniHQ6xWv
	 M+XGKG29AMwq7oufZgeodGnYWy6SZhUtxJ+HzRHY9QjhTfo54ItvdCFuxqmx3ZAceV
	 HasXGRxeMLMjw==
Date: Sun, 10 Dec 2023 11:50:07 +0000
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Suman Ghosh <sumang@marvell.com>
Subject: Re: [PATCH iwl-net] igc: Check VLAN EtherType mask
Message-ID: <20231210115007.GH5817@kernel.org>
References: <20231206140718.57433-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206140718.57433-1-kurt@linutronix.de>

On Wed, Dec 06, 2023 at 03:07:18PM +0100, Kurt Kanzenbach wrote:
> Currently the driver accepts VLAN EtherType steering rules regardless of
> the configured mask. And things might fail silently or with confusing error
> messages to the user. The VLAN EtherType can only be matched by full
> mask. Therefore, add a check for that.
> 
> For instance the following rule is invalid, but the driver accepts it and
> ignores the user specified mask:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 \
> |             m 0x00ff action 0
> |Added rule with ID 63
> |root@host:~# ethtool --show-ntuple enp3s0
> |4 RX rings available
> |Total 1 rules
> |
> |Filter: 63
> |        Flow Type: Raw Ethernet
> |        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Ethertype: 0x0 mask: 0xFFFF
> |        VLAN EtherType: 0x8100 mask: 0x0
> |        VLAN: 0x0 mask: 0xffff
> |        User-defined: 0x0 mask: 0xffffffffffffffff
> |        Action: Direct to queue 0
> 
> After:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan-etype 0x8100 \
> |             m 0x00ff action 0
> |rmgr: Cannot insert RX class rule: Operation not supported
> 
> Fixes: 2b477d057e33 ("igc: Integrate flex filter into ethtool ops")
> Suggested-by: Suman Ghosh <sumang@marvell.com>
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Reviewed-by: Simon Horman <horms@kernel.org>



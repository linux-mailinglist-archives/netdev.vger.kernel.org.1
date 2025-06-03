Return-Path: <netdev+bounces-194723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7248ACC22B
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7243A4AC2
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C127FD7A;
	Tue,  3 Jun 2025 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7YiE7or"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE75A1F3BBB
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939341; cv=none; b=gY39APqWdsVugoYKvPcT4mfdrNFNYwq/xdoPZiaOGs2oqURfC5o4t98sD3dT4LNQQCxBcy9GC+qQZ+hLha6UoeJLKA8y+5+6FaZiHnTY1uSqWgx+poF2CmiAZvKjLY5nYqqNXXZicyIxZUgUzBE3S00zrXpuEN6uinXX7yYJV4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939341; c=relaxed/simple;
	bh=a1/ue7BjPqlrTpKB1WNmGqITAW8iZLDxEbRgvPgsB4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr9vBe+AxGDVQ5y8EbePL3tKaAN3QHe4RCtdoijwL43s16igZkdexGyvhzgcDf9TMn4akFfyWJ7ziERAskC9Y0QByGi+Zw1uLoKyqfFG7GtmgMHY1PKOr5de2iQZaGkKVvGrOc7+cWiKIguUxdeNgBxzVeQhvqKZ3jJuZSSQ6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7YiE7or; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474B4C4CEED;
	Tue,  3 Jun 2025 08:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748939341;
	bh=a1/ue7BjPqlrTpKB1WNmGqITAW8iZLDxEbRgvPgsB4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7YiE7orxmHDTrenSRi1QIs5Kn5FsxEnovCPGCXOsH6I+0eVIOmzmUq8U7EiOrnR6
	 KO9LTU1OjkKvG20T2uwif1HEqQ4xMCM+EDiX7LA9dT68M6SwueR0J7roQpV0Ca2PFF
	 NIj+7SzwS1uJgi63niZnf1Vk9+exaozfZoDtnPjZ6NojMDQB4Da328Nbv9qACVf6rK
	 bGLmxBMR2QeK7DMYtp502pTK6hMqcvMagj8sa4SDqzWzluQP1sEOw16PfCP+nZKbSj
	 Uju4ieRXJ5CTwSDaHpx/dNMp7/c+2pGpqxxlxQP3BVN7uzqvJ0NoRKUsrRptOGw0tA
	 DaJToLXVFnFDQ==
Date: Tue, 3 Jun 2025 09:28:57 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] net: airoha: Fix IPv6 hw acceleration in
 bridge mode
Message-ID: <20250603082857.GB1484967@horms.kernel.org>
References: <20250602-airoha-flowtable-ipv6-fix-v2-0-3287f8b55214@kernel.org>
 <20250602-airoha-flowtable-ipv6-fix-v2-2-3287f8b55214@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602-airoha-flowtable-ipv6-fix-v2-2-3287f8b55214@kernel.org>

On Mon, Jun 02, 2025 at 12:55:38PM +0200, Lorenzo Bianconi wrote:
> ib2 and airoha_foe_mac_info_common have not the same offsets in
> airoha_foe_bridge and airoha_foe_ipv6 structures. Current codebase does
> not accelerate IPv6 traffic in bridge mode since ib2 and l2 info are not
> set properly copying airoha_foe_bridge struct into airoha_foe_ipv6 one
> in airoha_ppe_foe_commit_subflow_entry routine.
> Fix IPv6 hw acceleration in bridge mode resolving ib2 and
> airoha_foe_mac_info_common overwrite in
> airoha_ppe_foe_commit_subflow_entry() and configuring them with proper
> values.
> 
> Fixes: cd53f622611f ("net: airoha: Add L2 hw acceleration support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>



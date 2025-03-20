Return-Path: <netdev+bounces-176526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EA6A6AA7B
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D5B3B1FD1
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A7C1922C0;
	Thu, 20 Mar 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWPfVE0U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F9B38F9C
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486432; cv=none; b=lNrXrJHUXpOq5RSSGQwO/RCp4X/d1+0WAqBG41L0qR5r/WhWJmiYxTGWPaHO3eoJ9MqwVnkJtQ75tb/OsXfNi3uPb26mqZ4gbTNiIKpZQaTuu+PzoBaVlbtLKmvfYbfN1Xq/QoTWt/fSpquMkkBiUTNlBtqU/M2rmv9DFL/YDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486432; c=relaxed/simple;
	bh=DXEp31z/GWa1Pb3kBBSYSrPKxKsFGo3rMsH9KDRSpKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeM8vfEgfme/okBB+gmDDx/zSM06KRetcPaJanDYKEl+NAiepdp+Jmlur0Dq4fxC5TaXcJzHrodRa1hq8FJiDgaFQn/5REPiEqMKl+/Dc2G0PxB/X0nzysK5gCg5MV0GdcIKMoZLuJoQAEyTMyOICAmpzbGrJMA2l3xwgPijTQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWPfVE0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAFEC4CEE8;
	Thu, 20 Mar 2025 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486432;
	bh=DXEp31z/GWa1Pb3kBBSYSrPKxKsFGo3rMsH9KDRSpKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZWPfVE0Ur6FEvCauXPVluWcRUOeWXSyuVtVYFVlawdb0lLkBfpCSvNafdbb4KJUDu
	 GhvukdNc7VJs/IBql/WQQi4iSrFcBEyhAC8JcB0xmVAF79j4ZGtsPkI16FQKVV0Rrt
	 WxWsPRHYHZ9J4LC5262i5SdBJ3Myd3DiUfnD3ZxGBf4fcTVz3G0XFF8J4c1V4anDnG
	 dypZgaY7EwMdtyaOOxF/7GsLj4xBJOejSk0ZqK5rreZCMvJZKdtZbTwrOydn5IoptP
	 xmDAIGrNirtx2dTn88IzmVOGi4LFJnNR3z+zNb86zfCJI37CZZ3nZk0vch8yCrDpZH
	 Y/HVg5EbP3XdQ==
Date: Thu, 20 Mar 2025 16:00:27 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	mlxsw@nvidia.com, Vladimir Oltean <olteanv@gmail.com>,
	Vladyslav Mykhaliuk <vmykhaliuk@nvidia.com>
Subject: Re: [PATCH net-next 5/6] mlxsw: Add VXLAN bridge ports to same
 hardware domain as physical bridge ports
Message-ID: <20250320160027.GH889584@horms.kernel.org>
References: <cover.1742224300.git.petrm@nvidia.com>
 <7279056843140fae3a72c2d204c7886b79d03899.1742224300.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7279056843140fae3a72c2d204c7886b79d03899.1742224300.git.petrm@nvidia.com>

On Mon, Mar 17, 2025 at 06:37:30PM +0100, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> When hardware floods packets to bridge ports, but flooding to VXLAN bridge
> port fails during encapsulation to one of the remote VTEPs, the packets are
> trapped to CPU. In such case, the packets are marked with
> skb->offload_fwd_mark, which means that packet was L2-forwarded in
> hardware. Software data path repeats flooding, but packets which are
> marked with skb->offload_fwd_mark will not be flooded by the bridge to
> bridge ports which are in the same hardware domain as the ingress port.
> 
> Currently, mlxsw does not add VXLAN bridge ports to the same hardware
> domain as physical bridge ports despite the fact that the device is able
> to forward packets to and from VXLAN tunnels in hardware. In some scenarios
> (as mentioned above) this can result in remote VTEPs receiving duplicate
> packets. The packets are first flooded by hardware and after an
> encapsulation failure, they are flooded again to all remote VTEPs by
> software.
> 
> Solve this by adding VXLAN bridge ports to the same hardware domain as
> physical bridge ports, so then nbp_switchdev_allowed_egress() will return
> false also for VXLAN, and packets will not be sent twice from VXLAN device.
> 
> switchdev_bridge_port_offload() should get vxlan_dev not as const, so
> some changes are required. Call switchdev API from
> mlxsw_sp_bridge_vxlan_{join,leave}() which handle offload configurations.
> 
> Reported-by: Vladimir Oltean <olteanv@gmail.com>
> Closes: https://lore.kernel.org/all/20250210152246.4ajumdchwhvbarik@skbuf/
> Reported-by: Vladyslav Mykhaliuk <vmykhaliuk@nvidia.com>
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>



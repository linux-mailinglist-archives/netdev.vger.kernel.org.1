Return-Path: <netdev+bounces-176522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 606C1A6AA6E
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DF61897169
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AC81EB183;
	Thu, 20 Mar 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1jmIOYI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528F71E3DC4
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486279; cv=none; b=Ds6wRb4RKumeSg8tfSoRgQzzxG9VND/xtpM8+tkavSg7NQRt3kumSBe4gk5y7N5fsrAnWs7ZE3Ali5+6bTDeevVgf5m+PiwY98gw5XQPBHtO4ZPqg80XLwsZyhHu5DsZITrtTXLK/KZ7H3CUqOoZpoX0i0bvNwKLAs46FBHr/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486279; c=relaxed/simple;
	bh=Nmg9UA4bevEVe+SEX5HkoobPKgZ1BJv14Z6voMs/tsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u01IvlNMMyEz5MgO0FLFSNg4RuIOMysn+e8kuSQ5YrPmCBuTbTwiWJiDb5PKENjkG8i4vranzdw0ArTrZXNRYjMj8hyF0MOK+tKDa/p6gk27NMcrVyTWcaQi9Ymi8o1zFiX5+oeQq45Nwas+PpHUwMowZ6n1kxE9JR59LowCUZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1jmIOYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EAEC4CEDD;
	Thu, 20 Mar 2025 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486278;
	bh=Nmg9UA4bevEVe+SEX5HkoobPKgZ1BJv14Z6voMs/tsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1jmIOYIOhikswfN+aSIyHhg+fRDqZcGz/GKH/HFJyHb2/4zIOcpzrEsqeGOXdUNI
	 ko37CM2DPvokzj54eIVa9j4uigtoQO6x6JqKXO0KFXVzafBZadnokEZrFwdb/mzopE
	 Xw22aTQ2ukZV4dUpyFwQQItK2/YmSv9wtfBkjPhJKr+RJ1tuIr+6B4B44F/kqIbu9+
	 a6NiKq92ey1jndo5Aq3Nk5ZRKp5hPthtFO4iQU3w8AP2oNizVbD2etnlTk5IkhOIgu
	 B7CgHqn5YNaSRXDV4YhoYhIoG2vRnX7XSTQfOLE2w78mbrwnDTseXhad7H4F2s3Rul
	 B73OLKNxjzQZQ==
Date: Thu, 20 Mar 2025 15:57:54 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 1/6] mlxsw: Trap ARP packets at layer 2 instead
 of layer 3
Message-ID: <20250320155754.GD889584@horms.kernel.org>
References: <cover.1742224300.git.petrm@nvidia.com>
 <b2a2cc607a1f4cb96c10bd3b0b0244ba3117fd2e.1742224300.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2a2cc607a1f4cb96c10bd3b0b0244ba3117fd2e.1742224300.git.petrm@nvidia.com>

On Mon, Mar 17, 2025 at 06:37:26PM +0100, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Next patch will set the same hardware domain for all bridge ports,
> including VXLAN, to prevent packets from being forwarded by software when
> they were already forwarded by hardware.
> 
> ARP packets are not flooded by hardware to VXLAN, so software should handle
> such flooding. When hardware domain of VXLAN device will be changed, ARP
> packets which are trapped and marked with offload_fwd_mark will not be
> flooded to VXLAN also in software, which will break VXLAN traffic.
> 
> To prevent such breaking, trap ARP packets at layer 2 and don't mark them
> as L2-forwarded in hardware, then flooding ARP packets will be done only
> in software, and VXLAN will send ARP packets.
> 
> Remove NVE_ENCAP_ARP which is no longer needed, as now ARP packets are
> trapped when they enter the device.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>



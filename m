Return-Path: <netdev+bounces-176523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7D4A6AA74
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0A816444C
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48121EB1B4;
	Thu, 20 Mar 2025 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJFg6eRB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909041DE3B1
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486294; cv=none; b=aDrSngoZ2z4kcoLi6hiWnq7mHHZ7BCwqCDthRXEK+VxiIhirhF00xx4cqIXmXXaW7vs6j+r0a7ufomaljIUBOimdfpSQZMsRsGKkhlOnqQFy7ZFQ1fOsFIMqhb9Efm9SC2EWqGvAb5kxieGszffAOyX4U86WypRSFK6epavjvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486294; c=relaxed/simple;
	bh=kcqaWaumOxOGTUjyeHV2ylx4Os3nXY9dbZE8xGxNJcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgYZmoNE9P6G7xKdZUAsOH6HuPANnt7CIQHRcJJ8OzDvbBsbainEH7RBn+Rhh6tfX439aq6KCUtTmm/Z78ZTCiy11ywhqul9XoGaA9kae2QrkmJQpt/8k366ihtdUdLHVdvnYMKB6ueYjgkYtwI253o5zRp7+jo1jN6IEXJkvK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJFg6eRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A57C4CEDD;
	Thu, 20 Mar 2025 15:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486294;
	bh=kcqaWaumOxOGTUjyeHV2ylx4Os3nXY9dbZE8xGxNJcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJFg6eRBeWUtKq15himGoO7M+hDGGCHVzTyjV2N3nCLVbxy//37/+dJcdxfyFZIel
	 VVzD8q7ru+syJb7dBIRsuGI9XCO9JcBHao65mOuDR8JsWC97P491YW/lIc9x60MGIA
	 O7NK7Wx9iSQiKiFopd+rC09rkxubFqmVxJpczDqiv2MNUiR2uEAt8Hhn6xM1InUxD5
	 bD7l1Iiwm99DCbAlDo+kqkUCm2Evu9UB/Kb+26lxFKOZDgbpnRkWE8m5UIisl7MCMd
	 mz+Qq2lzDTxf4o0AVr4LFDvBXvSTC92Mdk7f0xtvqZaxW2fxA1v29StUfjQVdFLHoj
	 06UYHDoRg9xAg==
Date: Thu, 20 Mar 2025 15:58:10 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 2/6] mlxsw: spectrum: Call
 mlxsw_sp_bridge_vxlan_{join, leave}() for VLAN-aware bridge
Message-ID: <20250320155810.GE889584@horms.kernel.org>
References: <cover.1742224300.git.petrm@nvidia.com>
 <994c1ea93520f9ea55d1011cd47dc2180d526484.1742224300.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <994c1ea93520f9ea55d1011cd47dc2180d526484.1742224300.git.petrm@nvidia.com>

On Mon, Mar 17, 2025 at 06:37:27PM +0100, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> mlxsw_sp_bridge_vxlan_{join,leave}() are not called when a VXLAN device
> joins or leaves a VLAN-aware bridge. As mentioned in the comment - when the
> bridge is VLAN-aware, the VNI of the VXLAN device needs to be mapped to a
> VLAN, but at this point no VLANs are configured on the VxLAN device. This
> means that we can call the APIs, but there is no point to do that, as they
> do not configure anything in such cases.
> 
> Next patch will extend mlxsw_sp_bridge_vxlan_{join,leave}() to set hardware
> domain for VXLAN, this should be done also when a VXLAN device joins or
> leaves a VLAN-aware bridge. Call the APIs, which for now do not do anything
> in these flows.
> 
> Align the call to mlxsw_sp_bridge_vxlan_leave() to be called like
> mlxsw_sp_bridge_vxlan_join(), only in case that the VXLAN device is up,
> so move the check to be done before calling
> mlxsw_sp_bridge_vxlan_{join,leave}(). This does not change the existing
> behavior, as there is a similar check inside mlxsw_sp_bridge_vxlan_leave().
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>



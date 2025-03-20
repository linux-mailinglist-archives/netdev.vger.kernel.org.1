Return-Path: <netdev+bounces-176527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABE5A6AA8C
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCCA3B1C97
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EC1226D17;
	Thu, 20 Mar 2025 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hx5MSm0x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A005B226D12
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486449; cv=none; b=YmWc6vm1Hx/d8f3IckLZtKohE9AqIIp3dO+fpc16KDqwVcAONE4SwJB++jKGqUrfs7blyTYm9Qygzv/e/mF6q4Ty39ebbnz8FZTLdzbkg+udSG3y2xJpyfG0diE7goqrMmdqrdCM04xNJFr2iaTbdx1C6dFM5QoJAyZpF0cB8iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486449; c=relaxed/simple;
	bh=xU+se03DDls4bdI6qgMGMAZoymDg+1z9tGp3vgrjpS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1TllWoN98clzXOfcGtl4GMCMorpcck6pr2zIUGIxCyC5wRROAQcXQE0OelXfcmpQdXXPE7c9FhWoC7+NDnODKWtqK9SVyvcpdd84BU9LBMvvb1JdG8ze9XKfoHQ5RYuoHJ6apNIrTwjW1KPYrgvhGvLRzsHvTKM8ysCaM/0WeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hx5MSm0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D12AC4CEF0;
	Thu, 20 Mar 2025 16:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486449;
	bh=xU+se03DDls4bdI6qgMGMAZoymDg+1z9tGp3vgrjpS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hx5MSm0xQyMAtoRHL2DHqW6EEAxfCbrYUWxtyoHnUorK36vD88EBRRtO4TeNw1Yb6
	 ewribCrELVSyjuYWDD0Zigljq7CCG8zlgih3eP6OiCyJ8bliAMWBejDGPn57qwTX2J
	 Rk0UU8ZWP3dR0nucMN9ftLAByxsBHml6wXF/YR0SskYnNetuENy+g01ACN9MWfNiMs
	 BfEhwjlfVtk3km8TyAb1Dt8y+dGQVr++ULY8JZwQ7zV/mGEJawX1dgAS57gFSeDs8O
	 C/iN5yBZfizwF4C0ZeXj2aP/HjqWem9Ie49qoiWz8b2a1ciY9Ccg9g8P3vCMItJ7ZQ
	 74HxwHyoKKHgA==
Date: Thu, 20 Mar 2025 16:00:45 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 6/6] selftests: vxlan_bridge: Test flood with
 unresolved FDB entry
Message-ID: <20250320160045.GI889584@horms.kernel.org>
References: <cover.1742224300.git.petrm@nvidia.com>
 <7bc96e317531f3bf06319fb2ea447bd8666f29fa.1742224300.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bc96e317531f3bf06319fb2ea447bd8666f29fa.1742224300.git.petrm@nvidia.com>

On Mon, Mar 17, 2025 at 06:37:31PM +0100, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Extend flood test to configure FDB entry with unresolved destination IP,
> check that packets are not sent twice.
> 
> Without the previous patch which handles such scenario in mlxsw, the
> tests fail:
> 
> $ TESTS='test_flood' ./vxlan_bridge_1d.sh
> Running tests with UDP port 4789
> TEST: VXLAN: flood                                                  [ OK ]
> TEST: VXLAN: flood, unresolved FDB entry                            [FAIL]
>         vx2 ns2: Expected to capture 10 packets, got 20.
> 
> $ TESTS='test_flood' ./vxlan_bridge_1q.sh
> INFO: Running tests with UDP port 4789
> TEST: VXLAN: flood vlan 10                                          [ OK ]
> TEST: VXLAN: flood vlan 20                                          [ OK ]
> TEST: VXLAN: flood vlan 10, unresolved FDB entry                    [FAIL]
>         vx10 ns2: Expected to capture 10 packets, got 20.
> TEST: VXLAN: flood vlan 20, unresolved FDB entry                    [FAIL]
>         vx20 ns2: Expected to capture 10 packets, got 20.
> 
> With the previous patch, the tests pass.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>



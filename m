Return-Path: <netdev+bounces-163757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A072A2B7EC
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037C0167213
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2BD946C;
	Fri,  7 Feb 2025 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uiieyw83"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3297366;
	Fri,  7 Feb 2025 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738891903; cv=none; b=GOzbOzekoLcFBJuruJJDzVhoFGxau6HTxS3MdkB8+iRPvu+h5R2Xv/pyUX/G7O9z+eZ3TRCdn5jNmbbSSXinxz1S6C6Xwenf5ZwLKceGwlhZBjmWQnLtC3faAqH1BcCf3SZ/wbQPSp7L70vLJfePkB+9rzBIsEOxYePBVw5yNY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738891903; c=relaxed/simple;
	bh=L7C3tXXZKEUD7SVXq8iYXFdWMXHOWGFjV1TSk3xraAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIWVtQMLR7gWMoaYjQZ5s1ZlhHRjmy0VwQtN8/KWGyPR80VPMWRzI/YLv7wyg6unj9+T1TIpoyIYEXkBsALUcaouJ4KSxXW3LKMAM8SlSzpQiur/NVYEf+B0ZzPNwPWPeQC2fYA1LXpuS9eF8T+rkY9dZ3U9a6yK9YlzVi83n4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uiieyw83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2536C4CEDD;
	Fri,  7 Feb 2025 01:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738891903;
	bh=L7C3tXXZKEUD7SVXq8iYXFdWMXHOWGFjV1TSk3xraAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uiieyw834/Qh39Blryc6QexvoeUdMvDa4xQqgr7XdflgfjF/n4esn1DksUO++9ACy
	 6ah7EpXCKHR/ZnzW8ChL5nKsh1YK4I74o+DL/trSzL2QXYnoopuRlY5h7ZZu8L6/lA
	 Mkm174r83pFvqXHKsrFX16uIYIGiw1DiGrfMS1iHDTU0pB5Bh/i+q3IXj4hX2HsKUT
	 tgCLmwkztNNbvlwQMzAub6hNY89I69tmmTP/8q+/H2qUDyl0elXKGrY0p6l0mKixjJ
	 np48tBcB/b1qUbcy77ocrB2BwizmV3job+5NY/ArJ+9y4Km3b4/73NBNXr01kqh0zy
	 wigbIpaA1e6gQ==
Date: Thu, 6 Feb 2025 17:31:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Tariq
 Toukan" <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, <linux-doc@vger.kernel.org>, Cosmin Ratiu
 <cratiu@nvidia.com>
Subject: Re: [PATCH net-next v2 1/2] ethtool: Symmetric OR-XOR RSS hash
Message-ID: <20250206173142.79a9ef3c@kernel.org>
In-Reply-To: <20250205135341.542720-2-gal@nvidia.com>
References: <20250205135341.542720-1-gal@nvidia.com>
	<20250205135341.542720-2-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 15:53:40 +0200 Gal Pressman wrote:
> @@ -997,7 +996,7 @@ struct kernel_ethtool_ts_info {
>  struct ethtool_ops {
>  	u32     cap_link_lanes_supported:1;
>  	u32     cap_rss_ctx_supported:1;
> -	u32	cap_rss_sym_xor_supported:1;
> +	u32	supported_input_xfrm:8;
>  	u32	rxfh_per_ctx_key:1;
>  	u32	cap_rss_rxnfc_adds:1;
>  	u32	rxfh_indir_space;

reorder the fields, please, so the 8b one is aligned to a byte


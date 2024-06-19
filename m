Return-Path: <netdev+bounces-104688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D5690E0B4
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 02:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BCE28379A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B146EDB;
	Wed, 19 Jun 2024 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1Lv6eed"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467C17CD
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718756389; cv=none; b=u6yCQJZ+7o/L+dq51uveqmLjS+Av4FEv5wWjRUekOkEMax8Op3wQ1+9YH82eX2v+knY21yZzm+ErLr8QDiH+UGDru1NgCpuV7scX/c9PBKy7MBKMmuibZtQiwlD9DH4ojo7PcSdnrKOa0jgnnVWifbCZDiYxlIMIkkFW9ZVy/VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718756389; c=relaxed/simple;
	bh=gZkI9LBVm1lVxL8+QF6cOZew8P5NM1Bx6UI2d7JkMpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKB8AJsT6zjmU9SQOJsaudqwINDIqpi0QSnRN50zOPooAIK9MiH53nRPh050Sbdr9R9TbLWr7VlEces4Hzze7xt93NoWvTVXOGKyhOOG+Y0hzNJbMU0uMSkQIaEVrEUvFqnXiQHriTl/Des4thoCh0BF7Wc3T3/LHgRZsFFXQj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1Lv6eed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE33C4AF1D;
	Wed, 19 Jun 2024 00:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718756389;
	bh=gZkI9LBVm1lVxL8+QF6cOZew8P5NM1Bx6UI2d7JkMpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M1Lv6eedBmaAGf32SvcMGX4qjCnfpEM7iuejPPpqYkxEgRWg2G1xhBVUKNp5x4Cxi
	 GRx+ySRapACfijJFnfwYdv0PiZkXushNlJbaR3GPc25VsZzAbyvVf6auYLDCeQo+iS
	 zkbBEIBlyrK8mK6rE1qr1UI1oOMVz0hHDRA9QRRl0llVo8iYKwvroBBtHEFChktk7M
	 TSxOGAfJ/yy/kIxLV37AYsCZzQfVS1nVWQ6c32SxJiCUMu7umkoz7ht0NPzjDjI0wz
	 /6U6/NaQvf4RcDNW4Ezxtr8wlmr9yIxpyC4/TKTWflvJ+x7/nnmqe0p7rQtlp+w+Vl
	 Hn5W1iPGELl2g==
Date: Tue, 18 Jun 2024 17:19:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <edward.cree@amd.com>
Cc: <linux-net-drivers@amd.com>, <davem@davemloft.com>,
 <edumazet@google.com>, <pabeni@redhat.com>, Edward Cree
 <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
 <habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
 <jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
 <jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: Re: [PATCH v5 net-next 0/7] ethtool: track custom RSS contexts in
 the core
Message-ID: <20240618171947.4f85e6da@kernel.org>
In-Reply-To: <cover.1718750586.git.ecree.xilinx@gmail.com>
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 23:44:20 +0100 edward.cree@amd.com wrote:
> Make the core responsible for tracking the set of custom RSS contexts,
>  their IDs, indirection tables, hash keys, and hash functions; this
>  lets us get rid of duplicative code in drivers, and will allow us to
>  support netlink dumps later.
> 
> This series only moves the sfc EF10 & EF100 driver over to the new API;
>  other drivers (mvpp2, octeontx2, mlx5, sfc/siena) can be converted afterwards
>  and the legacy API removed.

LGTM!

I'll take a stab at bnxt conversion tomorrow. Do you have any tests 
or should I try to produce some as well?


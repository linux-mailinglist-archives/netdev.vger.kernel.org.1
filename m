Return-Path: <netdev+bounces-140847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A659B87CE
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E31A6B21F35
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 00:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64997EEC3;
	Fri,  1 Nov 2024 00:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY9jB+cj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42C28DD0
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 00:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422126; cv=none; b=EY+gbH0fA2fr18fEHSJ8XQrESX5iBBjJfmY6bja5QD+wAmn8T3wBizRaw99USpY5G6u8As3fBq7QG4YV6uC8dIAViuNTecHRfGl6csjxK+eIioh3OQ/P9ttubNY2PcpJTYfBNt52A2ilTADOf9ubfJ67vPnXeveFuPxgt2ECjUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422126; c=relaxed/simple;
	bh=LaPO27Sq7/kiqw8/iJ3/cxzNni5rxWPculCge19Cx+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwMDSJgsefCBTRb9y19OGUrMueem4HxTts3SMbjVRpLS9pKK9+vFcidN+jsL+Er13bv5krF5omfOo14mK2tjWFfYSQvnBHEBHd3Tp/En3yW1dWQywgd8bVuoeLqiGb8ZlFkqX8cjdxi3OIqIxEoBiA81P2SfQkoe6cIv0QGDMTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY9jB+cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C61C4CEC3;
	Fri,  1 Nov 2024 00:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730422125;
	bh=LaPO27Sq7/kiqw8/iJ3/cxzNni5rxWPculCge19Cx+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NY9jB+cjGop9j2ekdsa5EFlToIWYrAU9niY4WeEuD+f6GPscZ9w1GzKsDA5DEGxXf
	 F14TChZqcQG+BCnAPJHDNMe7JVM+TWO9vHGSJ8BI8QQqHffsf8eANrJOP9Xj4rHt5v
	 o+wLHFHnXoRFDEgMJsZYt1gtfJrFWz/hZA4x+fV5rsz/7Mn/tZEtvFcNpy3xy1Ta8W
	 STCkjo4CsxWrPV/LUZC5uihUze6IZMmIuxDWihBq0NqUndfX87tsQSPSDGXuJ+gFOL
	 BTGZtt8u42m2jYGzGIFDFWM0qvNnsBs5tXgfYdmjIk6RjHUoexvGAg0Su4v/wzgPVS
	 2arH7LKik0kuA==
Date: Thu, 31 Oct 2024 17:48:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Jay Vosburgh <jv@jvosburgh.net>, "Andy Gospodarek"
 <andy@greyhouse.net>, <netdev@vger.kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Boris Pismenny
 <borisp@nvidia.com>
Subject: Re: [PATCH net-next] bonding: add ESP offload features when slaves
 support
Message-ID: <20241031174844.06a5b110@kernel.org>
In-Reply-To: <20241024163112.298865-1-tariqt@nvidia.com>
References: <20241024163112.298865-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 19:31:12 +0300 Tariq Toukan wrote:
> +#ifdef CONFIG_XFRM_OFFLOAD
> +	if (gso_partial_features & NETIF_F_GSO_ESP)
> +		bond_dev->gso_partial_features |= NETIF_F_GSO_ESP;
> +	else
> +		bond_dev->gso_partial_features &= ~NETIF_F_GSO_ESP;
> +#endif /* CONFIG_XFRM_OFFLOAD */

Hiding the block under ifdef is unnecessary.
If you worry about the no-lower devs case - add IS_ENABLED()
to the if condition. The local variable doesn't have to be under
ifdef either (making it more rev xmas tree compatible)
-- 
pw-bot: cr


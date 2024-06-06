Return-Path: <netdev+bounces-101248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A04848FDD46
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 05:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA0C1F23014
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 03:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73F51DA21;
	Thu,  6 Jun 2024 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D99P3i1N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38921C68D
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 03:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717644021; cv=none; b=l5xP0Un/2mcrfA9MFN02EZGn69CbhlmALur4m/ZmunBqtU2fp+RPBqEso13yiftAxn0VGM//gD1brPpqP0M0g7hD64Kh9K1Jd3Xdz3IlDxprAUmiGxl42lwqKivFz30INtHU8yJmV7sdKAo0zjxdhhop5/33xx9dGfNZ5XLcOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717644021; c=relaxed/simple;
	bh=51BGBhrBzVjrxruhpYG9fwi6dgnnKAEIe9nftbsTn0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L25MhV7dirHS4cj+I0mFD1gZ70BghoIrzs8CFx+q2AjCGKPVS3cnhP1x0gKu4aZH6UkxHMLg8jBVv5No0K8Tk2wEucYUfWRhE2gda8leVJwmHvORVNkO2xlbB2RisE4mzbvh7JH22Cqj16Nl2OL1vXIRk5dVLFpeCepP1oEOwvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D99P3i1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDF3C3277B;
	Thu,  6 Jun 2024 03:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717644021;
	bh=51BGBhrBzVjrxruhpYG9fwi6dgnnKAEIe9nftbsTn0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D99P3i1Nuy4kslj71yR4xteg7JAWvO+Veuo4sCufOY8h+2+MF619PE/YAoripPEZu
	 zIKochCL7ZIDpcnLPvqXc/ljW1Ec5bwOhXX+zz/4xjXnbborXX713Au97OlPH81Wdn
	 I1cZcGA13LQQg3EWeU2broHzMZy8Hxt3E+iolTzD6oeYnli+SvTwqRiGQgxsHJuRzT
	 01Y5CprLKMWfZbQuLHADVvsdedH64fe4tQ6Oy61kcpn8Wz1/TUO08xhP+8mYaR3LWO
	 TAaZrsxGdKauyTfmlIFYd77GUs5p3Y07Fhzv6nuEr/bb/ytX7HffRj18R64hCMK4YR
	 /JAexR0vj1Zdw==
Date: Wed, 5 Jun 2024 20:20:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 02/14] net/mlx5e: SHAMPO, Fix incorrect page
 release
Message-ID: <20240605202019.740a1682@kernel.org>
In-Reply-To: <20240603212219.1037656-3-tariqt@nvidia.com>
References: <20240603212219.1037656-1-tariqt@nvidia.com>
	<20240603212219.1037656-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 00:22:07 +0300 Tariq Toukan wrote:
> Fixes: 6f5742846053 ("net/mlx5e: RX, Enable skb page recycling through the page_pool")

Why is this still here?! If the bad code path cannot be hit without
applying patches later in the series, it's not a fix. Let me remove
this for you when applying so y'all don't descend on me for "hating
vendors" :|


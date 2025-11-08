Return-Path: <netdev+bounces-236932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD2DC424AF
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 03:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63AB94E02CE
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 02:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696872BD5A1;
	Sat,  8 Nov 2025 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YT0zoP3D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DA63595D
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762568895; cv=none; b=LQfA8teRmzrxkFmX90I1OxYKKk+LmngjLtj6hTVbKQWgkdquUvvIZIO43P5GjSqxXd+svx7xm8zQ65FRlLlLttgOmcqze/Q0pWV6+riu5+XI8oQZuCuSPrhlZ+uJi2jSs7RllsGa7bEhWnkF7fzpurKPt7SVvkg6MQgdLFHf4Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762568895; c=relaxed/simple;
	bh=Ipu1sALFmRpDczKJrcFs7aekVXatfr1Ya4SQo264VQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HI/8ElyhYsnTDJ9z1wGuXyK2Xjhu/iU0OLDXwz6VZeFIGiP2sEdMvK7yMNNmzHtERQJoCkEU8meHlY12OR2sTFXAIdlcjvwcrE7PwDJ6EvKs/IZDSWRO9LPGF9ekjbYPlAwTIwNkucazYSqgjWxt+GLGaq72QzKh04L57LMWvVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YT0zoP3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48200C116B1;
	Sat,  8 Nov 2025 02:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762568894;
	bh=Ipu1sALFmRpDczKJrcFs7aekVXatfr1Ya4SQo264VQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YT0zoP3D793OAFdzpym5Vu3i+kfpTF0By5ggZ8N3y2kzqqvNFALoW5+P6usnFonKk
	 bgYDjuBbUR6bn9b84CvJYOBmYcfQNqE1ZVzpuN9C9o9/9wrP+iRUwGej5Rk2YdHRhi
	 MhRalosWg7Pob5RbX2Qa/QXYsEKUV1sC/2sDQ+eXPzEb605XpHUj1F/m52aDWrna3Z
	 BQJvkn18xZFyJ5TJZuk1Qtqp8idqgor3tiIBqAWeGaSrprvb3mGrkFRbEICsGmewHq
	 4cuFHyv7mv8b8PPvPWNt/4oSgn+SrG2taGVssyhvj5NJE/tQmRinTLwhG33Uye3rv4
	 2jtwpFjsMOOZg==
Date: Fri, 7 Nov 2025 18:28:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, mbloch@nvidia.com,
 Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: Re: [PATCH net-next V2 3/3] net/mlx5: E-Switch, support eswitch
 inactive mode
Message-ID: <20251107182813.737c2d73@kernel.org>
In-Reply-To: <20251107000831.157375-4-saeed@kernel.org>
References: <20251107000831.157375-1-saeed@kernel.org>
	<20251107000831.157375-4-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Nov 2025 16:08:31 -0800 Saeed Mahameed wrote:
> +	if (IS_ERR(table)) {
> +		esw_warn(dev, "Failed to create fdb drop root table, err %ld\n",
> +			 PTR_ERR(table));
> +		return PTR_ERR(table);
> +	}

cocci says:

drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c:2397:4-11: WARNING: Consider using %pe to print PTR_ERR()

While I have you, could you please help this one along (dare I say,
first, due to the extack propagation?):
https://lore.kernel.org/all/20251107204347.4060542-1-daniel.zahka@gmail.com/


Return-Path: <netdev+bounces-205637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CEEAFF71F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDE04E7CF0
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F4C28003A;
	Thu, 10 Jul 2025 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMCW4uqw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7B27FD70
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115983; cv=none; b=DCsEq6gn3nITMTeRso3om0Qnk/UIwUt9HkuZBzjdumhCyEi2HXJ/vFwjsCz5yg7RFDclKtMpx5Dyuqn5JwZ2mFNdGl/VSEMlCztuFLBR4lAF63LedtwBGZswczvARyYvuoaXpYe2J367ac/T79LMH91s75w+UcRpdfLcqgoYho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115983; c=relaxed/simple;
	bh=NMRmAK2KYP4WZcdZi+oNd7+9RY6uNkf4cScTHVvvcuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaMjpURXZpSwdgKac8oMYBTvKB3rJBbg40zkXlciTwar7hDy/fcyD+BDAC9T80vY4bk8iWrtG86SJKdpYXlthaLtYDenp2elsicHCckcZHqpcX32uBbAukc2MQEZksN2hxeE97bKuQBcZ5cytuvi2954D3XvVrr5qEB3B+eoiWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMCW4uqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD09C4CEF0;
	Thu, 10 Jul 2025 02:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752115982;
	bh=NMRmAK2KYP4WZcdZi+oNd7+9RY6uNkf4cScTHVvvcuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iMCW4uqw2AcntkLRaXGdOiVkb6mMcYOyiYBsj0bOnUNMV5245vDX4XHSi0JbRtd++
	 MTEzwEFHSR/jlGxuyGoobop5TYC+WdaWS2V+u8VXy7u1n7yAhYdf9CIFP7/xWikpyM
	 yl3sNaRCqyB2Y4QW1gUHFtNTrQHKf1rjLYzdDz1vU8qL3NGWIuZwyjyAaw66yPA60a
	 m5TE67BNcC88SaRvu2/5bONTwqfCE+6+aScdn9p5CL1yrVZVzF/JH3yXP1O12gc16Z
	 GV8OETGH1Dqc+Qa92jVgLhTCbJ3rlvFONJJkeXeWWSy/q//NvHLydnNajKexfTSaRh
	 Wup4Y0XD/i9gw==
Date: Wed, 9 Jul 2025 19:53:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next V6 02/13] net/mlx5: Implement cqe_compress_type
 via devlink params
Message-ID: <20250709195300.6d393e90@kernel.org>
In-Reply-To: <20250709030456.1290841-3-saeed@kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
	<20250709030456.1290841-3-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Jul 2025 20:04:44 -0700 Saeed Mahameed wrote:
> Selects which algorithm should be used by the NIC in order to decide rate of
> CQE compression dependeng on PCIe bus conditions.
> 
> Supported values:
> 
> 1) balanced, merges fewer CQEs, resulting in a moderate compression ratio
>    but maintaining a balance between bandwidth savings and performance
> 2) aggressive, merges more CQEs into a single entry, achieving a higher
>    compression rate and maximizing performance, particularly under high
>    traffic loads.

This description sounds like 'aggressive' always  wins. Higher
compression rate and higher performance. You gotta describe the trade
offs for the knobs.

> diff --git a/Documentation/networking/devlink/mlx5.rst b/Documentation/networking/devlink/mlx5.rst
> index 7febe0aecd53..417e5cdcd35d 100644
> --- a/Documentation/networking/devlink/mlx5.rst
> +++ b/Documentation/networking/devlink/mlx5.rst
> @@ -117,6 +117,15 @@ parameters.
>       - driverinit
>       - Control the size (in packets) of the hairpin queues.
>  
> +   * - ``cqe_compress_type``
> +     - string
> +     - permanent
> +     - Configure which algorithm should be used by the NIC in order to decide
> +       rate of CQE compression dependeng on PCIe bus conditions.
> +
> +       * ``balanced`` : Merges fewer CQEs, resulting in a moderate compression ratio but maintaining a balance between bandwidth savings and performance
> +       * ``aggressive`` : Merges more CQEs into a single entry, achieving a higher compression rate and maximizing performance, particularly under high traffic loads

Line wrap please.

You already have a rx_cqe_compress ethtool priv flag.
Why is this needed and how it differs.
Is it just the default value for the ethtool setting?
-- 
pw-bot: cr


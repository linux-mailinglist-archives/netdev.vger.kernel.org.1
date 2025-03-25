Return-Path: <netdev+bounces-177503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A763CA7057B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D31A18868B4
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83E81F4180;
	Tue, 25 Mar 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uePXdwJu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9013529408;
	Tue, 25 Mar 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917726; cv=none; b=Dza1AL3DdL5L8+s6DDYd+eB8ix9j0KZgPL3Nbq1lINPSwY5Z5lUvWOpF+FSbS2S0I2hCZh4IXrMYAWn4PSj8MO5P4uRsjrD9hR10VFPZA5NyqTcPH3PhjriqQX/ziFjIg/XKLH9nu8gLY9D6TNUIMONnjFkUH2AJJkLx+mIOukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917726; c=relaxed/simple;
	bh=lgFYb0M0FOCdrPbZDnsy5FgBGD6+fTkPJSrCvY5eB7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojMj9in+FR9pLqt+J5b+rdrAvUOjF0WpdENR9RliECWtOfgbgQMr0riVLYGWKDmk7eX5yEmHaWufEj4D4BzkR0IMbG90eaiH5KH/qGihYsmQtbG2wpVesgX2oRaGQDns8IOPqtjjBj/dEeDcnIzFNr9+FF7/Rhp9lpL18Ng/gp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uePXdwJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021BFC4CEE4;
	Tue, 25 Mar 2025 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742917726;
	bh=lgFYb0M0FOCdrPbZDnsy5FgBGD6+fTkPJSrCvY5eB7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uePXdwJusexbJkNd+xnwhk6qorNQxuL61iduRXcBD8FO/LLtZ7qS0aK3sRgce292s
	 qdcqRqWOqoVK+Y1XrH0eReJt5u/Qzu/jwaHl8Qk2d/7G0NSgp6xToQ6CAav48Fojam
	 BpjEEb9R+KenVDgPNM3WdQEY3UNy2fEFfdNwdgWBTQyJoiS8tvL2oSX4AQXaIQsWCv
	 FSZlM//BJISO6DkX945LKmo1dAY6Wl3GrTuFz3Ss5zCdeCe4WVvEiYTAIQ74xNxNh5
	 Gpm1JV1SKmJ/ti/+1WBVGhW1UAF77EYB1Ty4v/YjxNH+YTq0wwEF+AwQVZlx5hfDJq
	 hRa9K9nd4VXhQ==
Date: Tue, 25 Mar 2025 08:48:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net-next] netpoll: optimize struct layout for cache
 efficiency
Message-ID: <20250325084838.5b2fdd1c@kernel.org>
In-Reply-To: <20250324-netpoll_structstruct-v1-1-ff78f8a88dbb@debian.org>
References: <20250324-netpoll_structstruct-v1-1-ff78f8a88dbb@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 05:29:13 -0700 Breno Leitao wrote:
> The struct netpoll serves two distinct purposes: it contains
> configuration data needed only during setup (in netpoll_setup()), and
> runtime data that's accessed on every packet transmission (in
> netpoll_send_udp()).
> 
> Currently, this structure spans three cache lines with suboptimal
> organization, where frequently accessed fields are mixed with rarely
> accessed ones.
> 
> This commit reorganizes the structure to place all runtime fields used
> during packet transmission together in the first cache line, while
> moving the setup-only configuration fields to subsequent cache lines.
> This approach follows the principle of placing hot fields together for
> better cache locality during the performance-critical path.
> 
> The restructuring also eliminates structural inefficiencies, reducing
> the number of holes. This provides a more compact memory layout while
> maintaining the same functionality, resulting in better cache
> utilization and potentially improves performance during packet
> transmission operations.

Netpoll shouldn't send too many packets, "not too many" for networking
means >100kpps. So I don't think the hot / close split matters?

> 
>   -   /* sum members: 137, holes: 3, sum holes: 7 */
>   +   /* sum members: 137, holes: 1, sum holes: 3 */
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/netpoll.h | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
> index 0477208ed9ffa..a8de41d84be52 100644
> --- a/include/linux/netpoll.h
> +++ b/include/linux/netpoll.h
> @@ -24,7 +24,16 @@ union inet_addr {
>  
>  struct netpoll {
>  	struct net_device *dev;
> +	u16 local_port, remote_port;
>  	netdevice_tracker dev_tracker;

It's a little odd to leave the tracker in hot data, if you do it
should at least be adjacent to the pointer it tracks?

> +	union inet_addr local_ip, remote_ip;
> +	bool ipv6;
-- 
pw-bot: cr


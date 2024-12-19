Return-Path: <netdev+bounces-153200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38999F727F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 03:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3943B188940F
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55084DA04;
	Thu, 19 Dec 2024 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3iPITmM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B284D8DA;
	Thu, 19 Dec 2024 02:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734574070; cv=none; b=BA2fxzbraNFxDDNPfGPtQecdmqqboLjin06TekbMNj+ncvvBk03vASiym9xRc/3oEeeC4icWQZFior9NU9TQfckNAuQpx9q1jZxmL57gdGeYSthKCPsUmY3PwgRSShiw5yWhU26SMrionbOJeSoLg8wtwh/j6TxHXy/7NmHkYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734574070; c=relaxed/simple;
	bh=36B+m5KURsei4laSNTEVtEexBVoUvQ9cGdeoxZ4mogM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTYKiG1KsENSSHd3AsRS5gGlyTZJfPit97AocEUzPSnM0hSWAZrqBqVO+/bPquenFERsckV1tyvNv1X0d6CECsuXrh5zUUmfbNMIDFknHpuPtih9HFALd++mULGQuWSlNkt0kWRbm41gB4ZS+WUlH/agtiV80NbITcjef1NP2Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3iPITmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4AFC4CECD;
	Thu, 19 Dec 2024 02:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734574070;
	bh=36B+m5KURsei4laSNTEVtEexBVoUvQ9cGdeoxZ4mogM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h3iPITmMjKN2oiy5ppCO0gnGbzVfjJYMW6NwWH0bYFskHzOQBJsad61MGf3/7sIwi
	 UoFY6IYYrxCpMrVfEsLJGJuHwsgM9QeBppMzQgMXAc+QC7zY3o7kAAOj5/1mRTIa7z
	 TvstXdcue35xaqS8770rVoXN2oaBm2WcpFs3svL2k0UEFvy1ZjbH2nzLGqqwMPHX3i
	 WCY9HAykLHYKkltZNnAGHrdgIdkrlw/VySXaANEhrUTb9WfpAcUFffOl52gc9B6c1q
	 8ehrQpZdsPRZCehrTjQzN95ub4uw3DoKeQOKpli8n3OVjPI7sQxLjUHtKXB/PuhRJR
	 67Nz2vmxpcmRA==
Date: Wed, 18 Dec 2024 18:07:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me,
 asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com, Andy Gospodarek <gospo@broadcom.com>
Subject: Re: [PATCH net-next v6 1/9] bnxt_en: add support for rx-copybreak
 ethtool command
Message-ID: <20241218180747.1ff69015@kernel.org>
In-Reply-To: <20241218144530.2963326-2-ap420073@gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
	<20241218144530.2963326-2-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 14:45:22 +0000 Taehee Yoo wrote:
> +			if (netif_running(dev)) {
> +				bnxt_close_nic(bp, false, false);
> +				bp->rx_copybreak = rx_copybreak;
> +				bnxt_set_ring_params(bp);
> +				bnxt_open_nic(bp, false, false);

We really shouldn't allow this any more, we've been rejecting
patches which try to accept reconfiguration requests by taking
the entire NIC down, without any solid recovery if memory allocation
fails.

Let's return -EBUSY if interface is running.


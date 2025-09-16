Return-Path: <netdev+bounces-223517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3897DB5964C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14321BC09EB
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1388F2D8393;
	Tue, 16 Sep 2025 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwSS0rs3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7014658D
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026089; cv=none; b=UE0B2m/L85DUrLZM0Hgsq4MfIsCfnh+o/TkJdZrZY43Al0rFApJE5WPEmJioxlpnVWC4eJzcEPTzqUs8yOpKag3OUQ32Hwn3o36lL8WoGtgu1b6I46RO3h0ngBCX/SJImOrqrhy6L2LBW1f+vlmusin+fyTvv6H+t4sC0CGbD+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026089; c=relaxed/simple;
	bh=WTTAnbxVklt98ysGADcRykPM3syZlKDOfNqtfiExGMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+fgMEZhyfcRwTvD/n7c7vYaZg6ilslcsWYiaDJZgSy6uY4WGRh39gK+xn78sFErQhza0BaKLjcONtDAevfaNyUEnxU6aUxkKVNWp82B2hz3rFuBaYB3K6ScldtjD5dq8vkPY/Rm1aIotLVgmmbYu0MUPwZh+4+eViEDMN2c4RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwSS0rs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2962C4CEEB;
	Tue, 16 Sep 2025 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758026088;
	bh=WTTAnbxVklt98ysGADcRykPM3syZlKDOfNqtfiExGMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PwSS0rs3ZME6aPgcuZ7dZppr9pSFF6m3/gRTbhtetegSmiM6REjK8Dkec07eDg69Q
	 4og5zMk0GZ8A3aBYBIOuTbx/N9p85zGbpexx/u8HFcdRcl/AuqWN+xd+J7buDm6fzz
	 7wSHSh/6Vqk0nnUS933aBhI9Hr5ixX61rlol6ntV21KUtCqED16GRofIcUC5+4jazZ
	 XqCsIMUvoGRIipzlJXY5hQUQ+A87hsLl41qrXpuKiTE1Y9MgexAAGpwgJzQp1o0pwT
	 4nO04DjTNp1sruI3wiO0CXjYw4HcRq4XyV0VuzikcfiQ8W5EIbRnrhJR3g7itWIRoP
	 ktEm57o00VASA==
Date: Tue, 16 Sep 2025 13:34:44 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, alexanderduyck@fb.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next v2 2/9] eth: fbnic: use fw uptime to detect fw
 crashes
Message-ID: <20250916123444.GA224143@horms.kernel.org>
References: <20250915155312.1083292-1-kuba@kernel.org>
 <20250915155312.1083292-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915155312.1083292-3-kuba@kernel.org>

On Mon, Sep 15, 2025 at 08:53:05AM -0700, Jakub Kicinski wrote:
> Currently we only detect FW crashes when it stops responding
> to heartbeat messages. FW has a watchdog which will reset it
> in case of crashes. Use FW uptime sent in the ownership and
> heartbeat messages to detect that the watchdog has fired
> (uptime went down).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - update commit msg
>  - use uptime the entry from OWNERSHIP enum in ownership rsp parsing
>  - update comment about heartbeat rsp
> v1: https://lore.kernel.org/20250912201428.566190-3-kuba@kernel.org

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>



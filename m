Return-Path: <netdev+bounces-133660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97B09969D9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171C91C22162
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551D5193063;
	Wed,  9 Oct 2024 12:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEVL8XDB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255BE192D82;
	Wed,  9 Oct 2024 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476499; cv=none; b=qu0T4YkEfIAvnUI3oMsaJCxn5ByD+gjlSqmNHcqsJCz5zOxBWUvD23/P37nNmTSVyLnhPbb6L2JrNab81p6UERIOLkcz/DyntNfZgVeIj2exXEAcF1xTmE5IfpTXz8lF8bZIOicM9sHzZGzEGMjm9OR9HetEq+iS5Sb6FOKw0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476499; c=relaxed/simple;
	bh=VNb1K2HvXG3DCvZoVEpmWdPbO9+s7NF2fKv/98Juzc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLpTQpY6a7FDPvZhgp0BVbB0m2yq5P2nw5mazDMRs4Hnjy+F+LodFmHYfq5C7Q2O3xybO92Co6+G0ij3rEhhQjwsaGj09JSpbzY/khR5vjf68rMBP2NkscrJ8PCSCiXjA0IH8FVotehEytI/4BrtmlZDJZIMjjU/YR3ReGV47ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEVL8XDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7431C4CEC5;
	Wed,  9 Oct 2024 12:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728476498;
	bh=VNb1K2HvXG3DCvZoVEpmWdPbO9+s7NF2fKv/98Juzc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEVL8XDB54B3CSDd9QD+aN/dNRv6/AcIDKBMQwbcYsJEZSYz6iJyc8+/LNsJeaZCm
	 2SrAoCyGxeQnl5fCOb/c/qpsRtV0EtrOdceugAS6GmQrBSMQqbztg1wXCA8XaLIV3i
	 BCCSlJYSO0RgFQZRDzzduTr4HlgqW3/usowJQUMpwxY3uRJPfK3bljmY27oj+T6HN/
	 Tn03jdXMZv+ta6W3s0L18Y454nMh9rSzwWOIJtzpCPM3AdnHgpVP/IPSLhHBS18/5+
	 6RrYfR21rEFf7zpaHmIkyJ07ElxHY4Ns90xuyDf8E/A64WBya3LOVTJQTjUx3HHu7n
	 U3kPQddtqmA9w==
Date: Wed, 9 Oct 2024 13:21:34 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] netdevsim: copy addresses for both in and
 out paths
Message-ID: <20241009122134.GP99782@kernel.org>
References: <20241008122134.4343-1-liuhangbin@gmail.com>
 <20241008122134.4343-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008122134.4343-3-liuhangbin@gmail.com>

On Tue, Oct 08, 2024 at 12:21:34PM +0000, Hangbin Liu wrote:
> The current code only copies the address for the in path, leaving the out
> path address set to 0. This patch corrects the issue by copying the addresses
> for both the in and out paths. Before this patch:
> 
>   # cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
>   SA count=2 tx=20
>   sa[0] tx ipaddr=0.0.0.0
>   sa[0]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
>   sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
>   sa[1] rx ipaddr=192.168.0.1
>   sa[1]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
>   sa[1]    key=0x3167608a ca4f1397 43565909 941fa627
> 
> After this patch:
> 
>   = cat /sys/kernel/debug/netdevsim/netdevsim0/ports/0/ipsec
>   SA count=2 tx=20
>   sa[0] tx ipaddr=192.168.0.2
>   sa[0]    spi=0x00000100 proto=0x32 salt=0x0adecc3a crypt=1
>   sa[0]    key=0x3167608a ca4f1397 43565909 941fa627
>   sa[1] rx ipaddr=192.168.0.1
>   sa[1]    spi=0x00000101 proto=0x32 salt=0x0adecc3a crypt=1
>   sa[1]    key=0x3167608a ca4f1397 43565909 941fa627
> 
> Fixes: 7699353da875 ("netdevsim: add ipsec offload testing")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>



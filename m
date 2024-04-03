Return-Path: <netdev+bounces-84517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4565C897214
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F0928A85C
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06856148FE4;
	Wed,  3 Apr 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0aa2++3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B3A148305
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153618; cv=none; b=R/e5Sj+Iaj9i2E3YcdLnTI10TZGMEfO0f23foEq65nesOgpvZUSYl4FNbeHUywo89EMW8t4An6NP70VBEL4mvcEcgnOih55PfYZNvH+jhPRGJJ8xzgNQanTwM1Qh21y4/bgybSe5D+Jswv0tCg8trUNS3crTv7atupbB8Am3TEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153618; c=relaxed/simple;
	bh=hkjsoBM4TIbMK2jyOke8q/ii5uHnGtfBheULkdfgRB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BaV7g89BGfjCCPc/cpNi0JvyMGcG+YZ4dPxdzyFljXJNaAjI5vEuISh5VT45IpxUz2V67g4GOTVA4hwzh+PeODXCrKvUzkzRE+HbkkQ89Y1cbdMyf6fqRJj6Kzc0yoO25c+DX5r/imrk/h/q0IaJDxjBepvxadwqHpD3uJA8ruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0aa2++3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164F4C433F1;
	Wed,  3 Apr 2024 14:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712153618;
	bh=hkjsoBM4TIbMK2jyOke8q/ii5uHnGtfBheULkdfgRB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E0aa2++3bTqzQK4H7fgZ6xCl+iFYOAdJ5gz4ebdQujIzjuqvNCJ5oFrnKrGwQgSI1
	 tYcJEpOPWu0983S3m9sPgjAo7HzMrUY5DjnMclcxWKpys8bFvghcoSn63myplDNe9m
	 iyXqDiKn7I3zVXGRlKidK7v+vB6t7/bcopQ5GAPHBBsUXU23Ogj0dycFEdSyzGeE+p
	 yu1DAqPxk5BV4+fmVQClQxFM69208yjamfLxfUj46cIUFohKt42FEktK4J0dUWbyxc
	 hniK5G110l3dSrPM8GOgkee6bcurEpCa2OoczQoxlgjsFRWkLn2ZQNMrK8MYqF3TGL
	 DdwBWXvyNnbpQ==
Date: Wed, 3 Apr 2024 07:13:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hechao Li <hli@netflix.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Soheil Hassas
 Yeganeh <soheil@google.com>, netdev@vger.kernel.org,
 kernel-developers@netflix.com, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH net-next] tcp: update window_clamp together with
 scaling_ratio
Message-ID: <20240403071332.49c219e8@kernel.org>
In-Reply-To: <20240402215405.432863-1-hli@netflix.com>
References: <20240402215405.432863-1-hli@netflix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Apr 2024 14:54:06 -0700 Hechao Li wrote:
> After commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale"),
> we noticed an application-level timeout due to reduced throughput. This
> can be reproduced by the following minimal client and server program.

Hi Hechao, nice to e-meet you :)

I suspect Eric may say that SO_RCVBUF = 64k is not very reasonable.
But I'll leave the technical review to him.

What I noticed is that our cryptic CI system appears to point at this
change as breaking BPF tests:

https://netdev.bots.linux.dev/flakes.html?min-flip=0&pw-n=0&tn-needle=gh-bpf

We accumulate all outstanding patches and test together.
BPF broke at net-next-2024-04-03--00-00, and:

$ cidiff origin/net-next-2024-04-02--21-00 \
         origin/net-next-2024-04-03--00-00

+tcp: update window_clamp together with scaling_ratio
+tools: ynl: ethtool.py: Output timestamping statistics from tsinfo-get operation
+netlink: specs: ethtool: add header-flags enumeration
+net/mlx5e: Implement ethtool hardware timestamping statistics
+net/mlx5e: Introduce timestamps statistic counter for Tx DMA layer
+net/mlx5e: Introduce lost_cqe statistic counter for PTP Tx port timestamping CQ
+ethtool: add interface to read Tx hardware timestamping statistics

The other patches are all driver stuff..

Here's the BPF CI output:

https://github.com/kernel-patches/bpf/actions/runs/8538300303


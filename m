Return-Path: <netdev+bounces-166482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98942A36203
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77461892461
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C835E266F05;
	Fri, 14 Feb 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d04L8ikl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E34266EE4
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547735; cv=none; b=OTK94/QqQV5pzwJ8Gs+70wQr9m06MlnTnAygWm+G7nQmpq7zujnzMauJ/xwU0NntdcQFGasVSMaQXemDYwUYl0TjDgiLe8nAdkE4m2u2fk0KntDQ/IlEJh0UBOMrm2dZQJYMTziGPVtsvn+rI+sGylUkf/UCcYrQThKbzYbPBSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547735; c=relaxed/simple;
	bh=ycsaR09W0Kxvd2MRxqf99iJC875yK5wRlj8BGekKAas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlM96+B4DsQr4voi6M1ZJf4owrHK3ZY0TxVxwU1kRSYcITJInWLy/84L6WM3/RLMGwJ9fsk5hNcq8Nb/6RR/ZUu7y6TfNwTaExrApcdudr2CTtEEQm7N4mYDvp+XAhLsMvEeMcym3/kkoubPGH7f/fnRNLfeMRbNcI6fchC3lig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d04L8ikl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5B7C4CEDD;
	Fri, 14 Feb 2025 15:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739547735;
	bh=ycsaR09W0Kxvd2MRxqf99iJC875yK5wRlj8BGekKAas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d04L8ikliFgOfMcL32WQ6eODi7SIWP5jp5smpovmuVVX87B5Bn8ReQUzQKYym7UXp
	 4X1UsyhoN+XopOrw/5Gbj5aGWyo2y3Jc4ssS0ZARllEs29oTc0m0sATU0XaUpP/n6i
	 +sWWkNWrAjZ+kB6OOR1LyiWUwVwnExUYlTruuUY6DLOka6BGH9stYimIjohMmu2TNY
	 Cwb/kxgfH1ztJ9Qz7PWn1rBAZRFh4PNaA/mx/86Yk8NplxPK7XCMJI6juWPfneR4gF
	 4ZWFULyD/q/S04Y8d73qAJrJgIrGB6LCxLYddGq7aeqshpItXUQuGlU+zF86NWIyQ+
	 w07zH4Hy+k8Qg==
Date: Fri, 14 Feb 2025 15:42:09 +0000
From: Simon Horman <horms@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux@armlinux.org.uk, sanman.p211993@gmail.com,
	vadim.fedorenko@linux.dev, suhui@nfschina.com, sdf@fomichev.me,
	jdamato@fastly.com, brett.creeley@amd.com,
	przemyslaw.kitszel@intel.com, colin.i.king@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH net-next V2] eth: fbnic: Add ethtool support for IRQ
 coalescing
Message-ID: <20250214154209.GL1615191@kernel.org>
References: <20250214035037.650291-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214035037.650291-1-mohsin.bashr@gmail.com>

On Thu, Feb 13, 2025 at 07:50:37PM -0800, Mohsin Bashir wrote:
> Add ethtool support to configure the IRQ coalescing behavior. Support
> separate timers for Rx and Tx for time based coalescing. For frame based
> configuration, currently we only support the Rx side.
> 
> The hardware allows configuration of descriptor count instead of frame
> count requiring conversion between the two. We assume 2 descriptors
> per frame, one for the metadata and one for the data segment.
> 
> When rx-frames are not configured, we set the RX descriptor count to
> half the ring size as a fail safe.
> 
> Default configuration:
> ethtool -c eth0 | grep -E "rx-usecs:|tx-usecs:|rx-frames:"
> rx-usecs:       30
> rx-frames:      0
> tx-usecs:       35
> 
> IRQ rate test:
> With single iperf flow we monitor IRQ rate while changing the tx-usesc and
> rx-usecs to high and low values.
> 
> ethtool -C eth0 rx-frames 8192 rx-usecs 150 tx-usecs 150
> irq/sec   13k
> irq/sec   14k
> irq/sec   14k
> 
> ethtool -C eth0 rx-frames 8192 rx-usecs 10 tx-usecs 10
> irq/sec  27k
> irq/sec  28k
> irq/sec  28k
> 
> Validating the use of extack:
> ethtool -C eth0 rx-frames 16384
> netlink error: fbnic: rx_frames is above device max
> netlink error: Invalid argument
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Hi Moshin,

Unfortunately this does not seem to apply cleanly against current net-next.
Could you rebase and repost?

Thanks!

-- 
pw-bot: changes-requested


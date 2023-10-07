Return-Path: <netdev+bounces-38798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E45C7BC890
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 17:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B7F1C20A55
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE7D2AB45;
	Sat,  7 Oct 2023 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO9WG4/P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9C2AB32
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 15:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D111C433C7;
	Sat,  7 Oct 2023 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696691612;
	bh=m89gazFfrv75JcJMlTacH3tiK09irLU+A97u2aDkxBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YO9WG4/P5pcHX0L59vCYD0VJkvi8oRSDh7oXwbRb66Emjoem3g9/VIEfrly7YtBqv
	 BRzlfWtip+BGlVSHm9QV+n6NdBRIqBWH/6PdT35W4Kb0NKS0zfkdTw4h0/xfrXUTvz
	 RJSlqtANVRhvktF5ylJVyf3631CdiGFxEzt494mxuCzzlxthftyfJ5A3xid+FPOnzF
	 PjeKRNsdhaiEk5bFGgQqlVSXWWxSgDzMe8Yd3nWo45HPZiXdpwnWb7cr1ATx3fVkF9
	 cka8NB/Qou7tV8mUoo8g/11VzP8tQKlVfCjhLVDpPMvD+iWi/nQsB1M8PFxFRYGHQk
	 tZWnkRmBe+8xQ==
Date: Sat, 7 Oct 2023 17:13:28 +0200
From: Simon Horman <horms@kernel.org>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: 3chas3@gmail.com, davem@davemloft.net,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] atm: solos-pci: Fix potential deadlock on
 &tx_queue_lock
Message-ID: <20231007151328.GD831234@kernel.org>
References: <20231005074917.65161-1-dg573847474@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005074917.65161-1-dg573847474@gmail.com>

On Thu, Oct 05, 2023 at 07:49:17AM +0000, Chengfeng Ye wrote:
> As &card->tx_queue_lock is acquired under softirq context along the
> following call chain from solos_bh(), other acquisition of the same
> lock inside process context should disable at least bh to avoid double
> lock.
> 
> <deadlock #2>
> pclose()
> --> spin_lock(&card->tx_queue_lock)
> <interrupt>
>    --> solos_bh()
>    --> fpga_tx()
>    --> spin_lock(&card->tx_queue_lock)
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> To prevent the potential deadlock, the patch uses spin_lock_irqsave()
> on &card->tx_queue_lock under process context code consistently to
> prevent the possible deadlock scenario.
> 
> Fixes: 213e85d38912 ("solos-pci: clean up pclose() function")
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
> V2: add fix tag, and split into two patches

Reviewed-by: Simon Horman <horms@kernel.org>



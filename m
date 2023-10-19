Return-Path: <netdev+bounces-42486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F1D7CED93
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 03:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F831C209BD
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBC0396;
	Thu, 19 Oct 2023 01:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMU+hWZx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057057FD
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6704C433C8;
	Thu, 19 Oct 2023 01:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697678756;
	bh=Bo2rNx1P5rqGaRjEElKR9ESp+uBQTFt4srxoPCP49qg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sMU+hWZx+AHKSSgK5/4oSCK2E6eC9t2jpi3nyN5NybU+tl2tCFztBba96/APfBvvq
	 u/qJp3EtjORVy7stL42taf3tyMTEI213hGi0U+r5iH2qAwdLwTfxURxu9Z29EDSRnS
	 5Kfkm6s2DzVngw5z1tzt9dguOMfONFXhab5MIE590zpON8/3hJnjVjg1JdmaSwcYe9
	 RwIxwSU+x+FGYErCc5CwSe3ipiRRhmkAOM0F8me9v/oioEr+u+JZBe08YCfSfA8CJW
	 HxPgYb+V5eGyrExTi/yKZG3TKXYJWyVcJQ4cSvoEreID/PpI8fhCDPx6Gj51r8/ym3
	 u22ebC2xUj6+A==
Date: Wed, 18 Oct 2023 18:25:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com, Sabrina Dubroca
 <sd@queasysnail.net>
Subject: Re: [PATCH v2] net/tls: Fix slab-use-after-free in tls_encrypt_done
Message-ID: <20231018182555.28f1a774@kernel.org>
In-Reply-To: <VI1P193MB0752321F24623E024C87886A99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
References: <VI1P193MB0752321F24623E024C87886A99D6A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 00:22:15 +0800 Juntong Deng wrote:
> In the current implementation, ctx->async_wait.completion is completed
> after spin_lock_bh, which causes tls_sw_release_resources_tx to
> continue executing and return to tls_sk_proto_cleanup, then return
> to tls_sk_proto_close, and after that enter tls_sw_free_ctx_tx to kfree
> the entire struct tls_sw_context_tx (including ctx->encrypt_compl_lock).
> 
> Since ctx->encrypt_compl_lock has been freed, subsequent spin_unlock_bh
> will result in slab-use-after-free error. Due to SMP, even using
> spin_lock_bh does not prevent tls_sw_release_resources_tx from continuing
> on other CPUs. After tls_sw_release_resources_tx is woken up, there is no
> attempt to hold ctx->encrypt_compl_lock again, therefore everything
> described above is possible.

Whoever triggered the Tx should wait for all outstanding encryption 
to finish before exiting sendmsg() (or alike).  This looks like 
a band-aid. Sabrina is working on fixes for the async code, lets
get those in first before attempting spot fixes.
-- 
pw-bot: cr


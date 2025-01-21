Return-Path: <netdev+bounces-159898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F65A1755F
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 02:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694DF1887D18
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 01:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3183820322;
	Tue, 21 Jan 2025 01:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h12ZZFyL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4EAEBE
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 01:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737421441; cv=none; b=qEtUcdblqGkD69/b98InL7Fiw/HEyKWquj0rJQlmtR4DLvaS2j+tCl4ewR3SqbLCKVstkYKeEUUyZy2LDBC3ZV6aR/M47iPcyDjYopa2Clv/cBPpFf72FLEykOVUr+LZDw1pX0Ea/yfnCvX0NHzArw+5+hrisYeqA0jBLGmf7aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737421441; c=relaxed/simple;
	bh=IxT6jvxwyfp01I4TqtJpSK9pSaUrBSVjbvnvsdaXqH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUfIS/FmN7IEhrvMRWJryD4QNEaMi9MMFYZPA3OniLsZto9GOcT++EuFJcyHzHFhfgg82xcGth8vAWrv5y6Wb4NugMypL7IOo8vj+zs31QiiLWMA9xwx4VbIkoXgVYt63jbvlTNUBStKA/JdMzZznXT0pxKo2pBtDrdHC4D9pKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h12ZZFyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6C7C4CEDD;
	Tue, 21 Jan 2025 01:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737421440;
	bh=IxT6jvxwyfp01I4TqtJpSK9pSaUrBSVjbvnvsdaXqH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h12ZZFyLaB/vxc8n+HqYKXOuyLUpjjPWe1US/j7MQwTrgLpqR8sMc8rA/mP0qXgg6
	 hfD1dDVviiomAfu9gp89tnKOhOOuA0wvxeJiF6yZ6TP0qdxiV0hofYN+cUxU4DWPIt
	 M27f7+Sm+EQsB3pDCHtIw79oqFlMyS6Zy8baW2CtG+AYv7rtPC4EbQe3xvy4RlawZh
	 OQ6GUkoag5YZrfcdEUY97j4K2B1we/efT0a+xqcAlQ279TZJorEPjW15pP4p+T77Js
	 TMpfdejfqFZGTBt0VESnK35cTIcM0/0wUGCL4mUYvpDDrNkBIH2mQMZudyVtlIZrnI
	 5gCeaTT+Dcy8w==
Date: Mon, 20 Jan 2025 17:03:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 andrew+netdev@lunn.ch, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
 tariqt@nvidia.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
 akpm@linux-foundation.org, shayagr@amazon.com,
 kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v6 0/5] net: napi: add CPU affinity to
 napi->config
Message-ID: <20250120170358.3f4181a6@kernel.org>
In-Reply-To: <20250118003335.155379-1-ahmed.zaki@intel.com>
References: <20250118003335.155379-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 17:33:30 -0700 Ahmed Zaki wrote:
> Drivers usually need to re-apply the user-set IRQ affinity to their IRQs
> after reset. However, since there can be only one IRQ affinity notifier
> for each IRQ, registering IRQ notifiers conflicts with the ARFS rmap
> management in the core (which also registers separate IRQ affinity
> notifiers).   
> 
> Move the IRQ affinity management to the napi struct. This way we can have
> a unified IRQ notifier to re-apply the user-set affinity and also manage
> the ARFS rmaps. Patches 1 and 2 move the ARFS rmap management to CORE.
> Patch 3 adds the IRQ affinity mask to napi_config and re-applies the mask
> after reset. Patches 4-6 use the new API for bnxt, ice and idpf drivers.

Sorry for not-super-in-depth reviews, the patches didn't apply for me :(
But feels like we are pretty close.
-- 
pw-bot: cr


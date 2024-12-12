Return-Path: <netdev+bounces-151282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538129EDE14
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5DCD1888C83
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532E6143759;
	Thu, 12 Dec 2024 04:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnN6Odca"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53D257D;
	Thu, 12 Dec 2024 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733976269; cv=none; b=Lxl/X1YSYzE572jNwPzK4uGCdnX9bg0qTPvsq3I/N3LnU7kgGU1AxfzWZblE2BkHNxz9MeOWq3dZgOrskxdG4OAdSUqxyPpC6m5wAyMpcPYOgtRWJKIFSyRuJlb9GrA6sU2cBqiXAeR7ZrMgKjDmZJf4DOFsmna2RL0o1vDllWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733976269; c=relaxed/simple;
	bh=n9A5pRbGL5TilI2UVM8yPg/bdtXL9BUcYvM+EptkmaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heKlg7QUvPr9pPEQPslAk4leeAOAypXIm/a5P56NjvclfMGH5AVkHckW2KWbmJL88rr8r81+Cwy3LyOGLNu6AMBNhpMGLyhQ0VI+POAUVHUJEfQRNbbPgjdffLX9URWIiNp7bMrMNMneiFCrXOI2rr4N2hTUR39j09tDoqKeD4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnN6Odca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2368FC4CED1;
	Thu, 12 Dec 2024 04:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733976268;
	bh=n9A5pRbGL5TilI2UVM8yPg/bdtXL9BUcYvM+EptkmaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PnN6Odca7mydU3HWfZ1KV4nir7utrwMKI4Y8yysf2s8W+QIXO0oL1b4+3BfqNBkcE
	 50hNlPqCOAdEMKOevvs1gLcvGlwCRoUmZzu625m67fOFTI2RpeAUY2AY5jvmOJC8aF
	 IrNFTwNTNa1LafRtmsb2I0oV99bM6zTaQcbYTTc4ZcL9228V+YOuAcmzvcLSy7CkVv
	 yFFdaMpdph2wgPADVDS2+HdybVfYfNVAXIyshQDkrxaB89dngP2tCKtE1w5ksrgmLd
	 5Mxcsc/dpsoiwD97C2nD04P22mGCxV//0C0R+bLRbrokriBUdqWA+0e/935uglkONa
	 q7TmDqs8cyjVA==
Date: Wed, 11 Dec 2024 20:04:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Louis Peens <louis.peens@corigine.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>, James
 Hershaw <james.hershaw@corigine.com>, Johannes Berg
 <johannes.berg@intel.com>, Mohammad Heib <mheib@redhat.com>, Fei Qin
 <fei.qin@corigine.com>, "open list:NETRONOME ETHERNET DRIVERS"
 <oss-drivers@corigine.com>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] nfp: Convert timeouts to secs_to_jiffies()
Message-ID: <20241211200427.3c1d7a73@kernel.org>
In-Reply-To: <58c2bbb7-cf39-4832-9e31-60ed9302372a@linux.microsoft.com>
References: <20241210-converge-secs-to-jiffies-v3-20-59479891e658@linux.microsoft.com>
	<Z1ldtgYpXCIIN5uQ@LouisNoVo>
	<58c2bbb7-cf39-4832-9e31-60ed9302372a@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Dec 2024 10:10:13 -0800 Easwar Hariharan wrote:
> I'll send a v4 series to netdev including your
> Reviewed-by for this patch.

No need to repost this patch. Tooling will pick up Louis' tag.


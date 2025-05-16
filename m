Return-Path: <netdev+bounces-190908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5348AB938B
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 03:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE1F1BC3E8D
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC0F21A94F;
	Fri, 16 May 2025 01:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxTe84IJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C2421FF20
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 01:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747358039; cv=none; b=R5jN2aj2F9caL9S2yt+W9AdQqRdq/SyGL+aQIAJoQ6rhz8apeqGfGRNa5BTV1VREgR9DmH56cBpumLJZak+WIKHuDu5JGok6iRdwtHBp7L3j5nw81EkI8iK2UvcF/n24F8PjrChfUhgGNxMiwtIt6BSFcVH5W1IRw3fj3py/uew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747358039; c=relaxed/simple;
	bh=MuVZIaw/gfFWLrrSK9MI2upd2KYATjSbjinT5eDdHNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcXz2G87okoQUbNU8p2DbQ/rI/JBfOUXAKG6sQVvrXuRRQ+4bFHP9/dy7/3SGvh9AiBXJH7EfenS5itPxjPrZUGPqCPAYvtul4Coe3dc9oPHQLynQuzjJ5ex24P+Fdk7ZEbPUXHlOlm4+zWNHOH635eQ6qQl9yVOPqYHE0G+/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxTe84IJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDC6C4CEE7;
	Fri, 16 May 2025 01:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747358038;
	bh=MuVZIaw/gfFWLrrSK9MI2upd2KYATjSbjinT5eDdHNE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QxTe84IJqt05STMoVkHbVJrJ4de5qk6u9F/5Pfw3mC9pWybeCOJsWGaIKOpUrqG4u
	 LdpSe23lM2QSBgmKv5/nI1Kj5lBH/dxw5oq5pk68Q80UdhfLGmJAb2Bwas3/vGSphZ
	 n9fpQ9gcT9fhnYCVyZev8qlKfCGucja3X+dhwHH6KViBdTcGgSpg3R3D+uZcX4FeDF
	 v5q0i5Exn11Lj3FcWK492EPHOVICVKZ8+XmAnzZRz6F38CkbdO1FQnCfKsNKpsVa5v
	 4LMiry9XOaSdJZxG1JyYaw3hYaTzFR3BRRLpfvP18CCmPYFHNtAexeYVtptNJNMT+Z
	 ciU9Frma/4QTA==
Date: Thu, 15 May 2025 18:13:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: airoha: Add FLOW_CLS_STATS callback
 support
Message-ID: <20250515181357.73f98a18@kernel.org>
In-Reply-To: <20250514-airoha-en7581-flowstats-v1-2-c00ede12a2ca@kernel.org>
References: <20250514-airoha-en7581-flowstats-v1-0-c00ede12a2ca@kernel.org>
	<20250514-airoha-en7581-flowstats-v1-2-c00ede12a2ca@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 19:09:58 +0200 Lorenzo Bianconi wrote:
> Introduce per-flow stats accounting to the flowtable hw offload in
> the airoha_eth driver. Flow stats are split in the PPE and NPU modules:
> - PPE: accounts for high 32bit of per-flow stats
> - NPU: accounts for low 32bit of per-flow stats
> 
> FLOW_CLS_STATS can be enabled or disabled at compile time.

sparse isn't happy:

drivers/net/ethernet/airoha/airoha_npu.c:382:15: warning: incorrect type in assignment (different address spaces)
drivers/net/ethernet/airoha/airoha_npu.c:382:15:    expected void *stats
drivers/net/ethernet/airoha/airoha_npu.c:382:15:    got void [noderef] __iomem *
-- 
pw-bot: cr


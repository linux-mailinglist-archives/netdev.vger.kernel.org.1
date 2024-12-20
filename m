Return-Path: <netdev+bounces-153803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A359F9B3C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0361670D5
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0559F221451;
	Fri, 20 Dec 2024 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOCSuIrn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE4157A48
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734727871; cv=none; b=bzRUGFkeATP1/bo7PouqOUMOuPTWVcSZIIXaCiRy5cLY8kuTr8teiwCkwVO3nYmeXSwG7YWlO1LIrj2LCU5y/AZpDtL6bcAOgycevnQe/i0BwroxfIqUMgo7ZejUIxnIWjXB8LuqjZhuFWWV+HT9BcRoN7z0BWJXKh2CYwj9au8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734727871; c=relaxed/simple;
	bh=PsiINN6x+FJAs3KH/LvlP/yQ3ibuFQXygFtnAYzvISs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXogSvXsMAhsdW/+WHCzDajI/ct3O8wIUqWhMMQ+uAgAWfi0Ko8PYMZkEDxtUMJdJUgGHHmCVCW1hQwYjaJeOV+QKS+2LqA/AejJZ8N6KvzIvyGxEadoUc1lbvEKqzDZtXxubEHhcqEle8BwgNdcEdV2Z7XJBMBlcXPuNehEU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOCSuIrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C29C4CECD;
	Fri, 20 Dec 2024 20:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734727871;
	bh=PsiINN6x+FJAs3KH/LvlP/yQ3ibuFQXygFtnAYzvISs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hOCSuIrnj/tN6MjeBHmXeTkQvlYWe1HfX3X20KOF/efdLnbQZk2utxHEpkJDosl68
	 np1Kx0Yi0RrjgxE56JEDql1TsxvcLp26mTGVDGlsdaIN0wHdyC5zt3gCuZoYyKuYBi
	 N8XRYS5XAHCzcJK/gGOr1sOQVfhb3faRFDB1g1fWWaTi4WUK13Eb9elpMjD7N9QGaE
	 IZqAUEcpGwbR+5+4NKclEFljAktG09QNc63BiXi2HiVsF+SCpUgRfPdbPskAXkgmP3
	 PvT84SM2+IefalLEYi3ZlQBDTew3u9yRcXX7QGFIV4emLPiVg6bV9JIHSnuuc46V3n
	 BjRvNWDp81c0Q==
Date: Fri, 20 Dec 2024 12:51:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <andrew+netdev@lunn.ch>, <edumazet@google.com>, <pabeni@redhat.com>,
 <davem@davemloft.net>, <michael.chan@broadcom.com>, <tariqt@nvidia.com>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <jdamato@fastly.com>, <shayd@nvidia.com>, <akpm@linux-foundation.org>
Subject: Re: [PATCH net-next v2 4/8] net: napi: add CPU affinity to
 napi->config
Message-ID: <20241220125110.4f8d8e6b@kernel.org>
In-Reply-To: <df42a234-f289-4be7-a698-54b645b0fd81@intel.com>
References: <20241218165843.744647-1-ahmed.zaki@intel.com>
	<20241218165843.744647-5-ahmed.zaki@intel.com>
	<20241219194237.31822cba@kernel.org>
	<cf836232-ef2b-40c8-b9e5-4f0dffdcc839@intel.com>
	<20241220092356.69c9aa1e@kernel.org>
	<35441a41-d543-4e7b-b0dc-537062d32c9c@intel.com>
	<20241220113711.5b09140b@kernel.org>
	<df42a234-f289-4be7-a698-54b645b0fd81@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 13:14:48 -0700 Ahmed Zaki wrote:
> > Then you can probably register a single unified handler, and inside
> > that handler check if the device wanted to have rmap or just affinity?  
> 
> This is what is in this patch already, all drivers following new 
> approach will have netif_irq_cpu_rmap_notify() as their IRQ notifier.
> 
> IIUC, your goal is to have the notifier inside napi, not irq_glue. For 
> this, we'll have to have our own version of irq_cpu_rmap_add() (for the 
> above reason).
> 
> sounds OK?

Yes.


Return-Path: <netdev+bounces-158211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD5EA11117
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0409F1883A5A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 19:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D591FC107;
	Tue, 14 Jan 2025 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAzk9vEI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA181FBC8A
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882643; cv=none; b=qd2sxhve7auLTXHVEMEnkpiJTcu5XqKFY06HxB0yPBJsYf8P9rJll+WCvKFdHNTShChgawG8a8YKXanJm3cItNu61rg3YaSmkjUn3wAg9wbovKVbU8DDacXEjb8zWC7QnOUdvpoJeNq2o299gOp7r7ac0Ro/d0ak1/DZk7weMwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882643; c=relaxed/simple;
	bh=EmUgtju5Mvy5kfkXswfmyD1qO1yREVF71pq8xOOlYLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExAMPizV+BVO7A2IcAwX5Y/c5eZFH33dYxphE075gWBKIeOflyjg97xNBtHUVi4onzkhKQhbbkSkXbWqrg3Cjo8XcFwMYt+MSTvFK/UERsuHa5b9J6m/0hO2o+0jGAkDU635958LcBL/oCRb75bAswlVWU9BgU9aqTjWK1GFPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAzk9vEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC098C4CEDD;
	Tue, 14 Jan 2025 19:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736882643;
	bh=EmUgtju5Mvy5kfkXswfmyD1qO1yREVF71pq8xOOlYLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eAzk9vEI8ma4VCxX+s/5562CEml2pm10Ng7RW2MSGBNKZ+LVPk09XiIkMjrNQ67PY
	 SaIbQtAuBd/ISd58p9WFeL5K3wtTCAV/wpznwWLGF48Oy19r4HVehR2+mBWJ74wkbx
	 5YNJFHRcsBljR8J3s75pqBQkEGfAAl4RKLyII5uQRsFtbrVyRpONHvSiZO2gwpzrjo
	 InmUvy3XQi8vdjV4hGn+zg8NalMKO7rCAAfE8N9xPjml/rdg0dVb70Xb+1Uxu4HXlZ
	 zZMTurxYgTtMXDvYt6n0MeBBpSH4843LUcYF4CD5aRskNIlV0wT0uX6JeG0vpO5ezj
	 KO0k+LrAdMWyQ==
Date: Tue, 14 Jan 2025 11:24:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Edward Cree <ecree.xilinx@gmail.com>
Subject: Re: [PATCH net] net: avoid race between device unregistration and
 set_channels
Message-ID: <20250114112401.545a70f7@kernel.org>
In-Reply-To: <20250113161842.134350-1-atenart@kernel.org>
References: <20250113161842.134350-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 17:18:40 +0100 Antoine Tenart wrote:
> This is because unregister_netdevice_many_notify might run before
> set_channels (both are under rtnl). 

But that is very bad, not at all sane. The set call should not proceed
once dismantle begins.

How about this?

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c index 849c98e637c6..913c8e329a06 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -90,7 +90,7 @@ int ethnl_ops_begin(struct net_device *dev)
                pm_runtime_get_sync(dev->dev.parent);
 
        if (!netif_device_present(dev) ||
-           dev->reg_state == NETREG_UNREGISTERING) {
+           dev->reg_state > NETREG_REGISTERED) {
                ret = -ENODEV;
                goto err;
        }


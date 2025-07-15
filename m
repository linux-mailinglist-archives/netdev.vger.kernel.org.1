Return-Path: <netdev+bounces-207206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD23B06391
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032C07A3FEC
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87591F30CC;
	Tue, 15 Jul 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9LWsc4d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340F41531E8
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594918; cv=none; b=md1esqt6X27uRCShYp8YgfnL9/FjF7LPCHA3JKPqgK3mrbItCACR0ijXntXa1Fj4rndcT6gnWKoVRQEDU7HEaKj1gZgzdJXmf49KVaYDlb3YypGrH0bTqDqZM22uQZNgz81+PrnVauhE3EpGoJUCKRpwt/3aZ/OSiHl+LNxLbgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594918; c=relaxed/simple;
	bh=g017OE2FngIcrQmqQbImkrx3L8729xMu+lbn3ALVDyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWnR6SoABEwc/SnyrGcG5eexEoPi1yJW1p3Ds1g39uBJfn0vfMwCe/8xWGGbx4LzqktLn5yO8HmVL+3VtE86Koac6er/cQgyt+MLvLM71o7FVqIh4aFjzB/5DeDS903eQaKgAN17FD8lJ3WNfS0nmMyYZoh4k4XoY0T6yFKWpuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9LWsc4d; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-235ef62066eso83101175ad.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 08:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752594916; x=1753199716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P5PPY48R2lQDoYsT9uGfHsMdmhqwgN7jEDchEWEJgLI=;
        b=L9LWsc4dJyY0wPziQN8pmj1q99JwbxAP38XQXXV2M6bLSCdcyNEyMuqosEhlJ/mBqU
         zyCRV1yLi82qaogTbXhK9tWFT5AsJZn1K6u9vptLeaco9EA/fWZt/OntHKKzkV5FHB5C
         cBHL2Kf62ilGy4ZozIgDdIYmIRWofBcEkxFDkEKeWYS/MGe9kChIBNWxn1uwkdc8rosa
         cjRZLneAkFl/Luj5SDramNxNNFYBz9f6A9m1il4tVlP+7GfCW/BD/gT0tnf3+vO91HFZ
         31NvAvpW+m4KU9MMl8UcTsD26rW5XxdH5O+/gZUqn9JZccd0rlr7AfBt1ROwND5YR2j4
         ridw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594916; x=1753199716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5PPY48R2lQDoYsT9uGfHsMdmhqwgN7jEDchEWEJgLI=;
        b=Kf8bPSJyXiiq30B2N0wPiTXNrqt+SvdRK1FG3ZszFIMmom0kwt1hAhKJ0RBs3WU4LF
         1tFzeiFp9j1O3f7ycVlzHhXvJPQ6UReZiUVbjxEUGLKM5r9w71p2n3gmipegDNVfTAm4
         5C7GA9LaUQUieNVybPYpF+/I4zwxnUXkg5WX9SxCzzdFO7Q8TbEPLCNXWKq/N/YCUL/y
         Y0Ih8N2w+KTK7QmOGAv+il8Vo52wN40x34hRDIVSgGzwCRIGVZ4Ui6xEbQVW9OobV5/j
         8hhzn/AnL0Qu2PQlyCR8kphzaC9ZrQrHq0Ddx6fuanTeZJcsIh3IZ+lUSi/REb+K27qG
         TdAw==
X-Forwarded-Encrypted: i=1; AJvYcCVOQLHyaOLho2Q/oyamsPCtXG09Be+l3p9mgdZjgIwAGnSpy6e3VpqmPRiduZckHCf5+DWLlU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEoSXC4C/DEsAR8uHjR8OJfnQSig7opXGSCaGPBuS3aeYMEmMP
	Z37slM7dVyPdQHDQEqOdImntWpEjDIxtkBKE8LLj9nDl6tz7jMfrGHU=
X-Gm-Gg: ASbGnctyJD1NgllxWVNzWF1VsP22NpI8XdzoLB1mO1rT2dimNHujHfe7ZvRcejzDvbC
	penzVdUImZSnMmHh3/V5DY5/B+t4V/D1LhAUec0beOSYI41Vyac2BcdFGAK7xj8HbBKASH1DpHp
	GgtphWo3tDbd3a7+Y5lBhVyzT8nz5Dat5qpdYpCn2L8BV2U9Dq18/6fq4v/fvGC7hugkEp76tLh
	eM8OkSflco4sX39cv5MjVQrCZhIM5nrRQofxjra2go+6wLQ0Phs8RkHDzLQJ1w/iDTXul3fNlhV
	ztaVd5npWU5+Cqa8n2W4n8Q2+cI3dyeykWanHCNyEadVf4XgiiRz8FE6i410jWRdu5mriVBT4xz
	2hGK204o3OGbgnsX8OG5o78xA+oYRigHXP8DdD3RmxGrop3+VCVYG1fgb5KY=
X-Google-Smtp-Source: AGHT+IGbM6sd1ptC1u0EK1Z8mxL4kXag/H0IC7ixdyTwOfFynkNW7VKL02eNbCUI6+nj8JrIL0Z98w==
X-Received: by 2002:a17:902:8b8b:b0:238:f2a:8893 with SMTP id d9443c01a7336-23dede984b9mr168315975ad.42.1752594916211;
        Tue, 15 Jul 2025 08:55:16 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de43226c3sm116294145ad.117.2025.07.15.08.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:55:15 -0700 (PDT)
Date: Tue, 15 Jul 2025 08:55:14 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "sdf@fomichev.me" <sdf@fomichev.me>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Sleeping in atomic context with VLAN and netdev instance lock
 drivers
Message-ID: <aHZ54sAfzIe0rmCd@mini-arch>
References: <2aff4342b0f5b1539c02ffd8df4c7e58dd9746e7.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2aff4342b0f5b1539c02ffd8df4c7e58dd9746e7.camel@nvidia.com>

On 07/15, Cosmin Ratiu wrote:
> Hi Stanislav,
> 
> There's a bug that was uncovered recently in a kernel with
> DEBUG_ATOMIC_SLEEP related to the new netdev instance locking.
> 
> I looked a bit into it and I am not sure how to solve it, I'd like your
> help. On a netdevice with instance locking enabled which supports
> macsec (e.g. mlx5) and a kernel with:
> CONFIG_MACSEC=y
> CONFIG_MLX5_MACSEC=y
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> 
> Run these:
> 
> IF=eth1
> ip link del macsec0
> ip link add link $IF macsec0 type macsec sci 3154 cipher gcm-aes-256
> encrypt on encodingsa 0
> ip link set dev macsec0 up
> ip link add link macsec0 name macsec_vlan type vlan id 1
> ip link set dev macsec_vlan address 00:11:22:33:44:88
> ip link set dev macsec_vlan up
> 
> And you get this splat:
> # BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:275
> #   dump_stack_lvl+0x4f/0x60
> #   __might_resched+0xeb/0x140
> #   mutex_lock+0x1a/0x40
> #   dev_set_promiscuity+0x26/0x90
> #   __dev_set_promiscuity+0x85/0x170
> #   __dev_set_rx_mode+0x69/0xa0
> #   dev_uc_add+0x6d/0x80
> #   vlan_dev_open+0x5f/0x120 [8021q]
> #  __dev_open+0x10c/0x2a0
> #  __dev_change_flags+0x1a4/0x210
> #  netif_change_flags+0x22/0x60
> #  do_setlink.isra.0+0xdb0/0x10f0
> #  rtnl_newlink+0x797/0xb00
> #  rtnetlink_rcv_msg+0x1cb/0x3f0
> #  netlink_rcv_skb+0x53/0x100
> #  netlink_unicast+0x273/0x3b0
> #  netlink_sendmsg+0x1f2/0x430
> 
> The problem is taking the netdev instance lock while holding the dev-
> >addr_list_lock spinlock.
> 
> Any suggestions on how to refactor things to avoid this? Maybe schedule
> a wq task from vlan_dev_change_rx_flags instead of synchronously trying
> to do the change? I'm not sure that would entirely solve the issue
> though.

Thanks for the report, I was looking at similar issue in [0] and for
macsec I was thinking about the following:

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 7edbe76b5455..4c75d1fea552 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3868,7 +3868,7 @@ static void macsec_setup(struct net_device *dev)
 	ether_setup(dev);
 	dev->min_mtu = 0;
 	dev->max_mtu = ETH_MAX_MTU;
-	dev->priv_flags |= IFF_NO_QUEUE;
+	dev->priv_flags |= IFF_NO_QUEUE | IFF_UNICAST_FLT;
 	dev->netdev_ops = &macsec_netdev_ops;
 	dev->needs_free_netdev = true;
 	dev->priv_destructor = macsec_free_netdev;

macsec has an ndo_set_rx_mode handler that propagates the uc list so
not sure why it lacks IFF_UNICAST_FLT.

This is not a systemic fix, but I guess with the limited number of
stacking devices, that should do? If that fixes the issue for you,
I can send a patch..

0: https://lore.kernel.org/netdev/686d55b4.050a0220.1ffab7.0014.GAE@google.com/


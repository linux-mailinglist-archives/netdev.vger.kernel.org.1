Return-Path: <netdev+bounces-201966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D732AEBA16
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E395640C6
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE302E54DA;
	Fri, 27 Jun 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M/mPOWcQ"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEC32E3AF8;
	Fri, 27 Jun 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035310; cv=none; b=tHVkkwQQe+sgo1EUaMuM0NfOHQAtNB3lUaGNW9w6VdV9WvYrzF5A9vT49JOXUUfk20gsVdEglYcBVD6VUYhJT+tSl3KoLsN9a/E7Nlmi5ihZH12PeH4ey9fh8yJmhtFvwiSXU4DM07+BgBxRGZP3V9t4x6O/dbNyeRuDT3+rpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035310; c=relaxed/simple;
	bh=IWhsrUpj3XLzFW/68PQs6OZ5mzzQRDoe+2aqErn6Egc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaDYBt3gUt/tS1iwr3+L/cgDnKBSU9FEk0j9VNA7T/jMqBw+Al5xBGO2VM9iPk4SCeUr9fDiiMSaKMqc2g8dLBqB+ucwx2s9R1h2JGbhb7gDAhCfRepY2Om7MYCXh/Q4hbWEn74H5V1hM32W/dsIXLZ7RalAqasUr29T+uX7q/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M/mPOWcQ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 720F07A009F;
	Fri, 27 Jun 2025 10:41:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 27 Jun 2025 10:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751035305; x=
	1751121705; bh=sRfr9oxgD+UekJ8CAymMSYxljdF93YKHcACrewgtdBQ=; b=M
	/mPOWcQkS55cRlrcfWBOF0tFEWc78+heDRxfc5OfOCdOKg+YJSprcvOZbewFRqZX
	9emCPUigPzvwNWBB54IzIMw9xgrW5JmYMmKWYwCMA/WjU4K6K50zkXrYqrz5K38y
	YXyBvRKcuM1Yk85iSEpTfUcYGVSen6cDwh/sxSndL0beIfM5ggFVCMPtrkhlPSED
	qPun+koiShiXe7q4Mta/6bMD08X0M23Wr3bjFtRR95UDiYWq08ab4hvPVvcH/EPT
	bH8xmMC+K9i4v87MRigiqIF8FfdyAEPtJGZsPBKRBMNu7G0nMmkaPpCKp1NtjWMB
	pJVdFEO0DW7iBDZSBh5cg==
X-ME-Sender: <xms:p61eaKeis4dYU-bWTNOYDxcDIPGR3oUxIDqvnjzvfrLkMS0aJ94kdQ>
    <xme:p61eaENniDdto3V58Bwnz7reeKcj6XsnPCWX_g8HExAAK1aBAqh2iIT5K9koU99V0
    R-80LTRPMsPKgE>
X-ME-Received: <xmr:p61eaLiB_nRG6ItaWvGby22PXA3_jUtjqoZT5TQToa8UMa4MirCla23cyoru>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpeegheekuddvueejvddtvdfgtddvgfevudektddtteevuddvkeetveeftdevueejveen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughosh
    gthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepughonhhgtghhvghntghhvghnvdeshhhurgifvghirdgtoh
    hmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghv
    vghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirhhise
    hrvghsnhhulhhlihdruhhspdhrtghpthhtohepohhstghmrggvshelvdesghhmrghilhdr
    tghomhdprhgtphhtthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhg
X-ME-Proxy: <xmx:qK1eaH_3a-MnimvuRT3uDa-QZk2IZHul7G8aYtqtmoblbBO0OcdsMg>
    <xmx:qK1eaGs_rFw57PSrWzhMDQEYmdz2Em5f3-H9kwHGhcwHL4LpXcyhdw>
    <xmx:qK1eaOG-2_edUTxn5VNl160HiOYKs0WcOdFjUSt4hbTX8kAoFLHKlw>
    <xmx:qK1eaFP9F36-8U7nwq3WY5vfABwP3R2XzDX9okbhW_hO1gnUMpHVAw>
    <xmx:qa1eaE625E9jtfGiEPUsye-_LdI9EwXtIQmgGMiBW-XvpoR8IjOWDdDA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jun 2025 10:41:43 -0400 (EDT)
Date: Fri, 27 Jun 2025 17:41:41 +0300
From: Ido Schimmel <idosch@idosch.org>
To: "dongchenchen (A)" <dongchenchen2@huawei.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	jiri@resnulli.us, oscmaes92@gmail.com, linux@treblig.org,
	pedro.netdev@dondevamos.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net] net: vlan: fix VLAN 0 refcount imbalance of toggling
 filtering during runtime
Message-ID: <aF6tpb4EQaxZ2XAw@shredder>
References: <20250623113008.695446-1-dongchenchen2@huawei.com>
 <20250624174252.7fbd3dbe@kernel.org>
 <900f28da-83db-4b17-b56b-21acde70e47f@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <900f28da-83db-4b17-b56b-21acde70e47f@huawei.com>

On Thu, Jun 26, 2025 at 11:41:45AM +0800, dongchenchen (A) wrote:
> maybe we can fix it by:
> 
> diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
> index 6e01ece0a95c..262f8d3f06ef 100644
> --- a/net/8021q/vlan.c
> +++ b/net/8021q/vlan.c
> @@ -378,14 +378,18 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
>              return notifier_from_errno(err);
>      }
> -    if ((event == NETDEV_UP) &&
> -        (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)) {
> +    if (((event == NETDEV_UP) &&
> +        (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)) ||
> +        (event == NETDEV_CVLAN_FILTER_PUSH_INFO &&
> +        (dev->flags & IFF_UP))) {
>          pr_info("adding VLAN 0 to HW filter on device %s\n",
>              dev->name);
>          vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
>      }
> -    if (event == NETDEV_DOWN &&
> -        (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
> +    if ((event == NETDEV_DOWN &&
> +        (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)) ||
> +        (event == NETDEV_CVLAN_FILTER_DROP_INFO &&
> +        (dev->flags & IFF_UP)))
>          vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
>     vlan_info = rtnl_dereference(dev->vlan_info);

As I understand it, there are two issues:

1. VID 0 is deleted when it shouldn't. This leads to the crashes you
shared.

2. VID 0 is not deleted when it should. This leads to memory leaks like
[1] with a reproducer such as [2].

AFAICT, your proposed patch solves the second issue, but only partially
addresses the first issue. The automatic addition of VID 0 is assumed to
be successful, but it can fail due to hardware issues or memory
allocation failures. I realize it is not common, but it can happen. If
you annotate __vlan_vid_add() [3] and inject failures [4], you will see
that the crashes still happen with your patch.

WDYT about something like [5]? Basically, noting in the VLAN info
whether VID 0 was automatically added upon NETDEV_UP and based on that
decide whether it should be deleted upon NETDEV_DOWN, regardless of
"rx-vlan-filter".

[1]
unreferenced object 0xffff888007468a00 (size 256):
  comm "ip", pid 386, jiffies 4294820761
  hex dump (first 32 bytes):
    00 20 26 0a 80 88 ff ff 00 00 00 00 00 00 00 00  . &.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 43031ab1):
    __kmalloc_cache_noprof+0x2b5/0x340
    vlan_vid_add+0x434/0x940
    vlan_device_event.cold+0x75/0xa8
    notifier_call_chain+0xca/0x150
    __dev_notify_flags+0xe3/0x250
    rtnl_configure_link+0x193/0x260
    rtnl_newlink_create+0x383/0x8e0
    __rtnl_newlink+0x22c/0xa40
    rtnl_newlink+0x627/0xb00
    rtnetlink_rcv_msg+0x6fb/0xb70
    netlink_rcv_skb+0x11f/0x350
    netlink_unicast+0x426/0x710
    netlink_sendmsg+0x75a/0xc20
    __sock_sendmsg+0xc1/0x150
    ____sys_sendmsg+0x5aa/0x7b0
    ___sys_sendmsg+0xfc/0x180
unreferenced object 0xffff888002fc3aa0 (size 32):
  comm "ip", pid 386, jiffies 4294820761
  hex dump (first 32 bytes):
    a0 8a 46 07 80 88 ff ff a0 8a 46 07 80 88 ff ff  ..F.......F.....
    81 00 00 00 01 00 00 00 cc cc cc cc cc cc cc cc  ................
  backtrace (crc c2f2186c):
    __kmalloc_cache_noprof+0x2b5/0x340
    vlan_vid_add+0x25a/0x940
    vlan_device_event.cold+0x75/0xa8
    notifier_call_chain+0xca/0x150
    __dev_notify_flags+0xe3/0x250
    rtnl_configure_link+0x193/0x260
    rtnl_newlink_create+0x383/0x8e0
    __rtnl_newlink+0x22c/0xa40
    rtnl_newlink+0x627/0xb00
    rtnetlink_rcv_msg+0x6fb/0xb70
    netlink_rcv_skb+0x11f/0x350
    netlink_unicast+0x426/0x710
    netlink_sendmsg+0x75a/0xc20
    __sock_sendmsg+0xc1/0x150
    ____sys_sendmsg+0x5aa/0x7b0
    ___sys_sendmsg+0xfc/0x180

[2]
#!/bin/bash

ip link add bond1 up type bond mode 0
ethtool -K bond1 rx-vlan-filter off
ip link del dev bond1

[3]
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index 9404dd551dfd..6dc25c4877f2 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -314,6 +314,7 @@ static int __vlan_vid_add(struct vlan_info *vlan_info, __be16 proto, u16 vid,
 	*pvid_info = vid_info;
 	return 0;
 }
+ALLOW_ERROR_INJECTION(__vlan_vid_add, ERRNO);
 
 int vlan_vid_add(struct net_device *dev, __be16 proto, u16 vid)
 {

[4]
#!/bin/bash

echo __vlan_vid_add > /sys/kernel/debug/fail_function/inject
printf %#x -12 > /sys/kernel/debug/fail_function/__vlan_vid_add/retval
echo 100 > /sys/kernel/debug/fail_function/probability
echo 1 > /sys/kernel/debug/fail_function/times
echo 1 > /sys/kernel/debug/fail_function/verbose
ip link add bond1 up type bond mode 0
ip link add link bond1 name vlan0 type vlan id 0 protocol 802.1q
ip link set dev bond1 down
ip link del vlan0
ip link del dev bond1

[5]
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 06908e37c3d9..9a6df8c1daf9 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -357,6 +357,35 @@ static int __vlan_device_event(struct net_device *dev, unsigned long event)
 	return err;
 }
 
+static void vlan_vid0_add(struct net_device *dev)
+{
+	struct vlan_info *vlan_info;
+	int err;
+
+	if (!(dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
+		return;
+
+	pr_info("adding VLAN 0 to HW filter on device %s\n", dev->name);
+
+	err = vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
+	if (err)
+		return;
+
+	vlan_info = rtnl_dereference(dev->vlan_info);
+	vlan_info->auto_vid0 = true;
+}
+
+static void vlan_vid0_del(struct net_device *dev)
+{
+	struct vlan_info *vlan_info = rtnl_dereference(dev->vlan_info);
+
+	if (!vlan_info || !vlan_info->auto_vid0)
+		return;
+
+	vlan_info->auto_vid0 = false;
+	vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
+}
+
 static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 			     void *ptr)
 {
@@ -378,15 +407,10 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 			return notifier_from_errno(err);
 	}
 
-	if ((event == NETDEV_UP) &&
-	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER)) {
-		pr_info("adding VLAN 0 to HW filter on device %s\n",
-			dev->name);
-		vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
-	}
-	if (event == NETDEV_DOWN &&
-	    (dev->features & NETIF_F_HW_VLAN_CTAG_FILTER))
-		vlan_vid_del(dev, htons(ETH_P_8021Q), 0);
+	if (event == NETDEV_UP)
+		vlan_vid0_add(dev);
+	else if (event == NETDEV_DOWN)
+		vlan_vid0_del(dev);
 
 	vlan_info = rtnl_dereference(dev->vlan_info);
 	if (!vlan_info)
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index 5eaf38875554..c7ffe591d593 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -33,6 +33,7 @@ struct vlan_info {
 	struct vlan_group	grp;
 	struct list_head	vid_list;
 	unsigned int		nr_vids;
+	bool			auto_vid0;
 	struct rcu_head		rcu;
 };


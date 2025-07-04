Return-Path: <netdev+bounces-204192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD37DAF971D
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 17:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BDE5670AF
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B661C3C18;
	Fri,  4 Jul 2025 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z0dTFawj"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529CD19F40A;
	Fri,  4 Jul 2025 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751643613; cv=none; b=UscBUv8AI27/+dbl9DbHnqAD353yMXWRet1n6+o0rN8l3A3OW63Bbbdj6B4zhzxr+jkRPoNWgc4HN40/Q2Bn9X6Nfn9KKflNCD7PUfNlieoKc8IIYpbHn8Xz8HdIS0tptwJuj6wqmgCs1D56ocwtZDmxYd/nB9nH22sdQui2W6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751643613; c=relaxed/simple;
	bh=4YRgImUlmsihMhxakIbAa0RoevCDXHu4IEFIFlW3g1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDLLt3I47JLdagvvYQA76Se6BrfeGn14+5rb3wseJloT2cfZyZc9avCaqro4vF19GiyU9v19gvgxGIHl1ZulIUo2r666kHx5rnHDi0yjmgoB3LcaRG7xhzsLobxWmjupx7SyJEF8DzFCexvAKUzaeegmWAuTcUsmk4LGg1Xn4a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z0dTFawj; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B4E9EC024F;
	Fri,  4 Jul 2025 11:40:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 04 Jul 2025 11:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751643609; x=1751730009; bh=+aBHmF+KAl8tS0LuKfJu8smtZYUktGCy8B/
	GH5AQM0o=; b=Z0dTFawjdcr8y3kPBebllhVHlxfOmLOZkGq7/Eo+7N2IMEC6LaE
	EP6fFxMBJ24C9tlQOacT4c7wfPC00o6queLVf8gcPmFJKlviTc1YtuBBjf05xDXL
	62R28Sbu3i/KySMCWhz56OhTl5ov72diWwDOjQsN+uURC5CeNpbszxMz27y/MrmO
	vsGJ+uOWt963Xa5ncyB2WT/RTNr6NYNAOi8b94S6tLkuz7k+2ry0PLiByFV0Pu9d
	G+6su1uQbbz4CPnvtnbYZ8jWXlSjiGzmbSY9ZKCjR+0ZNfcRjCIdYt5sLA9Z4oBE
	67yFyGJ09SdSH1pdjwKVyqt+g/G8aN0luBQ==
X-ME-Sender: <xms:2PVnaNyw0CorFFAylpyQTWeCQoK7skQCUFLkdaEKEIYDuH87BTVgcA>
    <xme:2PVnaNQRh9SzzOidGJyjsgLaQxxH5OwoAskoTZKebQMSsokfzgLCzZhoReMBG7qbq
    cMGa_nhKOm8C34>
X-ME-Received: <xmr:2PVnaHVnVxbrr7qGqQdl7oOHypVZaAHoJ3dG3pjKPW3Fl_xY77Xz-8epzocCAt4RlvZLQvb5g7Ct2P4z51TGZL11G-BU0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvfeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpeevgeeguefgudeuudeuveelgefgjeeftdelgeffgfejjeduudfffefftddthedtteen
    ucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihgu
    ohhstghhrdhorhhgpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepughonhhgtghhvghntghhvghnvdeshhhurgifvghirdgtohhmpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumh
    griigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoh
    ephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhirhhisehrvghsnhhu
    lhhlihdruhhspdhrtghpthhtohepohhstghmrggvshelvdesghhmrghilhdrtghomhdprh
    gtphhtthhopehlihhnuhigsehtrhgvsghlihhgrdhorhhg
X-ME-Proxy: <xmx:2PVnaPiW6SRrvs2OiqoVF7vdD4nhsDD5pK8Fh6DlUfrBe8jQDRvGGg>
    <xmx:2PVnaPDb-w1l2OJxHAPKZnTsQumVmwAcuYkNfxtIORm_vckv2Bxx2w>
    <xmx:2PVnaILh_J3XGstM8wFQGxV2kiTLWhGp8sD5TCs7UEx4ULMHWWZmNw>
    <xmx:2PVnaOBhvIlspOA_8-cgCSbMZsi-3czaxjhfwQpkQBcy6qb4epSJ2A>
    <xmx:2fVnaMSKfRx_YxNcWWFj4ig6hze2Lkk-_omsIDMB1EfK1N_QCyW9V9NK>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 11:40:07 -0400 (EDT)
Date: Fri, 4 Jul 2025 18:40:04 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
	oscmaes92@gmail.com, linux@treblig.org, pedro.netdev@dondevamos.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH net v2 1/2] net: vlan: fix VLAN 0 refcount imbalance of
 toggling filtering during runtime
Message-ID: <aGf11IS6Blvz_XOm@shredder>
References: <20250703075702.1063149-1-dongchenchen2@huawei.com>
 <20250703075702.1063149-2-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703075702.1063149-2-dongchenchen2@huawei.com>

On Thu, Jul 03, 2025 at 03:57:01PM +0800, Dong Chenchen wrote:
> 8021q(vlan_device_event) will add VLAN 0 when enabling the device, and
> remove it on disabling it if NETIF_F_HW_VLAN_CTAG_FILTER set.
> However, if changing filter feature during netdev runtime,
> null-ptr-unref[1] or bug_on[2] will be triggered by unregister_vlan_dev()
> for refcount imbalance.

[...]

> Root cause is as below:
> step1: add vlan0 for real_dev, such as bond, team.
> register_vlan_dev
>     vlan_vid_add(real_dev,htons(ETH_P_8021Q),0) //refcnt=1
> step2: disable vlan filter feature and enable real_dev
> step3: change filter from 0 to 1
> vlan_device_event
>     vlan_filter_push_vids
>     	ndo_vlan_rx_add_vid //No refcnt added to real_dev vlan0
> step4: real_dev down
> vlan_device_event
>     vlan_vid_del(dev, htons(ETH_P_8021Q), 0); //refcnt=0
>         vlan_info_rcu_free //free vlan0
> step5: real_dev up
> vlan_device_event
>     vlan_vid_add(dev, htons(ETH_P_8021Q), 0);
>         vlan_info_alloc //alloc new empty vid0. refcnt=1
> step6: delete vlan0
> unregister_vlan_dev
>     BUG_ON(!vlan_info); //will trigger it if step5 was not executed
>     vlan_group_set_device
>         array = vg->vlan_devices_arrays
> 	//null-ptr-ref will be triggered after step5
> 
> E.g. the following sequence can reproduce null-ptr-ref
> 
> $ ip link add bond0 type bond mode 0
> $ ip link add link bond0 name vlan0 type vlan id 0 protocol 802.1q
> $ ethtool -K bond0 rx-vlan-filter off
> $ ifconfig bond0 up
> $ ethtool -K bond0 rx-vlan-filter on
> $ ifconfig bond0 down
> $ ifconfig bond0 up
> $ ip link del vlan0
> 
> Add the auto_vid0 flag to track the refcount of vlan0, and use this
> flag to determine whether to dec refcount while disabling real_dev.
> 
> Fixes: ad1afb003939 ("vlan_dev: VLAN 0 should be treated as "no vlan tag" (802.1p packet)")
> Reported-by: syzbot+a8b046e462915c65b10b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a8b046e462915c65b10b
> Co-developed-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>

Given my name is also on the patch, do you mind making the commit
message a bit clearer? Specifically, in addition to the BUG_ON(), it
would be good to also describe the memory leak. Something like this:

"
Assuming the "rx-vlan-filter" feature is enabled on a net device, the
8021q module will automatically add or remove VLAN 0 when the net device
is put administratively up or down, respectively.

There are a couple of problems with the above scheme. The first problem
is a memory leak that can happen if the "rx-vlan-filter" feature is
disabled while the device is running:

 # ip link add bond1 up type bond mode 0
 # ethtool -K bond1 rx-vlan-filter off
 # ip link del dev bond1

When the device is put administratively down the "rx-vlan-filter"
feature is disabled, so the 8021q module will not remove VLAN 0 and the
memory will be leaked [1].

Another problem that can happen is that the kernel can automatically
delete VLAN 0 when the device is put administratively down despite not
adding it when the device was put administratively up since during that
time the "rx-vlan-filter" feature was disabled.

This is not a problem if VLAN 0 does not exist, but if it belongs to an
upper VLAN device with VLAN ID 0, then a crash [2] can be triggered when the
VLAN device is deleted since the lower device does not have a VLAN info
structure associated with it:

 # ip link add bond1 type bond mode 0
 # ip link add link bond1 name vlan0 type vlan id 0 protocol 802.1q
 # ethtool -K bond1 rx-vlan-filter off
 # ip link set dev bond1 up
 # ethtool -K bond1 rx-vlan-filter on
 # ip link set dev bond1 down
 # ip link del vlan0

Fix both problems by noting in the VLAN info whether VLAN 0 was
automatically added upon NETDEV_UP and based on that decide whether it
should be deleted upon NETDEV_DOWN, regardless of the state of the
"rx-vlan-filter" feature.

[1]
unreferenced object 0xffff8880068e3100 (size 256):
  comm "ip", pid 384, jiffies 4296130254
  hex dump (first 32 bytes):
    00 20 30 0d 80 88 ff ff 00 00 00 00 00 00 00 00  . 0.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 81ce31fa):
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
unreferenced object 0xffff888008c06f20 (size 32):
  comm "ip", pid 384, jiffies 4296130254
  hex dump (first 32 bytes):
    a0 31 8e 06 80 88 ff ff a0 31 8e 06 80 88 ff ff  .1.......1......
    81 00 00 00 01 00 00 00 cc cc cc cc cc cc cc cc  ................
  backtrace (crc fe715fa5):
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
kernel BUG at net/8021q/vlan.c:99!
Oops: invalid opcode: 0000 [#1] SMP KASAN
CPU: 4 UID: 0 PID: 405 Comm: ip Not tainted 6.16.0-rc4-virtme-gb9fd9888a565 #1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41 04/01/2014
RIP: 0010:unregister_vlan_dev+0x290/0x3b0
[...]
Call Trace:
 <TASK>
 rtnl_dellink+0x33d/0xa50
 rtnetlink_rcv_msg+0x6fb/0xb70
 netlink_rcv_skb+0x11f/0x350
 netlink_unicast+0x426/0x710
 netlink_sendmsg+0x75a/0xc20
 __sock_sendmsg+0xc1/0x150
 ____sys_sendmsg+0x5aa/0x7b0
 ___sys_sendmsg+0xfc/0x180
 __sys_sendmsg+0x124/0x1c0
 do_syscall_64+0xbb/0x360
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
"


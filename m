Return-Path: <netdev+bounces-153658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE449F9142
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 12:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9BC1881F25
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FD51C5CB1;
	Fri, 20 Dec 2024 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhdOJHHr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF51C5CAC;
	Fri, 20 Dec 2024 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734694065; cv=none; b=Ip6LMJAGfly3iaaVaqLQlouSYFY0RMCiEep/KW4y3NkZXWQiT8umpK5o84T6hJjWTR/Iys2jZXJdbaP03xZnlRQT8F0StRwTxgLFIfNm3mwTJpMMTt23LWZlCSCn0BIHP2kxhTtCuTY6Df79CeTsBd3V2jmgWUIdHdWx6RPruzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734694065; c=relaxed/simple;
	bh=WMFAjpjKlQFIIGyiOs+yaDfqRXHyroAkmhM2s2h4/v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSaeQ+RLyFlGeQYCFBIjv4CIjYSud6cL0Xkv2N+8QBQajZix2HJ87www7jOZXONWaksZmBWehntpJ1n4AK52Tcz7zb8IzFYuPkKnU2VdaHCNNlTVTmLH7zbIlPNR+44eGFYyoBNJZmRHxHAIFRMEgKVXsja+4cCztwSV6mV2n1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhdOJHHr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862f11a13dso187472f8f.2;
        Fri, 20 Dec 2024 03:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734694062; x=1735298862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PpZcz+6ghT9z/8AB9BJnGTiomPpWzFFE6S3jVzDuZ6U=;
        b=XhdOJHHrxFKjqbw9vGTDlDqOrK1tDq423Df5UrRcd6ZSEJRfXmNybfyxBgpXur9KFg
         rFGrAXMe8WHdSkh5k8VjQKAv0RAAdyAkVMSv3ztpS1IUssfBXcGVbnRwxXYGZWi2+sdQ
         aDtbZV3DPVdwwWVKXLEXNWzzFLNLbMgE/hfRY172nDZ6ksVdSB+e1g+UHBIt1YSKQ7fk
         P7+7/RZVt/nxc4yJzXs36KzQgVS+NS8FA6YejO6yPq0N4214WAyLePglbybE7/CWkqbJ
         9ODYi7zYRWHH6U9CMnmyeD8RRnazWn8TT3fm6Pk2tssHd/HSUEyJbmg3Za3pbm1OIXn0
         TzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734694062; x=1735298862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpZcz+6ghT9z/8AB9BJnGTiomPpWzFFE6S3jVzDuZ6U=;
        b=AVF4Hd2JG/Z8kqiuhfjLeK+7/l9jRcp7LNVrcfNqT+nfgbribtb1Nb+GtORvn9OuNS
         mbpPSUBKRp42zosSPjlWfRmUWNH7YxO0ltKqdKgui0nJrGSFSZYB22tKg8RrIQlNwXt3
         Jgfq+SZ0GuOpLzGztpjgx4tYHWveje/2pmxquf4B/cdzWdGsEqj0m8KEg4bnl6xIIuu5
         vuqhNUk+x9D/xdoSho1bruVdBfvD21785kpRADPyzVzRxxMNlFcAlnHNv4LYmp9xZpNC
         aEIne0OcjQObg5QXhL7E3Y9xSVQJPVyEfLS4QGbxcSDGMCHqf7val9Uj/m+HPCBt609E
         bV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1yBVUZ++gb2WMVHnxnStrE3cquOztxg0h5DPGPVr4Gxr9zDMyLO/6XrSXavCab7B7FMXj79JI@vger.kernel.org, AJvYcCVeJPKFFpbPVtO0vaU9aanElBA+b9jFkkIYaFmr46bCPKAdxzZ0F/gci/FAx/LunNdHRRyT0nEJ5DFLC2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1rYLRcbCgt0KNkqmjqZjz7gvHZ1z2ta0mcNbKMUkXpuz08Ma
	cXhrTL9DFl5BAssHQvFZe+25nar+hgQyjV0Pe6fyew0ZSzEy5F9iOHHDi6l1PWQ=
X-Gm-Gg: ASbGncuXIJwMP8eGN/BMjQ/NbsIN2lCzX5hlZyLGRQFMOci88FgZgmemlgIlNU+CQEM
	pi68sbc/Bgnv9fhMYZUQ2yUlJMLr2x74nAgJnKU/d/tziwjTqZt4rexLwfH4vzdXryo1i7dZFDf
	EkggqzZHUNoIlhBF5gwgQ/vw2H43LBJmCOByxHNXDW6OUhAcPN8blkCouF+/uQraBHoJ3y7ZDLI
	+BNy1+SX7PmfNTKIcm8ZqfNBerSSLx2VfsbjvMnxEAZ
X-Google-Smtp-Source: AGHT+IGyNF41vGBuLe9OigoQ/l95rLGuRGj87gn9ympIA+Fl72VXjDIJ1VDLKPoGvAs1b15xfO5v1w==
X-Received: by 2002:a05:6000:70a:b0:385:df73:2f43 with SMTP id ffacd0b85a97d-38a221e20ecmr949564f8f.2.1734694061817;
        Fri, 20 Dec 2024 03:27:41 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c829015sm3828515f8f.13.2024.12.20.03.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 03:27:41 -0800 (PST)
Date: Fri, 20 Dec 2024 13:27:38 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: jiang.kun2@zte.com.cn
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	hehe.peilin@zte.com.cn, xu.xin16@zte.com.cn, fan.yu9@zte.com.cn,
	qiu.yutan@zte.com.cn, wang.yaxin@zte.com.cn, tu.qiang35@zte.com.cn,
	yang.yang29@zte.com.cn, ye.xingchen@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re: [PATCH linux next] net:dsa:fix the dsa_ptr null pointer
 dereference
Message-ID: <20241220112738.7maahbhxi2fnaven@skbuf>
References: <20241220140516563WDQ_X40bt0ZOch3Qte1YO@zte.com.cn>
 <20241220140516563WDQ_X40bt0ZOch3Qte1YO@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220140516563WDQ_X40bt0ZOch3Qte1YO@zte.com.cn>
 <20241220140516563WDQ_X40bt0ZOch3Qte1YO@zte.com.cn>

Hello Kun Jiang,

On Fri, Dec 20, 2024 at 02:05:16PM +0800, jiang.kun2@zte.com.cn wrote:
> From: Peilin He<he.peilin@zte.com.cn>
> 
> Issue
> =====
> Repeatedly accessing the DSA Ethernet controller via the ethtool command,
> followed by a system reboot, may trigger a DSA null pointer dereference,
> causing a kernel panic and preventing the system from rebooting properly.
> This can lead to data loss or denial-of-service, resulting in serious 
> consequences.
> 
> The original problem occurred in the Linux kernel version 5.4.19.
> The following is the panic log:
> 
> [  172.523467] Unable to handle kernel NULL pointer dereference at virtual 
> address 0000000000000020
> [  172.532455] Mem abort info:
> [  172.535313] printk: console [ttyS0]: printing thread stopped
> [  172.536352]   ESR = 0x0000000096000006
> [  172.544926]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  172.550321]   SET = 0, FnV = 0
> [  172.553427]   EA = 0, S1PTW = 0
> [  172.556646]   FSC = 0x06: level 2 translation fault
> [  172.561604] Data abort info:
> [  172.564563]   ISV = 0, ISS = 0x00000006
> [  172.568466]   CM = 0, WnR = 0
> [  172.571502] user pgtable: 4k pages, 48-bit VAs, pgdp=00000020a4b34000
> [  172.578058] [0000000000000020] pgd=08000020a4ce6003, p4d=08000020a4ce6003, 
> pud=08000020a4b4d003, pmd=0000000000000000
> [  172.588785] Internal error: Oops: 96000006 [#1] PREEMPT_RT SMP
> [  172.594641] Modules linked in: r8168(O) bcmdhd(O) ossmod(O) tipc(O)
> [  172.600933] CPU: 1 PID: 548 Comm: lldpd Tainted: G           O      
> [  172.610795] Hardware name: LS1028A RDB Board (DT)
> [  172.615508] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  172.622492] pc : dsa_master_get_sset_count+0x24/0xa4
> [  172.627475] lr : ethtool_get_drvinfo+0x8c/0x210
> [  172.632020] sp : ffff80000c233a90
> [  172.635338] x29: ffff80000c233a90 x28: ffff67ad21e45a00 x27: 0000000000000000
> [  172.642498] x26: 0000000000000000 x25: 0000ffffd1102110 x24: 0000000000000000
> [  172.649657] x23: 00020100001149a9 x22: 0000ffffd1102110 x21: 0000000000000000
> [  172.656816] x20: 0000000000000000 x19: ffff67ad00bbe000 x18: 0000000000000000
> [  172.663974] x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffd1102110
> [  172.671132] x14: ffffffffffffffff x13: 30322e344230342e x12: 33302e37564c4547
> [  172.678290] x11: 0000000000000020 x10: 0101010101010101 x9 : ffffd837fcebe6fc
> [  172.685448] x8 : 0101010101010101 x7 : 6374656e655f6c73 x6 : 74656e655f6c7366
> [  172.692606] x5 : ffff80000c233b01 x4 : ffffd837fdae0251 x3 : 0000000000000063
> [  172.699764] x2 : ffffd837fd076da0 x1 : 0000000000000000 x0 : ffff67ad00bbe000
> [  172.706923] Call trace:
> [  172.709371]  dsa_master_get_sset_count+0x24/0xa4
> [  172.714000]  ethtool_get_drvinfo+0x8c/0x210
> [  172.718193]  dev_ethtool+0x780/0x2120
> [  172.721863]  dev_ioctl+0x1b0/0x580
> [  172.725273]  sock_do_ioctl+0xc0/0x100
> [  172.728944]  sock_ioctl+0x130/0x3c0
> [  172.732440]  __arm64_sys_ioctl+0xb4/0x100
> [  172.736460]  invoke_syscall+0x50/0x120
> [  172.740219]  el0_svc_common.constprop.0+0x4c/0xf4
> [  172.744936]  do_el0_svc+0x2c/0xa0
> [  172.748257]  el0_svc+0x20/0x60
> [  172.751318]  el0t_64_sync_handler+0xe8/0x114
> [  172.755599]  el0t_64_sync+0x180/0x184
> [  172.759271] Code: a90153f3 2a0103f4 a9025bf5 f9418015 (f94012b6)
> [  172.765383] ---[ end trace 0000000000000002 ]---
> 
> Root Cause
> ==========
> Analysis of linux-next-6.13.0-rc3 reveals that the 
> dsa_conduit_get_sset_count() function accesses members of 
> a structure pointed to by cpu_dp without checking 
> if cpu_dp is a null pointer. This can lead to a kernel panic 
> if cpu_dp is NULL.
> 
> 	static int dsa_conduit_get_sset_count(struct net_device *dev, 
>                                         int sset)
> 	{
> 		struct dsa_port *cpu_dp = dev->dsa_ptr;
> 		const struct ethtool_ops *ops = cpu_dp->orig_ethtool_ops;
> 		struct dsa_switch *ds = cpu_dp->ds;
> 		...
> 	}
> 
> dev->dsa_ptr is set to NULL in both the dsa_switch_shutdown and
> dsa_conduit_teardown functions.  When the DSA module unloads,
> dsa_conduit_ethtool_teardown(dev) restores the original copy of the DSA 
> device's ethtool_ops using  "dev->ethtool_ops = cpu_dp->orig_ethtool_ops;"
> before setting dev->dsa_ptr to NULL. This ensures that ethtool_ops
> remains accessible after DSA unloading. However, dsa_switch_shutdown does 
> not restore the original copy of the DSA device's ethtool_ops, potentially 
> leading to a null pointer dereference of dsa_ptr and subsequently a system 
> panic.
> 
> Solution
> ========
> In the kernel's dsa_switch_shutdown function, before dp->conduit->dsa_ptr
> is set to NULL, the dsa_conduit_ethtool_shutdown function is called to
> restore the DSA master's ethtool_ops pointer to its original value.
> This prevents the kernel from entering the DSA ethtool_ops flow even if
> the user executes ethtool, thus avoiding the null pointer dereference issue
> with dsa_ptr.
> 
> Signed-off-by: Peilin He<he.peilin@zte.com.cn>
> Co-developed-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: Kun Jiang <jiang.kun2@zte.com.cn>
> Cc: Fan Yu <fan.yu9@zte.com.cn>
> Cc: Yutan Qiu <qiu.yutan@zte.com.cn>
> Cc: Yaxin Wang <wang.yaxin@zte.com.cn>
> Cc: tuqiang <tu.qiang35@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: ye xingchen <ye.xingchen@zte.com.cn>
> Cc: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> 
> ---

Thank you for the patch.

There are many process problems with it however.

The most glaring one is that you are examining a crash from kernel 5.4
but patching linux-next, without having apparently also tested linux-next.
It appears that you just made a static analysis which may result in
incorrect conclusions. When submitting patches upstream you always have
to test on the latest version and understand afterwards what is missing
and needs to be backported in the particular stable version you are using.

In particular here, dsa_switch_shutdown() now has this:

	dsa_switch_for_each_user_port(dp, ds) {
		conduit = dsa_port_to_conduit(dp);
		user_dev = dp->user;

		netif_device_detach(user_dev);
		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		netdev_upper_dev_unlink(conduit, user_dev);
	}

After netif_device_detach() is called, my expectation is that
ethnl_ops_begin() sees that netif_device_present() is false, so it
returns -ENODEV and does not proceed further to call into the device's
ethtool ops. So that eliminates the premise for the crash.

Secondly, linux-next is not a kernel tree that accepts patches, it is
just for integration. For netdev, we have net.git for bug fixes and
net-next.git for new features. You have to target your patch to net.git
by using "[PATCH net v1]".

If the problem does not exist in net.git but exists in stable kernels,
you have to identify which patches are missing, adapt them if necessary,
and then send them to stable@vger.kernel.org, with netdev and the other
maintainers also CCed, and with a subject prefix along the lines of
"[PATCH stable 5.4]". Generally, backporting patches manually to stable
is rarely needed, so if that needs to happen, please use the space under
the "---" marker (this is discarded when applying the patch in git) to
explain to maintainers why (what conflicted, if it simply appears to
have been missed, etc).

There are other things to be aware of in Documentation/process/, I just
summarized to you what I considered most relevant here.


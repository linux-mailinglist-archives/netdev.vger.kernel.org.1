Return-Path: <netdev+bounces-293943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBR/LRIrHmqHhgkAu9opvQ
	(envelope-from <netdev+bounces-293943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 03:00:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CADB626C20
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 03:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 298E1300CBDB
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EF624A078;
	Tue,  2 Jun 2026 00:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvxT8V1X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F48814B08A
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 00:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780361958; cv=none; b=X3ALkYRoj3LjIebGg5zK0RX72usy2oohuLLj1F7J6iznXYRAAeIlkAMvluGo8Vf9j2vuzz/vQgghYwTOWA78fePI/K91VaGD5DCoThh+mlGlWshuEMlEIHCVRd/9FPQhCV5/oG3PY6HTXSUeUvPULqVbulQbZyf6oh2UBxakpbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780361958; c=relaxed/simple;
	bh=zp5gmOZ4M2kxkp0TmNAVEu6eGVxqVII10fbtZY2h2Dk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MZOgahc/OlW+Pei88WDQnyPhUTq3pQZy98o20R97uM7Z1VBncRObOsqDMW4uSeg6TzZf3joNv/SHYTYZtx8aqrF12xnTb7PT9oG6n7ydTrvPw0yFl1j4TaCUzSB5fULBQtnqB0yYdNVPd6YxJkov8ZZiTH6/Hx4PISWon8Y+c/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kvxT8V1X; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d98b76d12so1380031a91.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 17:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780361956; x=1780966756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ueDdGf0a3mgbSo2P2eQiXFpGPTxajTccFhUccRTE7wM=;
        b=kvxT8V1XGZDbhGFc4MrLlBYJSGNgtT+IK1Zo+/Os7MVC7/V4PowWXxXowy3MQyoLfb
         gFtb8hnHnJZm+LgfLH36RFE2BJ+QFoQiWxxQsHvKostDZtZmL2v/pLiSlRFP2i0UJYDm
         nHB4uhPTGc+uyndu6Afu4As+9Ebp1dB1Lz8rpQfBeuSEBALPw0jp2vWUSuIu5TzzqpfD
         pxNzt6cZpTXIyV8FfHICew6vcNYO2zhAm/hWcJTPpHM2EZiChYxLJjf7Ad0kz6JTFIzt
         M83UeF8UiLKxMcWUfgT27xUiBelEhAsMGJEfKTGNlzJ8eDtcJ01Cr1EOc/c9GNhL/DAo
         6czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780361956; x=1780966756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ueDdGf0a3mgbSo2P2eQiXFpGPTxajTccFhUccRTE7wM=;
        b=emmS/zuaVrqAD6UPagskkAOBvoZ0lE0N14NLQd3b8trIwkF0Uz1cdVVzEueyjiHs8v
         jSz0CabY76H+LXOkNh8NA3d72q3Ow34RzzKkgbSEO3XWY1Be0xShZLOlES2+TnNj9LfF
         8MrhCUFEalYJ55+FG9JQnmtGTZJxLXDXciBPktk+NOm3DeESlynjrfvg+leNgyHnNlq3
         nG/E1N9Yo8GfiPxfHEnWLiUbgWJkZjFpaMt5K6nw9ekhEU7xIVSUO82j7cpAOTcEAFuW
         qi5aGqaYEFEM2UTxC/wWO4VnTsI0GUrixYK9q6Z3Q2zzu9kjfjbuGtWX2rmoWz1psiqM
         cfng==
X-Forwarded-Encrypted: i=1; AFNElJ/LbHmCji1+2uKp2Y62ZK/4p1QC7IpdUTjKHRzbACY/+lZIw8VVAcocDrf3Rn05apRYfCOl0kI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzno0hp5xEcP7TP63sFppBt8dhX2PWa6ICpKfW5OBN6LASjyf01
	S9VNNmPiGCAZPcc59XR8+99iuynyD1nlDJduhIGnU4hWSGYe6G73dItwjYclh0UBKK1n0CBzQmU
	YxTf1XQ==
X-Received: from pjbmd5.prod.google.com ([2002:a17:90b:23c5:b0:36a:f1b9:c389])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ed0:b0:36b:88c4:46f0
 with SMTP id 98e67ed59e1d1-36c501dff00mr13385496a91.14.1780361956326; Mon, 01
 Jun 2026 17:59:16 -0700 (PDT)
Date: Tue,  2 Jun 2026 00:58:26 +0000
In-Reply-To: <20260601061304.344248-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601061304.344248-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602005915.3474979-1-kuniyu@google.com>
Subject: Re: [PATCH net-next] macvlan: fix use-after-free of macvlan_port in macvlan_fill_info()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: jiayuan.chen@linux.dev
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-293943-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 1CADB626C20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Mon,  1 Jun 2026 14:13:03 +0800
> This issue was reported by our internal syzkaller [1].
> 
> rtnl_link_ops->macvlan_fill_info() reads and dereferences
> 'port = vlan->port'.
> 
> However, when we delete the underlying physical device of a
> macvlan (e.g., eth0), we traverse all child macvlan devices and call
> ndo_uninit -> macvlan_uninit.
> 
> Each child goes through ndo_uninit -> macvlan_uninit, which
> synchronously kfree()s the shared port once the last child is gone, but
> does not clear vlan->port. The child netdevice itself is NOT freed here:
> its free_netdev() is deferred to netdev_run_todo(), and a concurrent
> rtnl_getlink() additionally holds a reference via netdev_hold(). So the
> netdevice stays alive with a now-dangling vlan->port, which
> macvlan_fill_info() later dereferences -> use-after-free.
> 
> Here, we set vlan->port = NULL after kfree(port), and then add a NULL check
> in macvlan_fill_info(). Both kfree(port) and vlan->port = NULL are atomic
> under the protection of the rtnl lock, so this is safe.
> 
> In macvlan_fill_info(), if port does not exist, we should simply ignore it
> and not goto nla_put_failure; otherwise, it would trigger WARN_ON_ONCE(1)
> in rtnl_getlink().

The splat implies the same class of issues in other devices, so
I don't think this macvlan-specific fix is the right approach.

We should give up dumping if dev->reg_state is not NETREG_REGISTERED
after acquiring RTNL, and I think Eric was preparing such a patch ?

https://lore.kernel.org/netdev/CANn89i+UMyx-rKO0ScZkcJYG_vk=_kddcQC+SxbbYSEyUTPgGw@mail.gmail.com/


> 
> vlan->port has no concurrent reader either (all under rtnl_lock, the
> lockless xmit path is quiesced before macvlan_uninit()), so no
> READ_ONCE()/WRITE_ONCE() is needed.
> 
> Before the blamed commit, rtnl_getlink() ran __dev_get_by_index() and
> rtnl_fill_ifinfo() entirely under rtnl_lock, so it could not race with
> macvlan_uninit().
> 
> [1]:
> '''
> BUG: KASAN: slab-use-after-free in macvlan_fill_info drivers/net/macvlan.c:1740
> 
> Call Trace:
>  <TASK>
>  macvlan_fill_info+0x681/0x750 drivers/net/macvlan.c:1740
>  rtnl_link_info_fill net/core/rtnetlink.c:905 [inline]
>  rtnl_link_fill net/core/rtnetlink.c:926 [inline]
>  rtnl_fill_ifinfo.isra.0+0x2ba7/0x4d70 net/core/rtnetlink.c:2185
>  rtnl_getlink+0x9b7/0xfc0 net/core/rtnetlink.c:4280
>  rtnetlink_rcv_msg+0x80f/0xd60 net/core/rtnetlink.c:7062
>  netlink_rcv_skb+0x15f/0x430 net/netlink/af_netlink.c:2556
>  rtnetlink_rcv+0x21/0x40 net/core/rtnetlink.c:7089
>  netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>  netlink_unicast+0x6ef/0xb50 net/netlink/af_netlink.c:1345
>  netlink_sendmsg+0x8d8/0xd70 net/netlink/af_netlink.c:1900
>  sock_sendmsg_nosec net/socket.c:787 [inline]
> 
> Allocated by task 5163:
>  macvlan_port_create drivers/net/macvlan.c:1260 [inline]
>  macvlan_common_newlink+0x45a/0x1ab0 drivers/net/macvlan.c:1498
>  macvlan_newlink+0x2a/0x40 drivers/net/macvlan.c:1596
>  rtnl_newlink_create net/core/rtnetlink.c:3905 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:4036 [inline]
>  rtnl_newlink+0xd38/0x2360 net/core/rtnetlink.c:4151
>  rtnetlink_rcv_msg+0x80f/0xd60 net/core/rtnetlink.c:7062
>  netlink_rcv_skb+0x15f/0x430 net/netlink/af_netlink.c:2556
>  rtnetlink_rcv+0x21/0x40 net/core/rtnetlink.c:7089
>  netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>  netlink_unicast+0x6ef/0xb50 net/netlink/af_netlink.c:1345
>  netlink_sendmsg+0x8d8/0xd70 net/netlink/af_netlink.c:1900
>  sock_sendmsg_nosec net/socket.c:787 [inline]
> 
> Freed by task 5166:
>  macvlan_port_destroy+0x3c5/0x630 drivers/net/macvlan.c:1319
>  macvlan_uninit+0xf5/0x140 drivers/net/macvlan.c:977
>  unregister_netdevice_many_notify+0x108f/0x2140 net/core/dev.c:12454
>  unregister_netdevice_many+0x1e/0x30 net/core/dev.c:12496
>  macvlan_device_event+0x477/0x880 drivers/net/macvlan.c:1856
>  notifier_call_chain+0xb7/0x330 kernel/notifier.c:85
>  raw_notifier_call_chain+0x32/0x50 kernel/notifier.c:453
>  call_netdevice_notifiers_info+0xa7/0x100 net/core/dev.c:2249
>  call_netdevice_notifiers_extack net/core/dev.c:2287 [inline]
>  call_netdevice_notifiers net/core/dev.c:2301 [inline]
>  unregister_netdevice_many_notify+0xde2/0x2140 net/core/dev.c:12435
>  rtnl_delete_link net/core/rtnetlink.c:3593 [inline]
>  rtnl_dellink+0x3db/0xaf0 net/core/rtnetlink.c:3635
>  rtnetlink_rcv_msg+0x80f/0xd60 net/core/rtnetlink.c:7062
>  netlink_rcv_skb+0x15f/0x430 net/netlink/af_netlink.c:2556
>  rtnetlink_rcv+0x21/0x40 net/core/rtnetlink.c:7089
>  netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
>  netlink_unicast+0x6ef/0xb50 net/netlink/af_netlink.c:1345
>  netlink_sendmsg+0x8d8/0xd70 net/netlink/af_netlink.c:1900
>  sock_sendmsg_nosec net/socket.c:787 [inline]
> '''
> 
> Fixes: e896e5c0734b ("rtnetlink: do not acquire RTNL in rtnl_getlink() with RTEXT_FILTER_NAME_ONLY")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  drivers/net/macvlan.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index c40fa331836b..4ff3a4de972e 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -975,6 +975,8 @@ static void macvlan_uninit(struct net_device *dev)
>  	port->count -= 1;
>  	if (!port->count)
>  		macvlan_port_destroy(port->dev);
> +
> +	vlan->port = NULL;
>  }
>  
>  static void macvlan_dev_get_stats64(struct net_device *dev,
> @@ -1736,12 +1738,14 @@ static int macvlan_fill_info(struct sk_buff *skb,
>  	}
>  	if (nla_put_u32(skb, IFLA_MACVLAN_BC_QUEUE_LEN, vlan->bc_queue_len_req))
>  		goto nla_put_failure;
> -	if (nla_put_u32(skb, IFLA_MACVLAN_BC_QUEUE_LEN_USED,
> -			READ_ONCE(port->bc_queue_len_used)))
> -		goto nla_put_failure;
> -	if (port->bc_cutoff != 1 &&
> -	    nla_put_s32(skb, IFLA_MACVLAN_BC_CUTOFF, port->bc_cutoff))
> -		goto nla_put_failure;
> +	if (port) {
> +		if (nla_put_u32(skb, IFLA_MACVLAN_BC_QUEUE_LEN_USED,
> +				READ_ONCE(port->bc_queue_len_used)))
> +			goto nla_put_failure;
> +		if (port->bc_cutoff != 1 &&
> +		    nla_put_s32(skb, IFLA_MACVLAN_BC_CUTOFF, port->bc_cutoff))
> +			goto nla_put_failure;
> +	}
>  	return 0;
>  
>  nla_put_failure:
> -- 
> 2.43.0


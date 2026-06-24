Return-Path: <netdev+bounces-301580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dVznBTWdO2qLaQgAu9opvQ
	(envelope-from <netdev+bounces-301580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:02:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1019E6BCC68
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:02:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=s3FLyiRK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301580-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301580-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 379FA3003BF7
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71D830C353;
	Wed, 24 Jun 2026 09:01:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72F3019AA
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 09:01:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782291710; cv=none; b=Cbo9cc2qXgoL2W1JZoOJr5lK1mvmhZRkYEe9p0stgoZz9qVS25hIWA6dPUVDbEsmWaYG0N+F6Eb70uSeZif4Q/uqmYpykl4J+TYTMS+BGyQi4vfX4x+NIU+WDtwGm+8oQS8lB97zNWkYHwD7D/Sj9XulVGGqWu1riwwnOGgH0Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782291710; c=relaxed/simple;
	bh=UdDrq6AykiO2lA6y39Bu2cHH1Oy8Dbc9z4+91NdXeEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aj9CnFhO1u3Zk1n80fRnwnyo3G812071Wh9LwWgdKfo03AHTvDktuzlWmy3e+UuQHbeDkEg/uJPWohJ08EjFO3Y3HvFiYmtKiQIcEvXJvC80kOfGI8kqHtLm++J29j2caXnRqk2znuVUcgp7vKQvADz8gPWQfc6zNMhQyC4aICE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3FLyiRK; arc=none smtp.client-ip=209.85.215.176
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8b49639fbaso520758a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782291706; x=1782896506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yz4o63cvQssQtvpex6eoP1eHy1LnwKR3OIYmsrMySAg=;
        b=s3FLyiRKqCzewn+fN54goCV4YvhXa4WCrbIR7av+ddhoaTYZSw21Zr88tM5NB3FB4D
         yECcFZNnitxNt11iWxfxZaRGlgJsax8Hgktb35VLhA0MdmNuOvoKe/u+wCuh2APDXOl/
         7C+NIuDVaeRD/aTj5Ss6lr8Jcuv64+kc3J9Kr9pF4wno/qvWxhNh39h919iuDjBezJNu
         gfeM1kr2MKXGzY/cFt/5Fl2mySld+D4RQzN5DC1mBGp1ljSBqXN4yFSjxnUEFEWugfes
         ZB1eRDCqVRlrjKQGHNCWxzI1UM7mFTWBrzkiKUggIKTILR0bdULCDZvUdeBWRcfYNpOt
         76oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782291706; x=1782896506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yz4o63cvQssQtvpex6eoP1eHy1LnwKR3OIYmsrMySAg=;
        b=ETutZXIjQRsFz2DaChCp1XNld0Srg/qFi9KsqahXfQVYU05WGKxNhzQNoz39S14qis
         1G6Zxpt4bukP5Zbs0BLSglwme6l/xx4YGjUTOIjeUX2IoLdbfblkHO17UCefQKW4EO6w
         HGTe6SIT0CineYyE6msQTN2f5PSYTI6HM/qfa7Ou9aXr8xUR2AE9IMj1zs8lZxX02i8i
         VHPOAulO//QhUO44vQloDX1gMgSstiwgejzx4apsihgU5RLNe5WkaJtcgGRDjWYGyQhg
         OFYUgiS0m6BAvMusNrYWkdzfnetBJNPpy2oJEU/B+co/AtrDjOSJQrwFPbCr6XS9FtBY
         RhcA==
X-Gm-Message-State: AOJu0Yx6PDVnc2D2eu+UYgBmVf3y0qLOxlxs/KZvsOPVSFHlFKe9s7rN
	V7b89KTyl4agR7vnBTVI6FHat/GoqVvZUjErhK4b2Wq9rvagIClrFNeh
X-Gm-Gg: AfdE7cnKhqALQZvIMApjCarRDlMhACmFLZhxJKhn/0+NMZ0EOGX6OlTEVeMc1AHDXq1
	SHR0KuomHpMFW/Aj9L19Z3CTbcrr6Cz71C/gg9lUJGGbuHF0SqTQgiPeVxyUCYE3zyVMQbFu49Z
	bsWuEfAGxdX1rF251xiXdOrahyyxwMklMVoFAZQPHutxXpF5Nk+wHPF10sF6+oNe7G1FaOuERT/
	F+HxnnGXE76UrtUF7fDUtNIxsMV1gLu+pxT6O9Gy867pLoQQsDpvBjeozPXyDv+/xUzXZ3fXfWH
	Hj8jgtoV2A80QvqmgHp1ya3pWOZoRnqNgudAntjt+DOJw1R93gUWdZW35GLGEDqYOM3+q3hSmO1
	XweI81dm5O0IEmuqWwAhIo85h/2gxvkbqGPi+8p6qDIXQ6ea+s0uJp6REqtL4aV4DbbnlDuKpQt
	hPNpahh8TGEDB4vEZiGlKjMMAVNfRVmaiHTCY=
X-Received: by 2002:a05:6a20:d043:b0:3aa:c93b:625b with SMTP id adf61e73a8af0-3bd14ecd394mr8315384637.3.1782291705587;
        Wed, 24 Jun 2026 02:01:45 -0700 (PDT)
Received: from gmail.com ([140.210.35.123])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc5a1dc13sm12073729a12.26.2026.06.24.02.01.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Jun 2026 02:01:44 -0700 (PDT)
From: Yue Sun <samsun1006219@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: [BUG] KFENCE: use-after-free read in udp_tunnel_nic_device_sync_work
Date: Wed, 24 Jun 2026 17:01:32 +0800
Message-ID: <20260624090135.95763-1-samsun1006219@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301580-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller@googlegroups.com,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[samsun1006219@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[samsun1006219@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1019E6BCC68

Hello,

I hit a reproducible use-after-free in the UDP tunnel NIC offload work item.
The original local crash was reported by KFENCE as:

  KFENCE: use-after-free read in udp_tunnel_nic_device_sync_work

On current mainline, the C reproducer below triggers the same lifetime bug,
reported by KASAN before KFENCE samples the object:

  BUG: KASAN: slab-use-after-free in __mutex_lock
  Workqueue: udp_tunnel_nic udp_tunnel_nic_device_sync_work

Tested kernel:

  840ef6c78e6a ("Merge tag 'nfs-for-7.2-1' of git://git.linux-nfs.org/projects/anna/linux-nfs")
  Linux 7.1.0-11240-g840ef6c78e6a #31 SMP PREEMPT_DYNAMIC

Related syzbot reports:

  https://syzkaller.appspot.com/bug?id=8d8fd27ae4339074afe3f456be73b2030d795256

The dashboard currently marks it as invalid, but the same issue is still
reproducible for me on current mainline with the C reproducer pasted below.

Crash stack from the latest C reproducer run:

[  131.757233][   T12] BUG: KASAN: slab-use-after-free in __mutex_lock+0x16d0/0x1d80
[  131.759738][   T12] Read of size 8 at addr ff11000065dcd2a8 by task kworker/u16:0/12
[  131.762204][   T12] 
[  131.762956][   T12] CPU: 2 UID: 0 PID: 12 Comm: kworker/u16:0 Not tainted 7.1.0-11240-g840ef6c78e6a #31 PREEMPT(full) 
[  131.762997][   T12] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  131.763020][   T12] Workqueue: udp_tunnel_nic udp_tunnel_nic_device_sync_work
[  131.763064][   T12] Call Trace:
[  131.763076][   T12]  <TASK>
[  131.763089][   T12]  dump_stack_lvl+0x116/0x1b0
[  131.763136][   T12]  print_report+0xf1/0x5c0
[  131.763178][   T12]  ? __virt_addr_valid+0x238/0x420
[  131.763214][   T12]  ? __mutex_lock+0x16d0/0x1d80
[  131.763264][   T12]  kasan_report+0xca/0x100
[  131.763301][   T12]  ? __mutex_lock+0x16d0/0x1d80
[  131.763345][   T12]  __mutex_lock+0x16d0/0x1d80
[  131.763383][   T12]  ? udp_tunnel_nic_device_sync_work+0x32/0x9c0
[  131.763438][   T12]  ? __pfx___mutex_lock+0x10/0x10
[  131.763487][   T12]  ? debug_object_deactivate+0x213/0x390
[  131.763551][   T12]  ? udp_tunnel_nic_device_sync_work+0x32/0x9c0
[  131.763587][   T12]  udp_tunnel_nic_device_sync_work+0x32/0x9c0
[  131.763633][   T12]  process_one_work+0x9de/0x1bf0
[  131.763670][   T12]  ? __pfx_udp_tunnel_nic_device_sync_work+0x10/0x10
[  131.763710][   T12]  ? __pfx_process_one_work+0x10/0x10
[  131.763747][   T12]  ? __pfx_udp_tunnel_nic_device_sync_work+0x10/0x10
[  131.763787][   T12]  worker_thread+0x693/0xeb0
[  131.763823][   T12]  ? __pfx_worker_thread+0x10/0x10
[  131.763855][   T12]  kthread+0x38d/0x4a0
[  131.763903][   T12]  ? __pfx_kthread+0x10/0x10
[  131.763953][   T12]  ret_from_fork+0xb09/0xdb0
[  131.763997][   T12]  ? __pfx_ret_from_fork+0x10/0x10
[  131.764037][   T12]  ? __pfx_kthread+0x10/0x10
[  131.764082][   T12]  ? kthread_affine_node+0x210/0x230
[  131.764131][   T12]  ? __switch_to+0x7a7/0x10e0
[  131.764174][   T12]  ? __pfx_kthread+0x10/0x10
[  131.764221][   T12]  ret_from_fork_asm+0x1a/0x30
[  131.764269][   T12]  </TASK>
[  131.764280][   T12] 
[  131.810468][   T12] Allocated by task 10356:
[  131.811305][   T12]  kasan_save_stack+0x24/0x50
[  131.812187][   T12]  kasan_save_track+0x14/0x30
[  131.813069][   T12]  __kasan_kmalloc+0xaa/0xb0
[  131.813959][   T12]  __kmalloc_noprof+0x345/0x7f0
[  131.814882][   T12]  udp_tunnel_nic_netdevice_event+0x1285/0x1de0
[  131.816061][   T12]  notifier_call_chain+0xbd/0x430
[  131.817014][   T12]  call_netdevice_notifiers_info+0xbe/0x110
[  131.819862][   T12]  register_netdevice+0x197c/0x2440
[  131.820868][   T12]  nsim_create+0xcd5/0x14b0
[  131.821733][   T12]  __nsim_dev_port_add+0x3c2/0x900
[  131.822701][   T12]  nsim_dev_reload_up+0x42c/0x6a0
[  131.823584][   T12]  devlink_reload+0x2e3/0x7b0
[  131.824421][   T12]  devlink_nl_reload_doit+0x541/0x1160
[  131.825385][   T12]  genl_family_rcv_msg_doit+0x1ff/0x2f0
[  131.826358][   T12]  genl_rcv_msg+0x532/0x7e0
[  131.827159][   T12]  netlink_rcv_skb+0x147/0x430
[  131.828017][   T12]  genl_rcv+0x28/0x40
[  131.828724][   T12]  netlink_unicast+0x58d/0x850
[  131.829582][   T12]  netlink_sendmsg+0x88d/0xd90
[  131.830439][   T12]  ____sys_sendmsg+0xa27/0xb90
[  131.831286][   T12]  ___sys_sendmsg+0x11c/0x1b0
[  131.832106][   T12]  __sys_sendmsg+0x142/0x1f0
[  131.832927][   T12]  do_syscall_64+0x11f/0x860
[  131.833745][   T12]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  131.834791][   T12] 
[  131.835206][   T12] Freed by task 10421:
[  131.835916][   T12]  kasan_save_stack+0x24/0x50
[  131.836742][   T12]  kasan_save_track+0x14/0x30
[  131.837564][   T12]  kasan_save_free_info+0x3b/0x60
[  131.838465][   T12]  __kasan_slab_free+0x61/0x80
[  131.839314][   T12]  kfree+0x2ca/0x6d0
[  131.840008][   T12]  udp_tunnel_nic_netdevice_event+0xc24/0x1de0
[  131.841080][   T12]  notifier_call_chain+0xbd/0x430
[  131.841981][   T12]  call_netdevice_notifiers_info+0xbe/0x110
[  131.843022][   T12]  unregister_netdevice_many_notify+0xbab/0x2130
[  131.844129][   T12]  unregister_netdevice_queue+0x305/0x3c0
[  131.845132][   T12]  nsim_destroy+0x231/0x980
[  131.845960][   T12]  __nsim_dev_port_del+0x197/0x2c0
[  131.846860][   T12]  nsim_dev_reload_destroy+0x105/0x490
[  131.847823][   T12]  nsim_dev_reload_down+0x67/0xd0
[  131.848707][   T12]  devlink_reload+0x197/0x7b0
[  131.849545][   T12]  devlink_nl_reload_doit+0x541/0x1160
[  131.850517][   T12]  genl_family_rcv_msg_doit+0x1ff/0x2f0
[  131.851489][   T12]  genl_rcv_msg+0x532/0x7e0
[  131.852282][   T12]  netlink_rcv_skb+0x147/0x430
[  131.853130][   T12]  genl_rcv+0x28/0x40
[  131.853836][   T12]  netlink_unicast+0x58d/0x850
[  131.854689][   T12]  netlink_sendmsg+0x88d/0xd90
[  131.855497][   T12]  ____sys_sendmsg+0xa27/0xb90
[  131.856293][   T12]  ___sys_sendmsg+0x11c/0x1b0
[  131.857067][   T12]  __sys_sendmsg+0x142/0x1f0
[  131.857826][   T12]  do_syscall_64+0x11f/0x860
[  131.858605][   T12]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  131.859579][   T12] 
[  131.859971][   T12] Last potentially related work creation:
[  131.860910][   T12]  kasan_save_stack+0x24/0x50
[  131.861694][   T12]  kasan_record_aux_stack+0xa7/0xc0
[  131.862563][   T12]  insert_work+0x36/0x230
[  131.863276][   T12]  __queue_work+0x474/0x12a0
[  131.864038][   T12]  queue_work_on+0x11c/0x140
[  131.864800][   T12]  __udp_tunnel_nic_del_port+0x2a5/0x350
[  131.865733][   T12]  udp_tunnel_notify_del_rx_port+0x228/0x410
[  131.866698][   T12]  __geneve_sock_release.part.0+0x13b/0x1d0
[  131.867583][   T12]  geneve_sock_release+0x165/0x2c0
[  131.868346][   T12]  geneve_stop+0x19c/0x200
[  131.869001][   T12]  __dev_close_many+0x350/0x720
[  131.869733][   T12]  __dev_change_flags+0x301/0x860
[  131.870474][   T12]  netif_change_flags+0x8e/0x170
[  131.871208][   T12]  do_setlink.constprop.0+0xac0/0x3f80
[  131.872011][   T12]  rtnl_newlink+0x17e7/0x1f30
[  131.872711][   T12]  rtnetlink_rcv_msg+0x9e8/0xfa0
[  131.873455][   T12]  netlink_rcv_skb+0x147/0x430
[  131.874207][   T12]  netlink_unicast+0x58d/0x850
[  131.874959][   T12]  netlink_sendmsg+0x88d/0xd90
[  131.875685][   T12]  ____sys_sendmsg+0xa27/0xb90
[  131.876406][   T12]  ___sys_sendmsg+0x11c/0x1b0
[  131.877102][   T12]  __sys_sendmsg+0x142/0x1f0
[  131.877803][   T12]  do_syscall_64+0x11f/0x860
[  131.878505][   T12]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  131.879297][   T12] 
[  131.879611][   T12] Second to last potentially related work creation:
[  131.880480][   T12]  kasan_save_stack+0x24/0x50
[  131.881112][   T12]  kasan_record_aux_stack+0xa7/0xc0
[  131.881818][   T12]  insert_work+0x36/0x230
[  131.882403][   T12]  __queue_work+0x474/0x12a0
[  131.883019][   T12]  queue_work_on+0x11c/0x140
[  131.883634][   T12]  __udp_tunnel_nic_add_port+0x6e4/0xd90
[  131.884385][   T12]  udp_tunnel_notify_add_rx_port+0x228/0x410
[  131.885199][   T12]  geneve_sock_add+0x7a3/0xb60
[  131.885844][   T12]  geneve_open+0xde/0x1d0
[  131.886435][   T12]  __dev_open+0x3b8/0x900
[  131.887017][   T12]  __dev_change_flags+0x58f/0x860
[  131.887692][   T12]  netif_change_flags+0x8e/0x170
[  131.888389][   T12]  do_setlink.constprop.0+0xac0/0x3f80
[  131.889130][   T12]  rtnl_newlink+0x17e7/0x1f30
[  131.889774][   T12]  rtnetlink_rcv_msg+0x9e8/0xfa0
[  131.890455][   T12]  netlink_rcv_skb+0x147/0x430
[  131.891065][   T12]  netlink_unicast+0x58d/0x850
[  131.891654][   T12]  netlink_sendmsg+0x88d/0xd90
[  131.892251][   T12]  ____sys_sendmsg+0xa27/0xb90
[  131.892837][   T12]  ___sys_sendmsg+0x11c/0x1b0
[  131.893412][   T12]  __sys_sendmsg+0x142/0x1f0
[  131.893988][   T12]  do_syscall_64+0x11f/0x860
[  131.894559][   T12]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  131.895275][   T12] 
[  131.895564][   T12] The buggy address belongs to the object at ff11000065dcd200
[  131.895564][   T12]  which belongs to the cache kmalloc-256 of size 256
[  131.897253][   T12] The buggy address is located 168 bytes inside of
[  131.897253][   T12]  freed 256-byte region [ff11000065dcd200, ff11000065dcd300)
[  131.898932][   T12] 
[  131.899228][   T12] The buggy address belongs to the physical page:
[  131.900013][   T12] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x65dcc
[  131.901089][   T12] head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  131.902125][   T12] flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
[  131.903017][   T12] page_type: f5(slab)
[  131.903477][   T12] raw: 00fff00000000040 ff11000100038b40 dead000000000100 dead000000000122
[  131.904457][   T12] raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
[  131.905422][   T12] head: 00fff00000000040 ff11000100038b40 dead000000000100 dead000000000122
[  131.906405][   T12] head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
[  131.907388][   T12] head: 00fff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
[  131.908365][   T12] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
[  131.909334][   T12] page dumped because: kasan: bad access detected
[  131.910076][   T12] page_owner tracks the page as allocated
[  131.910720][   T12] page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 9905, tgid 9901 (repro), ts 81743543441, free_ts 81726980842
[  131.913040][   T12]  post_alloc_hook+0xff/0x130
[  131.913579][   T12]  get_page_from_freelist+0xe82/0x2bf0
[  131.914216][   T12]  __alloc_frozen_pages_noprof+0x27b/0x2a00
[  131.914849][   T12]  new_slab+0xad/0x610
[  131.915190][   T12]  refill_objects+0x10e/0x3d0
[  131.915587][   T12]  __pcs_replace_empty_main+0x352/0x670
[  131.916050][   T12]  __kmalloc_noprof+0x65e/0x7f0
[  131.916458][   T12]  ops_init+0x77/0x5f0
[  131.916799][   T12]  setup_net+0x11a/0x3a0
[  131.917155][   T12]  copy_net_ns+0x351/0x7c0
[  131.917530][   T12]  create_new_namespaces+0x3f6/0xac0
[  131.917984][   T12]  copy_namespaces+0x45c/0x580
[  131.918389][   T12]  copy_process+0x3687/0x7d40
[  131.918788][   T12]  kernel_clone+0x1f6/0x910
[  131.919183][   T12]  __do_sys_clone+0xce/0x120
[  131.919575][   T12]  do_syscall_64+0x11f/0x860
[  131.919969][   T12] page last free pid 9905 tgid 9901 stack trace:
[  131.920496][   T12]  __free_frozen_pages+0x74d/0x1110
[  131.920930][   T12]  qlist_free_all+0x4c/0xf0
[  131.921327][   T12]  kasan_quarantine_reduce+0x195/0x1e0
[  131.921791][   T12]  __kasan_slab_alloc+0x67/0x90
[  131.922202][   T12]  kmem_cache_alloc_noprof+0x244/0x690
[  131.922665][   T12]  security_inode_alloc+0x3e/0x2d0
[  131.923099][   T12]  inode_init_always_gfp+0xc77/0xfb0
[  131.923562][   T12]  alloc_inode+0x8e/0x250
[  131.923930][   T12]  new_inode+0x22/0x1d0
[  131.924284][   T12]  __debugfs_create_file+0x10b/0x540
[  131.924737][   T12]  debugfs_create_file_full+0x41/0x60
[  131.925189][   T12]  ref_tracker_dir_debugfs+0x18c/0x2e0
[  131.925658][   T12]  alloc_netdev_mqs+0x31f/0x1600
[  131.926078][   T12]  ip6_tnl_init_net+0x12f/0x4c0
[  131.926491][   T12]  ops_init+0x1e2/0x5f0
[  131.926843][   T12]  setup_net+0x11a/0x3a0
[  131.927201][   T12] 
[  131.927399][   T12] Memory state around the buggy address:
[  131.927873][   T12]  ff11000065dcd180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  131.928542][   T12]  ff11000065dcd200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  131.929231][   T12] >ff11000065dcd280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  131.929902][   T12]                                   ^
[  131.930375][   T12]  ff11000065dcd300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  131.931050][   T12]  ff11000065dcd380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  131.931723][   T12] ==================================================================
[  131.932651][   T12] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[  131.933267][   T12] CPU: 2 UID: 0 PID: 12 Comm: kworker/u16:0 Not tainted 7.1.0-11240-g840ef6c78e6a #31 PREEMPT(full) 
[  131.934181][   T12] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  131.934965][   T12] Workqueue: udp_tunnel_nic udp_tunnel_nic_device_sync_work
[  131.935585][   T12] Call Trace:
[  131.935865][   T12]  <TASK>


The reproducer creates netdevsim/geneve devices and drives a devlink reload
while UDP tunnel offload notifications are being queued. A queued
udp_tunnel_nic_device_sync_work item later runs with its embedded work_struct
inside struct udp_tunnel_nic, but that struct has already been freed from the
NETDEV_UNREGISTER path. The first dereference in the worker is the mutex lock:

  udp_tunnel_nic_device_sync_work()
    rtnl_lock();
    mutex_lock(&utn->lock);

KASAN reports the read from the freed object at that mutex access.

Possible root cause analysis:

The lifetime of struct udp_tunnel_nic appears to be guarded only by the
utn->work_pending flag, but that flag is not a safe lifetime barrier for the
queued work:

  udp_tunnel_nic_device_sync()
    queue_work(udp_tunnel_nic_workqueue, &utn->work);
    utn->work_pending = 1;

  udp_tunnel_nic_unregister()
    udp_tunnel_nic_flush(dev, utn);
    udp_tunnel_nic_unlock(dev);
    if (utn->work_pending)
      return;
    udp_tunnel_nic_free(utn);

The work is queued before work_pending is set, so unregister can observe
work_pending == 0 and free utn while the work is already queued or starting.
Also, work_pending is only a flag in the object being protected; it is not a
reference, cancel_work_sync(), or flush_work() style guarantee that the worker
no longer owns or can dereference the containing object.  Once udp_tunnel_nic_free()
runs, the embedded work item can still call container_of(work, struct
udp_tunnel_nic, work) and dereference the freed utn, which matches the
alloc/free/use stacks above.

A fix should make unregister synchronize with the embedded work or otherwise
hold a real lifetime reference while the work is queued/running. In particular,
freeing utn based solely on work_pending looks racy.

If you have any questions, please let me know.

Best regards,
Yue

Build/run:

  gcc -pthread -static -O2 repro.c -o repro
  ./repro

C reproducer:

// autogenerated by syzkaller (https://github.com/google/syzkaller)

#define _GNU_SOURCE 

#include <arpa/inet.h>
#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <net/if.h>
#include <net/if_arp.h>
#include <netinet/in.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/capability.h>
#include <linux/futex.h>
#include <linux/genetlink.h>
#include <linux/if_addr.h>
#include <linux/if_ether.h>
#include <linux/if_link.h>
#include <linux/if_tun.h>
#include <linux/in6.h>
#include <linux/ip.h>
#include <linux/neighbour.h>
#include <linux/net.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/tcp.h>
#include <linux/veth.h>

static unsigned long long procid;

static void sleep_ms(uint64_t ms)
{
	usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
	struct timespec ts;
	if (clock_gettime(CLOCK_MONOTONIC, &ts))
	exit(1);
	return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static void thread_start(void* (*fn)(void*), void* arg)
{
	pthread_t th;
	pthread_attr_t attr;
	pthread_attr_init(&attr);
	pthread_attr_setstacksize(&attr, 128 << 10);
	int i = 0;
	for (; i < 100; i++) {
		if (pthread_create(&th, &attr, fn, arg) == 0) {
			pthread_attr_destroy(&attr);
			return;
		}
		if (errno == EAGAIN) {
			usleep(50);
			continue;
		}
		break;
	}
	exit(1);
}

#define BITMASK(bf_off,bf_len) (((1ull << (bf_len)) - 1) << (bf_off))
#define STORE_BY_BITMASK(type,htobe,addr,val,bf_off,bf_len) *(type*)(addr) = htobe((htobe(*(type*)(addr)) & ~BITMASK((bf_off), (bf_len))) | (((type)(val) << (bf_off)) & BITMASK((bf_off), (bf_len))))

typedef struct {
	int state;
} event_t;

static void event_init(event_t* ev)
{
	ev->state = 0;
}

static void event_reset(event_t* ev)
{
	ev->state = 0;
}

static void event_set(event_t* ev)
{
	if (ev->state)
	exit(1);
	__atomic_store_n(&ev->state, 1, __ATOMIC_RELEASE);
	syscall(SYS_futex, &ev->state, FUTEX_WAKE | FUTEX_PRIVATE_FLAG, 1000000);
}

static void event_wait(event_t* ev)
{
	while (!__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
		syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, 0);
}

static int event_isset(event_t* ev)
{
	return __atomic_load_n(&ev->state, __ATOMIC_ACQUIRE);
}

static int event_timedwait(event_t* ev, uint64_t timeout)
{
	uint64_t start = current_time_ms();
	uint64_t now = start;
	for (;;) {
		uint64_t remain = timeout - (now - start);
		struct timespec ts;
		ts.tv_sec = remain / 1000;
		ts.tv_nsec = (remain % 1000) * 1000 * 1000;
		syscall(SYS_futex, &ev->state, FUTEX_WAIT | FUTEX_PRIVATE_FLAG, 0, &ts);
		if (__atomic_load_n(&ev->state, __ATOMIC_ACQUIRE))
			return 1;
		now = current_time_ms();
		if (now - start > timeout)
			return 0;
	}
}

static bool write_file(const char* file, const char* what, ...)
{
	char buf[1024];
	va_list args;
	va_start(args, what);
	vsnprintf(buf, sizeof(buf), what, args);
	va_end(args);
	buf[sizeof(buf) - 1] = 0;
	int len = strlen(buf);
	int fd = open(file, O_WRONLY | O_CLOEXEC);
	if (fd == -1)
		return false;
	if (write(fd, buf, len) != len) {
		int err = errno;
		close(fd);
		errno = err;
		return false;
	}
	close(fd);
	return true;
}

struct nlmsg {
	char* pos;
	int nesting;
	struct nlattr* nested[8];
	char buf[4096];
};

static void netlink_init(struct nlmsg* nlmsg, int typ, int flags,
			 const void* data, int size)
{
	memset(nlmsg, 0, sizeof(*nlmsg));
	struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
	hdr->nlmsg_type = typ;
	hdr->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | flags;
	memcpy(hdr + 1, data, size);
	nlmsg->pos = (char*)(hdr + 1) + NLMSG_ALIGN(size);
}

static void netlink_attr(struct nlmsg* nlmsg, int typ,
			 const void* data, int size)
{
	struct nlattr* attr = (struct nlattr*)nlmsg->pos;
	attr->nla_len = sizeof(*attr) + size;
	attr->nla_type = typ;
	if (size > 0)
		memcpy(attr + 1, data, size);
	nlmsg->pos += NLMSG_ALIGN(attr->nla_len);
}

static void netlink_nest(struct nlmsg* nlmsg, int typ)
{
	struct nlattr* attr = (struct nlattr*)nlmsg->pos;
	attr->nla_type = typ;
	nlmsg->pos += sizeof(*attr);
	nlmsg->nested[nlmsg->nesting++] = attr;
}

static void netlink_done(struct nlmsg* nlmsg)
{
	struct nlattr* attr = nlmsg->nested[--nlmsg->nesting];
	attr->nla_len = nlmsg->pos - (char*)attr;
}

static int netlink_send_ext(struct nlmsg* nlmsg, int sock,
			    uint16_t reply_type, int* reply_len, bool dofail)
{
	if (nlmsg->pos > nlmsg->buf + sizeof(nlmsg->buf) || nlmsg->nesting)
	exit(1);
	struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
	hdr->nlmsg_len = nlmsg->pos - nlmsg->buf;
	struct sockaddr_nl addr;
	memset(&addr, 0, sizeof(addr));
	addr.nl_family = AF_NETLINK;
	ssize_t n = sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0, (struct sockaddr*)&addr, sizeof(addr));
	if (n != (ssize_t)hdr->nlmsg_len) {
		if (dofail)
	exit(1);
		return -1;
	}
	n = recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
	if (reply_len)
		*reply_len = 0;
	if (n < 0) {
		if (dofail)
	exit(1);
		return -1;
	}
	if (n < (ssize_t)sizeof(struct nlmsghdr)) {
		errno = EINVAL;
		if (dofail)
	exit(1);
		return -1;
	}
	if (hdr->nlmsg_type == NLMSG_DONE)
		return 0;
	if (reply_len && hdr->nlmsg_type == reply_type) {
		*reply_len = n;
		return 0;
	}
	if (n < (ssize_t)(sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr))) {
		errno = EINVAL;
		if (dofail)
	exit(1);
		return -1;
	}
	if (hdr->nlmsg_type != NLMSG_ERROR) {
		errno = EINVAL;
		if (dofail)
	exit(1);
		return -1;
	}
	errno = -((struct nlmsgerr*)(hdr + 1))->error;
	return -errno;
}

static int netlink_send(struct nlmsg* nlmsg, int sock)
{
	return netlink_send_ext(nlmsg, sock, 0, NULL, true);
}

static int netlink_query_family_id(struct nlmsg* nlmsg, int sock, const char* family_name, bool dofail)
{
	struct genlmsghdr genlhdr;
	memset(&genlhdr, 0, sizeof(genlhdr));
	genlhdr.cmd = CTRL_CMD_GETFAMILY;
	netlink_init(nlmsg, GENL_ID_CTRL, 0, &genlhdr, sizeof(genlhdr));
	netlink_attr(nlmsg, CTRL_ATTR_FAMILY_NAME, family_name, strnlen(family_name, GENL_NAMSIZ - 1) + 1);
	int n = 0;
	int err = netlink_send_ext(nlmsg, sock, GENL_ID_CTRL, &n, dofail);
	if (err < 0) {
		return -1;
	}
	uint16_t id = 0;
	struct nlattr* attr = (struct nlattr*)(nlmsg->buf + NLMSG_HDRLEN + NLMSG_ALIGN(sizeof(genlhdr)));
	for (; (char*)attr < nlmsg->buf + n; attr = (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len))) {
		if (attr->nla_type == CTRL_ATTR_FAMILY_ID) {
			id = *(uint16_t*)(attr + 1);
			break;
		}
	}
	if (!id) {
		errno = EINVAL;
		return -1;
	}
	recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
	return id;
}

static int netlink_next_msg(struct nlmsg* nlmsg, unsigned int offset,
			    unsigned int total_len)
{
	struct nlmsghdr* hdr = (struct nlmsghdr*)(nlmsg->buf + offset);
	if (offset == total_len || offset + hdr->nlmsg_len > total_len)
		return -1;
	return hdr->nlmsg_len;
}

static unsigned int queue_count = 2;

static void netlink_add_device_impl(struct nlmsg* nlmsg, const char* type,
				    const char* name, bool up)
{
	struct ifinfomsg hdr;
	memset(&hdr, 0, sizeof(hdr));
	if (up)
		hdr.ifi_flags = hdr.ifi_change = IFF_UP;
	netlink_init(nlmsg, RTM_NEWLINK, NLM_F_EXCL | NLM_F_CREATE, &hdr, sizeof(hdr));
	if (name)
		netlink_attr(nlmsg, IFLA_IFNAME, name, strlen(name));
	netlink_attr(nlmsg, IFLA_NUM_TX_QUEUES, &queue_count, sizeof(queue_count));
	netlink_attr(nlmsg, IFLA_NUM_RX_QUEUES, &queue_count, sizeof(queue_count));
	netlink_nest(nlmsg, IFLA_LINKINFO);
	netlink_attr(nlmsg, IFLA_INFO_KIND, type, strlen(type));
}

static void netlink_add_device(struct nlmsg* nlmsg, int sock, const char* type,
			       const char* name)
{
	netlink_add_device_impl(nlmsg, type, name, false);
	netlink_done(nlmsg);
	int err = netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

static void netlink_add_veth(struct nlmsg* nlmsg, int sock, const char* name,
			     const char* peer)
{
	netlink_add_device_impl(nlmsg, "veth", name, false);
	netlink_nest(nlmsg, IFLA_INFO_DATA);
	netlink_nest(nlmsg, VETH_INFO_PEER);
	nlmsg->pos += sizeof(struct ifinfomsg);
	netlink_attr(nlmsg, IFLA_IFNAME, peer, strlen(peer));
	netlink_attr(nlmsg, IFLA_NUM_TX_QUEUES, &queue_count, sizeof(queue_count));
	netlink_attr(nlmsg, IFLA_NUM_RX_QUEUES, &queue_count, sizeof(queue_count));
	netlink_done(nlmsg);
	netlink_done(nlmsg);
	netlink_done(nlmsg);
	int err = netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

static void netlink_add_xfrm(struct nlmsg* nlmsg, int sock, const char* name)
{
	netlink_add_device_impl(nlmsg, "xfrm", name, true);
	netlink_nest(nlmsg, IFLA_INFO_DATA);
	int if_id = 1;
	netlink_attr(nlmsg, 2, &if_id, sizeof(if_id));
	netlink_done(nlmsg);
	netlink_done(nlmsg);
	int err = netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

static void netlink_add_hsr(struct nlmsg* nlmsg, int sock, const char* name,
			    const char* slave1, const char* slave2)
{
	netlink_add_device_impl(nlmsg, "hsr", name, false);
	netlink_nest(nlmsg, IFLA_INFO_DATA);
	int ifindex1 = if_nametoindex(slave1);
	netlink_attr(nlmsg, IFLA_HSR_SLAVE1, &ifindex1, sizeof(ifindex1));
	int ifindex2 = if_nametoindex(slave2);
	netlink_attr(nlmsg, IFLA_HSR_SLAVE2, &ifindex2, sizeof(ifindex2));
	netlink_done(nlmsg);
	netlink_done(nlmsg);
	int err = netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

static void netlink_add_linked(struct nlmsg* nlmsg, int sock, const char* type, const char* name, const char* link)
{
	netlink_add_device_impl(nlmsg, type, name, false);
	netlink_done(nlmsg);
	int ifindex = if_nametoindex(link);
	netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
	int err = netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

static void netlink_add_vlan(struct nlmsg* nlmsg, int sock, const char* name, const char* link, uint16_t id, uint16_t proto)
{
	netlink_add_device_impl(nlmsg, "vlan", name, false);
	netlink_nest(nlmsg, IFLA_INFO_DATA);
	netlink_attr(nlmsg, IFLA_VLAN_ID, &id, sizeof(id));
	netlink_attr(nlmsg, IFLA_VLAN_PROTOCOL, &proto, sizeof(proto));
	netlink_done(nlmsg);
	netlink_done(nlmsg);
	int ifindex = if_nametoindex(link);
	netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
	int err = netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

static void netlink_add_macvlan(struct nlmsg* nlmsg, int sock, const char* name, const char* link)
{
	netlink_add_device_impl(nlmsg, "macvlan", name, false);
	netlink_nest(nlmsg, IFLA_INFO_DATA);
	uint32_t mode = MACVLAN_MODE_BRIDGE;
	netlink_attr(nlmsg, IFLA_MACVLAN_MODE, &mode, sizeof(mode));
	netlink_done(nlmsg);
	netlink_done(nlmsg);
	int ifindex = if_nametoindex(link);
	netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
	int err = netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

static void netlink_add_geneve(struct nlmsg* nlmsg, int sock, const char* name, uint32_t vni, struct in_addr* addr4, struct in6_addr* addr6)
{
	netlink_add_device_impl(nlmsg, "geneve", name, false);
	netlink_nest(nlmsg, IFLA_INFO_DATA);
	netlink_attr(nlmsg, IFLA_GENEVE_ID, &vni, sizeof(vni));
	if (addr4)
		netlink_attr(nlmsg, IFLA_GENEVE_REMOTE, addr4, sizeof(*addr4));
	if (addr6)
		netlink_attr(nlmsg, IFLA_GENEVE_REMOTE6, addr6, sizeof(*addr6));
	netlink_done(nlmsg);
	netlink_done(nlmsg);
	int err = netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

#define IFLA_IPVLAN_FLAGS 2
#define IPVLAN_MODE_L3S 2
#undef IPVLAN_F_VEPA
#define IPVLAN_F_VEPA 2

static void netlink_add_ipvlan(struct nlmsg* nlmsg, int sock, const char* name, const char* link, uint16_t mode, uint16_t flags)
{
	netlink_add_device_impl(nlmsg, "ipvlan", name, false);
	netlink_nest(nlmsg, IFLA_INFO_DATA);
	netlink_attr(nlmsg, IFLA_IPVLAN_MODE, &mode, sizeof(mode));
	netlink_attr(nlmsg, IFLA_IPVLAN_FLAGS, &flags, sizeof(flags));
	netlink_done(nlmsg);
	netlink_done(nlmsg);
	int ifindex = if_nametoindex(link);
	netlink_attr(nlmsg, IFLA_LINK, &ifindex, sizeof(ifindex));
	int err = netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

static void netlink_device_change(struct nlmsg* nlmsg, int sock, const char* name, bool up,
				  const char* master, const void* mac, int macsize,
				  const char* new_name)
{
	struct ifinfomsg hdr;
	memset(&hdr, 0, sizeof(hdr));
	if (up)
		hdr.ifi_flags = hdr.ifi_change = IFF_UP;
	hdr.ifi_index = if_nametoindex(name);
	netlink_init(nlmsg, RTM_NEWLINK, 0, &hdr, sizeof(hdr));
	if (new_name)
		netlink_attr(nlmsg, IFLA_IFNAME, new_name, strlen(new_name));
	if (master) {
		int ifindex = if_nametoindex(master);
		netlink_attr(nlmsg, IFLA_MASTER, &ifindex, sizeof(ifindex));
	}
	if (macsize)
		netlink_attr(nlmsg, IFLA_ADDRESS, mac, macsize);
	int err = netlink_send(nlmsg, sock);
	if (err < 0) {
	}
}

static int netlink_add_addr(struct nlmsg* nlmsg, int sock, const char* dev,
			    const void* addr, int addrsize)
{
	struct ifaddrmsg hdr;
	memset(&hdr, 0, sizeof(hdr));
	hdr.ifa_family = addrsize == 4 ? AF_INET : AF_INET6;
	hdr.ifa_prefixlen = addrsize == 4 ? 24 : 120;
	hdr.ifa_scope = RT_SCOPE_UNIVERSE;
	hdr.ifa_index = if_nametoindex(dev);
	netlink_init(nlmsg, RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, &hdr, sizeof(hdr));
	netlink_attr(nlmsg, IFA_LOCAL, addr, addrsize);
	netlink_attr(nlmsg, IFA_ADDRESS, addr, addrsize);
	return netlink_send(nlmsg, sock);
}

static void netlink_add_addr4(struct nlmsg* nlmsg, int sock,
			      const char* dev, const char* addr)
{
	struct in_addr in_addr;
	inet_pton(AF_INET, addr, &in_addr);
	int err = netlink_add_addr(nlmsg, sock, dev, &in_addr, sizeof(in_addr));
	if (err < 0) {
	}
}

static void netlink_add_addr6(struct nlmsg* nlmsg, int sock,
			      const char* dev, const char* addr)
{
	struct in6_addr in6_addr;
	inet_pton(AF_INET6, addr, &in6_addr);
	int err = netlink_add_addr(nlmsg, sock, dev, &in6_addr, sizeof(in6_addr));
	if (err < 0) {
	}
}

static struct nlmsg nlmsg;

#define DEVLINK_FAMILY_NAME "devlink"

#define DEVLINK_CMD_PORT_GET 5
#define DEVLINK_ATTR_BUS_NAME 1
#define DEVLINK_ATTR_DEV_NAME 2
#define DEVLINK_ATTR_NETDEV_NAME 7

static struct nlmsg nlmsg2;

static void initialize_devlink_ports(const char* bus_name, const char* dev_name,
				     const char* netdev_prefix)
{
	struct genlmsghdr genlhdr;
	int len, total_len, id, err, offset;
	uint16_t netdev_index;
	int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
	if (sock == -1)
	exit(1);
	int rtsock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (rtsock == -1)
	exit(1);
	id = netlink_query_family_id(&nlmsg, sock, DEVLINK_FAMILY_NAME, true);
	if (id == -1)
		goto error;
	memset(&genlhdr, 0, sizeof(genlhdr));
	genlhdr.cmd = DEVLINK_CMD_PORT_GET;
	netlink_init(&nlmsg, id, NLM_F_DUMP, &genlhdr, sizeof(genlhdr));
	netlink_attr(&nlmsg, DEVLINK_ATTR_BUS_NAME, bus_name, strlen(bus_name) + 1);
	netlink_attr(&nlmsg, DEVLINK_ATTR_DEV_NAME, dev_name, strlen(dev_name) + 1);
	err = netlink_send_ext(&nlmsg, sock, id, &total_len, true);
	if (err < 0) {
		goto error;
	}
	offset = 0;
	netdev_index = 0;
	while ((len = netlink_next_msg(&nlmsg, offset, total_len)) != -1) {
		struct nlattr* attr = (struct nlattr*)(nlmsg.buf + offset + NLMSG_HDRLEN + NLMSG_ALIGN(sizeof(genlhdr)));
		for (; (char*)attr < nlmsg.buf + offset + len; attr = (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len))) {
			if (attr->nla_type == DEVLINK_ATTR_NETDEV_NAME) {
				char* port_name;
				char netdev_name[IFNAMSIZ];
				port_name = (char*)(attr + 1);
				snprintf(netdev_name, sizeof(netdev_name), "%s%d", netdev_prefix, netdev_index);
				netlink_device_change(&nlmsg2, rtsock, port_name, true, 0, 0, 0, netdev_name);
				break;
			}
		}
		offset += len;
		netdev_index++;
	}
error:
	close(rtsock);
	close(sock);
}

#define DEV_IPV4 "172.20.20.%d"
#define DEV_IPV6 "fe80::%02x"
#define DEV_MAC 0x00aaaaaaaaaa

static void netdevsim_add(unsigned int addr, unsigned int port_count)
{
	write_file("/sys/bus/netdevsim/del_device", "%u", addr);
	if (write_file("/sys/bus/netdevsim/new_device", "%u %u", addr, port_count)) {
		char buf[32];
		snprintf(buf, sizeof(buf), "netdevsim%d", addr);
		initialize_devlink_ports("netdevsim", buf, "netdevsim");
	}
}

#define WG_GENL_NAME "wireguard"
enum wg_cmd {
	WG_CMD_GET_DEVICE,
	WG_CMD_SET_DEVICE,
};
enum wgdevice_attribute {
	WGDEVICE_A_UNSPEC,
	WGDEVICE_A_IFINDEX,
	WGDEVICE_A_IFNAME,
	WGDEVICE_A_PRIVATE_KEY,
	WGDEVICE_A_PUBLIC_KEY,
	WGDEVICE_A_FLAGS,
	WGDEVICE_A_LISTEN_PORT,
	WGDEVICE_A_FWMARK,
	WGDEVICE_A_PEERS,
};
enum wgpeer_attribute {
	WGPEER_A_UNSPEC,
	WGPEER_A_PUBLIC_KEY,
	WGPEER_A_PRESHARED_KEY,
	WGPEER_A_FLAGS,
	WGPEER_A_ENDPOINT,
	WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL,
	WGPEER_A_LAST_HANDSHAKE_TIME,
	WGPEER_A_RX_BYTES,
	WGPEER_A_TX_BYTES,
	WGPEER_A_ALLOWEDIPS,
	WGPEER_A_PROTOCOL_VERSION,
};
enum wgallowedip_attribute {
	WGALLOWEDIP_A_UNSPEC,
	WGALLOWEDIP_A_FAMILY,
	WGALLOWEDIP_A_IPADDR,
	WGALLOWEDIP_A_CIDR_MASK,
};

static void netlink_wireguard_setup(void)
{
	const char ifname_a[] = "wg0";
	const char ifname_b[] = "wg1";
	const char ifname_c[] = "wg2";
	const char private_a[] = "\xa0\x5c\xa8\x4f\x6c\x9c\x8e\x38\x53\xe2\xfd\x7a\x70\xae\x0f\xb2\x0f\xa1\x52\x60\x0c\xb0\x08\x45\x17\x4f\x08\x07\x6f\x8d\x78\x43";
	const char private_b[] = "\xb0\x80\x73\xe8\xd4\x4e\x91\xe3\xda\x92\x2c\x22\x43\x82\x44\xbb\x88\x5c\x69\xe2\x69\xc8\xe9\xd8\x35\xb1\x14\x29\x3a\x4d\xdc\x6e";
	const char private_c[] = "\xa0\xcb\x87\x9a\x47\xf5\xbc\x64\x4c\x0e\x69\x3f\xa6\xd0\x31\xc7\x4a\x15\x53\xb6\xe9\x01\xb9\xff\x2f\x51\x8c\x78\x04\x2f\xb5\x42";
	const char public_a[] = "\x97\x5c\x9d\x81\xc9\x83\xc8\x20\x9e\xe7\x81\x25\x4b\x89\x9f\x8e\xd9\x25\xae\x9f\x09\x23\xc2\x3c\x62\xf5\x3c\x57\xcd\xbf\x69\x1c";
	const char public_b[] = "\xd1\x73\x28\x99\xf6\x11\xcd\x89\x94\x03\x4d\x7f\x41\x3d\xc9\x57\x63\x0e\x54\x93\xc2\x85\xac\xa4\x00\x65\xcb\x63\x11\xbe\x69\x6b";
	const char public_c[] = "\xf4\x4d\xa3\x67\xa8\x8e\xe6\x56\x4f\x02\x02\x11\x45\x67\x27\x08\x2f\x5c\xeb\xee\x8b\x1b\xf5\xeb\x73\x37\x34\x1b\x45\x9b\x39\x22";
	const uint16_t listen_a = 20001;
	const uint16_t listen_b = 20002;
	const uint16_t listen_c = 20003;
	const uint16_t af_inet = AF_INET;
	const uint16_t af_inet6 = AF_INET6;
	const struct sockaddr_in endpoint_b_v4 = {
	    .sin_family = AF_INET,
	    .sin_port = htons(listen_b),
	    .sin_addr = {htonl(INADDR_LOOPBACK)}};
	const struct sockaddr_in endpoint_c_v4 = {
	    .sin_family = AF_INET,
	    .sin_port = htons(listen_c),
	    .sin_addr = {htonl(INADDR_LOOPBACK)}};
	struct sockaddr_in6 endpoint_a_v6 = {
	    .sin6_family = AF_INET6,
	    .sin6_port = htons(listen_a)};
	endpoint_a_v6.sin6_addr = in6addr_loopback;
	struct sockaddr_in6 endpoint_c_v6 = {
	    .sin6_family = AF_INET6,
	    .sin6_port = htons(listen_c)};
	endpoint_c_v6.sin6_addr = in6addr_loopback;
	const struct in_addr first_half_v4 = {0};
	const struct in_addr second_half_v4 = {(uint32_t)htonl(128 << 24)};
	const struct in6_addr first_half_v6 = {{{0}}};
	const struct in6_addr second_half_v6 = {{{0x80}}};
	const uint8_t half_cidr = 1;
	const uint16_t persistent_keepalives[] = {1, 3, 7, 9, 14, 19};
	struct genlmsghdr genlhdr = {
	    .cmd = WG_CMD_SET_DEVICE,
	    .version = 1};
	int sock;
	int id, err;
	sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
	if (sock == -1) {
		return;
	}
	id = netlink_query_family_id(&nlmsg, sock, WG_GENL_NAME, true);
	if (id == -1)
		goto error;
	netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
	netlink_attr(&nlmsg, WGDEVICE_A_IFNAME, ifname_a, strlen(ifname_a) + 1);
	netlink_attr(&nlmsg, WGDEVICE_A_PRIVATE_KEY, private_a, 32);
	netlink_attr(&nlmsg, WGDEVICE_A_LISTEN_PORT, &listen_a, 2);
	netlink_nest(&nlmsg, NLA_F_NESTED | WGDEVICE_A_PEERS);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_b, 32);
	netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_b_v4, sizeof(endpoint_b_v4));
	netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL, &persistent_keepalives[0], 2);
	netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v4, sizeof(first_half_v4));
	netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
	netlink_done(&nlmsg);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v6, sizeof(first_half_v6));
	netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
	netlink_done(&nlmsg);
	netlink_done(&nlmsg);
	netlink_done(&nlmsg);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_c, 32);
	netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_c_v6, sizeof(endpoint_c_v6));
	netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL, &persistent_keepalives[1], 2);
	netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v4, sizeof(second_half_v4));
	netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
	netlink_done(&nlmsg);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v6, sizeof(second_half_v6));
	netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
	netlink_done(&nlmsg);
	netlink_done(&nlmsg);
	netlink_done(&nlmsg);
	netlink_done(&nlmsg);
	err = netlink_send(&nlmsg, sock);
	if (err < 0) {
	}
	netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
	netlink_attr(&nlmsg, WGDEVICE_A_IFNAME, ifname_b, strlen(ifname_b) + 1);
	netlink_attr(&nlmsg, WGDEVICE_A_PRIVATE_KEY, private_b, 32);
	netlink_attr(&nlmsg, WGDEVICE_A_LISTEN_PORT, &listen_b, 2);
	netlink_nest(&nlmsg, NLA_F_NESTED | WGDEVICE_A_PEERS);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_a, 32);
	netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_a_v6, sizeof(endpoint_a_v6));
	netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL, &persistent_keepalives[2], 2);
	netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v4, sizeof(first_half_v4));
	netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
	netlink_done(&nlmsg);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v6, sizeof(first_half_v6));
	netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
	netlink_done(&nlmsg);
	netlink_done(&nlmsg);
	netlink_done(&nlmsg);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_c, 32);
	netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_c_v4, sizeof(endpoint_c_v4));
	netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL, &persistent_keepalives[3], 2);
	netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v4, sizeof(second_half_v4));
	netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
	netlink_done(&nlmsg);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v6, sizeof(second_half_v6));
	netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
	netlink_done(&nlmsg);
	netlink_done(&nlmsg);
	netlink_done(&nlmsg);
	netlink_done(&nlmsg);
	err = netlink_send(&nlmsg, sock);
	if (err < 0) {
	}
	netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
	netlink_attr(&nlmsg, WGDEVICE_A_IFNAME, ifname_c, strlen(ifname_c) + 1);
	netlink_attr(&nlmsg, WGDEVICE_A_PRIVATE_KEY, private_c, 32);
	netlink_attr(&nlmsg, WGDEVICE_A_LISTEN_PORT, &listen_c, 2);
	netlink_nest(&nlmsg, NLA_F_NESTED | WGDEVICE_A_PEERS);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_a, 32);
	netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_a_v6, sizeof(endpoint_a_v6));
	netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL, &persistent_keepalives[4], 2);
	netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v4, sizeof(first_half_v4));
	netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
	netlink_done(&nlmsg);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &first_half_v6, sizeof(first_half_v6));
	netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
	netlink_done(&nlmsg);
	netlink_done(&nlmsg);
	netlink_done(&nlmsg);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGPEER_A_PUBLIC_KEY, public_b, 32);
	netlink_attr(&nlmsg, WGPEER_A_ENDPOINT, &endpoint_b_v4, sizeof(endpoint_b_v4));
	netlink_attr(&nlmsg, WGPEER_A_PERSISTENT_KEEPALIVE_INTERVAL, &persistent_keepalives[5], 2);
	netlink_nest(&nlmsg, NLA_F_NESTED | WGPEER_A_ALLOWEDIPS);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet, 2);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v4, sizeof(second_half_v4));
	netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
	netlink_done(&nlmsg);
	netlink_nest(&nlmsg, NLA_F_NESTED | 0);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_FAMILY, &af_inet6, 2);
	netlink_attr(&nlmsg, WGALLOWEDIP_A_IPADDR, &second_half_v6, sizeof(second_half_v6));
	netlink_attr(&nlmsg, WGALLOWEDIP_A_CIDR_MASK, &half_cidr, 1);
	netlink_done(&nlmsg);
	netlink_done(&nlmsg);
	netlink_done(&nlmsg);
	netlink_done(&nlmsg);
	err = netlink_send(&nlmsg, sock);
	if (err < 0) {
	}

error:
	close(sock);
}

static void initialize_netdevices(void)
{
	char netdevsim[16];
	sprintf(netdevsim, "netdevsim%d", (int)procid);
	struct {
		const char* type;
		const char* dev;
	} devtypes[] = {
	    {"ip6gretap", "ip6gretap0"},
	    {"bridge", "bridge0"},
	    {"vcan", "vcan0"},
	    {"bond", "bond0"},
	    {"team", "team0"},
	    {"dummy", "dummy0"},
	    {"nlmon", "nlmon0"},
	    {"caif", "caif0"},
	    {"batadv", "batadv0"},
	    {"vxcan", "vxcan1"},
	    {"veth", 0},
	    {"wireguard", "wg0"},
	    {"wireguard", "wg1"},
	    {"wireguard", "wg2"},
	};
	const char* devmasters[] = {"bridge", "bond", "team", "batadv"};
	struct {
		const char* name;
		int macsize;
		bool noipv6;
	} devices[] = {
	    {"lo", ETH_ALEN},
	    {"sit0", 0},
	    {"bridge0", ETH_ALEN},
	    {"vcan0", 0, true},
	    {"tunl0", 0},
	    {"gre0", 0},
	    {"gretap0", ETH_ALEN},
	    {"ip_vti0", 0},
	    {"ip6_vti0", 0},
	    {"ip6tnl0", 0},
	    {"ip6gre0", 0},
	    {"ip6gretap0", ETH_ALEN},
	    {"erspan0", ETH_ALEN},
	    {"bond0", ETH_ALEN},
	    {"veth0", ETH_ALEN},
	    {"veth1", ETH_ALEN},
	    {"team0", ETH_ALEN},
	    {"veth0_to_bridge", ETH_ALEN},
	    {"veth1_to_bridge", ETH_ALEN},
	    {"veth0_to_bond", ETH_ALEN},
	    {"veth1_to_bond", ETH_ALEN},
	    {"veth0_to_team", ETH_ALEN},
	    {"veth1_to_team", ETH_ALEN},
	    {"veth0_to_hsr", ETH_ALEN},
	    {"veth1_to_hsr", ETH_ALEN},
	    {"hsr0", 0},
	    {"dummy0", ETH_ALEN},
	    {"nlmon0", 0},
	    {"vxcan0", 0, true},
	    {"vxcan1", 0, true},
	    {"caif0", ETH_ALEN},
	    {"batadv0", ETH_ALEN},
	    {netdevsim, ETH_ALEN},
	    {"xfrm0", ETH_ALEN},
	    {"veth0_virt_wifi", ETH_ALEN},
	    {"veth1_virt_wifi", ETH_ALEN},
	    {"virt_wifi0", ETH_ALEN},
	    {"veth0_vlan", ETH_ALEN},
	    {"veth1_vlan", ETH_ALEN},
	    {"vlan0", ETH_ALEN},
	    {"vlan1", ETH_ALEN},
	    {"macvlan0", ETH_ALEN},
	    {"macvlan1", ETH_ALEN},
	    {"ipvlan0", ETH_ALEN},
	    {"ipvlan1", ETH_ALEN},
	    {"veth0_macvtap", ETH_ALEN},
	    {"veth1_macvtap", ETH_ALEN},
	    {"macvtap0", ETH_ALEN},
	    {"macsec0", ETH_ALEN},
	    {"veth0_to_batadv", ETH_ALEN},
	    {"veth1_to_batadv", ETH_ALEN},
	    {"batadv_slave_0", ETH_ALEN},
	    {"batadv_slave_1", ETH_ALEN},
	    {"geneve0", ETH_ALEN},
	    {"geneve1", ETH_ALEN},
	    {"wg0", 0},
	    {"wg1", 0},
	    {"wg2", 0},
	};
	int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (sock == -1)
	exit(1);
	unsigned i;
	for (i = 0; i < sizeof(devtypes) / sizeof(devtypes[0]); i++)
		netlink_add_device(&nlmsg, sock, devtypes[i].type, devtypes[i].dev);
	for (i = 0; i < sizeof(devmasters) / (sizeof(devmasters[0])); i++) {
		char master[32], slave0[32], veth0[32], slave1[32], veth1[32];
		sprintf(slave0, "%s_slave_0", devmasters[i]);
		sprintf(veth0, "veth0_to_%s", devmasters[i]);
		netlink_add_veth(&nlmsg, sock, slave0, veth0);
		sprintf(slave1, "%s_slave_1", devmasters[i]);
		sprintf(veth1, "veth1_to_%s", devmasters[i]);
		netlink_add_veth(&nlmsg, sock, slave1, veth1);
		sprintf(master, "%s0", devmasters[i]);
		netlink_device_change(&nlmsg, sock, slave0, false, master, 0, 0, NULL);
		netlink_device_change(&nlmsg, sock, slave1, false, master, 0, 0, NULL);
	}
	netlink_add_xfrm(&nlmsg, sock, "xfrm0");
	netlink_device_change(&nlmsg, sock, "bridge_slave_0", true, 0, 0, 0, NULL);
	netlink_device_change(&nlmsg, sock, "bridge_slave_1", true, 0, 0, 0, NULL);
	netlink_add_veth(&nlmsg, sock, "hsr_slave_0", "veth0_to_hsr");
	netlink_add_veth(&nlmsg, sock, "hsr_slave_1", "veth1_to_hsr");
	netlink_add_hsr(&nlmsg, sock, "hsr0", "hsr_slave_0", "hsr_slave_1");
	netlink_device_change(&nlmsg, sock, "hsr_slave_0", true, 0, 0, 0, NULL);
	netlink_device_change(&nlmsg, sock, "hsr_slave_1", true, 0, 0, 0, NULL);
	netlink_add_veth(&nlmsg, sock, "veth0_virt_wifi", "veth1_virt_wifi");
	netlink_add_linked(&nlmsg, sock, "virt_wifi", "virt_wifi0", "veth1_virt_wifi");
	netlink_add_veth(&nlmsg, sock, "veth0_vlan", "veth1_vlan");
	netlink_add_vlan(&nlmsg, sock, "vlan0", "veth0_vlan", 0, htons(ETH_P_8021Q));
	netlink_add_vlan(&nlmsg, sock, "vlan1", "veth0_vlan", 1, htons(ETH_P_8021AD));
	netlink_add_macvlan(&nlmsg, sock, "macvlan0", "veth1_vlan");
	netlink_add_macvlan(&nlmsg, sock, "macvlan1", "veth1_vlan");
	netlink_add_ipvlan(&nlmsg, sock, "ipvlan0", "veth0_vlan", IPVLAN_MODE_L2, 0);
	netlink_add_ipvlan(&nlmsg, sock, "ipvlan1", "veth0_vlan", IPVLAN_MODE_L3S, IPVLAN_F_VEPA);
	netlink_add_veth(&nlmsg, sock, "veth0_macvtap", "veth1_macvtap");
	netlink_add_linked(&nlmsg, sock, "macvtap", "macvtap0", "veth0_macvtap");
	netlink_add_linked(&nlmsg, sock, "macsec", "macsec0", "veth1_macvtap");
	char addr[32];
	sprintf(addr, DEV_IPV4, 14 + 10);
	struct in_addr geneve_addr4;
	if (inet_pton(AF_INET, addr, &geneve_addr4) <= 0)
	exit(1);
	struct in6_addr geneve_addr6;
	if (inet_pton(AF_INET6, "fc00::01", &geneve_addr6) <= 0)
	exit(1);
	netlink_add_geneve(&nlmsg, sock, "geneve0", 0, &geneve_addr4, 0);
	netlink_add_geneve(&nlmsg, sock, "geneve1", 1, 0, &geneve_addr6);
	netdevsim_add((int)procid, 4);
	netlink_wireguard_setup();
	for (i = 0; i < sizeof(devices) / (sizeof(devices[0])); i++) {
		char addr[32];
		sprintf(addr, DEV_IPV4, i + 10);
		netlink_add_addr4(&nlmsg, sock, devices[i].name, addr);
		if (!devices[i].noipv6) {
			sprintf(addr, DEV_IPV6, i + 10);
			netlink_add_addr6(&nlmsg, sock, devices[i].name, addr);
		}
		uint64_t macaddr = DEV_MAC + ((i + 10ull) << 40);
		netlink_device_change(&nlmsg, sock, devices[i].name, true, 0, &macaddr, devices[i].macsize, NULL);
	}
	close(sock);
}
static void initialize_netdevices_init(void)
{
	int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	if (sock == -1)
	exit(1);
	struct {
		const char* type;
		int macsize;
		bool noipv6;
		bool noup;
	} devtypes[] = {
	    {"nr", 7, true},
	    {"rose", 5, true, true},
	};
	unsigned i;
	for (i = 0; i < sizeof(devtypes) / sizeof(devtypes[0]); i++) {
		char dev[32], addr[32];
		sprintf(dev, "%s%d", devtypes[i].type, (int)procid);
		sprintf(addr, "172.30.%d.%d", i, (int)procid + 1);
		netlink_add_addr4(&nlmsg, sock, dev, addr);
		if (!devtypes[i].noipv6) {
			sprintf(addr, "fe88::%02x:%02x", i, (int)procid + 1);
			netlink_add_addr6(&nlmsg, sock, dev, addr);
		}
		int macsize = devtypes[i].macsize;
		uint64_t macaddr = 0xbbbbbb + ((unsigned long long)i << (8 * (macsize - 2))) +
				 (procid << (8 * (macsize - 1)));
		netlink_device_change(&nlmsg, sock, dev, !devtypes[i].noup, 0, &macaddr, macsize, NULL);
	}
	close(sock);

}

#define MAX_FDS 30

static long syz_genetlink_get_family_id(volatile long name, volatile long sock_arg)
{
	int fd = sock_arg;
	if (fd < 0) {
		fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
		if (fd == -1) {
			return -1;
		}
	}
	struct nlmsg nlmsg_tmp;
	int ret = netlink_query_family_id(&nlmsg_tmp, fd, (char*)name, false);
	if ((int)sock_arg < 0)
		close(fd);
	if (ret < 0) {
		return -1;
	}
	return ret;
}

static void setup_gadgetfs();
static void setup_binderfs();
static void setup_fusectl();
static void sandbox_common_mount_tmpfs(void)
{
	write_file("/proc/sys/fs/mount-max", "100000");
	if (mkdir("./syz-tmp", 0777))
	exit(1);
	if (mount("", "./syz-tmp", "tmpfs", 0, NULL))
	exit(1);
	if (mkdir("./syz-tmp/newroot", 0777))
	exit(1);
	if (mkdir("./syz-tmp/newroot/dev", 0700))
	exit(1);
	unsigned bind_mount_flags = MS_BIND | MS_REC | MS_PRIVATE;
	if (mount("/dev", "./syz-tmp/newroot/dev", NULL, bind_mount_flags, NULL))
	exit(1);
	if (mkdir("./syz-tmp/newroot/proc", 0700))
	exit(1);
	if (mount("syz-proc", "./syz-tmp/newroot/proc", "proc", 0, NULL))
	exit(1);
	if (mkdir("./syz-tmp/newroot/selinux", 0700))
	exit(1);
	const char* selinux_path = "./syz-tmp/newroot/selinux";
	if (mount("/selinux", selinux_path, NULL, bind_mount_flags, NULL)) {
		if (errno != ENOENT)
	exit(1);
		if (mount("/sys/fs/selinux", selinux_path, NULL, bind_mount_flags, NULL) && errno != ENOENT)
	exit(1);
	}
	if (mkdir("./syz-tmp/newroot/sys", 0700))
	exit(1);
	if (mount("/sys", "./syz-tmp/newroot/sys", 0, bind_mount_flags, NULL))
	exit(1);
	if (mount("/sys/kernel/debug", "./syz-tmp/newroot/sys/kernel/debug", NULL, bind_mount_flags, NULL) && errno != ENOENT)
	exit(1);
	if (mount("/sys/fs/smackfs", "./syz-tmp/newroot/sys/fs/smackfs", NULL, bind_mount_flags, NULL) && errno != ENOENT)
	exit(1);
	if (mount("/proc/sys/fs/binfmt_misc", "./syz-tmp/newroot/proc/sys/fs/binfmt_misc", NULL, bind_mount_flags, NULL) && errno != ENOENT)
	exit(1);
	if (mkdir("./syz-tmp/newroot/syz-inputs", 0700))
	exit(1);
	if (mount("/syz-inputs", "./syz-tmp/newroot/syz-inputs", NULL, bind_mount_flags | MS_RDONLY, NULL) && errno != ENOENT)
	exit(1);
	if (mkdir("./syz-tmp/pivot", 0777))
	exit(1);
	if (syscall(SYS_pivot_root, "./syz-tmp", "./syz-tmp/pivot")) {
		if (chdir("./syz-tmp"))
	exit(1);
	} else {
		if (chdir("/"))
	exit(1);
		if (umount2("./pivot", MNT_DETACH))
	exit(1);
	}
	if (chroot("./newroot"))
	exit(1);
	if (chdir("/"))
	exit(1);
	setup_gadgetfs();
	setup_binderfs();
	setup_fusectl();
}

static void setup_gadgetfs()
{
	if (mkdir("/dev/gadgetfs", 0777)) {
	}
	if (mount("gadgetfs", "/dev/gadgetfs", "gadgetfs", 0, NULL)) {
	}
}

static void setup_fusectl()
{
	if (mount(0, "/sys/fs/fuse/connections", "fusectl", 0, 0)) {
	}
}

static void setup_binderfs()
{
	if (mkdir("/dev/binderfs", 0777)) {
	}
	if (mount("binder", "/dev/binderfs", "binder", 0, NULL)) {
	}
	if (symlink("/dev/binderfs", "./binderfs")) {
	}
}

static void loop();

static void sandbox_common()
{
	prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
	if (getppid() == 1)
	exit(1);
	struct rlimit rlim;
	rlim.rlim_cur = rlim.rlim_max = (200 << 20);
	setrlimit(RLIMIT_AS, &rlim);
	rlim.rlim_cur = rlim.rlim_max = 32 << 20;
	setrlimit(RLIMIT_MEMLOCK, &rlim);
	rlim.rlim_cur = rlim.rlim_max = 136 << 20;
	setrlimit(RLIMIT_FSIZE, &rlim);
	rlim.rlim_cur = rlim.rlim_max = 1 << 20;
	setrlimit(RLIMIT_STACK, &rlim);
	rlim.rlim_cur = rlim.rlim_max = 128 << 20;
	setrlimit(RLIMIT_CORE, &rlim);
	rlim.rlim_cur = rlim.rlim_max = 256;
	setrlimit(RLIMIT_NOFILE, &rlim);
	if (unshare(CLONE_NEWNS)) {
	}
	if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
	}
	if (unshare(CLONE_NEWIPC)) {
	}
	if (unshare(0x02000000)) {
	}
	if (unshare(CLONE_NEWUTS)) {
	}
	if (unshare(CLONE_SYSVSEM)) {
	}
	typedef struct {
		const char* name;
		const char* value;
	} sysctl_t;
	static const sysctl_t sysctls[] = {
	    {"/proc/sys/kernel/shmmax", "16777216"},
	    {"/proc/sys/kernel/shmall", "536870912"},
	    {"/proc/sys/kernel/shmmni", "1024"},
	    {"/proc/sys/kernel/msgmax", "8192"},
	    {"/proc/sys/kernel/msgmni", "1024"},
	    {"/proc/sys/kernel/msgmnb", "1024"},
	    {"/proc/sys/kernel/sem", "1024 1048576 500 1024"},
	};
	unsigned i;
	for (i = 0; i < sizeof(sysctls) / sizeof(sysctls[0]); i++)
		write_file(sysctls[i].name, sysctls[i].value);
}

static int wait_for_loop(int pid)
{
	if (pid < 0)
	exit(1);
	int status = 0;
	while (waitpid(-1, &status, __WALL) != pid) {
	}
	return WEXITSTATUS(status);
}

static void drop_caps(void)
{
	struct __user_cap_header_struct cap_hdr = {};
	struct __user_cap_data_struct cap_data[2] = {};
	cap_hdr.version = _LINUX_CAPABILITY_VERSION_3;
	cap_hdr.pid = getpid();
	if (syscall(SYS_capget, &cap_hdr, &cap_data))
	exit(1);
	const int drop = (1 << CAP_SYS_PTRACE) | (1 << CAP_SYS_NICE);
	cap_data[0].effective &= ~drop;
	cap_data[0].permitted &= ~drop;
	cap_data[0].inheritable &= ~drop;
	if (syscall(SYS_capset, &cap_hdr, &cap_data))
	exit(1);
}

static int do_sandbox_none(void)
{
	if (unshare(CLONE_NEWPID)) {
	}
	int pid = fork();
	if (pid != 0)
		return wait_for_loop(pid);
	sandbox_common();
	drop_caps();
	initialize_netdevices_init();
	if (unshare(CLONE_NEWNET)) {
	}
	write_file("/proc/sys/net/ipv4/ping_group_range", "0 65535");
	initialize_netdevices();
	sandbox_common_mount_tmpfs();
	loop();
	exit(1);
}

static void kill_and_wait(int pid, int* status)
{
	kill(-pid, SIGKILL);
	kill(pid, SIGKILL);
	for (int i = 0; i < 100; i++) {
		if (waitpid(-1, status, WNOHANG | __WALL) == pid)
			return;
		usleep(1000);
	}
	DIR* dir = opendir("/sys/fs/fuse/connections");
	if (dir) {
		for (;;) {
			struct dirent* ent = readdir(dir);
			if (!ent)
				break;
			if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
				continue;
			char abort[300];
			snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort", ent->d_name);
			int fd = open(abort, O_WRONLY);
			if (fd == -1) {
				continue;
			}
			if (write(fd, abort, 1) < 0) {
			}
			close(fd);
		}
		closedir(dir);
	} else {
	}
	while (waitpid(-1, status, __WALL) != pid) {
	}
}

static void setup_test()
{
	prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
	setpgrp();
	write_file("/proc/self/oom_score_adj", "1000");
}

static void close_fds()
{
	for (int fd = 3; fd < MAX_FDS; fd++)
		close(fd);
}

#define USLEEP_FORKED_CHILD (3 * 50 *1000)

static long handle_clone_ret(long ret)
{
	if (ret != 0) {
		return ret;
	}
	usleep(USLEEP_FORKED_CHILD);
	syscall(__NR_exit, 0);
	while (1) {
	}
}

static long syz_clone(volatile long flags, volatile long stack, volatile long stack_len,
		      volatile long ptid, volatile long ctid, volatile long tls)
{
	long sp = (stack + stack_len) & ~15;
	long ret = (long)syscall(__NR_clone, flags & ~CLONE_VM, sp, ptid, ctid, tls);
	return handle_clone_ret(ret);
}

struct thread_t {
	int created, call;
	event_t ready, done;
};

static struct thread_t threads[16];
static void execute_call(int call);
static int running;

static void* thr(void* arg)
{
	struct thread_t* th = (struct thread_t*)arg;
	for (;;) {
		event_wait(&th->ready);
		event_reset(&th->ready);
		execute_call(th->call);
		__atomic_fetch_sub(&running, 1, __ATOMIC_RELAXED);
		event_set(&th->done);
	}
	return 0;
}

static void execute_one(void)
{
	if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {
	}
	int i, call, thread;
	for (call = 0; call < 9; call++) {
		for (thread = 0; thread < (int)(sizeof(threads) / sizeof(threads[0])); thread++) {
			struct thread_t* th = &threads[thread];
			if (!th->created) {
				th->created = 1;
				event_init(&th->ready);
				event_init(&th->done);
				event_set(&th->done);
				thread_start(thr, th);
			}
			if (!event_isset(&th->done))
				continue;
			event_reset(&th->done);
			th->call = call;
			__atomic_fetch_add(&running, 1, __ATOMIC_RELAXED);
			event_set(&th->ready);
			event_timedwait(&th->done, 50);
			break;
		}
	}
	for (i = 0; i < 100 && __atomic_load_n(&running, __ATOMIC_RELAXED); i++)
		sleep_ms(1);
	close_fds();
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
	int iter = 0;
	for (;; iter++) {
		int pid = fork();
		if (pid < 0)
	exit(1);
		if (pid == 0) {
			setup_test();
			execute_one();
			exit(0);
		}
		int status = 0;
		uint64_t start = current_time_ms();
		for (;;) {
			sleep_ms(10);
			if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
				break;
			if (current_time_ms() - start < 5000)
				continue;
			kill_and_wait(pid, &status);
			break;
		}
	}
}

uint64_t r[5] = {0xffffffffffffffff, 0x0, 0x0, 0xffffffffffffffff, 0xffffffffffffffff};

void execute_call(int call)
{
		intptr_t res = 0;
	switch (call) {
	case 0:
//  socket$nl_generic arguments: [
//    domain: const = 0x10 (8 bytes)
//    type: const = 0x3 (8 bytes)
//    proto: const = 0x10 (4 bytes)
//  ]
//  returns sock_nl_generic
		res = syscall(__NR_socket, /*domain=*/0x10ul, /*type=*/3ul, /*proto=*/0x10);
		if (res != -1)
				r[0] = res;
		break;
	case 1:
//  syz_genetlink_get_family_id$devlink arguments: [
//    name: ptr[in, buffer] {
//      buffer: {64 65 76 6c 69 6e 6b 00} (length 0x8)
//    }
//    fd: sock_nl_generic (resource)
//  ]
//  returns genl_devlink_family_id
memcpy((void*)0x200000000080, "devlink\000", 8);
		res = -1;
res = syz_genetlink_get_family_id(/*name=*/0x200000000080, /*fd=*/-1);
		if (res != -1)
				r[1] = res;
		break;
	case 2:
//  gettid arguments: [
//  ]
//  returns pid
		res = syscall(__NR_gettid);
		if (res != -1)
				r[2] = res;
		break;
	case 3:
//  sendmsg$DEVLINK_CMD_RELOAD arguments: [
//    fd: sock_nl_generic (resource)
//    msg: ptr[in, msghdr_netlink[netlink_msg_t[genl_devlink_family_id, genlmsghdr_t[DEVLINK_CMD_RELOAD], devlink_reload_policy]]] {
//      msghdr_netlink[netlink_msg_t[genl_devlink_family_id, genlmsghdr_t[DEVLINK_CMD_RELOAD], devlink_reload_policy]] {
//        addr: nil
//        addrlen: len = 0x0 (4 bytes)
//        pad = 0x0 (4 bytes)
//        vec: ptr[in, iovec[in, netlink_msg_t[genl_devlink_family_id, genlmsghdr_t[DEVLINK_CMD_RELOAD], devlink_reload_policy]]] {
//          iovec[in, netlink_msg_t[genl_devlink_family_id, genlmsghdr_t[DEVLINK_CMD_RELOAD], devlink_reload_policy]] {
//            addr: ptr[in, netlink_msg_t[genl_devlink_family_id, genlmsghdr_t[DEVLINK_CMD_RELOAD], devlink_reload_policy]] {
//              netlink_msg_t[genl_devlink_family_id, genlmsghdr_t[DEVLINK_CMD_RELOAD], devlink_reload_policy] {
//                len: len = 0x3c (4 bytes)
//                type: genl_devlink_family_id (resource)
//                flags: netlink_msg_flags = 0x536ae464467e3e0b (2 bytes)
//                seq: int32 = 0x0 (4 bytes)
//                pid: int32 = 0x0 (4 bytes)
//                payload: genlmsghdr_t[DEVLINK_CMD_RELOAD] {
//                  cmd: const = 0x25 (1 bytes)
//                  version: const = 0x0 (1 bytes)
//                  reserved: const = 0x0 (2 bytes)
//                }
//                attrs: array[devlink_reload_policy] {
//                  devlink_reload_policy {
//                    handle: union devlink_handle {
//                      nsim: devlink_nl_policy$nsim {
//                        DEVLINK_ATTR_BUS_NAME: nlattr_t[const[DEVLINK_ATTR_BUS_NAME, int16], string["netdevsim"]] {
//                          nla_len: offsetof = 0xe (2 bytes)
//                          nla_type: const = 0x1 (2 bytes)
//                          payload: buffer: {6e 65 74 64 65 76 73 69 6d 00} (length 0xa)
//                          size: buffer: {} (length 0x0)
//                          pad = 0x0 (2 bytes)
//                        }
//                        DEVLINK_ATTR_DEV_NAME: nlattr_t[const[DEVLINK_ATTR_DEV_NAME, int16], devlink_devname] {
//                          nla_len: offsetof = 0xf (2 bytes)
//                          nla_type: const = 0x2 (2 bytes)
//                          payload: devlink_devname {
//                            prefix: buffer: {6e 65 74 64 65 76 73 69 6d} (length 0x9)
//                            id: proc = 0x0 (1 bytes)
//                            z: const = 0x0 (1 bytes)
//                          }
//                          size: buffer: {} (length 0x0)
//                          pad = 0x0 (1 bytes)
//                        }
//                      }
//                    }
//                    arg: union devlink_nl_policy$reload {
//                      DEVLINK_ATTR_NETNS_PID: nlattr_t[const[DEVLINK_ATTR_NETNS_PID, int16], pid] {
//                        nla_len: offsetof = 0x8 (2 bytes)
//                        nla_type: const = 0x8b (2 bytes)
//                        payload: pid (resource)
//                        size: buffer: {} (length 0x0)
//                      }
//                    }
//                  }
//                }
//              }
//            }
//            len: len = 0x3c (8 bytes)
//          }
//        }
//        vlen: const = 0x1 (8 bytes)
//        ctrl: const = 0x0 (8 bytes)
//        ctrllen: const = 0x0 (8 bytes)
//        f: send_flags = 0x0 (4 bytes)
//        pad = 0x0 (4 bytes)
//      }
//    }
//    f: send_flags = 0x0 (8 bytes)
//  ]
*(uint64_t*)0x200000000800 = 0;
*(uint32_t*)0x200000000808 = 0;
*(uint64_t*)0x200000000810 = 0x200000000380;
*(uint64_t*)0x200000000380 = 0x200000000000;
*(uint32_t*)0x200000000000 = 0x3c;
*(uint16_t*)0x200000000004 = r[1];
*(uint16_t*)0x200000000006 = 0x3e0b;
*(uint32_t*)0x200000000008 = 0;
*(uint32_t*)0x20000000000c = 0;
*(uint8_t*)0x200000000010 = 0x25;
*(uint8_t*)0x200000000011 = 0;
*(uint16_t*)0x200000000012 = 0;
*(uint16_t*)0x200000000014 = 0xe;
*(uint16_t*)0x200000000016 = 1;
memcpy((void*)0x200000000018, "netdevsim\000", 10);
*(uint16_t*)0x200000000024 = 0xf;
*(uint16_t*)0x200000000026 = 2;
memcpy((void*)0x200000000028, "netdevsim", 9);
*(uint8_t*)0x200000000031 = 0x30;
*(uint8_t*)0x200000000032 = 0;
*(uint16_t*)0x200000000034 = 8;
*(uint16_t*)0x200000000036 = 0x8b;
*(uint32_t*)0x200000000038 = r[2];
*(uint64_t*)0x200000000388 = 0x3c;
*(uint64_t*)0x200000000818 = 1;
*(uint64_t*)0x200000000820 = 0;
*(uint64_t*)0x200000000828 = 0;
*(uint32_t*)0x200000000830 = 0;
		syscall(__NR_sendmsg, /*fd=*/r[0], /*msg=*/0x200000000800ul, /*f=*/0ul);
		break;
	case 4:
//  syz_clone arguments: [
//    flags: clone_flags = 0x40b04000 (8 bytes)
//    stack: nil
//    stack_len: bytesize = 0x0 (8 bytes)
//    parentid: nil
//    childtid: nil
//    tls: nil
//  ]
//  returns pid
syz_clone(/*flags=CLONE_NEWNET|CLONE_UNTRACED|CLONE_CHILD_CLEARTID|CLONE_PARENT_SETTID|CLONE_VFORK*/0x40b04000, /*stack=*/0, /*stack_len=*/0, /*parentid=*/0, /*childtid=*/0, /*tls=*/0);
		break;
	case 5:
//  socket$netlink arguments: [
//    domain: const = 0x10 (8 bytes)
//    type: const = 0x3 (8 bytes)
//    proto: netlink_proto = 0x0 (4 bytes)
//  ]
//  returns sock_netlink
		res = syscall(__NR_socket, /*domain=*/0x10ul, /*type=*/3ul, /*proto=*/0);
		if (res != -1)
				r[3] = res;
		break;
	case 6:
//  sendmsg$nl_route arguments: [
//    fd: sock_nl_route (resource)
//    msg: ptr[in, msghdr_netlink[netlink_msg_route]] {
//      msghdr_netlink[netlink_msg_route] {
//        addr: nil
//        addrlen: len = 0x0 (4 bytes)
//        pad = 0x0 (4 bytes)
//        vec: ptr[in, iovec[in, netlink_msg_route]] {
//          iovec[in, netlink_msg_route] {
//            addr: ptr[in, netlink_msg_route] {
//              union netlink_msg_route {
//                newlink: netlink_msg_t[const[RTM_NEWLINK, int16], ifinfomsg[AF_UNSPEC], ifla_policy] {
//                  len: len = 0x28 (4 bytes)
//                  type: const = 0x10 (2 bytes)
//                  flags: netlink_msg_flags = 0x1 (2 bytes)
//                  seq: int32 = 0x0 (4 bytes)
//                  pid: int32 = 0x0 (4 bytes)
//                  payload: ifinfomsg[AF_UNSPEC] {
//                    ifi_family: const = 0x0 (1 bytes)
//                    __ifi_pad: const = 0x0 (1 bytes)
//                    ifi_type: const = 0x0 (2 bytes)
//                    ifi_index: ifindex (resource)
//                    ifi_flags: net_device_flags = 0xf0ffff (4 bytes)
//                    ifi_change: net_device_flags = 0x0 (4 bytes)
//                  }
//                  attrs: array[ifla_policy] {
//                    union ifla_policy {
//                      IFLA_GROUP: nlattr_t[const[IFLA_GROUP, int16], int32] {
//                        nla_len: offsetof = 0x8 (2 bytes)
//                        nla_type: const = 0x1b (2 bytes)
//                        payload: int32 = 0x0 (4 bytes)
//                        size: buffer: {} (length 0x0)
//                      }
//                    }
//                  }
//                }
//              }
//            }
//            len: len = 0x28 (8 bytes)
//          }
//        }
//        vlen: const = 0x1 (8 bytes)
//        ctrl: const = 0x0 (8 bytes)
//        ctrllen: const = 0x0 (8 bytes)
//        f: send_flags = 0x0 (4 bytes)
//        pad = 0x0 (4 bytes)
//      }
//    }
//    f: send_flags = 0x0 (8 bytes)
//  ]
*(uint64_t*)0x2000000000c0 = 0;
*(uint32_t*)0x2000000000c8 = 0;
*(uint64_t*)0x2000000000d0 = 0x2000000013c0;
*(uint64_t*)0x2000000013c0 = 0x200000000040;
*(uint32_t*)0x200000000040 = 0x28;
*(uint16_t*)0x200000000044 = 0x10;
*(uint16_t*)0x200000000046 = 1;
*(uint32_t*)0x200000000048 = 0;
*(uint32_t*)0x20000000004c = 0;
*(uint8_t*)0x200000000050 = 0;
*(uint8_t*)0x200000000051 = 0;
*(uint16_t*)0x200000000052 = 0;
*(uint32_t*)0x200000000054 = 0;
*(uint32_t*)0x200000000058 = 0xf0ffff;
*(uint32_t*)0x20000000005c = 0;
*(uint16_t*)0x200000000060 = 8;
*(uint16_t*)0x200000000062 = 0x1b;
*(uint32_t*)0x200000000064 = 0;
*(uint64_t*)0x2000000013c8 = 0x28;
*(uint64_t*)0x2000000000d8 = 1;
*(uint64_t*)0x2000000000e0 = 0;
*(uint64_t*)0x2000000000e8 = 0;
*(uint32_t*)0x2000000000f0 = 0;
		syscall(__NR_sendmsg, /*fd=*/r[3], /*msg=*/0x2000000000c0ul, /*f=*/0ul);
		break;
	case 7:
//  socket$nl_route arguments: [
//    domain: const = 0x10 (8 bytes)
//    type: const = 0x3 (8 bytes)
//    proto: const = 0x0 (4 bytes)
//  ]
//  returns sock_nl_route
		res = syscall(__NR_socket, /*domain=*/0x10ul, /*type=*/3ul, /*proto=*/0);
		if (res != -1)
				r[4] = res;
		break;
	case 8:
//  sendmsg$nl_route_sched arguments: [
//    fd: sock_nl_route (resource)
//    msg: ptr[in, msghdr_netlink[netlink_msg_route_sched]] {
//      msghdr_netlink[netlink_msg_route_sched] {
//        addr: nil
//        addrlen: len = 0x0 (4 bytes)
//        pad = 0x0 (4 bytes)
//        vec: ptr[in, iovec[in, netlink_msg_route_sched]] {
//          iovec[in, netlink_msg_route_sched] {
//            addr: ptr[in, netlink_msg_route_sched] {
//              union netlink_msg_route_sched {
//                newqdisc: netlink_msg_t[const[RTM_NEWQDISC, int16], tcmsg[AF_UNSPEC], rtm_tca_policy] {
//                  len: len = 0x54 (4 bytes)
//                  type: const = 0x10 (2 bytes)
//                  flags: netlink_msg_flags = 0x1 (2 bytes)
//                  seq: int32 = 0x0 (4 bytes)
//                  pid: int32 = 0x0 (4 bytes)
//                  payload: tcmsg[AF_UNSPEC] {
//                    family: const = 0x6 (1 bytes)
//                    tcm__pad1: const = 0x0 (1 bytes)
//                    tcm__pad2: const = 0x8100 (2 bytes)
//                    ifindex: ifindex (resource)
//                    tcm_handle: tcm_handle {
//                      minor: tcm_handle_offsets = 0x0 (2 bytes)
//                      major: tcm_handle_offsets = 0x0 (2 bytes)
//                    }
//                    tcm_parent: tcm_handle {
//                      minor: tcm_handle_offsets = 0xfff1 (2 bytes)
//                      major: tcm_handle_offsets = 0x0 (2 bytes)
//                    }
//                    tcm_info: tcm_handle {
//                      minor: tcm_handle_offsets = 0xe (2 bytes)
//                      major: tcm_handle_offsets = 0x10 (2 bytes)
//                    }
//                  }
//                  attrs: array[rtm_tca_policy] {
//                    union rtm_tca_policy {
//                      TCA_EGRESS_BLOCK: nlattr_t[const[TCA_EGRESS_BLOCK, int16], int32] {
//                        nla_len: offsetof = 0x8 (2 bytes)
//                        nla_type: const = 0xe (2 bytes)
//                        payload: int32 = 0x7 (4 bytes)
//                        size: buffer: {} (length 0x0)
//                      }
//                    }
//                    union rtm_tca_policy {
//                      TCA_STAB: nlattr_tt[const[TCA_STAB, int16:14], 0, 1, array[stab_policy]] {
//                        nla_len: offsetof = 0x28 (2 bytes)
//                        nla_type: const = 0x8 (1 bytes)
//                        NLA_F_NET_BYTEORDER: const = 0x0 (0 bytes)
//                        NLA_F_NESTED: const = 0x1 (1 bytes)
//                        payload: array[stab_policy] {
//                          stab_policy {
//                            TCA_STAB_BASE: nlattr_t[const[TCA_STAB_BASE, int16], tc_sizespec] {
//                              nla_len: offsetof = 0x1c (2 bytes)
//                              nla_type: const = 0x11 (2 bytes)
//                              payload: tc_sizespec {
//                                cell_log: int8 = 0x0 (1 bytes)
//                                size_log: int8 = 0x0 (1 bytes)
//                                cell_align: int16 = 0x0 (2 bytes)
//                                overhead: int32 = 0x0 (4 bytes)
//                                linklayer: linklayer = 0x0 (4 bytes)
//                                mpu: int32 = 0x5e06209c (4 bytes)
//                                mtu: int32 = 0x0 (4 bytes)
//                                tsize: len = 0x2 (4 bytes)
//                              }
//                              size: buffer: {} (length 0x0)
//                            }
//                            TCA_STAB_DATA: nlattr_t[const[TCA_STAB_DATA, int16], array[int16]] {
//                              nla_len: offsetof = 0x8 (2 bytes)
//                              nla_type: const = 0x1b (2 bytes)
//                              payload: array[int16] {
//                                int16 = 0x0 (2 bytes)
//                                int16 = 0x0 (2 bytes)
//                              }
//                              size: buffer: {} (length 0x0)
//                            }
//                          }
//                        }
//                        size: buffer: {} (length 0x0)
//                      }
//                    }
//                  }
//                }
//              }
//            }
//            len: len = 0x54 (8 bytes)
//          }
//        }
//        vlen: const = 0x1 (8 bytes)
//        ctrl: const = 0x0 (8 bytes)
//        ctrllen: const = 0x0 (8 bytes)
//        f: send_flags = 0x0 (4 bytes)
//        pad = 0x0 (4 bytes)
//      }
//    }
//    f: send_flags = 0x0 (8 bytes)
//  ]
*(uint64_t*)0x200000000180 = 0;
*(uint32_t*)0x200000000188 = 0;
*(uint64_t*)0x200000000190 = 0x200000000280;
*(uint64_t*)0x200000000280 = 0x2000000001c0;
*(uint32_t*)0x2000000001c0 = 0x54;
*(uint16_t*)0x2000000001c4 = 0x10;
*(uint16_t*)0x2000000001c6 = 1;
*(uint32_t*)0x2000000001c8 = 0;
*(uint32_t*)0x2000000001cc = 0;
*(uint8_t*)0x2000000001d0 = 6;
*(uint8_t*)0x2000000001d1 = 0;
*(uint16_t*)0x2000000001d2 = 0x8100;
*(uint32_t*)0x2000000001d4 = 0;
*(uint16_t*)0x2000000001d8 = 0;
*(uint16_t*)0x2000000001da = 0;
*(uint16_t*)0x2000000001dc = 0xfff1;
*(uint16_t*)0x2000000001de = 0;
*(uint16_t*)0x2000000001e0 = 0xe;
*(uint16_t*)0x2000000001e2 = 0x10;
*(uint16_t*)0x2000000001e4 = 8;
*(uint16_t*)0x2000000001e6 = 0xe;
*(uint32_t*)0x2000000001e8 = 7;
*(uint16_t*)0x2000000001ec = 0x28;
STORE_BY_BITMASK(uint16_t, , 0x2000000001ee, 8, 0, 14);
STORE_BY_BITMASK(uint16_t, , 0x2000000001ef, 0, 6, 1);
STORE_BY_BITMASK(uint16_t, , 0x2000000001ef, 1, 7, 1);
*(uint16_t*)0x2000000001f0 = 0x1c;
*(uint16_t*)0x2000000001f2 = 0x11;
*(uint8_t*)0x2000000001f4 = 0;
*(uint8_t*)0x2000000001f5 = 0;
*(uint16_t*)0x2000000001f6 = 0;
*(uint32_t*)0x2000000001f8 = 0;
*(uint32_t*)0x2000000001fc = 0;
*(uint32_t*)0x200000000200 = 0x5e06209c;
*(uint32_t*)0x200000000204 = 0;
*(uint32_t*)0x200000000208 = 2;
*(uint16_t*)0x20000000020c = 8;
*(uint16_t*)0x20000000020e = 0x1b;
*(uint16_t*)0x200000000210 = 0;
*(uint16_t*)0x200000000212 = 0;
*(uint64_t*)0x200000000288 = 0x54;
*(uint64_t*)0x200000000198 = 1;
*(uint64_t*)0x2000000001a0 = 0;
*(uint64_t*)0x2000000001a8 = 0;
*(uint32_t*)0x2000000001b0 = 0;
		syscall(__NR_sendmsg, /*fd=*/r[4], /*msg=*/0x200000000180ul, /*f=*/0ul);
		break;
	}

}
int main(void)
{
		syscall(__NR_mmap, /*addr=*/0x1ffffffff000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/(intptr_t)-1, /*offset=*/0ul);
	syscall(__NR_mmap, /*addr=*/0x200000000000ul, /*len=*/0x1000000ul, /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/7ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/(intptr_t)-1, /*offset=*/0ul);
	syscall(__NR_mmap, /*addr=*/0x200001000000ul, /*len=*/0x1000ul, /*prot=*/0ul, /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul, /*fd=*/(intptr_t)-1, /*offset=*/0ul);
	const char* reason;
	(void)reason;
			do_sandbox_none();
	return 0;
}



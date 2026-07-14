Return-Path: <netdev+bounces-307428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZL2qEZEZVmrDzAAAu9opvQ
	(envelope-from <netdev+bounces-307428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:12:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECDF753CAF
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:12:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=WMqVJdRd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307428-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307428-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C12AB315657C
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 11:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A55C37F74A;
	Tue, 14 Jul 2026 11:08:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4B637E2F9
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 11:08:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027288; cv=none; b=Q+k703h+k1ggKXOcImsgHz/zed0R+wrquSqoDqVsum10YguLn4+Eyt9vYjliUClfnY/KbEiOy1Uaaa/w4DCCBit/xh2Is5pIii77FIudOC7uOUG4QxYe4CvJDzzdZELE8939S1qRIX+jh8+IqvZkLHV0f4aHYGlemdlvrZjKk/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027288; c=relaxed/simple;
	bh=ih29dVZmE/+d5QlQKOcIrFBA/q5MG1CcWhARzyB/d/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2AWJx6PQRRy7vrNx4KU1Ky6sZwb4AwvEogv/To5GRX2B0BYXC1Tq5+17ydYUQwAgBgouOzqFsUaIb+ba4q2QbbgcAzTiRwZAxmCwtnFp7V4lB+IKkrmw7m18Ie3MMP6smWb6YrwbIJ+8q+mgLvCpl9jwFxG9SeFOxyqxk2oBx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMqVJdRd; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784027284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15Oe3siE+6tkK5T1YlJbzX+vkvSSl3bQC8DQg9Cg5cw=;
	b=WMqVJdRdGO8ys2TuriaNL5ClDqxcb/P8OS1MiR/zUD5hDB95gANcdGPqrCzNHpL2MejL5X
	WVy6AS6wsbpF6LA9Ndp8ZlkRLM6iMuyAKK0GwUYhImpABPOWjOb6YMWwP1nQ/nG1cZaDTB
	A1yedF/WTLsBqGq3nXxldyG69l8BdOc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-kitM1sFGPGCT8seEeTwcBA-1; Tue,
 14 Jul 2026 07:07:59 -0400
X-MC-Unique: kitM1sFGPGCT8seEeTwcBA-1
X-Mimecast-MFC-AGG-ID: kitM1sFGPGCT8seEeTwcBA_1784027277
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 65D941956060;
	Tue, 14 Jul 2026 11:07:56 +0000 (UTC)
Received: from thinkpad (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6A1830001BE;
	Tue, 14 Jul 2026 11:07:51 +0000 (UTC)
Date: Tue, 14 Jul 2026 13:07:48 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
	=?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Hangbin Liu <liuhangbin@gmail.com>, Jakub Acs <acsjakub@amazon.de>,
	Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: hsr: clean up the slave VLAN filters when
 deleting a port
Message-ID: <alYYhIPZBbMo5qMe@thinkpad>
References: <20260714080640.149654-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714080640.149654-1-jiayuan.chen@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307428-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:lukma@nabladev.com,m:fmancera@suse.de,m:liuhangbin@gmail.com,m:acsjakub@amazon.de,m:xiaoliang.yang_1@nxp.com,m:danishanwar@ti.com,m:m-karicheri2@ti.com,m:jiri@resnulli.us,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,nabladev.com,suse.de,gmail.com,amazon.de,nxp.com,ti.com,resnulli.us];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[thinkpad:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8ECDF753CAF

On Tue, Jul 14, 2026 at 04:06:36PM +0800, Jiayuan Chen wrote:
> Our internal syzkaller reported this warning:
>
>   netdevsim netdevsim10 eth0: entered promiscuous mode
>   netdevsim netdevsim10 eth1: entered promiscuous mode
>   netdevsim netdevsim10 eth1 (unregistering): left promiscuous mode
>   ------------[ cut here ]------------
>   WARNING: drivers/net/netdevsim/netdev.c:1208 at nsim_destroy+0x276/0x6e0, CPU#3: 1/46
>   Modules linked in:
>   CPU: 3 UID: 0 PID: 46 Comm: kworker/u16:1 Not tainted 7.2.0-rc2+ #286 PREEMPT
>   Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>   Workqueue: netns cleanup_net
>   RIP: 0010:nsim_destroy (drivers/net/netdevsim/netdev.c:1031 drivers/net/netdevsim/netdev.c:1201)
>   RSP: 0018:ffffc90000337898 EFLAGS: 00010293
>   RAX: 0000000000000001 RBX: ffff8881036c8b00 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>   RBP: ffffc900003378f0 R08: 0000000000000000 R09: 0000000000000000
>   R10: ffffffffad4186a8 R11: ffffffffad41c3db R12: ffff8881036c9268
>   R13: dffffc0000000000 R14: ffffed10206d9164 R15: 0000000000000001
>   FS:  0000000000000000(0000) GS:ffff888160866000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 000055bcf1a2e0c4 CR3: 0000000105376003 CR4: 0000000000770ef0
>   PKRU: 55555554
>   Call Trace:
>   <TASK>
>   __nsim_dev_port_del (drivers/net/netdevsim/dev.c:1547)
>   nsim_dev_reload_destroy (drivers/net/netdevsim/dev.c:1561 drivers/net/netdevsim/dev.c:1785)
>   nsim_dev_reload_down (drivers/net/netdevsim/dev.c:1038)
>   devlink_reload (net/devlink/dev.c:462)
>   devlink_pernet_pre_exit (net/devlink/core.c:578)
>   ops_undo_list (net/core/net_namespace.c:161 net/core/net_namespace.c:235)
>   cleanup_net (net/core/net_namespace.c:706)
>   process_one_work (kernel/workqueue.c:3322)
>   worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
>   kthread (kernel/kthread.c:436)
>   ret_from_fork (arch/x86/kernel/process.c:158)
>   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>   </TASK>
>   ---[ end trace 0000000000000000 ]---
>   netdevsim netdevsim10 eth0 (unregistering): left promiscuous mode
>
> vlan_vids_add_by_dev() is what passes the VID filter info down to the real
> device. A virtual device does no filtering itself, so it has to push the
> VIDs down to its slaves. HSR already does this correctly on the add side:
> hsr_ndo_vlan_rx_add_vid() calls vlan_vid_add() on each slave.
>
> We just never clean the slaves up on delete. hsr_del_port() drops the port
> and leaves the VIDs sitting on the slave, so the filter entries leak.
> netdevsim keeps a bitmap of the VIDs it was told to filter and checks that
> it is empty when the netdev goes away, which is what trips the warning
> above.
>
> So do the cleanup in hsr_del_port(). We follow hsr_ndo_vlan_rx_add_vid()
> here: it only pushes the VIDs to HSR_PT_SLAVE_A and HSR_PT_SLAVE_B, so the
> del side only touches those two as well.
>
> Reproducer:
> ip netns add ns0
> ip netns exec ns0 sh -c 'echo "10 2" > /sys/bus/netdevsim/new_device'
> ip netns exec ns0 ip link add hsr0 type hsr slave1 eth0 slave2 eth1
> ip netns exec ns0 ip link add link hsr0 name hsr0.1 type vlan id 1
> ip netns del ns0

Thank you for your patch! The explanation and the patch look very
similar to a fix that Eric posted a week ago [1]. Can you check if
Eric's patch also fixes you reproducer? And if it does, please add your
Tested-by and/or Reviewed-by to the thread?

Thanks,
   Felix


[1]: https://lore.kernel.org/netdev/20260707082327.3238690-1-edumazet@google.com/



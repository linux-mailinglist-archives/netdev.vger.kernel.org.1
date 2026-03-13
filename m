Return-Path: <netdev+bounces-267566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C5dISRntGnxnQAAu9opvQ
	(envelope-from <netdev+bounces-267566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:36:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC50E289552
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C384F31D25E7
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 19:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A629F3E1CE8;
	Fri, 13 Mar 2026 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl7+eQ2R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281A23E1CE1;
	Fri, 13 Mar 2026 19:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430539; cv=none; b=WoHC2GgnM47qdf5f8VOgeeT6BuzWgR8tjAWN8KF49Mq6MRQn5fBjmfwf1EvyabqOrvrjR9xNOY1QeXFCY+xNBOytcAW237/xfR6CDEDHXoRiIMbJB8YbTPcJPHhlQu/JK6DfUDbqEaWPE+4jzYQzlFmaH2k0EGscHstyX3eKy5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430539; c=relaxed/simple;
	bh=eCQhync3EAXJGeoq988vGwhmsvfzvBJwGHsI4P/nMcs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eax44qxp1R51E2aYjzWGh5m32MTh1Z3NhWs1t8xKuaSfB6t5Hf35fNMjq1vIyi5s+XrVVLI9gNLxyVSqlFwlbzmuTRglUanrKaheT2LLquPjS/585VycLeI3uRNjVDw2oF7wCSCTJ/OTJs47McjWGLewaL9xyIc44MWIBp4q0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl7+eQ2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C880BC19421;
	Fri, 13 Mar 2026 19:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773430538;
	bh=eCQhync3EAXJGeoq988vGwhmsvfzvBJwGHsI4P/nMcs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bl7+eQ2RN6mQUBE1PzAvHumTx26YycZdF/Ogw065NNy5wti9Bn4EEukH//tvdeaOA
	 IrzVEYJd8ije0Q2D6haaI/rtjpgHg4Q8d6Qg+UX5VvgtfOHQNRn7PcUiEMNeySXiHD
	 WSkSvD8Er5A37UXXvElmGRqdVCQGwjnfQofYs5NPf5ndH5SEkkwkfRszHWZ/9NKirh
	 KNwdWA7ZUcYRAVGGJ9wKsxyP4zIb1djIzX8WZPQE/hsp1RNaKxoUDk9Nv60vrP+epo
	 v9xk5uPuSWHKAJA35pEXLktIxl9MroI8jva6oEWqExr6Vb2E9mppanpe4Vuu072EzB
	 6+kuaqa0EpUzQ==
Date: Fri, 13 Mar 2026 12:35:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>, Eelco
 Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: openvswitch: decouple flow_table from
 ovs_mutex
Message-ID: <20260313123535.4b2741b8@kernel.org>
In-Reply-To: <20260313173114.1220551-1-amorenoz@redhat.com>
References: <20260313173114.1220551-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-267566-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC50E289552
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 18:31:12 +0100 Adrian Moreno wrote:
> Currently the entire ovs module is write-protected using the global
> ovs_mutex. While this simple approach works fine for control-plane
> operations (such as vport configurations), requiring the global mutex
> for flow modifications can be problematic.

YNL selftest for ovs seems to trigger this:

[   88.995118][   T50] =============================
[   88.995287][   T50] WARNING: suspicious RCU usage
[   88.995448][   T50] 7.0.0-rc3-virtme #1 Not tainted
[   88.995630][   T50] -----------------------------
[   88.995788][   T50] net/openvswitch/datapath.c:2666 RCU-list traversed in non-reader section!!
[   88.996122][   T50] 
[   88.996122][   T50] other info that might help us debug this:
[   88.996122][   T50] 
[   88.996388][   T50] 
[   88.996388][   T50] rcu_scheduler_active = 2, debug_locks = 1
[   88.996640][   T50] 3 locks held by kworker/2:1/50:
[   88.996800][   T50]  #0: ff11000001139b48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0xcb4/0x1390
[   88.997092][   T50]  #1: ffa000000036fd10 ((work_completion)(&(&ovs_net->masks_rebalance)->work)){+.+.}-{0:0}, at: process_one_work+0xd16/0x1390
[   88.997420][   T50]  #2: ffffffffc08038e8 (ovs_mutex){+.+.}-{4:4}, at: ovs_dp_masks_rebalance+0x29/0x270 [openvswitch]
[   88.997707][   T50] 
[   88.997707][   T50] stack backtrace:
[   88.997898][   T50] CPU: 2 UID: 0 PID: 50 Comm: kworker/2:1 Not tainted 7.0.0-rc3-virtme #1 PREEMPT(full) 
[   88.997903][   T50] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   88.997904][   T50] Workqueue: events ovs_dp_masks_rebalance [openvswitch]
[   88.997911][   T50] Call Trace:
[   88.997914][   T50]  <TASK>
[   88.997916][   T50]  dump_stack_lvl+0x6f/0xa0
[   88.997921][   T50]  lockdep_rcu_suspicious.cold+0x4f/0xad
[   88.997928][   T50]  ovs_dp_masks_rebalance+0x226/0x270 [openvswitch]
[   88.997933][   T50]  process_one_work+0xd57/0x1390
[   88.997940][   T50]  ? pwq_dec_nr_in_flight+0x700/0x700
[   88.997942][   T50]  ? lock_acquire.part.0+0xbc/0x260
[   88.997950][   T50]  worker_thread+0x4d6/0xd40
[   88.997954][   T50]  ? rescuer_thread+0x1330/0x1330
[   88.997956][   T50]  ? __kthread_parkme+0xb3/0x200
[   88.997960][   T50]  ? rescuer_thread+0x1330/0x1330
[   88.997962][   T50]  kthread+0x30f/0x3f0
[   88.997964][   T50]  ? trace_irq_enable.constprop.0+0x13c/0x190
[   88.997967][   T50]  ? kthread_affine_node+0x150/0x150
[   88.997970][   T50]  ret_from_fork+0x472/0x6b0
[   88.997974][   T50]  ? arch_exit_to_user_mode_prepare.isra.0+0x140/0x140
[   88.997977][   T50]  ? __switch_to+0x538/0xcf0
[   88.997980][   T50]  ? kthread_affine_node+0x150/0x150
[   88.997983][   T50]  ret_from_fork_asm+0x11/0x20
[   88.997991][   T50]  </TASK>

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/tools/net/ynl/tests/ovs.c


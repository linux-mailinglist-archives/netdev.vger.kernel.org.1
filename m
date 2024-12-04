Return-Path: <netdev+bounces-148941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 051559E3982
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E34B248A8
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EB81B392F;
	Wed,  4 Dec 2024 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsfxExCE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3FD1AE863
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312608; cv=none; b=lwFO3uGK6utz2oIhmOhvL8mFKH5KKXrthp03flHL0V39ZH4xObJIe2oQDtm7bOPZriX9DySQLnG08HXdeRY7czVCHD2Syp/IBjY7RTpUGkNccAZy12k3sJrC49HmXLcOsnNzar62KCFMalKR/5nLFW0D752JcKsIdVXxx1WT/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312608; c=relaxed/simple;
	bh=4v0v9qQtQLCUVhLiNStaE4ijGcjZsY4IBnD1mAfV4Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FQxu0fush9XZT9vTFCjybNQYTdnA9l5uI75MXnBEXIkGFFWocM/pMnNtXxMeEpQ5eG5qovlxbcicCS/vZwr2xhHxt0Dw9Pwh/nRZV+94eVCBVCaF9b8EQmnknveivvz344ZO0dWpHj0pAkO3J29196xNLErmI1k1iJfqNSX9uC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IsfxExCE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733312605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nWlMtLT9W/JE0sDV4ETleqSg3lVaVJyih/3HfM+FmPw=;
	b=IsfxExCES8pJZNShP79LD9fOk2H/PjV9AYX+nCPjbRdXUCEcB/c7bdKYXKki5qbN0d5GKP
	JySR4tlLB/x4P9x7o37QCCkLkRdFDnvKaAN18pfEDsTiijI3FLY3qx8+4HD8Oc9+h5IRKQ
	t9IQk4JgKtwgQyaTnoO7EYonwJTVZlA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-i9Q0F52zP_eqrXOK9_WW0w-1; Wed,
 04 Dec 2024 06:43:22 -0500
X-MC-Unique: i9Q0F52zP_eqrXOK9_WW0w-1
X-Mimecast-MFC-AGG-ID: i9Q0F52zP_eqrXOK9_WW0w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD6861955F39;
	Wed,  4 Dec 2024 11:43:19 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 318A53000197;
	Wed,  4 Dec 2024 11:43:12 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH iwl-net 0/4] igb: fix igb_msix_other() handling for PREEMPT_RT
Date: Wed,  4 Dec 2024 08:42:23 -0300
Message-ID: <20241204114229.21452-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is the second attempt at fixing the behavior of igb_msix_other()
for PREEMPT_RT. The previous attempt [1] was reverted [2] following
concerns raised by Sebastian [3].

The initial approach proposed converting vfs_lock to a raw_spinlock,
a minor change intended to make it safe. However, it became evident
that igb_rcv_msg_from_vf() invokes kcalloc with GFP_ATOMIC,
which is unsafe in interrupt context on PREEMPT_RT systems.

To address this, the solution involves splitting igb_msg_task()
into two parts:

    * One part invoked from the IRQ context.
    * Another part called from the threaded interrupt handler.

To accommodate this, vfs_lock has been restructured into a double
lock: a spinlock_t and a raw_spinlock_t. In the revised design:

    * igb_disable_sriov() locks both spinlocks.
    * Each part of igb_msg_task() locks the appropriate spinlock for
    its execution context.

It is worth noting that the double lock mechanism is only active under
PREEMPT_RT. For non-PREEMPT_RT builds, the additional raw_spinlock_t
field is ommited.

If the extra raw_spinlock_t field can be tolerated under
!PREEMPT_RT (even though it remains unused), we can eliminate the
need for #ifdefs and simplify the code structure.

I will be on vacation from December 7th to Christmas and will address
review comments upon my return.

If possible, I kindly request the Intel team to perform smoke tests
on both stock and realtime kernels to catch any potential issues with
this patch series.

Cheers,
Wander

[1] https://lore.kernel.org/all/20240920185918.616302-2-wander@redhat.com/
[2] https://lore.kernel.org/all/20241104124050.22290-1-wander@redhat.com/
[3] https://lore.kernel.org/all/20241104110708.gFyxRFlC@linutronix.de/


Wander Lairson Costa (4):
  igb: narrow scope of vfs_lock in SR-IOV cleanup
  igb: introduce raw vfs_lock to igb_adapter
  igb: split igb_msg_task()
  igb: fix igb_msix_other() handling for PREEMPT_RT

 drivers/net/ethernet/intel/igb/igb.h      |   4 +
 drivers/net/ethernet/intel/igb/igb_main.c | 160 +++++++++++++++++++---
 2 files changed, 148 insertions(+), 16 deletions(-)

-- 
2.47.0



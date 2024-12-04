Return-Path: <netdev+bounces-148942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A79449E3915
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8459A16547A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F9D1B3935;
	Wed,  4 Dec 2024 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXG5Oz80"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C3C1B392F
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312614; cv=none; b=F9WraHboM+Q4quySoZe25eEaFsY8tT0blI68zVh7LsBxZ5B8+2ULl2N0ETsb9RZzvWq82AUmGTy/6Sm9SvmE3GNB2jSCRqTOvhWturvHIn3rvtFNKvT4/mgON6mSwHHfE8przaj0RlLXoIAjLtN2YhrNAa5sbkb1GXRiLaWCXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312614; c=relaxed/simple;
	bh=l2z9VD5HlFDHOtvxJuuLIRNAdEnNKlZq9mCp1WP8k+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KB5AR+cpGQqr6B318stSqkonncNjHk6r5hPDUkTGGjbB2NfVXsf4AMo7kr6oAWtR83gHojDhPSJvRl0B7xtd3Mg4LtRqBgmz4ehLUTPQdiIyJmE3P+1e2VClPEyLGLcEMhxo97zGpNNmKyp9TBHxBLMNuZiPknybCHpKw66zWvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXG5Oz80; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733312612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YjLiIgA1heSf6FeldDRqyic0hKMQLJvylr1VcRItvD4=;
	b=CXG5Oz80r9ohMkYVtSjngwwuEyVEJ5+svV5vkCi+ulgNzp/NyxibFt0duWOiWUjyDBPFRx
	eKxPKeA7S27P1VYnhXNAV6pmjixZPBSy9JGs1oc7oB5jCCH4DZHP4nBidRogVZ35FZoLYr
	clNEG/JBFPlFY97E/gko/4tU6Ivu7r8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-CrQUMUH4NIapA6bZIKoFvA-1; Wed,
 04 Dec 2024 06:43:29 -0500
X-MC-Unique: CrQUMUH4NIapA6bZIKoFvA-1
X-Mimecast-MFC-AGG-ID: CrQUMUH4NIapA6bZIKoFvA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D233B1955F68;
	Wed,  4 Dec 2024 11:43:26 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B95643000197;
	Wed,  4 Dec 2024 11:43:20 +0000 (UTC)
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
	Auke Kok <auke-jan.h.kok@intel.com>,
	Jeff Garzik <jgarzik@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH iwl-net 1/4] igb: narrow scope of vfs_lock in SR-IOV cleanup
Date: Wed,  4 Dec 2024 08:42:24 -0300
Message-ID: <20241204114229.21452-2-wander@redhat.com>
In-Reply-To: <20241204114229.21452-1-wander@redhat.com>
References: <20241204114229.21452-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The adapter->vfs_lock currently protects critical sections shared between
igb_disable_sriov() and igb_msg_task(). Since igb_msg_task() — which is
invoked solely by the igb_msix_other() ISR—only proceeds when
adapter->vfs_allocated_count > 0, we can reduce the lock scope further.

By moving the assignment adapter->vfs_allocated_count = 0 to the start of the
cleanup code in igb_disable_sriov(), we can restrict the spinlock protection
solely to this assignment. This change removes kfree() calls from within the
locked section, simplifying lock management.

Once kfree() is outside the vfs_lock scope, it becomes possible to safely
convert vfs_lock to a raw_spin_lock.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 08578980b6518..4ca25660e876e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3708,12 +3708,12 @@ static int igb_disable_sriov(struct pci_dev *pdev, bool reinit)
 			msleep(500);
 		}
 		spin_lock_irqsave(&adapter->vfs_lock, flags);
+		adapter->vfs_allocated_count = 0;
+		spin_unlock_irqrestore(&adapter->vfs_lock, flags);
 		kfree(adapter->vf_mac_list);
 		adapter->vf_mac_list = NULL;
 		kfree(adapter->vf_data);
 		adapter->vf_data = NULL;
-		adapter->vfs_allocated_count = 0;
-		spin_unlock_irqrestore(&adapter->vfs_lock, flags);
 		wr32(E1000_IOVCTL, E1000_IOVCTL_REUSE_VFQ);
 		wrfl();
 		msleep(100);
-- 
2.47.0



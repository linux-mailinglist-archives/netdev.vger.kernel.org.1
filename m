Return-Path: <netdev+bounces-280288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id l7Z0NdYy6GkAGwIAu9opvQ
	(envelope-from <netdev+bounces-280288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:30:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 77166441751
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBE51301EAF4
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A3335975;
	Wed, 22 Apr 2026 02:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="jOnNv4vR"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7BE375F7C;
	Wed, 22 Apr 2026 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776825038; cv=none; b=j2hRqXpVTPHAwTeHz9BvsimI+3hPRh/FywuRpKnpi6ngkerAefeUXYQsnHaNzuzuiOELLgcTnygISHR3ksK5LJSl7FaNWkLcLfy+7tQkqJ4GXAJCtPbcFkYe/ujSm1oKENl4Vd0EEJzO3hL+GWm0UjVTIh6S3NGSLU1wFCQoq/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776825038; c=relaxed/simple;
	bh=qp19i8gKOQAW2OoVrGwPyPDIdtOoJJmFIYmFogXNP2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uUYC34fLGNb8pKQGPue/sLnuhBD1Uu8sGpa2FnBpG0+xZ1gcOcqQAkXIwDteFJlabyPR11m+kNeMbCxAT9CJ+a0b990+g+uEXaPMxc79v/ycVrrbvAF87piPx6c8WjPDcdcl0VM7CY0624ZTz1QJhHvuaEvADzkFcXjvj7LJSwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=jOnNv4vR; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (232.154.13.160.dy.iij4u.or.jp [160.13.154.232])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63M2USQV090865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 22 Apr 2026 11:30:28 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=swiEIN7WrlDhQ8FdTFcXjLaM5ebLD8EN3bBCVp4yXgs=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1776825029; v=1;
        b=jOnNv4vRad30NNuL1TItyyMkLMKSN3yaIbKcgLTLMmvtg+FmJxUoGR9fktP+IEw/
         CBIrNyvQ7whqPJJtyi7l4nI3/urHNr3MT4mq47EsV2BexXOPyBAxjccTpAy2uzrR
         W/AeeNddVdRpcYtAiOhNbtFltiu2BzLbfPZM87ak3UJBqktpRF8umkOiS0hoiuxB
         K7YYlVhogp8+4PSlLv+P7bJobn9Br6XMTv5YB10jhn7Z2EGkoJpp2HP7oyvOGYzF
         qloWGP8PnnxpxAZDA7EnSAX0cxTbEE0aaXqE4HePKyNOs8hyEtgWUWKcs+mjW20u
         cDOj0JkS6hkFemKKgqxs2A==
From: Kohei Enju <kohei@enjuk.jp>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        netdev@vger.kernel.org, Kohei Enju <kohei@enjuk.jp>,
        syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
Subject: [PATCH net v1] vhost_net: fix sleeping with preempt-disabled in vhost_net_busy_poll()
Date: Wed, 22 Apr 2026 02:30:24 +0000
Message-ID: <20260422023026.81960-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280288-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev,6985cb8e543ea90ba8ee];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,enjuk.jp:email,enjuk.jp:dkim,enjuk.jp:mid]
X-Rspamd-Queue-Id: 77166441751
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot reported "sleeping function called from invalid context" in
vhost_net_busy_poll().

Commit 030881372460 ("vhost_net: basic polling support") introduced a
busy-poll loop and preempt_{disable,enable}() around it, where each
iteration calls a sleepable function inside the loop.

The purpose of disabling preemption was to keep local_clock()-based
timeout accounting on a single CPU, rather than as a requirement of
busy-poll itself:

https://lore.kernel.org/netdev/1448435489-5949-4-git-send-email-jasowang@redhat.com/T/#u

  Changes from RFC V1:
  ...
  - Disable preemption during busy looping to make sure local_clock()
    was correctly used.

From this perspective, migrate_disable() is sufficient here, so replace
preempt_disable() with migrate_disable(), avoiding sleepable accesses
from a preempt-disabled context.

Fixes: 030881372460 ("vhost_net: basic polling support")
Tested-by: syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
Reported-by: syzbot+6985cb8e543ea90ba8ee@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69e6a414.050a0220.24bfd3.002d.GAE@google.com/T/
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/vhost/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 80965181920c..c6536cad9c4f 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -560,7 +560,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
 	busyloop_timeout = poll_rx ? rvq->busyloop_timeout:
 				     tvq->busyloop_timeout;
 
-	preempt_disable();
+	migrate_disable();
 	endtime = busy_clock() + busyloop_timeout;
 
 	while (vhost_can_busy_poll(endtime)) {
@@ -577,7 +577,7 @@ static void vhost_net_busy_poll(struct vhost_net *net,
 		cpu_relax();
 	}
 
-	preempt_enable();
+	migrate_enable();
 
 	if (poll_rx || sock_has_rx_data(sock))
 		vhost_net_busy_poll_try_queue(net, vq);
-- 
2.51.0



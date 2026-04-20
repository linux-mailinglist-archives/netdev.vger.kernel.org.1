Return-Path: <netdev+bounces-279735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGJHFmMh5mkMsAEAu9opvQ
	(envelope-from <netdev+bounces-279735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 14:51:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A912542AF7F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 14:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5CF530D00A8
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94E93A2541;
	Mon, 20 Apr 2026 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I2ybQzdu"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BF33A16B3;
	Mon, 20 Apr 2026 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689268; cv=none; b=A8WB+15A8R7DYOwhNhQSzAwtMpIkxqPVHFa9/aKKBVrdNjtoYi1EySiJdiauvfMlsUfwF3v8ycFUtLkPt2dqiIaLdtOtO9POaff+uLXoZp+sS6Xcwm/UD34Bj3JKexlYhs0cvELPM2/92WcAoTojXZ7N6pcKhqNtWKajvwqaMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689268; c=relaxed/simple;
	bh=Ni6vx9SF49yxYhP3LbrjHOLdZht5SxkCYU2TLmQY4dY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEB93FGZlmc6ki8FpeyLRWnHAnHmbjNTP96wkcN27/gfPWK4ZyoALzOWqHJYwPen572ZiOINoVOQMRb+KWxT89x+NMNZ/zJznIpNMIbuM7vFBYZUs2xWd7mCebvW0D0HqmtO8pf/5QzA0WWynXGz3XyxMmQO5OMNsJ5MspHlnAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=I2ybQzdu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id B3E8720B6F21; Mon, 20 Apr 2026 05:47:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3E8720B6F21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776689267;
	bh=BBxLSN6bc6KHGhDAGqcnT/zZk1brxAn7fdLjOWLSc1I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=I2ybQzdurCAAABChs9YkdF1xaaWxTFXL1ZHhf60lEPChHzRBk0Zdm3hKB8zA5B8ZK
	 5sN+G40Fw31HlcTeVi8Em1r3CqXT+Gytu/DSI7/g8Iykmh9/dW2QAz3oRyuk8IH4GA
	 7yLekABiJpIbs2Z/awB2/MlM/fZANy2W8tUeOO/E=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ernis@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	kees@kernel.org,
	kotaranov@microsoft.com,
	leon@kernel.org,
	shacharr@microsoft.com,
	stephen@networkplumber.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 5/5] net: mana: Fix EQ leak in mana_remove on NULL port
Date: Mon, 20 Apr 2026 05:47:39 -0700
Message-ID: <20260420124741.1056179-6-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260420124741.1056179-1-ernis@linux.microsoft.com>
References: <20260420124741.1056179-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	TAGGED_FROM(0.00)[bounces-279735-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,13.77.154.182:received];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: A912542AF7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mana_remove(), when a NULL port is encountered in the port iteration
loop, 'goto out' skips the mana_destroy_eq(ac) call, leaking the event
queues allocated earlier by mana_create_eq().

This can happen when mana_probe_port() fails for port 0, leaving
ac->ports[0] as NULL. On driver unload or error cleanup, mana_remove()
hits the NULL entry and jumps past mana_destroy_eq().

Change 'goto out' to 'break' so the for-loop exits normally and
mana_destroy_eq() is always reached. Remove the now-unreferenced out:
label.

Fixes: 1e2d0824a9c3 ("net: mana: Add support for EQ sharing")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v4:
* No change
Changes in v3;
* Update Fixes tag to appropriate commit id.
Changes in v2:
* Apply the patch in net instead of net-next.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 39b18577fb51..98e2fcc797ca 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3752,7 +3752,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 		if (!ndev) {
 			if (i == 0)
 				dev_err(dev, "No net device to remove\n");
-			goto out;
+			break;
 		}
 
 		apc = netdev_priv(ndev);
@@ -3783,7 +3783,7 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	}
 
 	mana_destroy_eq(ac);
-out:
+
 	if (ac->per_port_queue_reset_wq) {
 		destroy_workqueue(ac->per_port_queue_reset_wq);
 		ac->per_port_queue_reset_wq = NULL;
-- 
2.34.1



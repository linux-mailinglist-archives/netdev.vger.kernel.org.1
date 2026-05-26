Return-Path: <netdev+bounces-291577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFXQIwJUFWqmUQcAu9opvQ
	(envelope-from <netdev+bounces-291577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:04:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1B15D232A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 10:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B1B7300CFD6
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0702B3CCFCC;
	Tue, 26 May 2026 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IhwxUNh3"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFED3B5837;
	Tue, 26 May 2026 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782652; cv=none; b=PC+11pDW8vNkla+rnsbHIgxCui4Wb9IHmg1b5ObyAVRrCI0mQTWzf1TGRrvG4xErWRNPq54KUbxHlhZiRhZbKGNfcTeg2Ia0zaBew23ZxnIXX7hD/rjnm5y4GlMz28ezY6elFPTRAmA9cH7g2ohYkDuRL4VNCXnqxR+RYX5Tb4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782652; c=relaxed/simple;
	bh=45KEKPvIipfpxvasf0IAIn3DmtzkftZ2hberpVknMjE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PIHtsW4ISBSMwLQZXTFvCZawiEE3Srgfwb+1ax9DJQ/oGHXY7PxF1W5zoAOm9pUbXSvs0Kn2gsN/gzVM+F5m1XaBJ6rP5liQpfytneEd2Pr34ue0R7YKLzy1Di3wqBhqzTuwmg8bKt8QO39hzxNkeTkifvl3lkEqmNjTZIMxtEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IhwxUNh3; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9B
	rc5GiPYOxWptKHRclEmQdD+ryXnNMxYPoyH4Q3BgA=; b=IhwxUNh3CRcZ2tdxwR
	4/orR6AaXzDrJNtlXSiATLbMq+LyMXS4HVbHU/kCsG9P/tBr8jLiUlA+dYb8J1c0
	RAe0jl+GL0RWvIo7qy36yPw2BZvG3FCsIfpeybGj9fexDnWU4784nT71ebErqKig
	bqxP55v4gXY/YhYJILr5A42TY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnL5PbUxVqovnmEg--.27103S2;
	Tue, 26 May 2026 16:03:43 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yufeng Wang <wangyufeng@kylinos.cn>
Subject: [PATCH] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
Date: Tue, 26 May 2026 16:03:36 +0800
Message-Id: <20260526080336.61296-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnL5PbUxVqovnmEg--.27103S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKry8tF43WrWkXrW7Wr48Zwb_yoWkXFX_u3
	9rXryxuryxGrnI9wsxXa4SyrWayFW8urs7WFn29ryxA343u3Z7Cana9FnxJa1UW3y8CF9r
	A3s8Jr92g3Z2qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8nXo7UUUUU==
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzh-rYWoVU9+0-QAA3h
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-291577-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[r4o5m6e8o@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[163.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Queue-Id: CD1B15D232A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yufeng Wang <wangyufeng@kylinos.cn>

The clear_user() call in VHOST_GET_FEATURES_ARRAY incorrectly starts
at argp, which is the beginning of the features array, overwriting the
data just written by copy_to_user(). It should start after the copied
elements at argp + copied * sizeof(u64) to only zero the trailing
unused space.

Fixes: 333c515d1896 ("vhost-net: allow configuring extended features")
Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
---
 drivers/vhost/net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index db341c922673..70c578acf840 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1777,7 +1777,8 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 
 		/* Zero the trailing space provided by user-space, if any */
-		if (clear_user(argp, size_mul(count - copied, sizeof(u64))))
+		if (clear_user(argp + copied * sizeof(u64),
+			       size_mul(count - copied, sizeof(u64))))
 			return -EFAULT;
 		return 0;
 	case VHOST_SET_FEATURES_ARRAY:
-- 
2.34.1



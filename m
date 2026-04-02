Return-Path: <netdev+bounces-274769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNWWN0X9zmkxsQYAu9opvQ
	(envelope-from <netdev+bounces-274769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:35:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D79ED38F3FA
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9128F306E02E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D1B37F75A;
	Thu,  2 Apr 2026 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b="gmV6miW3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040D839E6C9;
	Thu,  2 Apr 2026 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172410; cv=none; b=q0IMZaf4XHHDk/n+7RwDeCVyixizPJgqQTflZWjNk3n8fj4ZL4BTeVLUsbPcwmXX5ElOecdK/KhHZ2RLHHSGLbMerYt5BmDD9b1ryiinjkS6hEY30Vmz633QSdDiC//4qkXcOIMmnsVSJxDK9PjVts4eMduBZS5d2AzkYvyllGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172410; c=relaxed/simple;
	bh=wzqSeaql+9f3bTlG6r1Ms527UU1vR+/m3RmzbC6VoJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZS/UuX4ticoYkhWcT3APvhpFPRzcQ8wU8D0NkdpEbYredJB+t0g6E0yK/pzs6STNFSwIlDBxi4uXYGl1vjY/EleB/uShTF8lsOQC53ja1v9Gmtu5lJa1RZH0SnRJdo7X8mHjZk0a/2zpkcp/FnBjOt894U5GMNOU5OzNssn9AQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn; spf=pass smtp.mailfrom=ruc.edu.cn; dkim=pass (1024-bit key) header.d=ruc.edu.cn header.i=@ruc.edu.cn header.b=gmV6miW3; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ruc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ruc.edu.cn
Received: from lwz.tail698a0e.ts.net (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [36.112.3.244])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3956a5594;
	Fri, 3 Apr 2026 00:37:03 +0800 (GMT+08:00)
From: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
To: rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC PATCH 2/6] rust: helpers: add net_device and sk_buff helper wrappers
Date: Thu,  2 Apr 2026 12:36:36 -0400
Message-Id: <20260402163640.1079056-3-wenzhaoliao@ruc.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402163640.1079056-1-wenzhaoliao@ruc.edu.cn>
References: <20260402163640.1079056-1-wenzhaoliao@ruc.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d4f0e313303a2kunm6754def456bf2f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUgZVkwZSk8ZS0lPHklMSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlITVVKSklVSFVJT09ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVUpCS0
	tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gmV6miW3WhKwZlXqFRnWXjHFyYY3hBwDUtBnsuq9gvIEwZHSlC+V2aprYItxyu/nTe2GwrgDgmmWi/+7Kyq6Zr1XrW8KTHGbMYDRgZH0jAb9vGQIj2/Qz15hCqTjRRKvyk2aqlP0cUn0AX//aOZt3NkopXwIlu+5iaGVdcFqZew=; c=relaxed/relaxed; s=default; d=ruc.edu.cn; v=1;
	bh=CfXxbgNMw9+HoS60QIpz3BngK0AlOEjcX5CqGTKZmNE=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ruc.edu.cn,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[ruc.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,lunn.ch,davemloft.net,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274769-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wenzhaoliao@ruc.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ruc.edu.cn:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ruc.edu.cn:dkim,ruc.edu.cn:email,ruc.edu.cn:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D79ED38F3FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add C helper entry points for the small networking helpers that are not
exposed through bindgen-friendly interfaces.

This covers netdev_priv() and dev_lstats_add(), which are used by the
reference driver and remain hidden behind Rust-side safe wrappers.

Signed-off-by: Wenzhao Liao <wenzhaoliao@ruc.edu.cn>
---
 rust/helpers/helpers.c |  1 +
 rust/helpers/net.c     | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 rust/helpers/net.c

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index a3c42e51f00a..90fe1c7cbadc 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -38,6 +38,7 @@
 #include "maple_tree.c"
 #include "mm.c"
 #include "mutex.c"
+#include "net.c"
 #include "of.c"
 #include "page.c"
 #include "pci.c"
diff --git a/rust/helpers/net.c b/rust/helpers/net.c
new file mode 100644
index 000000000000..da04c718acd4
--- /dev/null
+++ b/rust/helpers/net.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+
+__rust_helper void rust_helper_dev_kfree_skb(struct sk_buff *skb)
+{
+	dev_kfree_skb(skb);
+}
+
+__rust_helper void rust_helper_dev_lstats_add(struct net_device *dev, unsigned int len)
+{
+	dev_lstats_add(dev, len);
+}
+
+__rust_helper void *rust_helper_netdev_priv(const struct net_device *dev)
+{
+	return netdev_priv(dev);
+}
-- 
2.34.1



Return-Path: <netdev+bounces-252504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIAdLOl0cmlpkwAAu9opvQ
	(envelope-from <netdev+bounces-252504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:05:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 109956CE17
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1493F300DE15
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7891034EEFA;
	Thu, 22 Jan 2026 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8TxcdXc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7132AAB4
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108637; cv=none; b=RxVsFlvHqoe/B4JdTfRHYM/pVrAGgcKLl01JvRpUMFnn5dCMsM43Iuz+vb4Q3AF7UWkkL8jEhOl0Wy3xxuP6hqhPiq7mSPc0Vs6aqrwVBc1ceZmE0sFnujgM/GmepOBAlYzLwNZzJENZaf+QTX4B+fzDlEE0BFnduQvhXWP+CfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108637; c=relaxed/simple;
	bh=Cu6o8NzOShm08SNJfhfpnVv1ADmauWyXomGmnWi32uY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aUPsqwgRcYB4ATSWq+HIduZclYh3tS4rJXXCy0UW0IkhwF6ymXem4nIyYr0TWecXBzB228c7wJ3KiMYrfSTzdaHasKJuvzAP6iQU56L1t4UVBqNcHHaS4BtMlxdgZFDU6oD+lukO6oYKBvQSdCkIe8MfeU3WoEowUH/xnpAgysQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8TxcdXc; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88a2ea47fa5so35216626d6.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769108631; x=1769713431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jW5MNt8Tzxi0nTGwbgqAg9sCreSmdKHLZq+jz+hv1f0=;
        b=m8TxcdXc2zUSbg573zr3M+RSmtNoJnYbYc8nZvggDuciFS0+h3SQi3dP37mtuceV0p
         Dz6dlM37g09bZGTyCZGCBw8TDe9rE/bGzt1QlgZBhYp3eMcgeVoYTz2i6heV7V98PMGI
         1Zc91OsphC9XNUsqpMLs7xdXcCsWCxWZr1noivtHikZtipyOXqldFtGMnEoNmJAP6lgu
         OjuN7KYrayX0hKrADxI8wTHPjWkkJKVsJr0v/EYFrIO7J8mIi5uwYyNUQIsTibAvLaJm
         y3MjII4gbCcgWw+MtOB9cB6CKh/bctDmxKi4TH+eB/e52lqXB1+PfO10Q0cqvIx5f8zT
         upDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769108631; x=1769713431;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jW5MNt8Tzxi0nTGwbgqAg9sCreSmdKHLZq+jz+hv1f0=;
        b=bcVsa9x9OJL0QImHvuldr+WdYiEzDEcU5kokHpG9vDAXsDsGlJ3fpyNRTjvlALT7q2
         eBh2mJaE1Axi/GbZur0D94j8oqravFflflLK/gMFu7cU0iszsB47IdAgHiQKxjalkBAi
         2aEsgSfi6RA3ovz79BSiuNCnVsQZyY8OJOIvlq/em3qTmVrZzPHPbfLWtZzVO8k0SXi/
         AQWfCh4IzWXwuxVJOmGAcqsqCn8PF29Sq14SSXO0iVwvtN6tdgUZOJE1ysiRktd0FhWT
         GeseK2KtFJ0AWsEPBPPqS1z1A9HBXDTL2EE5MyCZ1GBactWxKcHPYhKgiZYpDb1Z6vQ2
         RYIA==
X-Forwarded-Encrypted: i=1; AJvYcCWBrR7bNXvvyAV3NL9nmwQHX427/BsJYRCscqg58tioLZEXFGyJQjGa6vlugS1dctAFbXzfJk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykyeyYb4NVgBHTGtasLeHanHXd4OnRroPBmjDwHQH3ndbvpyaz
	Yd6EicC9ZqJ9Yuq2Z1Wh4p4PHN3q7ktIqzlU1Q0quxhfHiGxtOL2Lta8g6I356BQvYnDGXoFmxb
	UiDU0SRHk9qlGMg==
X-Received: from qvblx2.prod.google.com ([2002:a05:6214:5f02:b0:894:7038:8d68])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:301c:b0:888:6fde:7b72 with SMTP id 6a1803df08f44-894908b07b5mr7543096d6.32.1769108630824;
 Thu, 22 Jan 2026 11:03:50 -0800 (PST)
Date: Thu, 22 Jan 2026 19:03:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122190349.2771064-1-edumazet@google.com>
Subject: [PATCH net-next] net: expand NETDEV_RSS_KEY_LEN to 256 bytes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252504-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 109956CE17
X-Rspamd-Action: no action

NETDEV_RSS_KEY_LEN has been set to 52 bytes in 2014, until now.

Jakub suggested we bump the size to 128 bytes or more.

Some drivers (like idpf) were already working around the core limit.

Since this change might cause some issues in admin scripts,
bump it directly to 256 in one go.

tjbp26:~# cat /proc/sys/net/core/netdev_rss_key | wc -c
768

tjbp26:~# ethtool -x eth1
RX flow hash indirection table for eth1 with 32 RX ring(s):
...
RSS hash key:
fe:16:5b:2f:93:85:c2:c9:c1:ef:bd:60:c6:e0:2b:99:4d:bf:b7:14:c8:1e:8d:cb:31:17:51:da:55:eb:91:d9:9e:f9:89:9b:44:a1:dc:08:72:3a:b3:d6:31:86:9a:fe:02:3a:0d:eb:a1:7c:f5:a3:51:3b:08:56:c9:3f:71:69:01:ba:70:38
RSS hash function:
    toeplitz: on
    xor: off
    crc32: off

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/netdev/20260122075206.504ec591@kernel.org/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/admin-guide/sysctl/net.rst | 13 +++++++------
 include/linux/netdevice.h                |  3 +--
 net/core/sysctl_net_core.c               | 10 ++++++++--
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 91fa4ccd326c2b6351fd028a1c5d1c69126bee5f..19408da2390b013b06ca92b16c152d48a5efbc1e 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -314,21 +314,22 @@ Default: 1000
 netdev_rss_key
 --------------
 
-RSS (Receive Side Scaling) enabled drivers use a 40 bytes host key that is
-randomly generated.
+RSS (Receive Side Scaling) enabled drivers use a host key that
+is randomly generated.
 Some user space might need to gather its content even if drivers do not
 provide ethtool -x support yet.
 
 ::
 
   myhost:~# cat /proc/sys/net/core/netdev_rss_key
-  84:50:f4:00:a8:15:d1:a7:e9:7f:1d:60:35:c7:47:25:42:97:74:ca:56:bb:b6:a1:d8: ... (52 bytes total)
+  84:50:f4:00:a8:15:d1:a7:e9:7f:1d:60:35:c7:47:25:42:97:74:ca:56:bb:b6:a1:d8: ... (256 bytes total)
 
-File contains nul bytes if no driver ever called netdev_rss_key_fill() function.
+File contains all nul bytes if no driver ever called netdev_rss_key_fill()
+function.
 
 Note:
-  /proc/sys/net/core/netdev_rss_key contains 52 bytes of key,
-  but most drivers only use 40 bytes of it.
+  /proc/sys/net/core/netdev_rss_key contains 256 bytes of key,
+  but many drivers only use 40 or 52 bytes of it.
 
 ::
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d99b0fbc1942ad1dbbd372cfb9e809e413251f15..3524c54c786a94a1e797c07d6b2d1cf35b6cbc5b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5163,8 +5163,7 @@ void *netdev_lower_dev_get_private(struct net_device *dev,
 void netdev_lower_state_changed(struct net_device *lower_dev,
 				void *lower_state_info);
 
-/* RSS keys are 40 or 52 bytes long */
-#define NETDEV_RSS_KEY_LEN 52
+#define NETDEV_RSS_KEY_LEN 256
 extern u8 netdev_rss_key[NETDEV_RSS_KEY_LEN] __read_mostly;
 void netdev_rss_key_fill(void *buffer, size_t len);
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 05dd55cf8b58e6c6fce498a11c09f23fd56d8f34..0f761d4b94471a5f8bbe0810922cf59e009be99d 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -325,10 +325,16 @@ static int proc_do_dev_weight(const struct ctl_table *table, int write,
 static int proc_do_rss_key(const struct ctl_table *table, int write,
 			   void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct ctl_table fake_table;
 	char buf[NETDEV_RSS_KEY_LEN * 3];
+	struct ctl_table fake_table;
+	char *pos = buf;
+
+	for (int i = 0; i < NETDEV_RSS_KEY_LEN; i++) {
+		pos = hex_byte_pack(pos, netdev_rss_key[i]);
+		*pos++ = ':';
+	}
+	*(--pos) = 0;
 
-	snprintf(buf, sizeof(buf), "%*phC", NETDEV_RSS_KEY_LEN, netdev_rss_key);
 	fake_table.data = buf;
 	fake_table.maxlen = sizeof(buf);
 	return proc_dostring(&fake_table, write, buffer, lenp, ppos);
-- 
2.52.0.457.g6b5491de43-goog



Return-Path: <netdev+bounces-122948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96898963418
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57581C2407E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 21:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CCE1AD3FB;
	Wed, 28 Aug 2024 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="V3aBzfvA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94005156875
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724881585; cv=none; b=ELuLkVeCB5Uw3GtiFBl+NhG0q/I0F3FQxtprpLY2LGdh5gI0uG5DWeY0Q8o70U/C7g4/bS9NUgnqoVGQAmI4w1+G7R/wpZh+owkYmsuhTxP7RL2oqi/NvdibmC9tiTAY4KmKQwJLMW6VqycZk7isWxpESEAebJMioXvY4HquzeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724881585; c=relaxed/simple;
	bh=1sxKJNKLnXAReKEG2EtlzAJe4sEcrAVZJDvN3S/l+F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBdhXgDxXB9M7Ixe4YCn59gTGOynuU9StYfPajwEFJHd1kms89yJY90Vj1EedyiPwkyfpzJCu/t4RYtb3Ow08P/4b+yJuHE3HAipi2E6kJViNjsa3jRa7wxibki9vZ20CCQUZKoSI6yHkivqMhrVki0FZwhSUErkC4/xzhUrung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=V3aBzfvA; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45680233930so1268971cf.3
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 14:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1724881581; x=1725486381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0Tswf5S4c+yMzuL5IbiobA/lVYfNTKJrfN//29DfZ4=;
        b=V3aBzfvAGLjpboomWQB3H8qDUr3Fof0sk5JC+OSMj17cc0kbvPatkIenrbdny2dese
         wcQwc5cF8VPHzx8uMn6ylIMEywa7n5bL4SkWzfi5SE3A8YjA8BlRic3Nmvh5yO++g6tR
         SIGOnM9hZ3o3+cU+x5rZG71Tsx9lVntZwaZ2L+GdVzHXTCP9Dhi2OdEmxzqArEpBI0ts
         4deSQwSOswJYizZNYkh9cPCdiiWTMsk8xRsAaOdNUnxhgUmDC/CyoNtXXeNHCAxsrWCj
         xptt0PDv+6PoIWbC8Vf7IDmexd6HLZjVOF0ACHyTKzLkhOXYVaOAzvYWu3eVIaJLVFSe
         CPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724881581; x=1725486381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0Tswf5S4c+yMzuL5IbiobA/lVYfNTKJrfN//29DfZ4=;
        b=pmsfcsyCqTfIoDL87SEr739Y/3I5efK9VFrKZ0RNgQlk2tNBK6mLHQsqPqTdQCT3nK
         1mfGB3vLHZEAMSvbgkLXmy4zMKe0bD0m4QqWkFgxpVcWkpB2izDhBmPPs9nureUcXxcx
         RSM8O05dmHKpGchwNEdo9cCxkHqXnwD/QX+KnLxy4EBBN2ZQqwwJmCvRV68t3P6ejXc7
         NNQlgGxoLky5feWxme/icluHKMMSXCfFoumA1fLtRCSvmDE7uwAbabCJKhayUW9/nOtt
         FHI1/6E3m3QJF091Mpa1hMabL5kEoFuC5a9rX5LvAmzvqW/qpl7jE2JTUKe2Yd/ZJxIi
         ablA==
X-Gm-Message-State: AOJu0YyacDU9aQNWAGOkgucd6wBzEKI8uvu+uXZCFTzVFWOFCMNMtjV8
	8qqqoi2GZlqaR4v1rCVlzudvEAX0eDiJOPRAGDXw4MbWYhfOtDBe2YGMnVAKUCY=
X-Google-Smtp-Source: AGHT+IGM5nnILv1IWxvw8oD1Et8+LEvnDLdmzPbs6zojiPLVjSTPkd8ViX3iYjJaxLXlodQpfSGsog==
X-Received: by 2002:ac8:73c9:0:b0:456:8080:df14 with SMTP id d75a77b69052e-4568080f696mr3593541cf.5.1724881581350;
        Wed, 28 Aug 2024 14:46:21 -0700 (PDT)
Received: from devbig254.ash8.facebook.com (fwdproxy-ash-012.fbsv.net. [2a03:2880:20ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe196bc6sm65227741cf.62.2024.08.28.14.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:46:21 -0700 (PDT)
From: Maksym Kutsevol <max@kutsevol.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Maksym Kutsevol <max@kutsevol.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] netcons: Add udp send fail statistics to netconsole
Date: Wed, 28 Aug 2024 14:33:49 -0700
Message-ID: <20240828214524.1867954-2-max@kutsevol.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240828214524.1867954-1-max@kutsevol.com>
References: <20240824215130.2134153-1-max@kutsevol.com>
 <20240828214524.1867954-1-max@kutsevol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance observability of netconsole. Packet sends can fail.
Start tracking at least two failure possibilities: ENOMEM and
NET_XMIT_DROP for every target. Stats are exposed via an additional
attribute in CONFIGFS.

The exposed statistics allows easier debugging of cases when netconsole
messages were not seen by receivers, eliminating the guesswork if the
sender thinks that messages in question were sent out.

Stats are not reset on enable/disable/change remote ip/etc, they
belong to the netcons target itself.

Reported-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/all/ZsWoUzyK5du9Ffl+@gmail.com/
Signed-off-by: Maksym Kutsevol <max@kutsevol.com>
---
Changelog:

v2:
 * fixed commit message wording and reported-by reference.
 * not hiding netconsole_target_stats when CONFIG_NETCONSOLE_DYNAMIC
   is not enabled.
 * rename stats attribute in configfs to transmit_errors and make it
   a single u64 value, which is a sum of errors that occured.
 * make a wrapper function to count errors instead of a return result
   classifier one.
 * use u64_stats_sync.h to manage stats.

v1:
 * https://lore.kernel.org/netdev/20240824215130.2134153-2-max@kutsevol.com/
 Documentation/networking/netconsole.rst |  5 +-
 drivers/net/netconsole.c                | 63 +++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index d55c2a22ec7a..94c4680fdf3e 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -124,7 +124,7 @@ To remove a target::
 
 The interface exposes these parameters of a netconsole target to userspace:
 
-	==============  =================================       ============
+	=============== =================================       ============
 	enabled		Is this target currently enabled?	(read-write)
 	extended	Extended mode enabled			(read-write)
 	release		Prepend kernel release to message	(read-write)
@@ -135,7 +135,8 @@ The interface exposes these parameters of a netconsole target to userspace:
 	remote_ip	Remote agent's IP address		(read-write)
 	local_mac	Local interface's MAC address		(read-only)
 	remote_mac	Remote agent's MAC address		(read-write)
-	==============  =================================       ============
+	transmit_errors	Number of packet send errors		(read-only)
+	=============== =================================       ============
 
 The "enabled" attribute is also used to control whether the parameters of
 a target can be updated or not -- you can modify the parameters of only
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9c09293b5258..e14b13a8e0d2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -36,6 +36,7 @@
 #include <linux/inet.h>
 #include <linux/configfs.h>
 #include <linux/etherdevice.h>
+#include <linux/u64_stats_sync.h>
 #include <linux/utsname.h>
 
 MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
@@ -82,6 +83,12 @@ static DEFINE_SPINLOCK(target_list_lock);
  */
 static struct console netconsole_ext;
 
+struct netconsole_target_stats  {
+	u64_stats_t xmit_drop_count;
+	u64_stats_t enomem_count;
+	struct u64_stats_sync syncp;
+} __aligned(2 * sizeof(u64));
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.
@@ -89,6 +96,7 @@ static struct console netconsole_ext;
  * @userdata_group:	Links to the userdata configfs hierarchy
  * @userdata_complete:	Cached, formatted string of append
  * @userdata_length:	String length of userdata_complete
+ * @stats:	Packet send stats for the target. Used for debugging.
  * @enabled:	On / off knob to enable / disable target.
  *		Visible from userspace (read-write).
  *		We maintain a strict 1:1 correspondence between this and
@@ -115,6 +123,7 @@ struct netconsole_target {
 	struct config_group	userdata_group;
 	char userdata_complete[MAX_USERDATA_ENTRY_LENGTH * MAX_USERDATA_ITEMS];
 	size_t			userdata_length;
+	struct netconsole_target_stats stats;
 #endif
 	bool			enabled;
 	bool			extended;
@@ -227,6 +236,7 @@ static struct netconsole_target *alloc_and_init(void)
  *				|	remote_ip
  *				|	local_mac
  *				|	remote_mac
+ *				|	transmit_errors
  *				|	userdata/
  *				|		<key>/
  *				|			value
@@ -323,6 +333,21 @@ static ssize_t remote_mac_show(struct config_item *item, char *buf)
 	return sysfs_emit(buf, "%pM\n", to_target(item)->np.remote_mac);
 }
 
+static ssize_t transmit_errors_show(struct config_item *item, char *buf)
+{
+	struct netconsole_target *nt = to_target(item);
+	u64 xmit_drop_count, enomem_count;
+	unsigned int start;
+
+	do {
+		start = u64_stats_fetch_begin(&nt->stats.syncp);
+		xmit_drop_count = u64_stats_read(&nt->stats.xmit_drop_count);
+		enomem_count = u64_stats_read(&nt->stats.enomem_count);
+	} while (u64_stats_fetch_retry(&nt->stats.syncp, start));
+
+	return sysfs_emit(buf, "%llu\n", xmit_drop_count + enomem_count);
+}
+
 /*
  * This one is special -- targets created through the configfs interface
  * are not enabled (and the corresponding netpoll activated) by default.
@@ -795,6 +820,7 @@ CONFIGFS_ATTR(, remote_ip);
 CONFIGFS_ATTR_RO(, local_mac);
 CONFIGFS_ATTR(, remote_mac);
 CONFIGFS_ATTR(, release);
+CONFIGFS_ATTR_RO(, transmit_errors);
 
 static struct configfs_attribute *netconsole_target_attrs[] = {
 	&attr_enabled,
@@ -807,6 +833,7 @@ static struct configfs_attribute *netconsole_target_attrs[] = {
 	&attr_remote_ip,
 	&attr_local_mac,
 	&attr_remote_mac,
+	&attr_transmit_errors,
 	NULL,
 };
 
@@ -1015,6 +1042,36 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+/**
+ * netpoll_send_udp_count_errs - Wrapper for netpoll_send_udp that counts errors
+ * @nt: target to send message to
+ * @msg: message to send
+ * @len: length of message
+ *
+ * Calls netpoll_send_udp and classifies the return value. If an error
+ * occurred it increments statistics in nt->stats accordingly.
+ * Noop if CONFIG_NETCONSOLE_DYNAMIC is disabled.
+ */
+// static void netpoll_send_udp_count_errs(struct netpoll *np, const char *msg, int len)
+static void netpoll_send_udp_count_errs(struct netconsole_target *nt, const char *msg, int len)
+{
+#ifdef CONFIG_NETCONSOLE_DYNAMIC
+	int result = netpoll_send_udp(&nt->np, msg, len);
+	result = NET_XMIT_DROP;
+	if (result == NET_XMIT_DROP) {
+		u64_stats_update_begin(&nt->stats.syncp);
+		u64_stats_inc(&nt->stats.xmit_drop_count);
+		u64_stats_update_end(&nt->stats.syncp);
+	} else if (result == -ENOMEM) {
+		u64_stats_update_begin(&nt->stats.syncp);
+		u64_stats_inc(&nt->stats.enomem_count);
+		u64_stats_update_end(&nt->stats.syncp);
+	};
+#else
+	netpoll_send_udp(&nt->np, msg, len);
+#endif
+}
+
 /**
  * send_ext_msg_udp - send extended log message to target
  * @nt: target to send message to
@@ -1063,7 +1120,7 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 					     "%s", userdata);
 
 		msg_ready = buf;
-		netpoll_send_udp(&nt->np, msg_ready, msg_len);
+		netpoll_send_udp_count_errs(nt, msg_ready, msg_len);
 		return;
 	}
 
@@ -1126,7 +1183,7 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 			this_offset += this_chunk;
 		}
 
-		netpoll_send_udp(&nt->np, buf, this_header + this_offset);
+		netpoll_send_udp_count_errs(nt, buf, this_header + this_offset);
 		offset += this_offset;
 	}
 }
@@ -1172,7 +1229,7 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 			tmp = msg;
 			for (left = len; left;) {
 				frag = min(left, MAX_PRINT_CHUNK);
-				netpoll_send_udp(&nt->np, tmp, frag);
+				netpoll_send_udp_count_errs(nt, tmp, frag);
 				tmp += frag;
 				left -= frag;
 			}
-- 
2.43.5



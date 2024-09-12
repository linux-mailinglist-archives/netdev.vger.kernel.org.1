Return-Path: <netdev+bounces-127903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19552976FAA
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA352832E1
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C8D1BD01E;
	Thu, 12 Sep 2024 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="1XZV4KyD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23344188CCA
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162730; cv=none; b=hGDhzAgcAeicmHuwOcD5ebToWrGcliHgvgNKd896hlUtgssDYslpHZTcjb97k5r2DKRZZKBEWFw05rNMDZYsU7fliAxpu1w6F3bHIMY9C2MWgC+Vidf85ku2PJsGyyc+YiXpIBgRQwKjerq18Jfr/unYYPSxWBZyhSVgJO3s7qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162730; c=relaxed/simple;
	bh=APFMeYRqG/AuwC5yvSTPXxVXjdAr6E8A08PReOEcWoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BE9JyfLdGFvTezgvMLAbCXEo4DYy0gejADqCMRpru4gvpwvLtHHLTFglguH0M38UuniS+ASZss/yB0+ruK/fu+Idktti0UaEKCGVTUE27u2FOhMm61OwPvYcPTCgzDazEb27KNv2OxsTWmOUbpNBf4ZhHkvv2elYogQGDgTE2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=1XZV4KyD; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c35b545b41so21022556d6.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1726162727; x=1726767527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMyNuv5ORfWeZlNUug/YUkoEB7gEB8Wjsj3No0rsQGQ=;
        b=1XZV4KyDkUsaxpBgR1CKyqPKrA6qBkEojEAbEbWTZZgMit2rVgP+/PkSnCsr/78bBr
         IozT9GE7FOQ/Z+6o7RpEGhuRTRJ8umwWC61hBj8Nx6B/7nGpvel187pA0CbMQEFWJkNV
         LThItE4W4Erjrao9xtxp25jF5UsEgtWhT9Oao8bqz3LQ6aOEnmwKAxNpjr0NrL9mVXCh
         sbxHdSsG3iE6QPiwcP/vGxzfa4qR8qCWqVqqr0d/WNfkfp8n4fptikrwyWOr7ngGqHDR
         hGCWNJauAGBoUBrAVCGnGaOvVPzDxVgI/aDngsbYbtirHw4NHMjzJDYOFilqmxMaQkA0
         VClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726162727; x=1726767527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMyNuv5ORfWeZlNUug/YUkoEB7gEB8Wjsj3No0rsQGQ=;
        b=micb6Te5cGMVM9YjtI1Q79xEgtq1hrcjvhcJsxZ7vYe/oQAI5nUgYrGCnyvz+ximZS
         qWb35w6ktMJJ7GQ8Q/O8N7maIBpV7Ug7u8JOX1JGBYzMq2wvR7TfhNwffN6tqUBfPAPt
         yJAl1TffzAexvniDmyemwPJ09IxUL62EWUB/9vroFOlkwJcMTCqGCTgo6zqqcGL70OCT
         nsZQkMe4g3OJs6MytTaKZUXthhC/Gr9A2ELlxlfTmzCg/X2i9GjkjryKsZiKGMxMDaZC
         ukRkytpFHs/ylESIIz7npf4VZ7bJyQ87D8WqtzcAwI9UF4lfZBtuvs/9WH4aiXXCC35m
         w5rA==
X-Gm-Message-State: AOJu0YwaDi54/nDHaUJlc9B4sWoW2ldViVRLiUra2RD7S3egKfB1N0sc
	Xr2Zx5wMBkn7X/FGlapEeR7gKapzpnnK2vfZ93TXLLv8szeIxAFhVsaxm4ISTOU=
X-Google-Smtp-Source: AGHT+IGppb/HY30iiXCQz61rdn9quiXR4pq4xnr9zR2jx/wwcji/RkYbOuSBPjURPvVNYJe60zm0Wg==
X-Received: by 2002:a05:6214:5906:b0:6c5:1452:2b47 with SMTP id 6a1803df08f44-6c573b21c93mr65158936d6.18.1726162726767;
        Thu, 12 Sep 2024 10:38:46 -0700 (PDT)
Received: from devbig254.ash8.facebook.com (fwdproxy-ash-000.fbsv.net. [2a03:2880:20ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534773619sm56605626d6.106.2024.09.12.10.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:38:46 -0700 (PDT)
From: Maksym Kutsevol <max@kutsevol.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maksym Kutsevol <max@kutsevol.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 2/2] netcons: Add udp send fail statistics to netconsole
Date: Thu, 12 Sep 2024 10:28:52 -0700
Message-ID: <20240912173608.1821083-2-max@kutsevol.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240912173608.1821083-1-max@kutsevol.com>
References: <20240912173608.1821083-1-max@kutsevol.com>
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
v3:
 * cleanup the accidental slip of debugging addons.
 * use IS_ENABLED() instead of #ifdef. Always have stats field.

v2:
 * https://lore.kernel.org/netdev/20240828214524.1867954-2-max@kutsevol.com/
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

 Documentation/networking/netconsole.rst |  5 ++-
 drivers/net/netconsole.c                | 60 +++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 5 deletions(-)

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
index 01cf33fa7503..fe6f29171a83 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -36,6 +36,7 @@
 #include <linux/inet.h>
 #include <linux/configfs.h>
 #include <linux/etherdevice.h>
+#include <linux/u64_stats_sync.h>
 #include <linux/utsname.h>
 #include <linux/rtnetlink.h>
 
@@ -90,6 +91,12 @@ static DEFINE_MUTEX(target_cleanup_list_lock);
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
@@ -97,6 +104,7 @@ static struct console netconsole_ext;
  * @userdata_group:	Links to the userdata configfs hierarchy
  * @userdata_complete:	Cached, formatted string of append
  * @userdata_length:	String length of userdata_complete
+ * @stats:	Packet send stats for the target. Used for debugging.
  * @enabled:	On / off knob to enable / disable target.
  *		Visible from userspace (read-write).
  *		We maintain a strict 1:1 correspondence between this and
@@ -124,6 +132,7 @@ struct netconsole_target {
 	char userdata_complete[MAX_USERDATA_ENTRY_LENGTH * MAX_USERDATA_ITEMS];
 	size_t			userdata_length;
 #endif
+	struct netconsole_target_stats stats;
 	bool			enabled;
 	bool			extended;
 	bool			release;
@@ -262,6 +271,7 @@ static void netconsole_process_cleanups_core(void)
  *				|	remote_ip
  *				|	local_mac
  *				|	remote_mac
+ *				|	transmit_errors
  *				|	userdata/
  *				|		<key>/
  *				|			value
@@ -371,6 +381,21 @@ static ssize_t remote_mac_show(struct config_item *item, char *buf)
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
@@ -842,6 +867,7 @@ CONFIGFS_ATTR(, remote_ip);
 CONFIGFS_ATTR_RO(, local_mac);
 CONFIGFS_ATTR(, remote_mac);
 CONFIGFS_ATTR(, release);
+CONFIGFS_ATTR_RO(, transmit_errors);
 
 static struct configfs_attribute *netconsole_target_attrs[] = {
 	&attr_enabled,
@@ -854,6 +880,7 @@ static struct configfs_attribute *netconsole_target_attrs[] = {
 	&attr_remote_ip,
 	&attr_local_mac,
 	&attr_remote_mac,
+	&attr_transmit_errors,
 	NULL,
 };
 
@@ -1058,6 +1085,33 @@ static struct notifier_block netconsole_netdev_notifier = {
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
+ * Only calls netpoll_send_udp if CONFIG_NETCONSOLE_DYNAMIC is disabled.
+ */
+static void netpoll_send_udp_count_errs(struct netconsole_target *nt, const char *msg, int len)
+{
+	int result = netpoll_send_udp(&nt->np, msg, len);
+
+	if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
+		if (result == NET_XMIT_DROP) {
+			u64_stats_update_begin(&nt->stats.syncp);
+			u64_stats_inc(&nt->stats.xmit_drop_count);
+			u64_stats_update_end(&nt->stats.syncp);
+		} else if (result == -ENOMEM) {
+			u64_stats_update_begin(&nt->stats.syncp);
+			u64_stats_inc(&nt->stats.enomem_count);
+			u64_stats_update_end(&nt->stats.syncp);
+		}
+	}
+}
+
 /**
  * send_ext_msg_udp - send extended log message to target
  * @nt: target to send message to
@@ -1106,7 +1160,7 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 					     "%s", userdata);
 
 		msg_ready = buf;
-		netpoll_send_udp(&nt->np, msg_ready, msg_len);
+		netpoll_send_udp_count_errs(nt, msg_ready, msg_len);
 		return;
 	}
 
@@ -1169,7 +1223,7 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 			this_offset += this_chunk;
 		}
 
-		netpoll_send_udp(&nt->np, buf, this_header + this_offset);
+		netpoll_send_udp_count_errs(nt, buf, this_header + this_offset);
 		offset += this_offset;
 	}
 }
@@ -1215,7 +1269,7 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
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



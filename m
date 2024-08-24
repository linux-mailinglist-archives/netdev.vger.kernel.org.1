Return-Path: <netdev+bounces-121681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD8A95E013
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 23:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4B91C20FED
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 21:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C81D13A268;
	Sat, 24 Aug 2024 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="levxh8ep"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B24C48CCC
	for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724536437; cv=none; b=LlQdENvRWpFz23k32ZDdghhqfdq43g4V4BSaa6xvpJLeLiqodyydhuL+scGaoY1zJGh4m0CG08aXsQw49gsoBUWfR8KTNzhrwC69raTEex6yTQrSrSeNj/ViJatyg6kXShcaVlwlhPy6Z80Bpjk73W5+WbUm1jFJIUNX0EE/mI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724536437; c=relaxed/simple;
	bh=4LE4weMPdvXTJ/F/GivsUGU6I9k2XgURasdip2WVhAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imyNTDzvmDB3VqBxPLC2izHmrMc89pCweCJWbQTEP51NsE2t2TNiIjSQxEnw/pxYIqVLSjeviezRkcXf9iwC60O1M5iR3yuwXZ0y5YEwK+5itknb2n06TqbjRZsE25iDJId4ZwU3LTg+6ASwS8LneY4ugTiPT5C04nr72my8ptU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=levxh8ep; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1d436c95fso188130285a.3
        for <netdev@vger.kernel.org>; Sat, 24 Aug 2024 14:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1724536435; x=1725141235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1GlhmphObW3OjUIsMA5Qnel/65FH+T2FY1x3SipER0=;
        b=levxh8epjVNIgj2lEUO6HDzZci/cNFHDo69DafB0bwD+5zxUuTAnucHsXIZAVQvOIu
         KlPihLZwsY8/f+NmybQ3SntID1VrkAFtAhjE6IQ3EYpHoBTbwrNi9f3nfiZNhzWtsMOC
         RvBUknN9IbAtoDl1UdsAHYZg3uUWdfT4yIMuJ+PvWy92GBdS0MJ1jTqMtXouLrFXcyIv
         bSMxFJD19H/TyDGYsMQ9cZird8WQMMsN95hiKxOZDeAwv31XLWSh3z2/A5dYLN8BZRnz
         hl504SVxA3pFluZ9gocJQ7tFuGdqfYXdTX0b6x5nFm2D95g5TDSOLSfmTj7YgvHksTbg
         YPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724536435; x=1725141235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1GlhmphObW3OjUIsMA5Qnel/65FH+T2FY1x3SipER0=;
        b=k/zU4drAKR42v5M5rizxohPP5hX1C4e9kWxDGVnknxZ1tkSpHviroIkfF7q7luCPkz
         qH2aFels6XY2dzrSHq5s4/6acXpbtKDSsZGCV5IqVGiT2IfwJK144IcLO5hFEFkw0r+X
         wYVt8HX0+d8AAnKk4qe1mKHwiKpb+T9XP+08dOpWuHRUsOz4gBOJ7cpQRkf5ZqlobKkY
         VVLRV2nHNaKj/2b1iPA1t6UJZZaRoyHaucsm3YVWe87B9btt1n20SzoJ+SwiSK/RWhQX
         1S+NNiUNT43jN8DC8k6MoMV+8HQ3w+2u5T4bK1c93LDYTMy8FZk6JXUB3nOZyjiQG23T
         4Z4w==
X-Gm-Message-State: AOJu0YxICKZ4QbJSbTHNCRpnvPkGKZ5f8oWWPMcto6G/z3342GwaQ6j5
	F2Y/edQw81TtEiy+Faqw/KkxuaDV7OCcOY2MkS9DGLIYazTmVjnN7yUHtTaj4cc=
X-Google-Smtp-Source: AGHT+IHl7mXUqr22WDIfj59oMMaH8EONkuQCwT2Yi54wD7zzm8BL2/KhPpfu4v/+XNpcrHVp/xPArQ==
X-Received: by 2002:a05:620a:31a0:b0:79f:10f:23fd with SMTP id af79cd13be357-7a6896f90c9mr611524185a.23.1724536435004;
        Sat, 24 Aug 2024 14:53:55 -0700 (PDT)
Received: from devbig254.ash8.facebook.com (fwdproxy-ash-114.fbsv.net. [2a03:2880:20ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3bb19esm307937385a.74.2024.08.24.14.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 14:53:54 -0700 (PDT)
From: Maksym Kutsevol <max@kutsevol.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Maksym Kutsevol <max@kutsevol.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] netcons: Add udp send fail statistics to netconsole
Date: Sat, 24 Aug 2024 14:50:24 -0700
Message-ID: <20240824215130.2134153-2-max@kutsevol.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240824215130.2134153-1-max@kutsevol.com>
References: <20240824215130.2134153-1-max@kutsevol.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance observability of netconsole. UDP sends can fail. Start tracking at
least two failure possibilities: ENOMEM and NET_XMIT_DROP for every target.
Stats are exposed via an additional attribute in CONFIGFS.

The exposed statistics allows easier debugging of cases when netconsole
messages were not seen by receivers, eliminating the guesswork if the
sender thinks that messages in question were sent out.

Stats are not reset on enable/disable/change remote ip/etc, they
belong to the netcons target itself.

Signed-off-by: Maksym Kutsevol <max@kutsevol.com>
---
 Documentation/networking/netconsole.rst |  1 +
 drivers/net/netconsole.c                | 54 +++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index d55c2a22ec7a..733d4a93878e 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -135,6 +135,7 @@ The interface exposes these parameters of a netconsole target to userspace:
 	remote_ip	Remote agent's IP address		(read-write)
 	local_mac	Local interface's MAC address		(read-only)
 	remote_mac	Remote agent's MAC address		(read-write)
+	stats		Send error stats			(read-only)
 	==============  =================================       ============
 
 The "enabled" attribute is also used to control whether the parameters of
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9c09293b5258..45c07ec7842d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -82,6 +82,13 @@ static DEFINE_SPINLOCK(target_list_lock);
  */
 static struct console netconsole_ext;
 
+#ifdef CONFIG_NETCONSOLE_DYNAMIC
+struct netconsole_target_stats  {
+	size_t xmit_drop_count;
+	size_t enomem_count;
+};
+#endif
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.
@@ -89,6 +96,7 @@ static struct console netconsole_ext;
  * @userdata_group:	Links to the userdata configfs hierarchy
  * @userdata_complete:	Cached, formatted string of append
  * @userdata_length:	String length of userdata_complete
+ * @stats:	UDP send stats for the target. Used for debugging.
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
+ *				|	stats
  *				|	userdata/
  *				|		<key>/
  *				|			value
@@ -323,6 +333,14 @@ static ssize_t remote_mac_show(struct config_item *item, char *buf)
 	return sysfs_emit(buf, "%pM\n", to_target(item)->np.remote_mac);
 }
 
+static ssize_t stats_show(struct config_item *item, char *buf)
+{
+	struct netconsole_target *nt = to_target(item);
+
+	return sysfs_emit(buf, "xmit_drop: %lu enomem: %lu\n",
+		nt->stats.xmit_drop_count, nt->stats.enomem_count);
+}
+
 /*
  * This one is special -- targets created through the configfs interface
  * are not enabled (and the corresponding netpoll activated) by default.
@@ -795,6 +813,7 @@ CONFIGFS_ATTR(, remote_ip);
 CONFIGFS_ATTR_RO(, local_mac);
 CONFIGFS_ATTR(, remote_mac);
 CONFIGFS_ATTR(, release);
+CONFIGFS_ATTR_RO(, stats);
 
 static struct configfs_attribute *netconsole_target_attrs[] = {
 	&attr_enabled,
@@ -807,6 +826,7 @@ static struct configfs_attribute *netconsole_target_attrs[] = {
 	&attr_remote_ip,
 	&attr_local_mac,
 	&attr_remote_mac,
+	&attr_stats,
 	NULL,
 };
 
@@ -1015,6 +1035,25 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
+/**
+ * count_udp_send_stats - Classify netpoll_send_udp result and count errors.
+ * @nt: target that was sent to
+ * @result: result of netpoll_send_udp
+ *
+ * Takes the result of netpoll_send_udp and classifies the type of error that
+ * occurred. Increments statistics in nt->stats accordingly.
+ */
+static void count_udp_send_stats(struct netconsole_target *nt, int result)
+{
+#ifdef CONFIG_NETCONSOLE_DYNAMIC
+	if (result == NET_XMIT_DROP) {
+		nt->stats.xmit_drop_count++;
+	} else if (result == -ENOMEM) {
+		nt->stats.enomem_count++;
+	};
+#endif
+}
+
 /**
  * send_ext_msg_udp - send extended log message to target
  * @nt: target to send message to
@@ -1063,7 +1102,9 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 					     "%s", userdata);
 
 		msg_ready = buf;
-		netpoll_send_udp(&nt->np, msg_ready, msg_len);
+		count_udp_send_stats(nt, netpoll_send_udp(&nt->np,
+							  msg_ready,
+							  msg_len));
 		return;
 	}
 
@@ -1126,7 +1167,11 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 			this_offset += this_chunk;
 		}
 
-		netpoll_send_udp(&nt->np, buf, this_header + this_offset);
+		count_udp_send_stats(nt,
+				     netpoll_send_udp(&nt->np,
+						      buf,
+						      this_header + this_offset)
+		);
 		offset += this_offset;
 	}
 }
@@ -1172,7 +1217,10 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 			tmp = msg;
 			for (left = len; left;) {
 				frag = min(left, MAX_PRINT_CHUNK);
-				netpoll_send_udp(&nt->np, tmp, frag);
+				int send_result = netpoll_send_udp(&nt->np,
+								   tmp,
+								   frag);
+				count_udp_send_stats(nt, send_result);
 				tmp += frag;
 				left -= frag;
 			}
-- 
2.43.5



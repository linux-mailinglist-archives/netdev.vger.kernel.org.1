Return-Path: <netdev+bounces-124564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7FB969FE2
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979591C2304D
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B92176046;
	Tue,  3 Sep 2024 14:08:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546B76F2E7;
	Tue,  3 Sep 2024 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372493; cv=none; b=Y4G7oo3Di3ngsmukZYlhNFLuqlU86Tm03FaSA8CYfl5fiTZpVPsqTXbD9u0Ac4TsgORK6VV/BrNLtBFmVQ3umjknqCr4Euquivu6HIaeVTSz6ucMXStDT1pbzs/jjqrotZtdhsnf9yPWv1LdJtvCQXpA+dYdy10onkz/t/EjlfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372493; c=relaxed/simple;
	bh=DaTtyBeT2Xf2cSzOd42rn2RoCx7PY9UKkjpNo0fS/NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAyXRin79lUtXQZ3tpUywHZB/aRT/L4UJ3GlLyR+OXxZiR6ahnkzQU9IQIS9IcU3fyNKX6GHR7AKPQfKxkTVbCnyVZCvAhS2uXQmiUgiSshncTT59WaiHOs3X+lwTnWQB+OWYSdTG8HJea+TFMqWC9mAURrpX43VpsDEk/4wv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c26852af8fso1649351a12.2;
        Tue, 03 Sep 2024 07:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372490; x=1725977290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ri1EA58BV/TWrZaeQrKkMSfjb0f3rHKbzd1pYby/AY0=;
        b=xEI7drzFIGTgctV8ULRjSMHY4ixkRiPgDRzQPglo98Tk0Jm8IkWwGoYqaWOqQ/Y6tO
         rG8m3NxArCAgdi+z+zsC+49gq5GsV7PmcEMDd89olq06pU4tyIhX9s4N6qw3MULfgDfq
         NkQSEZdMJyQfk5eQTewKsSX3fU7c5Naf4C2FiuWubklrFQh0eAInr89//0MK/pOoH9Co
         PcixQtmV4rLfOe9VDt82YMXrN+y8T8aOZQn6Bl5RRSTmSVHwgE+o54dNJ9YjwE5cMyYp
         sTMV7zMEJQT/uy6NLE6aAt+PN1g3C2KLJNK5SRU+kxhKeA2pBZUApLI8eQ/N3FeRHBua
         DHZg==
X-Forwarded-Encrypted: i=1; AJvYcCVFXZ+RnBI3y5DUo8xd4gcWCAGUDGJKtI3ch97oAcFuPfpcneUGO0y5mroX6PV1WbnR+VoXO38hkN/NqvQ=@vger.kernel.org, AJvYcCWQsscim/qJWwwZI0LdtQUCD2YmtDpZ0q36baz8+d/9yaDzMAV2QOxpVBLUlTL1LTangb+YTZDD@vger.kernel.org
X-Gm-Message-State: AOJu0YwEAR2hnnXnk4Mlvj1GsOf0uV0uhtD7Gr5ER/vetRcFdiqx9rrs
	f4LP3nj6tuwPSeZa0ols+h9w2AqlpZd3omvDO6sI5MJbv3lRyuA1
X-Google-Smtp-Source: AGHT+IGFK+QPrc526rQXpunySM8256dcguA0aQ+3buHH7lSuUpKxp7eobgClYXJzDurOcHxXahtTDA==
X-Received: by 2002:a05:6402:50cc:b0:5c2:6083:6256 with SMTP id 4fb4d7f45d1cf-5c2608364d2mr3587492a12.10.1725372488708;
        Tue, 03 Sep 2024 07:08:08 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccfe84sm6447630a12.71.2024.09.03.07.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:08:07 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk,
	thevlad@meta.com,
	max@kutsevol.com
Subject: [PATCH net-next 3/9] net: netconsole: separate fragmented message handling in send_ext_msg
Date: Tue,  3 Sep 2024 07:07:46 -0700
Message-ID: <20240903140757.2802765-4-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240903140757.2802765-1-leitao@debian.org>
References: <20240903140757.2802765-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the previous change, where the non-fragmented case was moved
to its own function, this update introduces a new function called
send_msg_fragmented to specifically manage scenarios where message
fragmentation is required.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 129 ++++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 55 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 0e43dacbd291..176ce6c616cb 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1058,66 +1058,20 @@ static struct notifier_block netconsole_netdev_notifier = {
 	.notifier_call  = netconsole_netdev_event,
 };
 
-static void send_msg_no_fragmentation(struct netconsole_target *nt,
-				      const char *msg,
-				      const char *userdata,
-				      int msg_len,
-				      int release_len)
-{
-	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
-	const char *release;
-
-	if (release_len) {
-		release = init_utsname()->release;
-
-		scnprintf(buf, MAX_PRINT_CHUNK, "%s,%s", release, msg);
-		msg_len += release_len;
-	} else {
-		memcpy(buf, msg, msg_len);
-	}
-
-	if (userdata)
-		msg_len += scnprintf(&buf[msg_len],
-				     MAX_PRINT_CHUNK - msg_len,
-				     "%s", userdata);
-
-	netpoll_send_udp(&nt->np, buf, msg_len);
-}
-
-/**
- * send_ext_msg_udp - send extended log message to target
- * @nt: target to send message to
- * @msg: extended log message to send
- * @msg_len: length of message
- *
- * Transfer extended log @msg to @nt.  If @msg is longer than
- * MAX_PRINT_CHUNK, it'll be split and transmitted in multiple chunks with
- * ncfrag header field added to identify them.
- */
-static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
-			     int msg_len)
+static void send_msg_fragmented(struct netconsole_target *nt,
+				const char *msg,
+				const char *userdata,
+				int msg_len,
+				int release_len)
 {
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
+	int offset = 0, userdata_len = 0;
 	const char *header, *body;
-	int offset = 0;
 	int header_len, body_len;
 	const char *release;
-	int release_len = 0;
-	int userdata_len = 0;
-	char *userdata = NULL;
-
-#ifdef CONFIG_NETCONSOLE_DYNAMIC
-	userdata = nt->userdata_complete;
-	userdata_len = nt->userdata_length;
-#endif
-
-	if (nt->release) {
-		release = init_utsname()->release;
-		release_len = strlen(release) + 1;
-	}
 
-	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK)
-		return send_msg_no_fragmentation(nt, msg, userdata, msg_len, release_len);
+	if (userdata)
+		userdata_len = nt->userdata_length;
 
 	/* need to insert extra header fields, detect header and body */
 	header = msg;
@@ -1133,11 +1087,18 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	 * Transfer multiple chunks with the following extra header.
 	 * "ncfrag=<byte-offset>/<total-bytes>"
 	 */
-	if (nt->release)
+	if (release_len) {
+		release = init_utsname()->release;
 		scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
+	}
+
+	/* Copy the header into the buffer */
 	memcpy(buf + release_len, header, header_len);
 	header_len += release_len;
 
+	/* for now on, the header will be persisted, and the body
+	 * will be replaced
+	 */
 	while (offset < body_len + userdata_len) {
 		int this_header = header_len;
 		int this_offset = 0;
@@ -1183,6 +1144,64 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	}
 }
 
+static void send_msg_no_fragmentation(struct netconsole_target *nt,
+				      const char *msg,
+				      const char *userdata,
+				      int msg_len,
+				      int release_len)
+{
+	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
+	const char *release;
+
+	if (release_len) {
+		release = init_utsname()->release;
+
+		scnprintf(buf, MAX_PRINT_CHUNK, "%s,%s", release, msg);
+		msg_len += release_len;
+	} else {
+		memcpy(buf, msg, msg_len);
+	}
+
+	if (userdata)
+		msg_len += scnprintf(&buf[msg_len],
+				     MAX_PRINT_CHUNK - msg_len,
+				     "%s", userdata);
+
+	netpoll_send_udp(&nt->np, buf, msg_len);
+}
+
+/**
+ * send_ext_msg_udp - send extended log message to target
+ * @nt: target to send message to
+ * @msg: extended log message to send
+ * @msg_len: length of message
+ *
+ * Transfer extended log @msg to @nt.  If @msg is longer than
+ * MAX_PRINT_CHUNK, it'll be split and transmitted in multiple chunks with
+ * ncfrag header field added to identify them.
+ */
+static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
+			     int msg_len)
+{
+	char *userdata = NULL;
+	int userdata_len = 0;
+	int release_len = 0;
+
+#ifdef CONFIG_NETCONSOLE_DYNAMIC
+	userdata = nt->userdata_complete;
+	userdata_len = nt->userdata_length;
+#endif
+
+	if (nt->release)
+		release_len = strlen(init_utsname()->release) + 1;
+
+	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK)
+		return send_msg_no_fragmentation(nt, msg, userdata, msg_len,
+						 release_len);
+
+	return send_msg_fragmented(nt, msg, userdata, msg_len, release_len);
+}
+
 static void write_ext_msg(struct console *con, const char *msg,
 			  unsigned int len)
 {
-- 
2.43.5



Return-Path: <netdev+bounces-286599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AmaIJy0AWo2iwEAu9opvQ
	(envelope-from <netdev+bounces-286599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:51:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BC850C3CB
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35DC1302B39E
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 10:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2913DA7E1;
	Mon, 11 May 2026 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="YgKYbm0v"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915B3D9DCD;
	Mon, 11 May 2026 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496146; cv=none; b=QglypTAg7V/jC2RS7o72DB4s6XMQ1IN034BOKtn8me/9Z1gKU2vYexcKdcmS1OLXQ5SllyqH4TF6miwtsiMO8y5oSjPluEm66GnnxrGPhclyR8RbVMiSCCLEGBL1Af4sb2LyoV8V2acsgBRR/glOmu4g+zoWccQhPyprsOwg8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496146; c=relaxed/simple;
	bh=DYq6umQdMqZTUhdHO/E7X/+HRGCCc9h/fbLMCwywAhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r3qQeDPjN5dqniG3r5o0IP9IXPeC5jZBphVDVaPLnOQjkQkeHaWHdutT/OtJ8K7jzvYQfvISbn0cUNQxgmdj9fcUYkIk0Og5Q2/EfMjSkpNZ2LX8CYszGeu5n0ijOXvjKfpabnO8LSDk30P9AsLSFFMNgZExvDeKcarJ6jcefQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=YgKYbm0v; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=JlQcP5h04hzIu0TVPM/h9/knvfbMgGm2wjEk1jQ7Bbs=; b=YgKYbm0vG+33y2x7VDgPI5iGJy
	pw/mYxZA3jhCcg30512eE0QZj5/QyF9f5SqyTDCBEb/2cMvKp/FnnDrZsv7TsLAUdme1z3SDrudcM
	5h971MyiMqhXNHGmfX4MVOQmtyCIYws/4/YCNEl1SsWRsdOFPaLF/ettCJydxhiPn4MyC32FsqCqJ
	LkxMsC8h/N75ElJ3rpN8DKaH5Hv6iHOh9pH2FaN6kKfsx3ZErk53dzB8p40bLyYrTQZqL05bS8KWM
	j4Yo+yOulrBKOhULeJUGdZHc/1mPnHt4CmMiqckk0eaPC6pmP3+qOxbgACPkCRlJbXSOxw6BedIWB
	QRGEwE5A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMO5e-001XfW-2r;
	Mon, 11 May 2026 10:42:23 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 May 2026 03:41:51 -0700
Subject: [PATCH net-next 6/7] selftests: net: getsockopt_iter: cover SCO
 BT_CODEC conversion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-getsock_three-v1-6-1461fa8786ab@debian.org>
References: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
In-Reply-To: <20260511-getsock_three-v1-0-1461fa8786ab@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3624; i=leitao@debian.org;
 h=from:subject:message-id; bh=DYq6umQdMqZTUhdHO/E7X/+HRGCCc9h/fbLMCwywAhM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqAbJvegQsqAc2+nnmwSJT84W9rZ4l0i8Bj+wn0
 /wh6Na7PQKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagGybwAKCRA1o5Of/Hh3
 beqnD/9EwDFH+x5/znqdulgo5JHr37qd6q5YfE2Xy8+qzeln1A1XEyJNhki3NUK3nkrycGoinXf
 UxtqCuN8XgMFioG81gRO6rhjOBHgiXFRmLfKCG734WvJ3JBryUkpDuaQDQR0FFLcN+ohwA3JJi8
 xi3UWWvO+J/YptSFgad8hxji3HqIcNie743GsvCB5pxSOIn3lsnM6uzKxCWCcgizYaEwGQS6k1V
 wo9CtG4CIRibT3cHBCl8vJ1GIgsc/HxMTLMPqzitSz/GToJsLaG/ebFq75uJtc3TjNldrfGPbSa
 +fTqLgZpwRiYlRCxwlNQtrtcMvenAma99iHBxad89VOa/GDCQtLcg9Jma6f8V/UfpUcfGtg5Ur+
 6urHBGvrfvG4NcLXEKRbhOcD9vMIzZdDVGp3Co3pe//xe2WudFcxhvaDC7byXaX4rjvIwkUFx7p
 aVzcNPF/QQ4BqUD759uMTmPPbzMKm3gOmbS5keGlWJ8cUn4JVpTiYL8vZLfQ0l1CU0/LpZ9PEmW
 kbpmmp87RyYTyDcyOkz+pjlWl6KICZdV6bG6q3ZWbT/VYugtwyi8/2RdoGJyZgyKvQG1OSEUGq9
 ZTBWMQ3BZpky5ypizGyGnG7vi4hmPROJGutjxs8TlYj367PTNUHTWowLzJ2ViAIOAF4n6myUrBW
 64JdOMpnKkgzgHQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 02BC850C3CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286599-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add a single test for the SCO conversion that replaced an open-coded
ptr cursor in BT_CODEC with plain copy_to_iter() calls. The test
pre-fills the user buffer with a sentinel byte and:

  - asserts the buffer is unchanged when the kernel returns -EBADFD
    or -EOPNOTSUPP (the common case in CI, where there is no
    controller exposing HCI_OFFLOAD_CODECS_ENABLED + a
    get_data_path_id op), or
  - asserts at least one byte changed when the call succeeds
    (capable controller present), validating the converted
    copy_to_iter() write path.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/net/getsockopt_iter.c | 65 +++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/net/getsockopt_iter.c b/tools/testing/selftests/net/getsockopt_iter.c
index 209569354d0e3..b3cac4be4af0d 100644
--- a/tools/testing/selftests/net/getsockopt_iter.c
+++ b/tools/testing/selftests/net/getsockopt_iter.c
@@ -11,6 +11,13 @@
  *   that always reports the required buffer length back via optlen,
  *   even when the user buffer is too small to receive any group bits.
  * - vsock:   SO_VM_SOCKETS_BUFFER_SIZE covers the u64 path.
+ * - bluetooth/sco: BT_CODEC exercises the SCO conversion that
+ *   replaced an open-coded ptr cursor with copy_to_iter() — the
+ *   test pre-fills the user buffer with a sentinel and asserts that
+ *   the error-return paths (hit when no controller / no codec
+ *   offload is available, the common case in CI) leave the buffer
+ *   untouched. If a capable controller is present, the success
+ *   path's copy_to_iter() write is validated instead.
  *
  * Author: Breno Leitao <leitao@debian.org>
  */
@@ -31,6 +38,15 @@
 #define AF_VSOCK 40
 #endif
 
+#ifndef AF_BLUETOOTH
+#define AF_BLUETOOTH	31
+#endif
+
+#define BTPROTO_SCO		2
+#define SOL_BLUETOOTH		274
+#define BT_CODEC		19
+#define BT_SENTINEL		0xa5
+
 /* ---------- netlink ---------- */
 
 FIXTURE(netlink)
@@ -297,4 +313,53 @@ TEST_F(vsock, connect_timeout_old_exact)
 	ASSERT_EQ(sizeof(tv), optlen);
 }
 
+/* ---------- bluetooth ---------- */
+
+/* sco: BT_CODEC. The SCO conversion replaced an open-coded ptr
+ * cursor in this option with plain copy_to_iter() calls. Without a
+ * controller exposing HCI_OFFLOAD_CODECS_ENABLED + a get_data_path_id
+ * op, the kernel returns -EBADFD / -EOPNOTSUPP from an early check
+ * and must NOT touch the user buffer. With such a controller the
+ * call succeeds and the buffer is filled by copy_to_iter().
+ */
+TEST(bt_sco_codec)
+{
+	socklen_t optlen;
+	uint8_t buf[256];
+	int fd, ret;
+
+	fd = socket(AF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO);
+	if (fd < 0)
+		SKIP(return, "AF_BLUETOOTH/SCO: %s", strerror(errno));
+
+	memset(buf, BT_SENTINEL, sizeof(buf));
+	optlen = sizeof(buf);
+	ret = getsockopt(fd, SOL_BLUETOOTH, BT_CODEC, buf, &optlen);
+
+	if (ret < 0) {
+		size_t i, changed = 0;
+
+		ASSERT_TRUE(errno == EBADFD || errno == EOPNOTSUPP)
+			TH_LOG("unexpected errno %d (%s)", errno,
+			       strerror(errno));
+		for (i = 0; i < sizeof(buf); i++)
+			if (buf[i] != BT_SENTINEL)
+				changed++;
+		ASSERT_EQ(0, changed)
+			TH_LOG("error path modified %zu byte(s)", changed);
+	} else {
+		size_t i, changed = 0;
+
+		ASSERT_GT(optlen, 0);
+		ASSERT_LE(optlen, sizeof(buf));
+		for (i = 0; i < optlen; i++)
+			if (buf[i] != BT_SENTINEL)
+				changed++;
+		ASSERT_GT(changed, 0)
+			TH_LOG("success path left buffer untouched");
+	}
+
+	close(fd);
+}
+
 TEST_HARNESS_MAIN

-- 
2.53.0-Meta



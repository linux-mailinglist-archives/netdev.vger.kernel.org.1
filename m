Return-Path: <netdev+bounces-306923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DMarAUAUU2oSWwMAu9opvQ
	(envelope-from <netdev+bounces-306923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 06:12:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FAF743C8D
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 06:12:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ljVUR4LY;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306923-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306923-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 612B7305B7E5
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 04:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031C8370AE7;
	Sun, 12 Jul 2026 04:09:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0A936AB5A
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 04:09:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783829368; cv=none; b=M4pOwB4Ywczq9bFD2pm1YGIYrSz0aMZkoD5JqM7EkO/qQ5d3uU3gCrWoPiR27Nt2AmflfseefU5yFtP208ZPPuVCdGTsdlHgYhIRezJmZ9oLVkLPoelOtVqYEcifeZaPtiFAGlsM4RKI5woxHRfbNaVuJycP4yhfIkWKj34TxhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783829368; c=relaxed/simple;
	bh=ht7k1vfyTfnKzBTKA4hWIj+a/zQqJ1S/l9ggwrpoISo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouYb08yHiuF5iUjit+CFwKKqte3bJkMn9pJ17vnjZezUk0CpEAN+SFPBG2R5PIvTCW+Jk0dMsLtuA2zrCauu265m5MhJ5yNZgPNDwVOe10BmXe0Tf+qAlQwa8eDDT3LclhnSh7iFdjIf1fBiAAi8uN/WbARcQ0eG7TOFNDOi9lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljVUR4LY; arc=none smtp.client-ip=209.85.219.41
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ef7b7651ecso24745166d6.1
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 21:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783829365; x=1784434165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CY1zhHCs8Urd6z2dxMWVdrNocO2i3dPyfsdmlbGYaEg=;
        b=ljVUR4LYLTjfRSI3KGhnaHhxHKA2dn/11jD/S0aF9ftwYXsuo9oxFItpkTJLbIguJm
         5/q6bNuC9IKtit2LiIScEYlIwtYvqKLqTPjQyvPwy+nlG86o8W3mbWvDDAd0ogFHtNt6
         fKCWxM/j75Ang57K8NwZ+APwFaZpdrBAJfhP2xftQ3h6cTi43peEQf0TpvKExTNi+IV+
         hBq/tj7zGUyoop+CSRbDS8PkY23sfm5/1/lAgd2BMu5VVW/Yb0j92eRlRTWAk2RFhtko
         SzcYXWphSq3jFyRdrigF2XtXAAmA1p95Bd5bnBM41ZB6kyHx3RhgqT5NuQBFDGVkKXA9
         5pxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783829365; x=1784434165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CY1zhHCs8Urd6z2dxMWVdrNocO2i3dPyfsdmlbGYaEg=;
        b=bZsZ+qPlQm9OCbM6cCspB2ldNQ3EyaohbgyCg56ze2yY/BvQDYjRhu5oW1QDIKTAiw
         jCQXNoBYFlWAPEMKLAz1Cb4X2bDIs539a8JSBMRbl9ivvbOu8oYOnKui8HFmjZilSFhX
         /QQhsXsLrXnkJhSS0xKjfzVk/wHdZrASjH3qiv/rdYhz1+kY2nzfDxGfhjp+FWD4QJOh
         Vf69siAQutB+oBtFKfgr7zgeeA1I8PWc/VgnMB6FClcNrHGtIEBAJv0+l06K6UDJIKbi
         5qFNWHSaerZm1wHBAETZpH563W6waej5EeG6M1yw0izkOIzGLcogb/436hjyLMTfWhNx
         +R3A==
X-Gm-Message-State: AOJu0Yy3ZGpD0v64CIXSI03IdSJEqGjvD6a+I17aY12lMfoci7H0NBoD
	yU41I/5ss8CP3YywB5NtDwMcli8rJjqHScUF0eEdhBn6isKFHfjtM7ECkXYxqyZQ
X-Gm-Gg: AfdE7cmCVGss5y88vLT2oy6n5KRJn0J2k+P3P1n4rbjVZ5yFhR9Yz3Vz/7fJwZIQfey
	EYqipDu7R300om+n96HW4XGO+3VdMY3kPBCqRCCjrfe8D8CNuTLCpDWx5NJiljQuzY76k/9A1pK
	Apwps3qDFWw1Iu+aFglKb7gIBMJfdposOgz5I/q7ut9tCI8KT51Dx77Bk4jmA7nL449gT4hKsAs
	KNI5Yh2Oul6GRMKq6B8dBKOico9FWp2EwJUksKbGeNldf8+RLOpTvCp9w+gW3cH/PHn2QEODa6j
	INRNHmWe0nAxQ0xKE1aG9HjIlC5zi2Et8w5HsDd/WYkNNbJRK/weuiV5RO1LlK4wlqXkffcWWEy
	N1Zzoq0xN+Xf+9Jo9QVlfnPhRlGueE3zFogzWIrSc26hhD18vO7sQf0RMcxU+bn8ZrcuydJRrGH
	f7xtMegcoG5iNk6FS9F4b+dZgEkBl5xJC6B1ctUnAzRc/1nyfTO132nqzs0zK8m/TIYY7+UrvYj
	DPaXPoB0nhppQuQF8BeR7Ch/ddI3vxztbQIhB+uM/4=
X-Received: by 2002:a05:620a:44d4:b0:92e:e728:9d03 with SMTP id af79cd13be357-92ef3cc8072mr428999985a.6.1783829365498;
        Sat, 11 Jul 2026 21:09:25 -0700 (PDT)
Received: from ip-172-31-15-253.ec2.internal (ec2-44-200-214-82.compute-1.amazonaws.com. [44.200.214.82])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf9d9bsm687147085a.28.2026.07.11.21.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 21:09:24 -0700 (PDT)
From: Deep Shah <deepshah146@gmail.com>
To: netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Deep Shah <deepshah146@gmail.com>
Subject: [PATCH net 2/2] selftests: ptp: add a regression test for the frequency adjustment overflow
Date: Sun, 12 Jul 2026 04:09:22 +0000
Message-ID: <20260712040922.6403-3-deepshah146@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260712040922.6403-1-deepshah146@gmail.com>
References: <20260712040922.6403-1-deepshah146@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-306923-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:richardcochran@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:linux-kernel@vger.kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:deepshah146@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,davemloft.net,kernel.org,redhat.com,google.com,lunn.ch];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[deepshah146@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deepshah146@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,phc.sh:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83FAF743C8D

testptp's -f option stores the requested adjustment as an int ppb and
converts it to scaled ppm, so it cannot express the 64-bit scaled-ppm
values needed to overflow scaled_ppm_to_ppb() and bypass the max_adj
check enforced by ptp_clock_adjtime().

Add a small test that crafts struct timex.freq directly and verifies that
an overflowing frequency adjustment is rejected with -ERANGE.  The test
skips when no frequency-adjustable PTP device is available.

Signed-off-by: Deep Shah <deepshah146@gmail.com>
---
 tools/testing/selftests/ptp/Makefile          |  2 +-
 .../testing/selftests/ptp/ptp_freq_overflow.c | 74 +++++++++++++++++++
 2 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ptp/ptp_freq_overflow.c

diff --git a/tools/testing/selftests/ptp/Makefile b/tools/testing/selftests/ptp/Makefile
index 8f57f88ecadd..dd7376cc9bf5 100644
--- a/tools/testing/selftests/ptp/Makefile
+++ b/tools/testing/selftests/ptp/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := testptp
+TEST_GEN_PROGS := testptp ptp_freq_overflow
 LDLIBS += -lrt
 TEST_PROGS = phc.sh
 
diff --git a/tools/testing/selftests/ptp/ptp_freq_overflow.c b/tools/testing/selftests/ptp/ptp_freq_overflow.c
new file mode 100644
index 000000000000..342b22689f67
--- /dev/null
+++ b/tools/testing/selftests/ptp/ptp_freq_overflow.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Regression test for the scaled_ppm_to_ppb() integer overflow that allowed
+ * a crafted clock_adjtime(ADJ_FREQUENCY) to bypass the PTP max_adj check.
+ *
+ * testptp's -f option stores the adjustment as an int ppb and cannot express
+ * the 64-bit scaled-ppm values needed to overflow the conversion, so this
+ * test crafts struct timex.freq directly.
+ */
+#define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/timex.h>
+#include <time.h>
+#include <unistd.h>
+#include <linux/ptp_clock.h>
+#include "../kselftest.h"
+
+#define FD_TO_CLOCKID(fd)	((~(clockid_t)(fd) << 3) | 3)
+
+/* clock_adjtime is not available in GLIBC < 2.14 */
+#if !__GLIBC_PREREQ(2, 14)
+#include <sys/syscall.h>
+static int clock_adjtime(clockid_t id, struct timex *tx)
+{
+	return syscall(__NR_clock_adjtime, id, tx);
+}
+#endif
+
+int main(int argc, char *argv[])
+{
+	const char *device = argc > 1 ? argv[1] : "/dev/ptp0";
+	struct ptp_clock_caps caps;
+	struct timex tx = { 0 };
+	clockid_t clkid;
+	int fd, ret;
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	if (sizeof(tx.freq) < 8)
+		ksft_exit_skip("the overflow only affects 64-bit kernels\n");
+
+	fd = open(device, O_RDWR);
+	if (fd < 0)
+		ksft_exit_skip("cannot open %s: %s\n", device, strerror(errno));
+
+	clkid = FD_TO_CLOCKID(fd);
+
+	if (ioctl(fd, PTP_CLOCK_GETCAPS, &caps))
+		ksft_exit_skip("PTP_CLOCK_GETCAPS on %s: %s\n", device, strerror(errno));
+	if (!caps.max_adj)
+		ksft_exit_skip("%s does not support frequency adjustment\n", device);
+
+	/*
+	 * (1 + 147573952589676412) * 125 == 2^64 + 9, which overflows s64 in
+	 * scaled_ppm_to_ppb() and wraps the result to a ppb of 0.  A kernel
+	 * that does not detect the overflow lets this absurd frequency past
+	 * the max_adj check; a fixed kernel rejects it with -ERANGE.
+	 */
+	tx.modes = ADJ_FREQUENCY;
+	tx.freq = 147573952589676412LL;
+
+	ret = clock_adjtime(clkid, &tx);
+	ksft_test_result(ret < 0 && errno == ERANGE,
+			 "overflowing frequency adjustment is rejected (ret=%d errno=%d)\n",
+			 ret, ret < 0 ? errno : 0);
+
+	close(fd);
+	ksft_finished();
+}
-- 
2.43.0



Return-Path: <netdev+bounces-298724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C06pGog1LGrlNgQAu9opvQ
	(envelope-from <netdev+bounces-298724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:36:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D31FA67AFCF
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:36:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AkEG3AS4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298724-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298724-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43D593264ED1
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DD63E5EF1;
	Fri, 12 Jun 2026 16:28:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D643D2FEC
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 16:28:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281697; cv=none; b=YiY2+z6SLvwcDrNe3IpOujkgfvcjekIFDQl/muHExSAe7WbH/iLHhYgJgjWu60EN/TJO7HqxdFGihjR32V561/ElQ5TAKWPEeN3IBShjlCFNkHuRWmQxDIu0RK8YXpaVJ+swHwpkitSmk7SI925JVUWjuQ0Jxa9oHXyAUxevZuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281697; c=relaxed/simple;
	bh=0YU1HLiebluuOuSF+Qg1uHbj8fl9pwBoskv/oq3WwOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mddt1T1lWvB2Q+stII7TtVUNraMCIQIH3xzl4AW8BuMepMEnuFAN3m1TrV10ESed6SbVWB9xI/VEPWB0aNegS67oC88GNkA87zaSjVup3Rf30ydabUpScdSRH/nBiA+/L/KRBSTeuefw8ORoLkAkWiB15fY8wIcrnFuZQ1Gx5XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkEG3AS4; arc=none smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8423f52af13so946519b3a.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781281695; x=1781886495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3hx3iEvB3FQYubpdUTwVhz53gJdWPirEdfCXBfHIMU=;
        b=AkEG3AS46AGra2RXNruHXJOx0zIP10x91c0l3M4NwoFmowISm8T2B99zw5SW+YpoBN
         4KJGfaQVPNOnAHquKZs1EwvfAv7tGwZUTuCNPGfLh9BBNYBlat4zqzOUMjszVPkcBflE
         1WYtzEU/tl0iEcekEEN9AsJulcPCZ2pQMNKjZFWIUIh253bpPclBUqs5RI7KDriL4HfB
         iTHpSidrO3hVxd2IyqzMwN8vKtTSZIk7oDspoC5mey+eJrdgqkXHxbrmDgloMrphHX6V
         wZeqtMuFANJZHJiEUTvDB9iS5E/tx+hrE5HEyPyT7uTD9bWJByMUTrDbqOpwCxlaSLTX
         A59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781281695; x=1781886495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k3hx3iEvB3FQYubpdUTwVhz53gJdWPirEdfCXBfHIMU=;
        b=d2I917J6K5LnXY0TZA08rYv9YfC4sNmd5fe1A2ghYE5yY5s9oysOBxRNzcSQTEAAQg
         VMM15zpOdNVvU6ywWuLTrfnHym8IpNE73cirw1HDHz9HEepfUbcRw8rpGX3o65PrzA6w
         3rNsTlzHDgdwVki3NryZMj1Olz6kUMAzixVMc3PW9z2L6AiZ2nft8B7LrpwRQNn6aNWW
         UR/lz2YBiEH+D/thCLNgsRHznqnUAByKV/Kady4Dl0UDwoIN4BP+MfG9THT53EH8+fcY
         EYoar0H85xqjecBL7psrQ1AhyGro1383zWmpClpCAp4eBpvsCeOidJIZvwCEusDAnqmT
         d2pg==
X-Gm-Message-State: AOJu0YzXX8dv9KPu2WZTYT7nY9pD83EiJm05P/7ohLr/rY9ph9O5e21H
	hBHY22xk8s1pDhIcWpIjzu5zdO6eXHGkxItBMUWupn6OycOvau8pH0/5
X-Gm-Gg: Acq92OEpEy4hPYrc0PbQHUhkh9lJn2orabD3ayJ/RibYXsWxYYxbr39qAG7vnbZGwTu
	ExZEHYtrgF/4D7JVRoWzZa5JLPL8blf/4JPNoN4YBQnP40SSkNaanM4TmKLe3XFU/l8gPkLQVOq
	PuYpy1feCewXCfx9xZGCstmTMRfEP9s4r473X/Jw6w/wh50uyWdD6u5dZ9Ff2XLHvR34w4o2a9E
	QbmYjFSfJZmzfZrKbnRjSvJxNOT9Xk5eEG4USFtVeI0gALwTbXGtVnCz6sAM2y9PPi11NrujKq/
	cmWE7/E9ZOdSN4F6Kp2LbkZJOXJ11KClrx00rRWnfphU76gRqrGT2xKXirMZUIkhYqiB5AYEVYn
	JVcFJniE3e/8iLdQPlAmMcoX9m89l9b0Vl9sx+Iln197D+Xgr/imDisi1c42cGq/2Tc3vDJt767
	+63BVCZgRkv7d5mvWujMA=
X-Received: by 2002:a05:6a00:a220:b0:842:48ae:1d6c with SMTP id d2e1a72fcca58-844e1a28ea1mr391873b3a.24.1781281694728;
        Fri, 12 Jun 2026 09:28:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b03fd0bsm2690221b3a.50.2026.06.12.09.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:28:14 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 12 Jun 2026 09:25:59 -0700
Subject: [PATCH net-next v3 3/4] selftests/net: ncdevmem: add -b option to
 set rx-buf-size on bind
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-tcpdm-large-niovs-v3-3-a3b693e76fcb@meta.com>
References: <20260612-tcpdm-large-niovs-v3-0-a3b693e76fcb@meta.com>
In-Reply-To: <20260612-tcpdm-large-niovs-v3-0-a3b693e76fcb@meta.com>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org, 
 sdf@fomichev.me, razor@blackwall.org, daniel@iogearbox.net, 
 almasrymina@google.com, matttbe@kernel.org, skhawaja@google.com, 
 dw@davidwei.uk, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:kraxel@redhat.com,m:vivek.kasireddy@intel.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-media@vger.kernel.org,m:linaro-mm-sig@lists.linaro.org,m:linux-kselftest@vger.kernel.org,m:sdf@fomichev.me,m:razor@blackwall.org,m:daniel@iogearbox.net,m:almasrymina@google.com,m:matttbe@kernel.org,m:skhawaja@google.com,m:dw@davidwei.uk,m:bobbyeshleman@meta.com,m:donaldhunter@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c04:e001:36c::12fc:5321:from];
	FORGED_SENDER(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,intel.com,linaro.org,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298724-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[209.85.210.173:received,100.90.174.1:received,2a03:2880:ff:52:::received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,meta.com:mid,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D31FA67AFCF

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add -b <bytes> to request a non-default niov size via
NETDEV_A_DMABUF_RX_BUF_SIZE. When the value exceeds PAGE_SIZE,
udmabuf_alloc() switches to an MFD_HUGETLB-backed memfd so each 2 MB
hugepage produces one naturally-aligned sg entry.

Reject values > 2 MB up front: MFD_HUGETLB + udmabuf can only guarantee
2 MB per sg entry (one hugepage), so a larger rx_buf_size would fail the
per-sg length/alignment check.

Add CONFIG_HUGETLBFS=y to drivers/net/hw/config so the new path is
reachable in the CI kernels built for these tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/config     |  1 +
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 36 +++++++++++++++++++++--
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
index cd20024218cd..ed8642b68094 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -3,6 +3,7 @@ CONFIG_FAIL_FUNCTION=y
 CONFIG_FAULT_INJECTION=y
 CONFIG_FAULT_INJECTION_DEBUG_FS=y
 CONFIG_FUNCTION_ERROR_INJECTION=y
+CONFIG_HUGETLBFS=y
 CONFIG_INET6_ESP=y
 CONFIG_INET6_ESP_OFFLOAD=y
 CONFIG_INET_ESP=y
diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index d96e8a3b5a65..a16e55af51ee 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -40,6 +40,7 @@
 
 #include <linux/uio.h>
 #include <stdarg.h>
+#include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -61,6 +62,7 @@
 #include <sys/time.h>
 
 #include <linux/memfd.h>
+#include <sys/param.h>
 #include <linux/dma-buf.h>
 #include <linux/errqueue.h>
 #include <linux/udmabuf.h>
@@ -79,6 +81,7 @@
 #define PAGE_SHIFT 12
 #define TEST_PREFIX "ncdevmem"
 #define NUM_PAGES 16000
+#define MB(x) ((x) << 20)
 
 #ifndef MSG_SOCK_DEVMEM
 #define MSG_SOCK_DEVMEM 0x2000000
@@ -100,6 +103,7 @@ static unsigned int dmabuf_id;
 static uint32_t tx_dmabuf_id;
 static int waittime_ms = 500;
 static bool fail_on_linear;
+static uint32_t rx_buf_size;
 
 /* System state loaded by current_config_load() */
 #define MAX_FLOWS	8
@@ -142,6 +146,7 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 {
 	struct udmabuf_create create;
 	struct memory_buffer *ctx;
+	unsigned int memfd_flags;
 	int ret;
 
 	ctx = malloc(sizeof(*ctx));
@@ -156,9 +161,14 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 		goto err_free_ctx;
 	}
 
-	ctx->memfd = memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
+	memfd_flags = MFD_ALLOW_SEALING;
+	if (rx_buf_size > getpagesize())
+		memfd_flags |= MFD_HUGETLB | MFD_HUGE_2MB;
+
+	ctx->memfd = memfd_create("udmabuf-test", memfd_flags);
 	if (ctx->memfd < 0) {
-		pr_err("[skip,no-memfd]");
+		pr_err("[skip,no-memfd%s]",
+		       (memfd_flags & MFD_HUGETLB) ? " (need hugepages)" : "");
 		goto err_close_dev;
 	}
 
@@ -168,6 +178,11 @@ static struct memory_buffer *udmabuf_alloc(size_t size)
 		goto err_close_memfd;
 	}
 
+	if (memfd_flags & MFD_HUGETLB) {
+		size = roundup(size, MB(2));
+		ctx->size = size;
+	}
+
 	ret = ftruncate(ctx->memfd, size);
 	if (ret == -1) {
 		pr_err("[FAIL,memfd-truncate]");
@@ -699,6 +714,8 @@ static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
 	netdev_bind_rx_req_set_ifindex(req, ifindex);
 	netdev_bind_rx_req_set_fd(req, dmabuf_fd);
 	__netdev_bind_rx_req_set_queues(req, queues, n_queue_index);
+	if (rx_buf_size)
+		netdev_bind_rx_req_set_rx_buf_size(req, rx_buf_size);
 
 	rsp = netdev_bind_rx(*ys, req);
 	if (!rsp) {
@@ -1411,7 +1428,7 @@ int main(int argc, char *argv[])
 	int is_server = 0, opt;
 	int ret, err = 1;
 
-	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:n")) != -1) {
+	while ((opt = getopt(argc, argv, "Lls:c:p:v:q:t:f:z:nb:")) != -1) {
 		switch (opt) {
 		case 'L':
 			fail_on_linear = true;
@@ -1446,6 +1463,19 @@ int main(int argc, char *argv[])
 		case 'n':
 			skip_config = 1;
 			break;
+		case 'b': {
+			unsigned long val;
+
+			errno = 0;
+			val = strtoul(optarg, NULL, 0);
+			if ((val == ULONG_MAX && errno == ERANGE) ||
+			    val > UINT32_MAX) {
+				pr_err("invalid rx_buf_size: %s", optarg);
+				return 1;
+			}
+			rx_buf_size = val;
+			break;
+		}
 		case '?':
 			fprintf(stderr, "unknown option: %c\n", optopt);
 			break;

-- 
2.53.0-Meta



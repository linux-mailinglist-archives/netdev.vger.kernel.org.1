Return-Path: <netdev+bounces-276642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKGsEGSF1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:42:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC603BEFD3
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C069306E8C0
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420CB3D3013;
	Wed,  8 Apr 2026 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ccu7EuJ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="efPW6EZM"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4653D16E6
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666322; cv=none; b=rwiJUYy1OU0z2guAtLkRWbUwkl8wAHoS0sna165C7BLdygNymivwNFatetqpaX818dEe+w+JFdtvgCC9LRu4ryi1TLfnhGihs9ak0dgL5T1+QxHwOP4RreYiac8p8yxavw8hPPEx8GiiFbp8nytDm2NNil/5xJhOYPfNPwjzx8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666322; c=relaxed/simple;
	bh=Z3H+iIzNoijgKaKwknrMlaKfVtBcQBQJ4v/Z7kmns+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITQbuAtIS6wVM4vozSRAJGq1rhuATuuK+V4J+0RL7vsYzx6T3++blb4E3xfFOl2/zy6sv/C0GDsIlKBPqCjxwmAz69wF0k+pwFDaHrh0nKrMX7brOcUuXCcfWho4r6VfXat7+SNslCijDirt2Mgr7CtxbyRM2x9B7dAjksYnFCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ccu7EuJ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=efPW6EZM; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E23F81400144;
	Wed,  8 Apr 2026 12:38:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 08 Apr 2026 12:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775666319; x=
	1775752719; bh=B2LRgCzdhZvosd4jmMgsTPOeAAUkSnM/EgHJHDIAZWk=; b=c
	cu7EuJ730J1bekUgc2qpj7vIHZ1o8Nv2fHinGvW9QGlDlOUXhuxsJeQn/k8hNLvL
	6Qr0qt7o86Wg8bY+jHkEBGoHkbNZVuHes/B8rOaBUACXPGT6HZOqA6jmiTU3fbxH
	KWjszShmG/MHOJjNixXYaanOH/45SLSZka604pxInS+HpOMWF9gxtFWb3ZWO6j9R
	kaiCxO+AveG9xi2O5wHoniA8z9Qqh+ulVP3jbWcD/e1kfacnxDgdr3lt0QflA6+f
	Y4DnN1JXXaJsdlDo2Il1VPEGvHvIagPIOqxTIEml4Of+MI2Ar1RdufYanLMHPtnR
	0TuMNl4hcd44/WyLshXMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775666319; x=1775752719; bh=B
	2LRgCzdhZvosd4jmMgsTPOeAAUkSnM/EgHJHDIAZWk=; b=efPW6EZMquciUPUzs
	dm5grM+Yl9RmWZFDGcKvha0GRDkM95V5Z/8baOt+kOjXNrlpGUkRqz99GDX3SRyV
	bTzbhVxQTks4sCKzDezDFoNGLY70BkcwpKUi1WwnAl7hK5K1jvAPE7zp33TcH6H9
	3UrbVLeCRPn9klepPj72n6K/WCpjBvY0BKSJxh+n/EJxOB5bQP/Bg+7bMylsuFX5
	WsdcLITSKgeMM20+vG+5q13dmJEQGd0EbSgPt2sdOrnR6mr/QvZL3Mqqx9RLtvzF
	ZtYmUkBxparveIjrsOP3j8irYVRYpFg0aeCCBkUvvWo9E++3+s3Chjf7m1q11TGI
	fPZTw==
X-ME-Sender: <xms:j4TWafpWl9gqFh7VZepsPmaatN1o-dxROGTfHGGRU-Cpr0nJTaiiZg>
    <xme:j4TWafpDoAPHZ_dZ_Id_NOGlKx4Y4M6DFVchBaOcMnS0BznCBbB2YKasYlD7hzwBH
    AdsATXSkNOCC3oRGXcbVQlH7DR4kTAiSvpFoz0Z3lCyrvEYapA8IfY>
X-ME-Received: <xmr:j4TWaZ2DEDMKaDrrWLV-0BHS-XsIQy4I0xwIHOe0buGZMsPEsAdu-Ljqt_ar8oTGc1ANVxsSTOZPzZfkTOjuK-5O_nBczcM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhurghnlhhuucfjvghrrhgvrhhouceojhhurghnlhhusehfrghs
    thhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiieegudejfedvheehjedutd
    fgffekgffguedvhfehkedtvdekkeehkeefheevnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhhurghnlhhusehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhurghnlhhuse
    hfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:j4TWaeBg3TZLB7prtMSLCcnzHhaPQYR8LJrczOh4f-V-8M_tXV6T9w>
    <xmx:j4TWaRf9kbli1VBUrEr0kRhu-cs7rAxH072Z4jKzr0Izd1Gv6MFyoQ>
    <xmx:j4TWaThYVw3B4GCVvdZsLfCMN6uwgDvcFdwRfl_D1xhZ7QCOd1mNOA>
    <xmx:j4TWaZqSp-Y16L_oJ1QqonEtXZSx25-bEKyPoInU-1EjWzOMcF13mQ>
    <xmx:j4TWaTBq1Wa9lERHs2NcMm0brPOBeXdqtoV6H1dscLp4nyd8lL2QPL6D>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 12:38:39 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: netdev@vger.kernel.org
Cc: Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH 2/5] selftests: net: add multithread client support to iou-zcrx
Date: Wed,  8 Apr 2026 11:38:13 -0500
Message-ID: <20260408163816.2760-3-juanlu@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408163816.2760-1-juanlu@fastmail.com>
References: <20260408163816.2760-1-juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.com,none];
	R_DKIM_ALLOW(-0.20)[fastmail.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[fastmail.com];
	TAGGED_FROM(0.00)[bounces-276642-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juanlu@fastmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	FREEMAIL_FROM(0.00)[fastmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fastmail.com:dkim,fastmail.com:email,fastmail.com:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: ADC603BEFD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add pthreads to the iou-zcrx client so that multiple connections can be
established simultaneously. Each client thread connects to the server
and sends its payload independently.

Introduce struct thread_ctx and the -t option to control the number of
threads (default 1), preserving backwards compatibility with existing
tests.

Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |  2 +-
 .../selftests/drivers/net/hw/iou-zcrx.c       | 46 +++++++++++++++++--
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index deeca3f8d080..227adfec706c 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -80,5 +80,5 @@ include ../../../net/ynl.mk
 include ../../../net/bpf.mk
 
 ifeq ($(HAS_IOURING_ZCRX),y)
-$(OUTPUT)/iou-zcrx: LDLIBS += -luring
+$(OUTPUT)/iou-zcrx: LDLIBS += -luring -lpthread
 endif
diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 334985083f61..de2eea78a5b6 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -4,6 +4,7 @@
 #include <error.h>
 #include <fcntl.h>
 #include <limits.h>
+#include <pthread.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
@@ -85,8 +86,14 @@ static int cfg_send_size = SEND_SIZE;
 static struct sockaddr_in6 cfg_addr;
 static unsigned int cfg_rx_buf_len;
 static bool cfg_dry_run;
+static int cfg_num_threads = 1;
 
 static char *payload;
+
+struct thread_ctx {
+	int			thread_id;
+};
+
 static void *area_ptr;
 static void *ring_ptr;
 static size_t ring_size;
@@ -376,7 +383,7 @@ static void run_server(void)
 		error(1, 0, "test failed\n");
 }
 
-static void run_client(void)
+static void *client_worker(void *arg)
 {
 	ssize_t to_send = cfg_send_size;
 	ssize_t sent = 0;
@@ -402,12 +409,42 @@ static void run_client(void)
 	}
 
 	close(fd);
+	return NULL;
+}
+
+static void run_client(void)
+{
+	struct thread_ctx *ctxs;
+	pthread_t *threads;
+	int i, ret;
+
+	ctxs = calloc(cfg_num_threads, sizeof(*ctxs));
+	threads = calloc(cfg_num_threads, sizeof(*threads));
+	if (!ctxs || !threads)
+		error(1, 0, "calloc()");
+
+	for (i = 0; i < cfg_num_threads; i++)
+		ctxs[i].thread_id = i;
+
+	for (i = 0; i < cfg_num_threads; i++) {
+		ret = pthread_create(&threads[i], NULL, client_worker,
+				     &ctxs[i]);
+		if (ret)
+			error(1, ret, "pthread_create()");
+	}
+
+	for (i = 0; i < cfg_num_threads; i++)
+		pthread_join(threads[i], NULL);
+
+	free(threads);
+	free(ctxs);
 }
 
 static void usage(const char *filepath)
 {
 	error(1, 0, "Usage: %s (-4|-6) (-s|-c) -h<server_ip> -p<port> "
-		    "-l<payload_size> -i<ifname> -q<rxq_id>", filepath);
+		    "-l<payload_size> -i<ifname> -q<rxq_id> -t<num_threads>",
+		    filepath);
 }
 
 static void parse_opts(int argc, char **argv)
@@ -425,7 +462,7 @@ static void parse_opts(int argc, char **argv)
 		usage(argv[0]);
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:d")) != -1) {
+	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:dt:")) != -1) {
 		switch (c) {
 		case 's':
 			if (cfg_client)
@@ -466,6 +503,9 @@ static void parse_opts(int argc, char **argv)
 		case 'd':
 			cfg_dry_run = true;
 			break;
+		case 't':
+			cfg_num_threads = strtoul(optarg, NULL, 0);
+			break;
 		}
 	}
 
-- 
2.53.0



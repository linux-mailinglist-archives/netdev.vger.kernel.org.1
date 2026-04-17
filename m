Return-Path: <netdev+bounces-279375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGqNAeBl4mlm5gAAu9opvQ
	(envelope-from <netdev+bounces-279375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:54:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D2E41D5BF
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B4DA301700D
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51352343D7B;
	Fri, 17 Apr 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DJG6i+Ub";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uH/qYmhY"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA4E35DA6E
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776444621; cv=none; b=P6lzLge4AGX/+7IycQLDQlrbIc86Y2j3wzccmfx1LVX1UHTTp06kFtE2guMb7umaxmU1KgsY6oz0qS7NWu2eFOHXTgy1dkT5w50mvpCMP8X6sA2az7tKG29AY7L/uvDf64KaFgrM8Be3P79VHCsmiA6CPHQtWYvOdTFwfn3Oymw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776444621; c=relaxed/simple;
	bh=8amysLJjrpuWbuE85q+zS+tBKpcB5d16wrW9xpmwiJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpJ0BqRvffR6vEnZl/9DFkgR0zK5Ju/Oh5IWlMxF3HrF/8WEoT8Kly6xmeouaqxJyncxesEvsOq1UV6mjxeZMfkzuunhwbE0PVhVoFV9VqIpR7uuCyQZtNipg+b4r9Amqpv70wmIxuXVA+BCsZJB2WkwxKh+eFyEx9V3DRcidD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DJG6i+Ub; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uH/qYmhY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4AF457A01F0;
	Fri, 17 Apr 2026 12:50:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 17 Apr 2026 12:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1776444619; x=
	1776531019; bh=FZYh4N4FiRtenh/U53K1jQMn3Ejzph+zclEc8UXrQGE=; b=D
	JG6i+UbRsM6aFkh2V0sgsXUrQ0hn38YE/hMIF67ucR6L5B7Gc4r6vF03Masi4lSk
	iOuGH2Z1IZ9c4MArqbQ8tyt8nUY1SI87QpXR+My16JwAzuApdxtrA2LthiKr8rwS
	IGEbmCU10d9joBpivPN91s67hbpEdVvYhdjIpFVRFCbeHp/EfWDLenbQ/oOHOBpk
	HBo169HuhGM7aeZkWWcUlNtq1O3/1f1Qh5YdHjJh7pT6p68u6HH7rIAiHWWnKE1H
	42hNM0XgHB70Qsp7LUKm3dc2lw0FVVauKkAxuaA0RE8Y7Xff/XzTyfxvtNC+WJHe
	3SIfkZexozBLPOHjOVxkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1776444619; x=1776531019; bh=F
	ZYh4N4FiRtenh/U53K1jQMn3Ejzph+zclEc8UXrQGE=; b=uH/qYmhYQ98AqvMJb
	c4W7GxEgbsA1ig38psgdf5FQ9sU8sMW/cevGHQ9pxzy99ll3yXBjLnQryl5ORLXk
	tUp+FLwNJcsR4fHOeUR5fzZb2s9dNPfWKEbFbjUryM+MM4DU4+Xf6XOTSCmd35J5
	u81M4PaFESe4QwjLOunNiFIqZkuy338zf+kmzWfUuaH0X9Xq8zhkDYJANjLa2a92
	jPql2uuaClDglW/9HezVeL3FQUaQP4hyGF4Y6Ne8gvxkwoCiPjsrzdZd7MMwSnPM
	wFWXz84OgFi0FuTZX4I1GC2MByOVn8I1YfDfZM+oZV66OaSkqhny6MYKv+F1vPKO
	pMv9g==
X-ME-Sender: <xms:y2TiaQkV8y-MRHcoMhYuC76yCUI6p5ZUqFlwbWMFgN68ulVLN7Kjzw>
    <xme:y2TiaW3L4GRfyQIt8NgCQ_U-rRPpxbD8xy_4e7ekl7ZAbPkim9qn4gUDLTbGtJ7J4
    3NPdUT07zAo_2qJNyunWL9Fi0_qPQftoOF3XfW3LUjLFOI7GdfBmA>
X-ME-Received: <xmr:y2TiaTqZ4GbYtu0vRuBlW1-_FdP0wPiI0TX0k3rPVNA44UHmxsEvwPioqFIN819UhXuUxHUUA6F4S2OPBY8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehtdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhurghnlhhuucfjvghrrhgvrhhouceojhhurghnlhhusehfrghs
    thhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiieegudejfedvheehjedutd
    fgffekgffguedvhfehkedtvdekkeehkeefheevnecuvehluhhsthgvrhfuihiivgepuden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhhurghnlhhusehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepugif
    segurghvihgufigvihdruhhkpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjuhgrnhhluhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:y2Tiabdn4_2Vz-9UM73itqjVl9TrRlaoiL5dzUj_VtGmHFIVqvPpKA>
    <xmx:y2TiaarI9mQ-QrFRBZpkIMuDMdCBi2CncC3BjrVBOfw1pvgWEm8APw>
    <xmx:y2TiaUF6qmxs4nDLOa3c2stUJb7CX0rYgCuFxoz00foV6rgV4OY0EA>
    <xmx:y2TiaSuHQwj9-DDGeRmvFGla1Sg7kYeJjNa4YnPOm3keBaQIxgP_6A>
    <xmx:y2TiafbF1BfHVxTmlZOYTjsuMkKWgEmOLnPD873U6XU5HvYzjvnomsNb>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 12:50:18 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: dw@davidwei.uk,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH v2 4/6] selftests: net: add multithread client support to iou-zcrx
Date: Fri, 17 Apr 2026 09:49:50 -0700
Message-ID: <c70c641a0120e799b7978cb39f3c6c75a4dcc66b.1776444379.git.juanlu@fastmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1776444379.git.juanlu@fastmail.com>
References: <20260408163816.2760-1-juanlu@fastmail.com> <cover.1776444379.git.juanlu@fastmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,fastmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279375-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juanlu@fastmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[fastmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.com:email,fastmail.com:dkim,fastmail.com:mid]
X-Rspamd-Queue-Id: 80D2E41D5BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add pthreads to the iou-zcrx client so that multiple connections can be
established simultaneously. Each client thread connects to the server
and sends its payload independently.

Introduce the -t option to control the number of threads (default 1),
preserving backwards compatibility with existing tests.

Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |  2 +-
 .../selftests/drivers/net/hw/iou-zcrx.c       | 38 +++++++++++++++++--
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 85ca4d1ecf9ec..4f8c3d0b6acdb 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -83,5 +83,5 @@ include ../../../net/ynl.mk
 include ../../../net/bpf.mk
 
 ifeq ($(HAS_IOURING_ZCRX),y)
-$(OUTPUT)/iou-zcrx: LDLIBS += -luring
+$(OUTPUT)/iou-zcrx: LDLIBS += -luring -lpthread
 endif
diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 8dcb2f061f00a..6eb738ef4b5cc 100644
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
@@ -85,6 +86,7 @@ static int cfg_send_size = SEND_SIZE;
 static struct sockaddr_in6 cfg_addr;
 static unsigned int cfg_rx_buf_len;
 static bool cfg_dry_run;
+static int cfg_num_threads = 1;
 
 static char *payload;
 
@@ -379,7 +381,7 @@ static void run_server(void)
 		error(1, 0, "test failed\n");
 }
 
-static void run_client(void)
+static void *client_worker(void *arg)
 {
 	ssize_t to_send = cfg_send_size;
 	ssize_t sent = 0;
@@ -405,12 +407,39 @@ static void run_client(void)
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
@@ -428,7 +457,7 @@ static void parse_opts(int argc, char **argv)
 		usage(argv[0]);
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:d")) != -1) {
+	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:dt:")) != -1) {
 		switch (c) {
 		case 's':
 			if (cfg_client)
@@ -469,6 +498,9 @@ static void parse_opts(int argc, char **argv)
 		case 'd':
 			cfg_dry_run = true;
 			break;
+		case 't':
+			cfg_num_threads = strtoul(optarg, NULL, 0);
+			break;
 		}
 	}
 
-- 
2.52.0



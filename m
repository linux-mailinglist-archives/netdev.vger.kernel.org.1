Return-Path: <netdev+bounces-107047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB24591984B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 21:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3551F23D4C
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD8E1922DE;
	Wed, 26 Jun 2024 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LHN8wo1V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B8E18FC6B
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719430451; cv=none; b=bqy06O/DgULYE/m4vHpNYRW6qMG9OT4YmJph4I97GhHKVRhZwAX6tA39IuCnVdJarXn8weOqx/2e3g/bHwcrAdAfIbi94l+NdFbIH8Qjlqme3cO/FK5pioWJrS4ckM8Dtts53tcrWEOvWZAgrwrOKBPJJ7+G2VUyuhozZuTLo4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719430451; c=relaxed/simple;
	bh=UNwIgy0eaP1U/PjG+dxmb5r6nXFEuXCnnd8Z+VVWbpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KRFyRhHPQGaO4SOnABGsOI+sBQTgKiX2S/Sx9yVFdW9BQuaX6a8oKg9NY2tgzMn2C2UY+Lw+4oVcG+D8r2FQ1W/Ri7bS/ISxZY9rFwALbQD0xuQ+yJaQBx67yce9S6p+2WmCjLzZi/QCwbFmNmfC63edrfLUtxf8EQnzOLEU/vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LHN8wo1V; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-643efaf0786so39005337b3.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 12:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719430448; x=1720035248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pq1qBmFA90YYxxuCBnsZZeZJpNA0DQPz8KGklT3/y7Q=;
        b=LHN8wo1VcEHNEo69QA46DpLQIkA0Y/js1sdVcnyVP5S/qHk4vZnf9JEpXq+g+4M739
         QE5ddl2k8XejcA8vgnnlR/9aqMnj7d3xLI+VrM9gPxzlB/XvejZzxy24+lWXgHGNW4fy
         ZDukkDOpJQ8wDiDgTAyINieKIHnih+sDJKP9iv3wxIntsVEbSQWbosDyJkPeg+y6VcYa
         eLEtDouJdPrVbyx8W4oBGDlJp1t21L6oDmDqO+iIL+j/tGLiwh4Wula+A1AkkU6vuEvP
         8AZpjIf8xvExENBdAn357YTqfbjoUOylwTK09VtMtlbGLglho+e/r220k1gmINIfKd24
         MP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719430448; x=1720035248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pq1qBmFA90YYxxuCBnsZZeZJpNA0DQPz8KGklT3/y7Q=;
        b=XOYvBCbGpcJsL2HDKB0SypmfvbbSXpM+J+u95IuBS0ZERPyMEpEFVb4PXJOYd6GUt9
         EE6xY5z0fA8b69dZfW4CXmWzFsCpxLZXsS1eHnfJ2taXmGRY2piCr2uKvqP/oPWSYWHC
         x1d9Ig6hgQTkBEj2S1fLQC0uyNVk0pd8G4XLVDsgzS1JjLu1eW8V/eDy88zTvAjDOOm/
         A1psqPv9d6nUSYym5oTx3OZTmc470YKBi+jB2XFlVkbsrUjy6apyBf1zkNX5OZFcZmui
         9WdiPzGXVpWB8/gAbv5KzXed20xm1g770qUvnUcAulSe3H5Mma7jn8b7XKIMlcs5uRbP
         KZDA==
X-Gm-Message-State: AOJu0YzgE09AxeiVUjz5nJ5R9CDEMWKTJAdvTGFEBWV2dAvgm9C/Djfl
	cgOBPF9TiolljXlYmEN/QedpWTOzLmm1kqJbJO9ziku5ZJ+mfFaPbeupr7szueFRFBI8joe8DDy
	V
X-Google-Smtp-Source: AGHT+IHFauWbFT7DxMYusahgE5j/+KdBP0c4hHDoJtmihacmCcD9D8vHxir9r89/G2anNjZgxQcPpQ==
X-Received: by 2002:a05:690c:3747:b0:62c:dcb2:a75b with SMTP id 00721157ae682-64342d9ab69mr100195917b3.38.1719430448148;
        Wed, 26 Jun 2024 12:34:08 -0700 (PDT)
Received: from n191-036-066.byted.org ([130.44.212.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b53df48dedsm40112286d6.67.2024.06.26.12.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 12:34:07 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	willemdebruijn.kernel@gmail.com,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v6 1/4] selftests: fix OOM problem in msg_zerocopy selftest
Date: Wed, 26 Jun 2024 19:34:00 +0000
Message-Id: <20240626193403.3854451-2-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240626193403.3854451-1-zijianzhang@bytedance.com>
References: <20240626193403.3854451-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
on a socket with MSG_ZEROCOPY flag, and it will recv the notifications
until the socket is not writable. Typically, it will start the receiving
process after around 30+ sendmsgs. However, because of the
commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
the sender is always writable and does not get any chance to run recv
notifications. The selftest always exits with OUT_OF_MEMORY because the
memory used by opt_skb exceeds the core.sysctl_optmem_max.

According to our experiments, this problem can be mitigated by open the
DEBUG_LOCKDEP configuration for the kernel. But it will makes the
notifications disordered even in good commits before
commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale").

We introduce "cfg_notification_limit" to force sender to receive
notifications after some number of sendmsgs. And, notifications may not
come in order, because of the reason we present above. We have order
checking code managed by cfg_verbose.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 tools/testing/selftests/net/msg_zerocopy.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index bdc03a2097e8..7ea5fb28c93d 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -85,6 +85,7 @@ static bool cfg_rx;
 static int  cfg_runtime_ms	= 4200;
 static int  cfg_verbose;
 static int  cfg_waittime_ms	= 500;
+static int  cfg_notification_limit = 32;
 static bool cfg_zerocopy;
 
 static socklen_t cfg_alen;
@@ -95,6 +96,7 @@ static char payload[IP_MAXPACKET];
 static long packets, bytes, completions, expected_completions;
 static int  zerocopied = -1;
 static uint32_t next_completion;
+static uint32_t sends_since_notify;
 
 static unsigned long gettimeofday_ms(void)
 {
@@ -208,6 +210,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 		error(1, errno, "send");
 	if (cfg_verbose && ret != len)
 		fprintf(stderr, "send: ret=%u != %u\n", ret, len);
+	sends_since_notify++;
 
 	if (len) {
 		packets++;
@@ -435,7 +438,7 @@ static bool do_recv_completion(int fd, int domain)
 	/* Detect notification gaps. These should not happen often, if at all.
 	 * Gaps can occur due to drops, reordering and retransmissions.
 	 */
-	if (lo != next_completion)
+	if (cfg_verbose && lo != next_completion)
 		fprintf(stderr, "gap: %u..%u does not append to %u\n",
 			lo, hi, next_completion);
 	next_completion = hi + 1;
@@ -460,6 +463,7 @@ static bool do_recv_completion(int fd, int domain)
 static void do_recv_completions(int fd, int domain)
 {
 	while (do_recv_completion(fd, domain)) {}
+	sends_since_notify = 0;
 }
 
 /* Wait for all remaining completions on the errqueue */
@@ -549,6 +553,9 @@ static void do_tx(int domain, int type, int protocol)
 		else
 			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
 
+		if (cfg_zerocopy && sends_since_notify >= cfg_notification_limit)
+			do_recv_completions(fd, domain);
+
 		while (!do_poll(fd, POLLOUT)) {
 			if (cfg_zerocopy)
 				do_recv_completions(fd, domain);
@@ -708,7 +715,7 @@ static void parse_opts(int argc, char **argv)
 
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vz")) != -1) {
+	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -736,6 +743,9 @@ static void parse_opts(int argc, char **argv)
 			if (cfg_ifindex == 0)
 				error(1, errno, "invalid iface: %s", optarg);
 			break;
+		case 'l':
+			cfg_notification_limit = strtoul(optarg, NULL, 0);
+			break;
 		case 'm':
 			cfg_cork_mixed = true;
 			break;
-- 
2.20.1



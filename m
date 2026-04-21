Return-Path: <netdev+bounces-280172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGSTJ1WW52mp+AEAu9opvQ
	(envelope-from <netdev+bounces-280172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:23:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4558943CB08
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25DA7301F3DC
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A183D9020;
	Tue, 21 Apr 2026 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmfY3CBk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D63D903E
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784951; cv=none; b=Q0endDmNWP26GpcyNlTV7G0qdu/crTI/51SSA8PIGgi2slLUy69440oZCQRcmijJq7HCgaIrzVRXfc/tWf7wGKbg0apARH0Urv6nNO/x1Meo9zTbi3cP6V0BiCPEGwrm2eWo4tJvppbC04wdc/Eujd8iJJnyHUglP7OyGKzZsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784951; c=relaxed/simple;
	bh=H8bkG9DBL9Xfb/wm1zVD5wdpScJ3eI851mJ2Uf1xggk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpMTBmFloWG9/DRROZZ5een6HIpBCpb7IxhO+KwTsSpB6yXV9QvHjsmPXCirESvLBNZnJ3marBOj9Y3uWWVyVJ0VkMGMMN9jmJy4otfB5fOOm8UpTphvEoS/Z2e7egRpjH5j46q7CFXBrB8j6SkQgtH9tsd5U1Uh4CH+p8bQxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmfY3CBk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso15158345e9.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776784948; x=1777389748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApK1G5L+Mc6Cb2sCCSVe+Ii36gaQQarOC5kERgb3MHY=;
        b=FmfY3CBkmK4SE85NruZacF1rWPnX+oBK9hJXdzD13TuwB5Ibas1k4ooBI2Ja5dSTKA
         Ex7QSgMtCvKkWFs+TS8A8DK/MFPokk2S6UoB9jqeZRProBZsOJ7fObYZmpbZCvfMd8XZ
         ZW4ExZQ47h8O94Fs2eZxoDIeyvKDXhu7AQloV3WnM6h059ILzS0NA43gW/aiYBstbu5+
         SbjbM6mPo6P6edS8j3lZ9GCB8k6UqxvMGDhIjpFHKQNZEbmQcQrT6n1uEXMo55FoegeA
         8HosBOyOmcESSmsKaQRwsnCr+dWpC6vNE144rCIT4BPnJlTOtQ9dHbe7qnM5n1LLGjrH
         7Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776784948; x=1777389748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ApK1G5L+Mc6Cb2sCCSVe+Ii36gaQQarOC5kERgb3MHY=;
        b=JWuhXufmOLkpo1qm+NX8bXQqrFEkiUJC9vlDdX0CBcEkcT/2b1SLCtXq2xvNscSNeL
         2Cm3Yj2W69Fp15eawoCxN6mm67yx8RpZ+Zl9QfGPrfDoToa+13W1450wfb7tMRGmoSjl
         WaHcB5oVkSh2GcwJFVFjY7PPMzo/AFbNmizbMC+QMzMnDNmnVAm5xAXx91U63TBj6poR
         HqKxT5dgfc8BxglhiJjJDT2WnEPUh1fGAKBSyb1reI2tpPFzMCMSYkyGlH94/dnm0qyD
         iKwA0q8ndoyFs6S+hat2FpLbX9ksCjQ1/kGqk2la4bNe+G2gB9CIN8MyaEf2fGMW7PXq
         sd8Q==
X-Gm-Message-State: AOJu0Yx/NyRpUVXHyJ4ws4ebEYlMRpdllyc4YqNnvVljaCTHzCgh6D9Y
	8x2L8Byz5Uy4KfC2tPuGv0afdGM2Mq0d4TWsaNL1f1U3oB9gROBvTRyTt8cwvNvC
X-Gm-Gg: AeBDietokNrbtO3K7ZPyzV/g5CvH0dB1u/DEZPKs9mQLfOrQlgBsiv9SDdFOPWhYCpi
	Px3Pt+9UUgrK7Uq6/AQ9l7Q2i42VJFGALw5hWfGt7ZRZx+uSJUXAwhL1HecLH74LbgHkuXzZ9n7
	nQ9aFRPxfFl+AKFWRZKAXBSNtVedrKwaaxeVlde3VD3FznkTgcWjtp6QPoxHdPJTNjLqXj11BzX
	aqydMwU+waEP+F8fz6romB7Xs8AYUFBHeEuuvLyAlU1k8+HWLNlmoB7d0rku9rwkeHdcyy/qshe
	PwiIKAxmCWgEEczFU/it9gEjOur1HVvHDkIqK8vlhI2+A+Q84vTIeKT3KOyaxHUfUz4hDkhJzBs
	+OytPKQ5EGvAwmdxqBHcftTlz1unj67jCKcvxMzkdBRAg54zBsHhwxLFZplSXhFJMz8JMYiT3cw
	6iu+QKSzSb2ANrUOEhUOUQAiWTOgddKZrQol4OmMsTirdyvSIk6impn/gU780slt9RW/Hlzn0+S
	9IBesvjItwfFyzqpSMlCH+IF1QjUXbG
X-Received: by 2002:a05:600c:6296:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-488fb7923a9mr250841765e9.26.1776784947890;
        Tue, 21 Apr 2026 08:22:27 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4411c9f4f03sm8975225f8f.1.2026.04.21.08.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:22:27 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 3/3] selftests: mptcp: cover RECVERR and MSG_ERRQUEUE
Date: Tue, 21 Apr 2026 16:22:11 +0100
Message-ID: <20260421152216.38127-4-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421152216.38127-1-devnexen@gmail.com>
References: <20260421152216.38127-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-280172-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4558943CB08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add MPTCP selftest coverage for RECVERR sockopt round-trips and
parent-socket MSG_ERRQUEUE delivery.

Enable TX software timestamping, send data over an MPTCP socket, wait
for POLLERR, and verify that recvmsg(MSG_ERRQUEUE) returns timestamping
metadata on the MPTCP parent socket.

Signed-off-by: David Carlier <devnexen@gmail.com>
Assisted-by: Codex:gpt-5
---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 152 ++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index b6e58d936ebe..b499e7585d38 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -26,9 +26,17 @@
 
 #include <linux/tcp.h>
 #include <linux/compiler.h>
+#include <linux/errqueue.h>
+#include <linux/net_tstamp.h>
+
+#include <poll.h>
 
 static int pf = AF_INET;
 
+#ifndef SCM_TIMESTAMPING
+#define SCM_TIMESTAMPING SO_TIMESTAMPING
+#endif
+
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
 #endif
@@ -128,6 +136,9 @@ struct so_state {
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
+static void enable_tx_timestamping(int fd);
+static void test_msg_errqueue_timestamping(int fd);
+
 static void __noreturn die_perror(const char *msg)
 {
 	perror(msg);
@@ -598,6 +609,8 @@ static void connect_one_server(int fd, int pipefd)
 
 	assert(strncmp(buf2, "xmit", 4) == 0);
 
+	enable_tx_timestamping(fd);
+
 	ret = write(fd, buf, len);
 	if (ret < 0)
 		die_perror("write");
@@ -605,6 +618,8 @@ static void connect_one_server(int fd, int pipefd)
 	if (ret != (ssize_t)len)
 		xerror("short write");
 
+	test_msg_errqueue_timestamping(fd);
+
 	total = 0;
 	do {
 		ret = read(fd, buf2 + total, sizeof(buf2) - total);
@@ -769,6 +784,142 @@ static void test_ip_tos_sockopt(int fd)
 		xerror("expect socklen_t == -1");
 }
 
+static void test_ip_recverr_sockopt(int fd)
+{
+	struct iovec iov = {
+		.iov_base = &(char){ 0 },
+		.iov_len = 1,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	int one = 1, zero = 0, val = -1;
+	socklen_t s = sizeof(val);
+	int level, optname, r;
+
+	switch (pf) {
+	case AF_INET:
+		level = SOL_IP;
+		optname = IP_RECVERR;
+		break;
+	case AF_INET6:
+		level = SOL_IPV6;
+		optname = IPV6_RECVERR;
+		break;
+	default:
+		xerror("Unknown pf %d\n", pf);
+	}
+
+	r = setsockopt(fd, level, optname, &one, sizeof(one));
+	if (r)
+		die_perror("setsockopt recverr on");
+
+	r = getsockopt(fd, level, optname, &val, &s);
+	if (r)
+		die_perror("getsockopt recverr on");
+	if (s != sizeof(val) || val != one)
+		xerror("recverr on mismatch val=%d len=%u", val, s);
+
+	r = recvmsg(fd, &msg, MSG_ERRQUEUE | MSG_DONTWAIT);
+	if (r != -1 || errno != EAGAIN)
+		xerror("expected empty errqueue to return EAGAIN, ret=%d errno=%d", r, errno);
+
+	r = setsockopt(fd, level, optname, &zero, sizeof(zero));
+	if (r)
+		die_perror("setsockopt recverr off");
+
+	val = -1;
+	s = sizeof(val);
+	r = getsockopt(fd, level, optname, &val, &s);
+	if (r)
+		die_perror("getsockopt recverr off");
+	if (s != sizeof(val) || val != zero)
+		xerror("recverr off mismatch val=%d len=%u", val, s);
+}
+
+static void enable_tx_timestamping(int fd)
+{
+	int val = SOF_TIMESTAMPING_SOFTWARE |
+		  SOF_TIMESTAMPING_TX_SOFTWARE |
+		  SOF_TIMESTAMPING_OPT_TSONLY;
+	int ret;
+
+	ret = setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING_OLD,
+			 &val, sizeof(val));
+	if (ret)
+		die_perror("setsockopt SO_TIMESTAMPING");
+}
+
+static void test_msg_errqueue_timestamping(int fd)
+{
+	char ctrl[512] = { 0 };
+	char data[32] = { 0 };
+	struct iovec iov = {
+		.iov_base = data,
+		.iov_len = sizeof(data),
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = ctrl,
+		.msg_controllen = sizeof(ctrl),
+	};
+	struct pollfd pfd = {
+		.fd = fd,
+		.events = POLLERR,
+	};
+	struct cmsghdr *cm;
+	struct scm_timestamping *tss = NULL;
+	struct sock_extended_err *serr = NULL;
+	int ret, i;
+
+	for (i = 0; i < 10; i++) {
+		ret = poll(&pfd, 1, 1000);
+		if (ret < 0)
+			die_perror("poll errqueue");
+		if (ret == 0)
+			continue;
+		if (!(pfd.revents & POLLERR))
+			xerror("expected POLLERR, got revents %#x", pfd.revents);
+		break;
+	}
+
+	if (i == 10)
+		xerror("timed out waiting for MSG_ERRQUEUE event");
+
+	ret = recvmsg(fd, &msg, MSG_ERRQUEUE);
+	if (ret < 0)
+		die_perror("recvmsg timestamping errqueue");
+	if (!(msg.msg_flags & MSG_ERRQUEUE))
+		xerror("expected MSG_ERRQUEUE in msg_flags, got %#x",
+		       msg.msg_flags);
+
+	for (cm = CMSG_FIRSTHDR(&msg); cm; cm = CMSG_NXTHDR(&msg, cm)) {
+		if (cm->cmsg_level == SOL_SOCKET &&
+		    cm->cmsg_type == SCM_TIMESTAMPING)
+			tss = (void *)CMSG_DATA(cm);
+		if ((cm->cmsg_level == SOL_IP &&
+		     cm->cmsg_type == IP_RECVERR) ||
+		    (cm->cmsg_level == SOL_IPV6 &&
+		     cm->cmsg_type == IPV6_RECVERR))
+			serr = (void *)CMSG_DATA(cm);
+	}
+
+	if (!tss)
+		xerror("missing SCM_TIMESTAMPING cmsg");
+	if (!serr)
+		xerror("missing sock_extended_err cmsg");
+	if (serr->ee_errno != ENOMSG ||
+	    serr->ee_origin != SO_EE_ORIGIN_TIMESTAMPING)
+		xerror("unexpected timestamping err ee_errno=%u ee_origin=%u",
+		       serr->ee_errno, serr->ee_origin);
+	if (!tss->ts[0].tv_sec && !tss->ts[0].tv_nsec &&
+	    !tss->ts[1].tv_sec && !tss->ts[1].tv_nsec &&
+	    !tss->ts[2].tv_sec && !tss->ts[2].tv_nsec)
+		xerror("all timestamp slots are zero");
+}
+
 static int client(int pipefd)
 {
 	int fd = -1;
@@ -787,6 +938,7 @@ static int client(int pipefd)
 	}
 
 	test_ip_tos_sockopt(fd);
+	test_ip_recverr_sockopt(fd);
 
 	connect_one_server(fd, pipefd);
 
-- 
2.53.0



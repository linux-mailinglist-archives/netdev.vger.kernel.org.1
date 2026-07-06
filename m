Return-Path: <netdev+bounces-305051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p6KwFFHJS2r7aAEAu9opvQ
	(envelope-from <netdev+bounces-305051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:27:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6467712923
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:27:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jEsXgDPn;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305051-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305051-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21DB031DB455
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B509F376467;
	Mon,  6 Jul 2026 13:34:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB2374A19
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:34:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344885; cv=none; b=aQW4r0bBwkJQsbeEvfe47LqPmPSMHPIzxGG9fREcBN55cAI2xMWj4pI3Kt68Y7/74kiH894TiY8r9Ca6bIdrXcvSeXqy4a9BtfK21NfV1b71oKk+YACiEm085X9IkS+sluUjRYB4UMfDTpGE938oFrtOx/TZNRszRvFxNbHphhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344885; c=relaxed/simple;
	bh=RG1Oc2+h4RvsE1VUuJGB5j5rMAJzo32TLIP0Wf1uqSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+dAj+SkNhxdhIu7MLhkmCHOWzF32j1LcFDtDOHIxyoy4here4C/fNClnCS2zKWafurUk0aFmJNLLL74WzM9z2HdnQQY8Tk30gZBl7soIxdG4xS2egzFwwKjhyuHSTQ8RN0vk3EOjs9YcEktM6qoEqSNzfO0eJXgd2YBMje8H2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEsXgDPn; arc=none smtp.client-ip=209.85.128.171
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-806449d108aso43904357b3.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783344883; x=1783949683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42MY3X1dq8H9+cNScwMLFFGufs9GWDBHac7RPtiyTzA=;
        b=jEsXgDPn8eX27CdGZBikqweL1oP3h6gRwJXPZP9puUHGm04RSl0tbJrDBoY3C8/VgV
         hjR9n+6gVkaODMdkBM4m8xph9pVHvMnbXv2p/fDbyqM9v/l5v7HPjekiIQug55TFOJIg
         9+9Zr3ONTpYRZ0KDF5el1jDuKWcIhV5IbKz9/q2JKb9jJpENfmUORZ73yawfIkWIojdI
         kF6TbzGSf6nP2GMWe6nnxOnTSiHQMdrMazHE0eq4C4t5Z57egmwXCts72o93Mlw+lm5X
         hyUCqZuGr1j2a79qDqHKTwcYMKwxARxOHmT7LYlfn3qGU1aw3v5vTi5bmhyzA02oVL3Z
         0ILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344883; x=1783949683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=42MY3X1dq8H9+cNScwMLFFGufs9GWDBHac7RPtiyTzA=;
        b=ZxTArycVt4kyKqfKkNa43TVyh8DiY+6xBCv2pdp6GxZZ64SDVVdQPbdfs/iMTxXSsw
         ekLIj3SOiHQNqGQw0ramqPGRObKy4JUdq0t3ymjrI035fx7wS0iZmhUNUmGM/GnpwG+U
         qP2/el1kgM+U7nx+5djxp19zHaK8ze5R2tVzbmgYzeSKvH+I0MBYsdH0dF651EhAg3q3
         9yn413y5JpOPzdcXned1oT2DR4LwwNctzBSpbfdWC/toV9eqNS4Vh57M/QnZ7KB1kHH1
         KS28qt10kqIqPNTAHffIIFBKIb4UbrYZ9tRtTMNRaDtiFvFSJOI91NjjNw+ktqm02gDZ
         01zA==
X-Gm-Message-State: AOJu0Yw8zHEFtgyK/yYZ4cSr0fVw4suQplp6s9DQceuTXbwN4TpzwJWP
	QhQah3EAL8KLgHs7VjNu2bo1rahoHq8p+tBTOqX32OUi1LgMBfABdD40ah+/Sg==
X-Gm-Gg: AfdE7ckOvpgmbOnZKXjLGhEj/w0BU1XFw579g+CTEyxDNCgk1uS829NLWIPU05zi72K
	N0Ku+6xxRLa9UAsF3mYazQnXE0/uVeopPhfja40vbF05MfowBtIw2zenXWFcIhmgT6GQiugb2IK
	0qTjPUnkOpCLWLVA3K/7KeUiYySlj10GZQK+hSbbP+md6Cf0oVp4dy9kzCRO+vwuC8anCi6PKb6
	Vm62xY7D29pGabwMugbSuaHMzGwRl75G8PKCyN1x6lB1tbusz2YDl2G2VyoiUxN1fb2jY5vryik
	Jhl52cR63Gi5hhBZD+63ZngKx2LEvi5ZiJ922LNr/iUo+4SAXoHY4Ucuca0NHMOomwJ1pr0WV9H
	VkZlZAxyXxRx8Q19BvWZNo7GWWPuSIEJ5CMGOHsKl47QW7PcHJryJqBs65t4IjJEK/Ok8qmqlvZ
	2GnSXu2yixZy5U2qIN7uiahYV5rKqYMqIg01OEW3FOfyM2TnWgLhlTpHgaz7ZBydb5GD9j+19oa
	/ecWaY1Ys3BAzhnBWfjN67Prqw=
X-Received: by 2002:a05:690c:6b81:b0:80c:85e5:875d with SMTP id 00721157ae682-81be3bd31f4mr2071917b3.70.1783344882618;
        Mon, 06 Jul 2026 06:34:42 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144b537e3asm57002827b3.34.2026.07.06.06.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:34:42 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 5/7] selftests: drv-net: in so_txtime tell apart sw from hw pacing
Date: Mon,  6 Jul 2026 09:34:07 -0400
Message-ID: <20260706133433.3142805-6-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260706133433.3142805-1-willemdebruijn.kernel@gmail.com>
References: <20260706133433.3142805-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-305051-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew@lunn.ch,m:willemb@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6467712923

From: Willem de Bruijn <willemb@google.com>

Detect software pacing in so_txtime.c using SO_TIMESTAMPING.

If '-h' (hw) is passed

1. measure sw tx delay with SOF_TIMESTAMPING_TX_SOFTWARE, and
2. fail if delay exceeds a threshold, indicating pacing

Also reorder getopt parameters to make them alphabetical.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 .../testing/selftests/drivers/net/so_txtime.c | 81 ++++++++++++++++---
 1 file changed, 69 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index 7364ce2bec0b..5900ca97957c 100644
--- a/tools/testing/selftests/drivers/net/so_txtime.c
+++ b/tools/testing/selftests/drivers/net/so_txtime.c
@@ -42,8 +42,10 @@ static bool	cfg_machine_slow;
 static uint64_t	cfg_start_time_ns;
 static int	cfg_mark;
 static bool	cfg_rx;
+static bool	cfg_verify_hw_offload;
 
 static uint64_t glob_tstart;
+static uint64_t glob_tstart_real;
 static uint64_t tdeliver_max;
 
 static int errors;
@@ -191,12 +193,32 @@ static int do_recv_errqueue_timeout(struct sock_extended_err *err,
 	return 1;
 }
 
+static void do_recv_errqueue_timestamping(struct sock_extended_err *err,
+					  struct scm_timestamping *tss)
+{
+	int64_t ts;
+
+	ts = tss->ts[0].tv_sec;
+	ts *= 1000ULL * 1000 * 1000;
+	ts += tss->ts[0].tv_nsec;
+	ts -= glob_tstart_real;
+	ts /= 1000;
+
+	if (ts > cfg_variance_us) {
+		fprintf(stderr, "sw delay %" PRId64 "us exceeds bounds\n", ts);
+		if (!cfg_machine_slow)
+			errors++;
+	}
+}
+
 static int do_recv_errqueue(int fdt)
 {
 	char control[CMSG_SPACE(sizeof(struct sock_extended_err)) +
+		     CMSG_SPACE(sizeof(struct scm_timestamping)) +
 		     CMSG_SPACE(sizeof(struct sockaddr_in6))] = {0};
 	char data[sizeof(struct ethhdr) + sizeof(struct ipv6hdr) +
 		  sizeof(struct udphdr) + 1];
+	struct scm_timestamping *tss;
 	struct sock_extended_err *err;
 	int ret, num_tstamp = 0;
 	struct msghdr msg = {0};
@@ -222,16 +244,30 @@ static int do_recv_errqueue(int fdt)
 			error(1, 0, "errqueue: flags 0x%x\n", msg.msg_flags);
 
 		cm = CMSG_FIRSTHDR(&msg);
+		tss = NULL;
+
+		if (cm->cmsg_level == SOL_SOCKET &&
+		    cm->cmsg_type == SCM_TIMESTAMPING) {
+			tss = (void *)CMSG_DATA(cm);
+			cm = CMSG_NXTHDR(&msg, cm);
+			if (!cm)
+				error(1, 0, "timestamp missing ip err\n");
+		}
+
 		if (cm->cmsg_level != cfg_errq_level ||
 		    cm->cmsg_type != cfg_errq_type)
 			error(1, 0, "errqueue: type 0x%x.0x%x\n",
 				    cm->cmsg_level, cm->cmsg_type);
 
 		err = (struct sock_extended_err *)CMSG_DATA(cm);
-		if (err->ee_origin != SO_EE_ORIGIN_TXTIME)
+		if (err->ee_origin == SO_EE_ORIGIN_TXTIME)
+			num_tstamp += do_recv_errqueue_timeout(err,
+							       data[ret - 1]);
+		else if (err->ee_origin == SO_EE_ORIGIN_TIMESTAMPING && tss)
+			do_recv_errqueue_timestamping(err, tss);
+		else
 			error(1, 0, "errqueue: origin 0x%x\n", err->ee_origin);
 
-		num_tstamp += do_recv_errqueue_timeout(err, data[ret - 1]);
 		msg.msg_flags = 0;
 		msg.msg_controllen = sizeof(control);
 	}
@@ -256,7 +292,8 @@ static void recv_errqueue_msgs(int fdt)
 		if (num_tstamp == cfg_num_pkt)
 			break;
 
-	} while (gettime_ns(cfg_clockid) < tdeliver_max);
+	} while (gettime_ns(cfg_clockid) <
+		 tdeliver_max + (cfg_variance_us * 1000));
 }
 
 static void start_time_wait(void)
@@ -301,6 +338,18 @@ static void setsockopt_txtime(int fd)
 		error(1, 0, "getsockopt txtime: mismatch");
 }
 
+static void setsockopt_txtimestamping(int fd)
+{
+	int val = SOF_TIMESTAMPING_TX_SOFTWARE |
+		  SOF_TIMESTAMPING_SOFTWARE |
+		  SOF_TIMESTAMPING_OPT_ID |
+		  SOF_TIMESTAMPING_OPT_TSONLY;
+
+	if (setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING,
+		       &val, sizeof(val)))
+		error(1, errno, "setsockopt timestamping");
+}
+
 static int setup_tx(struct sockaddr *addr, socklen_t alen)
 {
 	int fd;
@@ -314,6 +363,9 @@ static int setup_tx(struct sockaddr *addr, socklen_t alen)
 
 	setsockopt_txtime(fd);
 
+	if (cfg_verify_hw_offload)
+		setsockopt_txtimestamping(fd);
+
 	if (cfg_mark &&
 	    setsockopt(fd, SOL_SOCKET, SO_MARK, &cfg_mark, sizeof(cfg_mark)))
 		error(1, errno, "setsockopt mark");
@@ -354,6 +406,7 @@ static void do_test_tx(struct sockaddr *addr, socklen_t alen)
 
 	start_time_wait();
 	glob_tstart = gettime_ns(cfg_clockid);
+	glob_tstart_real = gettime_ns(CLOCK_REALTIME);
 
 	for (i = 0; i < cfg_num_pkt; i++)
 		do_send_one(fdt, &cfg_buf[i]);
@@ -446,10 +499,11 @@ static void usage(const char *progname)
 			"  -6            only IPv6\n"
 			"  -c <clock>    monotonic or tai (default)\n"
 			"  -D <addr>     destination IP address (server)\n"
-			"  -S <addr>     source IP address (client)\n"
+			"  -h            verify hardware offload (tx)\n"
+			"  -m <mark>     socket mark\n"
 			"  -r            run rx mode\n"
+			"  -S <addr>     source IP address (client)\n"
 			"  -t <nsec>     start time (UTC nanoseconds)\n"
-			"  -m <mark>     socket mark\n"
 			"\n",
 			progname);
 	exit(1);
@@ -461,7 +515,7 @@ static void parse_opts(int argc, char **argv)
 	int domain = PF_UNSPEC;
 	int c;
 
-	while ((c = getopt(argc, argv, "46c:S:D:rt:m:")) != -1) {
+	while ((c = getopt(argc, argv, "46c:D:hm:rS:t:")) != -1) {
 		switch (c) {
 		case '4':
 			if (domain != PF_UNSPEC)
@@ -488,21 +542,24 @@ static void parse_opts(int argc, char **argv)
 			else
 				error(1, 0, "unknown clock id %s", optarg);
 			break;
-		case 'S':
-			saddr = optarg;
-			break;
 		case 'D':
 			daddr = optarg;
 			break;
+		case 'h':
+			cfg_verify_hw_offload = true;
+			break;
+		case 'm':
+			cfg_mark = strtol(optarg, NULL, 0);
+			break;
 		case 'r':
 			cfg_rx = true;
 			break;
+		case 'S':
+			saddr = optarg;
+			break;
 		case 't':
 			cfg_start_time_ns = strtoll(optarg, NULL, 0);
 			break;
-		case 'm':
-			cfg_mark = strtol(optarg, NULL, 0);
-			break;
 		default:
 			usage(argv[0]);
 		}
-- 
2.55.0.795.g602f6c329a-goog



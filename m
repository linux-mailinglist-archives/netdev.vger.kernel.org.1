Return-Path: <netdev+bounces-257686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHz2D8WVhmkUPAQAu9opvQ
	(envelope-from <netdev+bounces-257686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 02:30:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABD4104846
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 02:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB4E23040AAE
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 01:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3185E29B766;
	Sat,  7 Feb 2026 01:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etfkEqN9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1829827E
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 01:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770427821; cv=none; b=Y40RdVM5Lw+8zk2hL+pJn5OCwFlKdWwmYi2HC/TO7EI8cbKxSH6HV0GqbFq5On+k4pI/JzWbaOzL17WH9/dvHSgNq/GE14xkPftNZ6hRxrbYh5ylDq0y/fqFFM0QVsq9EyiL0tJIjjFZmUeiwE6ttyTGZv7KgLtf8TulEalZnYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770427821; c=relaxed/simple;
	bh=A+ftBd2Jtc29Pgy/SA6btDqagDLkGK8wLmvgN28yyX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KCyjm8SXyA/YcUkfGDW9fvQ3ipfk8yqn65t9VyVQd4MTTxMabOLVJKgjqOqfdm7t8T3PLW7k15LGKU76BuFHzzXDKcMPRmtVHcINEYjHm8/XV4jsu+b7+8O3V8R4YVv1GRHvUt2TmOVNFJqxVodyRGEuFypcf1qkI8UNULOVf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etfkEqN9; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7cfd8ca8191so488014a34.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 17:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770427820; x=1771032620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rYNkIW0UP5hKW4DkRpPD0FYrX4D16Qtz0FKf0quRohI=;
        b=etfkEqN9XhIZXROyBZwH+SizgI6DKLVx94R/ldgfJT3lQjlDTgdYDMTSXMiHxEGAsV
         rsKl7bvvxChBuRC216JqWOrvUCLisIrggwuaGcYOkInhV+TdEeg19Jq8V4lM6yG3iuIQ
         C5fngSQyXovVmnIpaADbj55+oKmDJZMr202n12yJIBDf95ma5pxX5cxyPOEC4Xb0Fx4V
         +gbs2uYeEbh08d9BHiFf0+hujdtQ0+ldFu9XRNWf9WzPIIA4SMTz3U6FgqPlbOVx6YdW
         JOuNTzD8DdDjVzaWv0OoWrm7SCoVf0MCLCnHfzgQCNWG3Wfzl3wqcBPKh00/bAFIT88n
         pp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770427820; x=1771032620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYNkIW0UP5hKW4DkRpPD0FYrX4D16Qtz0FKf0quRohI=;
        b=Tx8hDa9duL1kZpQ56Rc9yiM/Nd8h4JHMoSitTOZ3SNlyUdB3FDoEYDauCx6eWRufLb
         WqAxDO3hk+Guv1JmrYQIb928HkPRpEGYoMt633SRy4G9su/PBFJgemU5eWaRxKgp0GYl
         6JOs9IRlqsv6e+O1hd4q3M9gCtHGSoHZJGd7CSqoRYI0pJKGW5MA45p+KpPUuMNd3+dO
         e1y5CWNAlamNnzfIYJNjOUr65fbIGJ9TW1k3cPDIL9qf0iYX+d8RoJW3kDGkuh6kvdcW
         UU1qEiIdm6sp9wdSmE/wxqICY5pxbkNC4dHAA8sD+BxMXYUWKs/zKtd+D01UtoxaHt+f
         o3VA==
X-Forwarded-Encrypted: i=1; AJvYcCVdcamzVcFJLkeC+6S2s8R4hrxtlgaj0aExJu4T2Vkpq82GDOCVXs/PLCOls0LER8W4/FDxtT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgAXFZBs3166G48FFeyNottcXb+raJyx2toioWPcyy4HYu9ySp
	NqERLD57TRV9x0jmHyvSe8n1+zAag5f6g/V72RLu756/B2oaWBJ3GsCD
X-Gm-Gg: AZuq6aLYXqEKQJqDa7IVmlzI/SGLhmG9Be1DYj8J+Unba8DcqvbpP9ObWb3Ix9+Dy+2
	gcq5JkoxeziHczMgqlhqEmFi+XU4CpChclpCymbrRXHew6BgpI8/JzoEo0yT3S5cEQ9K/Lhz2Xm
	xeub6tSEIeX5E/lzhQfwtUPj2vUny3BbZS1EZ5v57tV/hu4vAZfQtmgU57v5GrizC+4qY8m0Vgv
	xq+aGpDNtm9oMBe178baSCd5YWIZwPJAtYjjnGJSxmtbzGRPfrRD/QSXvOUeogQmF2Gfr5k+EeZ
	gpVCsHJV+MaNMUWEtyTxPxsq+iPrBimzDUISIser5MWDmLODOunmLbhBtcRbbIQBTrnFh5/BEoN
	ESilBvDF73NJ4nlPKKrWXWrA8P8tF9WBPmNgAztBAgdJiHux4hWjglMQiWrNvhSW2xfPMLlBR+0
	QxcdsrxyBufPMvfHO8
X-Received: by 2002:a05:6830:2b0e:b0:7cf:c485:be43 with SMTP id 46e09a7af769-7d4643e7eddmr2341449a34.7.1770427819735;
        Fri, 06 Feb 2026 17:30:19 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d46470da04sm2765988a34.7.2026.02.06.17.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:30:19 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Willem de Bruijn <willemb@google.com>,
	Petr Machata <petrm@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drivers: net: hw: Modify toeplitz.c to poll for packets
Date: Fri,  6 Feb 2026 17:30:18 -0800
Message-ID: <20260207013018.551347-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257686-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9ABD4104846
X-Rspamd-Action: no action

Prior to this the receiver would sleep for the configured timeout,
then attempt to receive as many packets as possible. This would result
in a large burst of packets, and we don't necessarily need that many samples.

The tests now run faster.

Before

 ok 12 toeplitz.test.rps_udp_ipv6
 # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0

 real	0m54.792s
 user	0m12.486s
 sys	0m10.887s

After

 ok 12 toeplitz.test.rps_udp_ipv6
 # Totals: pass:12 fail:0 xfail:0 xpass:0 skip:0 error:0

 real	0m36.892s
 user	0m4.203s
 sys	0m8.314s

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
---
 .../selftests/drivers/net/hw/toeplitz.c       | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.c b/tools/testing/selftests/drivers/net/hw/toeplitz.c
index cd4bf58a44ee..315e353dafab 100644
--- a/tools/testing/selftests/drivers/net/hw/toeplitz.c
+++ b/tools/testing/selftests/drivers/net/hw/toeplitz.c
@@ -72,6 +72,8 @@
 
 #define RPS_MAX_CPUS 16UL	/* must be a power of 2 */
 
+#define MIN_PKT_SAMPLES 40 	/* minimum number of packets to receive */
+
 /* configuration options (cmdline arguments) */
 static uint16_t cfg_dport =	8000;
 static int cfg_family =		AF_INET6;
@@ -251,15 +253,30 @@ static bool recv_block(struct ring_state *ring)
 	return true;
 }
 
-/* simple test: sleep once unconditionally and then process all rings */
+/* simple test: process all rings until MIN_PKT_SAMPLES packets are received,
+ * or the test times out. */
 static void process_rings(void)
 {
+	struct timeval start, now;
+	bool pkts_found = true;
+	long elapsed_usec;
 	int i;
 
-	usleep(1000 * cfg_timeout_msec);
+	gettimeofday(&start, NULL);
 
-	for (i = 0; i < num_cpus; i++)
-		do {} while (recv_block(&rings[i]));
+	do {
+		if (!pkts_found)
+			usleep(100);
+
+		pkts_found = false;
+		for (i = 0; i < num_cpus; i++)
+			pkts_found |= recv_block(&rings[i]);
+
+		gettimeofday(&now, NULL);
+		elapsed_usec = (now.tv_sec - start.tv_sec) * 1000000 +
+			       (now.tv_usec - start.tv_usec);
+	} while (frames_received - frames_nohash < MIN_PKT_SAMPLES &&
+		 elapsed_usec < cfg_timeout_msec * 1000);
 
 	fprintf(stderr, "count: pass=%u nohash=%u fail=%u\n",
 		frames_received - frames_nohash - frames_error,
-- 
2.47.3



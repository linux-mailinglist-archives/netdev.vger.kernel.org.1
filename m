Return-Path: <netdev+bounces-305050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lFuQAk3FS2oBaAEAu9opvQ
	(envelope-from <netdev+bounces-305050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:10:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62094712669
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 17:10:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=slsEbNop;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305050-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305050-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5AC931D2F91
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546D3374E42;
	Mon,  6 Jul 2026 13:34:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31CD33A9E9
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:34:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344884; cv=none; b=p3TotanEuDwpjnoYkCeOe4YFxtuO15+L1F1Zk8D85Vf/ZdYFlG/lP8TpWc5IkxzR7v38HcBbWGbXlVYibEJLrw7arIndqLJD3eFM27Oioh4Gmkwt65PJK1lEqbNlbXyOAsdxi+Smy5EosM4v6RZYAaZVqQGG2I1lkQFdX5LEItg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344884; c=relaxed/simple;
	bh=oFQQ0BEtCNmZgPZ9hFd0SYNb3j3YgcpyHPK6J0kKe1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q23WpGRsCL6FE5ugKGiWJclqAD2lxHfFqhMEjU+YqH3hAaMoDA/0BKqxBEE2SdvFi7B1wyXJqG+jcUWPMyTQlmdkaDGQFo/LrUhwmGVsclMq6lL2JsyDCmXA6hGcFTMsnG1Aj+yME+M5zqsujpI+QUR6zBlxawqXK02WkF7B3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slsEbNop; arc=none smtp.client-ip=209.85.128.180
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7fe36f1be74so41982667b3.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783344882; x=1783949682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/y2I+sB4nnIw24fNyYtwZ+R62pw0nFMF5HbbrlkcN4=;
        b=slsEbNopGV4JmxoeeUG/FFbC8mq9ot3QqW9dAIajBBgtcCiLsa/nuS8SHDzKB8fZ3v
         tk8IKW+kVhCV5yLB+Qp16grFGuNnQNdJao3RU99DuPWuoeKFwIsS2WFAKMAlZjX0Lvxj
         iD2eZcdJ+OwksgWduMK6W84dipPjj7tSOe0hcBX08Nzv9IPYCWpneX0Pow18WwKeed9E
         XGHxl2aCPXOBUmAYYQFZTJDkYNxe4LDYTHiborEc2sSDye/S44KvHF69ru/4X+vNdfmG
         5lTT8ig7uJjevKintwpURM3MgRnS0K5ru/E5ygBDojUcMQTvAdz1KH6uGfHdvRg3hVWk
         HCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344882; x=1783949682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2/y2I+sB4nnIw24fNyYtwZ+R62pw0nFMF5HbbrlkcN4=;
        b=indixDF9B5ZJOHLEdakoWO+aNwkl5dqhzs/VVoFWD8XODkp264aUZs8H7QMQNQPfO5
         ODjVh8o+aWkzNgJNKuYpmyBSBkTiAZtg4LA1uJjYtDiNGz3kEB6kpet3LNk5p3szhdP0
         R+Icf+yoe7u58uAtAlOZU1dgZhDLli9tBDuV24idT/wkkFnN7DiZJwQKMqYO+oBxZNec
         6QNIu8ojCixhpxe1j9fQeR44kcdNrJT5X57JwEGY7UBVOAjGq67wJZnnrjnCilEz/79f
         sIZ/9dNxJ064dh2vHg4JPdco1b8lucqgO4UG88Q9LScHXFF+ikGb8239nt9mEhYm4pj9
         5ybw==
X-Gm-Message-State: AOJu0Ywc6JpsQqNNCV8WeNAaqwNstnFH1IlP67SH+7b6fW/Ojnb0APGB
	uZVWbvGn7pMKDWx6vJeJjyH/fWRZdBXLH0MhXV5v94GNkDOVe8+lmOXOeuMYeQ==
X-Gm-Gg: AfdE7cn2mUb90tZvVchYLcrH5uv6zfb03t+8cbaCG7DApvWol86CzWXmaK/cFdr2zSU
	AGuPVD5WQm3Xa/GVc/mgW++pXbmjz7DXdkOYSmzQNwAJufVKH1WUPn4WFI3a7I22zYFL2EWhat+
	q+I5hm74dKOMpR3nxV+GRhtvMza0fE0hlWEq60eQRcXaW1FXkOlGKWVzDGdPMjSBSKcmuHIyZwP
	QQpnv9L2VB040wDAdPMnRp8qJ9Qa/nbhXk+toEiV7onIQ5aoXV5g5J2zJacnROX/U/EGv9jxrG5
	fktgEMm1/2iONSuY44jO+Eq9XGDz8VvqUlGA5pN4VEBkdKl3ARyGemNTxia4LV8cbnydI6NihWo
	uoIY+smLPrDthwEOrRgJoqeFU7OC21/3dO2r2juzbMIbWNUHrchIIekoExAkYS+F5Z9oAGOh6Yy
	TYEy+SQbsnKRo9o1u9PzjnTIdScJJKdW13SArImHVxfd6BVAwwsjS8g/PLGDZoHRdS0wWrsTkpO
	+7pPW5+Ur6hSaCZ
X-Received: by 2002:a05:690c:4d83:b0:80c:85b6:75bd with SMTP id 00721157ae682-81be4809ee4mr1851507b3.70.1783344881777;
        Mon, 06 Jul 2026 06:34:41 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144b537e3asm57002827b3.34.2026.07.06.06.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:34:41 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 4/7] selftests: drv-net: refactor so_txtime errqueue handling
Date: Mon,  6 Jul 2026 09:34:06 -0400
Message-ID: <20260706133433.3142805-5-willemdebruijn.kernel@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-305050-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 62094712669

From: Willem de Bruijn <willemb@google.com>

Prepare error queue handling for upcoming SO_EE_ORIGIN_TIMESTAMPING
messages in the next patch in this series.

Convert do_recv_errqueue_timeout into dispatcher do_recv_errqueue
and move SO_EE_ORIGIN_TXTIME specific code into a separate helper.

This will make the next patch a lot more readable.

No functional changes.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 .../testing/selftests/drivers/net/so_txtime.c | 66 ++++++++++---------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index 55a386f3d1b9..7364ce2bec0b 100644
--- a/tools/testing/selftests/drivers/net/so_txtime.c
+++ b/tools/testing/selftests/drivers/net/so_txtime.c
@@ -158,7 +158,40 @@ static void do_recv_verify_empty(int fdr)
 		error(1, 0, "recv: not empty as expected (%d, %d)", ret, errno);
 }
 
-static int do_recv_errqueue_timeout(int fdt)
+static int do_recv_errqueue_timeout(struct sock_extended_err *err,
+				    const char payload_char)
+{
+	const char *reason = NULL;
+	int64_t tstamp = 0;
+
+	switch (err->ee_errno) {
+	case ECANCELED:
+		if (err->ee_code != SO_EE_CODE_TXTIME_MISSED)
+			error(1, 0, "errqueue: unknown ECANCELED %u\n",
+			      err->ee_code);
+		reason = "missed txtime";
+	break;
+	case EINVAL:
+		if (err->ee_code != SO_EE_CODE_TXTIME_INVALID_PARAM)
+			error(1, 0, "errqueue: unknown EINVAL %u\n",
+			      err->ee_code);
+		reason = "invalid txtime";
+	break;
+	default:
+		error(1, 0, "errqueue: errno %u code %u\n",
+		      err->ee_errno, err->ee_code);
+	}
+
+	tstamp = ((int64_t)err->ee_data) << 32 | err->ee_info;
+	tstamp -= (int64_t)glob_tstart;
+	tstamp /= 1000 * 1000;
+	fprintf(stderr, "send: pkt %c at %" PRId64 "ms dropped: %s\n",
+		payload_char, tstamp, reason);
+
+	return 1;
+}
+
+static int do_recv_errqueue(int fdt)
 {
 	char control[CMSG_SPACE(sizeof(struct sock_extended_err)) +
 		     CMSG_SPACE(sizeof(struct sockaddr_in6))] = {0};
@@ -169,7 +202,6 @@ static int do_recv_errqueue_timeout(int fdt)
 	struct msghdr msg = {0};
 	struct iovec iov = {0};
 	struct cmsghdr *cm;
-	int64_t tstamp = 0;
 
 	iov.iov_base = data;
 	iov.iov_len = sizeof(data);
@@ -181,8 +213,6 @@ static int do_recv_errqueue_timeout(int fdt)
 	msg.msg_controllen = sizeof(control);
 
 	while (1) {
-		const char *reason = NULL;
-
 		ret = recvmsg(fdt, &msg, MSG_ERRQUEUE);
 		if (ret == -1 && errno == EAGAIN)
 			break;
@@ -201,33 +231,9 @@ static int do_recv_errqueue_timeout(int fdt)
 		if (err->ee_origin != SO_EE_ORIGIN_TXTIME)
 			error(1, 0, "errqueue: origin 0x%x\n", err->ee_origin);
 
-		switch (err->ee_errno) {
-		case ECANCELED:
-			if (err->ee_code != SO_EE_CODE_TXTIME_MISSED)
-				error(1, 0, "errqueue: unknown ECANCELED %u\n",
-				      err->ee_code);
-			reason = "missed txtime";
-		break;
-		case EINVAL:
-			if (err->ee_code != SO_EE_CODE_TXTIME_INVALID_PARAM)
-				error(1, 0, "errqueue: unknown EINVAL %u\n",
-				      err->ee_code);
-			reason = "invalid txtime";
-		break;
-		default:
-			error(1, 0, "errqueue: errno %u code %u\n",
-			      err->ee_errno, err->ee_code);
-		}
-
-		tstamp = ((int64_t) err->ee_data) << 32 | err->ee_info;
-		tstamp -= (int64_t) glob_tstart;
-		tstamp /= 1000 * 1000;
-		fprintf(stderr, "send: pkt %c at %" PRId64 "ms dropped: %s\n",
-			data[ret - 1], tstamp, reason);
-
+		num_tstamp += do_recv_errqueue_timeout(err, data[ret - 1]);
 		msg.msg_flags = 0;
 		msg.msg_controllen = sizeof(control);
-		num_tstamp++;
 	}
 
 	return num_tstamp;
@@ -245,7 +251,7 @@ static void recv_errqueue_msgs(int fdt)
 			error(1, errno, "poll");
 
 		if (ret && (pfd.revents & POLLERR))
-			num_tstamp += do_recv_errqueue_timeout(fdt);
+			num_tstamp += do_recv_errqueue(fdt);
 
 		if (num_tstamp == cfg_num_pkt)
 			break;
-- 
2.55.0.795.g602f6c329a-goog



Return-Path: <netdev+bounces-171110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0197EA4B8A8
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33A918928AC
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6378635F;
	Mon,  3 Mar 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGUsXnOg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54AEAD27
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989061; cv=none; b=tIiH7hVvQeKlCHr+tlpZXD+f2n9X6AmS/zrlW/eQe5fVO8fH1HbflI4eH3madup9xMstxVRCACvr8gN98kAOWjEnoFFksUjn+/tnqdVxcaUS9nUE7Iyb3tKb91AUJWY218mRVd0YEtkfIgBnwZN3zF6LMvywu0r7+ulNYZRhSHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989061; c=relaxed/simple;
	bh=yock02p8WzLQWzC+4PpwkfwqwMvxF9wQ+cYVg/GBdG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kruRG/9daMPlo3cWZsZhZ5QJm4CJMMGcZmP8QdW2ggqKIwjlnNufpvg6lX/YaGQGk51g1Fs5XyHby8BB9eBgSsKhlBCZ935cDy0j5NFGjfgvCHZskVnEmmeTT9NyApe7v9mTlx3E6AMo3uZtmLQgbZCGtDKMyTAyDSXMIVUSnwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGUsXnOg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223378e2b0dso57536005ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 00:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740989058; x=1741593858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SbPG6Sncay2jVK/KcaB/R6wiyPWVfGtkuZj+mkez72k=;
        b=BGUsXnOgOg3hFOA39RcxdDnAhCxnthjCGSyTkWTNp/eQr3XvuHc9NtS62n6fe/0Atb
         ddE2Q55QPIE5DmevJSv/CfbRAtLL+UmlckkKJiJunRul69/yENt5XuXxydEJIpPkVHS0
         TCftK95nrwopr9uEiYcB2fDTV5bNIhb2EoPqv/+ZyWizUwRRDI+BtKHYAKQ0vcox76X1
         7kRMZzm1N6KsB8E24tV51eiDUQgYNS9GadWxO9hrZFWRD6Y+ArfO5WMsao2g3px1z2/b
         +lIGXF++U7R8SOf+F2JkJjaUgkKt0+9Fpz7JdQUGK6lmNy1/CiTyX5ljVyKWWx2jCAuC
         Tuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740989058; x=1741593858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbPG6Sncay2jVK/KcaB/R6wiyPWVfGtkuZj+mkez72k=;
        b=jqokQirEGtwWhPMPqcPpGK5UEgPbjEYLa6P8p5j8BEExTL8yZsoWlgYmxgMFtZfUX+
         JfIZhWBMZWwhe+RCloMxKZUFFv/94oDJBZRS8UD9Ry9/eq4AqSnhIOqTqzi0qbhkJh1k
         4zcQNVynV2bWo4ZSQXTt2q/gC0iOhdJQtidpU+EJIkUXZcPhpb2+/WeyJdJVf27UUuxl
         mDljsV+fimzAKnXps8dDrntUPdYik+PgmSNIV9ffyY5L3rf/3FSXYYDNjK7vZJJmj/AG
         AlsNNf8ntC2AoNQ7jor5wMMGvG31+qu2nu4sDqj6qkFBHpsHYSNzEa/SEucBWSd1qBAj
         xtLQ==
X-Gm-Message-State: AOJu0YxQTfHHJjeQ4VF0oWQq7O0VLI/DnmP/6sTKPpvDZKdgIyeUMPYI
	EPjDmr5yX+FerqdUrAruJQvapjSwnOiAJvQdqAg0Tk/uDXjJ1lMZ
X-Gm-Gg: ASbGncumg03h+XKlhEXnd21kA67zI466WVUCJmhXneb2WdRssK984dOjSnFpbwrUmCF
	T2I7S0IfmZpi3ctP01Wql2OstTXB4O69VTAOie7Sjn4Mg26mFCfkRZv1+ngUsZzXWU9O/xDoq6N
	fdaoAx4qeJMS6LG27xUeoIMA0WUdCKvbCTdhl8bNBBGlQAaeiytS/YyuvPZRbprHMmVcapNQd34
	CIqrPTiZyfj4P3Ag/BFig3ADxfWVgs7oeHwW+tSFGNu5ZJlT/5p091/4EgR/tQOg2CX2JfYGHxE
	qpUM05B2p6iSEWW28RUd5+BL/2BogDZb/FqzTwRcTZWMeBqKEJ0IMN+ybl1/KFa/eXk9Ql/ISSH
	xwNFN8UbcfF57j4Qx
X-Google-Smtp-Source: AGHT+IFs3pibu42YqWXnOeFbhWs38O57WBc+6EGrH/Kbg5bcRQHVpkebyhVUBWQ+UK34IK0HP3kOEA==
X-Received: by 2002:a05:6a21:1518:b0:1ee:ced0:f0a4 with SMTP id adf61e73a8af0-1f2f4e45063mr23536638637.34.1740989058033;
        Mon, 03 Mar 2025 00:04:18 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73648f97953sm2271741b3a.166.2025.03.03.00.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:04:17 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net-next] selftests: txtimestamp: ignore the old skb from ERRQUEUE
Date: Mon,  3 Mar 2025 16:04:04 +0800
Message-Id: <20250303080404.70042-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I was playing with txtimestamp.c to see how kernel behaves,
I saw the following error outputs if I adjusted the loopback mtu to
1500 and then ran './txtimestamp -4 -L 127.0.0.1 -l 30000 -t 100000':

test SND
    USR: 1740877371 s 488712 us (seq=0, len=0)
    SND: 1740877371 s 489519 us (seq=29999, len=1106)  (USR +806 us)
    USR: 1740877371 s 581251 us (seq=0, len=0)
    SND: 1740877371 s 581970 us (seq=59999, len=8346)  (USR +719 us)
    USR: 1740877371 s 673855 us (seq=0, len=0)
    SND: 1740877371 s 674651 us (seq=89999, len=30000)  (USR +795 us)
    USR: 1740877371 s 765715 us (seq=0, len=0)
ERROR: key 89999, expected 119999
ERROR: -12665 us expected between 0 and 100000
    SND: 1740877371 s 753050 us (seq=89999, len=1106)  (USR +-12665 us)
    SND: 1740877371 s 800783 us (seq=119999, len=30000)  (USR +35068 us)
    USR-SND: count=5, avg=4945 us, min=-12665 us, max=35068 us

Actually, the kernel behaved correctly after I did the analysis. The
second skb carrying 1106 payload was generated due to tail loss probe,
leading to the wrong estimation of tskey in this C program.

This patch does:
- Neglect the old tskey skb received from ERRQUEUE.
- Add a new test to count how many valid skbs received to compare with
cfg_num_pkts.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
Willem, I'm not sure if it's worth reviewing this patch to handle this
testcase. After all it's only a selftest. Well, adding a new test might
be helpful. Please feel free to drop/ignore it if you don't like it.
---
 tools/testing/selftests/net/txtimestamp.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
index dae91eb97d69..c63af798a521 100644
--- a/tools/testing/selftests/net/txtimestamp.c
+++ b/tools/testing/selftests/net/txtimestamp.c
@@ -86,6 +86,7 @@ static struct timespec ts_usr;
 
 static int saved_tskey = -1;
 static int saved_tskey_type = -1;
+static int saved_num_pkts;
 
 struct timing_event {
 	int64_t min;
@@ -131,17 +132,20 @@ static void add_timing_event(struct timing_event *te,
 	te->total += ts_delta;
 }
 
-static void validate_key(int tskey, int tstype)
+static bool validate_key(int tskey, int tstype)
 {
 	int stepsize;
 
+	if (tskey <= saved_tskey)
+		return false;
+
 	/* compare key for each subsequent request
 	 * must only test for one type, the first one requested
 	 */
 	if (saved_tskey == -1 || cfg_use_cmsg_opt_id)
 		saved_tskey_type = tstype;
 	else if (saved_tskey_type != tstype)
-		return;
+		return true;
 
 	stepsize = cfg_proto == SOCK_STREAM ? cfg_payload_len : 1;
 	stepsize = cfg_use_cmsg_opt_id ? 0 : stepsize;
@@ -152,6 +156,7 @@ static void validate_key(int tskey, int tstype)
 	}
 
 	saved_tskey = tskey;
+	return true;
 }
 
 static void validate_timestamp(struct timespec *cur, int min_delay)
@@ -219,7 +224,8 @@ static void print_timestamp(struct scm_timestamping *tss, int tstype,
 {
 	const char *tsname;
 
-	validate_key(tskey, tstype);
+	if (!validate_key(tskey, tstype))
+		return;
 
 	switch (tstype) {
 	case SCM_TSTAMP_SCHED:
@@ -242,6 +248,7 @@ static void print_timestamp(struct scm_timestamping *tss, int tstype,
 		tstype);
 	}
 	__print_timestamp(tsname, &tss->ts[0], tskey, payload_len);
+	saved_num_pkts++;
 }
 
 static void print_timing_event(char *name, struct timing_event *te)
@@ -582,6 +589,7 @@ static void do_test(int family, unsigned int report_opt)
 		       (char *) &sock_opt, sizeof(sock_opt)))
 		error(1, 0, "setsockopt timestamping");
 
+	saved_num_pkts = 0;
 	for (i = 0; i < cfg_num_pkts; i++) {
 		memset(&msg, 0, sizeof(msg));
 		memset(buf, 'a' + i, total_len);
@@ -673,6 +681,12 @@ static void do_test(int family, unsigned int report_opt)
 		while (!recv_errmsg(fd)) {}
 	}
 
+	if (cfg_num_pkts != saved_num_pkts) {
+		fprintf(stderr, "ERROR: num_pkts received %d, expected %d\n",
+				saved_num_pkts, cfg_num_pkts);
+		test_failed = true;
+	}
+
 	print_timing_event("USR-ENQ", &usr_enq);
 	print_timing_event("USR-SND", &usr_snd);
 	print_timing_event("USR-ACK", &usr_ack);
-- 
2.43.5



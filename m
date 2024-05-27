Return-Path: <netdev+bounces-98118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B56F8CF81E
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 05:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6EE71F21C11
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 03:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9892A1A2C38;
	Mon, 27 May 2024 03:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADaJXkU2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D70120E6
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 03:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716781103; cv=none; b=Hp3zwSOBXJ1bpyyBrjjXJvGBYO8k/y18ZE9MgvtY6t1Rj/8Nl3R5FgBbVF5x01WHw7WyC6L9O2bZSQycXLq0y0vT2a3L5f+OnuzZBCGpdN81qk609/ifPewQQmP4GJD8CQ8ScZyyFsrH55l8v9Uu6CNB3+c8AufCwdS4/SuJpWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716781103; c=relaxed/simple;
	bh=DILAFSaIB8Zonx+zUSBYgfTXqZxPgnJXY6VsrQsNbUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bkn3MdDMiwa/eBg/3WnyaQJg4kT4qCDakfeuqR5QfWD0A6/E4XcJ1z2U7U4zXiEqqsGiRW1Gqr1d0LWus1To8nuJP2qiKDvBr/rogyAmu5waaBkEVxrtP0CrMELDKC8HvtSGedJgcdE2q18wz+hWDtXcMf/RxWkKuKLE3TnjA00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADaJXkU2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6f8e9555eabso2292954b3a.1
        for <netdev@vger.kernel.org>; Sun, 26 May 2024 20:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716781101; x=1717385901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMTVJ9VmCl5Obe+Blb0eZZ3+W7i/Oy+EbfXZVNp8N3U=;
        b=ADaJXkU2nQNmcoAhGZr/c//FvnzjDMyqmdt4IRNuAHlTYydlCxyDuJB0Vt2/fvEpQn
         zBCVq3gyZ1h4/35gVnf6TC6y9t/XZOt/5bc+m7YUXoyCGV2Z2EedzLXcU3+58keT60vn
         vvF/D8iP25+AowZeRJahv59hzkt/22ZJtsR4wbEMxj8dBQrFn1nBuQFG8H4PHM8g0VZo
         y/6b5oBAa3W+I+XcZawXFQ0b2ugql+j7SA9C2PFr3GypAUFUPZwwXvqHzP8PaxI4rCNY
         rdqGlP+ltD4EK5TkFQ/R01LBznIbzVUqGMPC5W8VgGcj7MbtSi4Jn8wEvoDkVhIAqsbG
         bxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716781101; x=1717385901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMTVJ9VmCl5Obe+Blb0eZZ3+W7i/Oy+EbfXZVNp8N3U=;
        b=rcZE3sh2JH315e4kpnYxvmdrQG99Fuduh45QjRSCspRzYYxw1Scb1VrsYrvlekdZ5E
         ++sVhO0VHl5jtrof16W8FTXao83y02KAjNliOPXc5JqtLrXZimI6dAiGjkX2E3MixmAh
         A05ameeDhLCCbiIUbUBwLVn2wTjfD85dYHj5GkmFwDIJYnpAPNCZHh48YCUrKw1WwdpF
         px2hhxuNKFKSlgdvklXiEVhEVAdqN2V04c0YTYzkj4otIP6VZ9tutCT/bR/Bhc1oBYWF
         CmtaOhWD8FVcSiaPecYu971MCrxk6s8Q6JTOoDt2T/ej44hS8GsWQh6Xo88cqVuNFD/n
         yJMA==
X-Gm-Message-State: AOJu0YzreO/kewEiBkxD7I8JiCTAnLBq/wZbd4wTeE6MLiFUXeetwo3J
	F8yYs7aKF+seHM0cPdKG+63nZvfU/YLUrQ2NlFUtXmwevrDOhgD8
X-Google-Smtp-Source: AGHT+IE7iG5SYRBqaLOduyJKZcYWrNPNro57mEyntsS+AD0OTCpqxMJ4hLGiSzV1kg8V0egZ8P5kHw==
X-Received: by 2002:a05:6a00:22cc:b0:6ff:191a:992 with SMTP id d2e1a72fcca58-6ff191a1ab6mr4809035b3a.34.1716781101339;
        Sun, 26 May 2024 20:38:21 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbeb128sm4045576b3a.135.2024.05.26.20.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 20:38:20 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>,
	Yongming Liu <yomiliu@tencent.com>,
	Wangzi Yong <curuwang@tencent.com>
Subject: [RFC PATCH net-next] tcp: introduce a new MIB for CLOSE-WAIT sockets
Date: Mon, 27 May 2024 11:37:45 +0800
Message-Id: <20240527033745.90643-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

CLOSE-WAIT is a relatively special state which "represents waiting for
a connection termination request from the local user" (RFC 793). Some
issues may happen because of unexpected/too many CLOSE-WAIT sockets,
like user application mistakenly handling close() syscall.

We want to trace this total number of CLOSE-WAIT sockets fastly and
frequently instead of resorting to displaying them altogether by using:

  netstat -anlp | grep CLOSE_WAIT

or something like this, which does harm to the performance especially in
heavy load. That's the reason why I chose to introduce this new MIB counter
like CurrEstab does. It do help us diagnose/find issues in production.

Besides, in the group of TCP_MIB_* defined by RFC 1213, TCP_MIB_CURRESTAB
should include both ESTABLISHED and CLOSE-WAIT sockets in theory:

  "tcpCurrEstab OBJECT-TYPE
   ...
   The number of TCP connections for which the current state
   is either ESTABLISHED or CLOSE- WAIT."

Apparently, at least since 2005, we don't count CLOSE-WAIT sockets. I think
there is a need to count it separately to avoid polluting the existing
TCP_MIB_CURRESTAB counter.

After this patch, we can see the counter by running 'cat /proc/net/netstat'
or 'nstat -s | grep CloseWait'

Suggested-by: Yongming Liu <yomiliu@tencent.com>
Suggested-by: Wangzi Yong <curuwang@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/uapi/linux/snmp.h | 1 +
 net/ipv4/proc.c           | 1 +
 net/ipv4/tcp.c            | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index adf5fd78dd50..c0feefb4d88b 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -302,6 +302,7 @@ enum
 	LINUX_MIB_TCPAOKEYNOTFOUND,		/* TCPAOKeyNotFound */
 	LINUX_MIB_TCPAOGOOD,			/* TCPAOGood */
 	LINUX_MIB_TCPAODROPPEDICMPS,		/* TCPAODroppedIcmps */
+	LINUX_MIB_TCPCLOSEWAIT,			/* TCPCloseWait */
 	__LINUX_MIB_MAX
 };
 
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 6c4664c681ca..964897dc6eb8 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -305,6 +305,7 @@ static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("TCPAOKeyNotFound", LINUX_MIB_TCPAOKEYNOTFOUND),
 	SNMP_MIB_ITEM("TCPAOGood", LINUX_MIB_TCPAOGOOD),
 	SNMP_MIB_ITEM("TCPAODroppedIcmps", LINUX_MIB_TCPAODROPPEDICMPS),
+	SNMP_MIB_ITEM("TCPCloseWait", LINUX_MIB_TCPCLOSEWAIT),
 	SNMP_MIB_SENTINEL
 };
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 681b54e1f3a6..7abaa2660cc8 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2659,6 +2659,8 @@ void tcp_set_state(struct sock *sk, int state)
 	default:
 		if (oldstate == TCP_ESTABLISHED)
 			TCP_DEC_STATS(sock_net(sk), TCP_MIB_CURRESTAB);
+		if (state == TCP_CLOSE_WAIT)
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPCLOSEWAIT);
 	}
 
 	/* Change state AFTER socket is unhashed to avoid closed
-- 
2.37.3



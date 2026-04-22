Return-Path: <netdev+bounces-280440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGXXMuHe6GlDRAIAu9opvQ
	(envelope-from <netdev+bounces-280440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:44:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DBF4476AC
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90F2D301DAD0
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC123ED5CA;
	Wed, 22 Apr 2026 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1+UzRBL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6423ED5D0
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868778; cv=none; b=KfLAB+XexlDXRVzdFIVZt876LuYLwRtbB2lkbUP70hxLvihzT/EvhqEqHx4pFWLUfzTErHFyx4/QNc17Bo+Kqh7wcsi/p/AoX3KMR3+6jD1DcXm6bQ86tcy6X30k+2xVA9Ipf1iTzyrrMDguj84CAPEbHKWGJcGUlUOE8jzlqYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868778; c=relaxed/simple;
	bh=iZ9suLIuBUoCeCnetfnZ7mtmyUYxmiPfo0+beK82tOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tKX49tiO5eIDL7HFnyyyqZ0pggkWQ44E9PoSu15RxvnXGnEWz4WPwAasM6AkcxFthnLjsUrJk3EFTuxdN+9zRTbLN9mqn++9AbWUK0kxShTBMOudGzJoRuJtKUcH6pZI5W4E2z69D++UXegovRVUaRpyaiCQnxUubDgw1GyMxPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1+UzRBL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2d3a9e149so30711285ad.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 07:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776868777; x=1777473577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v1HO4kkoe4n1JrCENVUM3crOySJ+rOzuctiq2bNthFo=;
        b=D1+UzRBL9L4vibylI3+D+HQl1gnmwiDxYArvfT4hppriIyGv73AQrBmCqpa2LHj05S
         aSTq1GfmeWa7p0zXC3mJQx1tiKcCtPePmMLe+RDpwBUhmAZd01Kpskup11HbNXBdc2ZD
         mLt3v3uNY8Oo4c9K9lx4gu+kQMzWXpWLFP4mu1OcMisz6DkKiHKnk3wvezXQtZ6IclEB
         FjeMle2siDUIOayg28e//HnRBq+W5Xga23OYI50oB220nNifHQ6O3JMmzM+IZDQ+dX/n
         +qGa+Q32oB8i/xBd7B58KzIOSghHVgOSDF4NCqhUoPZnACP+HBEJZ5judoNYHgiOQh0S
         PoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776868777; x=1777473577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1HO4kkoe4n1JrCENVUM3crOySJ+rOzuctiq2bNthFo=;
        b=tRJjABYmt6dbOA70yOBXhSR3n0TjmC7aGkXXorJmoi+KUgzHH5Wk6FCib0j4v83Ycy
         pMosJ5vPyEpM09ETpiEas9MNGctI8vPiwyVD4fgzMvozSkMNwyLHuZDlVR2EKBEX/tBq
         i3isfj7U0oY2W5/18mzQpTHrxbOZJwrErzHJXz1iDYdKeDOMrgqYj3ShL2rIV1lMO/d7
         xPCYTHKaOxqUCQYAjzx+GcZ4hS1Di/1f81Lpidee2Ga+f3Vrim2agZWdY5f+NHvx24d2
         /vMscglbbphchksMG4gz7oRo5CYVPyIZhRD2aYrMnvTiRWcoQ0hzGZCx9e+QwyGD3PjG
         2jMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9H8OCIGFjlWp1lmYxpSSR/vivtreRrmwCRvNlPqfdLgvbr0XqgdyNzR09IX7MXIPr4bw3kczM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysg/8Eu1rxhIMxgQwVTk+k6MG56NmyrC2OCUVczW8XOj0+tt4t
	Jse2W0nLfkYdSsG5Gmnsox3/Lec6FYfL9eftfZ/Hd46XWF5N6yaSBOi2
X-Gm-Gg: AeBDieuYsBS1SINyLCyrAtCNjHV80CTGjCjlgMxiRkfz7i/XxC2dZSYX+7ncKtXgSa/
	ufLygOps6Lib806JRBAAA/9gJhMBBhlgmkw2WLzRqEoVmgT2gwvLulnZLO9RavUr7ZSezuJGuf3
	Yy4ZeLb3jk8poj2rLPTWucokVNEtB+Eymxvrh61MEqX05Ay/e+iiPDtKccXJImmcWE4b+qdG+HN
	KFbK/MrC5eYWwKVtD/Jo4WxjXgh9qGFbJdeBXJOvTrRCIwX0SBlzAXwH5F4yxG4AiZl8xP4w4Ia
	oAPO1/IqLoKkYHn6wthkvQwCSBqKOaPc7tUafxt11lxvuV+LLKP/3F6ciPqF8WgjITZ+obg6JaB
	MLIzb/yjoW2+3IQlNJcC19BCgaF4T7qw0d/b8UIOmeou27jCW/gDMRJLd9JlEUZO1FJtCJ2pTTU
	g71Ub7uu1unmzAR9ZCF7liuzKM9qtRsPs2qatLAWYdBg==
X-Received: by 2002:a17:902:ef10:b0:2b0:ac1e:9730 with SMTP id d9443c01a7336-2b5f9e931b5mr183257505ad.14.1776868776613;
        Wed, 22 Apr 2026 07:39:36 -0700 (PDT)
Received: from localhost ([223.185.43.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa507cbsm173588135ad.37.2026.04.22.07.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 07:39:35 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: pabeni@redhat.com,
	matttbe@kernel.org,
	martineau@kernel.org
Cc: geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v2] mptcp: do not drop partial packets
Date: Wed, 22 Apr 2026 20:09:31 +0530
Message-Id: <20260422143931.43281-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280440-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,vger.kernel.org,lists.linux.dev,mpiric.us,mpiricsoftware.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardulsb08@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpiricsoftware.com:mid,mpiricsoftware.com:email]
X-Rspamd-Queue-Id: 31DBF4476AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a packet arrives with map_seq < ack_seq < end_seq, the beginning
of the packet has already been acknowledged but the end contains new
data.  Currently the entire packet is dropped as "old data," forcing
the sender to retransmit.

Instead, skip the already-acked bytes by adjusting the skb offset and
enqueue only the new portion.  Update bytes_received and ack_seq to
reflect the new data consumed.

A previous attempt at this fix (commit 1d2ce718811a ("mptcp: do not
drop partial packets"), reverted in commit bf39160c4218 ("Revert
"mptcp: do not drop partial packets"")) also added a zero-window
check and changed rcv_wnd_sent initialization, which caused test
regressions.  This version addresses only the partial packet handling
without modifying receive window accounting.

Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/600
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
v2: Drop the mptcp_try_coalesce() attempt for partial packets, since
    non-zero offset always prevents coalescing (Paolo).

 net/mptcp/protocol.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 614c3f583ca0..73ec6563ab2b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -397,12 +397,24 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
 		return false;
 	}
 
-	/* old data, keep it simple and drop the whole pkt, sender
-	 * will retransmit as needed, if needed.
+	/* Completely old data? */
+	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
+	/* Partial packet: map_seq < ack_seq < end_seq.
+	 * Skip the already-acked bytes and enqueue the new data.
 	 */
-	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
-	mptcp_drop(sk, skb);
-	return false;
+	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+	msk->bytes_received += copy_len;
+	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
+
+	skb_set_owner_r(skb, sk);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	return true;
 }
 
 static void mptcp_stop_rtx_timer(struct sock *sk)
-- 
2.34.1



Return-Path: <netdev+bounces-240722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5340EC78911
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAE5A4E3674
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 10:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FEC3431E4;
	Fri, 21 Nov 2025 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVgGAT7i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2AF2D7387
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763722006; cv=none; b=iWFbrk68pK5o+cp/NA3NGj1bdPrs1kF0avf1HN2wgd8BMX1LYf6LbqhW9xeysBK4iEVWfjbPw0fZWmU1A9GH5AnV2NZDPDqPE+i8kfwn64R0DclU3kdiHbcWVUOUkaCIJjhB4xS/R+yUWUt6nlUwVM+71vkvTIIHEWXxx1Ta9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763722006; c=relaxed/simple;
	bh=IoKeewMqEqvP0bmflhtcozf0g3MwQaI4Yhft6Uthnrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NqQiCBggaCMJkXPniDWtff5I94hT9zZ5qe2RLwPhn+0ezUnB20yoEkx2MfrYLnjnZNMVrbiRTp5rpU2kUb0NSzhv7jQz6fDczGyRDcxlOtG1CUCodCjWYfdvFLaYu0KRRdqyoLvT8N4dk0PGxgVOIhzQlpwm7H9p5HNuznLA380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVgGAT7i; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29812589890so22558495ad.3
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 02:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763722004; x=1764326804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t+jQtIi6R3/Xo/ufxKPC6qm0gUE57Dr6R3PpZg3G3bk=;
        b=RVgGAT7iLzj3srBr+nD5PD4aI9xsojU8H3Cx0g3u5hZdTRg/gTe1Z101goefp+zX5k
         OxIFMMrTiQJ1XBBzrUdXLX7JFkGFFzQRohVU4hqBASR07evWXUqSW4Q5vnG0doX3XbWq
         yxODvYbiP9JrutAAoHAuWO4iyxpT3lsI3llQp7j9YOwjgWbEtFzqHBBtXhTV87WCVb+7
         U3EJNYRCRnvGy9ZnyBYz2TcxLJ31nvnMleQf3IVTC5JpnXasJDFwPpRkIoKV8VpZz2uR
         oPKMhfAqBvOd/UJTi5qiXgBL8W3jhi3KpgV1KSlrlYAw56TaYH3A4x0ZTwd9u0GdL8FA
         wQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763722004; x=1764326804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+jQtIi6R3/Xo/ufxKPC6qm0gUE57Dr6R3PpZg3G3bk=;
        b=tf0W9hyDWtMe+lHXgNpYhXVoeXP7h+7aeo+g6X3tvwWSW8VHrQN8WnOg8fy1Ku4Vlx
         SlYo/enwIBwjPmn5GDCRaAWbHxS/vJDqKf8TsCXUIxL0zIHACag4ltyDgkoT7Z2KOcr3
         ZUN/pzg3vjkN2YqSkcA012qxeavoihULQ8yZihI6KSfeDZmQcAkEJ8S8wVb7dnVX9dOV
         SmgcFRtGK7au3DH889SeOPrhs25kHKqCP1ZDfaZ8qLzK3kWf45fYVSTKApoQhNC0FgYG
         awWOnCh/2Wzgcj1LiutRVdvZ1lc6qlbTd3J+w1r6DnHlM/dxlHaln/NAcnvcaT1UH3wv
         PS2w==
X-Gm-Message-State: AOJu0Yxku7ntbe1VrX3g7iaJQMDanE84BzbIwRIC1qXzmZ9ci9gLJ/jI
	ZDUjek/y+VsDNGTm9ulvj15LPO9ijjWLgr0beeSTns/64vPGRio/4lNSaXz7Mg==
X-Gm-Gg: ASbGncv7ro3xx7Z2fYuDevdi+uizg/0/5ygl3IIbv0vsTLqVJFr437pR7Iucvrfok4a
	aqpwBQIevSzlT78sY0XcOweAqahmv3mOEk6VMFcneTAfOWJb5ms4dZR3vWdc/PqzM4EMVziXi4n
	9whb/MezzFhPCJrunS2m2hw+WjsWWSgvYoLefVNrA/pFZ55SH3dSZ/aQDeErG2eS6CZZHsqhvaM
	g1szq3HTdKavDWRXFA8uGAAcT3meLeeDt+JaXHbA04uXg9q4LAbdnM/p1FFUzD5NlqM4iPQ8FBt
	LgioVcr33rCJboTzDlCXy8OI45my66j4ESv9jOBDmL2l8M+yDDtHqeL0QvoqHjNcQmku9RUpF9r
	9jYt3Gv3MvxE3dz75FmYITUA7PVtsLy/XYdYplv20grbmngSKWGTPUH8qiORnshCeEgVsZ8yZOK
	dlXXejNfP4
X-Google-Smtp-Source: AGHT+IGM3Tnv0hnwaOvrFZQ0FP2TxVRH4LEdBvIs6xlX50jwt+kcq2E8pZwNoQWT5TAY6OTUuyyJfQ==
X-Received: by 2002:a17:902:d511:b0:297:d4a5:6500 with SMTP id d9443c01a7336-29b6bec9822mr29067905ad.26.1763722003892;
        Fri, 21 Nov 2025 02:46:43 -0800 (PST)
Received: from fedora ([122.173.25.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138bfdsm52398575ad.22.2025.11.21.02.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:46:43 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	ncardwell@google.com,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	Shi Hao <i.shihao.999@gmail.com>
Subject: [PATCH v2] net: ipv4: fix spelling typos in comments
Date: Fri, 21 Nov 2025 16:14:25 +0530
Message-ID: <20251121104425.44527-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling typos in several code comments.

- alignement -> alignment
- wont -> won't
- orignal -> original
- substract -> subtract
- Segement -> Segment
- splitted -> split

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>

---

changes v2:
- Update subject message
- Add additional spelling typo fixes
- Combined all typo fixes into single patch as requested
---
 net/ipv4/ip_fragment.c          | 2 +-
 net/ipv4/netfilter/arp_tables.c | 2 +-
 net/ipv4/syncookies.c           | 2 +-
 net/ipv4/tcp.c                  | 2 +-
 net/ipv4/tcp_input.c            | 4 ++--
 net/ipv4/tcp_output.c           | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index f7012479713b..116ebdd1ec86 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -335,7 +335,7 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb, int *refs)

 	/* Note : skb->rbnode and skb->dev share the same location. */
 	dev = skb->dev;
-	/* Makes sure compiler wont do silly aliasing games */
+	/* Makes sure compiler won't do silly aliasing games */
 	barrier();

 	prev_tail = qp->q.fragments_tail;
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index 1cdd9c28ab2d..f4a339921a8d 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -59,7 +59,7 @@ static inline int arp_devaddr_compare(const struct arpt_devaddr_info *ap,
 /*
  * Unfortunately, _b and _mask are not aligned to an int (or long int)
  * Some arches dont care, unrolling the loop is a win on them.
- * For other arches, we only have a 16bit alignement.
+ * For other arches, we only have a 16bit alignment.
  */
 static unsigned long ifname_compare(const char *_a, const char *_b, const char *_mask)
 {
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 569befcf021b..7d0d34329259 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -131,7 +131,7 @@ static __u32 check_tcp_syn_cookie(__u32 cookie, __be32 saddr, __be32 daddr,

 /*
  * MSS Values are chosen based on the 2011 paper
- * 'An Analysis of TCP Maximum Segement Sizes' by S. Alcock and R. Nelson.
+ * 'An Analysis of TCP Maximum Segment Sizes' by S. Alcock and R. Nelson.
  * Values ..
  *  .. lower than 536 are rare (< 0.2%)
  *  .. between 537 and 1299 account for less than < 1.5% of observed values
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8a18aeca7ab0..0d1c8e805d24 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1600,7 +1600,7 @@ struct sk_buff *tcp_recv_skb(struct sock *sk, u32 seq, u32 *off)
 			return skb;
 		}
 		/* This looks weird, but this can happen if TCP collapsing
-		 * splitted a fat GRO packet, while we released socket lock
+		 * split a fat GRO packet, while we released socket lock
 		 * in skb_splice_bits()
 		 */
 		tcp_eat_recv_skb(sk, skb);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e4a979b75cc6..6c09018b3900 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1129,7 +1129,7 @@ static void tcp_update_pacing_rate(struct sock *sk)
 		do_div(rate, tp->srtt_us);

 	/* WRITE_ONCE() is needed because sch_fq fetches sk_pacing_rate
-	 * without any lock. We want to make sure compiler wont store
+	 * without any lock. We want to make sure compiler won't store
 	 * intermediate values in this location.
 	 */
 	WRITE_ONCE(sk->sk_pacing_rate,
@@ -4868,7 +4868,7 @@ void tcp_sack_compress_send_ack(struct sock *sk)
 		__sock_put(sk);

 	/* Since we have to send one ack finally,
-	 * substract one from tp->compressed_ack to keep
+	 * subtract one from tp->compressed_ack to keep
 	 * LINUX_MIB_TCPACKCOMPRESSED accurate.
 	 */
 	NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPACKCOMPRESSED,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b94efb3050d2..483d6b578503 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2629,7 +2629,7 @@ static int tcp_mtu_probe(struct sock *sk)
 	interval = icsk->icsk_mtup.search_high - icsk->icsk_mtup.search_low;
 	/* When misfortune happens, we are reprobing actively,
 	 * and then reprobe timer has expired. We stick with current
-	 * probing process by not resetting search range to its orignal.
+	 * probing process by not resetting search range to its original.
 	 */
 	if (probe_size > tcp_mtu_to_mss(sk, icsk->icsk_mtup.search_high) ||
 	    interval < READ_ONCE(net->ipv4.sysctl_tcp_probe_threshold)) {
--
2.51.0



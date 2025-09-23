Return-Path: <netdev+bounces-225527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73335B951A6
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B6118838A4
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DDF320A32;
	Tue, 23 Sep 2025 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEjmNjYg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A506320A1F
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617981; cv=none; b=MuWrTxNUoRZR9B22/7nj6WzWmS50766esFYyXUWkkqidhQ16wyfTDXIzP1AY5+pa9I5nGFMsIjuqj2i36fEX6ue43NtKdJMU1ixQw97YgqrW1u3oQgZGtSEK755ELSLfXV/ZiQpyzbP4n5N6KSWMcQ3qSJziGyE7Wd5ieQq4K5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617981; c=relaxed/simple;
	bh=kVgoHwy6jjvf1QemDdlf3DDsHECl0hJXuFQxcVH0zxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NqV1iFgfolmMyJrQCklRELftpKj6HGjvk0ONF08RNPXrOuTnJh4tmlemx8KW+68bKvCojnrcyr6+DphVvNyvge7WRZxrmyUAiJVnb7ZWU6tFrIEEFYhodeSy4CryveZVdqEfuu2dB+WEULREhZqxRYa3tvpn1+vreHdoQsJIkd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEjmNjYg; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee155e0c08so3324104f8f.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 01:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758617978; x=1759222778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnPlx3AD0qlRydPbaBxHLAGb56Xx3APcL+18Eue+CQ4=;
        b=QEjmNjYgZpMUJJVkPRa0PTivTSOsZsjk7yrQtzhIExlQgjDrKJtQzyqk8D0mZbzEle
         X2ZVp/NpKW5t/jkXtrkZGYXvREVEUZaiOzNvhYs4qq2v12+s/DXoXCYisEor7s5k09Jv
         GOp/toQVBpkeo1f+4RXVxy7a2KER8g+iQM0Vb2b1yxQ6HEjl0Ejt0uTpESvtvZBM2+7Y
         qzkxgpDbYd5DkJwNUf4jg/eC2bdlD2BdecBgA/QJa2FjY0k6CjcdNtquTqKqKz/FQ6SZ
         NG4c1xNrkxcGYhryM6UHg9kRUL0kgV4oNURuMcyLh/xSZjXYVPNDuQRolDRCgrRniV/I
         H+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617978; x=1759222778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnPlx3AD0qlRydPbaBxHLAGb56Xx3APcL+18Eue+CQ4=;
        b=vrx1sG/dLvPYl8Ku9HjD1MXz7XOrF8E4Y/tImxdzyECvgCjVj+88dLW1oZZypO1MZD
         dA8eMaG/nDa9VSDRVMNLx0ms6YUPE7LAo1F9+Njjat2o5uPwCPi1dd4oTJxaprvuT8hh
         u9qVX7BFlMfhQU+ynA8OxWEt6FoqU5hFQ17W+uVx/O06LZapVB8uKJzWeweTUTx5MHtM
         lKTix2/6PG8TThc9LRZH/q9gjNPfGU5jRLoQjLTz0A2SlwzgjdPx391tDNFxDIqRFdgU
         j84mzvU5yuq31xKOpr2v99Uxqi/vfsHFWOCRk2iC0HtE2GQNG7OnD/2zm5QVoMnZ26PA
         zbhg==
X-Gm-Message-State: AOJu0YySvmT0073vbp9ZYOF40//ikWUGrkKejBBNWSP6BAj23avqOuvm
	WXK4Ds8OBIC55W2alRzoMv6EHxJd4BzSIW0ul9D9Knf9wcWIwyzuATFvR6NpLg==
X-Gm-Gg: ASbGncuT07GpISSZ9UVUyanGx5lMzcjZdZmE2LcudQHQUczqLB99FBx2EVSy9O9q1l4
	qgOfYIuz4+lUWBhaQCPHvVhaBqN4QZQLa0iqUpvr6xV8RwJ2SW/j5mX7SJsnUp8o5TplTLTuJmc
	XsvY98W2bDiwX16YozHDlgFj22OJBaZO6iu5itCBKUzuIY01U0xuTDYEZ1oEwzNd2t18o1ikNOX
	yqkZWYtWhvGgPTbX+qUdH8DNB7M2sc4MJhmFuJ4TpQBytMm71BAfAAYNhaIgVS4GE2iaitDWz1D
	GkGVhUtT2oVZQpePyIvOILoEZhDBg0MHjE8029Yxb5h0dLYuKTy+KhV1X2IGFqSkwqcub0aga3e
	4vO4qmmxCIEQ92MbhDt0YHgU=
X-Google-Smtp-Source: AGHT+IG4eLaa4z203/TpewOpCHeAuWlt+0sMbe6X6EHPpFByd90iWgb55eTmaNSVhvkP3W4qnUin9A==
X-Received: by 2002:a05:6000:1866:b0:3ec:db87:e8a7 with SMTP id ffacd0b85a97d-405cb3e5d50mr1091344f8f.61.1758617977677;
        Tue, 23 Sep 2025 01:59:37 -0700 (PDT)
Received: from localhost ([45.10.155.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm11649545f8f.57.2025.09.23.01.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:59:37 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	ecree.xilinx@gmail.com,
	willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	dsahern@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	shuah@kernel.org,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	florian.fainelli@broadcom.com,
	alexander.duyck@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-net-drivers@amd.com,
	Richard Gobert <richardbgobert@gmail.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v8 4/5] net: gro: remove unnecessary df checks
Date: Tue, 23 Sep 2025 10:59:07 +0200
Message-Id: <20250923085908.4687-5-richardbgobert@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923085908.4687-1-richardbgobert@gmail.com>
References: <20250923085908.4687-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, packets with fixed IDs will be merged only if their
don't-fragment bit is set. This restriction is unnecessary since
packets without the don't-fragment bit will be forwarded as-is even
if they were merged together. The merged packets will be segmented
into their original forms before being forwarded, either by GSO or
by TSO. The IDs will also remain identical unless NETIF_F_TSO_MANGLEID
is set, in which case the IDs can become incrementing, which is also fine.

Clean up the code by removing the unnecessary don't-fragment checks.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/gro.h                 | 5 ++---
 net/ipv4/af_inet.c                | 3 ---
 tools/testing/selftests/net/gro.c | 9 ++++-----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index e7997a9fb30b..e3affb2e2ca8 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -448,17 +448,16 @@ static inline int inet_gro_flush(const struct iphdr *iph, const struct iphdr *ip
 	const u32 id2 = ntohl(*(__be32 *)&iph2->id);
 	const u16 ipid_offset = (id >> 16) - (id2 >> 16);
 	const u16 count = NAPI_GRO_CB(p)->count;
-	const u32 df = id & IP_DF;
 
 	/* All fields must match except length and checksum. */
-	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^ (id2 & IP_DF)))
+	if ((iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | ((id ^ id2) & IP_DF))
 		return true;
 
 	/* When we receive our second frame we can make a decision on if we
 	 * continue this flow as an atomic flow with a fixed ID or if we use
 	 * an incrementing ID.
 	 */
-	if (count == 1 && df && !ipid_offset)
+	if (count == 1 && !ipid_offset)
 		NAPI_GRO_CB(p)->ip_fixedid |= 1 << inner;
 
 	return ipid_offset ^ (count * !(NAPI_GRO_CB(p)->ip_fixedid & (1 << inner)));
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index fc7a6955fa0a..c0542d9187e2 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1393,10 +1393,7 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 
 	segs = ERR_PTR(-EPROTONOSUPPORT);
 
-	/* fixed ID is invalid if DF bit is not set */
 	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
-	if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
-		goto out;
 
 	if (!skb->encapsulation || encap)
 		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
index d5824eadea10..3d4a82a2607c 100644
--- a/tools/testing/selftests/net/gro.c
+++ b/tools/testing/selftests/net/gro.c
@@ -670,7 +670,7 @@ static void send_flush_id_case(int fd, struct sockaddr_ll *daddr, int tcase)
 		iph2->id = htons(9);
 		break;
 
-	case 3: /* DF=0, Fixed - should not coalesce */
+	case 3: /* DF=0, Fixed - should coalesce */
 		iph1->frag_off &= ~htons(IP_DF);
 		iph1->id = htons(8);
 
@@ -1188,10 +1188,9 @@ static void gro_receiver(void)
 			correct_payload[0] = PAYLOAD_LEN * 2;
 			check_recv_pkts(rxfd, correct_payload, 1);
 
-			printf("DF=0, Fixed - should not coalesce: ");
-			correct_payload[0] = PAYLOAD_LEN;
-			correct_payload[1] = PAYLOAD_LEN;
-			check_recv_pkts(rxfd, correct_payload, 2);
+			printf("DF=0, Fixed - should coalesce: ");
+			correct_payload[0] = PAYLOAD_LEN * 2;
+			check_recv_pkts(rxfd, correct_payload, 1);
 
 			printf("DF=1, 2 Incrementing and one fixed - should coalesce only first 2 packets: ");
 			correct_payload[0] = PAYLOAD_LEN * 2;
-- 
2.36.1



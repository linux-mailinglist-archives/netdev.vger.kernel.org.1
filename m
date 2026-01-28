Return-Path: <netdev+bounces-254121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF/yG/y0eWk0ygEAu9opvQ
	(envelope-from <netdev+bounces-254121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:04:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DB79D938
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05A86302A6D3
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFB63271E0;
	Wed, 28 Jan 2026 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+yg6T6w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C708C3254B5
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769583816; cv=none; b=eIaD+oQR9WMVB+ExvB03QwWMmx0W/BiO6Lwe6gDcp3cAk96P61kZBtT2hKygvqeNVOvpUl75SwQs04hL9f4kyXeeZ72QEOfOkRFHx0NJ/DOkqjGnyBUOFyH2YNr7eKbVGY9lgoGhNFQWFh4mkdLVYfJ75CPVnhXr9/Dg3O/3cNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769583816; c=relaxed/simple;
	bh=9yaa//l02hL9d3QnXsX8TGpcfmMZmVVVdA046893Ntc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QLJGscoCnWSgJwsITjxx0d7LokB5waAIzpYlGyso0DT56B0ZCwkHn9MdQO+Ykq8F3FHakapXegZl4rKdBHTxCNqJDBlTlrfZcbpSE65pneSg3TcS1pvraiIMmOA00nXl6+Qp2l+BeorZlJkrdsHZhOhCjjmippEJulbgi2OhQLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+yg6T6w; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-435903c4040so3973187f8f.3
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 23:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769583813; x=1770188613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uB1ae9vjvwE2CUDJT9majQICeAPiKcyK1Nree7WNF6U=;
        b=J+yg6T6whb6R46IAn4ws4AdL04bq9kP6bMyxD9XktQ1YZPI7NxdnAc2tU97dk5wsXN
         arSUvkkowwGn5c3MbR1YzE1eG/F6Ysd00c0QtNiu0/Lrh7fibWatSlYTv/80nAGesRU+
         408giic4bodKx9LBsQXJJ3hQAPVWkXqMb132Nwp9UgNjG8KoFYmX6BPVhXU4sPY4Qq39
         EKKoBw5AUuuzdJv+YUnHKUzhWI5GJxQTPf6FHWXUopt40pPcYR1S0jy6vUZorX5r3q9+
         5Xy8ttqX5IXzIB5+4xBweriVR9MpytTZBrr6SKxDeufbU++bYSpFGtwfZWAncp6lGJad
         G9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769583813; x=1770188613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB1ae9vjvwE2CUDJT9majQICeAPiKcyK1Nree7WNF6U=;
        b=QBKMDx4vlkGt/HdB3KLS9JaiSgZmz71b/ckC+iKG3D/s1SrIpQ8jsNs9Jq9aJbgzZB
         PaKHsjoGZJv90+QJ1sP1mQi5DWm2QVIyW4ZgOKp5saRikyQLkhMKPYjvsWOFZWH0IdpB
         vEeFVtw90suE/yzWqr7nHbRv8dbA3Knz+e77dNl7qRjo5rHlKqaR/Y5ivc96smR98YXf
         fZpYvfkQMujd3gRURvMDS7FkqUj7FoD78qUfiMUi9OVeFTYkZz1IhQzCF/Nvx6UWI23j
         jaSUHuvJbWFbEJOYU+H2GA/Ta2AWOKtw+1C9T75Spg5WxPXLjMP/Ja88AmJTCunN+kDT
         UODg==
X-Gm-Message-State: AOJu0YzpFa20fTspI8t8x9RShXI4nFTgoNY2lrHxUqEnPWlRtDycE6Fu
	uAZPiJMoPAHtt/qohiFd/JNf3ZRq5O8fsle608jMGD7jfWM8c3HC/eW1Q8K9G1+T
X-Gm-Gg: AZuq6aK8RRizrUuRhrF/2PJZ2EPPPLoJKKBE+24Vff9P3CmNctrl+2t5XopU1cvo7c6
	64BCzMSONkUKE3tVQQzKB4kHLOSUGGOPW9fP8VTRftb7pBk7JDuD4n4MN5txK+jxRxEGOXLUbn1
	xCdU4ZuHUDXHKc1mEnEILsgIDhdxV7AxhU2jPxcss42XbCCmFFkV2L3EC0ao8zrMCAd9/bW508c
	Ifok6dDhw8cd34M17KxLSpg+O1YUOO/UH5to86hS3HqkBlV+PiFriD4uzBTlM7rKm0RwRo9o1SZ
	wXkfEdqCsz1r73jtHm0SMGld9n9hHmUZ/inqpRtFGJWFtcAqPkfDNRQARP+Dtm/c0bA5Spa2Po5
	yGtV/9tcxBzVrc2nM8WLRx9Z3meFDrNRfAh9R8dWy3MIZyWo7z0NQCKyg3GQ4iitSEcc+mxD/nM
	I=
X-Received: by 2002:a5d:5d87:0:b0:435:8d02:b9d2 with SMTP id ffacd0b85a97d-435dd1d45c4mr5492387f8f.60.1769583812747;
        Tue, 27 Jan 2026 23:03:32 -0800 (PST)
Received: from wdesk. ([5.216.7.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce93sm4406837f8f.24.2026.01.27.23.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 23:03:32 -0800 (PST)
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kshitiz.bartariya@zohomail.in,
	Mahdi Faramarzpour <mahdifrmx@gmail.com>
Subject: [PATCH net-next] udp: add drop count for packets in udp_prod_queue
Date: Wed, 28 Jan 2026 10:33:11 +0330
Message-Id: <20260128070311.48892-1-mahdifrmx@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,zohomail.in];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254121-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahdifrmx@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7DB79D938
X-Rspamd-Action: no action

This commit adds SNMP drop count increment for the packets in
per NUMA queues which were introduced in commit b650bf0977d3
("udp: remove busylock and add per NUMA queues"). note that SNMP
counters are incremented currently by the caller for skb. And
that these skbs on the intermediate queue cannot be counted
there so need similar logic in their error path.

Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
---
v6:
  - increasing a single counter based on socket family
v5: https://lore.kernel.org/netdev/20260122185357.50922-1-mahdifrmx@gmail.com/
  - check if drop counts are non-zero before increasing countrers
v4: https://lore.kernel.org/netdev/20260108102950.49417-1-mahdifrmx@gmail.com/
  - move all changes to unlikely(to_drop) branch
v3: https://lore.kernel.org/netdev/20260105114732.140719-1-mahdifrmx@gmail.com/
  - remove the unreachable UDP_MIB_RCVBUFERRORS code
v2: https://lore.kernel.org/netdev/20260105071218.10785-1-mahdifrmx@gmail.com/
  - change ENOMEM to ENOBUFS
v1: https://lore.kernel.org/netdev/20260104105732.427691-1-mahdifrmx@gmail.com/
---
 net/ipv4/udp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ffe074cb5..dd302f5fb 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1797,10 +1797,13 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 			skb = to_drop;
 			to_drop = skb->next;
 			skb_mark_not_on_list(skb);
-			/* TODO: update SNMP values. */
 			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
 		}
 		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, (sk->sk_family == PF_INET)),
+			       UDP_MIB_MEMERRORS, nb);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, (sk->sk_family == PF_INET)),
+			       UDP_MIB_INERRORS, nb);
 	}
 
 	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
-- 
2.34.1



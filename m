Return-Path: <netdev+bounces-248036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBB1D023A1
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 11:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A897B300A99C
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 10:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435ED4A65FB;
	Thu,  8 Jan 2026 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW3W4SQb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7458E4A65C5
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868226; cv=none; b=OQLZzEBH4SJOyCmClqO+x2qUaOft2tw+ulxnktkKHatJCFYZvcvwXO+8lbWiLgImAzrM/LwVIV3wtgRq2DE80mf2GYhpItQlWlmpl8LYYUBvsp9clgJERm7KcovtZ5whsl95VvwitwK7J1VpznJr213VCfiCn9MwO3cxcMrOhVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868226; c=relaxed/simple;
	bh=0uipFis8wkUJAtInCuFtvgsW07eWYLoNh0PbJv7jezw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dptBTxrU1bhFexZgHXoFckOQ8Wug3Q48jTFXGxQIoJR2b1TbKYX9+mkvaVE/o210IvWerGMOlI4KmxErSdnSYCX4UtTcKXOgURO/3rtLAIvpCRsv5NcWf/9lSxSElDadBFGwtpf7cljXJ66+6RqRthAtM3mAoUaAO0dj6H3+K58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XW3W4SQb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4327790c4e9so1466219f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 02:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767868222; x=1768473022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JkBZ6sa3GSnCHPRd79ivj9LmwMul58d/usPL6qSpnTU=;
        b=XW3W4SQb5iVJqtnLTg9pXfdIivFVT7sNZolZK0g1e8wR8DXTB7lH/+u/jyTuw4Da2A
         6Un1M1RMzi3TjWkCqXtSiU1MRhTr83UKssbwGNU2y1X5U1mkUeqKZiVuN8Tn8cdbIcOi
         VnPsV85ecwvZGoCdO9zAwhuUrIiwsbHF/yfeixp/UTvV4PZRBpeTNhNkSq0DHAij4CL4
         IsNu5sgJW4XN2S/RJKjTxk+TU1HuVG1E6VKESxmeD9T+Qb+5MrxGlb2MmtrniLtcQG0j
         i9WxJFKVAN+T+b2CgcpqSw4+EKMjVrssUUF1ADCm9Oy3YbzS3kHkQTWbS212qW548kmy
         1q2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868222; x=1768473022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkBZ6sa3GSnCHPRd79ivj9LmwMul58d/usPL6qSpnTU=;
        b=OQ2KyYoaSCoCUhk5gMGjm5gKbEp06D19dE1zP0ChOVVNYyX0fRIxJvBIS/nqn8y7Ua
         egz9xK4Mznu6jm3xv3extQCKZt2XGqnXAcdByNxE08LjFz9VvpH46QGH2MCrmtWqYrNw
         dWaqqiTExrLXnIYjp1t67QCZ/70YQAQyKKTtcvxNATyYi2vpoOXCxNEmqOUJF7CppC5p
         DndKAiaVS1ssbh2zdnocOewahDxh2sgO1/zHdDIBopUEPUzYaBaWxoX/wi5jds29PYcq
         ekTVotmuaNl32HLqVJWAgYNU5l4Vk60s/45snRbJ4h6at+BfBVvKmYqn8Jeyi/qbr3EL
         xRpg==
X-Gm-Message-State: AOJu0YyH8q81iYGDsaoLTfkshqJ3Cqt5dZYSCDBB9c4ogYWEB+jGQziI
	HKER9/VPPvKNhAkD6oflMcm98MUWP12UMjngBBA3PRge4wzvf2hwGoubRRGUHB3ogEk=
X-Gm-Gg: AY/fxX5dbx5Ld0cT57pn1WmLGf6Xq7C9+L3tspNvohuZbCyqLfr80SZVe08cyLSOHOk
	C64II/1MmGY2vI6ls6PxwDRhYGuPWXyV/AXW+/PQubV+gyEhbbodZ8x2h6QsYXWhx8VinOiEZ6W
	quZRXFRxaK+w2J+NAvSEHpkGg/FXAa1prP3JOab2m8WOuYXsx1q0upv1obgTXa8E4MgS3DNXfeH
	PATR/XmvPA10Rr8gxrOHpoFWJZvuwdfuMjjTMOn5A7+p3FUlJNIpl0ps33OvzXwQlbeRdVAcG5z
	ooy0QVSBEny/DD1djDpTDtZlfF8gZtTjRyl+Aqks6pDQs3GsR+8uu+AL1umCjtT6avpTjqQkQaf
	Ri/7IMJkUpwcEU+8XGc75BPshsWDPD0zfE8NinQ5Q7ZRdtGxSkSbrPfjYac+qNtzDXAkE9U4gSM
	ZWhQ==
X-Google-Smtp-Source: AGHT+IFPr6YhwcvospboRe0wf35zEEkDtRS84WRGH9vdKWubsTOEW/0L5BU1GpLdroBE0MFBeH2OJg==
X-Received: by 2002:a05:6000:2509:b0:431:907:f307 with SMTP id ffacd0b85a97d-432c3760e1fmr6815671f8f.48.1767868221924;
        Thu, 08 Jan 2026 02:30:21 -0800 (PST)
Received: from wdesk. ([37.218.240.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5fe67csm15258490f8f.40.2026.01.08.02.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:30:21 -0800 (PST)
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
Date: Thu,  8 Jan 2026 13:59:50 +0330
Message-Id: <20260108102950.49417-1-mahdifrmx@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds SNMP drop count increment for the packets in
per NUMA queues which were introduced in commit b650bf0977d3
("udp: remove busylock and add per NUMA queues").

Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
---
v4:
  - move all changes to unlikely(to_drop) branch
v3: https://lore.kernel.org/netdev/20260105114732.140719-1-mahdifrmx@gmail.com/
  - remove the unreachable UDP_MIB_RCVBUFERRORS code
v2: https://lore.kernel.org/netdev/20260105071218.10785-1-mahdifrmx@gmail.com/
  - change ENOMEM to ENOBUFS
v1: https://lore.kernel.org/netdev/20260104105732.427691-1-mahdifrmx@gmail.com/
---
 net/ipv4/udp.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ffe074cb5..399d1a357 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1705,6 +1705,10 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	unsigned int rmem, rcvbuf;
 	int size, err = -ENOMEM;
 	int total_size = 0;
+	struct {
+		int ipv4;
+		int ipv6;
+	} mem_err_count;
 	int q_size = 0;
 	int dropcount;
 	int nb = 0;
@@ -1793,14 +1797,28 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (unlikely(to_drop)) {
+		mem_err_count.ipv4 = 0;
+		mem_err_count.ipv6 = 0;
 		for (nb = 0; to_drop != NULL; nb++) {
 			skb = to_drop;
+			if (skb->protocol == htons(ETH_P_IP))
+				mem_err_count.ipv4++;
+			else
+				mem_err_count.ipv6++;
 			to_drop = skb->next;
 			skb_mark_not_on_list(skb);
-			/* TODO: update SNMP values. */
 			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
 		}
 		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
+
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_MEMERRORS,
+			       mem_err_count.ipv4);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_INERRORS,
+			       mem_err_count.ipv4);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_MEMERRORS,
+			       mem_err_count.ipv6);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_INERRORS,
+			       mem_err_count.ipv6);
 	}
 
 	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
-- 
2.34.1



Return-Path: <netdev+bounces-194289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE99AC85DC
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 03:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21ADFA414D7
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 01:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F9372606;
	Fri, 30 May 2025 01:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cJGz5rb3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C5613CF9C
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748567067; cv=none; b=bFHWnjZE1/VqfMH6id3Ff9qz16VImY74rpCnNyj76K4UoFZXjFfghWEURqoflfE2NZlQ4yARBebF0EczAPMAnEYPYeZweieI76DA4iDaBGQTQY0XxwC1oI6BaZLu4w1zbxgg/kfKJEjNJW0LPNF6JlE+SMAopy3szBu3CaOuWfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748567067; c=relaxed/simple;
	bh=rX/1ao7p/NvtFeOI1F1MuvMHxeHwAQOnrfHP/4pdlNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J973/LlL5q2ko2RFr9pVq5R7GaY2I//Kcr2T7Sq8lNx9jkpCI2wGn9wIyvgd4+5vc+3nMM/IBDxJWmkOmixcPoYytGfoqpxed8ZCAJtX7to9pkfnsBIfE8WTbCtsOvByjSgL3j2KXN37eX8Zx2WfE3YuzmTkoYQc7fHUxD52f9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cJGz5rb3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7426c44e014so1172489b3a.3
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 18:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748567065; x=1749171865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WMuXhARc7ZPHZfZkbAHNR+JT/HooS/WosQOHTLidIcA=;
        b=cJGz5rb3DOTCYqYu5LY6PFD5btZ1i6JJ0xkCnJ0zqWLqhmY7Dt+IM6Dt+wTbYXLc4i
         WWkr8XCwTFABoG9vkZlHfOSo2VPlzz2elDzxVaHNfryWExz4uAeoz4oKZzCPH5YFcWG1
         ieoK0NMHN2BFswsHVS8m4fcPkCoqs9zt0khl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748567065; x=1749171865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMuXhARc7ZPHZfZkbAHNR+JT/HooS/WosQOHTLidIcA=;
        b=J6GvjMbu1wVkbXG1y2wzDKLrNrRwehZJkOrpRP3LVoks15gJWfi7uPWHcL6IEFjwq+
         SU8gliL6ZYFeaU5R5BUKVYhWK4hbuk/R6YRam1JrMaACN/dtTnYgexRWERvcQZ+aZS3a
         UPa4FsVF52WdbpW0TaxyBQv3WRu9+BIeMx6TMvcaBtMKHwulGdynucZdoVigfDknRq9J
         r7w8IvQ2uHQUZSBMEZr+GD9nXt4vOrQpuIdeQrWLFRfSE1YUlwRDV7LhYgAtcAfiz0kk
         R76sjUnKGsFEVnLArHLxufMREhQuLHB8vqAI71OKTfy87GbWohKv9F/k/CJTe0EqXFlZ
         FAhw==
X-Gm-Message-State: AOJu0YwyUxZhl+xGesUvhQWHtE+dFcH7EZlMwU4TAXvztDqg5GPv0rqT
	Cg8v2lBC0mwUsouAzOXAJqewdrjAlXJu6IXGrfhHljZPubYDkRClFxx46kiBY7gk3EKXYHVVQJs
	Ok1N5H6vrYTUdrKkAqRW1MXfL/ASRgIguhMT93lL59ncoCBdCrzy7w2M56xst1+nid/Arb2RtA+
	2omzdTFARfDY6kZ9LSHWADxt8ZvjE4kd+nDkM7EyBj7cc=
X-Gm-Gg: ASbGnct2PBqnIJEIxhYvgPUGF2Qwwy6T4QRZ400/kJqOrTKPvZlGKIlB1Ubyh1KV40U
	0ctYt08Tyg4o1+RY3FQAE1g/kV+REgZGXvfyJ/lZdvPdDophxGImzgfWwVo+fPHY2aF7vE9KtPe
	RtpRNnPHy3QbhUXgfKB3xvYjQCQuukA7hi7gMyKOLtOKOeYFk7HouaTnV6E2XnV+BK4+SZ0ixRa
	qb4HHRMIuVs8T+DzavqwjwYn/hek/KMjQcJ4cO49kqyKZlpxmf8pB3nomwQhpSRYQ0EZ1RgwwTi
	XVF4hOE0E6R0UqJksyNpeUzvERpZBM86NkxcBqNzRSvb+JuT7r3L4RNcgf1jrf7IK7HVNT9TSQm
	ZUZN1mh/dxQqpNkbhW92qyQ==
X-Google-Smtp-Source: AGHT+IHlk/pQOASPBzEhio0XVuWGW4RALWeN2/BSwN7IXKo0wC2eAk4JY8nDmbRw4+IxZyH616w8PQ==
X-Received: by 2002:a05:6a00:138a:b0:742:a7e3:7c84 with SMTP id d2e1a72fcca58-747bd980c66mr1882310b3a.13.1748567064627;
        Thu, 29 May 2025 18:04:24 -0700 (PDT)
Received: from ubuntu.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeabc8bsm2004400b3a.64.2025.05.29.18.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 18:04:23 -0700 (PDT)
From: Ronak Doshi <ronak.doshi@broadcom.com>
To: netdev@vger.kernel.org
Cc: Ronak Doshi <ronak.doshi@broadcom.com>,
	Guolin Yang <guolin.yang@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3] vmxnet3: correctly report gso type for UDP tunnels
Date: Fri, 30 May 2025 00:46:30 +0000
Message-ID: <20250530004631.68288-1-ronak.doshi@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3d010c8031e3 ("udp: do not accept non-tunnel GSO skbs landing
in a tunnel") added checks in linux stack to not accept non-tunnel
GRO packets landing in a tunnel. This exposed an issue in vmxnet3
which was not correctly reporting GRO packets for tunnel packets.

This patch fixes this issue by setting correct GSO type for the
tunnel packets.

Currently, vmxnet3 does not support reporting inner fields for LRO
tunnel packets. This is fine for now as workaround is to enable
tnl-segmentation offload on the relevant interfaces. This problem
pre-exists this patch fix and can be addressed as a separate future
patch.

Fixes: dacce2be3312 ("vmxnet3: add geneve and vxlan tunnel offload support")
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Acked-by: Guolin Yang <guolin.yang@broadcom.com>

Changes v1-->v2:
  Do not set encapsulation bit as inner fields are not updated
Changes v2-->v3:
  Update the commit message explaining the next steps to address
  segmentation issues that pre-exists this patch fix.
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index c676979c7ab9..287b7c20c0d6 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1568,6 +1568,30 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 	return (hlen + (hdr.tcp->doff << 2));
 }
 
+static void
+vmxnet3_lro_tunnel(struct sk_buff *skb, __be16 ip_proto)
+{
+	struct udphdr *uh = NULL;
+
+	if (ip_proto == htons(ETH_P_IP)) {
+		struct iphdr *iph = (struct iphdr *)skb->data;
+
+		if (iph->protocol == IPPROTO_UDP)
+			uh = (struct udphdr *)(iph + 1);
+	} else {
+		struct ipv6hdr *iph = (struct ipv6hdr *)skb->data;
+
+		if (iph->nexthdr == IPPROTO_UDP)
+			uh = (struct udphdr *)(iph + 1);
+	}
+	if (uh) {
+		if (uh->check)
+			skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
+		else
+			skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL;
+	}
+}
+
 static int
 vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 		       struct vmxnet3_adapter *adapter, int quota)
@@ -1881,6 +1905,8 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 			if (segCnt != 0 && mss != 0) {
 				skb_shinfo(skb)->gso_type = rcd->v4 ?
 					SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
+				if (encap_lro)
+					vmxnet3_lro_tunnel(skb, skb->protocol);
 				skb_shinfo(skb)->gso_size = mss;
 				skb_shinfo(skb)->gso_segs = segCnt;
 			} else if ((segCnt != 0 || skb->len > mtu) && !encap_lro) {
-- 
2.45.2



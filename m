Return-Path: <netdev+bounces-107983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEAD91D5BC
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 03:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF2C1C20C5A
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 01:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94A0125C1;
	Mon,  1 Jul 2024 01:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="FkS0WyYX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334BDF42
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719796893; cv=none; b=kHAl5rF5Vlrfp0qhMquPQyBe+1WDvnOaE3qs5g1Be3e0rPH1u3kOCAOTtIXM8DaN2NcI5B/i1I1TTUMKhK+hgnvQO4kDwxnd+gI/kZFUpvmb22JdhXf9VbwhHtAJ3WyYLoyb6jEB5SZMqu3UbyEbVau8OY6ncOc4Sp3FpeRw3ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719796893; c=relaxed/simple;
	bh=jIuNIafRnFEfCJzX6gQqkI1HAzoXM47rQAVEKRQvo2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e2lq6uePeH8EWeP1QcCh48tvp8dkx5pApQ0h692p7p7B6wdanU+hYvySw77wLsuXC9a5cEyUwIfe2eVzlI30Yn3K8QWfel/DZJcq9W9zHa+TrhHbKKK8IJA8TfPCYb/JCOTf9iAhSM7JAQ0uS1alBHGOJSNjjRpE4OQMYv7AFsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=FkS0WyYX; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70670188420so1479597b3a.2
        for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 18:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1719796892; x=1720401692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuGoCf6HMv4WXYT1IGvtzkbvAJQLRlgnX2FDOCBWTe0=;
        b=FkS0WyYXjRDg5c0IIYJgOXviVM4EVa2wsjDSf78aLmHfPUj3x5XxUx7j3LsjjG4nvF
         VdJ+D/LAH7zskH3T6Q1wIKAFeMYEBGNHAuec358AkzD3pFkbt54G2J3kj62XwL/FMQa5
         kB6hLnxs8WWD7PuCTIIYQbdrtEHcK6ja7TjT0m43yreBAn6wmYoznNZfuTLTQeuEFN1e
         zktIXzGpkum4Fw/cDJ7WO6o1fcBgexho1WZUMk3g+DmQ8tWU4LIMRuyfJ0KIeFdDDNDJ
         gxolkbZ7By9MarsnfyXR1ZJKe8FVmJbi1OzLkRQRvYReXtJHvmwVRHUolclLL7pSf7oe
         Gb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719796892; x=1720401692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuGoCf6HMv4WXYT1IGvtzkbvAJQLRlgnX2FDOCBWTe0=;
        b=Vy+k52JnJSYRONgsjvDkGboXsS23ACSCG+fTqPGoQ5a6HYZnlcGZCvmMYm5XS7INmi
         PMzAwSQeI14GF08VPlt7oSlr5plNJyAXvJIdTj3jvPcvcHsyV82IgZU+nNPGEJzuqETz
         8xWbFP1XV4wf5E5nbJa2Rl9sIlIV9KlCJxLKi/ZVkeMtADTejf5mAh0tml6Ihsog9Vkn
         i0SB4iy1KR6+XVrBv0BtkpRSHQJ/n76O0h9mbP01soNS7q0eLkTRGE8lhQBTggAi+s3a
         X6sln9MUWAHY/kDvqi0Wogha8ls9WycVk6Qqj7h8SwjCQfRznToZUbtD2+NgL8LW9UrP
         Xybw==
X-Forwarded-Encrypted: i=1; AJvYcCVt64srp/h3mrpHPmg0ZzE0LLIpTjCtU8KDOwEYFGpi1b2liRnMCKXopeWAA/P8guV6JY9E1V88NpY4Iake3Za9h9DIIvVP
X-Gm-Message-State: AOJu0YwYomM1zKMe1aWhveXiSGmDdMRytanSSZGMGCAXwFwYeiT7gtt2
	9+hQXwfsc6V0Nm6YZKmrTPjFAReQgfc90sye0Glanju9b48tyNdO+/ZT8NTtJYs2Fij85MY8giu
	0Sw==
X-Google-Smtp-Source: AGHT+IHGYS3ML6BRn75QTYbqg8mym+TkIZbXIJRC7AgT5OhrUFoRvS2iTmiY9rPiyMHcNaoe0YuhpA==
X-Received: by 2002:a05:6a21:3287:b0:1be:cea:d381 with SMTP id adf61e73a8af0-1bef613effcmr3305957637.18.1719796891838;
        Sun, 30 Jun 2024 18:21:31 -0700 (PDT)
Received: from TomsPC.. ([2601:646:8300:25d3:25ec:3900:78b7:fad0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce5490esm5529284a91.24.2024.06.30.18.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 18:21:31 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@sipanda.io>,
	Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next 6/7] hinic: Don't do TX csum offload with routing header present
Date: Sun, 30 Jun 2024 18:21:00 -0700
Message-Id: <20240701012101.182784-7-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701012101.182784-1-tom@herbertland.com>
References: <20240701012101.182784-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tom Herbert <tom@sipanda.io>

When determining if the L4 checksum in an IPv6 packet can be offloaded
on transmit, call ipv6_skip_exthdr_no_rthdr to check for the presence
of a routing header. If a routing header is present, that is the
function return less than zero, then don't offload checksum and call
skb_checksum_help instead.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_tx.c | 23 +++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_tx.c b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
index 9b60966736db..ba6b7481b6fa 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
@@ -357,8 +357,10 @@ static int offload_csum(struct hinic_sq_task *task, u32 *queue_info,
 	u32 offset, l4_len, network_hdr_len;
 	enum hinic_l3_offload_type l3_type;
 	u32 tunnel_type = NOT_TUNNEL;
+	unsigned char *exthdr;
 	union hinic_l3 ip;
 	union hinic_l4 l4;
+	__be16 frag_off;
 	u8 l4_proto;
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
@@ -374,17 +376,15 @@ static int offload_csum(struct hinic_sq_task *task, u32 *queue_info,
 			l3_type = IPV4_PKT_NO_CHKSUM_OFFLOAD;
 			l4_proto = ip.v4->protocol;
 		} else if (ip.v4->version == 6) {
-			unsigned char *exthdr;
-			__be16 frag_off;
-
 			l3_type = IPV6_PKT;
 			tunnel_type = TUNNEL_UDP_CSUM;
 			exthdr = ip.hdr + sizeof(*ip.v6);
 			l4_proto = ip.v6->nexthdr;
 			l4.hdr = skb_transport_header(skb);
-			if (l4.hdr != exthdr)
-				ipv6_skip_exthdr(skb, exthdr - skb->data,
-						 &l4_proto, &frag_off);
+			if (l4.hdr != exthdr &&
+			    ipv6_skip_exthdr_no_rthdr(skb, exthdr - skb->data,
+						      &l4_proto, &frag_off) < 0)
+				goto no_csum_offload;
 		} else {
 			l3_type = L3TYPE_UNKNOWN;
 			l4_proto = IPPROTO_RAW;
@@ -411,6 +411,7 @@ static int offload_csum(struct hinic_sq_task *task, u32 *queue_info,
 			network_hdr_len = skb_network_header_len(skb);
 			break;
 		default:
+no_csum_offload:
 			/* Unsupported tunnel packet, disable csum offload */
 			skb_checksum_help(skb);
 			return 0;
@@ -421,6 +422,16 @@ static int offload_csum(struct hinic_sq_task *task, u32 *queue_info,
 		ip.hdr = skb_network_header(skb);
 		l4.hdr = skb_transport_header(skb);
 		network_hdr_len = skb_network_header_len(skb);
+
+		if (ip.v4->version == 6) {
+			exthdr = ip.hdr + sizeof(*ip.v6);
+			l4_proto = ip.v6->nexthdr;
+			l4.hdr = skb_transport_header(skb);
+			if (l4.hdr != exthdr &&
+			    ipv6_skip_exthdr_no_rthdr(skb, exthdr - skb->data,
+						      &l4_proto, &frag_off) < 0)
+				goto no_csum_offload;
+		}
 	}
 
 	get_inner_l3_l4_type(skb, &ip, &l4, TX_OFFLOAD_CSUM, &l3_type,
-- 
2.34.1



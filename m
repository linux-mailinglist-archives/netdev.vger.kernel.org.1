Return-Path: <netdev+bounces-295961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KVPlJVgnI2oOjgEAu9opvQ
	(envelope-from <netdev+bounces-295961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 21:45:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E51F164B08F
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 21:45:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=I19Bho0F;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295961-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295961-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 629673008A6C
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 19:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9071543E4A6;
	Fri,  5 Jun 2026 19:40:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B1C4418CA
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 19:40:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688452; cv=none; b=Wn55626oQsfwxXdQmNcPzkgrcgjnmyi8F4HYPiBELZsZn8iX5CL0Ud25bId3HChd0wykQ/Ja32Qn6YYPSLNsRbCiSc5WEI77mIfyqiqCjZ9k6ZKPfbMRRi8YKx0KAXqfLAOZ0QUUawPA7204GtNjVXOLEFbZ2pcr1NUhwpaD6cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688452; c=relaxed/simple;
	bh=y/rU4gh0E0L2u/dhKcW9ljUwXNcpqmT4X+WX+7weVWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QT/IdhBm0gQPSjH+4UUoT+3Wd48aylwI+qtCNlrfM3WxfpH7fk2eF5VdA2QG/dfPVfegYp4S0krRHh6GOj5BzWaOli7cA+vsu3+8XpRUN+Cc4RJO4sxYXIlWZkofbOzi8u20HGthzRXDbk3C+NW/X/2/2J0QO1rALgzx7Znmpx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=I19Bho0F; arc=none smtp.client-ip=209.85.219.49
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ce65629acaso26219136d6.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 12:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780688449; x=1781293249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cAFqrVA+AqYfDZqdtHewX5SP2boCxXzf2uI82b8kdGA=;
        b=I19Bho0FtK+r40fAbPnyu4R0jAO4GrbzY5HhGpN3f2/+PaUdhlaZ7CPsiO6Ts4TVa5
         v6UPhnWuGK+A9fGQ0M3oPIv5CbTuMUyFgqXCupP4wdgv79WqYJNP/KuEcd36oORqwz+/
         6PNIwM2P0TVV726vx7nGoWGZSxanBws7mdV52Lf3ACCbP94rsN5RyX98wuQKNsIxd7JI
         1nEaKAxY8qKA5w1l8+zk7BSyOA01eoKyGnxWFv2m1EDFbkWETrkE157giFxIfe4Crz73
         VYQmbJmdpZ4OrLUuf0oEsF28Yf5RtuOSGLPgSIUCx/NFUmjTETAycnwqdlBg2VvIDGDS
         oS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780688449; x=1781293249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAFqrVA+AqYfDZqdtHewX5SP2boCxXzf2uI82b8kdGA=;
        b=AwGz49buA1XLe9Ki/BswkcqG2a6ZrCQc43WRo4nbGvU4CRR/VyqH7DDu9wjNKW95sz
         OyPJh79Kt5mk5cqNYJVXdscYttqOr/DdShCwqVGs3LFuCAyC1mlmJwB3+5RM00waJrrE
         lfjZf4ZJW55ibaAdNpfjeMrYKKHVGxnV77IFRft5E9pCnKvHUc+lx+8YYx+ewteFkQpH
         RdFVQbD6d6TCZmTn3tOPes7yyNM8IQ5OBx03JwzYBXRQilYdvsrPU3xekXJ6fD0oy6kk
         FeqpSpySlhXm01XJofx9sfl2Tzts1wC5E12G+ywM85UTrbljC7IQTrMUlbxTHjj4e9n3
         JkcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/fXbKf9Sl0aZAJ0+ZdDh65V3XbwythDuR5Gxr0wRFbXlSDlmW6ko0ux0JuNPoDxxunj6TLJFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTG4jt7xDZ1G5tNEO+ULUua1g1UxMNantH9GbmrCsn3EFunnCM
	AnUqWkuK19K6nhLTm7VEnNTNFgjShkUiUbto/zzHxd+LGYICu4vQaDFe529ktooSfMw=
X-Gm-Gg: Acq92OHELCZhyinA1805gbBM48P0LTMjvjM47ZbBWNvXIPxBv79i/PCpbwfzNl3k7mt
	Q+wRN4Re7nv+LSDB8nXj8lZhlD3/c8+8koj8EZKe2LBlxemLLm8oL4F7/U4AU5B4IeuDERxFxQN
	RaW5cmcAet5zYZjUHa77itIjROd19GOHnxMdZWWbW/27BQl4NH2QQHAWCFc/JjEkLMzH7Ln3reg
	ad8xkZncOCbxMPyp7VulFZUAbMtiMNeT+jzvztg7NC3AXFh+qRqzpq54s1hU6UP9x2KLpcabU5+
	nqPvXI7IE+lxFSquslQSCGa2f/XElDQvruoYvUrK2BmgGhJupEwuTBuvAcrUFxer/Lkv5goSOre
	UYs0C/decqwQbUShInC4jZ7UZNOCGUvAwh/WYfE+6oNOQV5mUc6GaufvYLBqwxVo5VPBiaS8aH8
	cPaZ0lqWkCqv6DmZhSQVr/pjHheVNMzu7qIa9OIA==
X-Received: by 2002:a05:620a:690d:b0:915:8865:dc01 with SMTP id af79cd13be357-915a9da7f30mr906550385a.46.1780688448992;
        Fri, 05 Jun 2026 12:40:48 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a00afafsm974370785a.2.2026.06.05.12.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 12:40:48 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org (open list:VIRTIO NET DRIVER),
	virtualization@lists.linux.dev (open list:VIRTIO NET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] virtio_net: normalize non-positive napi_weight values
Date: Fri,  5 Jun 2026 19:40:44 +0000
Message-ID: <20260605194045.2625610-1-sam.moelius@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295961-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:sam.moelius@trailofbits.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E51F164B08F

The virtio_net.napi_weight module parameter is signed and is copied
directly into the RX NAPI weight after netif_napi_add_config().

A value of -1 lets virtnet_poll() run with a negative budget.  The RX
loop processes no packets, the unsigned received-vs-budget comparison
completes NAPI, and the NAPI core reports:

NAPI poll function virtnet_poll returned 0, exceeding its budget of -1

The device then repeatedly drops receive progress under stock QEMU
virtio-net traffic.

Normalize non-positive values to the default NAPI weight before
assigning the RX and TX NAPI weights.  TX NAPI can still be disabled
through the separate napi_tx parameter, which intentionally sets the TX
weight to zero.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 drivers/net/virtio_net.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f4adcfee7a80..667026607cfa 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -6481,6 +6481,7 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 static int virtnet_alloc_queues(struct virtnet_info *vi)
 {
 	int i;
+	int weight = napi_weight > 0 ? napi_weight : NAPI_POLL_WEIGHT;
 
 	if (vi->has_cvq) {
 		vi->ctrl = kzalloc_obj(*vi->ctrl);
@@ -6500,10 +6501,10 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
 		vi->rq[i].pages = NULL;
 		netif_napi_add_config(vi->dev, &vi->rq[i].napi, virtnet_poll,
 				      i);
-		vi->rq[i].napi.weight = napi_weight;
+		vi->rq[i].napi.weight = weight;
 		netif_napi_add_tx_weight(vi->dev, &vi->sq[i].napi,
 					 virtnet_poll_tx,
-					 napi_tx ? napi_weight : 0);
+					 napi_tx ? weight : 0);
 
 		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
 		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
-- 
2.43.0



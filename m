Return-Path: <netdev+bounces-249828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA5ED1EC45
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 783A930A426C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDE4397AC6;
	Wed, 14 Jan 2026 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1i75yib"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49123396D3E
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393588; cv=none; b=i8elU5Cx6Mh/shbj0WZh+RrKmfhp39H1AOwD7IBzIUPex2Fc1OGvftWk5rDes7zPlbHRMR2ROKBIyV48zndcKG5E++PXZ+6CRyU/nmbw8fOOvQXGwV0vtTpH5G5pRWMAjXm/u+Yzr5OHqEVSUcjM5eG74zKLPaR9D1P2VtTCCZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393588; c=relaxed/simple;
	bh=JEDnlZYXIHilnOnTePLHzYAZD0ZmBByyDO4WzTOYCCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PXn+Y9VuUe1BvNEPXkPK3lUTAow2IrL3oQqY8rCxXwSSZsLrCxVeaqOcv3FPQVgtIWEWoJ7doewjHrdOrRkr4zOiNUFk57ajCyD61Co1xVO2TWxx1rZ72LzbFPzEKrFT9CLMQPaQjfyhOmo30/R9mh0R1bwRKzaKbKA96h/K+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1i75yib; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29f0f875bc5so67940185ad.3
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 04:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768393584; x=1768998384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AbzNlyftwKRg9xsu0MFnIl7dchtZzqwBBSHtb8zwf2M=;
        b=b1i75yibxVgOr/Wjjc2QVYZnW3+jOTNz6BFEGAG0QuwV6TL7zfwc22aNfLk3bcD56o
         NYZ9Gop1frF7BfSHJnfDOf4NwWmYpMqbppapjspV4Zc2fYa0lPtlZJrXfE8W964peLnj
         mTiomx4X7nHZFwNFMwyz6REat4rCwtlnqhTCRKeD3OXumaxEHD0rMZED3xnu9VzYku2m
         Z3PpUFVzZ4YNYJZfIlsVdCA4+Y/G4fWGxsVj9EUB2H2OskVHbQGyjH1yatTkPWndV2Q+
         ZwvYKgRZQP1B9CUhhzr3PCz7aV9NsjYdW5dyomLar7sp8Bqkip+p890a0DvNf/s8lI03
         3jJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768393584; x=1768998384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbzNlyftwKRg9xsu0MFnIl7dchtZzqwBBSHtb8zwf2M=;
        b=YW9rYzF2BnFSBv8q3aX+LXEYBQOUqWI6AGWbCt9PYpwVSq2tksO0glASmTrIaal/8t
         PgWGovv0wa8dzsx1lH3Frd9U7bKbRhk4RxGWvJWajRXIRIDnhco44dPykRzi1QuU9U23
         AfITF7D4gmjw+O4A4DBBLlqwMPKFQxZAeXl/y6jIkQADhsOt/ugHZkaFJjaj/fkFI6uR
         0B7vxAJQgi/6356nS858yFmIz/dzt2r2tC1ChKBvz+DnMJ/Gy8XzlqosDERCfFbxPxaO
         IL4CD1ifpu8Jmstni1n+Y8XhpyiPYZ/0EoZfKw9N2pJvPTxoJ9beTOZe2hx4nOIfXwbm
         Vseg==
X-Gm-Message-State: AOJu0YytRobQjmEFzxrX12GFh/ZDBk45ansZN6LYvVUYSXRz8VBaQvBv
	X4NltxuPhfXZBVWTxnaCl02GYXCIA4MB6nzuCmUYFARmPQgBQryXygUFEflZVQ==
X-Gm-Gg: AY/fxX5jc/KOIysb10u4sEjV/3VpIEA1SWAzj4CbqafwS6VMES8mCKlEIPDfhMzY2z8
	1MtwHbDHXGY0zZL2JMFqLsXpb0afTrYqGMQWEs0uvPc249jeYBA8pl+BZVF/GSMwtO40N0bx/wC
	+MDK9JY1X+3nww8C0yR6zxSom+oL3DzQpiTHA8fnH3OnJXAt/ahPaf3wFFp/Bi1gIvGwKUYb0O4
	ijS+i4+msr5BgD6f/Uf0d+y7vvh0Vk8N27qFtNe2ZYJAv961fv+phfyIaBatHDp46IYaR3yjvyR
	85OumhyEUF6n6OHip304if/tF9zsFe5dk06xT5M0Fy78HZmmm/tODDysfxrTyLEtrzz3rBM+KnX
	1DQxi6aZM7cXDTpJ6tOaHhtamqgHICd/A965Cw8IV2bMsr5iW93/TeODaNHZ9jXmxLQFNE7DZct
	JppUYm0NvirwuiJNd8Nz2X09uOUG0wNQZCvC7rQKxP/fPZSWf4sYCgyg==
X-Received: by 2002:a17:903:40d2:b0:2a0:d34f:aff3 with SMTP id d9443c01a7336-2a59bb36674mr24558905ad.18.1768393584056;
        Wed, 14 Jan 2026 04:26:24 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd4401sm230327115ad.92.2026.01.14.04.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 04:25:57 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next] veth: fix data race in veth_get_ethtool_stats
Date: Wed, 14 Jan 2026 20:24:45 +0800
Message-ID: <20260114122450.227982-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In veth_get_ethtool_stats(), some statistics protected by
u64_stats_sync, are read and accumulated in ignorance of possible
u64_stats_fetch_retry() events. These statistics, peer_tq_xdp_xmit and
peer_tq_xdp_xmit_err, are already accumulated by veth_xdp_xmit(). Fix
this by reading them into a temporary buffer first.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/veth.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 14e6f2a2fb77..9982412fd7f2 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -228,16 +228,20 @@ static void veth_get_ethtool_stats(struct net_device *dev,
 		const struct veth_rq_stats *rq_stats = &rcv_priv->rq[i].stats;
 		const void *base = (void *)&rq_stats->vs;
 		unsigned int start, tx_idx = idx;
+		u64 buf[VETH_TQ_STATS_LEN];
 		size_t offset;
 
-		tx_idx += (i % dev->real_num_tx_queues) * VETH_TQ_STATS_LEN;
 		do {
 			start = u64_stats_fetch_begin(&rq_stats->syncp);
 			for (j = 0; j < VETH_TQ_STATS_LEN; j++) {
 				offset = veth_tq_stats_desc[j].offset;
-				data[tx_idx + j] += *(u64 *)(base + offset);
+				buf[j] = *(u64 *)(base + offset);
 			}
 		} while (u64_stats_fetch_retry(&rq_stats->syncp, start));
+
+		tx_idx += (i % dev->real_num_tx_queues) * VETH_TQ_STATS_LEN;
+		for (j = 0; j < VETH_TQ_STATS_LEN; j++)
+			data[tx_idx + j] += buf[j];
 	}
 	pp_idx = idx + dev->real_num_tx_queues * VETH_TQ_STATS_LEN;
 
-- 
2.51.0



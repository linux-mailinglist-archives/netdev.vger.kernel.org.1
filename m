Return-Path: <netdev+bounces-49768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E73F67F36A0
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 20:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29721C20434
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 19:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F9559161;
	Tue, 21 Nov 2023 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ps8VatJ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944BC20DE4
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 19:09:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E2DC433C7;
	Tue, 21 Nov 2023 19:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700593741;
	bh=PNP7cC07/dqSCbuK3E8a42Exisr/9Hepjuctq0/I9vE=;
	h=From:To:Cc:Subject:Date:From;
	b=ps8VatJ6YmjGBNbrl5/e3IGAFnacaRMMfgdTd/YGyfJMZqgO2BpQ9e5Xi4N3AdTfj
	 McfalGgyuwDN5XL9lQdVBVFpFUfzujQtMZbmAINplwi9e9ur5MM9912Gjefe6fFArV
	 q3/1zsdzPHRJGMOwMSc29TZOvwmWGHV9pEwRsQlckH2LfaN38ey2f0e/qrRr4HN4cc
	 3YSbC0Wk93curUywRkup17/M0ww8aIpwN/Uv90zYoQXJBAgeBYOyKiEslVUbaVANiD
	 gc47/wdwXAN/8oeKvlPiNB1O5FHfeESgtBj7/5dJjuFgvDW5XxK0LOG51pa/+C7FTu
	 3ZNzhGQBsNn8A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lorenzo.bianconi@redhat.com,
	huangjie.albert@bytedance.com,
	toshiaki.makita1@gmail.com
Subject: [PATCH net] net: veth: fix ethtool stats reporting
Date: Tue, 21 Nov 2023 20:08:44 +0100
Message-ID: <c5b5d0485016836448453f12846c7c4ab75b094a.1700593593.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a possible misalignment between page_pool stats and tx xdp_stats
reported in veth_get_ethtool_stats routine.
The issue can be reproduced configuring the veth pair with the
following tx/rx queues:

$ip link add v0 numtxqueues 2 numrxqueues 4 type veth peer name v1 \
 numtxqueues 1 numrxqueues 1

and loading a simple XDP program on v0 that just returns XDP_PASS.
In this case on v0 the page_pool stats overwrites tx xdp_stats for queue 1.
Fix the issue incrementing pp_idx of dev->real_num_tx_queues * VETH_TQ_STATS_LEN
since we always report xdp_stats for all tx queues in ethtool.

Fixes: 4fc418053ec7 ("net: veth: add page_pool stats")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/veth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 9980517ed8b0..8607eb8cf458 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -236,8 +236,8 @@ static void veth_get_ethtool_stats(struct net_device *dev,
 				data[tx_idx + j] += *(u64 *)(base + offset);
 			}
 		} while (u64_stats_fetch_retry(&rq_stats->syncp, start));
-		pp_idx = tx_idx + VETH_TQ_STATS_LEN;
 	}
+	pp_idx = idx + dev->real_num_tx_queues * VETH_TQ_STATS_LEN;
 
 page_pool_stats:
 	veth_get_page_pool_stats(dev, &data[pp_idx]);
-- 
2.42.0



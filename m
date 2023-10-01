Return-Path: <netdev+bounces-37251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D58B7B4710
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 13:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5CF7C28202B
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 11:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240F9168AC;
	Sun,  1 Oct 2023 11:07:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BE016408
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 11:07:36 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA636D8
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 04:07:32 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id muIKqTqNAm6tamuIKq8U2z; Sun, 01 Oct 2023 13:07:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1696158450;
	bh=vnDdg5+DzhgdjgHe7taJV26QihvlT8zptPXcuelUK94=;
	h=From:To:Cc:Subject:Date;
	b=nPaerTM624Q5KEjxgJswqeFpq5OhcBol67sFbIhkVF77GVRMUBXpY0DwuSsqJOOTn
	 wVoZtLnsn5JrD9WKvVwo47eqbRqe37LfBdvE372lstTMcBReVX5Ne/KYW0ECHitHIG
	 BiMgTnyMEZlatR/fk9sP4bO8zUmQE/nRZaUza69inlUDs29S+7LqSv5TUVY2+byAZC
	 /Qt14ebRducV3Or2yaSeyn1BR8eYoPair4dsek646jESx9lLw/nO4p8QGHI/x4YLqX
	 ER03VapFfVsNtESQi5WqNOJlKhxDMhW6E9sBbuojDeRTBQzTP5nH/O0hBrRrgtmmf1
	 iNgvxfBcgFv+A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 01 Oct 2023 13:07:30 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: keescook@chromium.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org,
	dev@openvswitch.org
Subject: [PATCH net-next 1/2] net: openvswitch: Use struct_size()
Date: Sun,  1 Oct 2023 13:07:22 +0200
Message-Id: <8be59c9e06fca8eff2f264abb4c2f74db0b19a9e.1696156198.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use struct_size() instead of hand writing it.
This is less verbose and more robust.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is IMHO more readable, even if not perfect.

However (untested):
+	new = kzalloc(size_add(struct_size(new, masks, size),
			       size_mul(sizeof(u64), size)), GFP_KERNEL);

looks completely unreadable to me.
---
 net/openvswitch/flow_table.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 4f3b1798e0b2..d108ae0bd0ee 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -220,16 +220,13 @@ static struct mask_array *tbl_mask_array_alloc(int size)
 	struct mask_array *new;
 
 	size = max(MASK_ARRAY_SIZE_MIN, size);
-	new = kzalloc(sizeof(struct mask_array) +
-		      sizeof(struct sw_flow_mask *) * size +
+	new = kzalloc(struct_size(new, masks, size) +
 		      sizeof(u64) * size, GFP_KERNEL);
 	if (!new)
 		return NULL;
 
 	new->masks_usage_zero_cntr = (u64 *)((u8 *)new +
-					     sizeof(struct mask_array) +
-					     sizeof(struct sw_flow_mask *) *
-					     size);
+					     struct_size(new, masks, size));
 
 	new->masks_usage_stats = __alloc_percpu(sizeof(struct mask_array_stats) +
 						sizeof(u64) * size,
-- 
2.34.1



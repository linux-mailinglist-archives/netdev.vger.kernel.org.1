Return-Path: <netdev+bounces-14091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D4E73ED49
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 23:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F341C20A15
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6BC15AFC;
	Mon, 26 Jun 2023 21:50:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A87156F8
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 21:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9950C433C9;
	Mon, 26 Jun 2023 21:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687816233;
	bh=+mGPmVImVmnHPmBxcq1rpE9b+jtRaLLokiwmSd7WHc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NvZsTGBz1mvVhAPNJ/FDbaFn7F3hEJS6orRjFK97/FsQDf3CUbpy4c49T1mUxw86+
	 1O50K3Svw+Nlk7SKVsUkSC/SBlKCl1YWlZLc5i8Aa5UYc9Z+KPspSQMUj5eIH27zrL
	 1QlWeAVfjDdAIDVMRGO6wjVk/qOWqdlOSiEggO1wxX7XjVN8sNCCXC0ct4A6Lbgn27
	 lNTaRy2wIma1LOTZ1kfcem8Ldrdb1TGeUC5fQ1DWenfaj34Wsef/pSPBUm6aAr7OTi
	 YtrXO0PB4dZTMMMtxMi6JAuLts//cSPRggYNsbIMqXHMIAtDrd+T2r93rBmkPVDq2y
	 8bESwnMhB1J8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/15] wifi: mac80211: Use active_links instead of valid_links in Tx
Date: Mon, 26 Jun 2023 17:50:18 -0400
Message-Id: <20230626215031.179159-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215031.179159-1-sashal@kernel.org>
References: <20230626215031.179159-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.35
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 7b3b9ac899b54f53f7c9fc07e1c562f56b2187fa ]

Fix few places on the Tx path where the valid_links were used instead
of active links.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230608163202.e24832691fc8.I9ac10dc246d7798a8d26b1a94933df5668df63fc@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 763cefd0cc268..2f9e1abdf375d 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4391,7 +4391,7 @@ static void ieee80211_mlo_multicast_tx(struct net_device *dev,
 				       struct sk_buff *skb)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-	unsigned long links = sdata->vif.valid_links;
+	unsigned long links = sdata->vif.active_links;
 	unsigned int link;
 	u32 ctrl_flags = IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX;
 
@@ -5827,7 +5827,7 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 		rcu_read_unlock();
 
 		if (WARN_ON_ONCE(link == ARRAY_SIZE(sdata->vif.link_conf)))
-			link = ffs(sdata->vif.valid_links) - 1;
+			link = ffs(sdata->vif.active_links) - 1;
 	}
 
 	IEEE80211_SKB_CB(skb)->control.flags |=
@@ -5863,7 +5863,7 @@ void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
 		band = chanctx_conf->def.chan->band;
 	} else {
 		WARN_ON(link_id >= 0 &&
-			!(sdata->vif.valid_links & BIT(link_id)));
+			!(sdata->vif.active_links & BIT(link_id)));
 		/* MLD transmissions must not rely on the band */
 		band = 0;
 	}
-- 
2.39.2



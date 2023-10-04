Return-Path: <netdev+bounces-37981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 002947B8299
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 16:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D32B11C2087B
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC90C12B76;
	Wed,  4 Oct 2023 14:44:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E07D279
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 14:44:28 +0000 (UTC)
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Oct 2023 07:44:27 PDT
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE98AB;
	Wed,  4 Oct 2023 07:44:26 -0700 (PDT)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
	by tretyak2.mcst.ru (Postfix) with ESMTP id 514B1102397;
	Wed,  4 Oct 2023 17:38:45 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
	by tretyak2.mcst.ru (Postfix) with ESMTP id 4BB9D102395;
	Wed,  4 Oct 2023 17:38:00 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.63.223])
	by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 394Ebxp3003157;
	Wed, 4 Oct 2023 17:37:59 +0300
From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [lvc-project] [PATCH] wifi: mac80211: fix buffer overflow in ieee80211_rx_get_bigtk()
Date: Wed,  4 Oct 2023 17:37:40 +0300
Message-Id: <20231004143740.40933-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.0.152.ga5737674b6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
	 bases: 20111107 #2745587, check: 20231004 notchecked
X-AV-Checked: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If 'idx' is 0, then 'idx2' is -1, and arrays 
will be accessed by a negative index. 

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 net/mac80211/rx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e751cda5eef6..e686380434bd 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1868,10 +1868,13 @@ ieee80211_rx_get_bigtk(struct ieee80211_rx_data *rx, int idx)
 		key = rcu_dereference(rx->link_sta->gtk[idx]);
 	if (!key)
 		key = rcu_dereference(rx->link->gtk[idx]);
-	if (!key && rx->link_sta)
-		key = rcu_dereference(rx->link_sta->gtk[idx2]);
-	if (!key)
-		key = rcu_dereference(rx->link->gtk[idx2]);
+
+	if (idx2 >= 0) {
+		if (!key && rx->link_sta)
+			key = rcu_dereference(rx->link_sta->gtk[idx2]);
+		if (!key)
+			key = rcu_dereference(rx->link->gtk[idx2]);
+	}
 
 	return key;
 }
-- 
2.30.2



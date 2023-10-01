Return-Path: <netdev+bounces-37234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B6E7B4589
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 08:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 89D2EB20BE1
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 06:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6815A9473;
	Sun,  1 Oct 2023 06:09:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980518F60
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 06:09:10 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95D6D8
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 23:09:05 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id mpdVqDSB9FUAImpdVqisEq; Sun, 01 Oct 2023 08:09:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1696140543;
	bh=dEigoJc9Nj/oPsIwmLuIjy2oFl0OjwHYbc4E9ZX/Nhc=;
	h=From:To:Cc:Subject:Date;
	b=LPUhQqzMzF6cS/lswRtOb/1RTdGXjkT08HH/DJUjRRUjg76PNQ33CONA4z+vf33Gk
	 H3BJsiIKPtpLOchk8aPfC51NJFperyvTW2uIU7MBWb65nggYTgiJ3vFphZpJpzQoaY
	 8+CMhkhsdNVqsxCewuk5aJoO+R3Eac+MrwfYSo6Yb7f5a6XgdiJ6xRVY3Lw1GWbecL
	 NBtbDrZQ9Hi+nv4EXzgmXHBRL2Byp567km9A6HWuXLuQXfw2uq2A3UH6bqsBz2lS2T
	 wspaRQQVkVfFF0vS2AXX3621J1I1iv7AaaWlCB35VU9i+yPVV4wLZpJTyPSBLz9xY2
	 zm/igHjt+6J9g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 01 Oct 2023 08:09:03 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH wireless] wifi: mac80211: Fix a memory leak in ieee80211_key_link()
Date: Sun,  1 Oct 2023 08:08:59 +0200
Message-Id: <cd52eee26b2afd7823b58654d73ef631ad2930e3.1696140396.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 5d6020ba6657 seems to be conflicting with d097ae01ebd4 and what
used to "goto out" now ends with a direct return.

Restore the expected behavior.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is here more to draw attention to something that looks wrong
because of a merge conflict.

If there is really an issue, then the commit description certainly need to
we improved, by someone that know the recent changes better than me.
---
 net/mac80211/key.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 2913c6b13558..af74d7f9d94d 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -910,8 +910,10 @@ int ieee80211_key_link(struct ieee80211_key *key,
 	 * Silently accept key re-installation without really installing the
 	 * new version of the key to avoid nonce reuse or replay issues.
 	 */
-	if (ieee80211_key_identical(sdata, old_key, key))
-		return -EALREADY;
+	if (ieee80211_key_identical(sdata, old_key, key)) {
+		ret = -EALREADY;
+		goto out;
+	}
 
 	key->local = sdata->local;
 	key->sdata = sdata;
-- 
2.34.1



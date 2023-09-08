Return-Path: <netdev+bounces-32649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D83E2798E0E
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DE8281BE6
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9CC16416;
	Fri,  8 Sep 2023 18:19:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F87C16417
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6219EC43397;
	Fri,  8 Sep 2023 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694197143;
	bh=H+t5+9GD/ikDTM+ovHHOvZiQjjd5x0i/Y0udP52tLYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E70w1a/TJo6YQ48799LpDiPlYqIG3ZnDvJocyLBmE9qBnfcLKhQdqJROvPka4KXNG
	 WLNVD0ekwNBlR7BD0Qid58oHXs3I5i9uuJ6SK5i0+ratDSkl+t/XZ5/L+MBnxrkabr
	 Mefq5/C0g3gJ3wtV+QI6j9DdS6n1otoojlrb6LdipQr58NZtzFpX9v8oMfFU6KNhrJ
	 DMn9fezpF/oyN5WLzNk30TKX3mVHv40cjwXpOh6VfxZUOrM1xFEnOuJUZgT/TkJN1e
	 cKtsMsqV0T/Ay2RVjv7xrPrgOGGPeZRy41y4G5gXdnB1ocVjaMW3Mhk5hD4NQ+q8OO
	 x9EaSvPtKWR9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+be9c824e6f269d608288@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 19/26] wifi: mac80211: check S1G action frame size
Date: Fri,  8 Sep 2023 14:17:57 -0400
Message-Id: <20230908181806.3460164-19-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181806.3460164-1-sashal@kernel.org>
References: <20230908181806.3460164-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 19e4a47ee74718a22e963e8a647c8c3bfe8bb05c ]

Before checking the action code, check that it even
exists in the frame.

Reported-by: syzbot+be9c824e6f269d608288@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 0f81492da0b46..3bebf28ea7464 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3623,6 +3623,10 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			break;
 		goto queue;
 	case WLAN_CATEGORY_S1G:
+		if (len < offsetofend(typeof(*mgmt),
+				      u.action.u.s1g.action_code))
+			break;
+
 		switch (mgmt->u.action.u.s1g.action_code) {
 		case WLAN_S1G_TWT_SETUP:
 		case WLAN_S1G_TWT_TEARDOWN:
-- 
2.40.1



Return-Path: <netdev+bounces-32623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3429F798CAA
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4EE1C20C89
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D710114AB8;
	Fri,  8 Sep 2023 18:15:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D0914F83
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA25BC116CB;
	Fri,  8 Sep 2023 18:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694196901;
	bh=etr5nO4R+vHEYa++IHNZ0E9/ZO5rmMXZRBBrn74Gy7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OIzYIXbJWO1azP/yzsPMUmk8JRTCEG8LqlaIRA7MJkgFgI+aGqoIARXofm7Bv1HZi
	 jopJklz37nNE/ffdi0vZKjd5zfMlFnwGzytY1Xb8L8Q0Luv1yPlomSelMV4iA3eFQV
	 j5rSDJ3Rs22KPWNTw3JYhASnMok9PBNp9i/MgSOZQlmHKfSCGc9Hqis+1kXdI00j5c
	 XgFVSZ4vJgAHZY9NTUJy7M1nDSHYu71nRDfTbcbpczV0W76cUdr6kDRJqgP7+gTp30
	 txm73ltxZKnNc5/PFuiDCKUSfsi5uIMwtRdlseboYVgEhULOemCFiXuuSBL9egM9VR
	 LNpVbNibpVwxQ==
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
Subject: [PATCH AUTOSEL 6.5 32/45] wifi: mac80211: check S1G action frame size
Date: Fri,  8 Sep 2023 14:13:13 -0400
Message-Id: <20230908181327.3459042-32-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181327.3459042-1-sashal@kernel.org>
References: <20230908181327.3459042-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
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
index 0af2599c17e8d..e751cda5eef69 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3734,6 +3734,10 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
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



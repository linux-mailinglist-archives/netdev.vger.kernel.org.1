Return-Path: <netdev+bounces-32636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1407B798D97
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3A0281CB9
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A7814F89;
	Fri,  8 Sep 2023 18:17:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1EE14A9C
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34969C4AF5C;
	Fri,  8 Sep 2023 18:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694197032;
	bh=K+87wGbBIG8R/JLnLUmopLiZrnwsNdzcud+lzXhjtJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJbizOngow250WZ/jWpr21wpfEkmRWtUfhJFAMrtJuYjJFc4xvyuP+RSdOQizUm5V
	 y7oQzYuu4tfBoKuPMHXaJ/aMS0LhkEH/egCUQGgw8+DSH+geRJ70nQnQxZw8brd32M
	 oEBZ/wZin6V+bo2qRFiXyCDYtXaCn7g3RaDNiQlGw1Tkq8BzFI39uPpuewSK8xvdWJ
	 EXfbZlIBQ9nuKhtoV4Oga+kK2p8d3JYs4D++NwL4Y83toWek0VT5/gRIT6wZElUN6J
	 ZVGuNgzsYFt15PjFpFO5HHG+KjpeOqJEvBcMvMuZ1sidQAV0kDf5/uC1OH0Phd8Haa
	 4VifXhKalVyvA==
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
Subject: [PATCH AUTOSEL 6.4 29/41] wifi: mac80211: check S1G action frame size
Date: Fri,  8 Sep 2023 14:15:43 -0400
Message-Id: <20230908181555.3459640-29-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
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
index fc6e130364da1..8580caa470d6d 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3713,6 +3713,10 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
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



Return-Path: <netdev+bounces-32627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9745798CE9
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75251C20D89
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BA515494;
	Fri,  8 Sep 2023 18:15:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE9115491
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46387C116D4;
	Fri,  8 Sep 2023 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694196910;
	bh=4HKDkTtC4tOIWsd2cApCbbBMtlwvL78yXaFUdzme9NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UkSZjNTLjqzPwyE65J50JBK7sFAnyMsr0QvUM/iUT58eSS6pQkSjgIA8ka36xlWLa
	 MHCpqXex9uKmleMaxxtlXH3fWv8WkiczIcRj502pWIoQoWIRQbfssJr9x3IeM3CF+8
	 osw4Us5HggeHBgYnZfVpEG9cJqmLq28Fd05ujzTIJCFu/jxh8T2miB553yDtjhWgFm
	 lnJv2Z1QIVe4ymXj6KmqebMJQcF7u+n1R6pNe1QPShzUJjTA6D7+41rCK7pjDiAlbD
	 h+0eCX5IYzJFCSXMJVw22EHHhZJOhPrEFx3RODwJ+sQM8UIU26NzwOQPguGKF/lhL7
	 cA4LrYo0HGNng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+999fac712d84878a7379@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 36/45] wifi: mac80211: check for station first in client probe
Date: Fri,  8 Sep 2023 14:13:17 -0400
Message-Id: <20230908181327.3459042-36-sashal@kernel.org>
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

[ Upstream commit 67dfa589aa8806c7959cbca2f4613b8d41c75a06 ]

When probing a client, first check if we have it, and then
check for the channel context, otherwise you can trigger
the warning there easily by probing when the AP isn't even
started yet. Since a client existing means the AP is also
operating, we can then keep the warning.

Also simplify the moved code a bit.

Reported-by: syzbot+999fac712d84878a7379@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e7ac246038925..953f24166ffcf 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4133,19 +4133,20 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 	mutex_lock(&local->mtx);
 
 	rcu_read_lock();
+	sta = sta_info_get_bss(sdata, peer);
+	if (!sta) {
+		ret = -ENOLINK;
+		goto unlock;
+	}
+
+	qos = sta->sta.wme;
+
 	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (WARN_ON(!chanctx_conf)) {
 		ret = -EINVAL;
 		goto unlock;
 	}
 	band = chanctx_conf->def.chan->band;
-	sta = sta_info_get_bss(sdata, peer);
-	if (sta) {
-		qos = sta->sta.wme;
-	} else {
-		ret = -ENOLINK;
-		goto unlock;
-	}
 
 	if (qos) {
 		fc = cpu_to_le16(IEEE80211_FTYPE_DATA |
-- 
2.40.1



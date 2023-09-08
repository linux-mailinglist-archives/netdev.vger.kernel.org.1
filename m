Return-Path: <netdev+bounces-32638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41498798D99
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714C41C20D0A
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B45156F6;
	Fri,  8 Sep 2023 18:17:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18000156EC
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5153AC433AD;
	Fri,  8 Sep 2023 18:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694197038;
	bh=2X9oBDQXOi1jWu1cYSLv33GlMJqWE5MwYaLjhX1AWh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sDNzF5IwUM/BGkxmrQ+TBxMwABVzSa6aLDpfiku5YY6KzlovYmTrCP438F3inYfiN
	 RvVwiZ/dEkE6IoMWlWFBgmKjtjO8XuokvOvRL0TF+nfkAYoxTuSWDFVpJfPcisc4Ye
	 680WFxs1lTIlC2CWz9gZakdwfXvtjhNIsO1ZlNRKlKLfIaTyJfLjqRF2H0FZGPhjE3
	 RZID6az65uPEMIApgsqUeYHGdR6+VYFCMLo+lxDYrrOok+i5y5pIY0GfkcTAIS5kHJ
	 unmXkyfVA40R7tiERVpFI+8p4qx7O+NFOYJ6zXd13tR27Si8M7uwn77fJy37945wDm
	 DBfPm3NuIgo6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+2676771ed06a6df166ad@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 31/41] wifi: cfg80211: reject auth/assoc to AP with our address
Date: Fri,  8 Sep 2023 14:15:45 -0400
Message-Id: <20230908181555.3459640-31-sashal@kernel.org>
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

[ Upstream commit 5d4e04bf3a0f098bd9033de3a5291810fa14c7a6 ]

If the AP uses our own address as its MLD address or BSSID, then
clearly something's wrong. Reject such connections so we don't
try and fail later.

Reported-by: syzbot+2676771ed06a6df166ad@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/mlme.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index ac059cefbeb39..775cac4d61006 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -281,6 +281,11 @@ int cfg80211_mlme_auth(struct cfg80211_registered_device *rdev,
 	    ether_addr_equal(req->bss->bssid, wdev->u.client.connected_addr))
 		return -EALREADY;
 
+	if (ether_addr_equal(req->bss->bssid, dev->dev_addr) ||
+	    (req->link_id >= 0 &&
+	     ether_addr_equal(req->ap_mld_addr, dev->dev_addr)))
+		return -EINVAL;
+
 	return rdev_auth(rdev, dev, req);
 }
 
@@ -335,6 +340,9 @@ int cfg80211_mlme_assoc(struct cfg80211_registered_device *rdev,
 			if (req->links[i].bss == req->links[j].bss)
 				return -EINVAL;
 		}
+
+		if (ether_addr_equal(req->links[i].bss->bssid, dev->dev_addr))
+			return -EINVAL;
 	}
 
 	if (wdev->connected &&
@@ -342,6 +350,11 @@ int cfg80211_mlme_assoc(struct cfg80211_registered_device *rdev,
 	     !ether_addr_equal(wdev->u.client.connected_addr, req->prev_bssid)))
 		return -EALREADY;
 
+	if ((req->bss && ether_addr_equal(req->bss->bssid, dev->dev_addr)) ||
+	    (req->link_id >= 0 &&
+	     ether_addr_equal(req->ap_mld_addr, dev->dev_addr)))
+		return -EINVAL;
+
 	cfg80211_oper_and_ht_capa(&req->ht_capa_mask,
 				  rdev->wiphy.ht_capa_mod_mask);
 	cfg80211_oper_and_vht_capa(&req->vht_capa_mask,
-- 
2.40.1



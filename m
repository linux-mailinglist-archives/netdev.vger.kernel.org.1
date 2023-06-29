Return-Path: <netdev+bounces-14490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AF9741EED
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 05:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C93B1C204E8
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 03:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC52D1FD7;
	Thu, 29 Jun 2023 03:54:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6811FB9
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:54:02 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561BE2D7B
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 20:54:00 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666ecf9a081so236887b3a.2
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 20:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688010840; x=1690602840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PgRCWuAL+JILQAuJVgnpzN1VGDR5+ycwundGmuPsvAc=;
        b=Zp7/05od1Hzmg3DamsY4xVwfn6tMykIurlQXX5Rz4Xuof4ze/XQSv561GpHeqSpoKh
         2v+EzzaIXKRz/2+ZwPdbePYm00aj+7lpLYrNJ4hAYEhBfPYw1efyvEasC85ra7aPmZY2
         HvVIPX6DZQ3ldkpxDKKby+eFfCylabLuTSQA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688010840; x=1690602840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PgRCWuAL+JILQAuJVgnpzN1VGDR5+ycwundGmuPsvAc=;
        b=OXfkRUWV3twp0OR+x4Edaawv77H7aklA7J+YDCNgYUxhINMyDvB0jz81+H3wRZUJZ5
         x7ZlpP0DG3XTooMRxLLSgXAtSDrMWDUHZ9bUQponUy9Eo0WbON13EP0Zc/c+V+MCvP1W
         8FHjXDJiIeVd69aRwUgpczNzjF2Py09vH+8QMT1/7e8i0q0Iix8V+USug8Pt1XK0xLKb
         PI4E44TsdE5mWaKpddfJe2rpNYFRh1aT8Iarlt212DmpRCuSAFB+hZEO+8RtnDrrr7a0
         qte9Gkqf1aabSWhoeTO3K4mSeYAlU/IHoi1rGjOh1f+ldEpEMs5Xp6GuDWKGOehu8Zfv
         uzrg==
X-Gm-Message-State: AC+VfDwduqRKvDqP7jKSUW/Zd5Inj44a9wzrmyvkfc+0094YAAIzN7x3
	tFijgfGl+ZuoykUaefztx0bPSQ==
X-Google-Smtp-Source: ACHHUZ6y8ticW17Bm2FXqsOoVj+oMchk8icLpia+Wu94tK8W+NMrPIcN6NkM7fNXF21kuk4TIlr51g==
X-Received: by 2002:a05:6a20:1605:b0:115:83f:fce1 with SMTP id l5-20020a056a20160500b00115083ffce1mr48159642pzj.5.1688010839715;
        Wed, 28 Jun 2023 20:53:59 -0700 (PDT)
Received: from kuabhs-cdev.c.googlers.com.com (242.67.247.35.bc.googleusercontent.com. [35.247.67.242])
        by smtp.gmail.com with ESMTPSA id r19-20020a634413000000b005579f12a238sm7019842pga.86.2023.06.28.20.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 20:53:59 -0700 (PDT)
From: Abhishek Kumar <kuabhs@chromium.org>
To: johannes.berg@intel.com,
	kvalo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kuabhs@chromium.org,
	netdev@vger.kernel.org,
	ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 1/2] wifi: cfg80211: call reg_call_notifier on beacon hints
Date: Thu, 29 Jun 2023 03:52:54 +0000
Message-ID: <20230629035254.1.I059fe585f9f9e896c2d51028ef804d197c8c009e@changeid>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently the channel property updates are not propagated to
driver. This causes issues in the discovery of hidden SSIDs and
fails to connect to them.
This change defines a new wiphy flag which when enabled by vendor
driver, the reg_call_notifier callback will be trigger on beacon
hints. This ensures that the channel property changes are visible
to the vendor driver. The vendor changes the channels for active
scans. This fixes the discovery issue of hidden SSID.

Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
---

 include/net/cfg80211.h |  3 +++
 net/wireless/reg.c     | 20 ++++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9e04f69712b1..48e6ebcdacb3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4783,6 +4783,8 @@ struct cfg80211_ops {
  * @WIPHY_FLAG_SUPPORTS_EXT_KCK_32: The device supports 32-byte KCK keys.
  * @WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER: The device could handle reg notify for
  *	NL80211_REGDOM_SET_BY_DRIVER.
+ * @WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON: reg_call_notifier() is called if driver
+ *	set this flag to update channels on beacon hints.
  */
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
@@ -4809,6 +4811,7 @@ enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_5_10_MHZ		= BIT(22),
 	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
 	WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER	= BIT(24),
+	WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON     = BIT(25),
 };
 
 /**
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 26f11e4746c0..c76bfaad650b 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2149,6 +2149,13 @@ static bool reg_is_world_roaming(struct wiphy *wiphy)
 	return false;
 }
 
+static void reg_call_notifier(struct wiphy *wiphy,
+			      struct regulatory_request *request)
+{
+	if (wiphy->reg_notifier)
+		wiphy->reg_notifier(wiphy, request);
+}
+
 static void handle_reg_beacon(struct wiphy *wiphy, unsigned int chan_idx,
 			      struct reg_beacon *reg_beacon)
 {
@@ -2156,6 +2163,7 @@ static void handle_reg_beacon(struct wiphy *wiphy, unsigned int chan_idx,
 	struct ieee80211_channel *chan;
 	bool channel_changed = false;
 	struct ieee80211_channel chan_before;
+	struct regulatory_request *lr = get_last_request();
 
 	sband = wiphy->bands[reg_beacon->chan.band];
 	chan = &sband->channels[chan_idx];
@@ -2181,8 +2189,11 @@ static void handle_reg_beacon(struct wiphy *wiphy, unsigned int chan_idx,
 		channel_changed = true;
 	}
 
-	if (channel_changed)
+	if (channel_changed) {
 		nl80211_send_beacon_hint_event(wiphy, &chan_before, chan);
+		if (wiphy->flags & WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON)
+			reg_call_notifier(wiphy, lr);
+	}
 }
 
 /*
@@ -2325,13 +2336,6 @@ static void reg_process_ht_flags(struct wiphy *wiphy)
 		reg_process_ht_flags_band(wiphy, wiphy->bands[band]);
 }
 
-static void reg_call_notifier(struct wiphy *wiphy,
-			      struct regulatory_request *request)
-{
-	if (wiphy->reg_notifier)
-		wiphy->reg_notifier(wiphy, request);
-}
-
 static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 {
 	struct cfg80211_chan_def chandef = {};
-- 
2.41.0.162.gfafddb0af9-goog



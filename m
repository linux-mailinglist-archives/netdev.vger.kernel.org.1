Return-Path: <netdev+bounces-46422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0347E3C0F
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 13:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F439B20BC2
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 12:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03D32E62B;
	Tue,  7 Nov 2023 12:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7yS2Csc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935122E40D
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 12:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119F3C433BD;
	Tue,  7 Nov 2023 12:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699359123;
	bh=1ImHK7UGCVcnn5bdj3JjXWjW9E0s9LVgk+3keyShaZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H7yS2Csci9EBnMYREQtISVUc+p8+Y928JBsaPfrGKcc4n3Kvlot3OL/TPKhlPNtnT
	 G6YZxseBxSf2TBku293RCjNOaZspdzIkUU2oycLhRkLHE1ZxcryOuuFFenUhP2LX5D
	 vkM30FzTq9vqvQDRF8cctqSKd52Fg9YrqKHrLwmsrpATf9rsKzxfr9k37Fa08i9ijT
	 u6QSt77iVUKq2db/qa7en0sG+3zZvtbYIACocEktLi0qSKfAPBIZKY0kIaybGhFXET
	 YyTmGiL2fk/vKi9GwkQJYWpBeA2MdAShU/wIe0zIcqC4PHPdYaKEmvFFywpee1gwpI
	 vS0+zDI2Ar+ug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/12] wifi: mac80211: don't return unset power in ieee80211_get_tx_power()
Date: Tue,  7 Nov 2023 07:11:39 -0500
Message-ID: <20231107121158.3758348-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121158.3758348-1-sashal@kernel.org>
References: <20231107121158.3758348-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit e160ab85166e77347d0cbe5149045cb25e83937f ]

We can get a UBSAN warning if ieee80211_get_tx_power() returns the
INT_MIN value mac80211 internally uses for "unset power level".

 UBSAN: signed-integer-overflow in net/wireless/nl80211.c:3816:5
 -2147483648 * 100 cannot be represented in type 'int'
 CPU: 0 PID: 20433 Comm: insmod Tainted: G        WC OE
 Call Trace:
  dump_stack+0x74/0x92
  ubsan_epilogue+0x9/0x50
  handle_overflow+0x8d/0xd0
  __ubsan_handle_mul_overflow+0xe/0x10
  nl80211_send_iface+0x688/0x6b0 [cfg80211]
  [...]
  cfg80211_register_wdev+0x78/0xb0 [cfg80211]
  cfg80211_netdev_notifier_call+0x200/0x620 [cfg80211]
  [...]
  ieee80211_if_add+0x60e/0x8f0 [mac80211]
  ieee80211_register_hw+0xda5/0x1170 [mac80211]

In this case, simply return an error instead, to indicate
that no data is available.

Cc: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://lore.kernel.org/r/20230203023636.4418-1-pkshih@realtek.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 4fa216a108ae8..02bd90a537058 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2762,6 +2762,10 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
 	else
 		*dbm = sdata->vif.bss_conf.txpower;
 
+	/* INT_MIN indicates no power level was set yet */
+	if (*dbm == INT_MIN)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.42.0



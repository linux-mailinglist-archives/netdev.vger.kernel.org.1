Return-Path: <netdev+bounces-46429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E417E3C28
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 13:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E0B1C20A3A
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 12:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8802EB0F;
	Tue,  7 Nov 2023 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9v41jAT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A82E652
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 12:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88695C433CD;
	Tue,  7 Nov 2023 12:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699359180;
	bh=hcB/HlXH/JmzLDhh5gcECvx78cB7rLc/o4shKSOUy+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J9v41jATOklwl9xk2Nv8yqCP2Y94WXYYhUhOTRL161vRtafa/Sxfc0a7AWa6VXeSc
	 LMVDZwM4gmf3dLb8rrTxRob090OK/Lz/Z3J43ZYFpackiVRPAV+R+PR2Fpb5jc7YfR
	 uynt42+71wT11IXqh7kr/w9Yh/YHWEZpBVDMS31O7bd6E60UljypMFev8GT1dgNrMV
	 Jrn2+HE790bGDG6nZ0oRbigsXqXsAs2CJkK4EROyFQ2qAVmOb3k4tcVBH9XxlwsJqZ
	 lqx6wUZNuPm8UXUos+ki2tzvJRQ/AqnKwN9oRUShF2BhhO2YgWxCvRRT4bOQSLb+sL
	 l9yz4XY1MCt0g==
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
Subject: [PATCH AUTOSEL 5.4 2/9] wifi: mac80211: don't return unset power in ieee80211_get_tx_power()
Date: Tue,  7 Nov 2023 07:12:45 -0500
Message-ID: <20231107121256.3758858-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121256.3758858-1-sashal@kernel.org>
References: <20231107121256.3758858-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.259
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
index 9e3bff5aaf8b8..6428c0d371458 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2581,6 +2581,10 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
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



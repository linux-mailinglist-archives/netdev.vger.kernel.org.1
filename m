Return-Path: <netdev+bounces-13470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAFE73BB9A
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6160281C35
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B732C153;
	Fri, 23 Jun 2023 15:25:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04ED8F4A
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 15:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02DBC433C0;
	Fri, 23 Jun 2023 15:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687533946;
	bh=NvWgTGjsHRqDtvBYDx/2FZ7WiFRdFqxIOJ2GEgQdP5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jjSV3khYn7DQtMsuDg9EoNpKhthnIYHAR3qxDpF7Arr09pVBiSIRwUoI5OImA8F3s
	 qmlveYBP11wTA/VaTOeOK/7UPuOJpMlPgbxtyOfpAb7MCX8PGdeVw8AX2mWpyCMGL/
	 pkngpeZ4JGYxGMlzpLK1o860FrlWOZPNVFSi7u08r2V15VEqmBbkab00TOFCACUWYH
	 qtq0Jf3f/vajbOgUJdUm+WzWV7Ycb5rkdLKbMJIkjBXxGD5sCB3mTP3mKs5YT28mI7
	 8dwmjH+dAP0xRobOCLzn27EAfNnGTez82/9NOZJ5i1Hx9WiBXLPIU4DNp17r5a4SQV
	 4BuY8MkMhjXJg==
From: Arnd Bergmann <arnd@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Christian Lamparter <chunkeey@googlemail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Kees Cook <keescook@chromium.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Felix Fietkau <nbd@nbd.name>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH 2/2] mac80211: make ieee80211_tx_info padding explicit
Date: Fri, 23 Jun 2023 17:24:00 +0200
Message-Id: <20230623152443.2296825-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623152443.2296825-1-arnd@kernel.org>
References: <20230623152443.2296825-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

While looking at a bug, I got rather confused by the layout of the
'status' field in ieee80211_tx_info. Apparently, the intention is that
status_driver_data[] is used for driver specific data, and fills up the
size of the union to 40 bytes, just like the other ones.

This is indeed what actually happens, but only because of the
combination of two mistakes:

 - "void *status_driver_data[18 / sizeof(void *)];" is intended
   to be 18 bytes long but is actually two bytes shorter because of
   rounding-down in the division, to a multiple of the pointer
   size (4 bytes or 8 bytes).

 - The other fields combined are intended to be 22 bytes long, but
   are actually 24 bytes because of padding in front of the
   unaligned tx_time member, and in front of the pointer array.

The two mistakes cancel out. so the size ends up fine, but it seems
more helpful to make this explicit, by having a multiple of 8 bytes
in the size calculation and explicitly describing the padding.

Fixes: ea5907db2a9cc ("mac80211: fix struct ieee80211_tx_info size")
Fixes: 02219b3abca59 ("mac80211: add WMM admission control support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/net/mac80211.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 3a8a2d2c58c38..ca4dc8a14f1bb 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1192,9 +1192,11 @@ struct ieee80211_tx_info {
 			u8 ampdu_ack_len;
 			u8 ampdu_len;
 			u8 antenna;
+			u8 pad;
 			u16 tx_time;
 			u8 flags;
-			void *status_driver_data[18 / sizeof(void *)];
+			u8 pad2;
+			void *status_driver_data[16 / sizeof(void *)];
 		} status;
 		struct {
 			struct ieee80211_tx_rate driver_rates[
-- 
2.39.2



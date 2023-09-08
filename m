Return-Path: <netdev+bounces-32626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A7F798CE2
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3C1281CAB
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABDE14F9F;
	Fri,  8 Sep 2023 18:15:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019815491
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64358C4163C;
	Fri,  8 Sep 2023 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694196908;
	bh=u9dEwrOvXbjzBfCMU9FaZiUDZQVrozxBy7cifxEB0KQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sIf360Yo9sT8v5WTbTFQFsfZ2Yuw0f67ZDQRHbNEUwZKIXPpX29C3/A4kFHLu9W8/
	 4wD9Xl9U7ItN5jHG3++eAjkegm2W2S0BbZ1CPUyvj7TkMTWWfv0pzUPZCFVHUAQ96F
	 x9yIa5OhldZ2jcz6KtkYsPIzEb4LPNiBLTAfpfxPZua27eSN//HZQxiGGZfuie0ufs
	 nPdoFRUVZQIp32X9Rl2gbN4CGg+1KmGn7AROuaMcnk/exfLF3xRNY6eJSl0W7IRRgT
	 OZq3Vr2Uds0o7vIkqSo8r/bt2MGglLxU6RKXziq1Ec5BiUm9aVU+/6ahUnOwkyicLy
	 eP/FiyeOgH5VA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 35/45] wifi: cfg80211: ocb: don't leave if not joined
Date: Fri,  8 Sep 2023 14:13:16 -0400
Message-Id: <20230908181327.3459042-35-sashal@kernel.org>
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

[ Upstream commit abc76cf552e13cfa88a204b362a86b0e08e95228 ]

If there's no OCB state, don't ask the driver/mac80211 to
leave, since that's just confusing. Since set/clear the
chandef state, that's a simple check.

Reported-by: syzbot+09d1cd2f71e6dd3bfd2c@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/ocb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/ocb.c b/net/wireless/ocb.c
index 27a1732264f95..29afaf3da54f3 100644
--- a/net/wireless/ocb.c
+++ b/net/wireless/ocb.c
@@ -68,6 +68,9 @@ int __cfg80211_leave_ocb(struct cfg80211_registered_device *rdev,
 	if (!rdev->ops->leave_ocb)
 		return -EOPNOTSUPP;
 
+	if (!wdev->u.ocb.chandef.chan)
+		return -ENOTCONN;
+
 	err = rdev_leave_ocb(rdev, dev);
 	if (!err)
 		memset(&wdev->u.ocb.chandef, 0, sizeof(wdev->u.ocb.chandef));
-- 
2.40.1



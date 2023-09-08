Return-Path: <netdev+bounces-32664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38DD798E48
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F681C20EB2
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF70171C9;
	Fri,  8 Sep 2023 18:21:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB08156C1
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A99C116AD;
	Fri,  8 Sep 2023 18:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694197285;
	bh=M1SEUboSPYiiB6UY60gtnV2aLHbrgmGINt3ZwQqz7ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+0dNQv/KBPtflM6lIAt/P+CypY82xMjk4i3106L6VyB1iW9p5PEG7/myHLxjTU8w
	 sT3GwP2sCy9CWrUSIgm5/U5KDtE9j6iODH0Ksl0yTKuqnQDdNIf7PQpMCO1X7TNNg4
	 HQw0/3G5wOE5qoJuvVXjhNdHcu+qiCCvxPMpkg57tshu9tkjuybgw5H/jBAJWn2RMk
	 HpDWFElmltNyVbljVNXNDc1n5lcO/dmr9hEaSyBmNfDApvRN2aGzptemNnsJZRi2IF
	 GrmHzjLQFOy3qiiJKQIYKE+50JZlUdJ7O41T5IMgU8+PJIQ4qJEUT95pj762l59IAY
	 lYfQA26g2G62w==
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
Subject: [PATCH AUTOSEL 4.19 6/7] wifi: cfg80211: ocb: don't leave if not joined
Date: Fri,  8 Sep 2023 14:21:08 -0400
Message-Id: <20230908182109.3461101-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908182109.3461101-1-sashal@kernel.org>
References: <20230908182109.3461101-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.294
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
index e64dbf16330c4..73dd44e77a1a3 100644
--- a/net/wireless/ocb.c
+++ b/net/wireless/ocb.c
@@ -70,6 +70,9 @@ int __cfg80211_leave_ocb(struct cfg80211_registered_device *rdev,
 	if (!rdev->ops->leave_ocb)
 		return -EOPNOTSUPP;
 
+	if (!wdev->u.ocb.chandef.chan)
+		return -ENOTCONN;
+
 	err = rdev_leave_ocb(rdev, dev);
 	if (!err)
 		memset(&wdev->chandef, 0, sizeof(wdev->chandef));
-- 
2.40.1



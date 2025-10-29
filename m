Return-Path: <netdev+bounces-233797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85086C18950
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F026A19C75E6
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191C32F8BD1;
	Wed, 29 Oct 2025 07:06:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B694727707
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721580; cv=none; b=AtV/LluU48bM1RWCIfxl5dJ65brk9SoWerrg6mUdxxCvlVlbGK3nU6F4yfMuRgkET1mbqDJ+bYojlQWQq17ZSlzlNFVTE76G2poY6qc+UpLfWvrM6zPGiOGTDIFpTqzwPPy+SmxPXxZzmVbALAPbdMkIQ7vRzH8QmYtxGs3sblg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721580; c=relaxed/simple;
	bh=3llzfwvV3qATouhPkl3VJ8bGFyLqnEy9QNwpm9i0C/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ni67ybCL8QQjkBcp5Zvw6D6YF3HoZswWOwCk+HJctsUbGNvIFi2M8pCMQd9wMN4HHff9fuMyLJCAubVZf/1YAzR0CwLx214ecnW0yTU1Rpk6HdGScYPKCYbbz1jFtpJz3+wrAlkCBkaNqXPIhv1bcaa9H2QUwymRDHzr8fSsG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16901bc26ddc-307d7;
	Wed, 29 Oct 2025 15:03:02 +0800 (CST)
X-RM-TRANSID:2ee16901bc26ddc-307d7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100149 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36901bc23ced-f7dd4;
	Wed, 29 Oct 2025 15:03:02 +0800 (CST)
X-RM-TRANSID:2ee36901bc23ced-f7dd4
From: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
To: przemyslaw.kitszel@intel.com
Cc: devlink@vger.kernel.org,
	netdev@vger.kernel.org,
	Zhang Chujun <zhangchujun@cmss.chinamobile.com>
Subject: [PATCH] devlink: add NULL check in devlink_dpipe_entry_clear
Date: Wed, 29 Oct 2025 15:02:56 +0800
Message-ID: <20251029070256.2091-1-zhangchujun@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a NULL check for the pointer 'entry' at the entry
point of the function devlink_pipe_entry_clear. If the passed
'entry' is NULL, the function returns immediately, avoiding subsequent
dereferencing of a NULL pointer and thus preventing potential kernel
crahses or segmentation faults.

Signed-off-by: Zhang Chujun <zhangchujun@cmss.chinamobile.com>

diff --git a/net/devlink/dpipe.c b/net/devlink/dpipe.c
index e55701b007f0..4517d5112311 100644
--- a/net/devlink/dpipe.c
+++ b/net/devlink/dpipe.c
@@ -514,6 +514,9 @@ void devlink_dpipe_entry_clear(struct devlink_dpipe_entry *entry)
 	unsigned int value_count, value_index;
 	struct devlink_dpipe_value *value;
 
+	if (!entry)
+		return;
+
 	value = entry->action_values;
 	value_count = entry->action_values_count;
 	for (value_index = 0; value_index < value_count; value_index++) {
-- 
2.50.1.windows.1





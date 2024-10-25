Return-Path: <netdev+bounces-139067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4D49AFE70
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 11:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904091C20B01
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6170C1BCA0C;
	Fri, 25 Oct 2024 09:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6718C33C
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849221; cv=none; b=WhuGTNHXIyKGQAKkw14Okc9igppNMVII0fMZ1LhF3TOM8tnr6NtR+NGzru8RjQ2vLqVVcYsboUYxycJI0FkjmaPYCxNI9xvzOEXh94dqRnnL/O1koSsYUZtD8zsRsrbwmJM5VTKdVaTnjqaZXkSFBmp1isAbcA3+WSInLTdGhDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849221; c=relaxed/simple;
	bh=YMwDdCNly5MbeDSxYcykydUZn9YSJhk2f5F6t4cSDZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fdNydYpxb2OLNGQvM3A6+tTuSpkdjQF8EGsPivZ8UW2fLoIC5/I93iFR1qOU1YJ90AzOslJlPRdzftqQUKrLFX3rif+hF6TJM8fng69FdaHhydhoWq9QGEUh93f/lwH5DmZkVxue95NdWLK7EszSFkQVdOoxy7ELmxBMthOh2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZd6p5VyTz4f3k6H
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 17:40:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2E6431A0359
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 17:40:15 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCnJ8R0Zxtnl6ZLFA--.53579S2;
	Fri, 25 Oct 2024 17:40:14 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH] qed/qed_sriov: avoid null-ptr-deref
Date: Fri, 25 Oct 2024 09:31:35 +0000
Message-Id: <20241025093135.1053121-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnJ8R0Zxtnl6ZLFA--.53579S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZrW7Jw4kJrykCryfXr4kXrb_yoW8Jr1Dp3
	y5WFyDurW3XF1rCws7Z3W8JFy5Ga9rtFWDW3Z7Ja4fZr90yFy5uF1UAa4YkryfJws5GFya
	yF90vFn8tFyDGa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The qed_iov_get_public_vf_info may return NULL, which may lead to
null-ptr-deref. To avoid possible null-ptr-deref, check vf_info
before accessing its member.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 drivers/net/ethernet/qlogic/qed/qed_sriov.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
index fa167b1aa019..30da9865496d 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -2997,6 +2997,8 @@ static int qed_iov_pre_update_vport(struct qed_hwfn *hwfn,
 		return 0;
 
 	vf_info = qed_iov_get_public_vf_info(hwfn, vfid, true);
+	if (!vf_info)
+		return 0;
 
 	if (flags->update_rx_mode_config) {
 		vf_info->rx_accept_mode = flags->rx_accept_filter;
@@ -5145,6 +5147,9 @@ static void qed_iov_handle_trust_change(struct qed_hwfn *hwfn)
 		 * needed.
 		 */
 		vf_info = qed_iov_get_public_vf_info(hwfn, i, true);
+		if (!vf_info)
+			continue;
+
 		if (vf_info->is_trusted_configured ==
 		    vf_info->is_trusted_request)
 			continue;
-- 
2.34.1



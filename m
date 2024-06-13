Return-Path: <netdev+bounces-103095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D7E90649C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 09:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3A31C22A41
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 07:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3751386A5;
	Thu, 13 Jun 2024 07:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EqjRilcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA49137C59
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 07:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718262634; cv=none; b=IBCfgP3nN39g+Ec1u29/ZsEQW4kDFlzOtj865Mn/uOGXJ8aRWq2jegfBKYqGvgk1FCUoYCwk84Qs7r+1v4yZmidDorFasH32C9vCklKbUmnbCDhCVAcUFeaKIqxAkWcPDNSnm1x3l8oDWPiw3aZ3nm6zkz4tngU+90txsxuR+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718262634; c=relaxed/simple;
	bh=u+I1aAVj3a7n6IbIYshQj7+ph2yLn2mQWMRKJjGc/pA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bFP+5kKXV8+pqnmRiiWgtLJOj/6oQcq4a0/+uX6iDqpK/JAFN0laYMO52qVWscKDAc7YQKyqbZ6p/sJ7AGNpM3zhbbKtw7/5Mn3rv/YSFEgiTtFmRqMBVIpoc1J0+uF8tPGoozqF7riv17qVC0hJNGOGRzXlc2kSuocsBXAlBRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EqjRilcz; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44051a92f37so6038161cf.1
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 00:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718262631; x=1718867431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yH0AlsLpSkYHEHDI5h4LrEXxjv4o46QsFNcTAlffGK4=;
        b=EqjRilcz9ErAU96qrEMal0/rnVxE8Bk7WTeB4yR9aBz9KownJyqxsC5/r2CuANEWbX
         /SgIm76qH2O8XyI2J0wdwhJP6RJt52ydLOHblwJG/8XpPyxBx0PqFdguSaR4HjIG6cJV
         R4MAshNKiLuUmwNJEtzvmhgUHjI6xT1qDSJGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718262631; x=1718867431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yH0AlsLpSkYHEHDI5h4LrEXxjv4o46QsFNcTAlffGK4=;
        b=aYc6JWuruGEHsJC4SsRLqospK89SngLKrLSbX1/P1mv/xYiVp88K3Dicv3GBxmMBMN
         GO9kl8H218mKHT+dcVbCwHbd1tDmx1YTQTOhMmV6FrWVvmKsKCrciOkwVC4wCfFXBxFX
         bgM4FKvUiLvfK70Nz/tgvcEGVrIfxCqhIFLIxNtIH7PgDDXhwIdLRNUz2KlhpW1Z0jGl
         tc0LcBgYbwVCUGiBJd1BovwQzwuBoYCfl0zF/AERzlXLbtvtQaz2d+kiLc3bZY116vxd
         BescegOdW6x41NipMxNw3GEcFms25WdzutooPWRszYZ7Zsasq8RUmLoxMyfsu2LGZ9NR
         5n7A==
X-Gm-Message-State: AOJu0YwkRVopIOsV4w05E2ox4krLRoY3DDThTZKpM974HStMp75WXC55
	BqPxv5aUv+oqM16TFxINx5zixP+mXi5wlH0Fl6/nPzfv2O8NG56cezl0+HCC3HFwKqbTrS58CDw
	=
X-Google-Smtp-Source: AGHT+IHB18P0MbmibFj13ZlZdawFtcl8Crcnz/Kp5EtDjXHjZtOxmZdLv1LZs/NCiyv96h32cmOBLA==
X-Received: by 2002:ac8:5812:0:b0:442:1282:a40d with SMTP id d75a77b69052e-4421282a663mr323091cf.0.1718262631428;
        Thu, 13 Jun 2024 00:10:31 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-441ef4fe986sm3741271cf.33.2024.06.13.00.10.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 00:10:31 -0700 (PDT)
From: David Ruth <druth@chromium.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	marcelo.leitner@gmail.com,
	vladbu@nvidia.com,
	David Ruth <druth@chromium.org>,
	syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com
Subject: [PATCH v2 net] net/sched: cls_api: fix possible infinite loop in tcf_idr_check_alloc()
Date: Thu, 13 Jun 2024 07:10:21 +0000
Message-ID: <20240613071021.471432-1-druth@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot found hanging tasks waiting on rtnl_lock [1]

A reproducer is available in the syzbot bug.

When a request to add multiple actions with the same index is sent, the
second request will block forever on the first request. This holds
rtnl_lock, and causes tasks to hang.

Return -EAGAIN to prevent infinite looping, while keeping documented
behavior.

[1]

INFO: task kworker/1:0:5088 blocked for more than 143 seconds.
Not tainted 6.9.0-rc4-syzkaller-00173-g3cdb45594619 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0 state:D stack:23744 pid:5088 tgid:5088 ppid:2 flags:0x00004000
Workqueue: events_power_efficient reg_check_chans_work
Call Trace:
<TASK>
context_switch kernel/sched/core.c:5409 [inline]
__schedule+0xf15/0x5d00 kernel/sched/core.c:6746
__schedule_loop kernel/sched/core.c:6823 [inline]
schedule+0xe7/0x350 kernel/sched/core.c:6838
schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6895
__mutex_lock_common kernel/locking/mutex.c:684 [inline]
__mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
wiphy_lock include/net/cfg80211.h:5953 [inline]
reg_leave_invalid_chans net/wireless/reg.c:2466 [inline]
reg_check_chans_work+0x10a/0x10e0 net/wireless/reg.c:2481

Fixes: 0190c1d452a9 ("net: sched: atomically check-allocate action")
Reported-by: syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b87c222546179f4513a7
Signed-off-by: David Ruth <druth@chromium.org>
---
V1 -> V2: Moved from net-next to net, identified the change this fixes

 net/sched/act_api.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 9ee622fb1160..2520708b06a1 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -830,7 +830,6 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 	u32 max;
 
 	if (*index) {
-again:
 		rcu_read_lock();
 		p = idr_find(&idrinfo->action_idr, *index);
 
@@ -839,7 +838,7 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 			 * index but did not assign the pointer yet.
 			 */
 			rcu_read_unlock();
-			goto again;
+			return -EAGAIN;
 		}
 
 		if (!p) {
-- 
2.45.2.627.g7a2c4fd464-goog



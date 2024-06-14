Return-Path: <netdev+bounces-103706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE37A9092B3
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 21:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7717CB27727
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 19:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2D61991B9;
	Fri, 14 Jun 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EitioGvd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C25147C90
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391821; cv=none; b=qlCRf6LW1sh8Mx9+v+P84zzJ2nKxvz+8fNRUerpGp7FaEgS61p8jd+cFb+eSdwRrcTmM8ewQ8MIKkPaovDzX6fJWbwCb1nglxr/mGgJweGCvdKI1Sxr0m4ZE0GeYsrhRUYZuhJTcZIjBuNvtBTxCYo7H4Zwnz6sIv3r7p9YfTcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391821; c=relaxed/simple;
	bh=hoSPDQE9UjbVhD2Ix+wBjzVSlow5u229oEe8QRduNfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWUFHY2Bgx82f52w3KtWpgFHLeKFw3vL4/DPRvFTxaWpc55IK6ijTw8W8v3ZP+koXredZSuH4bCFunhtdtLDUk0tUrAol7CkM76hsmQXLCKLpyz6UoeFZ+WzzKxhfhpKkaMWFzj9UtShRzHtB9c+woW3z+7+5k8KRhXhYiewLI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EitioGvd; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b06e63d288so12651006d6.0
        for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718391819; x=1718996619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jHsd061ttJXffGVVKp/MCAPa+ouT4R6OVqLCCj3p4nU=;
        b=EitioGvdcTKNc6IvDjJD8TC4PigeUSmL+zikwtoHnAcAfabmUqd9hmp+AcIBf6sf+U
         8XAZDBsNOii3spYPEjDQJNpFm/tG1Pe2com8S/PMb57snllDP962b1iCHYgM0IuFJmtW
         hW0xXmZufIhRRfFBHKcTill4KiiYPmDDRDT+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391819; x=1718996619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jHsd061ttJXffGVVKp/MCAPa+ouT4R6OVqLCCj3p4nU=;
        b=vKYWCx9YGbXDe1qYKds5EdqvjBf7PCwIfGiAwXbP2t9ax1q6L+c5eD0rNMV7HohElO
         mkTGqiyL24J8iGiCh+6GWQcuNMJQ+W9WWTZ2c7Dw4iiiop/yNrMp5DSGnnMd19igoQu0
         ycvChM/FzONnq3fvZeRZplusuOMsXyjQ2YbUb65cnuddE5DBXqnDna5L3w8bpOigzVzo
         jkUyY76rNgApZJgPXSfg7sNnCRqgcSNCRaRJr0nyboOyZf+4rFgk3slOHtYJX0kauUo3
         M5efzVv4tJhXOVTIgaey4ovU4YG7YesrwSIfre8FWKBtmv5Ipc/BZOodpk8Ecj/J2YUr
         UZpw==
X-Gm-Message-State: AOJu0YxdVUa0TN24w8eqTHB2oJAm/qt2i2447aluLpu4PVzinCvfbgZ0
	aQwtF8QwBGtPf1nCnv4HOFg2QmngLJ2xJa+OmOlaOPBRxkswYm1T5Vv+6olSrD7ilXcbpa3CAHo
	=
X-Google-Smtp-Source: AGHT+IE/lxYlVy71AQcf/reGotlfaQCvRCDZ4++4qz/9WzobTHiOWFRoXYiBDp0p3dUrYPr2rMCHOg==
X-Received: by 2002:ad4:580b:0:b0:6b0:763c:e069 with SMTP id 6a1803df08f44-6b2afc811f2mr37988746d6.18.1718391818809;
        Fri, 14 Jun 2024 12:03:38 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6b2a5c20f53sm21488616d6.52.2024.06.14.12.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 12:03:38 -0700 (PDT)
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
Subject: [PATCH v3 net] net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc()
Date: Fri, 14 Jun 2024 19:03:26 +0000
Message-ID: <20240614190326.1349786-1-druth@chromium.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
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
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
V2 -> V3: Fixed subject, as the change is to act_api, not cls_api
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



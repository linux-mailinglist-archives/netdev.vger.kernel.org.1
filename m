Return-Path: <netdev+bounces-102981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ED6905D0A
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 22:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3081F21E58
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 20:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB96355C3E;
	Wed, 12 Jun 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lJwzxvN4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0F43144
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225190; cv=none; b=VEK1u92MmbiqBRifexJjLRsRSZj75Pl+83dMj+D13ewaMCIzVJMwqvfe/Ocrtyqm003rTRLYaWX8eZovS5o8LKg2S6ymkiuYydwHXorUWpVexo2GYPlU6ccoQLQRXXeTV6GRkwbNgR6OIzzDMOtSxD/j7ocxekbAr1VZZTlRAZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225190; c=relaxed/simple;
	bh=edP8/7jKpmvbgpAtYC46acsvk8RnlQHKPp1Wf5itBeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfny6j9PatF4AzIioPRiU7LZqweo+7IJg5oaNlkkjfNkWa7E73nKAVsqxrTzNVY7sQsjCdtx1vc5N5Ac/5r49AHKdTk7RdrbMVVBy+pNlxyvkPjg7VKJ27Fsz6XYbtR1dyLFIpcUmkKl4/FyBBqYVGButTSd+UoYL+2oJ4C4PM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lJwzxvN4; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-797a7f9b552so15551485a.0
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718225188; x=1718829988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P9UQbW/L95Vpna9fhw5CmVld12bVUKDef0eGHHfka4g=;
        b=lJwzxvN4Zt4bABZycsQpRQ6yFrCRomur/+kcRP+PnEodk75HtiTdb9KlH6I1pmrcBs
         urmkCACBG2eOQ9VnlUqMSRWE3b/o7g8kjlWIEy4rH+tkezou2mtQ9Y0DJpos1eyxBGau
         SFkakQfDXl/UDA5e8bGfQ2TG5mRi+H0nC6gC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718225188; x=1718829988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9UQbW/L95Vpna9fhw5CmVld12bVUKDef0eGHHfka4g=;
        b=qw1WZRFW+0Fqj4mBkPJQzPp4h5GIauYOyRB1VMvqq2hnv124bwICeOSG60HRA8IZkD
         UsCBaYO4CXo+QFtgEzTxqcHE5lL/g5/uWX03hv9AjelAxo2KdP+I96VN+CryRHfJtQn3
         QiugvqQLA6ZdAs9gF7qIvjE2OYri2cRt5yA1S1C8NlxZYmhEMF69iRMCwflD+cApJmRA
         +WalHJ9YiPtkKYsQXx14epcfWP5t4e8rh2J5ej+/hRjyR+v4PjtPyYFefinliZRWUSmP
         DTqo+zU6ZxqHOoFL2wmMFv6d9lepOJD9+8tMRcNG1vKlYs5W4jx/letvAxwpdPYdcNdL
         RFsA==
X-Gm-Message-State: AOJu0YzSJEFhzZSgjaUiP8TE8Msj7EXfz38HMQcdD3Gdg/JvQTdJ3tGi
	HPwmtqsq7ydH+s3kF5sf44z/cz+vrTPuvGvSk+z0M+tv0lkG7W+PFZ23XCMGHyx9rYGsUhcYsDo
	=
X-Google-Smtp-Source: AGHT+IF9VZ4fhMA9WTWbUpyf596tkhKQPEfc5KQT+nmTOBhtgUXJ38KSpNbpkz8Sol4s2FZFRxSOUw==
X-Received: by 2002:a05:620a:3729:b0:797:e7dd:96f with SMTP id af79cd13be357-797f60f602amr330849585a.57.1718225188162;
        Wed, 12 Jun 2024 13:46:28 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7955086fb96sm466657085a.37.2024.06.12.13.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 13:46:27 -0700 (PDT)
From: David Ruth <druth@chromium.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	David Ruth <druth@chromium.org>,
	syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com
Subject: [Patch net-next] net/sched: cls_api: fix possible infinite loop in tcf_idr_check_alloc()
Date: Wed, 12 Jun 2024 20:46:10 +0000
Message-ID: <20240612204610.4137697-1-druth@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot found hanging tasks waiting on rtnl_lock [1]

When a request to add multiple actions with the same index is sent, the
second request will block forever on the first request. This results in an
infinite loop that holds rtnl_lock, and causes tasks to hang.

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

Reported-by: syzbot+b87c222546179f4513a7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b87c222546179f4513a7
Signed-off-by: David Ruth <druth@chromium.org>
---
 net/sched/act_api.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 7458b3154426..2714c4ed928e 100644
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



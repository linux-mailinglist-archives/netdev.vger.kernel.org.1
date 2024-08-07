Return-Path: <netdev+bounces-116436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B7E94A630
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3751C2294E
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCA91E2133;
	Wed,  7 Aug 2024 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ncrkBtjV"
X-Original-To: netdev@vger.kernel.org
Received: from forward201a.mail.yandex.net (forward201a.mail.yandex.net [178.154.239.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C81C8FBB
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027668; cv=none; b=d36QeBqmtuk7bJ14rGo/yeJTFO0swWH48DkT9nzH8MI75ipPLh/5GOKmwRm85QbIfAqRTUC7q2NXZTw725nRTFAHI4oskaxZScPF8P7lf/Rhscw/s/dZt4vcBvRuu2ETykImudV22/VHihNBldBFLiesI06K9HnR06ToGVgQpYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027668; c=relaxed/simple;
	bh=r/xcw4mkfLvHrB7PfXQuHyAeZI0Y0vdAmcw8mBFA1B8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uWg520K4mkAze/2LrihMOLtJWRrM+NUPKt/3Og83FKjcFdbAAkSllPbC5yrteqNx0wCNaSxH+JdZPHPxTX9wq8Voc0eEu69j/xzEjiMzjA3pvyE92/C70WGM34ufduO6JcAQBecOBG7MKZ/P5hjXmO7K1ZQBamwo80waaEVqfoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ncrkBtjV; arc=none smtp.client-ip=178.154.239.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d101])
	by forward201a.mail.yandex.net (Yandex) with ESMTPS id D063D62A0C
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 13:40:41 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:26bf:0:640:efa0:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id D747B60AC0;
	Wed,  7 Aug 2024 13:40:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WeaXEH6Sl4Y0-cbPFdGVk;
	Wed, 07 Aug 2024 13:40:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1723027233; bh=AF4nlcPDOOqSXjDCWCvo6NX6QZUE6FVV55e/YuwK8Nc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ncrkBtjVMJXCbjh+BUwlWyWRhOcWTs+lcZp1tvOZEEowqW21KoavQ8PV/eldyGLic
	 l16MzOHM0Web8nVnGOYuS5/sSMifqHFWoRNG26T56SpcZz0JlfRSwpk/clkrJTgOS7
	 GUPrDC+KUdiEORtWeEBhjE49m3TC5WZxsg038FmQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Subject: [PATCH 1/3] net: sched: fix use-after-free in taprio_change()
Date: Wed,  7 Aug 2024 13:39:41 +0300
Message-ID: <20240807103943.1633950-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'taprio_change()', 'admin' pointer may become dangling due to sched
switch / removal caused by 'advance_sched()', and critical section
protected by 'q->current_entry_lock' is too small to prevent from such
a scenario (which causes use-after-free detected by KASAN). Fix this
by prefer 'rcu_replace_pointer()' over 'rcu_assign_pointer()' to update
'admin' immediately before an attempt to schedule freeing.

Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
Reported-by: syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/sched/sch_taprio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index cc2df9f8c14a..59fad74d5ff9 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1963,7 +1963,8 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 
 		taprio_start_sched(sch, start, new_admin);
 
-		rcu_assign_pointer(q->admin_sched, new_admin);
+		admin = rcu_replace_pointer(q->admin_sched, new_admin,
+					    lockdep_rtnl_is_held());
 		if (admin)
 			call_rcu(&admin->rcu, taprio_free_sched_cb);
 
-- 
2.45.2



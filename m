Return-Path: <netdev+bounces-136852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF70A9A3421
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4CF282CFA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 05:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129A517332C;
	Fri, 18 Oct 2024 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="N4Q3JSHy"
X-Original-To: netdev@vger.kernel.org
Received: from forward203a.mail.yandex.net (forward203a.mail.yandex.net [178.154.239.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEE11514CC
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 05:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729228846; cv=none; b=Hu7V/m+shyAnTRRBJb1JZI6FQ0+pPxdwRqBt27kkL6iqpnHEMqXwOyCNdx1qgsj0QqsNlXcjLPQlIFdBBdcvOUCKE8cYiaQaj9L8WYDUSoRlxexVEgRg7uJT0ZpUagmXBYy93i2khpTGKx8kTe2QaHCewfmFUnb/JS9HN/wxK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729228846; c=relaxed/simple;
	bh=KXvm92s07awak7G/cdC7TWsNdSrGe1cuAc+WzEpXq7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C79881NHCjIlG/7Yak2S0qN4bcFFjgoCNHwSUJBVKxFTE33jldgyraWrlLP28wWJRdQSiM/SEQR0XfYtLOi4HQ05MKxLe4L3oBE8NbyMnV5I93JXtqImayaScMDRh+wnsbiAUFOtZQsvuvtZ1Gs7Tanr/LPRgXvyFPhvSHjh+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=N4Q3JSHy; arc=none smtp.client-ip=178.154.239.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward203a.mail.yandex.net (Yandex) with ESMTPS id 8825E61393
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 08:14:08 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2a:1c1:0:640:adc:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id C0D0060AD4;
	Fri, 18 Oct 2024 08:13:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id vDGD1k31TSw0-nyUuekjI;
	Fri, 18 Oct 2024 08:13:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729228438; bh=VMP8ChqrrEAjBj2IBe9W7mWr+cZyaoaLnScD0mdcSKM=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=N4Q3JSHyhVZDshMXIH3YCulkujqPJNkLt8W+q1N2QxkmvGOnykHR/hAv+q2527+Z+
	 +oS0yXuFvuT7pgMFIGYoYKC7cUH6MQkZCvkyqEK7JpaE0GdW1wl06+BsQJeNGVS9i2
	 rl8BxBY8jqvpdx3dWqMf+LdOKnW+WIGxXN3ovWEE=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Subject: [PATCH net v7 1/2] net: sched: fix use-after-free in taprio_change()
Date: Fri, 18 Oct 2024 08:13:38 +0300
Message-ID: <20241018051339.418890-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

In 'taprio_change()', 'admin' pointer may become dangling due to sched
switch / removal caused by 'advance_sched()', and critical section
protected by 'q->current_entry_lock' is too small to prevent from such
a scenario (which causes use-after-free detected by KASAN). Fix this
by prefer 'rcu_replace_pointer()' over 'rcu_assign_pointer()' to update
'admin' immediately before an attempt to schedule freeing.

Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
Reported-by: syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v7: add (hopefully all required) process-related quirks
v6: adjust to match recent changes
v5: unchanged since v4 but resend due to series change
v4: adjust subject to target net tree
v3: unchanged since v2
v2: unchanged since v1
---
 net/sched/sch_taprio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 8498d0606b24..9f4e004cdb8b 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1965,7 +1965,8 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 
 		taprio_start_sched(sch, start, new_admin);
 
-		rcu_assign_pointer(q->admin_sched, new_admin);
+		admin = rcu_replace_pointer(q->admin_sched, new_admin,
+					    lockdep_rtnl_is_held());
 		if (admin)
 			call_rcu(&admin->rcu, taprio_free_sched_cb);
 
-- 
2.46.2



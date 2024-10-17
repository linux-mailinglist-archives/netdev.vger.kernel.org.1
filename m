Return-Path: <netdev+bounces-136555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5672E9A20FD
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886441C24ABB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA89B1D63E6;
	Thu, 17 Oct 2024 11:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="UhkvGF0t"
X-Original-To: netdev@vger.kernel.org
Received: from forward201b.mail.yandex.net (forward201b.mail.yandex.net [178.154.239.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A89A1D45F3
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164775; cv=none; b=NFe/tYqrTlO0u9L9EbNj0utoeo8TAycM9b6ymlbRx0fqWO2E0px6EK+FpsOxbcXl9Xen12LxaykMHdq3nsF9dmdr/KfsWHu04InEFvhm4hiPeB1GokvvQ0hmEheI/JCmRWLqxHvk8EqcgyUt7NqCqFyDk6yyDSPxh/ATzfo09kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164775; c=relaxed/simple;
	bh=lWbxMZE+o7FcZaOdAJj3fxAgNYvGVZw+2PNr3Wf5kPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSJNqm/YLD18UX4W8dOhqhA1R8N8SlgU/GWWGdjbFfex3LrBhqpdpd7UBL9ipN1rkvqP3fRlmkcM5VAug99+C8Cq68VzwksxJAP/lPo4uuZDRx/lSxC7QSuMNTcQV3Ag7ipqs3N5VgYr+Rhw9Vd++dwH+G3d4XpJxpGdFILdXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=UhkvGF0t; arc=none smtp.client-ip=178.154.239.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward201b.mail.yandex.net (Yandex) with ESMTPS id A3532670D7
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 14:26:08 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:c61f:0:640:7720:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 65F1F60A99;
	Thu, 17 Oct 2024 14:26:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wPLwlM6xFiE0-xAfQrUWk;
	Thu, 17 Oct 2024 14:26:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729164360; bh=DS+2lKlxktJJ20yDWr7bzVn6oFVlIMxoi7OnPBvjFUs=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=UhkvGF0tCMBGHmNcmeU/gJ09Ren0PO9WKR17Of+UIptWzUdJBF6d6VB2gMPP39X4G
	 zXqzm6OQ7zya46rzYtm9E0uOUy23HEcEqDsb2wzADVgpSO3bmMOjxU4iV15rAE2eIz
	 EQ6HUZLQZehzghIPjyxyJfkAznoV+bJMjuO5hwg4=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Subject: [PATCH v6 1/2] net: sched: fix use-after-free in taprio_change()
Date: Thu, 17 Oct 2024 14:25:04 +0300
Message-ID: <20241017112546.208758-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017112546.208758-1-dmantipov@yandex.ru>
References: <20241017112546.208758-1-dmantipov@yandex.ru>
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
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
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



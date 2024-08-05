Return-Path: <netdev+bounces-115779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B33947C38
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7F5281B1C
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFD038F91;
	Mon,  5 Aug 2024 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="BBwrH1/x"
X-Original-To: netdev@vger.kernel.org
Received: from forward202d.mail.yandex.net (forward202d.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC88141C6C
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865933; cv=none; b=h7VzDNJ2hxrnVHkwWHfTwUXRVO5+HogmPqIhfcFydBUGtDcdTQRQ9CNDZOBk2NcgyCn1FJFTwC3xOG60Xd8Do4abvfsIHZPDTAqsPa8EtW0twYrG46VZ4pdaoonQAth090vCSVSzUEhriX4/US5hzJPr4A9uUnbgq2zmz9I+5mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865933; c=relaxed/simple;
	bh=r/xcw4mkfLvHrB7PfXQuHyAeZI0Y0vdAmcw8mBFA1B8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cojSTdqW6+tTnbeqPzSfbcuoLqs6VZTx7Uuv/nqENrlqvb4+o8uxuTN/zcJZrZRNgEDhSabnPIet2sKwDrz+Cfqbt4KZG7Rj3SsEpikXP094j03fiZZQz3OotNJGvYeRGd7ocNVJp49mVWltMcYakfuVXgFo3syrswhirzbVWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=BBwrH1/x; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward202d.mail.yandex.net (Yandex) with ESMTPS id B554B65523
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 16:52:01 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-35.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-35.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:2345:0:640:1ce6:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 2B545609DE;
	Mon,  5 Aug 2024 16:51:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-35.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ppbqS4Fc2Os0-o2PMHSwf;
	Mon, 05 Aug 2024 16:51:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1722865913; bh=AF4nlcPDOOqSXjDCWCvo6NX6QZUE6FVV55e/YuwK8Nc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=BBwrH1/xKiqW9c6rTaYlOEUCPICod2PbOD8AS9trdsIxI79QPmeyGS3j6Tl2O9LwO
	 ocpA5DLSxlOA7civdg9IMycMDlbp1tsNOEJBd4Aj+wMDQxdJxLJTBnEFi9N0TbWy19
	 TzKTTM55BGt3LZKiogytjI8AHuqXQ1o+tlF3Z/C0=
Authentication-Results: mail-nwsmtp-smtp-production-main-35.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Subject: [PATCH] net: sched: fix use-after-free in taprio_change()
Date: Mon,  5 Aug 2024 16:51:45 +0300
Message-ID: <20240805135145.37604-1-dmantipov@yandex.ru>
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



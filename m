Return-Path: <netdev+bounces-124560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344EA969FDB
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670641C23009
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A13482C8;
	Tue,  3 Sep 2024 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="qvRZmoqb"
X-Original-To: netdev@vger.kernel.org
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74E81CA68F
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372488; cv=none; b=hPIdkcNnChWG7blOTfwRAYpSMGY2ynieKTRz2k282+4t7PwWF1SjeTSuS5sOzQFhSK7+Tz+4df/SYNLnY351z0dcJOf2ohXDPLFIuNlYaK7E+RDHMC0WBnrbMAlSlpxIurEQv4w769VlhtoWrBSpMdl99ndfURxCJ5Q3D3ILG/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372488; c=relaxed/simple;
	bh=Ae/hvkMJYTCa+tGCz1s4pKR8Cou/xrH5zEu3s3q7wys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0rJPaTnq4z/WA3HSPaVI9xe3c14pDH77KM+NVuhStdkRGcCVIZOLYbm02TsidxXDy65GS6RixOqioN8nHc1cs2qVklqsaicpdmWjITtsXCpRFBYV8P1VAh4/qw7uYzwFWoQ9AJFRiVvvb45/gKF3I76kHvI8bIMihDO/loGzhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=qvRZmoqb; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:de2c:0:640:e39b:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 59FFB60917;
	Tue,  3 Sep 2024 17:07:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id s7cJDQ0oD0U0-hBMFp44A;
	Tue, 03 Sep 2024 17:07:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1725372475; bh=ITm/G4Xv+muuJ8JRHFHlPRARYyTpD5M0eMX/8qVJhvI=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=qvRZmoqbptTSkALPaC2ald5r0AhG049Y+MM0XioZSbsJy+ouqXFoxIYMhWj6Obp+R
	 BdWPVd/WDapB9LuBR9mSziGo/mUXo5n3nt3uY+T57w2bL0SwMlfbr+nxFJJkGRzL9c
	 0DNwV/fbsQSV4T4n6bo6tIsSz9AjWuVD14/Lii9k=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Subject: [PATCH net v4 1/3] net: sched: fix use-after-free in taprio_change()
Date: Tue,  3 Sep 2024 17:07:06 +0300
Message-ID: <20240903140708.3122263-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.0
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
v4: adjust subject to target net tree
v3: unchanged since v2
v2: unchanged since v1
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
2.46.0



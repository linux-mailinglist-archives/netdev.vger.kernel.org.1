Return-Path: <netdev+bounces-125044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4441396BBD2
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F47B2CE76
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9831D88DD;
	Wed,  4 Sep 2024 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="dD/qhVFq"
X-Original-To: netdev@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3941F1D88AF
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451730; cv=none; b=ZbLOWHUMcHPDhftnAoQTP80NVH3rxaMXo3IyWZSnawzHecHS74lGsgh//Oyu9T0OfTZbpV4vh30Yv/3OjpWUaL846c4YX5M/WZKYFjrtRz3oMYxUmB24k7vQybs/jXWnhW1f9SdDLpNR5JCvBoA8oV8nj99T3KH2xr5/PUcDPZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451730; c=relaxed/simple;
	bh=tudkOBqicCQK4Gxw3wenulSEBK/j0ZtQ4l2gzrY7VeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FsaEQxu4eU4ndHEVgOZLjWkbS0/9hn4dGUVUKsyMiqWFdeysHaAM5zwDcM7EV0t90XEsnAbN6UYTk2xG78hI3Yd5c1cHyHVf4esxP/oQdyEEM7RYazACcwS1ZV24MVeFOy7Ptx6PVNh0gDHYPGI4udGQS6VvVNW7EWpJMR4IHxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=dD/qhVFq; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:f220:0:640:b85:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 336A560B4A;
	Wed,  4 Sep 2024 15:08:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id h8b9pL7j6Os0-OqhS6W8E;
	Wed, 04 Sep 2024 15:08:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1725451724; bh=zAt49LMWuIYAsshcBExvuI4BWZoXaEJfzbSelIL521w=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=dD/qhVFq2XsHNoIO2EbOWIZ3z1lJcgwroDh4v/bTNbmKlETnjBseCWc2UDtNEeWT3
	 DbcD++97Aywmr247PV8HLB+NnUm4obH6QqceKvU6Hec7n+u/4e8ZqjCH4nHjRRDsZU
	 G9eaCADQuzGOi32mTtWUIHdabUeE6fTOjagiA4fo=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Subject: [PATCH net v5 1/2] net: sched: fix use-after-free in taprio_change()
Date: Wed,  4 Sep 2024 15:08:41 +0300
Message-ID: <20240904120842.3426084-1-dmantipov@yandex.ru>
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
v5: unchanged since v4 but resend due to series change
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



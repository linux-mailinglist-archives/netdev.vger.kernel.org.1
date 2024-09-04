Return-Path: <netdev+bounces-125041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD5696BB6E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BFE2B26B85
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCE31D47D8;
	Wed,  4 Sep 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Je2jbdNW"
X-Original-To: netdev@vger.kernel.org
Received: from forward205a.mail.yandex.net (forward205a.mail.yandex.net [178.154.239.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D431CCEE3
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451237; cv=none; b=kI0Hb8Do2O54NFmGJadMuwWANBs4n7uvM9z3vjsJEEjZdCuI1PNa6g3efMVqQhV1ZWo6rhX7wzS1yMUUNpiaw3bYgUclsV8TiAfD/J71+EMp0HXJWJO8U8cirepqSvFCMdPk2JkKzymQ/heGKL8W7AovsUMYHRtC8hbbdQ5413k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451237; c=relaxed/simple;
	bh=NK3HEwyhysXJUEAEB2V8uNRVrXlRS+XEw1TYa8NZkog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LvsOOaTSqhfXA7BGCkVj8Z/QNdG6wDzahMfjgYitYIQZ9cuOVQ1QPOz4JEb1B2I5VVrL8RsqFsAwZY0EqZunLQr5LA7LgJK3JPf/Lhs44eZYgo9CHVT9pZHRb54+4h05ruoM+Ua76a/vUkypuS8NojrYTkY34C0dgNncBxTQ/GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Je2jbdNW; arc=none smtp.client-ip=178.154.239.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward205a.mail.yandex.net (Yandex) with ESMTPS id 26E2768F32
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 14:54:43 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:604:0:640:5e0e:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id B6E5D60906;
	Wed,  4 Sep 2024 14:54:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Xsa5duAq8W20-95BQWSfC;
	Wed, 04 Sep 2024 14:54:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1725450874; bh=0ze7FoxYSM03CXs6xb5yf0w55g6FTLWwSRuud5KXuQg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Je2jbdNWhjbZn/tHlqXyoz4svnvwg8mdGbRaltQDZSe3VpNVsqM+xQM160xDBPgUY
	 Js6BGZ2xkXqI+xbZR2M0ZIQEtMw9EE3AmhChf7/eERLgoB+6ajBnByuBCTREsZEJPU
	 +P7kW8gMcAGBVA0K9F5ooYRLOO//Z8T5qb40XoEk=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH net-next v5] net: sched: consistently use rcu_replace_pointer() in taprio_change()
Date: Wed,  4 Sep 2024 14:54:01 +0300
Message-ID: <20240904115401.3425674-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Vinicius (and carefully looking through the whole
https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
once again), txtime branch of 'taprio_change()' is not going to
race against 'advance_sched()'. But using 'rcu_replace_pointer()'
in the former may be a good idea as well.

Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v5: cut from the series, add syzbot link an re-target to net-next
v4: adjust subject to target net tree
v3: unchanged since v2
v2: added to the series
---
 net/sched/sch_taprio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index cc2df9f8c14a..8498d0606b24 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1952,7 +1952,9 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 			goto unlock;
 		}
 
-		rcu_assign_pointer(q->admin_sched, new_admin);
+		/* Not going to race against advance_sched(), but still */
+		admin = rcu_replace_pointer(q->admin_sched, new_admin,
+					    lockdep_rtnl_is_held());
 		if (admin)
 			call_rcu(&admin->rcu, taprio_free_sched_cb);
 	} else {
-- 
2.46.0



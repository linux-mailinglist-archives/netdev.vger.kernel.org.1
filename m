Return-Path: <netdev+bounces-258441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEeiIHqyjWmz5wAAu9opvQ
	(envelope-from <netdev+bounces-258441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 11:59:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB48A12CC4C
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 11:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 370FD3041BE6
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 10:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA78318133;
	Thu, 12 Feb 2026 10:58:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FF2316918;
	Thu, 12 Feb 2026 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770893930; cv=none; b=ogpfB4N/sLA3JfO83A5LOjoWNU5bjro4vf6402/I1DyMRLkwencj5N5x05aVpkxX86vawx53bgRExtlJLU34fTiNu2wBjUrXvYmTOEYkQH6LEbCRiJU+AG/W+cVB8RrpCN8WAQYWJnv3hRtRuIhAAfwxa57PQm0HhpOqdeQhnzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770893930; c=relaxed/simple;
	bh=5q/gy2Ucyfw1Ty2cmZtJ+NPyMI6M6VJcKIRA2HH2AmE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dSEaC/Xb5+Y0wF+OIQjagILVIEZSec9UgbpfU3DfmL14VYHyWvJ6sJE1P7damkWXxvu2PFYIdxjDJanGdJi/bBWoIY8PkP0jzRCyvSvxWVxaaT9r3oLgt2Ql7VURh5DlAlMgX2IpNq21aJbflQMWZ5ShQgibcuOe8LVDQVom1Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][net-next] net/devlink: Move health recovery notification after abort check
Date: Thu, 12 Feb 2026 05:57:51 -0500
Message-ID: <20260212105751.2410-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc4.internal.baidu.com (172.31.3.14) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[baidu.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-258441-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB48A12CC4C
X-Rspamd-Action: no action

From: Li RongQing <lirongqing@baidu.com>

In devlink_health_report(), the DEVLINK_CMD_HEALTH_REPORTER_RECOVER
notification is sent immediately after setting the error state, before
checking if recovery should be aborted via devlink_health_recover_abort().

When devlink_health_recover_abort() returns true (e.g., due to rate
limiting), the recovery process terminates early, but userspace has already
received a notification implying that recovery is underway. This creates a
misleading view of the reporter's activity.

Move the notification after the abort check, ensuring it is only sent when
recovery will actually proceed. This aligns the notification with the
actual recovery behavior.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/devlink/health.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index 136a67c..e9999fc 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -665,7 +665,6 @@ int devlink_health_report(struct devlink_health_reporter *reporter,
 	reporter->error_count++;
 	prev_health_state = reporter->health_state;
 	reporter->health_state = DEVLINK_HEALTH_REPORTER_STATE_ERROR;
-	devlink_recover_notify(reporter, DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
 
 	if (devlink_health_recover_abort(reporter, prev_health_state)) {
 		trace_devlink_health_recover_aborted(devlink,
@@ -686,6 +685,7 @@ int devlink_health_report(struct devlink_health_reporter *reporter,
 	if (!reporter->auto_recover)
 		return 0;
 
+	devlink_recover_notify(reporter, DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
 	devl_lock(devlink);
 	ret = devlink_health_reporter_recover(reporter, priv_ctx, NULL);
 	devl_unlock(devlink);
-- 
2.9.4



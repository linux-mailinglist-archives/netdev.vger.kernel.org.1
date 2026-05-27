Return-Path: <netdev+bounces-292374-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DzvFCMbF2ov4gcAu9opvQ
	(envelope-from <netdev+bounces-292374-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:26:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D425E7BD3
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A5FE300070D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420EC42EED3;
	Wed, 27 May 2026 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPF68SFE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1365742E004
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899128; cv=none; b=QN4BMJTWRFKQh1Fhe1xZ+2Vk9rMLanQ5ymmEkXCDxDGmgVuiNk3hrLDWeeLW403OIglQfSuvjRzNF78bXoFDTS+h9D7Og+uoqefjLbyc37kxeOGHcGo6HKaczu804IP1t88kdRnh1lITDuT6y++6dtRUM9SMRCLI3FvLwishAu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899128; c=relaxed/simple;
	bh=pZBbTa3SLjG0RmolAmgUx8HqAFjCV1vGNtpC0muEp5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJaY4tmB2NDjvK8jqPzmi3S72Q7HZgkTNtrAYtM5PXg2Pq0l979AzBxjIoiDQWd+ZcD7oqbE92ztzYQXy0VMtB97/0zAPKJR8t/gD05K2d3T9Ajy31YpHFBYkSvBqx6q/ZxiXPcbCEnoXSRZ0HSmb+bPqAfHVf+7PDXE18DXD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPF68SFE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D161F000E9;
	Wed, 27 May 2026 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779899126;
	bh=Pq1x5aRy7pcQn6lTgjFJ+mk8MAMG2Y7ozjH6zMVwpS4=;
	h=From:To:Cc:Subject:Date;
	b=XPF68SFEEhJgZIpZTfVc3vCp7CliFHmmUByeZ1Cl/vhlW6L3qDq60en9u5PiklhR0
	 WYYnNPDXz6926oTExCyTA1/ehLFteyz2C+6FrpUMBgc5iIkUB5x37g+O7DcwgX/zE4
	 1zZCh5w4AcS1lg76/w6TscOY82VKq+DXJ3rR665QmrX0h3Y8fXsPF8/IdSBYJp3/Jx
	 8IVcFhWeiVavyGwnTRKQro9nO/PPRZVqxVpevY39wZl7jBCfuIbdFPr9FLHoAkVOG0
	 kv51gr/klaUp5y2V9ABtY0FMw8DE6q3Ad9SmlS4zfUQevC693jSUwoeQQuezqbx/+F
	 YJMHTyotSrrSw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com
Subject: [PATCH net-next] net: ethtool: don't take rtnl_lock for global string dump
Date: Wed, 27 May 2026 09:25:22 -0700
Message-ID: <20260527162522.3344231-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292374-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Queue-Id: B9D425E7BD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ETHTOOL_MSG_STRSET_GET is the only op which sets allow_nodev_do.
When no device is provided it dumps static tables, there's no
need to hold rtnl_lock for this.

Not taking rtnl_lock is a minor win in itself so I think this
patch stands on its own merits. Later on it will be useful
to do locking only in paths which have access to a netdev,
so that we can decide which locks to take per-netdev.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: maxime.chevallier@bootlin.com
---
 net/ethtool/netlink.h |  4 +++-
 net/ethtool/netlink.c | 10 ++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index aaf6f2468768..b31de00fe683 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -333,7 +333,9 @@ int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
  * @hdr_attr:         attribute type for request header
  * @req_info_size:    size of request info
  * @reply_data_size:  size of reply data
- * @allow_nodev_do:   allow non-dump request with no device identification
+ * @allow_nodev_do:
+ *	Allow non-dump request with no device identification.
+ *	Note that locks (rtnl_lock etc.) are only taken if device is set.
  * @set_ntf_cmd:      notification to generate on changes (SET)
  * @parse_request:
  *	Parse request except common header (struct ethnl_req_info). Common
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 5046023a30b1..a42bdd5ded51 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -526,13 +526,15 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_free;
 	ethnl_init_reply_data(reply_data, ops, req_info->dev);
 
-	rtnl_lock();
-	if (req_info->dev)
+	if (req_info->dev) {
+		rtnl_lock();
 		netdev_lock_ops(req_info->dev);
+	}
 	ret = ops->prepare_data(req_info, reply_data, info);
-	if (req_info->dev)
+	if (req_info->dev) {
 		netdev_unlock_ops(req_info->dev);
-	rtnl_unlock();
+		rtnl_unlock();
+	}
 	if (ret < 0)
 		goto err_dev;
 	ret = ops->reply_size(req_info, reply_data);
-- 
2.54.0



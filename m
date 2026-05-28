Return-Path: <netdev+bounces-292879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL4dA5zNGGpjnggAu9opvQ
	(envelope-from <netdev+bounces-292879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:19:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9FC5FB5A1
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1FA43045376
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7657A36CE06;
	Thu, 28 May 2026 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIkh2ojJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5133636B043
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010211; cv=none; b=qCogrsqzxKjeBr5w2otvrtfXelqspt/50tSd4EgD0LrOEimUmyCNOmQSVHHVFvFRxTM9idezTjBuYOm85jomF+Y/yN8rh+nkEoaBA5VY23Z6FxkxcrdI0lmG6xmhKQWv4s1vQp3fBsVUv0wtsWI1NKuPRvvJ8m3m0jnU1ZwjIJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010211; c=relaxed/simple;
	bh=v1ZOeCLyEz7nTH7GHVxWn6EJ2FIIiIakIC5SXGyA9+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etTX+8c+afFQedBYXbo2TVY8fH+Hz16dFTYCS1iOdBtCD/vk25nKqNMZLXctV3DCTnUlYpvm5jQRaFa2OsWXxNntRgQdNgbuPag2ntFCeDQAn65xGVTPDKlZyhqGTfjpm/T1rVEPmRO/S0pJD8+wMM9HbHHzS146BmRoeq22AZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIkh2ojJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420B21F00A3A;
	Thu, 28 May 2026 23:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010210;
	bh=icdVmE59G7Uc1Xvo1wP+m/s3KjOOVC4niji7aqVlsrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kIkh2ojJyR4z8Oa8k3FLF+Zq1SaU87EukHW4usR71E5V7OpSLeKl5jGNglETfVkl+
	 pmMJ7xzSR4e34CCWJwflPpaGubkvCYq1wYptk3n8rSt719kais+x8Cvob1e3VPBS/F
	 Rv5Q3+rQj8MjqzEUbp0LfPjKczXO/wXBV2trz+njtsuLbiZtzOfigFRAaSvF+T3wEf
	 AXcIxX530pbi06rCM0uVMbqWuHsGvFzgDgHAVUQDhDOqDHKEMCubnfSt++1B6PgWyH
	 XDLpO0eDv/yKH/3TEqz5x6XtS3BZgfV4wVSVvr6KMhF7ZIoiCCMLOE3apwiAK4MUVb
	 sTXIaXnfHI99Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	haiyangz@microsoft.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	willemb@google.com,
	ernis@linux.microsoft.com,
	sdf.kernel@gmail.com,
	kory.maincent@bootlin.com,
	danieller@nvidia.com,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 02/14] net: ethtool: make sure __ethtool_get_link_ksettings() is ops-locked
Date: Thu, 28 May 2026 16:16:25 -0700
Message-ID: <20260528231637.251822-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528231637.251822-1-kuba@kernel.org>
References: <20260528231637.251822-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,nvidia.com,microsoft.com,armlinux.org.uk,bootlin.com,linux.microsoft.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-292879-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2B9FC5FB5A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

__ethtool_get_link_ksettings() is exported and called from sysfs
and many drivers. Looks like commit 2bcf4772e45a ("net: ethtool:
try to protect all callback with netdev instance lock")
missed adding the lock around it. Not treating this as a fix because
I don't think any driver cares at this point, but if we want to
remove the rtnl_lock protection this will become critical.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/ethtool.h |  2 ++
 net/ethtool/ioctl.c     | 20 +++++++++++++++++---
 net/ethtool/linkinfo.c  |  4 ++--
 net/ethtool/linkmodes.c |  4 ++--
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 1cb0740ba331..0caaeb91b094 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -325,6 +325,8 @@ struct ethtool_link_ksettings {
 extern int
 __ethtool_get_link_ksettings(struct net_device *dev,
 			     struct ethtool_link_ksettings *link_ksettings);
+int ethtool_get_link_ksettings_locked(struct net_device *dev,
+				      struct ethtool_link_ksettings *link_ksettings);
 
 struct ethtool_keee {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index bd97f9b9bf18..1d74ee67e77a 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -436,10 +436,10 @@ struct ethtool_link_usettings {
 };
 
 /* Internal kernel helper to query a device ethtool_link_settings. */
-int __ethtool_get_link_ksettings(struct net_device *dev,
-				 struct ethtool_link_ksettings *link_ksettings)
+int ethtool_get_link_ksettings_locked(struct net_device *dev,
+				      struct ethtool_link_ksettings *link_ksettings)
 {
-	ASSERT_RTNL();
+	netdev_ops_assert_locked(dev);
 
 	if (!dev->ethtool_ops->get_link_ksettings)
 		return -EOPNOTSUPP;
@@ -450,6 +450,20 @@ int __ethtool_get_link_ksettings(struct net_device *dev,
 	memset(link_ksettings, 0, sizeof(*link_ksettings));
 	return dev->ethtool_ops->get_link_ksettings(dev, link_ksettings);
 }
+
+/* Convenience helper for callers that hold only rtnl_lock(). */
+int __ethtool_get_link_ksettings(struct net_device *dev,
+				 struct ethtool_link_ksettings *link_ksettings)
+{
+	int ret;
+
+	ASSERT_RTNL();
+
+	netdev_lock_ops(dev);
+	ret = ethtool_get_link_ksettings_locked(dev, link_ksettings);
+	netdev_unlock_ops(dev);
+	return ret;
+}
 EXPORT_SYMBOL(__ethtool_get_link_ksettings);
 
 /* convert ethtool_link_usettings in user space to a kernel internal
diff --git a/net/ethtool/linkinfo.c b/net/ethtool/linkinfo.c
index 244ff92e2ff9..0cdcf0887b01 100644
--- a/net/ethtool/linkinfo.c
+++ b/net/ethtool/linkinfo.c
@@ -34,7 +34,7 @@ static int linkinfo_prepare_data(const struct ethnl_req_info *req_base,
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
-	ret = __ethtool_get_link_ksettings(dev, &data->ksettings);
+	ret = ethtool_get_link_ksettings_locked(dev, &data->ksettings);
 	if (ret < 0)
 		GENL_SET_ERR_MSG(info, "failed to retrieve link settings");
 	ethnl_ops_complete(dev);
@@ -104,7 +104,7 @@ ethnl_set_linkinfo(struct ethnl_req_info *req_info, struct genl_info *info)
 	bool mod = false;
 	int ret;
 
-	ret = __ethtool_get_link_ksettings(dev, &ksettings);
+	ret = ethtool_get_link_ksettings_locked(dev, &ksettings);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG(info, "failed to retrieve link settings");
 		return ret;
diff --git a/net/ethtool/linkmodes.c b/net/ethtool/linkmodes.c
index 30d703531652..e7999aed9200 100644
--- a/net/ethtool/linkmodes.c
+++ b/net/ethtool/linkmodes.c
@@ -39,7 +39,7 @@ static int linkmodes_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 
-	ret = __ethtool_get_link_ksettings(dev, &data->ksettings);
+	ret = ethtool_get_link_ksettings_locked(dev, &data->ksettings);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG(info, "failed to retrieve link settings");
 		goto out;
@@ -324,7 +324,7 @@ ethnl_set_linkmodes(struct ethnl_req_info *req_info, struct genl_info *info)
 	bool mod = false;
 	int ret;
 
-	ret = __ethtool_get_link_ksettings(dev, &ksettings);
+	ret = ethtool_get_link_ksettings_locked(dev, &ksettings);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG(info, "failed to retrieve link settings");
 		return ret;
-- 
2.54.0



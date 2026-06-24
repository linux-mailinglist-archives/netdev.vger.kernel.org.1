Return-Path: <netdev+bounces-301690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bbD2Myb1O2rkgQgAu9opvQ
	(envelope-from <netdev+bounces-301690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:17:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 524166BF8E7
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:17:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=c1Ap+tTH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301690-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301690-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FF98312C4AD
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F593BFAE7;
	Wed, 24 Jun 2026 15:07:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA173B7B7B;
	Wed, 24 Jun 2026 15:07:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313636; cv=none; b=RvhNOmcXX1s0Y191ZZqV+vt3GlzVbu164zoX5PVggmhcT9OsYGcfdzv19V9MJBH6yAxqvKNX8iXYfzl7MFyu7wKnfBsF6DxP4oztXaBtaSDN3yFItDCpBT4QWUk8gJRPw0rfCc/wYKCja4gR3raUjZGm8gi5PkhPC364f1I3bn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313636; c=relaxed/simple;
	bh=ODnf/Rg982u585CA9MVRZf8zTcdfWnRXjFq8vAd94vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=keGbyLoBY03iSf3tKh1NK62k3SdmghM1uSamao5BHqtcMJF8wxUVlw7w+mUKXNMYKxvOwnWCLdLcasXrgrneydHTOngeTFxDD0Q0NgrZJTjTPm+pfYsypmzOODGdUf5O2qUcBhVX4R1qhPnL32V6QDnLoFP8HesxSeg7Sta2JA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=c1Ap+tTH; arc=none smtp.client-ip=45.254.49.198
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 439d318bf;
	Wed, 24 Jun 2026 23:01:56 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [PATCH net-next] openvswitch: conntrack: annotate ct limit hlist traversal
Date: Wed, 24 Jun 2026 23:01:49 +0800
Message-Id: <20260624150149.3510541-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9efa26efcc03a1kunmf4a0eb873b849
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTUpCVkJCGkNMSxpMGENJSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=c1Ap+tTHfDsdYdMhYOR9tWKp2pqzRBoj9zBWhOAKbUYJDaRetHeyB2lt7HKIHXgPT42OZ7L2wc1MaGQf01zEgADYm9Gf3H0uWxf1vuGaNDioM3m0nbRNNdxHUOKQCeT/p+rW2pD6MkFnoPlxDD5aWW5B9uiCVXAb6TSJs4Vs4O8=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=v0emlpGfulGP8V887Y1pHMTBiLupsSDCWgA/s1jrzbQ=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301690-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:dev@openvswitch.org,m:linux-kernel@vger.kernel.org,m:runyu.xiao@seu.edu.cn,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 524166BF8E7

ct_limit_set() is documented as being called with ovs_mutex held. It
walks the ct limit hlist with hlist_for_each_entry_rcu(), but the
iterator does not currently pass the OVS lockdep condition used
elsewhere for RCU-protected OVS objects.

Pass lockdep_ovsl_is_held() to the iterator. This matches the function's
existing caller contract and lets CONFIG_PROVE_RCU_LIST distinguish the
ovs_mutex-protected update path from the RCU read-side ct_limit_get()
path.

This was found by our static analysis tool and then manually reviewed
against the current tree. In the reviewed CONFIG_PROVE_RCU_LIST triage
run, the writer-side ct limit update produced the expected "RCU-list
traversed in non-reader section!!" warning while ovs_mutex was held,
with the stack matching ct_limit_set() and ovs_ct_limit_set_zone_limit().
The change is limited to documenting the existing protection contract.

This is a lockdep annotation cleanup. It does not change the conntrack
limit list update or release behavior.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/openvswitch/conntrack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index c6fd9c424e8f..95697d4e16e6 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -883,7 +883,8 @@ static void ct_limit_set(const struct ovs_ct_limit_info *info,
 	struct hlist_head *head;
 
 	head = ct_limit_hash_bucket(info, new_ct_limit->zone);
-	hlist_for_each_entry_rcu(ct_limit, head, hlist_node) {
+	hlist_for_each_entry_rcu(ct_limit, head, hlist_node,
+				 lockdep_ovsl_is_held()) {
 		if (ct_limit->zone == new_ct_limit->zone) {
 			hlist_replace_rcu(&ct_limit->hlist_node,
 					  &new_ct_limit->hlist_node);
-- 
2.34.1



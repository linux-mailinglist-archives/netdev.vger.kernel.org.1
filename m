Return-Path: <netdev+bounces-302337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m4fKF5zQP2oAYgkAu9opvQ
	(envelope-from <netdev+bounces-302337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 15:31:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF4A6D1FFA
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 15:31:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b="QRzWDQO/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302337-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302337-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EAF4301D336
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 13:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDA538886D;
	Sat, 27 Jun 2026 13:31:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6236C5AE;
	Sat, 27 Jun 2026 13:30:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782567061; cv=none; b=lgTuxEfmoYi3Bx/3WK1ecH11qdN8lKiqcluCCC8Okqugc+8fXgtYFElghGQm5ak+GInEoyxqQaRfpM4DjyTZaevWnymgZkeavA2bJPywA6g9PQYLCaWdqrLipga95l+/ZD1GdX5CGz0Ql6Qerove12QOu7mqE3Ip9O/fRsoLCCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782567061; c=relaxed/simple;
	bh=KsfSqqfjYjdrTEywzPG+vZec0FaK/PzKcLvf//wJplM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gf/pYqPh4OBUZ9HWry0YmAToxMwx6BTnCqa0ut34pN3FUllUNEW4Upal9PX3pVNyAaQIWQI1NVRSaYSqUHmsTzD5t4YzItw3MWP+bG5vDWb6CBfrdWxbsiclQsthlZcuOo+8USwMWH9zE3yA9xJCv1NxzaOBiL6vSqoYHzjEEOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=QRzWDQO/; arc=none smtp.client-ip=45.254.49.197
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 44003fdf3;
	Sat, 27 Jun 2026 21:25:44 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Question: bridge: clarify MST VLAN list RCU traversal contract
Date: Sat, 27 Jun 2026 21:25:39 +0800
Message-Id: <20260627132539.3701630-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f0941f21903a1kunm6870078cd1180
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTRhJVhodTBhPGRpKGkkdS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QRzWDQO/9WPdeQzsbZ30FreXwoqG7XekJtbKubt9eBc0W27gC/4yca4rDkf3xpDWPy3oZsgPCTg2nCtPatabQ5SHNJDpHKr07J4roVd6NhvIUv0uclmtFqb7S5F4Pcei8oX9N/GUH1xYre2EujBMESof+JfTwaMnJnYhFhO8W2U=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=aGEZ6gZtMKGo9wdTJQLn/OJG9o5Lvqyo3f6OLohy5u8=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302337-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:razor@blackwall.org,m:idosch@nvidia.com,m:runyu.xiao@seu.edu.cn,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,seu.edu.cn:dkim,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CF4A6D1FFA

Hi bridge maintainers,

This question comes from a candidate found by our static analysis tool
and then manually reviewed against the current tree. The audit used
CONFIG_PROVE_RCU_LIST as target-matched triage evidence; I am asking
for maintainer guidance because the source-level review did not prove
a use-after-free.

A CONFIG_PROVE_RCU_LIST audit flags the VLAN-list traversal in
br_mst_info_size():

  net/bridge/br_mst.c:251 br_mst_info_size()

The helper walks vg->vlan_list with list_for_each_entry_rcu().  In the
direct local context, br_get_link_af_size_filtered() first enters an
RCU read-side section, resolves the bridge port or bridge VLAN group,
and calls br_get_num_vlan_infos(vg, filter_mask).  That local RCU
read-side section is then dropped before the later MST sizing call:

  net/bridge/br_netlink.c:104 rcu_read_lock()
  net/bridge/br_netlink.c:113 br_get_num_vlan_infos(vg, filter_mask)
  net/bridge/br_netlink.c:114 rcu_read_unlock()
  net/bridge/br_netlink.c:123 br_mst_info_size(vg)

The helper is registered through rtnl_af_ops.get_link_af_size, and
bridge VLAN updates appear RTNL-centered, so the broader rtnetlink
sizing path may already provide the intended serialization.  I am not
claiming a use-after-free here.  The question is only whether the
RCU-list traversal contract around br_mst_info_size() should be made
explicit enough for CONFIG_PROVE_RCU_LIST to see it.

Would you prefer one of these directions?

  1. keep the MST sizing loop inside an explicit rcu_read_lock() in
     br_get_link_af_size_filtered();

  2. pass a confirmed RTNL lockdep condition to the iterator in
     br_mst_info_size();

  3. document that the outer rtnetlink sizing path is the required
     protection and leave the helper unchanged;

  4. use a different bridge-specific pattern.

I am intentionally sending this as a maintainer question rather than a
patch because the right contract seems to depend on the bridge/rtnetlink
caller semantics.

Thanks.


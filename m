Return-Path: <netdev+bounces-233817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA77CC18D59
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84F6B1C60E20
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527B1312822;
	Wed, 29 Oct 2025 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hL9WWqOy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C52FF171
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724940; cv=none; b=HOmCihooDEsF+XCSvdxrrw45J5+DZ8CN5L4lyUeP7hunmwxp8ln3Vhe6GZbFZjtlLzWZ3nPUtwpGw5TRotW4WSehk/eElSXPJ7BliGoX5heSXvnMTktQ/Pkax6RJtO6Cutkf8o2GR6xd0EXMnIoRq/zDgCyqSx7G2XoLnO/XJmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724940; c=relaxed/simple;
	bh=MdVp8CiLEFaaVoxq+Rb53Wct36lN3EUZ5mBXUNuKOVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jneWbcec4J0zIxxcl2Kx6pPeXl0SMiHyUAFfSuTDd6vqdeZ5wWhB+VCWCBJyaiSIzM+VCJ+dmIiMP31cVfECIlZWklriX2nao2EPN7ZvEWuiURQvxGCqrY+m+p6ESEEtxyTzPTX8A6pqexgvIF0kRevRAlXEG7MdLo3CA3+psp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hL9WWqOy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761724937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q5n0VscfDcUD7y+LkJeaZSEYs6iu6kK4Zki+VPNsw60=;
	b=hL9WWqOydlMXXwSviQgrhaZuXUlg/GIeBjDCnF6iZ1NCdNmWkV8YHd3cSDfk591D+1Rmq9
	4JcX24OduWi+MaHB5Nx6gl0PV9CQakjnFgu6khoZDQYVwV1ZQq4fj6C2vQ/DCyUwc+xsMw
	KV2+Jd+obT9TuM9ugG/4GHtDFIesBYA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-KkcDhH-2MDiSC19sm5Tmzw-1; Wed,
 29 Oct 2025 04:02:13 -0400
X-MC-Unique: KkcDhH-2MDiSC19sm5Tmzw-1
X-Mimecast-MFC-AGG-ID: KkcDhH-2MDiSC19sm5Tmzw_1761724930
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 318521808981;
	Wed, 29 Oct 2025 08:02:10 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.45.225.97])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CFE4F30001A2;
	Wed, 29 Oct 2025 08:02:04 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	nicolas.dichtel@6wind.com,
	toke@redhat.com,
	Adrian Moreno <amorenoz@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Cong Wang <cong.wang@bytedance.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in IFLA_STATS
Date: Wed, 29 Oct 2025 09:01:52 +0100
Message-ID: <20251029080154.3794720-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Gathering interface statistics can be a relatively expensive operation
on certain systems as it requires iterating over all the cpus.

RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
statistics from interface dumps and it was then extended [2] to
also exclude IFLA_VF_INFO.

The semantics of the flag does not seem to be limited to AF_INET
or VF statistics and having a way to query the interface status
(e.g: carrier, address) without retrieving its statistics seems
reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
to also affect IFLA_STATS.

[1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
[2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/core/rtnetlink.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 8040ff7c356e..aa09d026817b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1275,8 +1275,9 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + nla_total_size(IFALIASZ) /* IFLA_IFALIAS */
 	       + nla_total_size(IFNAMSIZ) /* IFLA_QDISC */
 	       + nla_total_size_64bit(sizeof(struct rtnl_link_ifmap))
-	       + nla_total_size(sizeof(struct rtnl_link_stats))
-	       + nla_total_size_64bit(sizeof(struct rtnl_link_stats64))
+	       + ((ext_filter_mask & RTEXT_FILTER_SKIP_STATS) ? 0 :
+		  (nla_total_size(sizeof(struct rtnl_link_stats)) +
+		   nla_total_size_64bit(sizeof(struct rtnl_link_stats64))))
 	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_ADDRESS */
 	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_BROADCAST */
 	       + nla_total_size(4) /* IFLA_TXQLEN */
@@ -2123,7 +2124,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	if (rtnl_phys_switch_id_fill(skb, dev))
 		goto nla_put_failure;
 
-	if (rtnl_fill_stats(skb, dev))
+	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS) &&
+	    rtnl_fill_stats(skb, dev))
 		goto nla_put_failure;
 
 	if (rtnl_fill_vf(skb, dev, ext_filter_mask))
-- 
2.51.0



Return-Path: <netdev+bounces-232009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D484BBFFF25
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 788E835256C
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 08:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D92630101B;
	Thu, 23 Oct 2025 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cM7Lod8F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD9C2FCBED
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208507; cv=none; b=OLY/hSv9fsUG4Q7HMSDKpdhZe1J/Aktsac9ynFqLvzYgpOYelpm1WL+eAtQsZ27z2e6YZCrT/pLc8+Fx0aB9fkqNSwgb6LwCL+Z2FdY/qt67SFk54leytkpLg2HEB5LD0Ra2nI8OcRTkoPidkKRjMy5o8WO+Oj6WqE4peQGur2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208507; c=relaxed/simple;
	bh=bVtvp3MLF47bsFgFrN+KuyvROdXjdq8WgvgvNvEKbxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RSb6/++pnPpKe8xmGBOow1JBRJgUxaOIBlQHlL0vjbPYkX9cgfubeBF/rqu1HRsj4vN6Ag9NZ4+PO5cvZbsxm8BTvHP81JZBoeBpSujZVeBw0RRIDlGs90Y9HaJ2tXsnzMsQZ2yfXbe0jXGfSHZJ1yIuPxe/Y0xfnzeDArSVPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cM7Lod8F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761208504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c/siw8ZRuLKXXTv+YJVAOyEvr/nMP9ZYmhTuasRVQ4Q=;
	b=cM7Lod8F1lVtATkh8T5xmEwwHJDXPEpthzZNFZAW/D434ysHQEplgmcibFIrx38qK2wIDr
	4nPBlInvBg37UZoWoeKB08PL/a0/kSxBBcnQATyUry6QLHaFIkPUVKgr/T4YrMPsUV6lzR
	HYc6AX2X5dRXH+p6E2xMbNwDdrB5eWE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-PsQz1Wz5MSOJRntEtwGw6Q-1; Thu,
 23 Oct 2025 04:35:01 -0400
X-MC-Unique: PsQz1Wz5MSOJRntEtwGw6Q-1
X-Mimecast-MFC-AGG-ID: PsQz1Wz5MSOJRntEtwGw6Q_1761208499
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 237451800245;
	Thu, 23 Oct 2025 08:34:59 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.45.226.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE48D180045B;
	Thu, 23 Oct 2025 08:34:53 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: toke@redhat.com,
	Adrian Moreno <amorenoz@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Cong Wang <cong.wang@bytedance.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in IFLA_STATS
Date: Thu, 23 Oct 2025 10:34:48 +0200
Message-ID: <20251023083450.1215111-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
 net/core/rtnetlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 8040ff7c356e..88d52157ef1c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2123,7 +2123,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	if (rtnl_phys_switch_id_fill(skb, dev))
 		goto nla_put_failure;
 
-	if (rtnl_fill_stats(skb, dev))
+	if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS &&
+	    rtnl_fill_stats(skb, dev))
 		goto nla_put_failure;
 
 	if (rtnl_fill_vf(skb, dev, ext_filter_mask))
-- 
2.51.0



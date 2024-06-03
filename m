Return-Path: <netdev+bounces-100329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CA08D8919
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 20:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C261F261F9
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 18:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FE613A89C;
	Mon,  3 Jun 2024 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TT/igu/7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901AE13A3F9
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441046; cv=none; b=nQgj1vIIB7Ln9/oQMQxhgNtNhs6JhC+wq8lS8uzu1J9NH0VrcxJ4AWnTYv7dHbToi2e35nkcwXvqc9REznEsht4AdOEop008QcWA17Mlj6CmqFsiKuCkXb8jkH2AvhASwdL/aMowkISr9WZaUrsoJAaqg72Gr4EfA/EzD/TRQjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441046; c=relaxed/simple;
	bh=9iZFbFIqgMdQvgciGYpaXFrrxvOTwy3YOFeAKytklLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmaMo5usUjpb77QPPdDd1va2KeO7KYbUFe/VwN/hjQHcES65O+xwVjbTmZ70oVUXxvQIPUFPZibUQA1PFZkbaWnFqU4xdQUcQjt2gY8FIMrUoliwbisM0TatCEwh2utOITgowG78bw2jLsT6snYy3zlc4NuJFuW9QIToVWRrXKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TT/igu/7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717441043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+C3Lxc1H/BkHmxaLgkIrAXsMU+NbPCnsT3EFyhByuc=;
	b=TT/igu/7+eHDhmxR1HWsGpz70nycjGQXz28SYBnokc7ORulrKInD4km5Ue6B2fFZTJavRn
	HEx0keptQGWTgsJyQF8VeSZAxSGZUUqw/kfpXTRumEzt5RSQyeTZJAcYxk21s2+tR5ldaT
	EbLtAN3ynV1lhNmQYTY6mLuqNM1ZUQI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-yJC5n1d4MP23gZgdSGrKzQ-1; Mon,
 03 Jun 2024 14:57:20 -0400
X-MC-Unique: yJC5n1d4MP23gZgdSGrKzQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DD5318BF6C6;
	Mon,  3 Jun 2024 18:57:18 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.193.112])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6521D1955F6E;
	Mon,  3 Jun 2024 18:57:14 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/9] net: psample: skip packet copy if no listeners
Date: Mon,  3 Jun 2024 20:56:37 +0200
Message-ID: <20240603185647.2310748-4-amorenoz@redhat.com>
In-Reply-To: <20240603185647.2310748-1-amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If nobody is listening on the multicast group, generating the sample,
which involves copying packet data, seems completely unnecessary.

Return fast in this case.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/psample/psample.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/psample/psample.c b/net/psample/psample.c
index b37488f426bc..1c76f3e48dcd 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -376,6 +376,10 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 	void *data;
 	int ret;
 
+	if (!genl_has_listeners(&psample_nl_family, group->net,
+				PSAMPLE_NL_MCGRP_SAMPLE))
+		return;
+
 	meta_len = (in_ifindex ? nla_total_size(sizeof(u16)) : 0) +
 		   (out_ifindex ? nla_total_size(sizeof(u16)) : 0) +
 		   (md->out_tc_valid ? nla_total_size(sizeof(u16)) : 0) +
-- 
2.45.1



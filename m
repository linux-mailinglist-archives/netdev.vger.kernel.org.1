Return-Path: <netdev+bounces-107957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD5391D39E
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 21:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC104280C44
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 19:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680831586F5;
	Sun, 30 Jun 2024 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wmt3F1uf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD96157E82
	for <netdev@vger.kernel.org>; Sun, 30 Jun 2024 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719777492; cv=none; b=poxy/TlDVHRvtXqkZhicLKUjKJGTcEov9vxml3eQxV0EDlBfB4UAYGYRQvTZoBlCY8r6NoA+Qcg79ZYjc/g/sHapGfJb6/ItPza6vWVd3LaCLYMshSLzvFpyV9sKbMkw+6v+VgMKKmWwFc6B2tFfnQ+H5P7qKPqmnsM0x6atkGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719777492; c=relaxed/simple;
	bh=OwDvHl+s4ECjeytw/0sjArzf4oaD21GZ98U6MT4B8E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kz24UL/44qBt+mAigfcFHXp1cZN4Q+zydwup4d7cCMh8wq1R2rXrhlhOO6XDehB8aqc6kBF5cixBbUSFqNBViJP1PMXED+1WVx0/iD7etb9i0Jv6hSGWNbqW1bod3rBKE4W63pXRXwxUbt3TxIkySQ2rj4zI5SPpNsEB39e4WW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wmt3F1uf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719777489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2D874c+YhsRMRneo/991mnvInFwFQ/UmgHZ/hmjeug=;
	b=Wmt3F1uff0M4CIs7h2dIlu8UMVN/Ad2q0zy6I1S7qkFpHOKg8KHlC98+hZRjsQ6uIDuAVw
	Vie6APqhMwUd953nwGiNFENZBEjY4j5Vjeae3TDJLuLQcLlohp/077AGNYb5XhX0PPt2lt
	jZ31JT2Qxi7sddcC/hHfzBHqv72UYmg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-4vffkKL-PYGah4nYN8AYMw-1; Sun,
 30 Jun 2024 15:58:06 -0400
X-MC-Unique: 4vffkKL-PYGah4nYN8AYMw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 509741956096;
	Sun, 30 Jun 2024 19:58:04 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.78])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E52719560AE;
	Sun, 30 Jun 2024 19:57:59 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	dev@openvswitch.org,
	Adrian Moreno <amorenoz@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 03/10] net: psample: skip packet copy if no listeners
Date: Sun, 30 Jun 2024 21:57:24 +0200
Message-ID: <20240630195740.1469727-4-amorenoz@redhat.com>
In-Reply-To: <20240630195740.1469727-1-amorenoz@redhat.com>
References: <20240630195740.1469727-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If nobody is listening on the multicast group, generating the sample,
which involves copying packet data, seems completely unnecessary.

Return fast in this case.

Acked-by: Eelco Chaudron <echaudro@redhat.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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
2.45.2



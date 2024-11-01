Return-Path: <netdev+bounces-141113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA009B99A5
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 21:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E6C28276D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 20:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3066C1E2304;
	Fri,  1 Nov 2024 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVXAmFWR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DDF1E0E18
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 20:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730494065; cv=none; b=WMZgxyFRF8WlgxQQYVcK5todOBQyltsK6+So0AgUf9eZnAsaI69Nktqz5Gyk2dz+m9Uc/hVVHZOkKBart9WZveLgKg4w6SG2dSj8oFsmjIQRFoHQY+VYataV4kBHExJrr6AYRIszQlVCRm0s+5oDALrc36sjrkwAPbLP6it0zDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730494065; c=relaxed/simple;
	bh=+ACGm2X5bUfV1u+PCezkp/95pbZzsXWMR5I9lLuWjvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0jXXhnTFfH6Ztqk6/WPjgIiSqfxOgDvK/1qQJ3qffirFeWXXuCWqckuawYkZnEStPRENRn5pz2DkP5l+lBApsu8VvUyn+GSp6iB4ZY5/77BFP4BQmSJIRBZQy/3ifaPu8oTib7XE77a9ZdUzu6QVKmQTVa/We/6RcD4x/uYXJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eVXAmFWR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730494062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5YsdMdfOSE2dnJUvKdNseEnsfpuXrSxxUdmFCTsEsdI=;
	b=eVXAmFWRSqJmG5Fv2iVHuIW82u9h9dhLNfuzLfkZcvkbqsz5nlN3AfdyuUUl6cHSfieAXe
	x7obLY5koAlENtDhDSVUb/Q/Ow+ypA9lJmaZpqotdMEmXDHOqDd5mHtQedUpksDq83n4s4
	dqQD+YOBo8drp8uOHnDFr1hcvWNfSJE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-eqHijaepOpaQSVKpPLhjjg-1; Fri,
 01 Nov 2024 16:47:39 -0400
X-MC-Unique: eqHijaepOpaQSVKpPLhjjg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA1E2195608C;
	Fri,  1 Nov 2024 20:47:36 +0000 (UTC)
Received: from RHTRH0061144.redhat.com (unknown [10.22.66.84])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A508195605A;
	Fri,  1 Nov 2024 20:47:33 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] openvswitch: Pass on secpath details for internal port rx.
Date: Fri,  1 Nov 2024 16:47:32 -0400
Message-ID: <20241101204732.183840-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Clearing the secpath for internal ports will cause packet drops when
ipsec offload or early SW ipsec decrypt are used.  Systems that rely
on these will not be able to actually pass traffic via openvswitch.

There is still an open issue for a flow miss packet - this is because
we drop the extensions during upcall and there is no facility to
restore such data (and it is non-trivial to add such functionality
to the upcall interface).  That means that when a flow miss occurs,
there will still be packet drops.  With this patch, when a flow is
found then traffic which has an associated xfrm extension will
properly flow.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
 net/openvswitch/vport-internal_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 5858d65ea1a9..2412d7813d24 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -195,7 +195,6 @@ static int internal_dev_recv(struct sk_buff *skb)
 
 	skb_dst_drop(skb);
 	nf_reset_ct(skb);
-	secpath_reset(skb);
 
 	skb->pkt_type = PACKET_HOST;
 	skb->protocol = eth_type_trans(skb, netdev);
-- 
2.46.2



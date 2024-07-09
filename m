Return-Path: <netdev+bounces-110428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C81892C49D
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 22:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03252282CAB
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 20:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65585185607;
	Tue,  9 Jul 2024 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKawx/X2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B63144313
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557325; cv=none; b=eVpVl53KSWgxaVM6HRKEkbl5wxdYOS9ySM5yT5z/5hX0oTBtZAma3OUDNNCn+62NG0dQT4u/GgmPKXEDj7NeN5me92YJgQavlukuEu/rNIVqP90tadZZ067alzgnVS0glEr8fYpRg/406i5ZDDBLHIqR2FtH5DQG3rK2GXZP4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557325; c=relaxed/simple;
	bh=eKUKhI2YBw/Ad6+G7vSsx7UPtabwPEA29W5Ci9CXXpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qaRe2G2bY7EDRwFgb7uGUy8WBajUnZuV00ViB4/PJnPgK+4NKHjZsreDAPcFWEHFToSa61Tijmv97c+DS208soYZTMgntR5evES2EQfWUZtWkZXhrPoZKegTMIr5xg3awZwaAOBxf8X1UnzBWMB3rxY3KggXmIxgbeJZLWyf05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IKawx/X2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720557321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bQGIDaP1t/pBYsaGFONgFaSDOJQEw7gzA1HsrUDl/TE=;
	b=IKawx/X2oGPw371uw+Kc/18x9xAQleL2JHoq7UsuA5AcCXe5ApltR4+bM/kmJe00kUAncE
	FlL/Cf3kmCqWKVrccsVFqUewJEgKkRRdu1ApylT0BDZEvmOT70u865+AK2YmeqTklcGJSl
	asIrng8f6AJIXzOrJBkrCTimh5zAhGI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-3aRxG6oTO369D0qNUyAT1Q-1; Tue,
 09 Jul 2024 16:35:17 -0400
X-MC-Unique: 3aRxG6oTO369D0qNUyAT1Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 987461944B3E;
	Tue,  9 Jul 2024 20:35:14 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.192.91])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 55D231955DA1;
	Tue,  9 Jul 2024 20:35:06 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: psample: fix flag being set in wrong skb
Date: Tue,  9 Jul 2024 22:34:36 +0200
Message-ID: <20240709203437.1257952-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

A typo makes PSAMPLE_ATTR_SAMPLE_RATE netlink flag be added to the wrong
sk_buff.

Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/psample/psample.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/psample/psample.c b/net/psample/psample.c
index f48b5b9cd409..11b7533067b8 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -498,7 +498,7 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
 		goto error;
 
 	if (md->rate_as_probability)
-		nla_put_flag(skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
+		nla_put_flag(nl_skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
 
 	genlmsg_end(nl_skb, data);
 	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
-- 
2.45.2



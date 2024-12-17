Return-Path: <netdev+bounces-152570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40EB9F4A06
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8169A7A4239
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5721F1EF0B1;
	Tue, 17 Dec 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gs3Wq/uI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818231EC4D6
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435476; cv=none; b=eCbWPyma6V6mti8EGFgtSzlqLTzFHJhnybFZS3o7YXyg7pIVSjsTIWd2pkQidHLAL5EvNEs+KtsECZtnPVd+mAi/NK10evMgRgFd6dMbwfCk9LQsgtNemwTGFI7uy9XyC/QN1PcOYl7AlpdU1twWkjK4jlN1nSr9j/rHyOSKxDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435476; c=relaxed/simple;
	bh=9ty8582afXSWd/BOtZ1GC6HtEkTIV6qWwE4tUjiw8Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZQ7Y41Zo0SsJZQwGmY7NFSOi2SS6Yi/zuorxD0yzIOdeYLA9gQLccqIOKm6Ls8B1Ea//st/VMu87g4DEyuplEDY7/bUd5QAVkFqjgy0tGS4G+i09BZ6G11cq5I1K3G7ZsGvc4VSBMEPJ4AHjckQzGjesZHxGKwjad875/9f3EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gs3Wq/uI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734435473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6s04YPn1lNBo5J95MJd6h2MhVnv9P1D3qpQ6LE+2vHc=;
	b=gs3Wq/uIfS4cxiQVeGeOqcuG8nMlZ1aqgtM6NOMNRG6ggZemkS6QzFPAMWL8hISVg4YIAl
	xtlFexqBHb+mCcYoElKJiG3eYapdx4vCptND1c2B0lp6kCPkQPDTDYITX8FqD6iCiX8Fzn
	0A9Fd/VLoApj+YLbkpFiyoiffFenJ3w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-hJ60qpFoPcWtVFWFQ6NqMw-1; Tue,
 17 Dec 2024 06:37:50 -0500
X-MC-Unique: hJ60qpFoPcWtVFWFQ6NqMw-1
X-Mimecast-MFC-AGG-ID: hJ60qpFoPcWtVFWFQ6NqMw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDDC619560AF;
	Tue, 17 Dec 2024 11:37:48 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.221])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 696761956053;
	Tue, 17 Dec 2024 11:37:44 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] psample: adjust size if rate_as_probability is set
Date: Tue, 17 Dec 2024 12:37:39 +0100
Message-ID: <20241217113739.3929300-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If PSAMPLE_ATTR_SAMPLE_PROBABILITY flag is to be sent, the available
size for the packet data has to be adjusted accordingly.

Also, check the error code returned by nla_put_flag.

Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/psample/psample.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/psample/psample.c b/net/psample/psample.c
index a0ddae8a65f9..25f92ba0840c 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -393,7 +393,9 @@ void psample_sample_packet(struct psample_group *group,
 		   nla_total_size_64bit(sizeof(u64)) +	/* timestamp */
 		   nla_total_size(sizeof(u16)) +	/* protocol */
 		   (md->user_cookie_len ?
-		    nla_total_size(md->user_cookie_len) : 0); /* user cookie */
+		    nla_total_size(md->user_cookie_len) : 0) + /* user cookie */
+		   (md->rate_as_probability ?
+		    nla_total_size(0) : 0);	/* rate as probability */
 
 #ifdef CONFIG_INET
 	tun_info = skb_tunnel_info(skb);
@@ -498,8 +500,9 @@ void psample_sample_packet(struct psample_group *group,
 		    md->user_cookie))
 		goto error;
 
-	if (md->rate_as_probability)
-		nla_put_flag(nl_skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY);
+	if (md->rate_as_probability &&
+	    nla_put_flag(nl_skb, PSAMPLE_ATTR_SAMPLE_PROBABILITY))
+		goto error;
 
 	genlmsg_end(nl_skb, data);
 	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
-- 
2.47.1



Return-Path: <netdev+bounces-109149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597A5927267
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9271C24245
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE73A1ABC43;
	Thu,  4 Jul 2024 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZRIw20ek"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3CF1AB91B
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083486; cv=none; b=TeJRRhCwUw3nlAW9zC6wdzyMAR0KcF+M7/WcvWxbMBIUpBA9qeg9FxR6w9ANy8NTUz6b90ByIBAdq8rUc0Ol22nEqgecSxh+uaiE/fdpavch+sSh9bakyqRVFmUgt8ekPoDB5gL8WPW/9O7oyyR3HSmw+bOPdipToDUdlq52KOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083486; c=relaxed/simple;
	bh=tEMt8uF4hWy9k1ZIQOKRPv/vvsgheompOMTSikfwhVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/KbNj8h8L9frIG4ehIDfappTHfX1FwC2hsveztQ8gtkxyJ7U+3Ws+h32f/BcOFgcLYx3PIt4aNFf68IvoSGdlcW588zcXXrcfjuJHJRrUevH8/b2jDeyk5BCMv1LqWIVU3VuTgvjanQQ3tjtmwjxZHX19ddhuYEmVi6kVH6xv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZRIw20ek; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720083484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=818RCWMsmwDVM2bQEv4PthGvmSOhVSaUgggsNvr7KIY=;
	b=ZRIw20ekaNqFuijqug8R8ggv4ierQBSKhqZoQTkM3Gw7WPslHoQaIDc/stCm5dLBwlkhSm
	F6hE82x8zsgfWMKIrspnkVyMeSGKfbbrJxeYzEPCAZR6gGV32Q3Y5CTNE4fEtJ3g6JTQU5
	D1XE3drMCPdgIC9U0p+mZ+HRrv8lPKw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-0wYuTK5MNnuzL-pstCPxKg-1; Thu,
 04 Jul 2024 04:57:58 -0400
X-MC-Unique: 0wYuTK5MNnuzL-pstCPxKg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E373B19560B0;
	Thu,  4 Jul 2024 08:57:56 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.39.194.59])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A63A6195605F;
	Thu,  4 Jul 2024 08:57:52 +0000 (UTC)
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
Subject: [PATCH net-next v9 03/10] net: psample: skip packet copy if no listeners
Date: Thu,  4 Jul 2024 10:56:54 +0200
Message-ID: <20240704085710.353845-4-amorenoz@redhat.com>
In-Reply-To: <20240704085710.353845-1-amorenoz@redhat.com>
References: <20240704085710.353845-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

If nobody is listening on the multicast group, generating the sample,
which involves copying packet data, seems completely unnecessary.

Return fast in this case.

Reviewed-by: Aaron Conole <aconole@redhat.com>
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



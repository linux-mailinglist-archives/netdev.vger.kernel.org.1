Return-Path: <netdev+bounces-188929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6393AAF6D0
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B54A1C00F2D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B134E1DE2DF;
	Thu,  8 May 2025 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ohjro4xz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C474D5A79B
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746696799; cv=none; b=E6Cny172ZCuvC4g0v2f7B02F5TZY4i1b7/d8QtRwkORboC2Y+3/6MpcJTEw/NHnl//xCWvRBv7qKphOLyoJZK0SztlpwTci2W8E1gM3sKFid/6YXESasrWfSxwi6s+m9SoGWYU6s0qphBKp4vS3KjZ1as1CqWWaECPHSiFJ3+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746696799; c=relaxed/simple;
	bh=MIcMNCN0yxEIl4+VKAPbVhpqQu5fNc7cWdKq8RsxHdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHTb6MlEJMNGDTCBX+TsQphEPxKElpTvYjU+rASmU2qnlQdvP7PY0CNPg7wOMmS+ao9ijk6a7HZ8/+/Jc9AojqngD7ArALq+WOniWU82WBxLhMEhoK/7wllemDtqXE34USIRjsnQgu5ox8MkdsoGbMGI7tXmsh1mJFm9cxLppio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ohjro4xz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746696796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OR1ZGQVTIKUpEENV7dGU8xGWlUkywcJ9E6vpkGW9DKc=;
	b=Ohjro4xzYTPQQ9+OhlbssDhMyqiwRIaQsYc15ynt7OGCJpqzwV7jzzKD5k956KUiUQVhhV
	iJfKsndQW16uK8+DKKUhOnYNOWoAyVTdpSJ2Ta7x1ecHaG6SFpzliSeTrZ6DEptG3m0SOd
	f8c+2CYC9SCVc1UWde7uQkZ07bTepw0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-cwDOKpg5OiO3W6w7Eck0gw-1; Thu,
 08 May 2025 05:33:13 -0400
X-MC-Unique: cwDOKpg5OiO3W6w7Eck0gw-1
X-Mimecast-MFC-AGG-ID: cwDOKpg5OiO3W6w7Eck0gw_1746696792
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D85A6180048E;
	Thu,  8 May 2025 09:33:11 +0000 (UTC)
Received: from ebuild.redhat.com (unknown [10.44.33.52])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75E9C1955F24;
	Thu,  8 May 2025 09:33:08 +0000 (UTC)
From: Eelco Chaudron <echaudro@redhat.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net-next] openvswitch: Fix userspace attribute length validation
Date: Thu,  8 May 2025 11:32:27 +0200
Message-ID: <051302b5ef5e5ac8801bbef5a20ef2ab15b997a2.1746696747.git.echaudro@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The current implementation of validate_userspace() does not verify
whether all Netlink attributes fit within the parent attribute. This
is because nla_parse_nested_deprecated() stops processing Netlink
attributes as soon as an invalid one is encountered.

To address this, we use nla_parse_deprecated_strict() which will
return an error upon encountering attributes with an invalid size.

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
---
 net/openvswitch/flow_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/flow_netlink.c b/net/openvswitch/flow_netlink.c
index 518be23e48ea..ad64bb9ab5e2 100644
--- a/net/openvswitch/flow_netlink.c
+++ b/net/openvswitch/flow_netlink.c
@@ -3049,7 +3049,8 @@ static int validate_userspace(const struct nlattr *attr)
 	struct nlattr *a[OVS_USERSPACE_ATTR_MAX + 1];
 	int error;
 
-	error = nla_parse_nested_deprecated(a, OVS_USERSPACE_ATTR_MAX, attr,
+	error = nla_parse_deprecated_strict(a, OVS_USERSPACE_ATTR_MAX,
+					    nla_data(attr), nla_len(attr),
 					    userspace_policy, NULL);
 	if (error)
 		return error;
-- 
2.47.1



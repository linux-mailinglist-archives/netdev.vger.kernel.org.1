Return-Path: <netdev+bounces-189653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E9FAB3121
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 514D97A6F29
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4F92580C0;
	Mon, 12 May 2025 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzJQtBgS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747C8257AF2
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037372; cv=none; b=lGNM+LIzneL60Y/wUUonhJPxzUP+Yw3Sb/plcSlyOVkz4ugMNqbLG7QUOHtQPkcCrGiueyNc31ItxcyJvHfuUxIrZXwsBvsNECt9bht92HOkTpxcgmRgIIyECMPGHuIPsy7NroqhgqFzEdE4vIJHeSI8MyNZYTXK5f0hvaRF+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037372; c=relaxed/simple;
	bh=Q7uHqkDDclRs70qo4/u2K4ILwwDXIBGQXaKZ+cmVRzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bFI5eMlQO4nloRGPD7+kD5eRzPwsFNyz+fE9mpuSd6KMxQpQTDL51wV4IKKJyIXWOJxpzUKz8dK3nzJfk3/4RG+m0PeiYxW22s8pxc+dFZsZoMXVU+007sm/cOPqBCDbaQCvJauhCncW7WbBUUOTUmzO7MS+l5fQ1Z7TNc24yyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzJQtBgS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747037369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zXKqGWZ2H5LVLy5Nqxsp7w1xAyBBGTjBwcIruBNQPW4=;
	b=YzJQtBgS9OI9SzAbYr3Z6wcS9P43TCCo91bEYjIUcpg9sFsnn6leuKU7cHvxEh9vkFy76y
	pPHyX+q5qtG1FopxdOpKiVDyDTKQW+BD4Pa4IWkA1Dl0k62UNMQJlc2s6CqpZmiSNnt1NG
	+s2Mb2R8pXvWnOmSmgkA+UJ6l3HOFps=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-jp5hCRF8MIiQy9NKDZ3x9g-1; Mon,
 12 May 2025 04:09:24 -0400
X-MC-Unique: jp5hCRF8MIiQy9NKDZ3x9g-1
X-Mimecast-MFC-AGG-ID: jp5hCRF8MIiQy9NKDZ3x9g_1747037362
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 834AC195608A;
	Mon, 12 May 2025 08:09:22 +0000 (UTC)
Received: from ebuild.redhat.com (unknown [10.44.33.52])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DEF051800570;
	Mon, 12 May 2025 08:09:18 +0000 (UTC)
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
Subject: [PATCH net-next v2] openvswitch: Stricter validation for the userspace action
Date: Mon, 12 May 2025 10:08:24 +0200
Message-ID: <67eb414e2d250e8408bb8afeb982deca2ff2b10b.1747037304.git.echaudro@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This change enhances the robustness of validate_userspace() by ensuring
that all Netlink attributes are fully contained within the parent
attribute. The previous use of nla_parse_nested_deprecated() could
silently skip trailing or malformed attributes, as it stops parsing at
the first invalid entry.

By switching to nla_parse_deprecated_strict(), we make sure only fully
validated attributes are copied for later use.

Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
---
v2: Changed commit message based on Ilya's feedback.
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



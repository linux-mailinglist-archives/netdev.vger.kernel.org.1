Return-Path: <netdev+bounces-188368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D65AAC7F8
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 975397B1156
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 14:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CFD2820B8;
	Tue,  6 May 2025 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLnxM3cc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686CC270EA1
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541793; cv=none; b=MZQ5Aub28gTreDUrwFWwedSgO0hK6kgUfwMyLQJDmPCP226U2oPYjGb+fJCABtyfeyO5Yb06RqKlIjtI5lQmzPBqqGgbhZDWRV844ApGPWZRCsFuVqPioaPwT5KdjuLJRt1WPxCztl0kMh6JwfMV2gmewzeLuAdZkYOKncae5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541793; c=relaxed/simple;
	bh=lRUBkf0WiCGEs94dMZU4r9VWJAzTPNKc9POGWT1r5n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8ATEk2H/iQz9vbGj2iEzMnnJsQVxyGKbr/t8vZZm7QaFxlV3DNrOzYbBp8AbrHVBaJr8Ewi9E2LZhuR2+KAu2pSKDnKoVTUlbD6U1RLFXe0WzM0TH5OExPbvZNYWVG9p2hKbwP3yIUEozreGQ6kRsbFPSttr/1C2nZb8h5/d/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLnxM3cc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746541790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z6IAMOzx8anJjTuW2oX0nCMNbivsaEXJ8bAbqHltAYM=;
	b=hLnxM3ccvD6ik5iv/2pJ8hkknofpbw6Hk5uSVbq/3fq7CxNQiNtRe6BaplXb2d1Vc8JLP5
	lziQZ7530ppF2HvFsyCE/aYNZqdfYS4xJf2D5XtECMRuLovzoQZ0biVLGbk+S6Nl/dqZ8Q
	5HJ0OIEKdSt8ghGw1XybbYlyavTNXb0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-EEv7XtbtOPaGOIZj1a278A-1; Tue,
 06 May 2025 10:29:47 -0400
X-MC-Unique: EEv7XtbtOPaGOIZj1a278A-1
X-Mimecast-MFC-AGG-ID: EEv7XtbtOPaGOIZj1a278A_1746541785
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 990CB1955D6F;
	Tue,  6 May 2025 14:29:45 +0000 (UTC)
Received: from ebuild.redhat.com (unknown [10.44.33.52])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF64D19560A3;
	Tue,  6 May 2025 14:29:41 +0000 (UTC)
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
Subject: [PATCH net] openvswitch: Fix unsafe attribute parsing in output_userspace()
Date: Tue,  6 May 2025 16:28:54 +0200
Message-ID: <0bd65949df61591d9171c0dc13e42cea8941da10.1746541734.git.echaudro@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch replaces the manual Netlink attribute iteration in
output_userspace() with nla_for_each_nested(), which ensures that only
well-formed attributes are processed.

Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
---
 net/openvswitch/actions.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 61fea7baae5d..2f22ca59586f 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -975,8 +975,7 @@ static int output_userspace(struct datapath *dp, struct sk_buff *skb,
 	upcall.cmd = OVS_PACKET_CMD_ACTION;
 	upcall.mru = OVS_CB(skb)->mru;
 
-	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
-	     a = nla_next(a, &rem)) {
+	nla_for_each_nested(a, attr, rem) {
 		switch (nla_type(a)) {
 		case OVS_USERSPACE_ATTR_USERDATA:
 			upcall.userdata = a;
-- 
2.47.1



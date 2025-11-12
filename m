Return-Path: <netdev+bounces-238076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60499C53B35
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 18:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85526346CDF
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 17:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1A23446BB;
	Wed, 12 Nov 2025 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5Ap9UkZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2E2D73A3
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968626; cv=none; b=JWu9enSHb+A+3/w81IAnLV9TLDSeQbyr6uX0z5ezaVg4dbrFONYskNGvAsRML07zN9r2+BwlQmJqte7tEIw6FOaYYeZ52Lr2sn2brNylfRgKesNRThTWofdtOCT3EJ6Mx/qu7lGcmkpxlNdOOjYBRKpkQEP31pMBVItGZqxiSqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968626; c=relaxed/simple;
	bh=mcfrAXY0gX/mBERsfTQ7/LGUo3dcxXtPtDBcxEAr3Ro=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CAOryLfPZ20VJyh542/pk3f7ziFKziaAnuoUwPqpANBimrzAugrkWvcPGTrKCePanv9kiCcSnVcQ7e2Y1XljrEVXTS36ZDZVdNeWrnEg8nDmAW06ALFJVKG+PvsZzgz4T+N5EnTpuG+Dbcgi+dZPkIHYstiFyv8PveATyKQjdaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5Ap9UkZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762968624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IvBcKpwrs2dvwx5OxUUc7jmSG0zgCL3qxfMch+Oh4YM=;
	b=A5Ap9UkZo/TNSEY+rcx+z+5skGVxQNpIjEJGH54nvYLdA724GeUkNQkFcv/0EwYx0wiQ/o
	2x+dtgheiT9CsdKuWRRHEmTb46Am4sepIerUNQVS9qTnfLh+Pw+uWg4waVeuUOr7JhNCnl
	yzjBaV6Tez/Y8xd/CIAxehLHHuZ1F8E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-sP_wCntFPg-SwPrDihZ_jg-1; Wed,
 12 Nov 2025 12:30:20 -0500
X-MC-Unique: sP_wCntFPg-SwPrDihZ_jg-1
X-Mimecast-MFC-AGG-ID: sP_wCntFPg-SwPrDihZ_jg_1762968619
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 596B919560AE;
	Wed, 12 Nov 2025 17:30:19 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.44.34.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DFA251800269;
	Wed, 12 Nov 2025 17:30:16 +0000 (UTC)
From: Felix Maurer <fmaurer@redhat.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com
Subject: [PATCH net-next] netlink: specs: rt-link: Add attributes for hsr
Date: Wed, 12 Nov 2025 18:29:53 +0100
Message-ID: <926077a70de614f1539c905d06515e258905255e.1762968225.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

YNL wasn't able to decode the linkinfo from hsr interfaces. Add the
linkinfo attribute definitions for hsr interfaces. Example output now
looks like this:

$ ynl --spec Documentation/netlink/specs/rt-link.yaml --do getlink \
    --json '{"ifname": "hsr0"}' --output-json | jq .linkinfo
{
  "kind": "hsr",
  "data": {
    "slave1": 15,
    "slave2": 13,
    "supervision-addr": "01:15:4e:00:01:00",
    "seq-nr": 64511,
    "version": 1,
    "protocol": 0
  }
}

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 Documentation/netlink/specs/rt-link.yaml | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 2a23e9699c0b..e07341582771 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1913,6 +1913,35 @@ attribute-sets:
         name: port-range
         type: binary
         struct: ifla-geneve-port-range
+  -
+    name: linkinfo-hsr-attrs
+    name-prefix: ifla-hsr-
+    attributes:
+      -
+        name: slave1
+        type: u32
+      -
+        name: slave2
+        type: u32
+      -
+        name: multicast-spec
+        type: u8
+      -
+        name: supervision-addr
+        type: binary
+        display-hint: mac
+      -
+        name: seq-nr
+        type: u16
+      -
+        name: version
+        type: u8
+      -
+        name: protocol
+        type: u8
+      -
+        name: interlink
+        type: u32
   -
     name: linkinfo-iptun-attrs
     name-prefix: ifla-iptun-
@@ -2299,6 +2328,9 @@ sub-messages:
       -
         value: geneve
         attribute-set: linkinfo-geneve-attrs
+      -
+        value: hsr
+        attribute-set: linkinfo-hsr-attrs
       -
         value: ipip
         attribute-set: linkinfo-iptun-attrs
-- 
2.51.0



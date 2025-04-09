Return-Path: <netdev+bounces-180822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D966A82957
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C6B4A3C47
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB6C2673AC;
	Wed,  9 Apr 2025 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8020PWY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699EF267397
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210546; cv=none; b=N4ymJVAWihWl8Xd++bsbMvPfM9IT3wvUVN/dAngxC2GjYnGaCAyN8nPeA5naC8i0DZPj+wHiEtUSX4K+X/XiDuwHK05UqNDweoxnxEk8u+KQ/6s3klGPkrZgTvWJ6hV+FazmUyzOzqxxyHk1fzqROU2inBOaFn2dVS2d4wFZLnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210546; c=relaxed/simple;
	bh=DXGPrpF6JTlz7kP4ORLj5laMzdmNal10lel3OCvy6kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUHL669CUI0b1YJAC1gs5YYM7lHCpbY6oDg+zjpQl0AdPZOP9aGg3mQAUGELDyfHeBQYThdg0v+aKU2P7whGFkdjgpmsEizlaAFWgEG4x14qcVVWj9KDrOI8/nIGBuXPzCrum5HW7MKsR0GU8QkGQKV/QsP3tUdR4F0PzbdiLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8020PWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F16C4CEE2;
	Wed,  9 Apr 2025 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744210544;
	bh=DXGPrpF6JTlz7kP4ORLj5laMzdmNal10lel3OCvy6kM=;
	h=From:To:Cc:Subject:Date:From;
	b=K8020PWYCaCN2Rm2Xs6F2AoX3oq+KnfDpCyLnKOYoSoWbmNsp5GShhwmHxiB6zKRV
	 z8afLr/Up1i3qq/WdEvF2w/MLm+4OlMmNYq1m10G3QuQPAr8+7GPtkAlXJy4B6fHhA
	 eztl04ZVu4NpPDwzimFUZuNG1cgFViV3Wxt5sXW9b99MFxcbXz5JVrFY9FbLy1hgBl
	 vBQzvHd9ERqF6Ot0RVSikOtmtEwK+WZetJvwjgXTR95TRPPzGK6+pG/Zc1hjTYeo1I
	 lbsiZhu42wTbtlIIlDDJSPBi6W6JXDimqfUJ6oZEeczkOAwVOwrKtyUjZPUMlnYFkY
	 8/aOkOU2kyC3w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	jiri@resnulli.us
Subject: [PATCH net] netlink: specs: ovs_vport: align with C codegen capabilities
Date: Wed,  9 Apr 2025 07:55:41 -0700
Message-ID: <20250409145541.580674-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We started generating C code for OvS a while back, but actually
C codegen only supports fixed headers specified at the family
level right now (schema also allows specifying them per op).
ovs_flow and ovs_datapath already specify the fixed header
at the family level but ovs_vport does it per op.
Move the property, all ops use the same header.

This ensures YNL C sees the correct hdr_len:

   const struct ynl_family ynl_ovs_vport_family =  {
          .name           = "ovs_vport",
  -       .hdr_len        = sizeof(struct genlmsghdr),
  +       .hdr_len        = sizeof(struct genlmsghdr) + sizeof(struct ovs_header),
   };

Fixes: 7c59c9c8f202 ("tools: ynl: generate code for ovs families")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: jiri@resnulli.us
---
 Documentation/netlink/specs/ovs_vport.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/ovs_vport.yaml b/Documentation/netlink/specs/ovs_vport.yaml
index 86ba9ac2a521..b538bb99ee9b 100644
--- a/Documentation/netlink/specs/ovs_vport.yaml
+++ b/Documentation/netlink/specs/ovs_vport.yaml
@@ -123,12 +123,12 @@ uapi-header: linux/openvswitch.h
 
 operations:
   name-prefix: ovs-vport-cmd-
+  fixed-header: ovs-header
   list:
     -
       name: new
       doc: Create a new OVS vport
       attribute-set: vport
-      fixed-header: ovs-header
       do:
         request:
           attributes:
@@ -141,7 +141,6 @@ uapi-header: linux/openvswitch.h
       name: del
       doc: Delete existing OVS vport from a data path
       attribute-set: vport
-      fixed-header: ovs-header
       do:
         request:
           attributes:
@@ -152,7 +151,6 @@ uapi-header: linux/openvswitch.h
       name: get
       doc: Get / dump OVS vport configuration and state
       attribute-set: vport
-      fixed-header: ovs-header
       do: &vport-get-op
         request:
           attributes:
-- 
2.49.0



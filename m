Return-Path: <netdev+bounces-221194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8964AB4FA08
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F45189C7D0
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F6F334399;
	Tue,  9 Sep 2025 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBnaipz2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611ED309EE5;
	Tue,  9 Sep 2025 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420023; cv=none; b=jDwjr9R+IirIU51fTO+KiRd8JXBue/R4d9pi4QGSAuyVSI9NawbOYmNphvXU0Np0V2kWGC4D5H8vXaCs8v0KoMvlxHscedWfnsGoZ9LDSPRq7wC/E19e+fdhBN6ITC8wvlYmKJfs6+K3I99JuI7FeZVmcCgevaegcuBFg172Akc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420023; c=relaxed/simple;
	bh=R8IBEgyyfdC4LwzwmPwd7zIkX1SnWTZM2uMbSQnjzwM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=akP9lZStcLYzznumOfDYOockoa2e9+V0/b57/eOij4zmIuSsNMs0UYAWjdNOBobnF/h0sQLo6tyag8P7MQDEYrQ34AOjlRW5RdwU/uPN/I1CBuj2cGd8CgcSRcuQcaNv4z1EMUVRg/EsCVRif0dhr1aS+7MfILXF+NP0Js6arKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBnaipz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35132C4CEF4;
	Tue,  9 Sep 2025 12:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757420022;
	bh=R8IBEgyyfdC4LwzwmPwd7zIkX1SnWTZM2uMbSQnjzwM=;
	h=Date:From:To:Cc:Subject:From;
	b=cBnaipz2LRSWHlYEn0e52S3XLyiB6lXu6/LeAGDw65qGwxiXR8F+oOBTLmlQ2A4jF
	 8XTTP+HDqJ8D7514Jb1PS6OJdLWxz3CtxtbhbU50QmRBMQz/lOiGaw8XfRcQ+mRcVz
	 3gBIHu95PULkdI49gRhxVX64xonatNwmF5vmZyfml1gHE14h/6qVf6Lv3PRD4m65ca
	 C/54C4NCmHW3clOLH8CrhRJ4xbufciXFxWz5wgi8ETt7/Tc/VhvhH88hnk6V6ItS3M
	 38poAUb+EysM1CDvCtNW6Jsxh1RuGuhHHV/GPnpvnFnjfjK+htAOy7hgZJjodfOz7e
	 uDtMT7gBwwbCA==
Date: Tue, 9 Sep 2025 14:13:35 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] Bluetooth: Avoid a couple dozen
 -Wflex-array-member-not-at-end warnings
Message-ID: <aMAZ7wIeT1sDZ4_V@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the __struct_group() helper to fix 31 instances of the following
type of warnings:

30 net/bluetooth/mgmt_config.c:16:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
1 net/bluetooth/mgmt_config.c:22:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use __struct_group() instead of TRAILING_OVERLAP().

v1:
 - Link: https://lore.kernel.org/linux-hardening/aLSCu8U62Hve7Dau@kspp/

 include/net/bluetooth/mgmt.h | 9 +++++++--
 net/bluetooth/mgmt_config.c  | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 3575cd16049a..74edea06985b 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -53,10 +53,15 @@ struct mgmt_hdr {
 } __packed;
 
 struct mgmt_tlv {
-	__le16 type;
-	__u8   length;
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(mgmt_tlv_hdr, __hdr, __packed,
+		__le16 type;
+		__u8   length;
+	);
 	__u8   value[];
 } __packed;
+static_assert(offsetof(struct mgmt_tlv, value) == sizeof(struct mgmt_tlv_hdr),
+	      "struct member likely outside of __struct_group()");
 
 struct mgmt_addr_info {
 	bdaddr_t	bdaddr;
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index 6ef701c27da4..c4063d200c0a 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -13,13 +13,13 @@
 
 #define HDEV_PARAM_U16(_param_name_) \
 	struct {\
-		struct mgmt_tlv entry; \
+		struct mgmt_tlv_hdr entry; \
 		__le16 value; \
 	} __packed _param_name_
 
 #define HDEV_PARAM_U8(_param_name_) \
 	struct {\
-		struct mgmt_tlv entry; \
+		struct mgmt_tlv_hdr entry; \
 		__u8 value; \
 	} __packed _param_name_
 
-- 
2.43.0



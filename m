Return-Path: <netdev+bounces-202945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4D0AEFCEE
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327D9480246
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4549C1D63CD;
	Tue,  1 Jul 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJrqfuge"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3BA1C4A10;
	Tue,  1 Jul 2025 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381223; cv=none; b=iN3+8v7Oid/5uGPHbd/UDtNynSrqINfXsBBaqMhq9n6dz4umlId1pT6k0F+rm75cqZKi4W+CIgiZYBQX+h7N2A5aQbkP0zxU+3whl/3jSyjYorZO6gJ4XReqKohPluVqsr+VS0l+Q4RBdelMjlq2xgnVFPbyXWyS7XOwdr9MREc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381223; c=relaxed/simple;
	bh=ZvxGUUcqigy9ehv20F3kwJxyQUkKYhJ+kjjoT7nt2H0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5hUB0SX4f9BkG2Qddm3RTqYpjxuJEXms4566b8SxdABJ9S7IaKNkZ763PnkHW+Y2ygMkZlPNVD2/sy5OKhT6rAKQfGJIk84Xi77ePJkPsfZNQJEloTbT8qQFmdmJfE7T6ITLR9R2tz95ppPLSV51xkb072vYOpgUadRm7i6t8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJrqfuge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31823C4CEEF;
	Tue,  1 Jul 2025 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751381222;
	bh=ZvxGUUcqigy9ehv20F3kwJxyQUkKYhJ+kjjoT7nt2H0=;
	h=From:To:Cc:Subject:Date:From;
	b=BJrqfuged5xL7HvrSakF5nYuQJFRqYRMLgWrwVkHeJQIzWlrPfg5CKXhbtOgdcquJ
	 iZwJaJbis48UlCKxXLvdXwk+Cn3HV2E3POY+4yrkUQT2qP2Sn2OddnLX2g3c9JQgIN
	 SsPNhSTY7F5bWqUMRy0sJyeaz0nAYuE217/RRf82E7MIMjsC4KOqYfLNSX6e2o6Nii
	 FEwF1IVIS7yz+lYGEDIvDBPANtDjcsyO22zEDYq/9M0MwAIlGoU8WQ+cXebOjESRSl
	 qXRMrdNkEPJxos6aV8pFevWEEDgSsg7TiPY1yMKAxkgEnX+F1AP5XwOPN7914mmpt3
	 5Ek5fTUxoDWTQ==
From: Hannes Reinecke <hare@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: kernel-tls-handshake@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] net/handshake: Add new parameter 'HANDSHAKE_A_ACCEPT_KEYRING'
Date: Tue,  1 Jul 2025 16:46:57 +0200
Message-ID: <20250701144657.104401-1-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new netlink parameter 'HANDSHAKE_A_ACCEPT_KEYRING' to provide
the serial number of the keyring to use.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 Documentation/netlink/specs/handshake.yaml | 4 ++++
 include/uapi/linux/handshake.h             | 1 +
 net/handshake/tlshd.c                      | 6 ++++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index b934cc513e3d..a8be0b54755b 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -71,6 +71,9 @@ attribute-sets:
       -
         name: peername
         type: string
+      -
+        name: keyring
+        type: u32
   -
     name: done
     attributes:
@@ -109,6 +112,7 @@ operations:
             - peer-identity
             - certificate
             - peername
+            - keyring
     -
       name: done
       doc: Handler reports handshake completion
diff --git a/include/uapi/linux/handshake.h b/include/uapi/linux/handshake.h
index 3d7ea58778c9..662e7de46c54 100644
--- a/include/uapi/linux/handshake.h
+++ b/include/uapi/linux/handshake.h
@@ -45,6 +45,7 @@ enum {
 	HANDSHAKE_A_ACCEPT_PEER_IDENTITY,
 	HANDSHAKE_A_ACCEPT_CERTIFICATE,
 	HANDSHAKE_A_ACCEPT_PEERNAME,
+	HANDSHAKE_A_ACCEPT_KEYRING,
 
 	__HANDSHAKE_A_ACCEPT_MAX,
 	HANDSHAKE_A_ACCEPT_MAX = (__HANDSHAKE_A_ACCEPT_MAX - 1)
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index d6f52839827e..081093dfd553 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -230,6 +230,12 @@ static int tls_handshake_accept(struct handshake_req *req,
 		if (ret < 0)
 			goto out_cancel;
 	}
+	if (treq->th_keyring) {
+		ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_KEYRING,
+				  treq->th_keyring);
+		if (ret < 0)
+			goto out_cancel;
+	}
 
 	ret = nla_put_u32(msg, HANDSHAKE_A_ACCEPT_AUTH_MODE,
 			  treq->th_auth_mode);
-- 
2.43.0



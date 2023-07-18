Return-Path: <netdev+bounces-18701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B514F75853C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5A61C20E3E
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC4415ADD;
	Tue, 18 Jul 2023 18:59:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D33156E1;
	Tue, 18 Jul 2023 18:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6C3C433C8;
	Tue, 18 Jul 2023 18:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689706796;
	bh=z+g/oVpRmEOi63hgglQdij3DuOAoXiKlzw8WfvHlrOk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=I+xbnFontjF54GjG7JXpXn2VaNyjyRsm+3qkU6GwgUewxSs1zOqSXdhXx7EsZsieD
	 TV56G8La5UKM/Yvm/MZOB0Lxe5T9UHZp3gKCmOQZkSlTJZTIi1sMSC+g1Y6EMNnpwZ
	 wW20sMuwxdVTC62Z/iumzz8HLAFx1V7koV/5edgezJQGITHaYtvsUlIcy5YDNwHLFB
	 2oN8Nxc4S62Ye0f57wl7ZnXRKGBeJ2O1WzfoKYImkgqwLu5BkEbBapFo3Z+EKFZR0T
	 KnUyPeGCpywQ5V4vRtgeTYgS9Y1DvYspf/KekRIPkOwt2x4jY9yHgRuWxIZfNghal5
	 Ydun9QBr+3aeg==
Subject: [PATCH net-next v1 2/7] net/tls: Add TLS Alert definitions
From: Chuck Lever <cel@kernel.org>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date: Tue, 18 Jul 2023 14:59:44 -0400
Message-ID: 
 <168970677480.5330.16194452237553219882.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: 
 <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
References: 
 <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

I'm about to add support for kernel handshake API consumers to send
TLS Alerts, so introduce the needed protocol definitions in the new
header tls_prot.h.

This presages support for Closure alerts. Also, support for alerts
is a pre-requite for handling session re-keying, where one peer will
signal the need for a re-key by sending a TLS Alert.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/net/tls_prot.h |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/net/tls_prot.h b/include/net/tls_prot.h
index 47d6cfd1619e..68a40756440b 100644
--- a/include/net/tls_prot.h
+++ b/include/net/tls_prot.h
@@ -23,4 +23,46 @@ enum {
 	TLS_RECORD_TYPE_ACK = 26,
 };
 
+/*
+ * TLS Alert protocol: AlertLevel
+ */
+enum {
+	TLS_ALERT_LEVEL_WARNING = 1,
+	TLS_ALERT_LEVEL_FATAL = 2,
+};
+
+/*
+ * TLS Alert protocol: AlertDescription
+ */
+enum {
+	TLS_ALERT_DESC_CLOSE_NOTIFY = 0,
+	TLS_ALERT_DESC_UNEXPECTED_MESSAGE = 10,
+	TLS_ALERT_DESC_BAD_RECORD_MAC = 20,
+	TLS_ALERT_DESC_RECORD_OVERFLOW = 22,
+	TLS_ALERT_DESC_HANDSHAKE_FAILURE = 40,
+	TLS_ALERT_DESC_BAD_CERTIFICATE = 42,
+	TLS_ALERT_DESC_UNSUPPORTED_CERTIFICATE = 43,
+	TLS_ALERT_DESC_CERTIFICATE_REVOKED = 44,
+	TLS_ALERT_DESC_CERTIFICATE_EXPIRED = 45,
+	TLS_ALERT_DESC_CERTIFICATE_UNKNOWN = 46,
+	TLS_ALERT_DESC_ILLEGAL_PARAMETER = 47,
+	TLS_ALERT_DESC_UNKNOWN_CA = 48,
+	TLS_ALERT_DESC_ACCESS_DENIED = 49,
+	TLS_ALERT_DESC_DECODE_ERROR = 50,
+	TLS_ALERT_DESC_DECRYPT_ERROR = 51,
+	TLS_ALERT_DESC_TOO_MANY_CIDS_REQUESTED	= 52,
+	TLS_ALERT_DESC_PROTOCOL_VERSION = 70,
+	TLS_ALERT_DESC_INSUFFICIENT_SECURITY = 71,
+	TLS_ALERT_DESC_INTERNAL_ERROR = 80,
+	TLS_ALERT_DESC_INAPPROPRIATE_FALLBACK = 86,
+	TLS_ALERT_DESC_USER_CANCELED = 90,
+	TLS_ALERT_DESC_MISSING_EXTENSION = 109,
+	TLS_ALERT_DESC_UNSUPPORTED_EXTENSION = 110,
+	TLS_ALERT_DESC_UNRECOGNIZED_NAME = 112,
+	TLS_ALERT_DESC_BAD_CERTIFICATE_STATUS_RESPONSE = 113,
+	TLS_ALERT_DESC_UNKNOWN_PSK_IDENTITY = 115,
+	TLS_ALERT_DESC_CERTIFICATE_REQUIRED = 116,
+	TLS_ALERT_DESC_NO_APPLICATION_PROTOCOL = 120,
+};
+
 #endif /* _TLS_PROT_H */




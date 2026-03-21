Return-Path: <netdev+bounces-270167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKhOEwEevmmsGwMAu9opvQ
	(envelope-from <netdev+bounces-270167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 05:26:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F54E2E33F9
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 05:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5C98301E49F
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653832D2481;
	Sat, 21 Mar 2026 04:26:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99117A2EA;
	Sat, 21 Mar 2026 04:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774067193; cv=none; b=G3nW6C+3v6nxMgIWKZIwG+h7oB+ZWX4buryB3vTisY2PdvwEt2v7T0m1Big9EJ/237fKeXpQRN4kQhCBnKgxHfEGg5af/29a3sksJw69RxFr5V0u0fEEVXRzOaPfPNVKyr+npDMHGRyPciAx6rNxmI53/3RIsy4ro74uDpqsHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774067193; c=relaxed/simple;
	bh=+EaH7bM1rUEv3ESc2TQyVCS/eG5JcGcKIpE5GWWja9Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kB52WCWbGAT7NCOnaUJK2qBkUm3oqF5SSV0TN96mVy04Oz5zIkRrc8ORNIXEBVms/9jc77HigX4O1Yr+Dse+0gjVDX/WJN70j8qlx15oop2UQJNODXbU5mzrKpVzvHm+5+wUPfxWpn19ax0YzBEsUHYtYo5LfR7dER5HDJ9lD90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w3nuh-000000006pW-181d;
	Sat, 21 Mar 2026 04:26:15 +0000
Date: Sat, 21 Mar 2026 04:26:11 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] selftests: forwarding: local_termination: fix PTP UDP
 cksums
Message-ID: <651c3decb80023e4395ec149fd81110afa3869a1.1774067006.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270167-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nxp.com,makrotopia.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,makrotopia.org:email,makrotopia.org:mid]
X-Rspamd-Queue-Id: 5F54E2E33F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All six PTP-over-IP test frames (3x IPv4 + 3x IPv6) contain incorrect
UDP checksums. The stored values are the ones-complement sums of just
the pseudo-headers, not the complete UDP checksums over pseudo-header +
UDP header + payload. This is characteristic of frames captured on the
sender before TX checksum offload completion.

For example, the IPv4 Sync and Follow-Up frames both store checksum
0xa3c8 despite having different UDP payloads and port numbers - 0xa3c8
is their shared pseudo-header sum (same src/dst IP, same protocol and
UDP length).

While most L2 switches forward frames without verifying transport
checksums, hardware that performs deep packet inspection or has PTP
awareness may validate UDP checksums and drop frames that fail
verification. This causes the 1588v2 over IPv4/IPv6 tests to fail on
such hardware even though L2 PTP (which has no UDP checksum) passes
fine.

Replace all six pseudo-header partial sums with the correctly computed
full UDP checksums:

  IPv4 Sync:           0xa3c8 -> 0x9f41
  IPv4 Follow-Up:      0xa3c8 -> 0xeb8a
  IPv4 Peer Delay Req: 0xa2bc -> 0x9ab9
  IPv6 Sync:           0x2e92 -> 0x1476
  IPv6 Follow-Up:      0x2e92 -> 0xf047
  IPv6 Peer Delay Req: 0xb454 -> 0x891f

Fixes: 2379795042649 ("selftests: net: local_termination: add PTP frames to the mix")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../selftests/net/forwarding/local_termination.sh    | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index 9bc9d25e71368..15b1a1255a41f 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -57,21 +57,21 @@ PTP_1588_L2_PDELAY_REQ=" \
 PTP_1588_IPV4_SYNC=" \
 01:00:5e:00:01:81 00:00:de:ad:be:ef 08:00 45 00 \
 00 48 0a 9a 40 00 01 11 cb 88 c0 00 02 01 e0 00 \
-01 81 01 3f 01 3f 00 34 a3 c8 00 02 00 2c 00 00 \
+01 81 01 3f 01 3f 00 34 9f 41 00 02 00 2c 00 00 \
 02 00 00 00 00 00 00 00 00 00 00 00 00 00 3e 37 \
 63 ff fe cf 17 0e 00 01 00 00 00 00 00 00 00 00 \
 00 00 00 00 00 00"
 PTP_1588_IPV4_FOLLOW_UP="
 01:00:5e:00:01:81 00:00:de:ad:be:ef 08:00 45 00 \
 00 48 0a 9b 40 00 01 11 cb 87 c0 00 02 01 e0 00 \
-01 81 01 40 01 40 00 34 a3 c8 08 02 00 2c 00 00 \
+01 81 01 40 01 40 00 34 eb 8a 08 02 00 2c 00 00 \
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 3e 37 \
 63 ff fe cf 17 0e 00 01 00 00 02 00 00 00 66 83 \
 c6 0f 1d 9a 61 87"
 PTP_1588_IPV4_PDELAY_REQ=" \
 01:00:5e:00:00:6b 00:00:de:ad:be:ef 08:00 45 00 \
 00 52 35 a9 40 00 01 11 a1 85 c0 00 02 01 e0 00 \
-00 6b 01 3f 01 3f 00 3e a2 bc 02 02 00 36 00 00 \
+00 6b 01 3f 01 3f 00 3e 9a b9 02 02 00 36 00 00 \
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 3e 37 \
 63 ff fe cf 17 0e 00 01 00 01 05 7f 00 00 00 00 \
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00"
@@ -79,7 +79,7 @@ PTP_1588_IPV6_SYNC=" \
 33:33:00:00:01:81 00:00:de:ad:be:ef 86:dd 60 06 \
 7c 2f 00 36 11 01 20 01 0d b8 00 01 00 00 00 00 \
 00 00 00 00 00 01 ff 0e 00 00 00 00 00 00 00 00 \
-00 00 00 00 01 81 01 3f 01 3f 00 36 2e 92 00 02 \
+00 00 00 00 01 81 01 3f 01 3f 00 36 14 76 00 02 \
 00 2c 00 00 02 00 00 00 00 00 00 00 00 00 00 00 \
 00 00 3e 37 63 ff fe cf 17 0e 00 01 00 00 00 00 \
 00 00 00 00 00 00 00 00 00 00 00 00"
@@ -87,7 +87,7 @@ PTP_1588_IPV6_FOLLOW_UP=" \
 33:33:00:00:01:81 00:00:de:ad:be:ef 86:dd 60 0a \
 00 bc 00 36 11 01 20 01 0d b8 00 01 00 00 00 00 \
 00 00 00 00 00 01 ff 0e 00 00 00 00 00 00 00 00 \
-00 00 00 00 01 81 01 40 01 40 00 36 2e 92 08 02 \
+00 00 00 00 01 81 01 40 01 40 00 36 f0 47 08 02 \
 00 2c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \
 00 00 3e 37 63 ff fe cf 17 0e 00 01 00 00 02 00 \
 00 00 66 83 c6 2a 32 09 bd 74 00 00"
@@ -95,7 +95,7 @@ PTP_1588_IPV6_PDELAY_REQ=" \
 33:33:00:00:00:6b 00:00:de:ad:be:ef 86:dd 60 0c \
 5c fd 00 40 11 01 fe 80 00 00 00 00 00 00 3c 37 \
 63 ff fe cf 17 0e ff 02 00 00 00 00 00 00 00 00 \
-00 00 00 00 00 6b 01 3f 01 3f 00 40 b4 54 02 02 \
+00 00 00 00 00 6b 01 3f 01 3f 00 40 89 1f 02 02 \
 00 36 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \
 00 00 3e 37 63 ff fe cf 17 0e 00 01 00 01 05 7f \
 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \
-- 
2.53.0


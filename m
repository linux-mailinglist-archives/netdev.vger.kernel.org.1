Return-Path: <netdev+bounces-240488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1237C75772
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99A6E345F28
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7991A33373D;
	Thu, 20 Nov 2025 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="FBmy8cOr"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A935CBD8
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656962; cv=none; b=n3SN4/9A10a6a4pUpxZg9+GMCKxNF0ALoLf8PGjdHc5RKrC3zIXvAAGDoLuGdpyLFfdaCr7tOm6TwGtqhVBNPzdKnuAd10nfaisF3ZP3ltPoFZ/ZHMtIFMcqdbZ9l3pZK5Qkr70rGMX6wBCbnPSiWmltWJfgHWamWFIPHuSA3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656962; c=relaxed/simple;
	bh=ty589xR/4d58wuY6w8oqTR1xxujxnRrwtrLXvlTEFOM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wpbm9gDYibdaBdeLdZuHSwf6u+dk9GlDSb/kW8P70Fl3vKzd3pAG64BAiw2Kefu74oPezQpk/M1btGzAe1kGjvrtBUv/YHyMsuNbgNT0yJE47/5Jp1xxRVSrz5c7Kv31hFWFt36yPq3PsjfOx7W16OV6e/lWRGXx5CKF+Hby2rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=FBmy8cOr; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id B09F5200A279;
	Thu, 20 Nov 2025 17:34:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be B09F5200A279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1763656472;
	bh=ucoSyfu8CKNmYEdLZwsIjDEEmc5fqP8W1ZRXZD5aW24=;
	h=From:To:Cc:Subject:Date:From;
	b=FBmy8cOrzq7X32aV3Xk2GZ6OOQtfFmoot3/hIs/tO87HSFS/FpJX51uZL6hYyjAol
	 dnYEi4KXFx2vjfjmfhgJ5Lh5B9dp/xkyy/a71jHAKm/eKrbWBE+OS+VGJRlV8kEiuO
	 aRymhOC6N2Omdz8si4Oua69mEelOQf1RDlLIKJvsmYNg8AHrl90SyqmwvPDZQcIX8A
	 zqXVh179tCA2if58yjwTzcdDV3iMqOBHjTPu0SuNakfbz15h8JFAj6GIpPIKxfvabT
	 Ka18lMM9PKLs2zcGDlvE2tY1chBw+uHP4pxvp2wfo16DFlOoZFMYMyKL/ans0SuY5o
	 E8WGcg4RiMCuQ==
From: Justin Iurman <justin.iurman@uliege.be>
To: davem@davemloft.net,
	justin.iurman@uliege.be
Cc: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] uapi: ioam6: adjust the maximum size of a schema
Date: Thu, 20 Nov 2025 17:33:42 +0100
Message-Id: <20251120163342.30312-1-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With IPv6, the maximum size of the IOAM Pre-allocated Trace is 244 bytes
(see IOAM6_TRACE_DATA_SIZE_MAX), due to IPv6 Options length constraint.
However, RFC9197 defines the Opaque State Snapshot (i.e., a data field
that may be added by IOAM nodes in the pre-allocated trace) as follows:

    0                   1                   2                   3
    0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |   Length      |                     Schema ID                 |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                                                               |
   ~                        Opaque data                            ~
   |                                                               |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

   Length:
      1-octet unsigned integer.  It is the length in multiples of 4
      octets of the Opaque data field that follows Schema ID.

   Schema ID:
      3-octet unsigned integer identifying the schema of Opaque data.

   Opaque data:
      Variable-length field.  This field is interpreted as specified by
      the schema identified by the Schema ID.

Based on that, IOAM6_MAX_SCHEMA_DATA_LEN was initially set to 1020 bytes
(i.e., 255 * 4), which is already bigger than what is allowed in a
pre-allocated trace. As a result, if the Opaque State Snapshot (i.e.,
schema) configured on an IOAM node exceeds 244 bytes, it would just
skip the insertion of its data. This patch sets a more realistic
boundary to avoid any confusion. Now, IOAM6_MAX_SCHEMA_DATA_LEN is set
to 240 bytes (i.e., IOAM6_TRACE_DATA_SIZE_MAX - 4, to account for its
4-byte header).

Fixes: 8c6f6fa67726 ("ipv6: ioam: IOAM Generic Netlink API")
Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 include/uapi/linux/ioam6_genl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ioam6_genl.h b/include/uapi/linux/ioam6_genl.h
index 1733fbc51fb5..ce3d8bdabd3b 100644
--- a/include/uapi/linux/ioam6_genl.h
+++ b/include/uapi/linux/ioam6_genl.h
@@ -19,7 +19,7 @@ enum {
 	IOAM6_ATTR_NS_DATA,	/* u32 */
 	IOAM6_ATTR_NS_DATA_WIDE,/* u64 */
 
-#define IOAM6_MAX_SCHEMA_DATA_LEN (255 * 4)
+#define IOAM6_MAX_SCHEMA_DATA_LEN 240
 	IOAM6_ATTR_SC_ID,	/* u32 */
 	IOAM6_ATTR_SC_DATA,	/* Binary */
 	IOAM6_ATTR_SC_NONE,	/* Flag */
-- 
2.34.1



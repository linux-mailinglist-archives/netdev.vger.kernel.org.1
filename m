Return-Path: <netdev+bounces-300588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gt+YGwS6NGqyfgYAu9opvQ
	(envelope-from <netdev+bounces-300588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 05:39:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D32FD6A3AED
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 05:39:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300588-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300588-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E11F730584A4
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C5C2EBBA4;
	Fri, 19 Jun 2026 03:39:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E024B28;
	Fri, 19 Jun 2026 03:39:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781840384; cv=none; b=j3p9iT7vsLjbdwAVfFDlgad3WtdiWdWHhwdcqPVzqXRRFRbDtIaEGuYYw3elpKOux1NG0YznzErMMlscfqrGTFAaT/gv/UPVLAr5cs09B1NV/VvMg9gZ1Jsy6UPYiD4IlFHWl+2XXFx8yqvB4uui0ijyB+nKB5zvHMW9F6o0GRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781840384; c=relaxed/simple;
	bh=ucRNkhNSQ0NMD14dGjuPrzzz8jKjTaDeB3MQzKDfDV8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VWNY6WqMDCteKNSikdHquIbhCQbP5QkvMksBtrLbBxOF/GWk4Gum16Me8APJ6Z0c7NmyY0xS9PbPGNLjKmdU6pR7K8xqJOdKdxFurlUht9EIVA0PFbbPs5jPC2VaQ3qJTCtJR/nVBAhNAzo0soIGNQD1nm3J9J1imKQnz7WQoxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1waQ4m-0000000012z-2ff9;
	Fri, 19 Jun 2026 03:39:28 +0000
Date: Fri, 19 Jun 2026 04:39:25 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: dsa: mxl862xx: avoid unaligned 16-bit access in
 api_wrap
Message-ID: <599327521db465a534d277de53ab9b6cac01928b.1781702256.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[makrotopia.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-300588-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@makrotopia.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D32FD6A3AED

The MXL862XX_API_* macros pass the address of a stack-allocated, __packed
firmware-ABI struct to mxl862xx_api_wrap() as a void *. The struct has an
alignment of 1, so the compiler is free to place it at an odd address.

mxl862xx_api_wrap() reinterprets that buffer as a __le16 * and accesses it
with data[i], for which the compiler assumes the natural 2-byte alignment
of __le16 and emits aligned 16-bit loads/stores (e.g. lhu/sh on MIPS).
When the buffer lands on an odd address these fault on architectures that
do not support unaligned access, such as MIPS32.

-Waddress-of-packed-member does not catch this: the packed origin is
laundered through the void * parameter, so the cast inside api_wrap looks
alignment-safe to the compiler and no warning is emitted.

Use get_unaligned_le16()/put_unaligned_le16() for the three 16-bit word
accesses. The byte accesses (*(u8 *)&data[i], crc16()) are already safe
and are left unchanged.

Link: https://sashiko.dev/#/patchset/cover.1781319534.git.daniel%40makrotopia.org?part=4
Fixes: 23794bec1cb6 ("net: dsa: add basic initial driver for MxL862xx switches")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mxl862xx/mxl862xx-host.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index d55f9dff6433..882c5d960941 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -12,6 +12,7 @@
 #include <linux/crc16.h>
 #include <linux/iopoll.h>
 #include <linux/limits.h>
+#include <linux/unaligned.h>
 #include <net/dsa.h>
 #include "mxl862xx.h"
 #include "mxl862xx-host.h"
@@ -349,7 +350,7 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 	 * zero words individually.
 	 */
 	for (i = 0, zeros = 0; i < size / 2 && zeros < RST_DATA_THRESHOLD; i++)
-		if (!data[i])
+		if (!get_unaligned_le16(&data[i]))
 			zeros++;
 
 	if (zeros < RST_DATA_THRESHOLD && (size & 1) && !*(u8 *)&data[i])
@@ -395,7 +396,7 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 			 */
 			val = *(u8 *)&data[i] | ((crc & 0xff) << 8);
 		} else {
-			val = le16_to_cpu(data[i]);
+			val = get_unaligned_le16(&data[i]);
 		}
 
 		/* After RST_DATA, skip zero data words as the registers
@@ -453,7 +454,7 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 			*(uint8_t *)&data[i] = ret & 0xff;
 			crc = (ret >> 8) & 0xff;
 		} else {
-			data[i] = cpu_to_le16((u16)ret);
+			put_unaligned_le16((u16)ret, &data[i]);
 		}
 	}
 
-- 
2.54.0


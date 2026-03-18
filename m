Return-Path: <netdev+bounces-268858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CvgHxUXumnyRQIAu9opvQ
	(envelope-from <netdev+bounces-268858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:08:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C022B567C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EEF2306D8C3
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB0274FEB;
	Wed, 18 Mar 2026 03:08:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2D256C6C;
	Wed, 18 Mar 2026 03:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773803282; cv=none; b=lSQEtlbja68iiDUf6VlPu/vRgjIL9LBuKbho0Ixb9XTBHyvmI9nlGfSJHJa0oGQmqTMx6JvTOaYtaWKgstYTVxpNk+idNzSKj/0yTPg/URZ9+cFWYj9gxfsUdlPtxxePj1VA/+b/xvyvQM3eVw3bUfwZ3K1ryvUKBua8wevc+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773803282; c=relaxed/simple;
	bh=pzcrMZE7hNfVVvaxkldQYtyCSFl9v3tUWGWga5ZDz6A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EQ4juJ3H3bkyFvxe1W+7UnTjrhyMfelxDI95NcASMq5/VBWqXyT7oEDhP1L2WXnQKRfYv2w7bmbgHr7v8UzvgxGNlwWMXKE/UMeMZreaC5NpcRVbgDs7nHObYzkVwluv88fXuoZzH0eAhzM+TdazJ1cpyPZKv6FeKwIi4hWqG/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w2hGF-000000004GF-0jL3;
	Wed, 18 Mar 2026 03:07:55 +0000
Date: Wed, 18 Mar 2026 03:07:52 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: mxl862xx: don't read out-of-bounds
Message-ID: <83356ad9c9a4470dd49b6b3d661c2a8dd85cc6a1.1773803190.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268858-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:email,makrotopia.org:mid]
X-Rspamd-Queue-Id: 01C022B567C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The write loop in mxl862xx_api_wrap() computes the word count as
(size + 1) / 2, rounding up for odd-sized structs.

On the last iteration of an odd-sized buffer it reads a full __le16
from data[i], accessing one byte past the end of the caller's struct.
KASAN catches this as a stack-out-of-bounds read during probe (e.g.
from mxl862xx_bridge_config_fwd() because of the odd length of
sizeof(struct mxl862xx_bridge_config) == 49).

The read-back loop already handles this case, it writes only a single
byte when (i * 2 + 1) == size. The write loop lacked the same guard.

In practice the over-read is harmless: the extra stack byte is sent to
the firmware which ignores trailing data beyond the command's declared
payload size.

Apply the same odd-size last-byte handling to the write path: when the
final word contains only one valid byte, send *(u8 *)&data[i] instead
of le16_to_cpu(data[i]). This is endian-safe because data is
__le16-encoded and the low byte is always at the lowest address
regardless of host byte order.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mxl862xx/mxl862xx-host.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
index 8c55497a0ce89..4eefd2a759a7d 100644
--- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
+++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
@@ -175,8 +175,14 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
 				goto out;
 		}
 
-		ret = mxl862xx_reg_write(priv, MXL862XX_MMD_REG_DATA_FIRST + off,
-					 le16_to_cpu(data[i]));
+		if ((i * 2 + 1) == size)
+			ret = mxl862xx_reg_write(priv,
+						 MXL862XX_MMD_REG_DATA_FIRST + off,
+						 *(u8 *)&data[i]);
+		else
+			ret = mxl862xx_reg_write(priv,
+						 MXL862XX_MMD_REG_DATA_FIRST + off,
+						 le16_to_cpu(data[i]));
 		if (ret < 0)
 			goto out;
 	}
-- 
2.53.0


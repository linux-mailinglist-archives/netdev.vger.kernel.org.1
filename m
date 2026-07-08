Return-Path: <netdev+bounces-305963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BjgFKsiaTmreQQIAu9opvQ
	(envelope-from <netdev+bounces-305963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:45:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8DF729AA2
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:45:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=kmYCBPkQ;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=0eqZ9XdV;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305963-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305963-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C18B311E2A5
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956CB4D90CC;
	Wed,  8 Jul 2026 18:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0BA4D2EE7;
	Wed,  8 Jul 2026 18:40:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783536022; cv=none; b=g7ATOiRbMMEiXI3njMhJdezbLJ+baiqcWgUIdA4BBIfzvPBuUuF6XY8FMLhe4wCitDq8B65sp4FpEc0oHujc9d83aNJqbeD8t32PWc2btvV+bsFpK7BCtfslVUiVBaVdy6A/2IscNUfa0y9ppBnalmMkAX6zWL8+Bxd9VNKNsok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783536022; c=relaxed/simple;
	bh=ZPfelGZxTAG8TUBlIXu+xWodEdDwjBGUunYDmLnNuHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ADszEocF1d8NCEvi2IMPmVzcuOyhd7UMM3k+pLnKxkxxNXA1beITHhgp7AoTkFqUTRPJQIcfE4Q5kUCNXIipXUjbNMX02FQ3QU+SGEcRPCos8Iwn9yKutCQJMPJUTngekjZmLA15WYzLx+Qz6RsDesTNU8LdE+M6lD4WmEmQDhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=kmYCBPkQ; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=0eqZ9XdV; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536014;
	bh=ZPfelGZxTAG8TUBlIXu+xWodEdDwjBGUunYDmLnNuHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kmYCBPkQQdVLbgbne9LGH5D3oiyZPLaELU+1Lxud2B/YBZ4daQpWqVrvo/2jb82tn
	 Va3158yYJlimve+SnGgF+a/qJbLHiXS/sEkwyom3W3I7J7ck1DzT3ODnnEOgwn2lDy
	 rlUv4te+FWB9Zy9ZT3kULjXJAfshufEhj5imchmYO/ErCR460tNesT4vPSG6cUam/S
	 XfT1FkmDBcR4BJQHWYeqcfE5/xFNLkx6ZkMzFuQlfvkX0beVzN5xSYIdba6ojezL6L
	 CASfy9oiY7YFfIdw8iI2KGEwK8j6i3E7pbbGrZjZLrYFOiK8CQINkAsJwELTQxupxt
	 E0ApUdS55MSoA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id C1CD649441; Wed,  8 Jul 2026 18:40:14 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783536007;
	bh=ZPfelGZxTAG8TUBlIXu+xWodEdDwjBGUunYDmLnNuHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0eqZ9XdVvxCEkLK4Lim2sIulXoKiETevzJYwnvm4Bw2lR01S52xb5sxbnSlVZO1UY
	 4bBTP1UmpjR8XchYjqg4wl7lw05l2nDwniVbgs+LtGrTgpJUTjNFbbLjh+Dv2CW93G
	 k3C9Q4bAU8PUgGIOp1rXcvvGQSTqo0VF14mdIqm7NJkBmf2RSfi0bImI5ZD5JDtYIP
	 uSntEKseTHmilDdXmd10MwxeMi9mGdTRvtw2k2X+CFK/Z86lUG/oX2NT6E55xDBy8t
	 W4WXEuRtg+V+71hMisbZjvui5cRQyphHm4PMdIOJ3IQhb9A7zoDCcld11AGSM6EADo
	 +bYFX/bqaocng==
Received: from DebianDesktop.lan (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id CEEA949445;
	Wed,  8 Jul 2026 18:40:06 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 08 Jul 2026 20:39:16 +0200
Subject: [PATCH net-next v2 10/12] ax88179_178a: Add ethtool get_drvinfo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-ax88179a-v2-10-0800fedb2e16@birger-koblitz.de>
References: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
In-Reply-To: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305963-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mail@birger-koblitz.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:from_mime,birger-koblitz.de:email,birger-koblitz.de:mid,birger-koblitz.de:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC8DF729AA2

Add ax88179_get_drvinfo() as implementation of get_drvinfo, in order
to provide information about the device firmware.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 519d01e80f938346b6c8742be36b70ae31bc2855..31e0ec1c15b455b8810f73d4d8ae9a5b5b05f9a2 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -764,6 +764,21 @@ static void ax88179_disconnect(struct usb_interface *intf)
 	usbnet_disconnect(intf);
 }
 
+static void ax88179_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *info)
+{
+	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *priv = dev->driver_priv;
+
+	/* Inherit standard device info */
+	usbnet_get_drvinfo(net, info);
+	if (priv->chip_version < AX_VERSION_AX88179A)
+		return;
+
+	snprintf(info->fw_version, sizeof(info->fw_version), "%d.%d.%d.%d",
+		 priv->fw_version[0], priv->fw_version[1],
+		 priv->fw_version[2], priv->fw_version[3]);
+}
+
 static void
 ax88179_get_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 {
@@ -1177,6 +1192,7 @@ static int ax88179_set_eee(struct net_device *net, struct ethtool_keee *edata)
 }
 
 static const struct ethtool_ops ax88179_ethtool_ops = {
+	.get_drvinfo		= ax88179_get_drvinfo,
 	.get_link		= ethtool_op_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,

-- 
2.47.3



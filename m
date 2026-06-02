Return-Path: <netdev+bounces-294026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFJUN3tqHmqGjAkAu9opvQ
	(envelope-from <netdev+bounces-294026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:30:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFA0628911
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 07:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A3B1309ACE9
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 05:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D024C24BBEB;
	Tue,  2 Jun 2026 05:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="bHpmRfFx"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F02E7185
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 05:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780378039; cv=none; b=WrU9E8oF6tBCqJh2JQoTO/pew4lpGNBrWZ16qy3DiJsutg/irxRskEYL0VMm5e0NykFdm/cfApULZsdz16T6ZDS1FD2OW8mH3aQQ8zecETzWB+no0wLU5AF279YzBhMbcbk2S6woM+qqp61+AKvKkNcGmgjdoiv9vqieVgubLvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780378039; c=relaxed/simple;
	bh=fRrWPnSuF2dGAOx3BdmHRjIiK9d1lIk5FRvsCmXZUUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NESrSBXnr2/71nGhXOHcrZq8srWVgek2Rku+wlEbyR9sIUKTpEFvpVr/hZ3TVDPm0NsRy+uU0ubabh12JAUGEW5F9HS7W4sOeV2unuf51W3zD7o9AGyjVdFzhHlThfdzibDH9uC2Nt8PIjhl8r3WQo5FZ3wL0As5E7P+83ojmEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=bHpmRfFx; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1780378013; x=1780982813;
	i=markus.stockhausen@gmx.de;
	bh=fBDlDe9fzZflYrbfnGQI1ysp9aaTivgcC0lURdnSN/8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bHpmRfFxA635jPP1gHyydzTbsFYwB+bBXTmq2xvuxNTXGl6FXp3Dj9DwLyWNMf17
	 FIPn+Wzx9SGd/7M47oCuUof32ev3bcp8DrF1hcw5FlclOPdUle9jG5ek6zl7pot4U
	 NH0Lw6nYeQ2Z5PyW/m6lyzSpUN5yRdiC5Vb4uEZeS7sO5Ynttjoes0oNG2vF1YL9l
	 /9i41G72tZEErcM5Nqj2BfNI/7GviPvE9r1QPyvq8ijKbXwEYkoZhkMS22Tn9R4DJ
	 74RKp8QLuwqhUJkWefHAowqdXiS/IRR7ZReb4yn2YpSMqNdRp/EsX47M3EEcnNkX8
	 byT3feg6HZ3RskhA1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9nxt-1wP4yv2ncj-003U9c; Tue, 02
 Jun 2026 07:26:52 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	mensi@mensi.ch
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next 3/8] net: mdio: realtek-rtl9300: harden otto_emdio_map_ports()
Date: Tue,  2 Jun 2026 07:26:35 +0200
Message-ID: <20260602052640.93083-4-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602052640.93083-1-markus.stockhausen@gmx.de>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MbyA6sDix5odDiVEiDz1ZFJlelBLEcQteQmrllhFlmXYtW2ozBe
 Q5+5/vEc8SiDFbzLKzxca1QbPzfZgbH2kHmp+2kB/6XDjwIRU2ahWqeOZey3bCCXtZZlsI1
 1Db0nO0CaU6EfgSpB8CYsVgaABhJm3QCdFQ1kXw/tQ1sPm8WrK7gzPmyNSKM+2do4q+KeDS
 zAwDdIj7Jd8CdzSdD4tGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x7agl5A+P2w=;jJNDmLdRzKETapiYuI3yU4eQ3Ys
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294026-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de];
	DKIM_TRACE(0.00)[gmx.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 5BFA0628911
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Due to its design the MDIO driver needs to set up a port to bus/address
mapping during probing. The "ethernet-ports" subnodes are scanned and
from the "phy-handle" property the MDIO nodes are looked up. In case of
a malformed device tree the driver might produce out-of-bounds accesses.
The PHY address is not checked against the maximum supported address.

Add a sanity check. Do not use the existing (unused) MAX_SMI_ADDR define
but drop it in favour of PHY_MAX_ADDR.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 drivers/net/mdio/mdio-realtek-rtl9300.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/md=
io-realtek-rtl9300.c
index 381c45e0597b..517b01115f34 100644
=2D-- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -78,7 +78,6 @@
=20
 #define MAX_PORTS       28
 #define MAX_SMI_BUSSES  4
-#define MAX_SMI_ADDR	0x1f
 #define RAW_PAGE(priv)	((priv)->info->num_pages - 1)
=20
=20
@@ -495,6 +494,9 @@ static int otto_emdio_map_ports(struct device *dev)
 		if (err)
 			return err;
=20
+		if (addr >=3D PHY_MAX_ADDR)
+			return dev_err_probe(dev, -EINVAL, "illegal smi address %d\n", addr);
+
 		__set_bit(pn, priv->valid_ports);
 		priv->smi_bus[pn] =3D bus;
 		priv->smi_addr[pn] =3D addr;
=2D-=20
2.54.0



Return-Path: <netdev+bounces-302008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jgNDOBNKPWp20wgAu9opvQ
	(envelope-from <netdev+bounces-302008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:32:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E146C7163
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:32:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=LzzlKTES;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302008-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302008-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BCA6305763D
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BE826B2D2;
	Thu, 25 Jun 2026 15:32:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252B426B0A9
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:32:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401531; cv=none; b=mNft5PUBCzoFLAUgPwPTpDsWz96zRukxXI4VfNeDoE/dhXsuD7O99uIlWB5t8YC8iW7j2eOCOq7THqloqQa1qX3xEkuZ1LrAOUVWsh9iesXAWxt8uWTG8YxDZrixwBFyOisV+9uz9vLCHxXHxbUi47zqBTSutJsRoZRTXnqcf90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401531; c=relaxed/simple;
	bh=A8jc0d/xmIjRp2rSNnJ/RqYKcLaSap0CfxnIwAPIOYw=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc; b=jRJMvIGDrYNoJUrrKjU85dqER9rKjXWEAwRkC8Jpk/9ndtm2Cml+QlxJgGY5w7TC6qX3312c4OSzzfoq0AxrXKwVc+5QgvyO7glRjzhkEt1PN3r2R/pr11cH4SqGDoPDrrBmJbiqbndEJEKzzdfH6Umq7jKssLBKDHaD7wwoqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LzzlKTES; arc=none smtp.client-ip=95.215.58.179
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782401527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ar9Pm6dyCZZDF30aU5BwGeEwmXi1wHtXXo5rwKDfdIQ=;
	b=LzzlKTESuhu0dkHvP0QEH9MmbhNKtQuye+xYSiAg9q3DOrKiOf9LGd5NZFm2QJ6iGbpIwT
	A2/SwLRjVZMdCoxJsMnKYjDkzte+5+HJkVBmL8SUMzLDzSbKPfj6iBWCT8hPVXQ8XT+LVC
	cMwipSQc3fNIsmYcSwfY4LqAxgL9jWg=
Date: Thu, 25 Jun 2026 15:32:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Tianchu Chen" <tianchu.chen@linux.dev>
Message-ID: <700e16e9523d7f1299b00df75b13a3c66b6e517b@linux.dev>
TLS-Required: No
Subject: [PATCH] net: usb: cx82310_eth: stop parsing reboot marker as packet
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302008-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[tianchu.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tianchu.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,tencent.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48E146C7163

From: Tianchu Chen <flynnnchen@tencent.com>

Discovered by Atuin - Automated Vulnerability Discovery Engine.

cx82310_rx_fixup() treats an RX length of 0xffff as a device reboot
marker and schedules work to re-enable ethernet mode, but then continues
processing the marker as a normal packet length. This is an out-of-bounds
heap write controlled by the usb device.

Return immediately after scheduling the recovery work so the marker skb
is dropped instead of being assembled as packet data.

Fixes: ca139d76b0d9 ("cx82310_eth: re-enable ethernet mode after router r=
eboot")
Cc: stable@vger.kernel.org
Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
---
 drivers/net/usb/cx82310_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/cx82310_eth.c b/drivers/net/usb/cx82310_eth.=
c
index 068acb052..5df657acf 100644
--- a/drivers/net/usb/cx82310_eth.c
+++ b/drivers/net/usb/cx82310_eth.c
@@ -282,6 +282,7 @@ static int cx82310_rx_fixup(struct usbnet *dev, struc=
t sk_buff *skb)
 		if (len =3D=3D 0xffff) {
 			netdev_info(dev->net, "router was rebooted, re-enabling ethernet mode=
");
 			schedule_work(&priv->reenable_work);
+			return 0;
 		} else if (len > CX82310_MTU) {
 			netdev_err(dev->net, "RX packet too long: %d B\n", len);
 			return 0;
--=20
2.51.0


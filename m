Return-Path: <netdev+bounces-303475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jF9zGz2rRGr2ygoAu9opvQ
	(envelope-from <netdev+bounces-303475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:53:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F646E9FB9
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 07:53:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=W8zZHebU;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=dyZHmPgr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303475-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303475-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C5A5300A513
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 05:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA763939BC;
	Wed,  1 Jul 2026 05:52:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAECD392831;
	Wed,  1 Jul 2026 05:52:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885125; cv=none; b=F5ew8uXfbwpQdoppn0XDRFU2k7XuTlN4o8VoMlD3rTvoCsx9hBtbwtkgvTkRAnxMjEd3u3hz25BXlt3KNKiJ05UAeQeJL7mLDpRW2OerZ2eAvJ60VUGD37tLzjXfgWIBr4rIhvBbSoL24L19HGiBSRvMUamdS7ewNtiXoyO6uVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885125; c=relaxed/simple;
	bh=pKJx1sB/MQ0nAwU0Nm9oHjVfC3Bx6HCGBX5EQ0URiF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQAZtD6Qz0niCe+FO6t3BoNTm+WnUNN5jVh/8k0O09WiQWVvzrgMYn7ysGR13lmDMHtPnl5ifM6y+7sutwAXwBPQlGz4h92buDLKJuKGN6S/6Bsm5H9/TAW4E0EFPC5SbOIsEo4QzDC+tgxdLfTrW+tQ5eKwrLgd5skI5Hv+xi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=W8zZHebU; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=dyZHmPgr; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884575;
	bh=pKJx1sB/MQ0nAwU0Nm9oHjVfC3Bx6HCGBX5EQ0URiF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W8zZHebU/h5VS5VTf0769b5fk11m8LCJCYsHUC5BHU04aitG0tmJsR7a/zRS3qNh0
	 TPa/8dnT3RuGEcxe4zguJH/q+O1J4pnjAQWSZ1LPXWpc1DUrQugeN0MQAaLGcHkXAH
	 wvAAcy4cWEc3FHn+VYoXaVKfqjBaAf/8q6Xi/39MwsXeyfaKHG7IK7UXWVvwWadHV9
	 OMt5/ZkVsgUy1t8d9uuNJsEwM1b5k0IE5g9GnAqiZIZOsVOwVM4Z2VyLhVm1eM9SCj
	 FYYF5/PlOCbPbwa9YiH/N5ZX53fdracBmJeI2T/JFUA2tme1rBc1yoiC8a824nXAtv
	 dG0JPTNDJGJkg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id BA5CE4936A; Wed,  1 Jul 2026 05:42:55 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782884571;
	bh=pKJx1sB/MQ0nAwU0Nm9oHjVfC3Bx6HCGBX5EQ0URiF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dyZHmPgrAHp+//W/kQS6ZDFo94vsd1hUAhSnjwHf9nATdW/gmEVIXKfs6+YmWkfCq
	 64sxkBjMu4++iNhQVr8+HpfYNfzwV2dHhn81FPjn0Jc4bov31O9DF/vQK3xG5cJ6PD
	 +tCMQnnSyooVYB4V/FbKPjRfcT7sjMeNGeHDkdtvh7yuY5MZRROenkgbh37zt7Ce0v
	 stIZ9ytPFHVvHKhmiESAquzfvaKLjIlznb+NHHRNs03mltyT5ejtKMdZH9xYerc7Xb
	 leiQPvS4LnSU85KderX3YJSj5jUH/B3wCmnZkzJ+1UAn+8tZoYGzE3F5zbFHflbrGr
	 CmQfMDJHi7/RQ==
Received: from DebianDesktop.lan (p200300c69f1c3c0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 4EDCA49350;
	Wed,  1 Jul 2026 05:42:51 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 01 Jul 2026 07:42:50 +0200
Subject: [PATCH 4/9] ax88179_178a: Obtain speed and duplex from Interrupt
 URB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-ax88179a-v1-4-13685df67515@birger-koblitz.de>
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
In-Reply-To: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303475-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid,birger-koblitz.de:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5F646E9FB9

For newer AX179A/772D firmwares and the AX88279, the
interrupt URB response also contains information on the Ethernet
speed and duplex status. Read this in order to use it to configure
the link.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/ax88179_178a.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index fadf449fa5df70d4aed706b7488ac61d4cdf4cc9..16528d873e804fde5dcc27659048882eee1c3eaa 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -474,6 +474,7 @@ static int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
 
 static void ax88179_status(struct usbnet *dev, struct urb *urb)
 {
+	struct ax88179_data *data = dev->driver_priv;
 	struct ax88179_int_data *event;
 	u32 link;
 
@@ -484,6 +485,9 @@ static void ax88179_status(struct usbnet *dev, struct urb *urb)
 	le32_to_cpus((void *)&event->intdata1);
 
 	link = (((__force u32)event->intdata1) & AX_INT_PPLS_LINK) >> 16;
+	data->speed = (((__force u32)event->intdata1) >> 8) & 0x7;
+	data->full_duplex = (((__force u32)event->intdata1) >> 12) & 0x1;
+	data->link = link;
 
 	if (netif_carrier_ok(dev->net) != link) {
 		usbnet_link_change(dev, link, 1);

-- 
2.47.3



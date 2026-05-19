Return-Path: <netdev+bounces-289532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EytDCSXDGphjgUAu9opvQ
	(envelope-from <netdev+bounces-289532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:00:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDC3582C69
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21F98308CF3B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D721A40912C;
	Tue, 19 May 2026 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="UyQ0N7QP"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8234409105
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209908; cv=none; b=Krw00vNhGHBe3ggFgmRlSgJFqHo1lh713xB1xtXXxS0D/8MG3wJVVQ9B3lJYgTkSTOS/gy5c/j2zbAn5pd8U5aMLW5VCtArtSozMIjEDoy+a+8BjUjKufRgUeUOSiOOOPZksRBCv/x0a0lAAmzV7Fqjzd/3sYb7J8M6JZ8KqZng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209908; c=relaxed/simple;
	bh=itSHcRue2NW3geXYXwXg6e9GX8Ogxpzs0qcNszejezk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z/8fO13O39aGNFCt36jNy5Q9O6F72uI8pV8o9GaEBg/ivP1DcdZelceO8Z4QUk2GZ6x5x0NlzEH0v4EUgRtHLLxebK13z4ybq16SSw2EeNikjDyyPhQcsD5O1yhFaC6mYXinNTzYRjUQOzruOOBY4GqO+VVl0LsncxDo+du2xaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=UyQ0N7QP; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779209888; x=1779814688;
	i=markus.stockhausen@gmx.de;
	bh=zDtLgHY3MTQxtsDlQimVYXysbiGxYKdoZmTEGCAGFnA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UyQ0N7QPQenCZQIhIvHetycDtdAl6mAs8UVbI/CnBww5vjwtARnVIc3E5g1wmCMn
	 dHi3rxH0vKOnKbXnTNglj431B33uCNem91JGfDIsyAU8CMdH3+WgXer2j9r4f0Cad
	 7R5vMjrv73217hFsdbyGHZR/CQSA/2Vt6Khjwb9JBwSBzIpfurR8CooPwpKi8wwS3
	 bw0g3kCLFhxczngn+gNacSYGOFFha8UAa3qF4Msbf3PpN9frUIjYJrjKDldZGS+3z
	 c/eqvEQ0OJrfICVGzSRI07ugfgbfbhNCJ2v/70Xd0dwKVTu/0RC72qe/se0D5gkJX
	 HSfFIT5SsaWo6a/z/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSc1L-1wny7l2xdR-00YTL0; Tue, 19
 May 2026 18:58:08 +0200
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
	daniel@makrotopia.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH 0/9] mdio: realtek-rtl9300: Groundwork for multi SOC support
Date: Tue, 19 May 2026 18:57:38 +0200
Message-ID: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hdfDSQmi4ercF1gJx5L75TT1DQzYbY7L8ueReL+4EgFJh++u8vl
 xvv4rgY2gBleAmGujROZjo6tA3pkDZa4TNgVNC+fnRhAZpoIEWewQ/cBrfTGb2uVyCjNZe/
 dv9FItrgxZjZS+T/7WJrZac08n/X3LLYCqosH2JNyJfQBw1puPLso+PH877CQMusMPb3iWj
 BNjEu4lx/t3Kv3SA/flqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FJV2KLHi12I=;leCdT3M/PYQBkK9uXLsAErRPrRW
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-289532-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: BDDC3582C69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Realtek Otto switch platform consist of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

The existing realtek-rtl9300 MDIO driver was only designed for RTL930x
devices. The three other SOCs are not supported although they basically
incorporate a very similar MDIO controller.

This series is the first step in a multi stage approach to also support=20
the missing SOCs. Device specific properties and registers are converted
into designated initializers. Based on this new devices can be added
much easier in future commits.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>


Markus Stockhausen (9):
  net: mdio: realtek-rtl9300: Convert to generic prefix
  net: mdio: realtek-rtl9300: Add device specific info structure
  net: mdio: realtek-rtl9300: Add ports to info structure
  net: mdio: realtek-rtl9300: Add pages to info structure
  net: mdio: realtek-rtl9300: Add register structure
  net: mdio: realtek-rtl9300: Add command/C22 register
  net: mdio: realtek-rtl9300: Add I/O register
  net: mdio: realtek-rtl9300: Add mask register
  net: mdio: realtek-rtl9300: Link I/O functions in info structure

 drivers/net/mdio/mdio-realtek-rtl9300.c | 213 ++++++++++++++----------
 1 file changed, 129 insertions(+), 84 deletions(-)

=2D-=20
2.54.0



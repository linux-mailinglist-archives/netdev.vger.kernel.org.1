Return-Path: <netdev+bounces-306446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FmisMkaVUGrt1wIAu9opvQ
	(envelope-from <netdev+bounces-306446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:46:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 273FC737CED
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:46:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=DoBTsxPR;
	dmarc=pass (policy=reject) header.from=padl.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306446-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306446-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D759300FC6E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C4C370AE4;
	Fri, 10 Jul 2026 06:43:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A475379C36;
	Fri, 10 Jul 2026 06:43:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783665835; cv=none; b=EU+H73T/3XEaatzeiCDHjdsTzRd9wsycLsmY11/FUfi876/seg5IK4IUpbpHuQ6TG7YMMoRK1PGRzojguvjsx6htjm9x5PeW1jxK4txZqFIY65W7b7DSz4MnS4MUpukFQkjrD/DfjHA7S3gOO0MX5DSj0IfCD6CoWLL0rnOy+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783665835; c=relaxed/simple;
	bh=sGr37KYenPAfZfJcc/bmn2zk3GBSLYR3711tt+h92zs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KWV5seFCAeOmmpIxOcxKGHsR+DXpTEatGY3791906oHV5LiRfKpp01iNrMVz0hb/MF3CyhkBUPEkWkEK/X6eeL5fBe8RPFSRM1cnFX3Wb817NGxyuOXPDy/pS48oERBTTR2+ha3mamUm8Ss+LY3nizgdWr6+VcUGEVtUvVB+mq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=DoBTsxPR; arc=none smtp.client-ip=216.154.215.154
Received: from [127.0.1.1] (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id AA37460C0B;
	Fri, 10 Jul 2026 02:43:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1783665831; bh=hBIujlqYc22BZ+jJPqB34hQI0omaNUTV+G0Dw7cK4kk=;
	h=From:Subject:Date:To:Cc:From;
	b=DoBTsxPRHfpmex64dt2q/w7KGCCiTbgeCYsvlm5VvzRyWHB82BnP7eFqltyC5+QKa
	 wpSRzSnqtlTx7YZKA+DLYeHjEr70+eVCuYl7U377+9Tdm41TBfrmimEiOb69g1ZuuD
	 v+Pr7rSftE4pN2XCO5GAeqvP8/d4tamUTP1Xu8Dy3Kcn0YqAjT0exEnDhwa5A+0E68
	 iLGmKqvhfArR8clHSKl1zZqeiT1ebSdeOheIOyeQ88LziUbPgsa59IxsFGs3XT75ST
	 Xc9SbZFAZDvlWI7ZJqlikxcmkmy14x3FB9Dzx5Q9gncDOkp7oE06skgBK6C0F5Hu5S
	 X83CnGgvm5wTw==
From: Luke Howard <lukeh@padl.com>
Subject: [PATCH net-next v2 0/2] net: dsa: mv88e6xxx: various hwstamp fixes
Date: Fri, 10 Jul 2026 16:43:40 +1000
Message-Id: <20260710-mv88e6xxx-ptp-fixes-v2-0-af97c38df247@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJyUUGoC/22Oyw6CMBREf4Xctdf0EaC48j8MCx5XqZFC2trUE
 P7dUrcuJzNnZjZwZDU5uBQbWAra6cUkIU4FDFNnHoR6TBoEExWrJMM5KEVVjBFXv+JdR3LIayn
 KmvVKiQYSuVrKRgJvYMijoeih/Tnu3T9p8EfpkZ2084v95AOBZyJv1Uz+3QocGTIuVam4Uk3XX
 NdufJ2HZYZ23/cvDFf68tEAAAA=
X-Change-ID: 20260630-mv88e6xxx-ptp-fixes-1732570b8829
To: Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, 
 Max Hunter <max@huntershome.org>, 
 Christoph Mellauner <christoph.mellauner@joyned.at>, 
 Simon Gapp <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783665827; l=1380;
 i=lukeh@padl.com; s=20260701; h=from:subject:message-id;
 bh=sGr37KYenPAfZfJcc/bmn2zk3GBSLYR3711tt+h92zs=;
 b=NkBNu7kFvodjstT3pHPYVpkU0OZp9YJBc3Hh/6kcZAC8f3FdRlZdOmhsgDUGayHW8CyTAhhNb
 udDlsgey/m6CzEIqLfRQ7xnIYEoveMfwEhZBcne6lQOAjoFGQOyQxLp
X-Developer-Key: i=lukeh@padl.com; a=ed25519;
 pk=D6YgUnH9/OzSZsduYm9XDbvXn1IHDwKwI1hLTsKNRLw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306446-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:vivien.didelot@gmail.com,m:gregory.clement@bootlin.com,m:andrew@lunn.ch,m:richardcochran@gmail.com,m:cedric.jehasse@gmail.com,m:kieran@sienda.com,m:mh@rme-audio.de,m:max@huntershome.org,m:christoph.mellauner@joyned.at,m:simon.gapp@gapp-audio.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:viviendidelot@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,lunn.ch];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,sienda.com,rme-audio.de,huntershome.org,joyned.at,gapp-audio.com,vger.kernel.org,padl.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,msgid.link:url,lunn.ch:email,padl.com:from_mime,padl.com:email,padl.com:mid,padl.com:dkim,davemloft.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 273FC737CED

Two fixes for improving the reliably of hardware timestamp acquisition
on Marvell switches. In our tests this eliminated missed timestamps in
ptp4l.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
Changes in v2:
- Lineraize SKBs before retrieving embedded timestamp
- Hoist driver register lock out of per-frame loop
- Link to v1: https://patch.msgid.link/20260703-mv88e6xxx-ptp-fixes-v1-0-0138581889a9@padl.com

To: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Luke Howard (2):
      net: dsa: mv88e6xxx: use ARRIVAL1 counter for all peer delay messages
      net: dsa: mv88e6xxx: embedded PTP timestamp support

 drivers/net/dsa/mv88e6xxx/chip.c     |   3 +
 drivers/net/dsa/mv88e6xxx/chip.h     |   8 ++
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 140 +++++++++++++++++++++++++++++++----
 drivers/net/dsa/mv88e6xxx/hwtstamp.h |  14 ++++
 4 files changed, 152 insertions(+), 13 deletions(-)
---
base-commit: fe3e786ef4eb6e47d2901f568a27bd920477bbe9
change-id: 20260630-mv88e6xxx-ptp-fixes-1732570b8829

Best regards,
--  
Luke Howard <lukeh@padl.com>



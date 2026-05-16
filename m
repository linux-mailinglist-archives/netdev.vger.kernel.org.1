Return-Path: <netdev+bounces-288632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJCnEGB1CGqGqAMAu9opvQ
	(envelope-from <netdev+bounces-288632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 15:47:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 957FD55BF5F
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 15:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A551300F97B
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983043D88E1;
	Sat, 16 May 2026 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b="sziNV6Qm"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EE617B505;
	Sat, 16 May 2026 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778939227; cv=none; b=F/AHSSlX0GLy5gEyCj0bbwQ4ahohLs0ehtLKjEPOm3knznm7L/14xo76pUkqqSbzS5gKIFDEXRu4LbBwiPKp/HNab21OSimJnOYO0G62U9hYs2VSwN2R7Ugegx1RNrxf0AjWOwfi4Z3YPl7tFAO1LDm6VX+NNeyxUSdYyEMsihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778939227; c=relaxed/simple;
	bh=zaataJ7CfJGgFjzty+qU1S/pR8rb75dR3vgXPE+StGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtaY1tKI+NXqxmx4NUHA4AXf6lCSLT2nn78NcNBjQ/jdmYmvuRt6OwYXswe5rxM5zb8xI0IWiWTlFtvyO3ww3rMxR0vJcpwMsq3tVBVsAcEy7ou5GRw69URgPP96GJATHjiSgWmJg0dTr+VSz/nMrurFZ/g1NE8ag5UWj5vxk7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us; spf=pass smtp.mailfrom=gmx.us; dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b=sziNV6Qm; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.us
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.us;
	s=s31663417; t=1778939213; x=1779544013; i=len.bao@gmx.us;
	bh=zaataJ7CfJGgFjzty+qU1S/pR8rb75dR3vgXPE+StGE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sziNV6QmR2TEmXJtXeP+Nhx+xFJVvImtD1X5gQIvZQYIhSSSCQue+FG6tzr8u10W
	 B/h+HaZqeD5Ubm8bsp/WcDsGBiT2N2FrGhHhouN3JFqHBy7uVuO+qdw6qQqTbX4w9
	 4s3zhVyFUVAFP37uTsz8MXvji0GH6pvHtZhzheyUfqO+bbs3bpxKmQ75Qy1snhcfb
	 ARpz7xQH7mCZiORx6zxdLBi5VBhPzKLBAhkWyslgQ03wr8YQ7dR4JRnlDiw+Ly413
	 /uz416tzawWWHSAR34m9RCdruIAYANqC1CZMJvv++DxlrBBYiGgYclaRRxGFlgVG9
	 pAxZFR6MjWD30u8tew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M1Ycr-1wMshr49Kl-00Cm7a; Sat, 16
 May 2026 15:46:53 +0200
From: Len Bao <len.bao@gmx.us>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Len Bao <len.bao@gmx.us>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arcnet: com90xx: Mark cards and numcards variables as __ro_after_init
Date: Sat, 16 May 2026 13:46:26 +0000
Message-ID: <20260516134628.30672-1-len.bao@gmx.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O7jo/vO/1htTfrH+nJI33nsUY5wC6HnFPipZmhrVf8h9seqt6Uw
 /9myA1YfVARS/7H03cJb24LuWYtnmWlv91t8pgloLFAiXGlRcGnYL2X9+QH/jxUekbgosFt
 9JyWHQzuJJMhRFXeeiWZOvcqhRPZ57a7RMAYWihFOkQHXEJbLE129FNMUzlksPUMA4HJwRA
 +sHBTtJAy2910MoCrjvMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NHjo4qNkx1E=;oT56oei1A6qbIfLrI8XkAJbvJG5
 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
 udRK1Sa4ElkLurA==
X-Rspamd-Queue-Id: 957FD55BF5F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.us,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.us:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmx.us,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288632-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.us];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[len.bao@gmx.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.us:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The 'cards' and 'numcards' variables are initialized only during the
init phase in the 'com90xx_found' function and never changed. So, mark
these as __ro_after_init.

Signed-off-by: Len Bao <len.bao@gmx.us>
=2D--
 drivers/net/arcnet/com90xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/arcnet/com90xx.c b/drivers/net/arcnet/com90xx.c
index b3b287c16..bdcdccbfb 100644
=2D-- a/drivers/net/arcnet/com90xx.c
+++ b/drivers/net/arcnet/com90xx.c
@@ -67,8 +67,8 @@ static void com90xx_copy_from_card(struct net_device *de=
v, int bufnum,
=20
 /* Known ARCnet cards */
=20
-static struct net_device *cards[16];
-static int numcards;
+static struct net_device *cards[16] __ro_after_init;
+static int numcards __ro_after_init;
=20
 /* Handy defines for ARCnet specific stuff */
=20
=2D-=20
2.43.0



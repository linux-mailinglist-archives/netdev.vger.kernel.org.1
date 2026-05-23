Return-Path: <netdev+bounces-291121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LBaHjDDEWpDpgYAu9opvQ
	(envelope-from <netdev+bounces-291121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 17:09:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2ED45BF90E
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 17:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFC52300952D
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 15:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CAD2E0B58;
	Sat, 23 May 2026 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b="o4oM3L0O"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8892DF13E;
	Sat, 23 May 2026 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779548906; cv=none; b=FrY7JpLGzJWyILh8su1Vma4IweKarDD41/dBsbHO2r8PDJIEmYQFLIdL6tU+ln7X8bJSVO/+9EyBJDZAcKxXjnglEVl5iggGizV89S3VZpUkTF6czJKnU5k6qQokG5uFbf6etTHPlWCB1XnatLgPxMS3j9732NSYjZWIds6KigQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779548906; c=relaxed/simple;
	bh=82NSXEFFd4WZzMrDPwcXU9JvSq4k+i+r57OuVwqdf2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S26UDi03tAyTO5WuKl6kydE3QuelPmCFdK3VE0cqDIw3ZEd8I0fZyX86MbJnaE6j8L6bke8/5CsR013taBJNQrHYO0N0IOTrVeH3CLnB//Nf6ilGfesI7421AUZqXstvujroTkpnw+KEEOC8NMhS4qejwteSdvMBdKicDvTfmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us; spf=pass smtp.mailfrom=gmx.us; dkim=pass (2048-bit key) header.d=gmx.us header.i=len.bao@gmx.us header.b=o4oM3L0O; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.us
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.us;
	s=s31663417; t=1779548888; x=1780153688; i=len.bao@gmx.us;
	bh=M1PtxixyZK4GcxsbhumggAhD3tRUbNOr0CDeoNrgEXo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=o4oM3L0OuVzXYAzozEWSFBeOtYIqiUtkV51Ns4roQ6/CKvpN1EwhgMd5sOxyXK26
	 hJ7CsfjvswRO3Giq+i/DLotU0RLWP1u6VPa4zllA7M7YC/V84Gwp36Iz13jlqZpiM
	 h4qBzscSZrUw00E1zzGvwL480PjXWiwPd9J5Pi/uIK1EZJtTjcFQc6tgxx8+qYen9
	 sxlO6Dn4BV9eRyGm7UOb5ED4g3gPoNu/MxaWzbIvD2tDjHVAV8q7oFvkBwxr3CKFg
	 bkGW+sTdxV7hse00qeS9d++jY+om4IpnTBcKSjok+WyHitAFQbmpQAGKV95vaWYDU
	 geGK6uPP2haU1I7RFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGQnP-1wYILS0Hb3-00BHR2; Sat, 23
 May 2026 17:08:08 +0200
From: Len Bao <len.bao@gmx.us>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Len Bao <len.bao@gmx.us>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] eth: dpaa2: constify dpaa2_ethtool_stats and dpaa2_ethtool_extras
Date: Sat, 23 May 2026 15:07:35 +0000
Message-ID: <20260523150737.36988-1-len.bao@gmx.us>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EbexVjdeiW8vBjD+8Pf4bwCgH/Pf409FEHKLg6jTu+GV986aKtg
 JkV6c5yBtzsIyqTe1Yu7I87r+nZkcZxZLm9RTbaxxAeZaEIhD0aCTRQC9Xo8rD8cqWYLe5b
 3JWi6TMJF3fQVkr9aUlsI3xn2LVooFeudabKieEQ1WBiNesqMv91rnDAhVzakf+nGlrJnfT
 KiGM783bV5SaXki04O89w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NqrnVigbh8A=;RXDU8PVwlLfXrWkVXoQba/BBF7k
 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
 tGfP85LJMn7n12r5dY=
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.us,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.us:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmx.us,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291121-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.us];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[len.bao@gmx.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.us:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.us:email,gmx.us:mid,gmx.us:dkim]
X-Rspamd-Queue-Id: F2ED45BF90E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The 'dpaa2_ethtool_stats' and 'dpaa2_ethtool_extras' structures are
initialized in their declarations and never changed. So, constify them
to reduce the attack surface.

Before the patch (size dpaa2-ethtool.o):

   text	   data	    bss	    dec	    hex
  33433	   5992	      0	  39425	   9a01

After the patch (size dpaa2-ethtool.o):

   text	   data	    bss	    dec	    hex
  34937	   4488	      0	  39425	   9a01

Signed-off-by: Len Bao <len.bao@gmx.us>
=2D--
 drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c b/driver=
s/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
index 59f5c778d..fcc0a30a9 100644
=2D-- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
@@ -10,7 +10,7 @@
 #include "dpaa2-eth.h"
=20
 /* To be kept in sync with DPNI statistics */
-static char dpaa2_ethtool_stats[][ETH_GSTRING_LEN] =3D {
+static const char dpaa2_ethtool_stats[][ETH_GSTRING_LEN] =3D {
 	"[hw] rx frames",
 	"[hw] rx bytes",
 	"[hw] rx mcast frames",
@@ -37,7 +37,7 @@ static char dpaa2_ethtool_stats[][ETH_GSTRING_LEN] =3D {
=20
 #define DPAA2_ETH_NUM_STATS	ARRAY_SIZE(dpaa2_ethtool_stats)
=20
-static char dpaa2_ethtool_extras[][ETH_GSTRING_LEN] =3D {
+static const char dpaa2_ethtool_extras[][ETH_GSTRING_LEN] =3D {
 	/* per-cpu stats */
 	"[drv] tx conf frames",
 	"[drv] tx conf bytes",
=2D-=20
2.43.0



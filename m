Return-Path: <netdev+bounces-260214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCSfB67LnGlHKQQAu9opvQ
	(envelope-from <netdev+bounces-260214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:50:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD3C17DBDE
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18564301F6A9
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D211436F427;
	Mon, 23 Feb 2026 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="oCRRAMy1"
X-Original-To: netdev@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC29F36C596
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883435; cv=none; b=tb1Z+WzS/9Rfgo7U0wjmx9ZvcoZLKPIzMiBCUFmJ4FkrBcMYBD6CsD5yNMznZIRy2jSS9X3Bmp+UpHAERmTC/sbcvxicPf0i4bI474bN0WRusLd0Cpgn/6IBAKXFVF7cgxrFf//64oMbU+V8/FLCLJSr278Yfgry8+DGi98du7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883435; c=relaxed/simple;
	bh=dJIY/emjpr4sdLgCFoAYb5MbGHRNecbCpDwVHChAFLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObhMCmsQ55DSWAywiQI3aAPgprSkJsKgs0v+RQnpGRLx1Bp77faP5esuDqRz225mo24E12fbgTct0MU6FXOfcAPvJ9dXhKlI87EnUHICA9/ZVcJYE73LntQTD9Xdn21Glmggla9mXRRHA/hQVDmOmFTgTAZ6q/BvBcicGgQhKeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=oCRRAMy1; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZKQ2hjQzlh2fB;
	Mon, 23 Feb 2026 21:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883432; x=1774475433; bh=ANKdv
	tuiRf4C27SapojcPvyuhJhY2SUjvNwjDyRn5hU=; b=oCRRAMy1D4lcS7Zmhag2D
	FemoHiyypnYUheIvxFs7BiaF3cLjjD8OsqU2TU8ee2z2HD6mlDpD1puP0jQpfY2L
	1LMsX2ycBfCwca6v0RTf0Sdi/44tpDtrI5RReIgJWNRaN4VTdeWpfPw03wWyv42W
	dNRi/WGevjqNADMmmLqbAet+aSRsTx2UVOAyeVurWC6FQwNE1cgino1ZMQNa2NAp
	VREa+e2V6t2d+Al4O00KkGP/6OdWSMrmPNorONbAgRCsX4X4e3ieQpIunjkHzp7W
	Oa8JNA/i94dOh4oNwRdf6QDQ/WxHgFfgzS742v1A3l3uO0RPtqWXTgxAorxbeEsj
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WgwScLXhapj1; Mon, 23 Feb 2026 21:50:32 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZKK5xPSzlfddf;
	Mon, 23 Feb 2026 21:50:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Naveen Mamindlapalli <naveenm@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	netdev@vger.kernel.org
Subject: [PATCH 20/62] octeontx2-pf: Fix locking in an error path
Date: Mon, 23 Feb 2026 13:49:08 -0800
Message-ID: <20260223214950.2153735-21-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223214950.2153735-1-bvanassche@acm.org>
References: <20260223214950.2153735-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260214-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: ABD3C17DBDE
X-Rspamd-Action: no action

Only unlock pf->mbox.lock if it has been locked by otx2_do_set_vf_vlan().
This bug has been detected by the Clang thread-safety analyzer.

Cc: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Sunil Goutham <sgoutham@marvell.com>
Cc: Geetha sowjanya <gakula@marvell.com>
Cc: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: hariprasad <hkelam@marvell.com>
Cc: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org
Fixes: f0c2982aaf98 ("octeontx2-pf: Add support for SR-IOV management fun=
ctions")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drive=
rs/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index ee623476e5ff..8c9f08ed90fd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -2588,7 +2588,7 @@ static int otx2_do_set_vf_vlan(struct otx2_nic *pf,=
 int vf, u16 vlan, u8 qos,
 	config =3D &pf->vf_configs[vf];
=20
 	if (!vlan && !config->vlan)
-		goto out;
+		return err;
=20
 	mutex_lock(&pf->mbox.lock);
=20


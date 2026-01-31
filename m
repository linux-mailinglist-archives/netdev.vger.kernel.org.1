Return-Path: <netdev+bounces-255485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJf6BoZDfmnbWgIAu9opvQ
	(envelope-from <netdev+bounces-255485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:01:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B29B0C374A
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D2CC300361C
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1AF33D6E3;
	Sat, 31 Jan 2026 18:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="k+Ds22Q8"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FF830DEC0
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769882495; cv=none; b=kwJSbEjoHX3fHMXW59U8Kf7qi3TzyHNGDygCBmZ+f5N/laYzcJvQGutxuRC6pURlbs2rRLTBvMzGviFDitl5pRXg0/v/mWD39ay8U5dJdKRdSFFqiogbbtHWOzG3w91c9NKaclRfkYQuRpRk/k2dqxc+5rkHh3sP6Zpe5T31mdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769882495; c=relaxed/simple;
	bh=+19jXWzOxkMOnxFEs3HcD6qzXWy42+n/Tim8BASurCU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P6zwZzVeIfEImKgzx9xgTZSv5NDUmRb2cYbSdDlDDX12OD6357BFv9dI0T+c3MG+k6zzrkIeCG/zFinngtI1y1qYUj/6rqCjSVgRgCy1/Znv2i4wGNBdDeU8t8PeOl+wfNlcYonrTaGh274qYbJx+gxkA2QrPdIzGr+wZ2S4dYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=k+Ds22Q8; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60VAv5eU1201528
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 10:01:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=RLdg62LEJ87UX2jmlI
	BkSmqLa0qAGPTN9TVDGF46k04=; b=k+Ds22Q8Vr5xdmLaIjFCpdEf6TjuJIYbAh
	etr9BEUgkGhgGUdM1KouZO98z4fRqH2IU+4RrHOzPG1bEOVc1gno3CJjwuyLjRZS
	WB7KO2qmBYz3rouODa8SkKY2JXlZ+J/KfS8j3Q82ynwy/mcH1BDWdg9+wy4QiH9B
	zo6GteFnAWM2O7MbGzNKWazUw9MR+seksUVu+eq87lh0Ju7c2RNkwEgUV9EYt7AK
	FPzU7V9pfNp5YtQE77BXuV5rCgf5DJO0yw5T1KBOs+X9OuRJJN3ODRlfp+ZkR50I
	aDNru5Q4pcJoSLKhuq/Inrq4XrQ2+XsxGKxtq5iQJpBJzEwZ/tbw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c1ge928bk-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 10:01:32 -0800 (PST)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sat, 31 Jan 2026 18:01:29 +0000
Received: by devbig010.atn3.facebook.com (Postfix, from userid 224791)
	id 1E395748AA3; Sat, 31 Jan 2026 10:01:14 -0800 (PST)
From: Daniel Hodges <hodgesd@meta.com>
To: Jon Maloy <jmaloy@redhat.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <horms@kernel.org>, <tuong.t.lien@dektech.com.au>,
        <netdev@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>,
        Daniel
 Hodges <hodgesd@meta.com>
Subject: [PATCH RESEND] tipc: use kfree_sensitive() for session key material
Date: Sat, 31 Jan 2026 10:01:14 -0800
Message-ID: <20260131180114.2121438-1-hodgesd@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DMjz5wKZRn-v2pMCqZnNasUgYkGOe1XB
X-Proofpoint-ORIG-GUID: DMjz5wKZRn-v2pMCqZnNasUgYkGOe1XB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDE1MiBTYWx0ZWRfX225nekovJAhH
 vCJsBopavB6U2UBgCHASJ7JPB7wuvxDAig7be+6AbZVwwVsHtY1M3Q5Oh6lS7tJpaMV7j6fZyXB
 oDmVYQXjW+KidkUz7qDSPiLlkswlSaFpGWvNjKhCG7CZn/ZlSALkd/gm8j8zZl+qYFe49Tglmzd
 Rwm3uuiCnGs8VTX79/e/SGcNqXp14fRUoX81Vg5xGQIkU8RxaVADjA0XKaN5QFzb4TitPXwWvoo
 wF5WhQVeV8uXth/9g6u5Gg5elkIgTku9AnjDsqVEJi9BsMNYkruHIYezYaERIL/Njhw7Ei3iglS
 Crl0Oj+sIXBjtNvohZfV9K1+IpNe2vksa+l9QOv4OMB4HUtiz9UgvaLmWdUma2U4Ku23ZBOD9Ao
 Hla6a0TUJMOaJEuQxKQH2KZKwReXb0nL6bDR05kqvBmiXvv3pdikyNgrCKCPfJWpRH+142Lvpwm
 H6IfZjsK2fMR/2um2AQ==
X-Authority-Analysis: v=2.4 cv=B8i0EetM c=1 sm=1 tr=0 ts=697e437c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=cPLOpp3optabX5KMabIA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_03,2026-01-30_04,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255485-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:dkim,meta.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hodgesd@meta.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B29B0C374A
X-Rspamd-Action: no action

The rx->skey field contains a struct tipc_aead_key with GCM-AES
encryption keys used for TIPC cluster communication. Using plain
kfree() leaves this sensitive key material in freed memory pages
where it could potentially be recovered.

Switch to kfree_sensitive() to ensure the key material is zeroed
before the memory is freed.

Fixes: 1ef6f7c9390f ("tipc: add automatic session key exchange")
Signed-off-by: Daniel Hodges <hodgesd@meta.com>
---
 net/tipc/crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 751904f10aab..970db62bd029 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -1212,21 +1212,21 @@ void tipc_crypto_key_flush(struct tipc_crypto *c)
 {
 	struct tipc_crypto *tx, *rx;
 	int k;
=20
 	spin_lock_bh(&c->lock);
 	if (is_rx(c)) {
 		/* Try to cancel pending work */
 		rx =3D c;
 		tx =3D tipc_net(rx->net)->crypto_tx;
 		if (cancel_delayed_work(&rx->work)) {
-			kfree(rx->skey);
+			kfree_sensitive(rx->skey);
 			rx->skey =3D NULL;
 			atomic_xchg(&rx->key_distr, 0);
 			tipc_node_put(rx->node);
 		}
 		/* RX stopping =3D> decrease TX key users if any */
 		k =3D atomic_xchg(&rx->peer_rx_active, 0);
 		if (k) {
 			tipc_aead_users_dec(tx->aead[k], 0);
 			/* Mark the point TX key users changed */
 			tx->timer1 =3D jiffies;
@@ -2387,21 +2387,21 @@ static void tipc_crypto_work_rx(struct work_struc=
t *work)
 			pr_warn("%s: unable to attach received skey, err %d\n",
 				rx->name, rc);
 		switch (rc) {
 		case -EBUSY:
 		case -ENOMEM:
 			/* Resched the key attaching */
 			resched =3D true;
 			break;
 		default:
 			synchronize_rcu();
-			kfree(rx->skey);
+			kfree_sensitive(rx->skey);
 			rx->skey =3D NULL;
 			break;
 		}
 	}
=20
 	if (resched && queue_delayed_work(tx->wq, &rx->work, delay))
 		return;
=20
 	tipc_node_put(rx->node);
 }
--=20
2.47.3



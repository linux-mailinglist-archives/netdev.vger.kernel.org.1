Return-Path: <netdev+bounces-263492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLomKQh6p2kshwAAu9opvQ
	(envelope-from <netdev+bounces-263492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:17:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2101F1F8CB9
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A612D313646E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6BB17BEBF;
	Wed,  4 Mar 2026 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="Zo40B+Ua"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC911A275
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 00:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583293; cv=none; b=a/vAaM/N6dCRLFN+TLGaIF53DODV0M+LfE78eTEPN82wX9yL2b5ehFdr0orC9IHgzBPscMR8R8MAUFKYs3sY3mXc0KshnZd05fPB+nPh7tkgt2LmexBEZ4ZxFO6PZrx0GwXKNnTXkc5SDhFIlwDQ9ApPWyq6Bo+PaSfSRKmIkXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583293; c=relaxed/simple;
	bh=ELcsbryDbW1HsUGFekMMsczRqrv1wUaUYax+w3zo4G4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnRjnTNmVvyGeaFjIIXLa+xHrgmBBlmGm4btAj5z7e5ubS3tQ0J1sq6AmEnwBMj0ql7YQGLelzSppvdvRKCT48YJp3P9d32smlO0dbwkOLeHIfbYlfbLUKIwOd6V6FXNqgOMv24XZn3sE+6x/vVdD676euoBF/wnSrYfmaEQisU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=Zo40B+Ua; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623Ltx7q2473256
	for <netdev@vger.kernel.org>; Tue, 3 Mar 2026 16:14:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Z8Y108rJi+kI1qIutqeJm2bhlYAVj7MCxl/J9CbtwP4=; b=Zo40B+UaVVgC
	3l/MPDqOr49XGgBqejMCsJoDKiOgLrB1c6pgfZjGw5MSVAjN67eOXOTgyGAQleny
	j27L+meAVgXmUVnzGJBaIPMrArlkdegMnj+HEm+u+rMlkGrCPCnnWV5I4UuoeyKr
	0s+tjXYtBXMxSh4QLzGJ/HHLfz7BThJvMvoWUmqtvVydw1wF6zI29rfgldtFaerc
	dAto9u0lCz6ergxgtlVvFLs9QJnWq5c0dQMhI7z4DXxCsMZwsmpvJvurzdGHWSWC
	RNq42NkL0+CdGP1KvTv4oEGQP/JTBH0s/Agti4Ep1uTbgOsBGWTChhbhk8d+uaDn
	puHXu7XTOQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cp80b317m-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 16:14:50 -0800 (PST)
Received: from twshared18080.32.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Mar 2026 00:14:47 +0000
Received: by devbig1867.frc2.facebook.com (Postfix, from userid 708122)
	id 6301375994A6; Tue,  3 Mar 2026 16:14:42 -0800 (PST)
From: Wei Wang <weibunny@fb.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Daniel Zahka
	<daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
CC: Wei Wang <weibunny@fb.com>
Subject: [PATCH v2 net-next 7/9] psp: add a new netdev event for dev unregister
Date: Tue, 3 Mar 2026 16:00:47 -0800
Message-ID: <20260304000050.3366381-8-weibunny@fb.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304000050.3366381-1-weibunny@fb.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BB7tpZzchSabf3vHqFXZ2WPVnj817jq-
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=69a7797a cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=FOH2dFAWAAAA:8 a=-RvZIenZIDdK7zbSOTYA:9
X-Proofpoint-ORIG-GUID: BB7tpZzchSabf3vHqFXZ2WPVnj817jq-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAwMCBTYWx0ZWRfXxdxOGCeOdCLp
 gN3Ufv3wDMSxvBvpv34nEBnouzxXrqXlmeFyjALW5HwrTQFy4tXzkMey9Rkb4osJq8oF1Eo005M
 VjrELtfgBCtW1z3ngc/SlhFjxf6Ec2qGQQDRLxuGDbeko+SkA2G895yXACGFmHnKTsd5tU3DJNj
 WsRUDjzmONdXO9cxa+4ZveqXLgwUt4MDcKDio8oS62web7/+GL9elzGG9Kb0ZDUgx9N7bTcwBIq
 34mgJJdxvD5rPTC9lywkMiSv6XJoGs9O//jPzxFqHUK1KbMrrTvoDktxVoRUclgKhO76m69hODN
 yLDbJdxp8rA0A+nBGUvwf+aQ+gQxR9HQ0NIZzVKwAb/xI+T5zfRUxB5BbNS7SXXQsuZBZrrjJcq
 Rej8VbTvYPk5vxbv+gG99f94nBjp6bigjrbZmN706ByBOW/dy3TTDcTNDcqf+azf8eKiqzurSEQ
 CeptRxflzVViQ8k+bog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Rspamd-Queue-Id: 2101F1F8CB9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fb.com,reject];
	R_DKIM_ALLOW(-0.20)[fb.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-263492-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@fb.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fb.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add a new netdev event for dev unregister and handle the removal of this
dev from psp->assoc_dev_list.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 net/psp/psp_main.c | 64 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index a7635cae0d83..83b2b3abbe6f 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -371,10 +371,72 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, u8=
 generation, bool strip_icv)
 }
 EXPORT_SYMBOL(psp_dev_rcv);
=20
+static void psp_dev_disassoc_one(struct psp_dev *psd, struct net_device =
*dev)
+{
+	struct psp_assoc_dev *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &psd->assoc_dev_list, dev_list) {
+		if (entry->assoc_dev =3D=3D dev) {
+			list_del(&entry->dev_list);
+			rcu_assign_pointer(entry->assoc_dev->psp_dev, NULL);
+			netdev_put(entry->assoc_dev, &entry->dev_tracker);
+			kfree(entry);
+			return;
+		}
+	}
+}
+
+static int psp_netdev_event(struct notifier_block *nb, unsigned long eve=
nt,
+			    void *ptr)
+{
+	struct net_device *dev =3D netdev_notifier_info_to_dev(ptr);
+	struct psp_dev *psd;
+
+	if (event !=3D NETDEV_UNREGISTER)
+		return NOTIFY_DONE;
+
+	rcu_read_lock();
+	psd =3D rcu_dereference(dev->psp_dev);
+	if (psd && psp_dev_tryget(psd)) {
+		rcu_read_unlock();
+		mutex_lock(&psd->lock);
+		psp_dev_disassoc_one(psd, dev);
+		mutex_unlock(&psd->lock);
+		psp_dev_put(psd);
+	} else {
+		rcu_read_unlock();
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block psp_netdev_notifier =3D {
+	.notifier_call =3D psp_netdev_event,
+};
+
 static int __init psp_init(void)
 {
+	int err;
+
 	mutex_init(&psp_devs_lock);
+	err =3D register_netdevice_notifier(&psp_netdev_notifier);
+	if (err)
+		return err;
+
+	err =3D genl_register_family(&psp_nl_family);
+	if (err) {
+		unregister_netdevice_notifier(&psp_netdev_notifier);
+		return err;
+	}
+
+	return 0;
+}
=20
-	return genl_register_family(&psp_nl_family);
+static void __exit psp_exit(void)
+{
+	genl_unregister_family(&psp_nl_family);
+	unregister_netdevice_notifier(&psp_netdev_notifier);
 }
+
 subsys_initcall(psp_init);
+module_exit(psp_exit);
--=20
2.47.3



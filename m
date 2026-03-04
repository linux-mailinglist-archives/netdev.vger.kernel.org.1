Return-Path: <netdev+bounces-263494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA/HIid6p2kshwAAu9opvQ
	(envelope-from <netdev+bounces-263494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:17:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE5C1F8CED
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C650314FCA9
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436F417BEBF;
	Wed,  4 Mar 2026 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="lrOcCLdl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A5D23BF83
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583298; cv=none; b=ZAVhwyEgpV5RmdGoC/4Z5p/mtwd8I8vWnKO1Xe5pbKsVvKCKIgTQy6gTncWYlRX7YN1Rr00hqjiYmfg/qRNj0URteFg5A7n3DKhIygdWk1Bb2LntsDRmplMeZGvT9eOCvyJgccGhie48vR6rXO9+hkqZwldq12hP3Rl11YaD04Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583298; c=relaxed/simple;
	bh=fGRmrJdi4klDTfY9T/1uS529NbyMbKj6T02YxEgHczk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4Q4BA8QjDfy4FIsJipxqJKtmXciUdgx9xqWMgXVkjJRs/Vu6XHgZ+yuhi6Y+vjmOwuisvwef09Mwuora7dUjtbH5YGlE4Ie8RI9OIhdUpZHoEuwPa6DXFBaJR+H9s1nGnfPISQXxwxu/5NCIe7OE/f0DCtyrocnJUM+8aWGPFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=lrOcCLdl; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 623MMwKD2641815
	for <netdev@vger.kernel.org>; Tue, 3 Mar 2026 16:14:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=P9GhpdTsd66GW7hxaj7RAncUsX1HVluhTGLSwAF4ZuY=; b=lrOcCLdltqto
	Gitl9Nsln7g6cGp/aJKXO97GWCu1VgNF/oOyh+ml9miTaIedrXVM637LqlR0im4l
	t2O/SFPglFv/ZBH6+N8UGPHWITPE3mYHSTysL7lL+4S8sDEuGYRSPp6VEWeFFqpU
	Ll3EdiVg+S0BRgsVm5T770ILU1EoXKrh1XWZW8WnbfNYw781XQDbA9NRvYx6KBQJ
	imHvi3iIle9nljz9VTxAeJm+K+3faCQVdPXbRO6vL0RPfGqdam686TGJmkAIzwFm
	08fPwvKlXcGdmJ8nDONr5wh0bI6JWw6shli5W8SMhG8Av5/mGFlwOoGppfhql65m
	lqAUgZF9Fw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4cp4knnjku-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 16:14:55 -0800 (PST)
Received: from twshared4931.33.frc3.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Mar 2026 00:14:25 +0000
Received: by devbig1867.frc2.facebook.com (Postfix, from userid 708122)
	id 233BF75992EF; Tue,  3 Mar 2026 16:14:21 -0800 (PST)
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
Subject: [PATCH v2 net-next 5/9] psp: add unprivileged version of psp_device_get_locked
Date: Tue, 3 Mar 2026 16:00:45 -0800
Message-ID: <20260304000050.3366381-6-weibunny@fb.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAwMCBTYWx0ZWRfX3QMybkgDQYHP
 ZjTgwOInw4X/uNvVmboZRQ7cZT31aVJEguEKs9wVNmLC6J4jOR9ZojLTTrQpciqwjFjro79PiKT
 60VkvQfrRci9LHjAVvg4Ysv0871UtzBsIPVe8IY0h5h/cEVBGS2eCx14K6j3e7BbqSEcIs5T9Ji
 rRV6vD6QxzW4qAhpVF+TG968t6fnLdiAGcwK5LEDgW3luD0ZMS0JuVSUMsRZ0efWLGCOSuTaHd/
 f260MknrikxVbIf30bT7OrwAQKJBVsHRwMgFvpC5FHLryvNaDxNEAXs0XBVr65SzCeb+V+RUdk+
 NRjsFOenySbEKWkFZNAqdKpkUe6s3ak5TzT4F6Vw8xplRJ9V9LHVdzIksSi/RGqrdFgS3svf66v
 Y3NjU8QVTbE+rgou8+1NHwjN6hOIFrZ5dlKjIxTJyCBNzLC3BUOYA3cOzm1Dbgpbo38G7kRoo7Z
 Jsfo4uSZYAvyEFAX0nQ==
X-Authority-Analysis: v=2.4 cv=WKtyn3sR c=1 sm=1 tr=0 ts=69a7797f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=FOH2dFAWAAAA:8 a=3uZni17FfLg2RqZpgO4A:9
X-Proofpoint-ORIG-GUID: dqboUbC8vp8BSAGqFFXwj57b4YLAQKCJ
X-Proofpoint-GUID: dqboUbC8vp8BSAGqFFXwj57b4YLAQKCJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Rspamd-Queue-Id: 0FE5C1F8CED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fb.com,reject];
	R_DKIM_ALLOW(-0.20)[fb.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-263494-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

Add a place holder function called psp_device_get_locked_unpriv() which
will be used for commands that are unprivileged and are used for
exisiting commands like dev-dump, dev-get, rx-assoc, tx-assoc.
Commands including dev-add/delete/change-ntf, key-rotate would keep
using the privileged version.

Following commit will be implementing the unprivileged version check.

Signed-off-by: Wei Wang <weibunny@fb.com>
---
 Documentation/netlink/specs/psp.yaml |  2 +-
 net/psp/psp-nl-gen.c                 |  2 +-
 net/psp/psp-nl-gen.h                 |  2 ++
 net/psp/psp.h                        |  2 +-
 net/psp/psp_main.c                   |  3 ++-
 net/psp/psp_nl.c                     | 28 +++++++++++++++++++++-------
 6 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink=
/specs/psp.yaml
index f3a57782d2cf..2ef94f3503c8 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -170,7 +170,7 @@ operations:
             - ifindex
             - psp-versions-cap
             - psp-versions-ena
-        pre: psp-device-get-locked
+        pre: psp-device-get-locked-unpriv
         post: psp-device-unlock
       dump:
         reply: *dev-all
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 22a48d0fa378..106607a201d8 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -57,7 +57,7 @@ static const struct nla_policy psp_get_stats_nl_policy[=
PSP_A_STATS_DEV_ID + 1] =3D
 static const struct genl_split_ops psp_nl_ops[] =3D {
 	{
 		.cmd		=3D PSP_CMD_DEV_GET,
-		.pre_doit	=3D psp_device_get_locked,
+		.pre_doit	=3D psp_device_get_locked_unpriv,
 		.doit		=3D psp_nl_dev_get_doit,
 		.post_doit	=3D psp_device_unlock,
 		.policy		=3D psp_dev_get_nl_policy,
diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
index 599c5f1c82f2..7abad086be1e 100644
--- a/net/psp/psp-nl-gen.h
+++ b/net/psp/psp-nl-gen.h
@@ -15,6 +15,8 @@
 /* Common nested types */
 extern const struct nla_policy psp_keys_nl_policy[PSP_A_KEYS_SPI + 1];
=20
+int psp_device_get_locked_unpriv(const struct genl_split_ops *ops,
+				 struct sk_buff *skb, struct genl_info *info);
 int psp_device_get_locked(const struct genl_split_ops *ops,
 			  struct sk_buff *skb, struct genl_info *info);
 int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
diff --git a/net/psp/psp.h b/net/psp/psp.h
index 9f19137593a0..0e4ca03de869 100644
--- a/net/psp/psp.h
+++ b/net/psp/psp.h
@@ -14,7 +14,7 @@ extern struct xarray psp_devs;
 extern struct mutex psp_devs_lock;
=20
 void psp_dev_free(struct psp_dev *psd);
-int psp_dev_check_access(struct psp_dev *psd, struct net *net);
+int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool unpr=
iv);
=20
 void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd);
=20
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index d4c04c923c5a..27390b5cc89d 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -27,10 +27,11 @@ struct mutex psp_devs_lock;
  * psp_dev_check_access() - check if user in a given net ns can access P=
SP dev
  * @psd:	PSP device structure user is trying to access
  * @net:	net namespace user is in
+ * @unpriv:	whether the caller is unprivileged
  *
  * Return: 0 if PSP device should be visible in @net, errno otherwise.
  */
-int psp_dev_check_access(struct psp_dev *psd, struct net *net)
+int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool unpr=
iv)
 {
 	if (dev_net(psd->main_netdev) =3D=3D net)
 		return 0;
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 6afd7707ec12..8e0e4a853f9b 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -41,7 +41,8 @@ static int psp_nl_reply_send(struct sk_buff *rsp, struc=
t genl_info *info)
 /* Device stuff */
=20
 static struct psp_dev *
-psp_device_get_and_lock(struct net *net, struct nlattr *dev_id)
+psp_device_get_and_lock(struct net *net, struct nlattr *dev_id,
+			bool unpriv)
 {
 	struct psp_dev *psd;
 	int err;
@@ -56,7 +57,7 @@ psp_device_get_and_lock(struct net *net, struct nlattr =
*dev_id)
 	mutex_lock(&psd->lock);
 	mutex_unlock(&psp_devs_lock);
=20
-	err =3D psp_dev_check_access(psd, net);
+	err =3D psp_dev_check_access(psd, net, unpriv);
 	if (err) {
 		mutex_unlock(&psd->lock);
 		return ERR_PTR(err);
@@ -72,7 +73,20 @@ int psp_device_get_locked(const struct genl_split_ops =
*ops,
 		return -EINVAL;
=20
 	info->user_ptr[0] =3D psp_device_get_and_lock(genl_info_net(info),
-						    info->attrs[PSP_A_DEV_ID]);
+						    info->attrs[PSP_A_DEV_ID],
+						    false);
+	return PTR_ERR_OR_ZERO(info->user_ptr[0]);
+}
+
+int psp_device_get_locked_unpriv(const struct genl_split_ops *ops,
+				 struct sk_buff *skb, struct genl_info *info)
+{
+	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_ID))
+		return -EINVAL;
+
+	info->user_ptr[0] =3D psp_device_get_and_lock(genl_info_net(info),
+						    info->attrs[PSP_A_DEV_ID],
+						    true);
 	return PTR_ERR_OR_ZERO(info->user_ptr[0]);
 }
=20
@@ -160,7 +174,7 @@ static int
 psp_nl_dev_get_dumpit_one(struct sk_buff *rsp, struct netlink_callback *=
cb,
 			  struct psp_dev *psd)
 {
-	if (psp_dev_check_access(psd, sock_net(rsp->sk)))
+	if (psp_dev_check_access(psd, sock_net(rsp->sk), true))
 		return 0;
=20
 	return psp_nl_dev_fill(psd, rsp, genl_info_dump(cb));
@@ -305,7 +319,7 @@ int psp_assoc_device_get_locked(const struct genl_spl=
it_ops *ops,
=20
 	psd =3D psp_dev_get_for_sock(socket->sk);
 	if (psd) {
-		err =3D psp_dev_check_access(psd, genl_info_net(info));
+		err =3D psp_dev_check_access(psd, genl_info_net(info), true);
 		if (err) {
 			psp_dev_put(psd);
 			psd =3D NULL;
@@ -330,7 +344,7 @@ int psp_assoc_device_get_locked(const struct genl_spl=
it_ops *ops,
=20
 		psp_dev_put(psd);
 	} else {
-		psd =3D psp_device_get_and_lock(genl_info_net(info), id);
+		psd =3D psp_device_get_and_lock(genl_info_net(info), id, true);
 		if (IS_ERR(psd)) {
 			err =3D PTR_ERR(psd);
 			goto err_sock_put;
@@ -573,7 +587,7 @@ static int
 psp_nl_stats_get_dumpit_one(struct sk_buff *rsp, struct netlink_callback=
 *cb,
 			    struct psp_dev *psd)
 {
-	if (psp_dev_check_access(psd, sock_net(rsp->sk)))
+	if (psp_dev_check_access(psd, sock_net(rsp->sk), true))
 		return 0;
=20
 	return psp_nl_stats_fill(psd, rsp, genl_info_dump(cb));
--=20
2.47.3



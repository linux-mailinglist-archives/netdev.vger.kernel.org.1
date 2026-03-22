Return-Path: <netdev+bounces-270321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AF/AoE5wGkvFAQAu9opvQ
	(envelope-from <netdev+bounces-270321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 19:48:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C712EA5E0
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 19:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21A63302926C
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 18:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BD0373BF6;
	Sun, 22 Mar 2026 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSqfh1qd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE64207A
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774205243; cv=none; b=VRkl1wI/XV89sQ2nGGKjkNnLucsZT1v08dDsIUCyTev+PPykXJIhC+Mtnh5788avuhRMyCueM2FQfHhjJRdfgiAYzjFRlEkm5a5BFPa71s3XC1IB3HRB/t7MRIUVbT9LPEjGLof0plFe2y3mAPxPtqiS6EujA3jL0BLQJOL/rgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774205243; c=relaxed/simple;
	bh=ri7MVTfLbHHydHRVBmJ+3w97PxdipnKoXYcx6X66erk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D15QXPzcyz+eoZJkMpJyE6HyzgUlJw0ofeCR0yxsI59II/SifEKjBmUoDvEVm4xr35wUBX4xUIzESvwUHQS/zHtk8cceWB1+ZaDD9TO9h5u+2xmdqsnBSuHOl5LyKtb1CsHoaRGWUfA93UDyAcgyNm9GXOos6zCnvB3n3ZwwA9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VSqfh1qd; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1273349c56bso2869853c88.0
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 11:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774205240; x=1774810040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OlvFcN/Un0P/mJ7FSpupSUHVKo//s73OGNqn4ln4iqM=;
        b=VSqfh1qdZVbV2M3Ma4Dh9LFVN1xfF5oHBvLWwuU8IQDwDOPuftJfag/km01VpCFwFn
         AnhP7cqH0N4B53G1s/AN6gQtobPQnfjvWnWLYH7aXaWgsS5o0CIhc8GVIElng+cJcNac
         cLENeLOBHCruOmIsfmNHJqy4wC0U3QoGVQXZ0iw1H5JhHV5VQdXOz0gy2I3NcM2V5Oa+
         sPaGHkovC3Gbr7Dns0PMcs01CfwLpYNeerEGmc/0APZhDP25AkXiPShe2ck0Fj8bwRc6
         b7dfy46D0c5IVTtoe1UZB6GZi3Pkkhf+eKWyy5vZ0XS2JEDtaGZvcPnmlOm8QkSOq8qF
         IXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774205240; x=1774810040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlvFcN/Un0P/mJ7FSpupSUHVKo//s73OGNqn4ln4iqM=;
        b=dGM9gZAU2WiT++FRSkhMqqNpgtWqI1tke5jaeMKA67D9imCuajY/gn9T/gApblAknv
         vVWfPd8gX+sUxUeLkIh+dqxhymTj/VTBtM/BC2QZH2ssDEelUaExABFTQ0noDHyANH9v
         QLkt8mKEdjg2/eaQUnLsizMes8Ks1VXYsex7m/oLH03XAvx8rlcgCCSXDNm6qdfj6/KG
         445VwmdoA0WhEt2g+SESJHOLjsOgKsxhFPSzcwHo1lQdsC1fTEJPPXzfkxIWLxKFeAG/
         4RIFYUtqtsec/I6hX6mumEszb7HZ4vz2Nrp9PpNe171fouyL9er+PE17c8KZfdPCyS6Q
         +w4g==
X-Gm-Message-State: AOJu0YyF2u0tzBOATEET1d1gmGjEDOMssRU21KR//87fYfIR60EGcQMu
	dfxpiMNGhHcjQ8U1RYm/fhSX8oKQGVOv7SUlLOyWdOBVAYRLiKBGN/LPsdOsiG8pp5A=
X-Gm-Gg: ATEYQzztTCj1Gn5hA/FLICPN0reallY2qU3FB+4V1Hes5iG59V/L/lSplrQhPMsh671
	501aV5GNJHpm2NbJrKRCI4vX/WtGGNO8o9/G45nx8Opuez1uQ/o04MSf6OvDcK9TqlPcWML3ECm
	uIPC7fye7qd7GtVgr44kN7grqwM8CEV2NlFDB+oCrTsq12ZZ/5XsX+YoIRAH/2o4AuzRqhD7Eh0
	nQSGI+kYhrMJrSOgtVtiY1uMladWE4tOjO8rXUZkY5QDALcOrVBwkzROX5VrWqGu20LddA+fKT3
	phpdBlrb68H1qNLEslKKYp/UoPk1dWPgl8zQ+fy4SNHz5+gOSZSCcVkaJJlu0/6/F6lljuF6hsS
	kmEG7r0pwQjS035J8gWX78u2/GSltQmB+6QnBlz9J1lXazGZTipHQ9vDRPVb4KVvl+lxL9Q9ZhB
	H8HDd5yZSZXqBvdYYjyIBt8U2QHyOilMjKQgdgXRrGgzFSNDzMTC13sM8=
X-Received: by 2002:a05:7022:31f:b0:127:5cfe:1ee0 with SMTP id a92af1059eb24-12a726b2844mr4288501c88.21.1774205240287;
        Sun, 22 Mar 2026 11:47:20 -0700 (PDT)
Received: from 59989e37b1d1.cs.ucr.edu (colossus.cs.ucr.edu. [169.235.26.233])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a734bb33fsm7579845c88.9.2026.03.22.11.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 11:47:20 -0700 (PDT)
From: Zhengchuan Liang <zcliangcn@gmail.com>
To: netdev@vger.kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	shinta.sugimoto@ericsson.com,
	nakam@linux-ipv6.org,
	yoshfuji@linux-ipv6.org,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	lx24@stu.ynu.edu.cn
Subject: [PATCH net] net: af_key: zero aligned sockaddr tail in PF_KEY exports
Date: Sun, 22 Mar 2026 11:46:08 -0700
Message-ID: <20260322184608.1048146-1-zcliangcn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270321-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,ericsson.com,linux-ipv6.org,gmail.com,lzu.edu.cn,stu.ynu.edu.cn];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_NEQ_ENVFROM(0.00)[zcliangcn@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ynu.edu.cn:email,lzu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59C712EA5E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PF_KEY export paths use `pfkey_sockaddr_size()` when reserving sockaddr
payload space, so IPv6 addresses occupy 32 bytes on the wire. However,
`pfkey_sockaddr_fill()` initializes only the first 28 bytes of
`struct sockaddr_in6`, leaving the final 4 aligned bytes uninitialized.

Not every PF_KEY message is affected. The state and policy dump builders
already zero the whole message buffer before filling the sockaddr
payloads. Keep the fix to the export paths that still append aligned
sockaddr payloads with plain `skb_put()`:

  - `SADB_ACQUIRE`
  - `SADB_X_NAT_T_NEW_MAPPING`
  - `SADB_X_MIGRATE`

Fix those paths by clearing only the aligned sockaddr tail after
`pfkey_sockaddr_fill()`.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of endpoint address(es)")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Xiao Liu <lx24@stu.ynu.edu.cn>
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
---
 net/key/af_key.c | 52 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 0756bac62f7c0..f3f8f3c15a940 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -757,6 +757,22 @@ static unsigned int pfkey_sockaddr_fill(const xfrm_address_t *xaddr, __be16 port
 	return 0;
 }
 
+static unsigned int pfkey_sockaddr_fill_zero_tail(const xfrm_address_t *xaddr,
+						  __be16 port,
+						  struct sockaddr *sa,
+						  unsigned short family)
+{
+	unsigned int prefixlen;
+	int sockaddr_len = pfkey_sockaddr_len(family);
+	int sockaddr_size = pfkey_sockaddr_size(family);
+
+	prefixlen = pfkey_sockaddr_fill(xaddr, port, sa, family);
+	if (sockaddr_size > sockaddr_len)
+		memset((u8 *)sa + sockaddr_len, 0, sockaddr_size - sockaddr_len);
+
+	return prefixlen;
+}
+
 static struct sk_buff *__pfkey_xfrm_state2msg(const struct xfrm_state *x,
 					      int add_keys, int hsc)
 {
@@ -3206,9 +3222,9 @@ static int pfkey_send_acquire(struct xfrm_state *x, struct xfrm_tmpl *t, struct
 	addr->sadb_address_proto = 0;
 	addr->sadb_address_reserved = 0;
 	addr->sadb_address_prefixlen =
-		pfkey_sockaddr_fill(&x->props.saddr, 0,
-				    (struct sockaddr *) (addr + 1),
-				    x->props.family);
+		pfkey_sockaddr_fill_zero_tail(&x->props.saddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      x->props.family);
 	if (!addr->sadb_address_prefixlen)
 		BUG();
 
@@ -3221,9 +3237,9 @@ static int pfkey_send_acquire(struct xfrm_state *x, struct xfrm_tmpl *t, struct
 	addr->sadb_address_proto = 0;
 	addr->sadb_address_reserved = 0;
 	addr->sadb_address_prefixlen =
-		pfkey_sockaddr_fill(&x->id.daddr, 0,
-				    (struct sockaddr *) (addr + 1),
-				    x->props.family);
+		pfkey_sockaddr_fill_zero_tail(&x->id.daddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      x->props.family);
 	if (!addr->sadb_address_prefixlen)
 		BUG();
 
@@ -3421,9 +3437,9 @@ static int pfkey_send_new_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr,
 	addr->sadb_address_proto = 0;
 	addr->sadb_address_reserved = 0;
 	addr->sadb_address_prefixlen =
-		pfkey_sockaddr_fill(&x->props.saddr, 0,
-				    (struct sockaddr *) (addr + 1),
-				    x->props.family);
+		pfkey_sockaddr_fill_zero_tail(&x->props.saddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      x->props.family);
 	if (!addr->sadb_address_prefixlen)
 		BUG();
 
@@ -3443,9 +3459,9 @@ static int pfkey_send_new_mapping(struct xfrm_state *x, xfrm_address_t *ipaddr,
 	addr->sadb_address_proto = 0;
 	addr->sadb_address_reserved = 0;
 	addr->sadb_address_prefixlen =
-		pfkey_sockaddr_fill(ipaddr, 0,
-				    (struct sockaddr *) (addr + 1),
-				    x->props.family);
+		pfkey_sockaddr_fill_zero_tail(ipaddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      x->props.family);
 	if (!addr->sadb_address_prefixlen)
 		BUG();
 
@@ -3474,15 +3490,15 @@ static int set_sadb_address(struct sk_buff *skb, int sasize, int type,
 	switch (type) {
 	case SADB_EXT_ADDRESS_SRC:
 		addr->sadb_address_prefixlen = sel->prefixlen_s;
-		pfkey_sockaddr_fill(&sel->saddr, 0,
-				    (struct sockaddr *)(addr + 1),
-				    sel->family);
+		pfkey_sockaddr_fill_zero_tail(&sel->saddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      sel->family);
 		break;
 	case SADB_EXT_ADDRESS_DST:
 		addr->sadb_address_prefixlen = sel->prefixlen_d;
-		pfkey_sockaddr_fill(&sel->daddr, 0,
-				    (struct sockaddr *)(addr + 1),
-				    sel->family);
+		pfkey_sockaddr_fill_zero_tail(&sel->daddr, 0,
+					      (struct sockaddr *)(addr + 1),
+					      sel->family);
 		break;
 	default:
 		return -EINVAL;
-- 
2.43.0



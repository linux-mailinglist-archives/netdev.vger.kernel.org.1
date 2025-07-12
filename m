Return-Path: <netdev+bounces-206363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CF9B02CDD
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A151AA569F
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D52E223336;
	Sat, 12 Jul 2025 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wqF81GAg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9161FE44B
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352523; cv=none; b=BRugtn+ZSaPOzdkgIIKoEvBtqEx4VaUHoa957tMCGc6SweQjbcSUeZuuBZ6VpRUVoRar7x5B4wvtPeqeYjrc1wzcnjMGY4Y+5uQRSxFHS1CXS3o7pFLIMoPKM8R6GiAV8411DJbxtmhtzU8oj+nILsLQVq1pGnumaQFVsmCGP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352523; c=relaxed/simple;
	bh=ghAfaxk/rm2z6aYmN0Uqe0VOXHRzawxWt5mifyumHX4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cgJ6bxJXcTc10DGUdh6v+AErPtaXcayQ8N+IjMRhE+zC6l/c1C19sALXhUNAInIt/ZPNuRYseIlVZ0HzO8eDqaTtZ6QFyZhQHQYAiof3dv8bH5lVY7WKTzuo03Qv9pDFXCXtDHf1h6073J6AdI6LMpwTcdtc2QALd96Mc+3QQXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wqF81GAg; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b3beafa8d60so66868a12.3
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352521; x=1752957321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k9qm4lDL4MXYf6qhkJb4jl30W1kGNhheapByVfGSVG0=;
        b=wqF81GAg2N7NYFkdQzaRLQidav2ZTnzcWmgPlaX5TEEwzZ/540lwYA7PIOO+QHduZJ
         Mr+YyJVsh2tkXdfyir1dQU2J9Xu/iUKb8jDwNRmBRdlgjMlNBTubJdA4ruU5Y2EG8Yfu
         qux21dz496iLvah3hHqOxXySFlnVHN2moTN653Zr5QRBXuPdu9q+sN67js9rQ5G7YxA0
         9KTcRYkW+gHkjZ4iy+mUCT3jtzWb+12kyE5ccmdd/KWy0FT6KjUqC0sxOxG2cspaBrQV
         nUpoMQDXef++0TjOPjBYHtNkhCwsEuUEggF8sLtVtG39xZIqYCCV2N6h5YDngT1SwA4O
         pwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352521; x=1752957321;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9qm4lDL4MXYf6qhkJb4jl30W1kGNhheapByVfGSVG0=;
        b=sfCKF5Rj71e5BWs2HqvKfroGNqTEpOEBMoCUFLFH1Qvi/M1hsl7by/vg+yr3mjk2rJ
         Mesdi4Zcuy9Vxko9DQjHfaQC45nr4EZGdEyYlpMjslCryFP51LN1O5duK8BJguNY2k1t
         xQhmPSFKHcrgWCWmnXlkqnBCG/ziHECtvQK5MkAc1Nw/5nSStFzH5WwG2pY/er6iQBla
         1fJHTpjp1Ld2TSjCTRXmGa/uSDAZP2jT76N5S2XOkQYDS/Vu+g4RjBz5lgpiO2cF7Y0g
         dPBkRmxf74CC0vU9rCzvnpG/1LdfzQiZmx9WpCuR1pGOc38rDGnGYZy6ttM1rNl2jbsn
         4dhw==
X-Forwarded-Encrypted: i=1; AJvYcCXQmtFyWUrbInsrIVCTtVUZRKlNvboZJtFZVYgJSkATPMFa+vYNABUQ/vrVLYFKSXpPYwxw0Hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNRX1N8S6OHz5Js8b8hPtEzU19kZFPSA7mhCPrGg44HUxg5S8A
	qm9Poy4+LczOBDH7hAaZXAMeN6Yo46ropy8fNRoStC0BoJ2wGpLy7BzJHAQZ/N7VQHsj7qqK4IX
	xVPgMsQ==
X-Google-Smtp-Source: AGHT+IE/XjET5/Iiku2d9zTEOej1g7Tk2RxhG7oTZTWqer6AYJfsM1fx/ZPTsPIVZGcKzz5RMnoGW34HDrQ=
X-Received: from pfbhs11.prod.google.com ([2002:a05:6a00:690b:b0:746:e33e:7245])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3291:b0:233:84b4:d0a4
 with SMTP id adf61e73a8af0-23384b4d575mr2849474637.32.1752352520866; Sat, 12
 Jul 2025 13:35:20 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:10 +0000
In-Reply-To: <20250712203515.4099110-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 01/15] neighbour: Make neigh_valid_get_req()
 return ndmsg.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

neigh_get() passes 4 local variable pointers to neigh_valid_get_req().

If it returns a pointer of struct ndmsg, we do not need to pass two
of them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 51 +++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 43a5dcbb5f9c7..d35399de640d0 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2910,10 +2910,9 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	return err;
 }
 
-static int neigh_valid_get_req(const struct nlmsghdr *nlh,
-			       struct neigh_table **tbl,
-			       void **dst, int *dev_idx, u8 *ndm_flags,
-			       struct netlink_ext_ack *extack)
+static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
+					 struct neigh_table **tbl, void **dst,
+					 struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[NDA_MAX + 1];
 	struct ndmsg *ndm;
@@ -2922,31 +2921,33 @@ static int neigh_valid_get_req(const struct nlmsghdr *nlh,
 	ndm = nlmsg_payload(nlh, sizeof(*ndm));
 	if (!ndm) {
 		NL_SET_ERR_MSG(extack, "Invalid header for neighbor get request");
-		return -EINVAL;
+		err = -EINVAL;
+		goto err;
 	}
 
 	if (ndm->ndm_pad1  || ndm->ndm_pad2  || ndm->ndm_state ||
 	    ndm->ndm_type) {
 		NL_SET_ERR_MSG(extack, "Invalid values in header for neighbor get request");
-		return -EINVAL;
+		err = -EINVAL;
+		goto err;
 	}
 
 	if (ndm->ndm_flags & ~NTF_PROXY) {
 		NL_SET_ERR_MSG(extack, "Invalid flags in header for neighbor get request");
-		return -EINVAL;
+		err = -EINVAL;
+		goto err;
 	}
 
 	err = nlmsg_parse_deprecated_strict(nlh, sizeof(struct ndmsg), tb,
 					    NDA_MAX, nda_policy, extack);
 	if (err < 0)
-		return err;
+		goto err;
 
-	*ndm_flags = ndm->ndm_flags;
-	*dev_idx = ndm->ndm_ifindex;
 	*tbl = neigh_find_table(ndm->ndm_family);
-	if (*tbl == NULL) {
+	if (!*tbl) {
 		NL_SET_ERR_MSG(extack, "Unsupported family in header for neighbor get request");
-		return -EAFNOSUPPORT;
+		err = -EAFNOSUPPORT;
+		goto err;
 	}
 
 	for (i = 0; i <= NDA_MAX; ++i) {
@@ -2957,17 +2958,21 @@ static int neigh_valid_get_req(const struct nlmsghdr *nlh,
 		case NDA_DST:
 			if (nla_len(tb[i]) != (int)(*tbl)->key_len) {
 				NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
-				return -EINVAL;
+				err = -EINVAL;
+				goto err;
 			}
 			*dst = nla_data(tb[i]);
 			break;
 		default:
 			NL_SET_ERR_MSG(extack, "Unsupported attribute in neighbor get request");
-			return -EINVAL;
+			err = -EINVAL;
+			goto err;
 		}
 	}
 
-	return 0;
+	return ndm;
+err:
+	return ERR_PTR(err);
 }
 
 static inline size_t neigh_nlmsg_size(void)
@@ -3038,18 +3043,16 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	struct net_device *dev = NULL;
 	struct neigh_table *tbl = NULL;
 	struct neighbour *neigh;
+	struct ndmsg *ndm;
 	void *dst = NULL;
-	u8 ndm_flags = 0;
-	int dev_idx = 0;
 	int err;
 
-	err = neigh_valid_get_req(nlh, &tbl, &dst, &dev_idx, &ndm_flags,
-				  extack);
-	if (err < 0)
-		return err;
+	ndm = neigh_valid_get_req(nlh, &tbl, &dst, extack);
+	if (IS_ERR(ndm))
+		return PTR_ERR(ndm);
 
-	if (dev_idx) {
-		dev = __dev_get_by_index(net, dev_idx);
+	if (ndm->ndm_ifindex) {
+		dev = __dev_get_by_index(net, ndm->ndm_ifindex);
 		if (!dev) {
 			NL_SET_ERR_MSG(extack, "Unknown device ifindex");
 			return -ENODEV;
@@ -3061,7 +3064,7 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
-	if (ndm_flags & NTF_PROXY) {
+	if (ndm->ndm_flags & NTF_PROXY) {
 		struct pneigh_entry *pn;
 
 		pn = pneigh_lookup(tbl, net, dst, dev, 0);
-- 
2.50.0.727.gbf7dc18ff4-goog



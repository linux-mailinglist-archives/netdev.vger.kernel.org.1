Return-Path: <netdev+bounces-206370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3ECB02CE4
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1194B4E1547
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727C922B8CF;
	Sat, 12 Jul 2025 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4v3cmrW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AF922A7E8
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352532; cv=none; b=GOWpW2h4vnq35J2sL4zODVZABYmxqaau/qY3so5Zfp1qrd1lmRY5uAxs5jYmHV6JmIWYDmuTFIeprryPmwSFdCUf4vPLlXCOcso/XSqvxcfujZarDzbhnKeHT3cxSz4veq8qkVp7uN0C4XQilfHMMcoaHAvbx5sdncs1jcOQSZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352532; c=relaxed/simple;
	bh=fauz/V1FWW/LUKO5lwiNkB93eYfomnRwQ9wxAQlkNLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qGwM6NJ35USwenUZFg3I7RTrvLRZL50aZbMSi5CoXlmRnvP84ZfSA1zqYnosi1z0kBkUvqQKAsrGvfOkdAzOx9QQyFsEnZeC4oGPdzKDLRMHi8rWMsV6NtlUMrOLKL3+5ZG74XI2GHxZIQVNCvCr+D9kXrOVQdd4ZK2ojrBOKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4v3cmrW; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313d6d671ffso2858592a91.2
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352530; x=1752957330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9k2r84CY+fJpMC4JnK8dcnRpi9ycUpEJtGKqYvT4S1Y=;
        b=g4v3cmrWbiojcjjfwkdYKVNSME2naUIeCCAG+jbCgCaRQrWRpPCiosmHVq47OShRoi
         E3MdTMdVb8LimxvbnDyK5SN/kHr71CL8lZGx3+UZYiwhVUCwiuwI/MFAalA8KWmgiJ/h
         JsudPKg52sBjmr6VKNT0dJEI057EKIyvWgUCcRrf3wsxyZEZNO03hakWyEcGlWDNFr2C
         5dxytLaDPjsIEYwYWf7pDeBT/6ICV6cOpI+90KNViQ3gIt+4vAF+IwSbID/gimg/yhn9
         Gn2JHHipkT7l96mwKIT0SATyU2k7FcXqJpYWDYSqL/4AIcO+daRJ8p6mXVBv3W+yP+Qq
         S+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352530; x=1752957330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9k2r84CY+fJpMC4JnK8dcnRpi9ycUpEJtGKqYvT4S1Y=;
        b=EvGAqpkaUK60RI+vd8xkuuaqtYWpTKxqwGl0lTDqEnm8OHKGJkRR/fmWn7u9VvodL4
         Ea1pkJ5IizfIRhzL5SbhyBVRsw15BbnHYxOrWxzC7zn3UhzVWUjNy7AUNKNZUqYa/YrN
         n7g20wFjsJMmx4PvdqF17gaSDZCzbdPol2cBzIYR0NKQMgwPiqPuIj6TfmLygViOIXBN
         g1kLn0IUEQV+4+xZQQFcxzMN2X6+a88kMBgzdcUHE70goPB9dU7p28gAlqhkt1ZGvkaW
         iotQOd2xZmSGrqUr0UQRR1/GKCGSu+Fgj7xMP0VkpIEJ+ROZRPQbPcJs495ptjj034Za
         PDOA==
X-Forwarded-Encrypted: i=1; AJvYcCXBCyB4bvt2tOISCguxYx02i2OMrjmyn7jlWWCiqJdtX5wJ3FaYleUltEF0/q8UraOstb26Dj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94ABJavaPEOVMl8GZbsiji9OZmhUsXDR8hXxF8AWfvchc8gf/
	uQnsCTVLwiTzpCQke5Y4xseCxZ7/t3VbC87TZVtpsfuVH637m4BJVPspqQPlbLnhgs1jE+tp3gU
	Baulp5w==
X-Google-Smtp-Source: AGHT+IET8u/LfuS34u+nOtYaWqf3ek7Hi5iX2G0uWPn2m4XP3ApyYTv7NVVUDoi7L6C8H+58m7dMLHqh7pM=
X-Received: from pjbrr7.prod.google.com ([2002:a17:90b:2b47:b0:311:f309:e314])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d88:b0:311:b3e7:fb3c
 with SMTP id 98e67ed59e1d1-31c50e4664bmr9156785a91.31.1752352530387; Sat, 12
 Jul 2025 13:35:30 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:17 +0000
In-Reply-To: <20250712203515.4099110-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-9-kuniyu@google.com>
Subject: [PATCH v2 net-next 08/15] neighbour: Annotate access to struct pneigh_entry.{flags,protocol}.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will convert pneigh readers to RCU, and its flags and protocol
will be read locklessly.

Let's annotate the access to the two fields.

Note that all access to pn->permanent is under RTNL (neigh_add()
and pneigh_ifdown_and_unlock()), so WRITE_ONCE() and READ_ONCE()
are not needed.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 6f688b643c82b..b8562c6c3e8ef 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2044,10 +2044,10 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = -ENOBUFS;
 		pn = pneigh_create(tbl, net, dst, dev);
 		if (pn) {
-			pn->flags = ndm_flags;
+			WRITE_ONCE(pn->flags, ndm_flags);
 			pn->permanent = !!(ndm->ndm_state & NUD_PERMANENT);
 			if (protocol)
-				pn->protocol = protocol;
+				WRITE_ONCE(pn->protocol, protocol);
 			err = 0;
 		}
 		goto out;
@@ -2683,8 +2683,9 @@ static int pneigh_fill_info(struct sk_buff *skb, struct pneigh_entry *pn,
 	if (nlh == NULL)
 		return -EMSGSIZE;
 
-	neigh_flags_ext = pn->flags >> NTF_EXT_SHIFT;
-	neigh_flags     = pn->flags & NTF_OLD_MASK;
+	neigh_flags = READ_ONCE(pn->flags);
+	neigh_flags_ext = neigh_flags >> NTF_EXT_SHIFT;
+	neigh_flags &= NTF_OLD_MASK;
 
 	ndm = nlmsg_data(nlh);
 	ndm->ndm_family	 = tbl->family;
@@ -2698,7 +2699,7 @@ static int pneigh_fill_info(struct sk_buff *skb, struct pneigh_entry *pn,
 	if (nla_put(skb, NDA_DST, tbl->key_len, pn->key))
 		goto nla_put_failure;
 
-	if (pn->protocol && nla_put_u8(skb, NDA_PROTOCOL, pn->protocol))
+	if (pn->protocol && nla_put_u8(skb, NDA_PROTOCOL, READ_ONCE(pn->protocol)))
 		goto nla_put_failure;
 	if (neigh_flags_ext && nla_put_u32(skb, NDA_FLAGS_EXT, neigh_flags_ext))
 		goto nla_put_failure;
-- 
2.50.0.727.gbf7dc18ff4-goog



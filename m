Return-Path: <netdev+bounces-206238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 154D4B02446
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558CE16B85F
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E8F2F2737;
	Fri, 11 Jul 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="prjAKdSK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68172F2363
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261017; cv=none; b=PTZAjgDOVRzlkvMX4B5r70RL2JgMabiNqG7r5msIZDyQp+kvrI79BO+noCWPynRmIYBRXwzlQAHOqk/6IzLpbjOwyxXQGkfn3pSsg5yXHPM05uR5LDsQjR+35LO18LZuF35mByFQLtAD+iyHFQTidwaIBSYnhc4Ocf8yLeDvwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261017; c=relaxed/simple;
	bh=efEqm6LuvaPz+nlEkruVz/952mjxWhAu4ol4Q1ZTIvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=azcn50SAsdc00ZK0PPN7OYTJ3DfFwONB1ECeIPDX5sKSV1HWj0FDmjgohiM7v8IAHUXLF9PyIa+k385lyvLGPXRxi/xEipRWanjpf1CDgA7ySbqKr43B/IsXdJLdYJKTD/tttK9cfu+HwpNCm2Z8cy8JbUTYwDEoL7idBJgoos0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=prjAKdSK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so4301109a91.2
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752261015; x=1752865815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FtOVcgAy6/fBE+D4GvNRvO+lO7uWfIARwsK0pweRohk=;
        b=prjAKdSKiDLQ2c497b+RjwHRrPSn+0W8L/ecCyoI5zgMCv7LCzuylijwRfZYO5XwKL
         0sMW9muI7XfIZ0hcXN7vjROfA6iPNVxDds9DmgR17frOySACOvNoth4eDgmGboVZjMa9
         Sq9+xKX3W7eM5x/BbbvX1KbKAVHSK4eqRTYx6XdM1011ReZDbIZDvd5c5M9A8l7sDrAA
         hE/w4tDc4L7vy0HGtb2IQU5M029z3dHcsSyA+fJq1XkhCQOrFnvO/INtPgvmpCbJAv99
         VqmPetCqrcvQRzbKCFnNbt31BfGjdXbGfJD4+aXbjCQ+UKU9SXE0ireva4PrxTo8VFND
         LGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261015; x=1752865815;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FtOVcgAy6/fBE+D4GvNRvO+lO7uWfIARwsK0pweRohk=;
        b=kj25ODemtMc4j3K03oqv8Cm/RNej87tSde5/J+O5V4L7OAEBL10kCTWw/ch2AQjy96
         THj3GJqDUASkWSLA8cj7RrjxYayPt5WC6QnuQ30mJgAX6nfeldbkIeJQbNgcVWSAk6Xk
         BeCULCxNhlLF+v7+3epFneAOT029gJzfCfA4NQ9L4iFj1y5zDH/XK9jBad5lKCaoL9r3
         kJ6GngyNXP/i6/lUD9O156j4OAxQC25525drGG+q7IDAEkdCm2Ty7kUtIc4JYWv9Q+Bd
         5IvjrjlOBDICHQYg9tcu8FTmWz87Ar1pr+jO0nkcOMq2i5dBk+4/m3Nm2cdYiVuT6o3Q
         XZxA==
X-Forwarded-Encrypted: i=1; AJvYcCUjZQslTuinoM6DFQXD75ELF7sVBR3H6CigmBWM2KpQOYaGttFJ3nTR8poqQv0jYQ8MEXYcBEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0H0AJrp9mOBYVIRFt2jiQwyjiagYWsGb573P3nmswzBcizcpS
	oGN698s81JYn4cxU7oA5hMieLJ6vr8nael8MsZ51BEw04SUcjVSMy+S+k9TBT+XFYEMur0GVnqi
	LdMPlMA==
X-Google-Smtp-Source: AGHT+IGmNJ7b5MGoUjpi/ab1UrQ/pE80e9U6l97V8ZoNX7C5a1E02T1A0cZ+0KXK39ultTcAw74vBYWt584=
X-Received: from pjbeu14.prod.google.com ([2002:a17:90a:f94e:b0:313:2d44:397b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ecb:b0:311:f99e:7f4a
 with SMTP id 98e67ed59e1d1-31c4ccedab5mr6225649a91.26.1752261014996; Fri, 11
 Jul 2025 12:10:14 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:06:07 +0000
In-Reply-To: <20250711191007.3591938-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711191007.3591938-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711191007.3591938-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 02/14] neighbour: Move two validations from
 neigh_get() to neigh_valid_get_req().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will remove RTNL for neigh_get() and run it under RCU instead.

neigh_get() returns -EINVAL in the following cases:

  * NDA_DST is not specified
  * Both ndm->ndm_ifindex and NTF_PROXY are not specified

These validations do not require RCU.

Let's move them to neigh_valid_get_req().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/neighbour.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index d35399de640d0..2c3e0f3615e20 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2938,6 +2938,12 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 		goto err;
 	}
 
+	if (!(ndm->ndm_flags & NTF_PROXY) && !ndm->ndm_ifindex) {
+		NL_SET_ERR_MSG(extack, "No device specified");
+		err = -EINVAL;
+		goto err;
+	}
+
 	err = nlmsg_parse_deprecated_strict(nlh, sizeof(struct ndmsg), tb,
 					    NDA_MAX, nda_policy, extack);
 	if (err < 0)
@@ -2951,11 +2957,14 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 	}
 
 	for (i = 0; i <= NDA_MAX; ++i) {
-		if (!tb[i])
-			continue;
-
 		switch (i) {
 		case NDA_DST:
+			if (!tb[i]) {
+				NL_SET_ERR_MSG(extack, "Network address not specified");
+				err = -EINVAL;
+				goto err;
+			}
+
 			if (nla_len(tb[i]) != (int)(*tbl)->key_len) {
 				NL_SET_ERR_MSG(extack, "Invalid network address in neighbor get request");
 				err = -EINVAL;
@@ -2964,6 +2973,9 @@ static struct ndmsg *neigh_valid_get_req(const struct nlmsghdr *nlh,
 			*dst = nla_data(tb[i]);
 			break;
 		default:
+			if (!tb[i])
+				continue;
+
 			NL_SET_ERR_MSG(extack, "Unsupported attribute in neighbor get request");
 			err = -EINVAL;
 			goto err;
@@ -3059,11 +3071,6 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	if (!dst) {
-		NL_SET_ERR_MSG(extack, "Network address not specified");
-		return -EINVAL;
-	}
-
 	if (ndm->ndm_flags & NTF_PROXY) {
 		struct pneigh_entry *pn;
 
@@ -3076,11 +3083,6 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 					nlh->nlmsg_seq, tbl);
 	}
 
-	if (!dev) {
-		NL_SET_ERR_MSG(extack, "No device specified");
-		return -EINVAL;
-	}
-
 	neigh = neigh_lookup(tbl, dst, dev);
 	if (!neigh) {
 		NL_SET_ERR_MSG(extack, "Neighbour entry not found");
-- 
2.50.0.727.gbf7dc18ff4-goog



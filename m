Return-Path: <netdev+bounces-182975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D12DA8A7F4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6721903247
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FEB24E4CE;
	Tue, 15 Apr 2025 19:29:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E850624CEF9;
	Tue, 15 Apr 2025 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745355; cv=none; b=q/KL4Xuja4QXJ1J7BjTgXfT+5JmFoP3ovOA4fovHl+jx+WqFYwAVqVJI+DSg6Euv6vGEMROXCUtgb5Cn5+uEFXuCpnIA2xeUm6p3HFIGlHsKUsnXx889BDVqUOV0BSGFhuirI+jtwGP+WrLicJY43R8camSZe/4xKkbj+cS16Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745355; c=relaxed/simple;
	bh=+CFJmN6F/h1aJVdMxgj887nK2pULtHmK36nsWYuGQS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZdvOXBRhjVaeOE593D+1WPUk31W54Q/Ev0c6yqAZ9Fc30dvkuP2QAAS97CKUY1TLFCZ8FLt4DyDvI+8LHNuqZqYuRA35Je8m6yAGgTP3BpbapjxftLpe2tqTnkQdUvKFk8D73fC4299np6qbhb/OthwJc/zkjln+joxTOf6RZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2c663a3daso1093966266b.2;
        Tue, 15 Apr 2025 12:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744745352; x=1745350152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLFwV78SmluYq1I05RcZImjhpchW7U2CdM/dSOpLYS4=;
        b=qRG+Wfzel+MzkG+Q8RW2EOi2dPm9Ypl+5g/eb2QSkdE9BsdkU+uiJWQf6EH4YBWqe+
         xL0Eh30Pp+vqd5g+4vZbIdQbYpmsIcJB8rcCF/+VEtT4LoVA9duosKPJNlqDKFoT9HzU
         4veWW9iXmiWModtfBF26IP7alx1dCaoPKuWCFzXoSY5ndl5LPCShaKSVca/oqH79II0g
         LRCv7a2amHObEbOivxJvM3AvXdhgqlPSfwPGUwk+ySZ7R+IgddmBgi+z6fo45/GT4WGW
         uvcuTfD5+PnnWzjls/POF84mcV2PeTLdRo2u7BKD2jRf/GAUbb4aluhD2ZI4i4nfrvoD
         H2sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUnhPG7wvsQ6G8lHx/W9ChoG/ofWiK7L2mlcYJsvNWUV+Dt3RIpEKslU+xsGusBceZrKdgauSXw2YJsPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxvu/8+ladklgHkBH1tnNAZ63CJBuNiAwO6Z7oyD4YZo3VS4Jw
	v6YL/vKYQNE0nrnAVQFehlT0h3T2lgkljiqj1DAt/reOzaDG+eIMS25Xdw==
X-Gm-Gg: ASbGncsKRgXJm+5dJraC7JhtUwksu3hum9+U7DjLDN9wfBMdfTCG56GFx+/UX7nLId3
	7/EO5Eh/+A/aEVrd5eqLk5noI6sEWyyjm1T3PBASiBPNWsMuRXUGZvZQqlZhFJ6r3NrJLk8y1pl
	HJBiy51KZ4Y9jlZz4zmHwvM2rOeCgOXWwUCXEiHkRawuYFoH812TWCKBzixr7sTPueYV79W0VUD
	NLWH1sn589oVvnsJ4f6iHVvYP3YhEjj2m+iT8g7hz0119HJgBa0eEO43OZWZ73ncXXUSm3oOYCh
	Dr7E2KPjcCRqNM/HRAJS6R890EErR9c=
X-Google-Smtp-Source: AGHT+IE37E3kuW2dwBus5vXSASWM32Hama/1q+on3F4tb/DE0fxr68G1f0FBPYvl7x58VNfnRgiWnA==
X-Received: by 2002:a17:907:6d21:b0:ac7:c79d:f8ce with SMTP id a640c23a62f3a-acb38546358mr24110666b.57.1744745351949;
        Tue, 15 Apr 2025 12:29:11 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f5056b9sm7071425a12.51.2025.04.15.12.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:29:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Apr 2025 12:28:54 -0700
Subject: [PATCH net-next 3/8] ipv6: Use nlmsg_payload in route file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-nlmsg_v2-v1-3-a1c75d493fd7@debian.org>
References: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
In-Reply-To: <20250415-nlmsg_v2-v1-0-a1c75d493fd7@debian.org>
To: kuniyu@amazon.com, "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=leitao@debian.org;
 h=from:subject:message-id; bh=+CFJmN6F/h1aJVdMxgj887nK2pULtHmK36nsWYuGQS4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn/rOBYh6m6RQqlP3zSzn7IwObS8A1BIkD4oq0A
 T0LPoG35/aJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/6zgQAKCRA1o5Of/Hh3
 bR4LD/43fZnIncBLXVH0CUSEPwW+W4bGFbdYvsn4k5TYHONgzdPBRS8YPdGs9FFAW4HDLX2C4me
 VISBoLeNYDVE7sh78pT9U9WMYLuEYNJfSSyTEOmoH79a5++dUD3mNOlZ3KM6hiWSrlL22d1o4hR
 avfVvdSEAvf7c7RwDpRQ7t8g9zORwk6tzUZSuo6wK9cSeDSnSnlxyzWvpF8oq7RANennaoritMi
 fPFmOOLrCYLf/OZo0G7Wz8o2bhRMNnBrT3TuBhTXJaGEXmoJ7iAW7e96oVN4noMD/k/dP60zN1Q
 5HriegLn7cmgke53JiI/Z6QxddQWEVTZceaQ9Dsn6uPkBiEUxVgN2hEzrVHhouwX1h4ZBS0KAi+
 N+GdXAnwGLxuU97HGw6v+18nZcZPh4Qpyaz524qs4OY4HvuuDQG2tKJ6kN8PfFJsDaHGTcrfTQz
 JM79ckTZjsYpozuhp0u7bwn8tn95+uR9FFn+LMMrbFGZ5NGgZx/04SYGjEUF8UkFBvIS2jke0rM
 gC91nXRS+KG0crfgi3zkzl3Bpf48LKu8IZu0+Jb3AJqKlrdp+z9r5TI5ClZeArAh8g6QXI1S1cN
 0St3RTovftihk60MzY8rwkJH94VG2Ur0zKr6VRkPVUTwIlehoHdv/J7gZqlTYCIGdTMu5XPQrAW
 v3ScO31Xyan76nA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Leverage the new nlmsg_payload() helper to avoid checking for message
size and then reading the nlmsg data.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv6/route.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 210b84cecc242..e2c6c0b0684b2 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6029,7 +6029,8 @@ static int inet6_rtm_valid_getroute_req(struct sk_buff *skb,
 	struct rtmsg *rtm;
 	int i, err;
 
-	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*rtm))) {
+	rtm = nlmsg_payload(nlh, sizeof(*rtm));
+	if (!rtm) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Invalid header for get route request");
 		return -EINVAL;
@@ -6039,7 +6040,6 @@ static int inet6_rtm_valid_getroute_req(struct sk_buff *skb,
 		return nlmsg_parse_deprecated(nlh, sizeof(*rtm), tb, RTA_MAX,
 					      rtm_ipv6_policy, extack);
 
-	rtm = nlmsg_data(nlh);
 	if ((rtm->rtm_src_len && rtm->rtm_src_len != 128) ||
 	    (rtm->rtm_dst_len && rtm->rtm_dst_len != 128) ||
 	    rtm->rtm_table || rtm->rtm_protocol || rtm->rtm_scope ||

-- 
2.47.1



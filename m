Return-Path: <netdev+bounces-109972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A92D92A8D5
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA2C8B20969
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51F914900B;
	Mon,  8 Jul 2024 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="hXRjdcdH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F028A28EF
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462559; cv=none; b=vDlwYzj2/1QSwpAQv0/pv3/Hdk9gECqtBGhSjq2JHNsTFNPMjlnUu4UW1iXifa2y3O/DZGLQ1tMpRUKx7vNqidamV1P1XRAMXOAtzNKhlLP/VxQPfF9rMd1zYfx3YiSs5p9D7j4OIJogz13RZnVSt4KfAWFEfnBQVEOyzz0lve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462559; c=relaxed/simple;
	bh=ibX4c5HkiZ3iw5b7jPJhH6vG8JD5H5pnTuVXtda0FQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slWOHo9Yh0KCyMbhfkbVii5CJDGrga65NuwGsQ3618VC2+EEDFay/X6S4ZBTo/BAJsswvdxsSgA9m37ee8MSB16goumwjoLfXstw8Stwm4KgHFzS5IJR2FRWlFBzyiKF3VyQPID1Q5sLMs9wArYgrIbFLRscx6TYhkMt0xuNxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=hXRjdcdH; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-4266edee10cso3418375e9.2
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 11:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720462556; x=1721067356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+/8q0n9zIZuPd8v8xe46w2FL6quvs2/a1bhvxAdF2Y=;
        b=hXRjdcdHmxm/tcHT0sBlC684I1RGpJA+OZtDlBl/w1Pf91zHUzaPAGpLZEA3GBX5NH
         mLbIbUV9QKtHy7YxrCtktnVPYPIu68DnvTFSkkfhEQCAQkpWAnr/Kvry7DL56u00ATbO
         zNJ0BviD6pBDuLqLjTK7sRgL+agqMfgaNSBjgTuqdrPJkWDzQj2EOxuIjrnCO66xlD/+
         Rr7BExVjO56rs9/pC+zXsEp203IkmJdWwlJgzYvRRYsqOHAfB/fufoUuqJUSJzRK3oBD
         DV52Hvk1gbmrtchmovYS6URsE8/aTG2KmzgL6WkcKlldVQjPfdZuKFY4h+XTI9SnNala
         NdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462556; x=1721067356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+/8q0n9zIZuPd8v8xe46w2FL6quvs2/a1bhvxAdF2Y=;
        b=VQDzAQv2l4QDUv14UWOMMTHqY3FMfFyalOE21ogi7X82kqGNKQVOInUeGe2AW0oOpc
         7ax1VUj885eSi6lteB8SPZt2xhWLvxyUbObDAYt2ZDsNS6LxGqGXHryFRdTY3dHLh6hS
         Qucm5S9dCG07pBtJ+C9vwNpav2X3Pk9BhbguJ1pBoQqkhPWUsem82S+XEhdVB52sYp0S
         Yx4jeEojbgyNfmUMnqPOPO+M14e7ylaM4mRh6t2BETgwm8hapPh6KSIZO9dNMAXyI8et
         fvETAyRu71h4ukhtFAWSCz70X7JuQ8ZGdkqTn4RrczIPlw1oo7HN0XQYsbJCTOTa+8MG
         6X+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZXIFmtUmshYxL/Sjj5lIn10vUw8VWQYGEsiLkX9pTqZhG+oFU6IUjjxTHjCU3zY/iLKGFJDPosF63ScIVWhtA1M3XMnWA
X-Gm-Message-State: AOJu0YzN4lZleHNL7SqZCaexkMDR2RjU8UPA3xfa9SK0W+aErWXzoN3V
	iJAduO1FGg3MpCxtyGR05fq3nRNBBGTiriZg2Hj/Vg0LhI8Ok4X+WD7nWLnW5epVUq0QiUhShKt
	S1rl4hafZt9eblg/miuGvZ133g1NP848r
X-Google-Smtp-Source: AGHT+IHkqVFPGrB1oIKqijM7RNmdDYfluVmCTA+6xb+aMZ21j/vyzS0Shew3Y1jn1PyKmCvuBp0eUMLeBznj
X-Received: by 2002:a05:600c:428a:b0:426:6153:5318 with SMTP id 5b1f17b1804b1-426707e209emr2482865e9.19.1720462556441;
        Mon, 08 Jul 2024 11:15:56 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-4265f7f3a25sm2527395e9.44.2024.07.08.11.15.56;
        Mon, 08 Jul 2024 11:15:56 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 2869A603DB;
	Mon,  8 Jul 2024 20:15:56 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sQsu3-00HP93-QD; Mon, 08 Jul 2024 20:15:55 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 3/4] ipv6: take care of scope when choosing the src addr
Date: Mon,  8 Jul 2024 20:15:09 +0200
Message-ID: <20240708181554.4134673-4-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240708181554.4134673-1-nicolas.dichtel@6wind.com>
References: <20240708181554.4134673-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the source address is selected, the scope must be checked. For
example, if a loopback address is assigned to the vrf device, it must not
be chosen for packets sent outside.

CC: stable@vger.kernel.org
Fixes: afbac6010aec ("net: ipv6: Address selection needs to consider L3 domains")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv6/addrconf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5c424a0e7232..4f2c5cc31015 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1873,7 +1873,8 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
 							    master, &dst,
 							    scores, hiscore_idx);
 
-			if (scores[hiscore_idx].ifa)
+			if (scores[hiscore_idx].ifa &&
+			    scores[hiscore_idx].scopedist >= 0)
 				goto out;
 		}
 
-- 
2.43.1



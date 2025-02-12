Return-Path: <netdev+bounces-165630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FA6A32DD9
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300321887469
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF428260A5E;
	Wed, 12 Feb 2025 17:47:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E269225EF88;
	Wed, 12 Feb 2025 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382467; cv=none; b=NPz7i0PJ2UEs8L9GHzSSDYIAmoSv6nfGQr8zaKPkG9JRVyesx1FQNpgRTcxjCiWLB0ImB4YLPftFXewWb4tZggWaiL5Jhoykh9HC4E9Kf4seCXb7qGr/5jCADDOdAwvJPKALRipykCCJ8R80HxSoA0gQAU9DKNqFWrfS6EP/rvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382467; c=relaxed/simple;
	bh=jca81WNOd6H2xJFfjYv9JuvlMENwEsXJrCvol1J45WM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cy3aSPTKKSauYTMUp9TinWTl26YlkaPvG5NRAIsg6TK+y+Z5QGyuBZyoyFQgHN2jIaLOZsLKzu4kjkYoL27UhJAjJq5Io7YPxxrXFektT8/VK9mqWJjhH3d2V9Z+P44qYDDrHQHf+r92m21+jzIA6jw6QmN+hKEyfuGvtWYXu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7e1286126so11148866b.0;
        Wed, 12 Feb 2025 09:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382463; x=1739987263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4zZrC1DnajHNt8cVfhXIfTDAnbFMYNYCYXj5n8Wcu4=;
        b=k7gY9sJR8cXjwM5ZGHvlWtj/BSUk7CvcdtUOboGW6D4PILJHVV4QwKUtvcN6leYi3v
         emwm6VU7m7HTFdKa9vRfjnyLLwukGqSsn4ktl6h2D21gYw/qLQ23KSI8szmiGO5BypF8
         RL4XIOA28ShgNa6sB38iZWDp7OrVh5wBPEUq+j7k3He/mwVhSkSduwG4Hgd2tlBMiLZL
         3VyjZ9spRjk8FASB6ejzYjNYsV+a0mdDWSkwaQIyt+AEYBFLZQXsFBslkKCYfq9aud4P
         YUigkt2/RuncxbLxuXOxvKJ/e7a1SeLT2CrQr5sYYSZsxEVPykeLt1tndTGlRcjQnnR9
         z8AA==
X-Forwarded-Encrypted: i=1; AJvYcCUqzNE8eA7DWQ0w+Vq/py7M9g+s5idYd56YTwZt4R8cBqWLWbaX+phohkwjyhmiOZkG+7642EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYg0Do2u/dOQuXGHyyRWZUI3V4EzhCpcgnx+L3P20Nabc+eWOX
	4XEYPC0NUy+8RVmNqz66ek5sSDNClfa3M5f3CGphbuPCaa+TnwL8
X-Gm-Gg: ASbGnctFiACholRWSE9mhQMv24P3OgMa4GZ1EmzRsyEZuThDj4SosiVO0BCapNt6eY3
	6XlT2a1tpFukRIb2B82JdDZKgYWXe7DNNduIHNa4DoHAFzPfqeE04r9DBLD1SpVXMatpnNtHQzD
	jzOMVF3TIlSxwUbW9wQMqb5CJw/CplZo5SsjraNzi9KKwRM59bmjzVeZktiRvAkpbnl8H9AH8C1
	NOWLEffCr7xHsXumtrqji+p1k4oSy+bpGk1ieOitlQ6lWGfCfXlAsHVV11HQPnUZcp5zErr1vM5
	iRBBM6k=
X-Google-Smtp-Source: AGHT+IF8iOGb8mI1eXdoaGQY19xDExsikWNbpotivmMUT+9EioOATj/xm8wLRPeV10A7Dq9+QihFUg==
X-Received: by 2002:a17:906:c156:b0:ab7:ea47:dee1 with SMTP id a640c23a62f3a-ab7f34ab445mr311236866b.48.1739382463013;
        Wed, 12 Feb 2025 09:47:43 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab77d1cde62sm1253434066b.184.2025.02.12.09.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:47:42 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 12 Feb 2025 09:47:26 -0800
Subject: [PATCH net-next v3 3/3] arp: switch to dev_getbyhwaddr() in
 arp_req_set_public()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm_fix_selftest-v3-3-72596cb77e44@debian.org>
References: <20250212-arm_fix_selftest-v3-0-72596cb77e44@debian.org>
In-Reply-To: <20250212-arm_fix_selftest-v3-0-72596cb77e44@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kuniyu@amazon.co.jp, 
 ushankar@purestorage.com, kernel-team@meta.com, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; i=leitao@debian.org;
 h=from:subject:message-id; bh=jca81WNOd6H2xJFfjYv9JuvlMENwEsXJrCvol1J45WM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnrN6482LYBGt8CRaT/t1Bq3E+F+uhgEbi0+3PX
 dAVqYhaBICJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6zeuAAKCRA1o5Of/Hh3
 bVv6D/0cxzolWpAjDPxTX1g4vCzxOdGCx4Q+RBVRxgc+WPDvmR+B/YIRuoa4Xi0R+qVT9lzJBty
 kCJsjYZMHyallQa393ACZJFQmJQRkaHjqCQhqvAgkPxVD3mwmVrt0jZm6afd8FN6xeiIlvwKOxX
 Cp5faiyfIHKyiY5YaIU1N3Ck7KQBFQzkmD+PPVnupnIGSPB1edTezgwnAmgzE2362P0nuTQs8Nf
 AXJFSGK9KzHNkEU+8AlcfkyQBk/ZDoYiOJF2Q4brxOdjMSHt5GyRHedN2kB5GlLZsXJv0nEXaqr
 ka9TmkDKpU7NORpCX1D2wvgqfPFcDNnnppqMVmuspHs7G6T1kaPtZOVVHEb3S7Ur8jmMAoIQOUa
 5A78BxWZZF0f7BHwqgX2taZwkFuSgzove/7TeKCsnZ6xjApemVWFvcRBdRLZOzIM/Vm8ttiQAEZ
 ZNBrnn8fgO+p6SXUyZpvaFHQp6QYmbfwP7SY8EBHiHzc8rjsJkMHjv+Ej+ntHPQMliiN2pOMGQ2
 zdqc9k1n0QpfzXxLtbLsJfqiyuO5Q/fd8+JI8mKlsKviA6zphSohlbVqWfn0lZ/B5qQwS8kycCR
 CU0m06UWW1hMSKnlnB0GqYf2FTCMAOkxOVSZ+CI367ZFwI22N3HlGVT74L5eXu+5RFwn/Zlg5tL
 Gm90fS3+puZKkqA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The arp_req_set_public() function is called with the RTNL lock held,
which provides enough synchronization protection. This makes the RCU
variant of dev_getbyhwaddr() unnecessary. Switch to using the simpler
dev_getbyhwaddr() function since we already have the required rtnl
locking.

This change helps maintain consistency in the networking code by using
the appropriate helper function for the existing locking context.

Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ipv4/arp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index cb9a7ed8abd3ab17403f226ea7e31ea2bae52a9f..1867de1cd156fa91bb3ed4a2c12cafd69d11468a 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1075,7 +1075,7 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 	__be32 mask = ((struct sockaddr_in *)&r->arp_netmask)->sin_addr.s_addr;
 
 	if (!dev && (r->arp_flags & ATF_COM)) {
-		dev = dev_getbyhwaddr_rcu(net, r->arp_ha.sa_family,
+		dev = dev_getbyhwaddr(net, r->arp_ha.sa_family,
 				      r->arp_ha.sa_data);
 		if (!dev)
 			return -ENODEV;

-- 
2.43.5



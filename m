Return-Path: <netdev+bounces-106112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19191914DFC
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5871C20F13
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E9B13DDB5;
	Mon, 24 Jun 2024 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Fu1ccmna"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f97.google.com (mail-ej1-f97.google.com [209.85.218.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6039213D62B
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234547; cv=none; b=mZJTLKqKijaq+rMEjYfyZ+ZcR/iv/LSwlPIGtYsiIuqbrJ0V5oF5E9/Cy+zS4AKOl6ut6Xve2GiQzMeq18rPzcf4ioNVJQDVVKB9vrAWaB6ymXMAJ8MNFP5h7DIqwzU1YON7FbL1oDVU8cYT5PGsnJobabYnDKOYzNzxvnR3us0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234547; c=relaxed/simple;
	bh=YnwMFx7v27V6FYvekKLIctK4MfTa3mGutFv4M3UNWRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XzkIMQD4FLe203+1v3wszzhe2+P0GphusrhiNkSQoWNwLTAgwG6MGf2K6JbtUrv00Hhe2tJgz96QntcNDgNPFu/bJoAbEnN6yo9FxEFK/MDnDFOPes2jMBaH16DO/rMPifFay/zbPKPjVA1bl4R00wSp5qvivXoc4dTjVUpicAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Fu1ccmna; arc=none smtp.client-ip=209.85.218.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f97.google.com with SMTP id a640c23a62f3a-a7194ce90afso198427366b.2
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1719234543; x=1719839343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdqEoEJ0Pf4lgGIH6ji9Pz/3++dxBfiK/h/sDIFPHrE=;
        b=Fu1ccmnantlWGJLI4dH6m5m9HQa+KJbOmeQZcRKp6A3hC+VyTuYWqmTpL9tdrhwTGW
         tTmbQiIRdBTPOCaNw8DK2W/mijX9vRmQuX1qfitOgAYc5Yfjs3QdpDZlA+Wr+V6f8cOX
         AOcgWy7U3kUnnIFa9gpgn0Ah5YL2FFLrwgXq0J9vjXPpK5tiUdzCzMtVCxN+OPaK2z39
         OaqX1AqBVdsQC4jCP330o1xw6YcY0KMSQCnPzTdqvNtijjPm/yGI35iM31mx6lNndlPQ
         6Q64JVzW5Ooaz8RGSnNMQUv0mz73tUvB6t8wiE0anMlsrpSNWJYcVjVOJXzyKZ7+8RCZ
         2Qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234543; x=1719839343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdqEoEJ0Pf4lgGIH6ji9Pz/3++dxBfiK/h/sDIFPHrE=;
        b=m+wdRodheA9H9NA9g9cwGVdYeRf/dZ+I1yLAxNGub6Rn2O4hBFirFYjQAunnHB5VSf
         cmrxhQIT/+zU8DFLVUoTb/O9i7gX3HA//Xy0LfpHKTmRUm4uJAXATqEYxL5jmmXNVFgY
         pc2n5Uw3D3A2Gio2aR+Oc/j5zw5UGKTF+03fD3rYxenyWmC0vT1cSAyneqqd2if9c6qa
         E5+2pm2HvLL58DC9MD+dxiRHooCQK2o7xxXy4bdY6RnTyLj2jP/EIxTnXyHnhi9aBvrL
         hfGm6u+VK0o7gBmPUhs3PDH+4ykT345jP9GzIvQmPr3HyFNGIX390rcL2skIX9GvFi2/
         L9gg==
X-Forwarded-Encrypted: i=1; AJvYcCV72po4039gROY1IDC7Jrqos4sFUOYaMAJ6xFrtWzTC+P/1vOaTfMdl8vuxFgN7SRt3NF4bkXCVq2LuxqLAUx0VAd8dkVN9
X-Gm-Message-State: AOJu0YxrzRW3TpnLWaNLTw7ps+bpIdiQ48mBrLSWZaYcc088IuYr5PXj
	fr8RRCE10H6fYqVcYGSwUECNuk96zHmoZRN4KxF0aC2IxwajteyflwkWON/b4ltaDuqkWdURu28
	DpDo2xEvwXv8yf5S2QieFGWxHSGCJk2Om
X-Google-Smtp-Source: AGHT+IHCk7wynrIl8qJrDVl6mUMvyc5T0uLPZ9fOJVKL4yEifbZ4Dcx4XDbVA+6QE1V+fboohRVwC3ANdYMU
X-Received: by 2002:a17:906:4713:b0:a70:6f2c:b308 with SMTP id a640c23a62f3a-a715f94a9d8mr372023966b.29.1719234542660;
        Mon, 24 Jun 2024 06:09:02 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-a6fcf560fc5sm12243966b.229.2024.06.24.06.09.02;
        Mon, 24 Jun 2024 06:09:02 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 570A760490;
	Mon, 24 Jun 2024 15:09:02 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sLjRO-00406D-1I; Mon, 24 Jun 2024 15:09:02 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	stable@vger.kernel.org
Subject: [PATCH net 3/4] ipv6: take care of scope when choosing the src addr
Date: Mon, 24 Jun 2024 15:07:55 +0200
Message-ID: <20240624130859.953608-4-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
References: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
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



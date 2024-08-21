Return-Path: <netdev+bounces-120722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1E795A675
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 23:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA460B21755
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F0A175D45;
	Wed, 21 Aug 2024 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="FgvpAfBh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7DB17108A
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275358; cv=none; b=iPxC//+QnRYwLRyLTfJK7s1n8rl9bnKVAafICaqZyoTxsv0BtTWMp/7NtLD2FjF3fPKg3rhb8aybcSlKzzyl95flGJPmCbKryrvMIVaSmToQCUEIv7ctSUGYASZ8MnN3kwkbelazdyJIjRDnedyxUiWJh6PBW0ovzgvAUAqJITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275358; c=relaxed/simple;
	bh=eU0j3/8rJg2aPvh4RwRcGS6M4omz/kWqfL82UJkQcUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ggep1ScALN8y8sKEdYLSD50huqI97KwtsgVYEZyMoCJECVj3eqrlFLix7BBsK7KqikqPm3SBMlBQQYA9qX7qg5Gh19O9s/Bx0ZILXoGzNWaYWuWUQN/DEGubs4sexgKCEa/2M4pADa32wGTGmavPJ7h6NcTsBcaHIh26ZAUQUv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=FgvpAfBh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-201f7fb09f6so1189935ad.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724275356; x=1724880156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxoeXzU4BY+HKSmSR4ce1eIiQfaMzrOqErp0TccUqeA=;
        b=FgvpAfBhZYLUQ1n9NGX1xd2n7KERDF68o9A3JjkJ/LYzlftAz4QIHbUAY3dRr9JQP7
         v2+oxng3+0OVuyPc34/Drb9NJeg0OBSOT6dLcpI896Gagj1Bi68QXzJNzkwjzBN45fQC
         6yTtXFFzVojHLUScFVsppHrR9sPGb2CPMrmHUCX603RXvnt4AjCt2csUrqF/dZHlLT1y
         vo2ZjKtaQwDVKzamOU7oaamwqOgC1dtkRmtHnf5NYC3454aSK8rUy+5o4zFcu1rRFzJi
         gUti2cazXTIzgLVZFuJHVq7b1ilqakkGwDTxtHiHbH9JhmSbThKvbqSRGCoU5MI/mllB
         V5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724275356; x=1724880156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxoeXzU4BY+HKSmSR4ce1eIiQfaMzrOqErp0TccUqeA=;
        b=e3NOle0CUbrT7rVliW4oUAkec3Lgj6+G+Mj/7aSANQ1E3/DeEYh9QgTTRPSW6048+S
         NgKXy4oq80lsEyBWd3e+lg3QthjOcNOp4gUxlIm/WernpRRVdoozzqwcm8xRFJfhd6yf
         3D4vewn5Hel5yMpgNFDi5nPM4xcr1dP5sy92QqT2nu1Ie4RmNqdZvrjSBZxBBaJVuGte
         ZPAKB/0SBJbr/xtaehkDUCLGLF2gdRoUcCX3iwroVsBM8+T7Es6kJkKVHZIFIlr2CN00
         o7d8QfjvkIEqY226ELkTKVEKyh4Aceia2Z7cqnYPn7EVIsJ2ACPPL11LdRte21ArXi2c
         +GaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj5F3v0w5MhFlFoPNcPuzePrImEAWNa7X5bB9/qraeLRwg5yK6skMyYWXv2vtKLf1sKtj+sac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgU3d7pdy3nNesGwXJ5e+GlSp18BUDqPKi5DF+xI2UbJ7gQ5Yr
	rWuCoKxuXjA2pFf+nCN+TfTAAU88O8jidxRyfsr3GY/VaMAlBsK6/wfsEYqEfQ==
X-Google-Smtp-Source: AGHT+IGDS2edgR/8k3/nWMtFi47IwCu+9q+GtRX0j5YK581lrnp98VglON02PDAoBfhkDpoK2s5RTg==
X-Received: by 2002:a17:902:ea01:b0:1fc:369b:c1dd with SMTP id d9443c01a7336-20367bf7586mr37796465ad.6.1724275356430;
        Wed, 21 Aug 2024 14:22:36 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:7a19:cf52:b518:f0d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae701dsm388265ad.236.2024.08.21.14.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 14:22:35 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com,
	pablo@netfilter.org,
	laforge@gnumonks.org,
	xeb@mail.ru
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v3 01/13] ipv6: Add udp6_lib_lookup to IPv6 stubs
Date: Wed, 21 Aug 2024 14:22:00 -0700
Message-Id: <20240821212212.1795357-2-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821212212.1795357-1-tom@herbertland.com>
References: <20240821212212.1795357-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Want to do a UDP socket lookup from flow dissector so create a
stub for udp6_lib_lookup

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/net/ipv6_stubs.h | 5 +++++
 net/ipv6/af_inet6.c      | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
index 8a3465c8c2c5..fc6111fe820a 100644
--- a/include/net/ipv6_stubs.h
+++ b/include/net/ipv6_stubs.h
@@ -75,6 +75,11 @@ struct ipv6_stub {
 					    struct net_device *dev);
 	int (*ip6_xmit)(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 			__u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority);
+	struct sock *(*udp6_lib_lookup)(const struct net *net,
+				     const struct in6_addr *saddr, __be16 sport,
+				     const struct in6_addr *daddr, __be16 dport,
+				     int dif, int sdif, struct udp_table *tbl,
+				     struct sk_buff *skb);
 };
 extern const struct ipv6_stub *ipv6_stub __read_mostly;
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 90d2c7e3f5e9..699f1e3efb91 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -1061,6 +1061,7 @@ static const struct ipv6_stub ipv6_stub_impl = {
 	.ipv6_fragment = ip6_fragment,
 	.ipv6_dev_find = ipv6_dev_find,
 	.ip6_xmit = ip6_xmit,
+	.udp6_lib_lookup = __udp6_lib_lookup,
 };
 
 static const struct ipv6_bpf_stub ipv6_bpf_stub_impl = {
-- 
2.34.1



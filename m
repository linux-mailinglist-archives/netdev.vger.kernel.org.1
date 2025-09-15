Return-Path: <netdev+bounces-223180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0673B58229
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 18:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59AD1890ED9
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E0F23908B;
	Mon, 15 Sep 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mcwilliam.dev header.i=@mcwilliam.dev header.b="Ss8i0qIV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275C2701B8
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953942; cv=none; b=mQbdl7VGwZZJuHDpjmmEBk7n4M6CgRzqDqswVlBRllo04eEZtMf1ypyKNknPiawo+oR0oU31cV95LS/OefqX+QW/boKeeV6VKz+BbYF7ljXaWEjYM/mfblxwMR5tr764KpeMF7YbbS92ikl/nEzoPIGGGICYd7uy0WGqe12kgSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953942; c=relaxed/simple;
	bh=SqQe1p9kIP1/NtCSdBvMGZm1IS1/ztQyjSDjkLtwiHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dEacAj4QpfwJzYjK0ti2MS+88uqbxWCe7VctXrJXOMLOSTBRaiItGDJZfo2VnO9sHQbHOdR6Vw7GZ3yB/S2lgfMVNBDX/yBhQOkJAddNm+XqkmLKKrbVvSYzoIbt4vQmdD8I9I8G1Y4Cnm+smFIC6Oi1/5Mu/a48NoeZUJezOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mcwilliam.dev; spf=none smtp.mailfrom=mcwilliam.dev; dkim=fail (0-bit key) header.d=mcwilliam.dev header.i=@mcwilliam.dev header.b=Ss8i0qIV reason="key not found in DNS"; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mcwilliam.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mcwilliam.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3eb0a50a4c3so800924f8f.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mcwilliam.dev; s=google; t=1757953938; x=1758558738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXtGMeiOjBa8LVVSERnNIxwHRjN0rs5dw/t32599bBo=;
        b=Ss8i0qIVYAtEHame0a57ooDp2yxSA3aVwY07UA4zMRqV8d5fnNPvGvpqE2m3AibWPF
         6dpvP/CNJwepPUCZhGwASzKtRMdDG9Fl7IZGjn/eDHjTm3t5954RtxsmcDNh6Js4aFE/
         GWYuKOKhnYpx6iEBeKeJaUfBncy67dq9v9oI7i9ELoTxaU6W3i+xIDNaHizeEiyRjmrY
         cM0YNUd4lrw4RRDV3/rkgd9L5UjbJAzuMF7PN3UvPNG01T58fBTi/P236Gmi3nWj/ZWR
         6GJlxUdEM0EC34/1DV/KDoY9qlgIwasafqccDBOy0xzFy8c78AIZX2HOr0hxxaVHrEYt
         h/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953938; x=1758558738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXtGMeiOjBa8LVVSERnNIxwHRjN0rs5dw/t32599bBo=;
        b=ji9HQg8A7jnX0UTuaIWCuIH3KnmmWoMWqtrPWUjzzr04svq3NWfYhDLsSiaAodWELH
         Efc1sIRf4NFul8RRV42s9HKRwE+fbmZnvz2FmjrDt37q5oEeQssApnJsrfDTyPPzSBeJ
         WS0pPO71xVbl1pCfr6T5iqQnsuJDZ/JJwy7Muy3FIMOj54TAdIqx9gJJpaqBUGavRv2j
         J37iL/3RXymNMoAPj8vZCwyhf40nrSEJ5yd4RSs+dvmZZhLoWjUmjUrzhV7o26w86nR1
         d+UdWTWHnuhPoZRnnRJPbJSBN1yQc1kiyejRlLoGJF3Z0oVnN4XUrw2brI63USBz0Euc
         dsvw==
X-Gm-Message-State: AOJu0Yx7WjflMOo6Q8qIBYdfPyak8BiTJadM/5//foQ0kTbmU1AtriqG
	IXZ+KAzg/ryjAbx8BCMltegA5IDpOb+WVt/HX8YK7uVO7j52wqE5mfIkPqM/yUBjqBzi6zDi4hh
	QMGf7lTo=
X-Gm-Gg: ASbGnct7NyrG75l9XIVeLb85wtN4OpjmlF6bPmxFpdAVbulWrAXGh9cUPe8k31rOF8c
	ps56lDvksIMF4SAuciJcXPcJ7E8nhAIIte+seRybkxrZRJjh+oteaSmsZULIjt7enNvMx7kN//r
	NCS+UONeQXn4JNAz6UNZRa9ckyO6HV6IPPfPBf2StJprpKlN7s78lBfO9SkL+Du2OC3orbkbnXz
	Zg1lAQlKX7iH6pDRmZK6GiWmeC0tWMWniy33tauI1ubleGxXf/uyq1EBIJjnEaaGMPQmNBBweL6
	nrGbCL7YT9gKh4XLVSNyRWr4svxVBdIniJFFxMt8psEBcpD1PHR200SAnoNwlfgQem1YbwE8zC0
	mpy5gVgv1zl8XluMizZUM0PY1c5i3
X-Google-Smtp-Source: AGHT+IFNI2Rnp8DoEeNqiEZMNbOvoc3wnJ0XLSki5hyKuZE2DJvJ6AIg/eAwESjzQGdCoHYFReVkYQ==
X-Received: by 2002:a05:6000:2407:b0:3da:37de:a3c0 with SMTP id ffacd0b85a97d-3e7657972damr12119306f8f.15.1757953938477;
        Mon, 15 Sep 2025 09:32:18 -0700 (PDT)
Received: from el9-dev.local ([146.255.105.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0155b415sm102717105e9.0.2025.09.15.09.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:32:18 -0700 (PDT)
From: Alasdair McWilliam <alasdair@mcwilliam.dev>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] rtnetlink: add needed_{head,tail}room attributes
Date: Mon, 15 Sep 2025 17:32:17 +0100
Message-ID: <20250915163217.368435-1-alasdair@mcwilliam.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Various network interface types make use of needed_{head,tail}room values
to efficiently reserve buffer space for additional encapsulation headers,
such as VXLAN, Geneve, IPSec, etc. However, it is not currently possible
to query these values in a generic way.

Introduce ability to query the needed_{head,tail}room values of a network
device via rtnetlink, such that applications that may wish to use these
values can do so.

Signed-off-by: Alasdair McWilliam <alasdair@mcwilliam.dev>
---
 include/uapi/linux/if_link.h |  2 ++
 net/core/rtnetlink.c         | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 45f56c9f95d9..3b491d96e52e 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -379,6 +379,8 @@ enum {
 	IFLA_DPLL_PIN,
 	IFLA_MAX_PACING_OFFLOAD_HORIZON,
 	IFLA_NETNS_IMMUTABLE,
+	IFLA_HEADROOM,
+	IFLA_TAILROOM,
 	__IFLA_MAX
 };
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 094b085cff20..c68e20a36daa 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1326,6 +1326,8 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
 	       + rtnl_devlink_port_size(dev)
 	       + rtnl_dpll_pin_size(dev)
 	       + nla_total_size(8)  /* IFLA_MAX_PACING_OFFLOAD_HORIZON */
+	       + nla_total_size(2)  /* IFLA_HEADROOM */
+	       + nla_total_size(2)  /* IFLA_TAILROOM */
 	       + 0;
 }
 
@@ -2091,7 +2093,11 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	    nla_put_u32(skb, IFLA_CARRIER_UP_COUNT,
 			atomic_read(&dev->carrier_up_count)) ||
 	    nla_put_u32(skb, IFLA_CARRIER_DOWN_COUNT,
-			atomic_read(&dev->carrier_down_count)))
+			atomic_read(&dev->carrier_down_count)) ||
+	    nla_put_u16(skb, IFLA_HEADROOM,
+			READ_ONCE(dev->needed_headroom)) ||
+	    nla_put_u16(skb, IFLA_TAILROOM,
+			READ_ONCE(dev->needed_tailroom)))
 		goto nla_put_failure;
 
 	if (rtnl_fill_proto_down(skb, dev))
@@ -2243,6 +2249,8 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_GSO_IPV4_MAX_SIZE]	= NLA_POLICY_MIN(NLA_U32, MAX_TCP_HEADER + 1),
 	[IFLA_GRO_IPV4_MAX_SIZE]	= { .type = NLA_U32 },
 	[IFLA_NETNS_IMMUTABLE]	= { .type = NLA_REJECT },
+	[IFLA_HEADROOM]		= { .type = NLA_U16 },
+	[IFLA_TAILROOM]		= { .type = NLA_U16 },
 };
 
 static const struct nla_policy ifla_info_policy[IFLA_INFO_MAX+1] = {
-- 
2.47.3



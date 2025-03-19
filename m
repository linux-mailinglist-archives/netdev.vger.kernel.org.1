Return-Path: <netdev+bounces-176208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C609CA695B3
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A906171485
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B36D1DE2C2;
	Wed, 19 Mar 2025 17:03:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07131B4140;
	Wed, 19 Mar 2025 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403780; cv=none; b=ohMdaEE9A34Z0MVYnPIEMJNvg8AIbTXNRP01eOIL0LoN6EGYATf6my4ItNzb7FFGOsnop5/0vn8vjmxVrslLj3S7bjrLQSwyXq62e6jDfVczuf8KZ9UEwOZ3WiuSH8CNkuoOXp5tP1vaponjxCme0dayiI6r6/si44v1zmmEjqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403780; c=relaxed/simple;
	bh=QQEhEFjq9wfqNSHOh65dEw6Lr7M4kDIxuqMqTzNOoGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GAQ9j5aFH5ZHGNwfxYAZ95Wds95SgwBdNWmpaT1osV3HX9LJPXVr2I59DrkxtiObsXhProuHowcwvLW903oclPZ+uXdQusDVnR42+Yu2KmtJ5OMRg14E9E+tN0FKMbCZUgdOBI2r10UG9ypSeoIN7nxuRLM1eRQBTReDYulWhr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2c663a3daso734895866b.2;
        Wed, 19 Mar 2025 10:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403777; x=1743008577;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4emXJwNKSYYRU1ppTj5t1hQiQWF9TYLKaQBYefea5/o=;
        b=Wnn91x44EetNg8Acwl09S85MUi+xv0NWn44Ju4vRniYVSiuUShhikN9VjMO7su3p6k
         kxw9bEa3tosc0/7pgIW5Nsuyj/7m237xSyxwHh7eIBlleXal6e8ktbqgZjkQzRjGXrKJ
         OBizOZBYb5+xMgiNprpvhAeWhJAZzaNMMyxr5LwkzkSLfXeymqUSv72mZ3UzRSzUjcJy
         nIqPi/FBanNbkfzh2OXJ6cwGwAYsPQAfp72xaSmHIZUBXK6s6LXX1HxBk3qCxWYkJTUq
         0axmIY2PCbrkNkz5j05+4GDF2ExXeyYA4s/wZqkBaxXOz4lfZbCL3Us1LRduqeXjbh1c
         tY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwrh3GCCR0smrt/DPIw+Zkv9yEuIwKe/qUcEG5Kz/T3X7O09DObWzYF3/CIsH4VqOAuNCI3ygBq1iCaO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdl2neQ2dh0AeLldWu0CUBR2Q3TdULkNXC2XQKzvHiTcC1OaZ6
	n5h4Zy3vsBGXi/gy8dMe3t1yP3Ua1fWQEyfQGpisXgA0vAaB4FHW
X-Gm-Gg: ASbGnct/7iYlUN+KYtJGbnLcfNPyyzCVHTHS8aLuoXe2BRPjyiuHcV4SNRkuYeSAoRD
	S+YNOQdn2+hUiT0l8LpMPhuxMoUOkjUpvjm3ro/fUCt3JVjQ9WUYzvA5A8Zl6DstDYhVgQxl5Q9
	v9jo5B4oDXdx7jNwjo/uGxC/KjyxE8CnnwkrNLNLX7XGNFkJcNwoV8z163LVW1M3nSHe8NVdv3c
	GhzPpr1RR4KrPmolLJGRbxaCe/WWIlp//QqP4oNvjX9XNVyRC6gTJnYwgCubbWbyLWN/Rn3tROV
	h3AWczPDGQ84Y5ZNq6eEXrRky326LM2LjXcn
X-Google-Smtp-Source: AGHT+IEZLBoorOK0i/CAV4CmsJ+tQcdBO8kzpdre61WTzVJ+OCVuetyxxb0YvTAMHnHVKZy7YFqmhg==
X-Received: by 2002:a17:907:60ca:b0:abf:5266:6542 with SMTP id a640c23a62f3a-ac3b7fc05c1mr351075866b.55.1742403773151;
        Wed, 19 Mar 2025 10:02:53 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aeaa1sm1029706066b.2.2025.03.19.10.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:02:52 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 19 Mar 2025 10:02:44 -0700
Subject: [PATCH net-next] netpoll: Eliminate redundant assignment
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-netpoll_nit-v1-1-a7faac5cbd92@debian.org>
X-B4-Tracking: v=1; b=H4sIALP42mcC/x3MWQqEMBAFwKs079tANLjlKjKIS6sN0koSBkG8u
 2AdoG5EDsIRnm4E/kuUQ+EpzwjTNujKRmZ4QmGL0rq8NcrpPPa9V0mmcq2tS1fbZpyQEc7Ai1z
 f1kE5GeUr4fc8L5XBoFhnAAAA
X-Change-ID: 20250319-netpoll_nit-6390753708bc
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=leitao@debian.org;
 h=from:subject:message-id; bh=QQEhEFjq9wfqNSHOh65dEw6Lr7M4kDIxuqMqTzNOoGM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn2vi7csTf8sOFP820VIfSbD0Nb52LCyLoxcWhT
 Ghu1gQhGtmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ9r4uwAKCRA1o5Of/Hh3
 bTtSEACKlhCZ64vfCh0guBHi0j0RFZBrHSPsYdJV5ZaCfjptsM6MRYTXxB8jfiRbqv2/y6oUlbp
 PkRoRiUScjI/yAt2e7NaMMfk+pL8LnFScVeAfRhGP8UDhnzQviQI+TpF3aoiRYx3MEFXQZLlft0
 KWVWcso3EtUSgJzTJH7KSElJGHExxWmc8/S5r6pxc/EDXpS1aowwRideyXVR/vU6PPQiP9D4cxN
 WoQYZR+SPh/9hQpc9McyZsaI0BqfMl51st7ouvJ8/Ein1Cj+8/V7KtLf90/iMybE6az7+I3v+Py
 yGxtSNQO0iNveIVNGCxEJ6B1wPK6qeVyVeDaZtMkl3hy04ySbCyGC3perYsszWdOEwWueVTHGfs
 Xv+m9RIhC2TXicF5UFCOUrifQALJQaW+ixB9kFSDVlJAINtTLMX8lr7gfwtRtfnaEB4j5mxA2i1
 v4vbB2D03p89ecukZ9/4Ys/6O4+SkQ2KJJaoJfqwaJOECfY8a7NK8QOCVcJYwAeLGMI+uPFNbZf
 BgdePNS+/WVzDx1OnXIjPVolxR4v2bX6DvsxqGfr2F1mOBrTg8DN5c31PYO4yDLO9y8OQCj11q2
 h/FWD7r4odEdkXIGr7EmflxUKqoMGmQRIiAAG/Gcd7LM5C5hYuLbq3fIlybZE2ZcAB7clkTj9Bf
 gTj5XEP8wBZRL5Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The assignment of zero to udph->check is unnecessary as it is
immediately overwritten in the subsequent line. Remove the redundant
assignment.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 3cc3eae9def30..4e1dba572f5ac 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -433,7 +433,6 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	udph->len = htons(udp_len);
 
 	if (np->ipv6) {
-		udph->check = 0;
 		udph->check = csum_ipv6_magic(&np->local_ip.in6,
 					      &np->remote_ip.in6,
 					      udp_len, IPPROTO_UDP,

---
base-commit: 23c9ff659140f97d44bf6fb59f89526a168f2b86
change-id: 20250319-netpoll_nit-6390753708bc

Best regards,
-- 
Breno Leitao <leitao@debian.org>



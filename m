Return-Path: <netdev+bounces-143307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 264A09C1ED9
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 15:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0F21F23362
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BFF1EF083;
	Fri,  8 Nov 2024 14:08:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8E1EF095;
	Fri,  8 Nov 2024 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074928; cv=none; b=eJR/HQQVKQP24q0yZuvX9BPYJsltOY669JzUCQZ7Xw0/ddj5w4XG4D8nN5zidOB0EiP+EGh2Iv3PGlajLYKwNp+z674pDcxixk6uCNkPmT2WGLSzR9p8TF69R9k+CPxsAptyyIbPbvoALCEX8G7z4oqpA4vkxcu6knFr/Q8Rczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074928; c=relaxed/simple;
	bh=7Km3i1M5xWKDLBrUTRXumcxArKatpfaTbs4odA5WNBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ohxfC5CrNNAQgmDqjQXD+xtTrMin5Pq/mq2D2cDHhJohEIApOGQMYdKRMDqzhfMU4ZAgbyOnfhktq+q6sxni4MuMx4nrJ3ePz+QuWxQKNj4WclWMW56AQGeB/ukpCRMR8iL8Q2pQKngWlAkoCw08mP3mwhQY3APuW23LUdg/iG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99ebb390a5so605277866b.1;
        Fri, 08 Nov 2024 06:08:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731074925; x=1731679725;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Vs+8MmoutBmVIGaxrBB+Gc26ziMMInjO3wPn6W3jwo=;
        b=cH9AWSgpdnV1XhITXk6LlAr/JmJu9aG8F26cBsJ+V05FtxYcGIXueeJ946SkbZCW42
         KZLgJWN9xFlwzlkut07KaB0/5TSXkZmzWbT+DUCKqU8XBSVEORx1lY87aDsHwMbEC0u9
         tFm4rmmZE1gFhRsozN2U9AtOkWiDlhn6c5ujalpaDnWfvfzYYQN1BWBJJZnoznESqjOR
         zsZqXxXGUE2U4N2vV5bqcPGr4OIXCkJZNiI3gzp5ua9ga2o876fJ0zEU9eO5qqNOZ1fx
         3ISfMQqVF8GRrJlxP1bfFyVBehns1Rnw6n7QnshhED8eNCRxAir9Hek0+yOGVodTx8EK
         Lt/g==
X-Forwarded-Encrypted: i=1; AJvYcCWJVf00Q4DCQxu0weA6jKa7Rt6dw/5HmQIv7cifEw6Nm1yYxYdhGl73KYZzHT5J0ReYDGIKSmk8@vger.kernel.org, AJvYcCX+PhpIP2l2LnHElNRSHiUaWey0bYQLpm8Xq6YEbtLeG6IJMEZmwhsyEvD6XF3KozX5dSdugpBpZzZs9Qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCtxNj5tQnqMc1j8CeAGLIyjZ+YSVP5PbNCvMDHK7WU0+3W9SG
	bBVTmSVD+L9Tz7KbP7MP1J/d8IeNTn41KSKhfGe4IsCzLPTcvbD2zybbdw==
X-Google-Smtp-Source: AGHT+IG9MyyRiE8clL0are8WjgoIfAj4jhGW0zaUz3k+d78u3MMeQYOxWTAgO2qoNGOv58CynKY4FQ==
X-Received: by 2002:a17:906:dc8c:b0:a9a:616c:459e with SMTP id a640c23a62f3a-a9eeffe65c0mr257588366b.27.1731074924529;
        Fri, 08 Nov 2024 06:08:44 -0800 (PST)
Received: from localhost (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ef31fe476sm84123066b.21.2024.11.08.06.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 06:08:43 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 08 Nov 2024 06:08:36 -0800
Subject: [PATCH net v2] ipmr: Fix access to mfc_cache_list without lock
 held
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
X-B4-Tracking: v=1; b=H4sIAGMbLmcC/2XMQQ6CMBAF0Ks0f01Np0FFVt7DEFPoALOwkCkSD
 eHuJmxdv+RtyKzCGbXZoLxKlimhNr4w6MaQBrYSURt450sid7Uyv/Sp3dv6G8XqXDrX0gWFwaz
 cy+eoHki8oCkMRsnLpN+jX+mg/2klSzZE17Whin3P8R65lZBOkw5o9n3/AWBkXrWmAAAA
X-Change-ID: 20241107-ipmr_rcu-291d85400b16
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2627; i=leitao@debian.org;
 h=from:subject:message-id; bh=7Km3i1M5xWKDLBrUTRXumcxArKatpfaTbs4odA5WNBY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnLhtqgmnm+ETxe80MIUaf83bV/rIllOdcVf6W8
 FELLsJz9KqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZy4bagAKCRA1o5Of/Hh3
 bVxpD/sG2B4c/+/VHr//44r6QyqEnMVYecaMa9xmfeSt4HkP5hZgvjJN9dG0GZbh0pj8ghBK10D
 K8WcEJpghsUaY9uwD0ZQiekrIqwdtgsVz2iZddGju4TJ1IwVwlQCCKFIWxnvXmdvvnSezVBnq29
 khJWj3rPHToJVC+XmRNOJuvB53x2b7qeV/ksm40yayF0ZO9nwji8OnE6s1e0WzLOZZAKa4y+skm
 i9RPwg1/KAaiSmj8Usc0zrx6FHyHfTQLOlMhNkeLyqxT5lb8IbAkI2+T0KHTwTbNOBkiOZewPMe
 FTrgbZZa2kie82+veWKH4xqYL7CocMNN3jDqQUYcOE2zMgyIQfLz3BxAENEZXnOQSPkWRHRnKmX
 ec6Hwf7gcVVkBKV1/9WwpRl89cl/B7QNGtXIFJSgokjljMPyzS7NvYVmiEnGSqaIjwK+uiObJOO
 XFXGbIiRAQwP+522nsIS/ezSmO371i7FvJyYkOmRk6Q7yTcXcqTg83ExcCfpZyQU/m3ibxLWAw6
 KvhigMHJF0XEUYMkdshM3YAwgyVCmXE0VTi6KNKxrG463CAG8JGCITzMBqPmxyD6L8aqXnU5zZ1
 McNlgFuBdUWmOOBY8mluPiJ6fFLhg6YI8pjP61w3EVcNAfo61oiIJVpATLH9ZUL5mzXAuc5YCTz
 bDZEqJw0fUgAanw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Accessing `mr_table->mfc_cache_list` is protected by an RCU lock. In the
following code flow, the RCU read lock is not held, causing the
following error when `RCU_PROVE` is not held. The same problem might
show up in the IPv6 code path.

	6.12.0-rc5-kbuilder-01145-gbac17284bdcb #33 Tainted: G            E    N
	-----------------------------
	net/ipv4/ipmr_base.c:313 RCU-list traversed in non-reader section!!

	rcu_scheduler_active = 2, debug_locks = 1
		   2 locks held by RetransmitAggre/3519:
		    #0: ffff88816188c6c0 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: __netlink_dump_start+0x8a/0x290
		    #1: ffffffff83fcf7a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_dumpit+0x6b/0x90

	stack backtrace:
		    lockdep_rcu_suspicious
		    mr_table_dump
		    ipmr_rtm_dumproute
		    rtnl_dump_all
		    rtnl_dumpit
		    netlink_dump
		    __netlink_dump_start
		    rtnetlink_rcv_msg
		    netlink_rcv_skb
		    netlink_unicast
		    netlink_sendmsg

This is not a problem per see, since the RTNL lock is held here, so, it
is safe to iterate in the list without the RCU read lock, as suggested
by Eric.

To alleviate the concern, modify the code to use
list_for_each_entry_rcu() with the RTNL-held argument.

The annotation will raise an error only if RTNL or RCU read lock are
missing during iteration, signaling a legitimate problem, otherwise it
will avoid this false positive.

This will solve the IPv6 case as well, since ip6mr_rtm_dumproute() calls
this function as well.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Instead of getting an RCU read lock, rely on rtnl mutex (Eric)
- Link to v1: https://lore.kernel.org/r/20241107-ipmr_rcu-v1-1-ad0cba8dffed@debian.org
- Still sending it against `net`, so, since this warning is annoying
---
 net/ipv4/ipmr_base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr_base.c b/net/ipv4/ipmr_base.c
index 271dc03fc6dbd9b35db4d5782716679134f225e4..f0af12a2f70bcdf5ba54321bf7ebebe798318abb 100644
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -310,7 +310,8 @@ int mr_table_dump(struct mr_table *mrt, struct sk_buff *skb,
 	if (filter->filter_set)
 		flags |= NLM_F_DUMP_FILTERED;
 
-	list_for_each_entry_rcu(mfc, &mrt->mfc_cache_list, list) {
+	list_for_each_entry_rcu(mfc, &mrt->mfc_cache_list, list,
+				lockdep_rtnl_is_held()) {
 		if (e < s_e)
 			goto next_entry;
 		if (filter->dev &&

---
base-commit: 25d70702142ac2115e75e01a0a985c6ea1d78033
change-id: 20241107-ipmr_rcu-291d85400b16

Best regards,
-- 
Breno Leitao <leitao@debian.org>



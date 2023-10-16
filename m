Return-Path: <netdev+bounces-41335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED037CA955
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 561C7B20D9F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DEF27EE6;
	Mon, 16 Oct 2023 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iU5vgA0O"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092FD26E16
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:28:46 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E554AE3
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:28:45 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-564b6276941so3318054a12.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697462925; x=1698067725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6A4z/4U2K3WzAUzov3bGTmc+BOc6s6K9VnCG1bksGeE=;
        b=iU5vgA0OVfkZ/OHqpoVagiatPtAjNQ5vgTJNVH5VFLIFbndvQMMIWLwMqpiVr+a4yT
         9LeZ+bLuGpHyenxEgmuNOH3f6o9wCT+fNQenj3E0niFsM9yRo63eNMococ44zktbmyOM
         kC6ofiNp2X59kQL9ltJ7IL/t3y0EpDBUUkAUuOV7iZ/yAOAG5SpyLSkUgD6b2qglA8RT
         PU2SguQu+pBw/3B5QaYNolWF0hfLXhsR+TWLl8uCtmd1Zg10JfmryeRMUOlIWP4tOKg+
         HlXNxQVw+rgUBmdwhQgsQ3dioLPxEU8K6HgO+hVEnd1fQFTb4K5r+wPtmhoSYmLqZaUO
         EfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697462925; x=1698067725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6A4z/4U2K3WzAUzov3bGTmc+BOc6s6K9VnCG1bksGeE=;
        b=Wax3M7/jQZ3kTZwMdXdXwhV83H67NPN6gAgHxkAKOIedBbzi6b5iFCNPYtWhYH+H5B
         XOKM6ve15EKEDi24ZRqP3dJ0QZGElsOW0BHrZQ7eo6lk+0oJK/b6uwcZL9/p6ZibZTpb
         E+2AmiqI2yC7jNmlt7JO68taKKCQRxXuudzIBV+kCiPuse4gWNuJU7OV18KefubS79FV
         dVwmnlhmSBf+4S6Tz4ThVqAWHy7645ve98d24o14FRZ1Rw0zC3jRdXwS+6HBNOG4hrt5
         SX60tEaRBLwNLRAlf3gGJchvSSDt7BDjlUu8m7IObZVndd24ab2X9hPkZnuA/7YD7yeE
         2EIg==
X-Gm-Message-State: AOJu0YzjghadbaXvTCDMDV1pZHt42574rL7D4QBJioaRpcPDxRBZ8aAZ
	9tyvFehQNVWXm4DvcPeOWlxTkA==
X-Google-Smtp-Source: AGHT+IG/aNFD8yOcB2CiaA9N6pA4YrFoO3SZXheTzPSixLt3q6ZWlan2LBv2aK3gxkV6vP0lWDraQg==
X-Received: by 2002:a05:6a20:3d1b:b0:12e:4d86:c017 with SMTP id y27-20020a056a203d1b00b0012e4d86c017mr41504115pzi.10.1697462925400;
        Mon, 16 Oct 2023 06:28:45 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id l21-20020a170902d35500b001c737950e4dsm8476287plk.2.2023.10.16.06.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 06:28:45 -0700 (PDT)
From: Abel Wu <wuyun.abel@bytedance.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shakeel Butt <shakeelb@google.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH net-next v2 2/3] sock: Doc behaviors for pressure heurisitics
Date: Mon, 16 Oct 2023 21:28:11 +0800
Message-Id: <20231016132812.63703-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231016132812.63703-1-wuyun.abel@bytedance.com>
References: <20231016132812.63703-1-wuyun.abel@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are now two accounting infrastructures for skmem, while the
heuristics in __sk_mem_raise_allocated() were actually introduced
before memcg was born.

Add some comments to clarify whether they can be applied to both
infrastructures or not.

Suggested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 net/core/sock.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 43842520db86..9f969e3c2ddf 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3067,7 +3067,14 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	if (allocated > sk_prot_mem_limits(sk, 2))
 		goto suppress_allocation;
 
-	/* guarantee minimum buffer size under pressure */
+	/* Guarantee minimum buffer size under pressure (either global
+	 * or memcg) to make sure features described in RFC 7323 (TCP
+	 * Extensions for High Performance) work properly.
+	 *
+	 * This rule does NOT stand when exceeds global or memcg's hard
+	 * limit, or else a DoS attack can be taken place by spawning
+	 * lots of sockets whose usage are under minimum buffer size.
+	 */
 	if (kind == SK_MEM_RECV) {
 		if (atomic_read(&sk->sk_rmem_alloc) < sk_get_rmem0(sk, prot))
 			return 1;
@@ -3088,6 +3095,11 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 		if (!sk_under_memory_pressure(sk))
 			return 1;
+
+		/* Try to be fair among all the sockets under global
+		 * pressure by allowing the ones that below average
+		 * usage to raise.
+		 */
 		alloc = sk_sockets_allocated_read_positive(sk);
 		if (sk_prot_mem_limits(sk, 2) > alloc *
 		    sk_mem_pages(sk->sk_wmem_queued +
-- 
2.37.3



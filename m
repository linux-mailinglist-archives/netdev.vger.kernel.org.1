Return-Path: <netdev+bounces-54989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C74158091E8
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 20:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6D51F210A3
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F2C4F8B9;
	Thu,  7 Dec 2023 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4Hmdcms"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE9A1715
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 11:50:56 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5d4f71f7e9fso12069797b3.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 11:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701978655; x=1702583455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=okZ87/u6VscX9lIQ3XIJX9A+fjGGWaFDzFSNNM2c0ns=;
        b=Y4HmdcmsFP/m2T1QYYXABv5JJmOlfy0QIomhHPmWsTtomAu2Nsij+52BLUaOwB9OX5
         BVdxF0TegKu6F1mE7GKzu51mtGqGyIt5RWhbx8mZSDcpMilRVmY8DTVHm1g1+wGRTkgS
         mJheJ+V5K3PXxNMLrzhqgXXkzt5q83QPkok1DopxOLivhMMlZckNG5O/meXK04W4YiS0
         GqrgN4tyvYNuLb12YSuGYmYxluQSAbGvMLThwMq3Qci+h4E2BoRh5QPLQx/NfCHfgdcG
         xFNU/IM74b0AO8JeYoeTMUFPuH5Jlvt0BitqAAR2DO3n06YJsoPZtcejIN+vDxXI2Q+w
         KbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701978655; x=1702583455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=okZ87/u6VscX9lIQ3XIJX9A+fjGGWaFDzFSNNM2c0ns=;
        b=GbO/vaV3X5C+L6gl9fM7NhSAgLmEi8ihUxxvlvJ7qqRNz1g/wMGw7RIRvM44+8kqnF
         uXH5qCKfMIfSki0Q+VPpFRK/szvTCHTzHj6rIv7lmMsaxW4xEgKHmiIzpyVKxxbjtQc8
         PSlSkB71hejML5z/SBJrD398SJsoHX+FVkSZKpKJ9+74Y7J7koyhawmbqeU+lUpNtVZv
         W/tbgtpdxChhRRiqoSXhAaWkO22uhy/uSCr2E9+Zznk7GCVR+0JgR2DPEmKgiD+z5b/q
         BYXXm7qWRvXjKMN6zXJOSr5Y5B5B3yOTXG80GMZ2suREUviO8UMK5iJDMuhXNB8zSewq
         1DFA==
X-Gm-Message-State: AOJu0YybnmJ8S6na/7V73TfvAxdzobW0BNFMJRqP0EvE3c7D8jA6dnRx
	3FGQ6tsv42ih6gTUF3Zb+x9mv7KTy5j9hg==
X-Google-Smtp-Source: AGHT+IHnM/f3cJQrIPONPvPL4tbb2DZZNNTYVB5zfGU6CfW1JC9c8F9aHZmht4b09VwAEp5lix1p4Q==
X-Received: by 2002:a81:af0e:0:b0:5d7:1940:dd73 with SMTP id n14-20020a81af0e000000b005d71940dd73mr2962684ywh.73.1701978655171;
        Thu, 07 Dec 2023 11:50:55 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:57df:3a91:11ad:dcd])
        by smtp.gmail.com with ESMTPSA id o5-20020a817305000000b005cd9cdbc48dsm114146ywc.72.2023.12.07.11.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 11:50:54 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	edumazet@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next] ipv6: fix warning messages in fib6_info_release().
Date: Thu,  7 Dec 2023 11:50:51 -0800
Message-Id: <20231207195051.556101-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

The previous patch doesn't handle the case in ip6_route_info_create().
Move calling to fib6_set_expires_locked() to the end of the function to
avoid the false alarm of the previous patch.

Fixes: 5a08d0065a91 ("ipv6: add debug checks in fib6_info_release()")
Suggested-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/net/ip6_fib.h |  1 -
 net/ipv6/route.c      | 16 +++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index e1e7a894863a..95ed495c3a40 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -329,7 +329,6 @@ static inline bool fib6_info_hold_safe(struct fib6_info *f6i)
 static inline void fib6_info_release(struct fib6_info *f6i)
 {
 	if (f6i && refcount_dec_and_test(&f6i->fib6_ref)) {
-		DEBUG_NET_WARN_ON_ONCE(fib6_has_expires(f6i));
 		DEBUG_NET_WARN_ON_ONCE(!hlist_unhashed(&f6i->gc_link));
 		call_rcu(&f6i->rcu, fib6_info_destroy_rcu);
 	}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b132feae3393..398dbfb6e12b 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3762,17 +3762,10 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	if (cfg->fc_flags & RTF_ADDRCONF)
 		rt->dst_nocount = true;
 
-	if (cfg->fc_flags & RTF_EXPIRES)
-		fib6_set_expires_locked(rt, jiffies +
-					clock_t_to_jiffies(cfg->fc_expires));
-	else
-		fib6_clean_expires_locked(rt);
-
 	if (cfg->fc_protocol == RTPROT_UNSPEC)
 		cfg->fc_protocol = RTPROT_BOOT;
 	rt->fib6_protocol = cfg->fc_protocol;
 
-	rt->fib6_table = table;
 	rt->fib6_metric = cfg->fc_metric;
 	rt->fib6_type = cfg->fc_type ? : RTN_UNICAST;
 	rt->fib6_flags = cfg->fc_flags & ~RTF_GATEWAY;
@@ -3824,6 +3817,15 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	} else
 		rt->fib6_prefsrc.plen = 0;
 
+	if (cfg->fc_flags & RTF_EXPIRES)
+		fib6_set_expires_locked(rt, jiffies +
+					clock_t_to_jiffies(cfg->fc_expires));
+	/* Set fib6_table after fib6_set_expires_locked() to ensure the
+	 * gc_link is not inserted until fib6_add() is called to insert the
+	 * fib6_info to the fib.
+	 */
+	rt->fib6_table = table;
+
 	return rt;
 out:
 	fib6_info_release(rt);
-- 
2.34.1



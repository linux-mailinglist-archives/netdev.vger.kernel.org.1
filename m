Return-Path: <netdev+bounces-53102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E045A8014BA
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 21:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1E6B21156
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 20:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2955454671;
	Fri,  1 Dec 2023 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="fPGZbfrT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785A3FF
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 12:43:42 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5c2066accc5so774452a12.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 12:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701463422; x=1702068222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DGOijOKJdOqvHyhZyvR9Q5yxUXm8+4SFnahsPvs8Go=;
        b=fPGZbfrTlvKf3PNzLCrQsBhYLasWLJxEwJiFSFGFeIw2ijrvDsnXNsZEvE9CLOm6Eo
         Eg72GLKQihneFC4sF3mJmyAAKrN+3OJA+8EbRGyY/n5Fl6002mnAqyxe60bRJKuFKnDp
         wvazwTqjVlAQePhUlNzxhK+X4595LXXeZouNsf5g1lYZGq/SmsgU3aQL3Z17UwH0W9HJ
         S5sIaIgp1CGjYDg7px3f484+G2yFmcfS9HktCT3gghduW7UENxB8aPRy4U2wDLdmhGfu
         iNtrhALnolO/Mt7IJjUvaPapQDXjFvDAwvjhiSB59ZcpJy+Z2merJ/c8VT8sGUZIS9pO
         xKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701463422; x=1702068222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DGOijOKJdOqvHyhZyvR9Q5yxUXm8+4SFnahsPvs8Go=;
        b=H+0BqRM2tIWjQu+/L9ei1jrB0QeuV5ZFouj5eKs45/jryZP0g5pLFbGpkNAEuLetCX
         MYXT0Bw1F+C5IqHiuqrDQhv/p2LTWtQQbxqaEnz8G0EJRZfSrvdifYGzyAb6NoCvbK5e
         zclPkLePHn6QmW2xqZwMDgtwkdxJxgnRcqBd+cGbI9H+0mLLlkMduD70JIWCRPecX+f4
         Wyey+wFqGNYNAryYa9BspD12IUEKO/3tCptlC0d8iiuXKoHnhJeIpqTXgukgEx0+M0/2
         bfEqvJdEhaaL28YUbWF0TmmcbOmoid8LHsxn6zN9zbRhVFpNQSfiYotFZXBwlwXhrgdV
         sPow==
X-Gm-Message-State: AOJu0YyYYqXPUNmx7RL9LpOgsgTt1/HUsAFCWYsqTEOjDvRtSQjvV4dO
	BVQRdU+qzHRZH8x753xvNaJ+o2Tx1UT0CTwgA+0=
X-Google-Smtp-Source: AGHT+IEPklOggGhqkFhQ2Qsk3hdLlT/9jsyZdFT2aiWhHYupt/kHX/YivRA4EodBCfr+4zoVrZPmBg==
X-Received: by 2002:a17:90a:f016:b0:286:6cc0:8867 with SMTP id bt22-20020a17090af01600b002866cc08867mr110028pjb.84.1701463421817;
        Fri, 01 Dec 2023 12:43:41 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id mz18-20020a17090b379200b002865683a7c8sm1933467pjb.25.2023.12.01.12.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 12:43:41 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	marcelo.leitner@gmail.com,
	vladbu@nvidia.com,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 1/4] rtnl: add helper to check if rtnl group has listeners
Date: Fri,  1 Dec 2023 17:43:11 -0300
Message-Id: <20231201204314.220543-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231201204314.220543-1-pctammela@mojatatu.com>
References: <20231201204314.220543-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jamal Hadi Salim <jhs@mojatatu.com>

As of today, rtnl code creates a new skb and unconditionally fills and
broadcasts it to the relevant group. For most operations this is okay
and doesn't waste resources in general.

When operations are done without the rtnl_lock, as in tc-flower, such
skb allocation, message fill and no-op broadcasting can happen in all
cores of the system, which contributes to system pressure and wastes
precious cpu cycles when no one will receive the built message.

Introduce this helper so rtnetlink operations can simply check if someone
is listening and then proceed if necessary.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 include/linux/rtnetlink.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 3d6cf306cd55..a7d757e96c55 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -130,4 +130,11 @@ extern int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 
 extern void rtnl_offload_xstats_notify(struct net_device *dev);
 
+static inline int rtnl_has_listeners(const struct net *net, u32 group)
+{
+	struct sock *rtnl = net->rtnl;
+
+	return netlink_has_listeners(rtnl, group);
+}
+
 #endif	/* __LINUX_RTNETLINK_H */
-- 
2.40.1



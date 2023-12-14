Return-Path: <netdev+bounces-57484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F008E81329D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F857B21172
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7662D59E3D;
	Thu, 14 Dec 2023 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wrGhdgDT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1764CF
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:10:20 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28b011857f0so749656a91.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702563020; x=1703167820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+/3WYnJal5qQrhtD/BrhE5I0BuQauaDRcCBCns3ngY=;
        b=wrGhdgDTABsN+k297DBMyKJFZP62hyTJz04dcM7vtgXYqychz8PjHyN/3hkV7v45a3
         cfxMwofQEzBg/5CriZjTwYqs5W4bOzFiMOAPePWlKqFbuUckpkXuGQpDPVs9KjfiF3WL
         DzDcRxnaykao4oFyBkbupRGolmddtMdqsyCFTTthksuV6RomJGsyNMKujvBp8Fpq4uK1
         EM8wetxjIboghK+klsfZNd3OEWuN9R+mInsaJnkYkZlZiUs5f5POWYj0Ev3WsQbrNDYW
         9ENE5WH8MPv6zOjeJ2sWWv5KcPuakbgJIR77LqLNEeMM0jnWWW/CB7vZHwdJk/rxFY+J
         OeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702563020; x=1703167820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+/3WYnJal5qQrhtD/BrhE5I0BuQauaDRcCBCns3ngY=;
        b=ZBxzKm/YKEFW7Hnr4JYL1G74dAqYKlW6+M6PvAJ0/1G9Mk5yd0UVUF9wrTl52Tex9x
         nauQx6zUv2W11mKE0O0n89z8ZCTilpEVZl4UEQ2sSKCjPIzs2GUfMyY5d7Jx1nOW0bKz
         0pGhsIHVnUcLbL9Xo/W20Sgh+q1Xjdv2sef+6GeqBfXfPRM3Szb5TArOdnG3Ie09LN11
         jnRwdvHch0+VgMrkKF4P8Etyw06WxONQZQlvFP2NDcXbl50Aw4V5ioPXWFyO050cu8Vx
         +5gPaSXLyE1ZjAzg8r3ExQiW7MCV9MAAj/w3PZ9J+hb7QwhMHmWyvFfAC2Sp6bESSjbG
         Rrrg==
X-Gm-Message-State: AOJu0YwgmRK+jb/F9pCHRpprjPKgkXbZH9y1JSbikgeEtpKCS81VVeVp
	lscy+QKvnC413rMx/oCIV3r7qg==
X-Google-Smtp-Source: AGHT+IGd/MkA0tQt6L1hbx10uo0N4M3CV4ubtAqlczb0MdpnwrGDuAti0rcgwU4du76WxwYEWisgZA==
X-Received: by 2002:a17:90a:2a45:b0:28b:1fbb:c75d with SMTP id d5-20020a17090a2a4500b0028b1fbbc75dmr103563pjg.32.1702563020157;
        Thu, 14 Dec 2023 06:10:20 -0800 (PST)
Received: from localhost.localdomain ([2804:7f1:e2c0:60e3:4c1:486f:7eda:5fb5])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a430200b0028a4c85a55csm11028698pjg.27.2023.12.14.06.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 06:10:19 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: mleitner@redhat.com,
	vladbu@nvidia.com,
	paulb@nvidia.com,
	pctammela@mojatatu.com,
	netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next v6 2/3] net/sched: cls_api: Expose tc block to the datapath
Date: Thu, 14 Dec 2023 11:10:05 -0300
Message-ID: <20231214141006.3578080-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214141006.3578080-1-victor@mojatatu.com>
References: <20231214141006.3578080-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The datapath can now find the block of the port in which the packet arrived
at.

In the next patch we show a possible usage of this patch in a new
version of mirred that multicasts to all ports except for the port in
which the packet arrived on.

Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 include/net/sch_generic.h | 2 ++
 net/sched/cls_api.c       | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index cefca55dd4f9..479bc195bb0f 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -487,6 +487,8 @@ struct tcf_block {
 	struct mutex proto_destroy_lock; /* Lock for proto_destroy hashtable. */
 };
 
+struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index);
+
 static inline bool lockdep_tcf_chain_is_locked(struct tcf_chain *chain)
 {
 	return lockdep_is_held(&chain->filter_chain_lock);
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 6020a32ecff2..618f68733012 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1011,12 +1011,13 @@ static struct tcf_block *tcf_block_create(struct net *net, struct Qdisc *q,
 	return block;
 }
 
-static struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index)
+struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index)
 {
 	struct tcf_net *tn = net_generic(net, tcf_net_id);
 
 	return idr_find(&tn->idr, block_index);
 }
+EXPORT_SYMBOL(tcf_block_lookup);
 
 static struct tcf_block *tcf_block_refcnt_get(struct net *net, u32 block_index)
 {
-- 
2.25.1



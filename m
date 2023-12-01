Return-Path: <netdev+bounces-53103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F41C8014BC
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 21:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29839281D9E
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 20:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827C058AB5;
	Fri,  1 Dec 2023 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="VuQRjOYP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162A2FF
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 12:43:46 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-35942cb9ef4so8741085ab.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 12:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701463425; x=1702068225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJegg0KXpT9FOB7cbGUhiBOosv4mMjWt9zehWWNUU+4=;
        b=VuQRjOYP7oTXK2aOElG5bmM1b1+gaRh+GGYb/NMz5D7RN6/49lYI2MY/vOaFB6WIiu
         YmAMWJt0ig0k4f0mPvm7IQvoFKMYGMu7E56LFTUTVpEvVtEXZFnFRd0XYlXkmBvBWvK8
         EZBPLExs7A9o6ClykTpAkfirKs6kFqz9P3jTKV6k+Yu5tIdUNcD76yMn8+VhWYh3X6hZ
         1WewDgiIfLPMWxoepPotNUg8ffizkdIhnx2p4hDoRqlgdHa40AN9g774PBgMUbpK3qxE
         Niu3U2clNsxG19cRRgtAimEcsAL8DYf6jbBxCRDXaIDP+5/glWrL4ocj7pKsORqB84Cd
         rheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701463425; x=1702068225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJegg0KXpT9FOB7cbGUhiBOosv4mMjWt9zehWWNUU+4=;
        b=rVGi3zi1v19iIiYKbymlQIzE+/9kRS0QQaLE8p+KlBlxxgtjFuf+YlWc1AYbDC/0fO
         OZtTbhih9+AfGQAaYIsKmcS6BpfskB8SAz6WKTNZzYTbvILzgGThoHSsgcJu20PcBoF9
         S8ZoMMLnW8DtKPeTuZMeymxPNS20pcodqROu1m/MWsVtJaJi/poNPru1ADD4VyP9n6IT
         hKCHr8K+WS8mJq4kykayreEUUx2lH0gjaAdU/LKXVLl4JOfMo+wKS7McKzhUpzWP1KMo
         mcpZqGr7GteSnLLzYUQTVSs4doqIn/jmlXQFHSZBl9pVLGUHFePg6qPvQMJa2zsB9GCy
         p4EA==
X-Gm-Message-State: AOJu0Yzz3ZK4SCFmzXneDIIqqvSVAD2Ec1MADGveJOzhDOxCROLH0Fvc
	jHBWysIXK16tMKE67eH5XLL6iDnqJ/TwGIRmEWA=
X-Google-Smtp-Source: AGHT+IGXc4YBOPkuG86H1KTSVJKATjQz9dfgtQ7eJNOsf0CCfHTFRTwqO5peOlIACyRe54zFAT0/Pg==
X-Received: by 2002:a05:6e02:c66:b0:35d:59a2:2e3 with SMTP id f6-20020a056e020c6600b0035d59a202e3mr84556ilj.131.1701463425212;
        Fri, 01 Dec 2023 12:43:45 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id mz18-20020a17090b379200b002865683a7c8sm1933467pjb.25.2023.12.01.12.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 12:43:44 -0800 (PST)
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
Subject: [PATCH net-next 2/4] net/sched: add helper to check if a notification is needed
Date: Fri,  1 Dec 2023 17:43:12 -0300
Message-Id: <20231201204314.220543-3-pctammela@mojatatu.com>
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

From: Victor Nogueira <victor@mojatatu.com>

Building on the rtnl_has_listeners helper, add the tc_should_notify
helper to check if we can bail out early in the tc notification
routines.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 include/net/pkt_cls.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index a76c9171db0e..39c24cf30984 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -1065,4 +1065,9 @@ static inline void tc_skb_ext_tc_disable(void) { }
 #define tc_skb_ext_tc_enabled() false
 #endif
 
+static inline bool tc_should_notify(const struct net *net, u16 nlflags)
+{
+	return (nlflags & NLM_F_ECHO) || rtnl_has_listeners(net, RTNLGRP_TC);
+}
+
 #endif
-- 
2.40.1



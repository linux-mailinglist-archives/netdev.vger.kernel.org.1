Return-Path: <netdev+bounces-53056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457328012AC
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766651C2106D
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800C254BC8;
	Fri,  1 Dec 2023 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Plrq2LPG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67004115
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:29:16 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77d6f853ba0so291714685a.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701455355; x=1702060155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yEUgde+83Ie/CIdVOsUg/bpNgJ9RSPY4XMDhZVyzr4=;
        b=Plrq2LPGj1aKw4BsiweqFAv+foOTArO8h3GWyJ1Oo60NP+HNPXH1N1LKTwsd+9nDxY
         ZbptVSXwAsbALU9/pTmUdNyLDuMSwIayfP+W5pN57DjAO4/dPnaVQO+wSgs46aY2Unp5
         bMkiKRs7AAixbHVwyPjtlie0nzmTZo4DiZF5ZpsWfC5694/NjZd9T3+lsCBnQftUqhvY
         QSb81lxjnD/Zd+jCsybMugNt0HsBD4VeiHlPGfhULhZqrk2BdgJONQZhHeyBpQd+amYn
         ca+rEpg+DiA0CVLbTisJYcEQCLJm8Sgi8t4hU0rX8AxjwiEKvjIxUr+NLRQX7Tf4gU3z
         8g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455355; x=1702060155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yEUgde+83Ie/CIdVOsUg/bpNgJ9RSPY4XMDhZVyzr4=;
        b=nB+fzI4jSc7cUpRGbq7UPFYpp1cnbXLaGRrpaTKMprEBKcYwEqmrJ3cmBOrgbGvsSZ
         p2n31IA7i/J2tZfE0kgvCZQz/sHkZgIkAnCp/mOEEyqGUXv9kf/ZrQN+GWf2vqNC8JEM
         iK8HQkCjr9Rr0ZglRsHV7rV5Hs9elwsgM26Mipttf9nziG0pLlm0C7yYB9uSxv+yFo3c
         zu+Ytts6zzVPBBsYb4AW/U0Fl4ryQNaMsNXdEllxZ9i3k/ExhGFUXtWTGUoffCcFqOLq
         angtWnkGG9OgSfLDUYYNg/OIxEsVZDSnDa/z57JbaDm4b1tUSZ6/HzOgTpbGyIeVOAY8
         +64Q==
X-Gm-Message-State: AOJu0YzMXJ5XWfNCQO4r1snUwHnOPY5YIVv6TxS1CyR+Ot00hb0IFws/
	URmFFVTRfqspzQqBe9ZGhMctUkyTx8Mq+V5bJEs=
X-Google-Smtp-Source: AGHT+IE4VKyvO/TX7snHPzNo5xf7dVcdpdDQrNhd38IzIYIdp0m8wVAYb63AjFqLfcFllktj60vUIw==
X-Received: by 2002:a05:620a:4f:b0:77d:c51a:3242 with SMTP id t15-20020a05620a004f00b0077dc51a3242mr14895373qkt.19.1701455355225;
        Fri, 01 Dec 2023 10:29:15 -0800 (PST)
Received: from majuu.waya (bras-base-kntaon1618w-grc-15-174-91-6-24.dsl.bell.ca. [174.91.6.24])
        by smtp.gmail.com with ESMTPSA id s28-20020a0cb31c000000b0067a364eea86sm1702536qve.142.2023.12.01.10.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:29:14 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH net-next v9 06/15] net: introduce rcu_replace_pointer_rtnl
Date: Fri,  1 Dec 2023 13:28:55 -0500
Message-Id: <20231201182904.532825-7-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201182904.532825-1-jhs@mojatatu.com>
References: <20231201182904.532825-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use rcu_replace_pointer(rcu_ptr, ptr, lockdep_rtnl_is_held()) throughout
the P4TC infrastructure code.

It may be useful for other use cases, so we create a helper.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/rtnetlink.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 3d6cf306c..971055e66 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -62,6 +62,18 @@ static inline bool lockdep_rtnl_is_held(void)
 #define rcu_dereference_rtnl(p)					\
 	rcu_dereference_check(p, lockdep_rtnl_is_held())
 
+/**
+ * rcu_replace_pointer_rtnl - replace an RCU pointer under rtnl_lock, returning
+ * its old value
+ * @rcu_ptr: RCU pointer, whose old value is returned
+ * @ptr: regular pointer
+ *
+ * Perform a replacement under rtnl_lock, where @rcu_ptr is an RCU-annotated
+ * pointer. The old value of @rcu_ptr is returned, and @rcu_ptr is set to @ptr
+ */
+#define rcu_replace_pointer_rtnl(rcu_ptr, ptr)			\
+	rcu_replace_pointer(rcu_ptr, ptr, lockdep_rtnl_is_held())
+
 /**
  * rtnl_dereference - fetch RCU pointer when updates are prevented by RTNL
  * @p: The pointer to read, prior to dereferencing
-- 
2.34.1



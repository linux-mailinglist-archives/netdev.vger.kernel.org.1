Return-Path: <netdev+bounces-37169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0A67B40F6
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 16:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 56BC328300B
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 14:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214CF14A8E;
	Sat, 30 Sep 2023 14:36:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5848915AC4
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 14:36:04 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA236FD
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:36:01 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77386822cfbso1029135085a.0
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696084560; x=1696689360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yEUgde+83Ie/CIdVOsUg/bpNgJ9RSPY4XMDhZVyzr4=;
        b=UHf1aDRwJrzz5sSYVXkXs3k6HxdrLkJweTbNvnoYDW9m7aAXuxHhAYnZlrDKir7cek
         jDqWIYqIYAXY1JMaODulF3VdVT80zcMvUvZ+E0yMLN9TaNpFXSqkZGPgfBC+WUCg9SI0
         vg9t8dS7+MYZaOE15Lw3qGrs+iU+leljZQIVqNs1DS20PAE8GGbDC6wF6O9bggp3owgr
         lbn8LIJqd9qC9xiWpcFveg1LwOdxduwtOwbPj1Px3rg+tj3rIK1T890qzbkmCwzLkZJf
         RaY/hxegofcBWcuHayowUNctpAJLNZe6gO9Ka603ss489Oy3Kv5cwgY3YdcH5BY54D0n
         DhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696084560; x=1696689360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yEUgde+83Ie/CIdVOsUg/bpNgJ9RSPY4XMDhZVyzr4=;
        b=dW9JjGL1URkmXdmvdFhL/9u2hGoLYJWWjnit/oDR6EDV/ojfJ3z22ztXyzUtIdlUF+
         5o96fXKNqOeS7h7yAKnwY3S46hUHCXHyuT+Ims9IbKWlFsZ0vN0fpZLWh/EqiQmlTfNH
         yMwIlv2gLqj2uh1EclcAIuYf1WqThD++8GJeOI4RJUSDGLWIh1fSOerWSiDqOcUM+5O2
         heGpDBwnKquKNuVxxkBn/GGTN8YTw4x46pcAQwhFkHcaFUM8fuiw/Q5jBlbSdgGZAzXT
         CPfuOm8BrQDw15WwMsUFMlXHxMj42JoA+nahQ0+DCTMfUPBWWENoBAqgGqsulruuCcGz
         zvuQ==
X-Gm-Message-State: AOJu0YwPRjOtv9JFjjpp07fO8bzcIeowkByeA5bZ2xPyH3wtnq3nzz4Q
	3RJCxJFKr4sSUolGG6tBgLkaxcjA3X9QEGN6/YY=
X-Google-Smtp-Source: AGHT+IG8Rfz9qFnQd7CjeD+o+jCgavbpE+GPBfyTO3QkUmgh7gOfakJiVndwC6W+1R8+4eG2LtzYlQ==
X-Received: by 2002:a05:620a:4101:b0:76c:bb4d:97cf with SMTP id j1-20020a05620a410100b0076cbb4d97cfmr8055456qko.24.1696084560268;
        Sat, 30 Sep 2023 07:36:00 -0700 (PDT)
Received: from majuu.waya ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id vr25-20020a05620a55b900b0077434d0f06esm4466409qkn.52.2023.09.30.07.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 07:35:59 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
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
	kernel@mojatatu.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH RFC v6 net-next 06/17] net: introduce rcu_replace_pointer_rtnl
Date: Sat, 30 Sep 2023 10:35:31 -0400
Message-Id: <20230930143542.101000-7-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930143542.101000-1-jhs@mojatatu.com>
References: <20230930143542.101000-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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



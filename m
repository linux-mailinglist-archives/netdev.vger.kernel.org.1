Return-Path: <netdev+bounces-17203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744A5750CD4
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6872812FC
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ECE3D394;
	Wed, 12 Jul 2023 15:40:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F273934CFB
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:40:14 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9221BDF
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:09 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6237faa8677so36562996d6.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689176408; x=1691768408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yEUgde+83Ie/CIdVOsUg/bpNgJ9RSPY4XMDhZVyzr4=;
        b=VvbCwdjSai1MxaLSnu/VYWcqRtqwo7Bmx5uHX+A50dia6uaM/j76aMvgfMMRsoZsHS
         MPtjMtzq2b0NsnPmNpNJMNp7m93ob+WABN+9hBrOUxG27rs7vFSQAfOqzgP6N9HJOZMA
         M244nvu69Hd1MqAvzgL3+2ZxIuh6usvudcCGI1+/U7oV+ssSzrBpspvr8HwAlCDR96Zz
         /P/6XBejdHK/Ar+nZ7RErUjDPDRsu3kdW1titeJVN4BXYqzGmqDOrbPA4yBEQxvzALzc
         /GkX01qKWcNgILDKmrN+0rPYcOB/jpnyr7lbbW6jnF6C3pu/Q23+jTrUNG0wx2Nt9uBm
         WnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176408; x=1691768408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yEUgde+83Ie/CIdVOsUg/bpNgJ9RSPY4XMDhZVyzr4=;
        b=YcFm8ot+d36mg1mVFEmmBE+GD0qJ1/uunQRTfO+csB/x9pB7Rhpi2EgA7C3EEMikmc
         ZUGddk5Twpj3F4C2e7MsBOFBqGkgjTx75g3mQbT1+BZRNa3PVkW10AafSAloo7x8Z6+a
         EU23Gqcdq3Q8ILHgTlJxZKD9zADd89nDk0g18QF9jnat9f+X8897r5EUhVGvU41HWd32
         VlUWXUN75K8ANn2bek7JDkAmGIbA/j4CiZ8y4UyE1mT2XZQ+VHsRHswB5hlmL/sOaLQ1
         9hKVv7seB91hnOf9PjZeM7WdeHiEwx4QUsNysn6gnd34U3JsHNrTliOwVeWsBMCpmlww
         Ne6Q==
X-Gm-Message-State: ABy/qLbhsm8Inpt6eaQmhLeHkw23SVCs2fkwo/t02/NMQk+d9w8byhka
	8cBGIC8hxEkmbisVpp0+MsU+m6FM70Ug+qN1MqOFoQ==
X-Google-Smtp-Source: APBJJlHFP0IWmk9VL8xhRP8xVqePXfP7ej6Y5jMSMBXWDNnq0g2LHbMmRchbYhE3+k9QEliDEYZa7A==
X-Received: by 2002:a0c:f08f:0:b0:636:9b4:c7fb with SMTP id g15-20020a0cf08f000000b0063609b4c7fbmr14843906qvk.42.1689176408092;
        Wed, 12 Jul 2023 08:40:08 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id r3-20020a0ccc03000000b0063211e61875sm2283827qvk.14.2023.07.12.08.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:40:07 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	simon.horman@corigine.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v4 net-next 06/22] net: introduce rcu_replace_pointer_rtnl
Date: Wed, 12 Jul 2023 11:39:33 -0400
Message-Id: <20230712153949.6894-7-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712153949.6894-1-jhs@mojatatu.com>
References: <20230712153949.6894-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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



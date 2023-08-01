Return-Path: <netdev+bounces-23165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A40276B375
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4E61C20DAA
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B9C21D22;
	Tue,  1 Aug 2023 11:38:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7796320FB4
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:38:31 +0000 (UTC)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D831B0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:30 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76571dae5feso455752185a.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889909; x=1691494709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yEUgde+83Ie/CIdVOsUg/bpNgJ9RSPY4XMDhZVyzr4=;
        b=mO5ADxfOd66HThxvZKPw1HzaycTi/55Y28bAHffoUcjazRN3EmY0bhZ5CYOH2BYE3r
         zqeQXVoFv2lFdv0LznQjVntgQ3piidXFMm4u82gjBfDtZjq86W4RhpSHnOl8siY+pWok
         4sM/7zEoQW3GrRox9Zidi3TiBzs6b6jjPaBm0LMWhTnMCCqaikTA9/ynVB7VC64i/Pv7
         9NGzz28cb3F3xbQxdgHAPbVBN2SkhzaDMgYck64EpAn2ns5vkbL/mclrlPEWvgepxc9i
         tU9RU5x1EVjwIa+ApA0a3t2LKHN8eg2lRL/kHGhQQw5qMQSJbcBYqLhvIXZoBMtWWbBp
         FZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889909; x=1691494709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yEUgde+83Ie/CIdVOsUg/bpNgJ9RSPY4XMDhZVyzr4=;
        b=Uq6rvrj1Mey5mEBObAGNPscF2pDDEMDU9qqHHPhk9rJnazQbFLvpOXXKiNoAXCBcRO
         kDw9vmyed33yzVn4W4S2M850E0hjFPoIjSU5thKHgLZpFPfzxlhs6gyeeJYu+4RaBjFz
         JfuJcfzP6QbG07Wzjep9+hEFMon3slgt97iR1lPTqrdqJH0hDcFvAcnVkO7tioMxelPg
         VppJ8Z3eaN95oAjFe9BxU+6gazsv2xb/399oKxiYJ1u6EOrOF5CYs+511Qlr7y5Nu+1O
         mF4sfhKDQq47vAl1wNsac1j/AEDuN7iSXaHQqWcgxVU7Bm/A4mtBgKhtupPd2G6GYYtW
         /1QQ==
X-Gm-Message-State: ABy/qLZSINlNqj0ZedlUwuDNFKY5DivxI9RsgOHjgTTuu8xVqBMvSMv1
	ShMK85P2fBBrVm3nXKLzhujULXoCOZHPnLkZr26xjA==
X-Google-Smtp-Source: APBJJlFyY+gag9KoOYZxfQb8cyu9TVC3rqZDn/2tClxVNbw9bukTGqjmIt46OUw1R9EUGnJ+i3dXrQ==
X-Received: by 2002:a05:6214:518f:b0:637:a75:2473 with SMTP id kl15-20020a056214518f00b006370a752473mr14605082qvb.7.1690889909030;
        Tue, 01 Aug 2023 04:38:29 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:28 -0700 (PDT)
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
Subject: [PATCH RFC v5 net-next 07/23] net: introduce rcu_replace_pointer_rtnl
Date: Tue,  1 Aug 2023 07:37:51 -0400
Message-Id: <20230801113807.85473-8-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801113807.85473-1-jhs@mojatatu.com>
References: <20230801113807.85473-1-jhs@mojatatu.com>
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



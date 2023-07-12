Return-Path: <netdev+bounces-17219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAFF750CFC
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897F9281AD4
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA57520FBD;
	Wed, 12 Jul 2023 15:40:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE2C200B1
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:40:38 +0000 (UTC)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E041BE4
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:33 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4812f361e67so335949e0c.2
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689176432; x=1691768432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxozgYPIJezgNc0ZLNNqct8fkxA6ty7Q7qbLZpS6mBU=;
        b=twm6EipFYeQrQiGewMltJGj2LmtMPm5l4mp5SIuKFn+YvkijS/DvpnPa6S/j0SSOnk
         +gjkgP4SuHs0A7BSMW9VI3VTa6/MBzfOW8SEeVptnM3+7WfBXz2k2V38tlSJ5FUHmJgD
         arV1oe/kPJDEjqdbfhnEX6jCVN18QZRLgiaqRtWyJZxBwHy2CVQg8nyDd/tCKBl3wi+f
         hVD8k8fTToX056H+raPHqwiPEaiGzOzBtnBjSSKNXXHwZhdYicrYFVs2qQNY7R5O6ZRR
         6ZSO8sCC/dlwDU5TmW/fFfSBcf2+/07SwpD9ulR2JaqTUP2N6A/RRu3cCwwJTL8C3aMu
         n9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176432; x=1691768432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxozgYPIJezgNc0ZLNNqct8fkxA6ty7Q7qbLZpS6mBU=;
        b=ED82wO1QTwMxQ6gxQ3vvqy+QwrwDjd7iHoeZ8EO1EWy4WxoWblXwuxM3aOJUs2l9ay
         aKE40rWsHqqLAJYVghoh58Am766NNWWD6TeABSzRTzh4xV6vP1RwZnRA2Gq6F46UScK9
         Elf554urGYE6nsHmJcMpH2/Po+neGPEphbIPGV/OcnavAENxcBYTDo+s8ZNJ801RO0xu
         STm9s0jrA3VCuM8fEju0syMju5pG+lo0X8A8+YjRaYZIXZ8TudfiSSTS6veV1qv6w9iC
         ozHrkLZq8dbUT7r5II1KjeF7ZRxDygbXoOqcJbHYrowke4AU7ciW5qicFKT1m88IFnCU
         MO9g==
X-Gm-Message-State: ABy/qLZiNmLZ2/2RpxQ3AVbOF71Tngze6uk1kqYb6sD0U0Fjjuh3PMie
	yZ1eofeWqkEWt/BuWhch7ZDvF7GAD7AEu1AZDWQzww==
X-Google-Smtp-Source: APBJJlEAoW0RckiXeMne2tjfPx3cH8p0EjXETM6imMtQ1CcE2197gV/wl3EZe97NdOKvTNQ1iBARsg==
X-Received: by 2002:a1f:bdce:0:b0:481:2c13:eabb with SMTP id n197-20020a1fbdce000000b004812c13eabbmr2027759vkf.12.1689176432527;
        Wed, 12 Jul 2023 08:40:32 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id r3-20020a0ccc03000000b0063211e61875sm2283827qvk.14.2023.07.12.08.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:40:32 -0700 (PDT)
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
Subject: [PATCH RFC v4 net-next 22/22] MAINTAINERS: add p4tc entry
Date: Wed, 12 Jul 2023 11:39:49 -0400
Message-Id: <20230712153949.6894-23-jhs@mojatatu.com>
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

P4TC is currently maintained by Mojatatu Networks.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ebd26b3ca..32f6cd30a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15782,6 +15782,20 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 F:	Documentation/filesystems/overlayfs.rst
 F:	fs/overlayfs/
 
+P4TC
+M:	Victor Nogueira <victor@mojatatu.com>
+M:	Jamal Hadi Salim <jhs@mojatatu.com>
+M:	Pedro Tammela <pctammela@mojatatu.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	include/net/p4tc.h
+F:	include/net/p4tc_types.h
+F:	include/net/tc_act/p4tc.h
+F:	include/uapi/linux/p4tc.h
+F:	net/sched/cls_p4.c
+F:	net/sched/p4tc/
+F:	tools/testing/selftests/tc-testing/tc-tests/p4tc/
+
 P54 WIRELESS DRIVER
 M:	Christian Lamparter <chunkeey@googlemail.com>
 L:	linux-wireless@vger.kernel.org
-- 
2.34.1



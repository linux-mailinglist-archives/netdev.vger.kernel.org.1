Return-Path: <netdev+bounces-23978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1695276E67D
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C542028204C
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FB817FFE;
	Thu,  3 Aug 2023 11:13:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F948F7C
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:13:51 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CD0E75
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:13:46 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a640c23a62f3a-99c10ba30afso422955166b.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 04:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691061225; x=1691666025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0LhtMaDHhRm3mbnKfWT8/Dhmh40h6lBxv/BhmqqlQo=;
        b=XkoPN3HjHRBwVJxQE1gkkobS8bzHGBfG7clAoAmoZTMWeEqghxm1EOZoXnxl8ME/1X
         gXpqFgPrSzsA+Vg2At3W3nnWHfGf3zlIBhbR8uW4tdQwdFGKTGtv1gE8f6T1cBe101+T
         ER8S65DIiQwjiRQPInKr9kjYjBNmybhC1wbou+VcD0F3IU5C3EIM6l3zMYd92J9onGAP
         b8b/zZ6S7UvBKOPC8sP1IVjehyRp0/S9YmzoEiZVAzfw5Iiy8ZPXzp9srBpP0h0/Vkdt
         D1tNV8mQSBrOuaINKoJZPotKk81bcGMbLyVonkmbtYMQS3aknOaK8N24jkdblvo2MtsL
         jzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061225; x=1691666025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0LhtMaDHhRm3mbnKfWT8/Dhmh40h6lBxv/BhmqqlQo=;
        b=Qo573dLC5RjAmadYeHN4+LKdtF29+2KnxVlaRpSQIXTzPyckZZZ8QSFbs2nbg7TFSS
         3e+EC7A8PG2hj6q3Gc5PKNMg5sWQPzpZ6Wp1feNA6Yz79FXAbET1ZCdlQ08IAArkfDWP
         oYiePEgK7+L25ErV1NhiVfGa1gigFBcHbnRGwd623LeVTlY8sdbD3nUCcqvAPE6lF0Ld
         Kn1KMnRaCuSZUEkrZuRRW1LciG4ejnEiyu7GMKqmTxOKuComAwQlr3/fTPWa53Zph7ch
         apmd+6CRHdL6J5MV7Ib2CdbyDRrK8HYdDPZPJitgfZNAC985fRoWrvRMJnOsvUrpcVFN
         2uCw==
X-Gm-Message-State: ABy/qLaiM4ShgqMngTaQRPjS8CGUuF/NXEfAOILpbIAs+DRP05L1Eum1
	YbXrB0SNkRlRYz8EGTYs1O4C8kQoMjHfC/E/PiBIT2Bs
X-Google-Smtp-Source: APBJJlEX/gpQ+ZWPByGKB5SUDU6QnKKXNRvwXErm2eI1xMBVfyeNHKqfqZAcJ+mnEZEe0sC0WXdQnQ==
X-Received: by 2002:a17:907:9686:b0:98d:ebb7:a8b0 with SMTP id hd6-20020a170907968600b0098debb7a8b0mr10858705ejc.14.1691061225152;
        Thu, 03 Aug 2023 04:13:45 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id gw19-20020a170906f15300b0097404f4a124sm10400868ejb.2.2023.08.03.04.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:13:44 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	moshe@nvidia.com,
	saeedm@nvidia.com,
	idosch@nvidia.com,
	petrm@nvidia.com
Subject: [patch net-next v3 02/12] ynl-gen-c.py: filter rendering of validate field values for split ops
Date: Thu,  3 Aug 2023 13:13:30 +0200
Message-ID: <20230803111340.1074067-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803111340.1074067-1-jiri@resnulli.us>
References: <20230803111340.1074067-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

For split ops, do and dump has different meaningful values in
validate field.

Fix the rendering to allow the values per op type as follows:
do: strict
dump: dump, strict-dump

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- consider strict-dump flag newly added by the previous patch
- re-phrased the commit message, altered the patch subject a bit
---
 tools/net/ynl/ynl-gen-c.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 650be9b8b693..a3f70ca929fb 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -1988,9 +1988,17 @@ def print_kernel_op_table(family, cw):
                 cw.block_start()
                 members = [('cmd', op.enum_name)]
                 if 'dont-validate' in op:
+                    dont_validate = []
+                    for x in op['dont-validate']:
+                        if op_mode == 'do' and x in ['dump', 'dump-strict']:
+                            continue
+                        if op_mode == "dump" and x == 'strict':
+                            continue
+                        dont_validate.append(x)
+
                     members.append(('validate',
                                     ' | '.join([c_upper('genl-dont-validate-' + x)
-                                                for x in op['dont-validate']])), )
+                                                for x in dont_validate])), )
                 name = c_lower(f"{family.name}-nl-{op_name}-{op_mode}it")
                 if 'pre' in op[op_mode]:
                     members.append((cb_names[op_mode]['pre'], c_lower(op[op_mode]['pre'])))
-- 
2.41.0



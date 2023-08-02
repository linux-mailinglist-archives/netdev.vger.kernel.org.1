Return-Path: <netdev+bounces-23677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C78A76D1B1
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CC11C212BC
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D7B8474;
	Wed,  2 Aug 2023 15:21:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D35EAD2A
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:21:14 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E8B2D74
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:20:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id ffacd0b85a97d-317716a4622so6410602f8f.1
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 08:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690989629; x=1691594429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0LhtMaDHhRm3mbnKfWT8/Dhmh40h6lBxv/BhmqqlQo=;
        b=zwZSFFg0xcS1wi6bCBGhtGm0EXLe6emOvD1g4F318i01oBpfOw4f9+rXoq846D3xOs
         fOZ4vrikEFiud83LB9uVsVD8ZU2On7UoalNc/lvRCQlAw2XoiUENsmuuf5yWZup6B/DN
         C570T+eho9+Ti02RCzKBVWs7VG11+bijz3WJhsEZej7GQF8SzUYbrakZZMABGnMTl3l1
         omljMM31bcl8x5JAgMYV8MBpaE58KjI1D+FKf0P1NEf6ht4D97vzmL0J+y3FXDRZTfMf
         /YPW/nK5Hdmj1tWpr39cP+mKDOLK3EeQSeWpB1ijnutnJGSsB7rqDYZ25Kngj9W4kIae
         yOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989629; x=1691594429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0LhtMaDHhRm3mbnKfWT8/Dhmh40h6lBxv/BhmqqlQo=;
        b=hvwvydLU+zenv5QSZ2h+vzWPCf176Iog7MrSvC3yG2k32X/T65En5KNk3vQmYLqXgz
         V7Opl+cUOc97nfbOFYyM0AupP6DxBVPkfVia/F6rPGizCELwJQTXGbj2fq5O5RtTVTn8
         cz2AFVeGa8BQqOaMdvrVM78R0D6FIH5wWo9LZiIVHD6AEdYyDPRLoQ1tvLrFWy91SWWw
         y+NKOa1ieQOV3eQqd1kO0YltwHMsEgyOgTX0zaasC1Qh+0j2Ua0mhp/1g3eb5jGlrtDe
         8AYU61Jh+HQFV4J2piS1zc+Jn5M6ZaYulYzyFWPm70EV3l7ZOyetOg45IQN3StpnwYNb
         7XvA==
X-Gm-Message-State: ABy/qLYNFtqlMXpRySmvL7dScZu/uEHfz3Gm9PIY1bVIHR8eT13yL64P
	YBI67+JWa4rO0aRGj8RaTcvfsGUqHrNZ/eBRHojpArvV
X-Google-Smtp-Source: APBJJlGPJDaOcQtpHNPltbUnswYs61j1ld1B31hVl3ZMvkchZR000IdlEG0eoNTwWpgDD98oBv3KkQ==
X-Received: by 2002:a5d:6082:0:b0:316:fb39:e045 with SMTP id w2-20020a5d6082000000b00316fb39e045mr4799283wrt.48.1690989629094;
        Wed, 02 Aug 2023 08:20:29 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id bf10-20020a0560001cca00b0031432f1528csm19301649wrb.45.2023.08.02.08.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:20:28 -0700 (PDT)
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
Subject: [patch net-next v2 02/11] ynl-gen-c.py: filter rendering of validate field values for split ops
Date: Wed,  2 Aug 2023 17:20:14 +0200
Message-ID: <20230802152023.941837-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802152023.941837-1-jiri@resnulli.us>
References: <20230802152023.941837-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
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



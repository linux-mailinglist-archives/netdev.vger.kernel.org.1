Return-Path: <netdev+bounces-23982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CD476E68A
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E00028207F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 11:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B3F1ADF1;
	Thu,  3 Aug 2023 11:13:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8954E19BAD
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 11:13:53 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF09213F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 04:13:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52227884855so1063789a12.1
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691061226; x=1691666026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xm8m68R8BaH37vwbMbGP10geA0/w5IB1ToC+Q7Nn46w=;
        b=YEKo9jJLNLOvgyugG03qDkMOoC6GLR69SLJNnQHo8RfAlUh+Vu+q+ch06WONoHuZ+V
         Ee9gMquRu6ALOsHGi1LqFLgHqfoPQ7MUAHNCushg7TFoHcNFilgUzY/A4QIrhZC9pwIi
         ma+4zOaBrfkVez9MM+YBUQEtWAnHrUaRBTvJKbCd1Z79HbYWT81PPLOWpxOrBNv9zp4m
         TIoFBA35xSBdRyzAUF89sDaFwYvncdldE5T/Uocu0+racdz8u5Y79eT5e8bcp8JfhImJ
         NEiok7yI7PGM4TgJgubX+XLbUQiYN2nsL8D6gqHtoosz9aKPxVmqWXGuk4s5XM9z6T47
         itlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061226; x=1691666026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xm8m68R8BaH37vwbMbGP10geA0/w5IB1ToC+Q7Nn46w=;
        b=Kh/pui1Nm/syvRFggRaXIj9XnYGHMQ2gsVDGTdDO8nvnjyu8DBfXx1GsKxqiHTpCzz
         82vtSGGOcP+2EL3+LyElF7I9GENSn6Hl2pYGTghM5dBDlHZUvdsDG6rII0IJXyOgmxvJ
         k7Ih5Fzv+PVPgYEUfBwWPbL9/r2xA8eWCNawC6n+OK/u0Kkfmx2clW0UDcxhYkRnxoiG
         EU3Ng4/RC+riiuJzgNA/eifpyivbAPfSIMJm1zcoYh4bn27iyUhHqMNk7c3sSXe71NAP
         P5nSQIaGWhZk1Ok0owk+IIyAX+ve5ovvIGgTU3uNwNrZAVK23W4mktGk7mPdID9R/Ds4
         bC7Q==
X-Gm-Message-State: ABy/qLatScdrc7J2j1S8/YvMfVThO6nnuvwY3lLbjNrKGycQOfgyzdDD
	HoSHLB4gZQItwLLxzpyHQ1UwSpBd0K7B6oL+aEvLIA==
X-Google-Smtp-Source: APBJJlEt0Cqgv7xx6DpKbWuPNXQyfcy2oZpYPVD5AbGTnreMl2LMn04TMvlnKrqzKu5P69w8e6i78g==
X-Received: by 2002:aa7:cf01:0:b0:522:455d:6f6f with SMTP id a1-20020aa7cf01000000b00522455d6f6fmr7760947edy.34.1691061226561;
        Thu, 03 Aug 2023 04:13:46 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id s11-20020aa7c54b000000b0051df54c6a27sm9992230edr.56.2023.08.03.04.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:13:46 -0700 (PDT)
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
Subject: [patch net-next v3 03/12] ynl-gen-c.py: allow directional model for kernel mode
Date: Thu,  3 Aug 2023 13:13:31 +0200
Message-ID: <20230803111340.1074067-4-jiri@resnulli.us>
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

Directional model limitation is only applicable for uapi mode.
For kernel mode, the code is generated correctly using right cmd values
for do/dump requests. Lift the limitation.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- fixed double space issue
v1->v2:
- re-phrased the patch description
---
 tools/net/ynl/ynl-gen-c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index a3f70ca929fb..2ea6af892b68 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2317,7 +2317,7 @@ def main():
         return
 
     supported_models = ['unified']
-    if args.mode == 'user':
+    if args.mode in ['user', 'kernel']:
         supported_models += ['directional']
     if parsed.msg_id_model not in supported_models:
         print(f'Message enum-model {parsed.msg_id_model} not supported for {args.mode} generation')
-- 
2.41.0



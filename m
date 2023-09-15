Return-Path: <netdev+bounces-34186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E0A7A27E8
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 22:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C2C2823BA
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 20:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9C51B273;
	Fri, 15 Sep 2023 20:16:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3C1B26D
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 20:16:39 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206BF2D66
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 13:15:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c1ff5b741cso23500135ad.2
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 13:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808912; x=1695413712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DD0PB0X4P5RpnzepdYBK20P6YgyKEeTbO8VvW3SzPE0=;
        b=bj9GANvp8YMMDuzcyMnE4zefjLBFuDD33Jq2y3Phwq7y9R7lwZIczNSCqX4LThWcOJ
         9Khb33XoLSMbUtZdO4wfd5q2Lw9YSy5Df2WV5q8aYt8f0ZwUulF2JbFrucv2Q/e8E689
         +oCl9AIiLj3uEQFpgJZkCDRVN/JRnzz86fj2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808912; x=1695413712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DD0PB0X4P5RpnzepdYBK20P6YgyKEeTbO8VvW3SzPE0=;
        b=Hp0Kr88nW2FV4aPsFqPYY5GLen8MpzEFUGu7NVmgM5K5un29fYO6fcUEHHezTENvBt
         b3DSkww9U29n9jbR4NqiTKdXPgFzbXB2DtKdU9Anae2f69aZQ6K2giZLK/0zet+e2qkR
         8SqR5SV5V+5+jg8Y+NUUwQcc+4LLnQHbfoMFQebIP5NPN3TC6Hyd1g4FE2b2F6bpobPx
         rX8EqXTYt6DFtgyr0qKDnximQumc+KF/JPqSeJ5ZfqbvlYo120ZkuvfM47hr8duxEbEE
         yHwuArCMo3bsMXRHj3xJ5pjHrLhdtj+D2KoO9o6N9Rkac5fYOWBEFsDbsaKj/JuQcoqz
         1tlg==
X-Gm-Message-State: AOJu0Yz4w3Qyz9rxiZSAqOTTJIgn1aCgpFsoD+29sT31wOxaadbT5ZhV
	Lis3Cmov7PcXutDNhtn3qolJTA==
X-Google-Smtp-Source: AGHT+IFr13PLzk1XhNPHi5wQPBvpKN+JrCaS1AIy+WjDkGW+MxaOGCJr4sl9jUsUrz+Gxv7u4wWN9Q==
X-Received: by 2002:a17:902:dac7:b0:1bf:4582:90d with SMTP id q7-20020a170902dac700b001bf4582090dmr3499033plx.46.1694808912608;
        Fri, 15 Sep 2023 13:15:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902b28500b001bb750189desm3860366plr.255.2023.09.15.13.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:15:12 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	ceph-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] ceph: Annotate struct ceph_monmap with __counted_by
Date: Fri, 15 Sep 2023 13:15:10 -0700
Message-Id: <20230915201510.never.365-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2263; i=keescook@chromium.org;
 h=from:subject:message-id; bh=459xt744zpKd86AyMgpOkR51nqx31Cb+Bg+uK/o0T7M=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLtO5BRclquwJun9hzXP0EWlZ+GoTdZhGJ3lG
 aGjx/Zz1HyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS7TgAKCRCJcvTf3G3A
 JsmGEACL2A1XKUQWibswLmpq3EltVpG/A8eKgv6ea2LwVOAXy0x4SXG4cHd9Cu0nk/qHBUbSafm
 /LRlD5lO/9C+ATYOdVAn9t0V3au/VIjn21sAW1gMsSMXTEBt4RYva6+8ekRrcCE6zJyxKRcZ8FV
 1TP0oLZ+aZEmq83/afsOUMhAKZ73EU1YJrP2y7qEuhd9AasIKJxUVGM7DVcfrya6r/JmudEniQ/
 slYEzs/iOWTdsEj98u6gHbxVZWi3l4+Z2chqEOmaA47jYTbgLzIPmPYPYPcWB1kjzGWo7sTENSL
 snWzCkLtSJUMzl4dC2P8qEjNTs9Z97Zfy+yyMAePSR5RQLGtIWKXITcZgFCekUIF7vLjevaPaV1
 +LaCKf+sOzA2EWId/vEIG/kxz8h8dHLkrY/QRUmyY/uVFzbwLiOZE7DHTIBX2RKoIZGZEJUzBeR
 WNBaLF/w+lrRYldhG58wFjnEbGbgvVMya2tw0RpvwrbwceT8tHUcSV7MEFW5AduNfn/W80+XcU3
 WDRvge5QEdCUPgTXx/dF6CwMbzLuJM8bVq/JMoDpnZhUBciUwbOy/Mj2aVFC17+IUS36d5chuol
 RHp8X04Aun56SGx2HOl8Y46SbRFH50UsjBo4xWwVLeRAjb1uW/Qjq7Ps3DWovxlJ5RdT/+l0n1p
 IJga5Lu zADa1NNA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct ceph_monmap.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: ceph-devel@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/ceph/mon_client.h | 2 +-
 net/ceph/mon_client.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
index b658961156a0..7a9a40163c0f 100644
--- a/include/linux/ceph/mon_client.h
+++ b/include/linux/ceph/mon_client.h
@@ -19,7 +19,7 @@ struct ceph_monmap {
 	struct ceph_fsid fsid;
 	u32 epoch;
 	u32 num_mon;
-	struct ceph_entity_inst mon_inst[];
+	struct ceph_entity_inst mon_inst[] __counted_by(num_mon);
 };
 
 struct ceph_mon_client;
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index faabad6603db..f263f7e91a21 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -1136,6 +1136,7 @@ static int build_initial_monmap(struct ceph_mon_client *monc)
 			       GFP_KERNEL);
 	if (!monc->monmap)
 		return -ENOMEM;
+	monc->monmap->num_mon = num_mon;
 
 	for (i = 0; i < num_mon; i++) {
 		struct ceph_entity_inst *inst = &monc->monmap->mon_inst[i];
@@ -1147,7 +1148,6 @@ static int build_initial_monmap(struct ceph_mon_client *monc)
 		inst->name.type = CEPH_ENTITY_TYPE_MON;
 		inst->name.num = cpu_to_le64(i);
 	}
-	monc->monmap->num_mon = num_mon;
 	return 0;
 }
 
-- 
2.34.1



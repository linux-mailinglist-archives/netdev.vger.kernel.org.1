Return-Path: <netdev+bounces-37825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12D27B7499
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D92251C20473
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD56C3F4BF;
	Tue,  3 Oct 2023 23:17:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2493F4B8
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 23:17:51 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65766B7
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:17:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c60cec8041so10670505ad.3
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 16:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375066; x=1696979866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2hiNsKpT2HKUJ8qI7Tsyk3akcDPzjImS4VdPWR3XZT4=;
        b=aCSkSkl7sC4BruVJ6KatwzPKc6b7bhrSCn1NnqxhY7YizoiLOdMkWQpvql8jDkQYrm
         fydN6yVIdM+V5jG3cWusApcaU0lUb6UwTh0zieaICjAG1HrY1YBaeKLHKGW2OXCbvte9
         9vWifOlo7S2XBBg5BTp0kWUX4/tUgHyUvUfyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375066; x=1696979866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hiNsKpT2HKUJ8qI7Tsyk3akcDPzjImS4VdPWR3XZT4=;
        b=UfL2qvLqPv1io6Ke35QM3PdWuiqpfyvPPctDKZxcmc/lpIN0ghA0LeU+oF7B+GUQ+U
         l2gK9BKbiNHgpA5WaIEYSW8/q+KVtoZbUf7T8zKMHpEFU3ws7LZhT8yUdKhVHfn2lcG0
         ocqykJaPQ26rPO3VuXPhK1ISH4x4PqfAjLU52fdP9DNch8VCVX2Thb8uCkwVs/ch15ee
         B8K5fFuiBDWujun8zKf5mFQJsP7PuAj/Aesbu9AgIINCcWrWDN90cJAEGh0dK752pWUL
         RS0f0OzXegAMMZxv3nkC1eyzNxKiFQX4Fz8wVhd/IriEVRkXYfD1xxYvXtr+DHOOcPrs
         h9Cw==
X-Gm-Message-State: AOJu0YwAyU0zFKa+UuZ87sGQRdfE1Y1GaJwBKSxpsjZ29hS1Xx2W5oAk
	heaxujtDQcoET6ZvpUvZSQ0T5Q==
X-Google-Smtp-Source: AGHT+IEzbduhuq91qnIf9SmrVMDzR6Wn097mVLkmhj2fU4eb4uu4f4+qfWtXB80CU1vtpmuHsm0FCw==
X-Received: by 2002:a17:902:e84e:b0:1c0:d5b1:2de8 with SMTP id t14-20020a170902e84e00b001c0d5b12de8mr1214102plg.9.1696375066601;
        Tue, 03 Oct 2023 16:17:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ea8c00b001bb99e188fcsm2170047plb.194.2023.10.03.16.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:17:46 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <keescook@chromium.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Anqi Shen <amy.saq@antgroup.com>,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	syzbot <syzkaller@googlegroups.com>,
	Jianfeng Tan <henry.tjf@antgroup.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] net/packet: Annotate struct packet_fanout with __counted_by
Date: Tue,  3 Oct 2023 16:17:41 -0700
Message-Id: <20231003231740.work.413-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323; i=keescook@chromium.org;
 h=from:subject:message-id; bh=GKawqwHl4UULkff2cIaeAmAbzx8aWFIbmG5VLVkLd4I=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKEUZGTBGbWEbfQHr5gGx1uBl6q3iB19j5TQ8
 4R6/WUoIzCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhFAAKCRCJcvTf3G3A
 JiFBEACQ9z6btE2IRqV+dlPimus38QVTJ6TnbqlcqFLxVxfTBnSZPghD/CNiZuVouBKmCGzfc8Q
 H7Vlcjkf882aG66U6TSBtG2M9ndDjlyMpLwzjHNbD8sRH2f7VmHtLuM11Gsk7NAOMK2EU3uzZy5
 la89UC4CnKbQoki7cdi96USYK87HkKEMQ2FoktbUUSt0jDgZopRsieiYMkvhr//uOV/XtuzQPF4
 /P9r4qH6Z+cwQmuWV5fRvnAuZ+TtV6P8niy+TMK4u3v0NSyfhgqmzm81x7EEWPcApprDIIp7/Ep
 E4POegXoG7BGZ10Y216YaD9shGKXtcE8rQHPWfn95/z2HGh8xUrzz9M3VjV4A9KWS6NViF4UmKO
 TzlldgZ1RssRxTAChOf04lXMhc5VV8HFRnBkW+jIckgMei2klc0+SfeIERirUvcjDj6Hr/QWHvY
 4bDW579Wh6lNWVjyQICRm5G3kv9dz3Zgtdwef3NgZqsj2b4Y6p9/dmmbYCZlXZTrzM/0xvhHP/x
 FD0LlpmYBbed2Um/PQTQHk2Kd0nVWGbNxKB4bLXoGIc1NCecn1nqCO+JuvFMMvlIVQM1WaBtor9
 vrrpSr0s9k2fX6DT8MWId6QvSoe5Gni2yDgPb2AJ45TOUfZ1L7CNKBj3cHlIvxEm/uvbxIWDPco
 tS5hYpJ HBTM8msg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct packet_fanout.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Anqi Shen <amy.saq@antgroup.com>
Cc: netdev@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/packet/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/packet/internal.h b/net/packet/internal.h
index 63f4865202c1..d29c94c45159 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -94,7 +94,7 @@ struct packet_fanout {
 	spinlock_t		lock;
 	refcount_t		sk_ref;
 	struct packet_type	prot_hook ____cacheline_aligned_in_smp;
-	struct sock	__rcu	*arr[];
+	struct sock	__rcu	*arr[] __counted_by(max_num_members);
 };
 
 struct packet_rollover {
-- 
2.34.1



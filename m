Return-Path: <netdev+bounces-37829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACD27B74A4
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 01:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 2F3B61F218D8
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 23:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9713F4CF;
	Tue,  3 Oct 2023 23:18:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503753F4CB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 23:18:30 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3E1E4
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:18:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c3d6d88231so11484915ad.0
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375108; x=1696979908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fgl9vQEJJbjNo7nW0Wg2fi9SpTiuajLNVx4n3kKMxac=;
        b=AcEAfpihltU5ZDG2QebOjn0wc1RP5vw72GSbjzHmeVUUo4G0OmFLLxzb2ghokaI9N0
         +6NzfjHeajIrURTttNCqsoOq4Q5WDaC9PmyzuIfFWJWLGGvra1ONcjiyyjnS3t0R9JM5
         zuLQ31FbzTa6TlgRwhzQ4sP0YTVIx8rRJ947o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375108; x=1696979908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fgl9vQEJJbjNo7nW0Wg2fi9SpTiuajLNVx4n3kKMxac=;
        b=lgQGLPuPM5lua09X83/agujmkJn3TJ6s3110ZMWska07Jl5XQGsPpDPpLJLROQErb2
         1ipaDdpE0HCeJ+ANXco7x2kdtZfcOzqeVM9F2asOmUNqTJQvCE+QvzAZE8LSgvR1UuSO
         6YCfVaRMxJScJpRXAK48qc0lxIVlpPAkfDXEr1zYdzFEy/fRmSLdjF+WupM1EuBZQggC
         o2OXDInVFMxSTxnXSnpxxyO5UImVs3AVejq+0sEc5+RANgNSDu6yvMJDfyHttbW9/Dxx
         6QM0c9hxQvTcNeM+E+BKUjHsjjTsMyXVoTZLMc4/+PojHwXfvYfREhkJtakvjIF1J0wn
         XTdg==
X-Gm-Message-State: AOJu0Yw6UzepEDM7ux+i4C7mhPQN/Rq/568sElez2P6M84oXz8EEfULt
	QQNDNoXuVCTPXSaBN6iL5Eiqog==
X-Google-Smtp-Source: AGHT+IENo5Q2eLmEdNEu7fkSSs1KgbtKqyGqHzL/hdWpw4mK4/awHV+Yesa9BOkmwpuqvxV9DEr94Q==
X-Received: by 2002:a17:902:8f97:b0:1c7:4973:7b34 with SMTP id z23-20020a1709028f9700b001c749737b34mr847042plo.50.1696375108193;
        Tue, 03 Oct 2023 16:18:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c3c600b001c55e13bf2asm2164183plj.283.2023.10.03.16.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:18:27 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Kees Cook <keescook@chromium.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] netem: Annotate struct disttable with __counted_by
Date: Tue,  3 Oct 2023 16:18:23 -0700
Message-Id: <20231003231823.work.684-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=keescook@chromium.org;
 h=from:subject:message-id; bh=QpdV3D/pVMVweNA2oq+ijy0Ps1fXCHwUqT0dHu1y9HI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKE/cn0ZGSBlVX+YLyS7A9haLOLgFWp/l+KGJ
 DE5lp8PcbuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhPwAKCRCJcvTf3G3A
 JhyLD/4vRULjUhoTz+b+8DrLZnXEOUIpFIYJ+0ej73zTgRl+SU0hEtcV/IhKk4IxNZLKfg0zx3s
 sJ8zaDIZY/OuFu+YH5xbTOwAugAftkAjY+ZqN0XPxmkxOYjrx8zgEveE8iuwf2zxAL3xt9JDcQ/
 O1Wvsi3uEUzLs1QIrtaki9tOYku41VrQNQlOcpZjcyMh4DLPMBBVTejrG+8nyYlOOkmlwgjEMLz
 C158/Q8P5Be9//NQP1XZdULie/GNiaQZ7T4bQreXvgpQ0tr1lrQDbF6/8Q1gtWA1qAOIxqtkifw
 cXxGIe2woegB1Do1RgBumq0NIqYJRFl84RGqT0G5JuEzM0wecHS5QhEyObBw0vIYu6CV9NuAybw
 sZ7LAHZSSfP/+ZdIiaPsKV54lYYw56/txl25EgaxYjjZfRrPeNzjdjEAMXEvJKUXLSrGlqbnpwy
 IlG7RtvhLYPyIvOf4RrB/DoGUXO/JO18rAY8+spUsW4qU7M+F1ZvQNM5uqBF+PQSmCIEyM25wY5
 M/dKWVd7aB9oVyVBpNes2MNIglyizhxXKKMPwzXAeR5Ya0MOm1NsiJbRvV/7fJSfVJi0O7T9ZSA
 G4KV9HyfnLV8D0BhDlslXUjwAwImcRCCChBdzFfz+tx30E0nB3LsPPzZB8EgtetyzHqaMCBJNvL
 1JWISSN X18Ox4Ag==
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

As found with Coccinelle[1], add __counted_by for struct disttable.

Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/sched/sch_netem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 4ad39a4a3cf5..6ba2dc191ed9 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -67,7 +67,7 @@
 
 struct disttable {
 	u32  size;
-	s16 table[];
+	s16 table[] __counted_by(size);
 };
 
 struct netem_sched_data {
-- 
2.34.1



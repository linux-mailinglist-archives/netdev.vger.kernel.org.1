Return-Path: <netdev+bounces-37094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743FF7B39B7
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id EA5C72826C8
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 18:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55F76668B;
	Fri, 29 Sep 2023 18:07:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8726669B
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 18:07:53 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD22BE
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:07:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-69335ddbe16so3967775b3a.1
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010870; x=1696615670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZNuuPDo9it8tkX6qPOGwJo4GQ7mQ5hyHXJpkMAiaQU=;
        b=Xe4tE7z3UjPddP/3wIOYwdmU5WH1aUpqMSwfeVediFgy50ezbBfLiAMHJDz7zT5Gc0
         F/+RE5p0eBiGuPJ/wYZ2fr5kAOG3ifZNPiCG+bWEa1V+Ls+I57PqRPAs/lHfsCgFxesu
         MpfOnu+/cjzx6FwhKDC5gWFInbrRKGci81SV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010870; x=1696615670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZNuuPDo9it8tkX6qPOGwJo4GQ7mQ5hyHXJpkMAiaQU=;
        b=uAx7xQevmGEG6ku8MHmRQRgvU9geVhsSP5c6aanjtbLygJV3dBpn6Pp0QBIDsHoBr0
         BUBLxyYj/5QUPbh9milXRsGam8Y09TWlZgxm1rBOK7+V1qv5s5/6tQBbyKqOU0A5o5zK
         VKKdHc/Fizhkz+n7L9B9t8/6W5vTQyWMBjo33ALV23N7oZJyR1sSWsdUwLZtLJ8EcWqy
         1yR2cCo/wkp1x9NpJXR5LG8ys42RFsvMW2M+8rgbVQifwL5Tv1MaEdaNvu5JptkLwm+F
         O2HcHV76h01G52GbiO9ss+7nxQOvvGHCDeKyNOSeI+NYw6yL03gDQgrLx0W2zF0dbPzW
         K76A==
X-Gm-Message-State: AOJu0Yw4NV2+32aA1T6uIDtGvrq3FJQ/H7GcRnYroI73qTh3CxJ+zJ8G
	HrV4RAJB+sKQibIACTgaZ3ut1Q==
X-Google-Smtp-Source: AGHT+IFJ95BU6niyoo2gApDZnCXcDkP0dSKiwEwps//qgcxM63JrZFlYbqCMoWXf0lhhCnJHW9sTvw==
X-Received: by 2002:a05:6a20:158e:b0:160:18d6:a3d7 with SMTP id h14-20020a056a20158e00b0016018d6a3d7mr5378517pzj.1.1696010868900;
        Fri, 29 Sep 2023 11:07:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001bee782a1desm17055007plg.181.2023.09.29.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:07:47 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Kees Cook <keescook@chromium.org>,
	Petr Machata <petrm@nvidia.com>,
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
Subject: [PATCH 4/5] mlxsw: spectrum_router: Annotate struct mlxsw_sp_nexthop_group_info with __counted_by
Date: Fri, 29 Sep 2023 11:07:43 -0700
Message-Id: <20230929180746.3005922-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929180611.work.870-kees@kernel.org>
References: <20230929180611.work.870-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=keescook@chromium.org;
 h=from:subject; bh=B8keI90TRW2q45uUonlCrEQKui4OLUvrgLBebVNQ9NA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxJv3gQ2icCiNvzN2SrB6CO5vY/Quxy8Fmvkp
 MWA5zi05RKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcSbwAKCRCJcvTf3G3A
 JlMgD/9KspItI7uRPQsQk5b1n6wj1VGlU6uDB/MzB8j7BFvYACH75tHJ6+EtAxCMs6WH2/1xOJB
 Zc//rKE5ME8cSKtfDy2yuCaWHFyuMkgN1a33v24+KmVjWOC8Z/QjFt5svRWte8710RTditYZOT7
 XKykSAvsTe4/HJALIvV4CYJjTF4uavOTyu5UlYB7ZHjBBe0+VR+xepIZPkEjOgCYBRLh7lX/MeG
 fr3kiTfV1+0L6p5GA+Jbl2WymK1k56AOkQZXyBngR74bpIruI0iJJdu0vJKwC30V3SHQujqCe2k
 z598oohT+Wnd0x8ojB3RKTl1Kd1jHRSPN3uXlaIEIr33yM8vKL4PaoYIRnE6ZAh4LB8XeMkhrF2
 AQjtjTNgvq05sJ/iwgNhIjSE0TzGlV8uwf6IBWDELikCMijBFN2BhQg5lXOlI9ZzjV39Pv6Ghbg
 IEa8dbjv8XLSyhtIAWT9wZq+uOFfvYMeRwC/ff+Qeqx7S0B97oA19xAfKE2Ug/0eKSAwybHM0Ao
 eEzDT1/Q9mpQFcEl0vrNwq17gJM2cUasPKjBnI1W7aqj+rez0GpJxzyho+3j2K9MSMxbW2cqrw1
 nPBe7q3r8weENye2KqEWW5tjD5rkm2B1ikBvcdhkjlR/5K3OlyydwoM7dgEWGY1p0uLg0xY5rcC kErWnebJxPj8H3A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct mlxsw_sp_nexthop_group_info.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index debd2c466f11..82a95125d9ca 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3107,7 +3107,7 @@ struct mlxsw_sp_nexthop_group_info {
 	   gateway:1, /* routes using the group use a gateway */
 	   is_resilient:1;
 	struct list_head list; /* member in nh_res_grp_list */
-	struct mlxsw_sp_nexthop nexthops[];
+	struct mlxsw_sp_nexthop nexthops[] __counted_by(count);
 };
 
 static struct mlxsw_sp_rif *
-- 
2.34.1



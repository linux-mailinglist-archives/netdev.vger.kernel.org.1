Return-Path: <netdev+bounces-38268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9C37B9E3B
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CEA992817CA
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841DC273E1;
	Thu,  5 Oct 2023 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q4HA2HFP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948F5273D7
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 14:02:40 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D9E3B49F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 07:00:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-405361bb94eso9715275e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696514415; x=1697119215; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKYvXra/D0tLphe3ZYt8M2FkTUMUP0fbv8DSSHNP3AU=;
        b=q4HA2HFPnByx2wqryKNgqw7msNORxZy4rtAadz53kSnuGzKXoU5CALJUlPMjAkIcws
         qaj7dSLiV6U1u8lFE1A7o79bCJTHxXe2NC3PIwNgo6vwY1VdjMArA4Jg4zKlbf9Z5kwK
         XknL/scw5r5t6yLHgfpQ7g68TBkQIt86sO0YRS+DQylp1sGM+hMvtKcsIyDjZzPd3GWp
         xcvy2ow0i4UHquJrs8fMN47sdLEcg2NcJkeY05Cn5TkOv9L2/Q2cIp07f7EE54OiDcFk
         BuljjSEQDhwPeHQV9UthYNhdEBXVbxWU1sV3/If1j2dvHuB+k82B4FfOm+ravcz5LKA+
         hRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696514415; x=1697119215;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKYvXra/D0tLphe3ZYt8M2FkTUMUP0fbv8DSSHNP3AU=;
        b=kgkb3OmWMtfucTIPbH5HVFTcZ80rucgVALxWfyizYXXdnnIswQzHqyA6Dni5El89U1
         a/eH8d0kGx42SGHBHJHc1m3ziOYoAsH+DxqUZjgFz4dB2adekQFeLrmcrlZ0iBbuwbA7
         j9WXkGzlH5Q+kkc271oUl4kZeiAvm1nmuPC/YN/R96v6pwhd7GpPHwcb4b7ObxIbUXL6
         H4RkJHtEMWW52OiJ2xsTr1tqBJ7vmL2mA46nvX6gJEkPE0KLjSZf81XPm+OfQhC85Ra4
         Arj4w1tnOT70S1ZnfzS95fRr7hk6vgj4SCnu8dbijEwYgzklwsZWwmFkVIIpX+mXW2N9
         YiVQ==
X-Gm-Message-State: AOJu0YyanceGoZqC9IaTAG7c9MeHJ5hl6Pp/ZmTXK3BWWigDCKgljs3z
	xm/8O78IqY5WWLqQYxwq2kSInw==
X-Google-Smtp-Source: AGHT+IFeXTKirNHzitQdtS6ll6h532Honm6zVck6PvhrBG0gk4w02aInvnn9ivNnit9lXF/4TmElFA==
X-Received: by 2002:a05:600c:2981:b0:403:8fb9:8d69 with SMTP id r1-20020a05600c298100b004038fb98d69mr4991682wmd.25.1696514415402;
        Thu, 05 Oct 2023 07:00:15 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id hn32-20020a05600ca3a000b004053e9276easm3840958wmb.32.2023.10.05.07.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 07:00:15 -0700 (PDT)
Date: Thu, 5 Oct 2023 17:00:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ido Schimmel <idosch@mellanox.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] mlxsw: fix mlxsw_sp2_nve_vxlan_learning_set() return type
Message-ID: <6b2eb847-1d23-4b72-a1da-204df03f69d3@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The mlxsw_sp2_nve_vxlan_learning_set() function is supposed to return
zero on success or negative error codes.  So it needs to be type int
instead of bool.

Fixes: 4ee70efab68d ("mlxsw: spectrum_nve: Add support for VXLAN on Spectrum-2")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
index bb8eeb86edf7..52c2fe3644d4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve_vxlan.c
@@ -310,8 +310,8 @@ const struct mlxsw_sp_nve_ops mlxsw_sp1_nve_vxlan_ops = {
 	.fdb_clear_offload = mlxsw_sp_nve_vxlan_clear_offload,
 };
 
-static bool mlxsw_sp2_nve_vxlan_learning_set(struct mlxsw_sp *mlxsw_sp,
-					     bool learning_en)
+static int mlxsw_sp2_nve_vxlan_learning_set(struct mlxsw_sp *mlxsw_sp,
+					    bool learning_en)
 {
 	char tnpc_pl[MLXSW_REG_TNPC_LEN];
 
-- 
2.39.2



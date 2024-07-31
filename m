Return-Path: <netdev+bounces-114591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE91942FB9
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 15:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055D0286427
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E841AD9C3;
	Wed, 31 Jul 2024 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvA2YQwL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0673B2209F
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431364; cv=none; b=jGp9v2faPWyjImKdiOrcRXASXBtnuLHel/rEiANPtAtzVolab1hJ/iLvmMrXtnL5MA0rFFEJMUWdau609GFO+gttjyZS01VmKSP7PeoDnDs+1FC9QaCWqG/+X0RiJ6zEd2AA9Fxwydk+HHxC0Tdu7TDQMNym/DaYc8uYWHGXCVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431364; c=relaxed/simple;
	bh=V7l0EMAVjrIZgYIdEBWT/Z4aCRG5tm8yC+hqgtgrcR8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XqhtKnkuZD9MURoEw+QHbSxo3SNsKx4xKLt/1maBjHK6t/TKkVAK6tdMCNVQXJVY6k2qjUlCz70jnizpKrYDOCp3BDdBVe2RWejX1uTKip1wRNX40/a2KakQzfXNExbw71JwB2Hbr8JEpUF/n02NkcUIQx2wo4OOoHsU1zVObsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvA2YQwL; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-65fdfd7b3deso43196657b3.0
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722431362; x=1723036162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wqCGLGmkB3kattiqd8LtnjYBIZ25jniuTIwlHJv5xro=;
        b=dvA2YQwLFs1n7oi4SmDCB27MxmKKrjtSTBemLXKb2wTjEIbPFigvdxldkggPNySI9V
         /Ig3VuxJIiL2cvZR+douyK6VR1c1V12+TvpJkG/SvTq3031w7LFwxexswPUvdBPWgNbc
         BmclFxJwl6fMZOFo7ZUfyFiIRSW/DmROFw75zFHPmvcBhAQR6HEEMsT0zXfgiqmscDFu
         3GY4X5EZhukqbLVZcDXYo9IaN0dK7V/7QF6xCqhkDy0XeflUbnrkkCfTE3zK/uQxaWnH
         LaSuq/a0boSCZloG4eB5zHwzlmBw3eVhzp7dN52rFcWrnPi7NTtJda2TMXGEXGWZZpCG
         39vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431362; x=1723036162;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqCGLGmkB3kattiqd8LtnjYBIZ25jniuTIwlHJv5xro=;
        b=hIenDqyb8bupy8ewDo1FdV9cep4NfNk/B/YjLoLVVL3h+fOMpTrZeOJeHpFEMc48j7
         32yDk8i4Nhs45S2lq5Y1XGGcreU2kLomhEkKv6tmOB7fNoCP6ElxMFie+JBLjIbc801r
         Q9NqPAyeKeFoHNl4tIjEdyznTdceAUG5mhzRtcu61fcid2dZms9LTSHggU0+ADQRVQtG
         KSdHuf+gcBiZI+9HhtrDW15tINxiajoP9gWXEL2ypISRnkMbTSTsieFE6897WKg9XEue
         vvR1JsZzf3yt1PIOL8MuH6F03HFyjzPlHbMXJcGbEUWDeljD1DF1sbfERMm/DRz8I3XX
         wzpQ==
X-Gm-Message-State: AOJu0Yw7/7YmZctteKOZd6dWZhDHVdm0dF6Tv6GbiCoWkpwlVP+O9DV3
	XMsp8Ulat6qn5yU8dL02Q6d57UQK8jAW1eeM6Lujp8F5z4FdwK9ZsqOpdsXSvSlCmGkLxXHcPLN
	QBEmhr4O/us1ADiEU9niYhmHB7/P82IB73HI=
X-Google-Smtp-Source: AGHT+IE8LqEYii/VJcxpmx4jxM4oObzyH88RGUrWxEZUVPDhnlQQBGq+CDwCH+2uL4W6glzcGNTwnCJI8+0/EQyzxZs=
X-Received: by 2002:a05:690c:4485:b0:630:2749:2f4d with SMTP id
 00721157ae682-67a09787486mr144919357b3.36.1722431361860; Wed, 31 Jul 2024
 06:09:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gwangrok Baek <zester926@gmail.com>
Date: Wed, 31 Jul 2024 22:09:11 +0900
Message-ID: <CAHcxVNOf38nOzoWZ6cxxFUpvkfHPYa+DFZ4tBBYBntkLag93Gw@mail.gmail.com>
Subject: [PATCH ethtool v2] ethtool: fix argument check in do_srxfh function
 to prevent segmentation fault
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, mkubecek@suse.cz, ahmed.zaki@intel.com, 
	ecree@solarflare.com
Content-Type: text/plain; charset="UTF-8"

Ensure that do_srxfh function in ethtool.c checks for the presence of
additional arguments when context or xfrm parameter is provided before
performing strcmp. This prevents segmentation faults caused by missing
arguments.

Without this patch, running 'ethtool -X DEVNAME [ context | xfrm ]' without
additional arguments results in a segmentation fault due to an invalid
strcmp operation.

Fixes: f5d55b967e0c ("ethtool: add support for extra RSS contexts and
RSS steering filters")
Fixes: a6050b18ba73 ("ethtool: add support for RSS input transformation")
Signed-off-by: Gwangrok Baek <zester926@gmail.com>
---
 ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ethtool.c b/ethtool.c
index d85a57a..8cb722b 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -4261,6 +4261,8 @@ static int do_srxfh(struct cmd_context *ctx)
                        ++arg_num;
                } else if (!strcmp(ctx->argp[arg_num], "xfrm")) {
                        ++arg_num;
+                       if (!ctx->argp[arg_num])
+                               exit_bad_args();
                        if (!strcmp(ctx->argp[arg_num], "symmetric-xor"))
                                req_input_xfrm = RXH_XFRM_SYM_XOR;
                        else if (!strcmp(ctx->argp[arg_num], "none"))
@@ -4270,6 +4272,8 @@ static int do_srxfh(struct cmd_context *ctx)
                        ++arg_num;
                } else if (!strcmp(ctx->argp[arg_num], "context")) {
                        ++arg_num;
+                       if (!ctx->argp[arg_num])
+                               exit_bad_args();
                        if(!strcmp(ctx->argp[arg_num], "new"))
                                rss_context = ETH_RXFH_CONTEXT_ALLOC;
                        else
--
2.43.0


Return-Path: <netdev+bounces-113374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB63393DF8D
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 15:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4B11F219C4
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 13:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6087116D9C9;
	Sat, 27 Jul 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldcnUJ7m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2442AAA
	for <netdev@vger.kernel.org>; Sat, 27 Jul 2024 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722087601; cv=none; b=bH2ojm4ZIZ55NiiJ8R3pNVy3L8Z/2EWOz30aQ8tw/F/TbI9v7V7rnUtQnTlNAkLlKU72NvAoyzDF96AtrUb+IiJUhqms4S5RJ4dFb7ktRrpL/+QY6GXh7mqE3+/+fRswGkSaaJMA4ReqHkphL7SU5iuOwubmqN/PT71OcZ53gk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722087601; c=relaxed/simple;
	bh=V7l0EMAVjrIZgYIdEBWT/Z4aCRG5tm8yC+hqgtgrcR8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jbD/aXn0FNi48x+RBX0z5GkacA+kCN6ZbaqQDhI55cHDeUdn/wJm94LyJ4lTFEb4qhQ7Tl+u7mwzT8sVsjDw2M/TkM/CKYvL1lfocMQSJyWGKZVitu2VsY2giT0nJyAovwRx70LyCOTbwCTfSQF8iHPM8vpULmHfIusi2upBqp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldcnUJ7m; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-66c7aeac627so5664067b3.1
        for <netdev@vger.kernel.org>; Sat, 27 Jul 2024 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722087598; x=1722692398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wqCGLGmkB3kattiqd8LtnjYBIZ25jniuTIwlHJv5xro=;
        b=ldcnUJ7mACErw5WAW4iH0zJYvlcenfa1oeSTfL5KBray9nufO2rG9sqhZQ37NBhSqP
         TkiN4MdKb36DNPAVe5epNd0yIUUdGImUGNn8zo4Yy6vdt3KrRfDYE3vA5Jl7cQFckrXn
         onpaHwilGz8wfQb5WY1qNsPRYfdt1mMquzs1vhsoG/EH7/Jt1ds25lKrLkJnLuHz3IEd
         sYWgE+oGNJwmFwbC6Hb6m9Kbq0PIGe/6/05H0NNohYvLITcT4c9uyjljs0U9VVf3yVm9
         6hMyISEss032BMeSnoL7dKrLwXkHhiFbX/+EWUwUGpfIKrHlltjx310AS/qo5KEe1es9
         0Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722087598; x=1722692398;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wqCGLGmkB3kattiqd8LtnjYBIZ25jniuTIwlHJv5xro=;
        b=ue2cRRmdbNgCsrnZ89YkQmrVHm9/VvUd6lKSyed5yMo3pRV9QHK87/z/CQkcqUBL/r
         mdHOanM/UB+nv9IdflHslz2yIpi84X0M3LyXk3+Rzfg53h7FJDL2+snfu1OaKyEEOalF
         4LTQFyL7CsrL2qR4Lt14mL+iWlbZ8vIOvP259F82OWheta3qG+W1xIyGcxxgRBCZTubW
         9H6vCuo1ScPAgSXY1bWXUHW4QtuNIhc5zMjPpZ1LFQWx12KQWMqcp0zgCY9DmKLeP86C
         4g3bEpy6r/r+868rr3aKRZ853fVqrky07/mYSCn2fb7bHF0zJ9bBcfhk5dolONOzfCTg
         1eHQ==
X-Gm-Message-State: AOJu0YxKR0cP2fZBIkFPNAa4WEy4NZkCNFMEFV4sDFdoeyumRhjW4opY
	unYecsRW9NSLo0/zrtckUt7Nvvp7CirJNCxIbnS/mFaaqoBJs7XFQwbY9q43W9a/XtCpFDMPyiJ
	VYuisFUpd3ZiSXoDC+q0ZgidIMZ1L96CA
X-Google-Smtp-Source: AGHT+IGwh5U08HwsRwk4Gt9eMZrsJCet1H+dkBJgobIHYWE7AWZXJxz/2YWD/Wcgeky0lNa2dzkJX3TJ1giqSmSzKqE=
X-Received: by 2002:a81:bb4f:0:b0:64b:3246:cc24 with SMTP id
 00721157ae682-67a09f4a2a4mr28496957b3.29.1722087598247; Sat, 27 Jul 2024
 06:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?67Cx6rSR66Gd?= <zester926@gmail.com>
Date: Sat, 27 Jul 2024 22:39:46 +0900
Message-ID: <CAHcxVNNRRCMtT0AyNk4OTcqBn6wWTk37SJw9eWChKhxGRCjUCQ@mail.gmail.com>
Subject: [PATCH net] ethtool: fix argument check in do_srxfh function to
 prevent segmentation fault
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz, ahmed.zaki@intel.com, ecree@solarflare.com
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


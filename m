Return-Path: <netdev+bounces-147351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9369D93D0
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324241670D1
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F7819A2B0;
	Tue, 26 Nov 2024 09:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="n8Pv7bj4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3AC28FF
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612124; cv=none; b=PXWcCTa7mr/KeEbyVsna8ffNkZc/ctXPo/5GeOsWmPBPPbvsnDayx/QGANuXyXSBtqTqdY6RWkcRKYvBh79CRYx7+jnpumt07Fe+xkg+u0tT1bKS5gdenA2zzcbVaA/lSWyDK6/IatEV500audaUR6sDdEwvtlUNhlPJZ9ZarIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612124; c=relaxed/simple;
	bh=7t70YZBffsmmFkwGyusN0/IbLQvWxW15+60fzIgRXS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKUyarO52C6ZUHpXm0+qS4dACXcad+aHItw24xkNfpgq1wIkRUlhKovHiRWSw1IhvyQCuQBlE4YYZ5MkgU9yGMhmaPwhdvVOHAzN1nkpl40cUE7FKYqHG/iQ8S89EdBXX69U35rHAzmEFpYFPmx+llcneQPXPUiNgAdbmTHquxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=n8Pv7bj4; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffc80318c9so16266251fa.2
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 01:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1732612120; x=1733216920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m16aVCnRbfkgBu1RaVfuGkGho6ym/9PLLiGj/PJIyUI=;
        b=n8Pv7bj4LQfRQZfPuQjoknIRno8HzI2TKegA6VupTCrT1vxPw+09w+aCZ8XMkknyqM
         KCnqePwPlhWCEHnnW7mAzA+u7r3wNqyevbcXqjPp/ZQ5+asjxcjUQkZ7JkGjh7vg8wDM
         7wBOzOL330rdBkpLajaZx22mxsZhkmnD0BM405Pz/Fr5MO3DaeYbFbi1/lH74jMU8yMx
         UKOswwoyowsDTkl0J2mF75zGaeYDzWvIVQGJSAIRpJP5X+QX/R1WagE5cW2060xhb/zO
         J8v2Bu9qG1KTVYCfu5zw7pJBVVyEQsjcWSIbO7/kZy587jdA19AfsLcL7pP/vD3Qlfci
         id1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732612120; x=1733216920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m16aVCnRbfkgBu1RaVfuGkGho6ym/9PLLiGj/PJIyUI=;
        b=qtLI6p8/4HWp0Qg9J0M4XumxA+ONarxIZyEyStRiAmOlOSjxltcsgxj669syJVy6JW
         SdRMdZpud0VIlb6eqjDXxOFgKBFrRdhI++duM+toE04i+pnsQyFDrM0ZuQEFt55LnS1M
         jtkaXoxnvBzZBK/pEUXsiUJf0EeukwrXp0Y4XwLMWCWoIrHFmovIZYwSdmYck8kbIIFO
         buQm6gyda/QJqNMxfHokFcHYz4rGQD86Zm8SiPvk+Jp3FdA8Lave/dgmACnqyPbC26tq
         eSHBVd1pJYGphNpB14SkEl3bnyAON/hVqkhuIDDvzSgNKbjQdDUJAZGwNQbH7VoFtSlF
         5Yyw==
X-Gm-Message-State: AOJu0Yxv8UAdQ5+8keRQdG0sgzs1wm6GYly7Eq2rGvwZ6OvEFLMREL29
	zEooTXR3r7wHlqnaAtE0cc44/Pl9Mew6h52eD4XJyAhXfW4oFfdpB4WrP5KUiVHgGgNrUdyKyLZ
	o
X-Gm-Gg: ASbGnctMlWYXrPUzX08BNBFASKSXc0YUEHJUzaCrldm3y81HYKIk59MuzPoBXarb9ew
	NqSqw0L1sSapbibT0sl4J6P/MxcalP/lDwlahhPgDVpCv9ZOMo+/04WVOt3RHmcWfW4aZ8f7rZI
	vopDwX7IeepR//FBhCsa6eGdO4MhHZYjPpF8lH/Bo3GeyNWpO5HhfY/2iGV57EWCBhZ71OrBPVL
	18pi8B8AkITeWu92ashpt7FdsOE0iURR7z1aZcBVug=
X-Google-Smtp-Source: AGHT+IHP8VPB/t+f1RACPk8IodcTXk/irDkmZfpkYJJivwZHo8p4egGoFarCWo+YaMLNyM902AmNAQ==
X-Received: by 2002:a05:651c:a0b:b0:2ff:cb88:f132 with SMTP id 38308e7fff4ca-2ffcb88f152mr13935701fa.3.1732612119583;
        Tue, 26 Nov 2024 01:08:39 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a5f96236sm16789625e9.35.2024.11.26.01.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 01:08:39 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	saeedm@nvidia.com
Subject: [PATCH iproute2 1/2] devlink: do dry parse for extended handle with selector
Date: Tue, 26 Nov 2024 10:08:27 +0100
Message-ID: <20241126090828.3185365-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241126090828.3185365-1-jiri@resnulli.us>
References: <20241126090828.3185365-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

When parsing with selector, there's a list of extended handles
(devname/busname/x) which require special treatment.
DL_OPT_HANDLEP is one of them. The code tries to parse devname/busname
handle and in case it is successful, it goes the "dump" way. However if
it's not, parsing is directly done. That is wrong, as the options may
still be incomplete. Do break in that case instead allowing to do dry
parse and possibly go the "dump" way in case the option list is not
complete.

Fixes: 70faecdca8f5 ("devlink: implement dump selector for devlink objects show commands")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 devlink/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 9907712e3ad0..f4e90b804fb6 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -2409,7 +2409,7 @@ static int dl_argv_parse_with_selector(struct dl *dl, uint16_t *flags,
 						o_optional);
 			if (err == -ENOENT || !err)
 				goto dump_parse;
-			goto do_parse;
+			break;
 		}
 	}
 
-- 
2.47.0



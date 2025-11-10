Return-Path: <netdev+bounces-237341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F388BC4925F
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 20:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0ECB3A4ED8
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 19:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DC22FB624;
	Mon, 10 Nov 2025 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m48rzm3n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEEC22F16E
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804311; cv=none; b=sUyhkpm/KeVCk/D/qlOZGKeGYauyp2LPwBlAiKP38nhTVtwV9R7yNhgraOgVC0zZqKAMM14vD/5bmQ0QHGPnG6eH1m+2mFMhipiOkFQXruKyWcVIeQgMJDSeQYKAvXY7B90brgeYEByGU6wo2c2hao++fHMSsHH/sdz3OEIDvjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804311; c=relaxed/simple;
	bh=qkHNrqZdFrGbQ2sFVWvTU7Vf/JCQVLrMMbpthhsCB+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WrgbHVuaS0lUFeR6SOdNUp03oJHJ75c2ehc8RQqYpf5VywMTeCnqMC1G9mQT8byUg86zzHuORG36iUQWg7MAkKK8eqPaSFfaSmdzhEtpTJe6ssE696q7+KtOnKjfle1Auwoh/8BQxsz2I8kdyBhh7zGI8trd7pQJltlXt9fvW3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m48rzm3n; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7af603c06easo131316b3a.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 11:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762804309; x=1763409109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qwnhoUomw64HUQztzgJYcsDLgM3BoYLfj0X2UoQeEr0=;
        b=m48rzm3n45uUB1Jg18rCE2UkTl88eKW94wMMAwWXck4BbVI+7A4I/ycLCpp8unDmsP
         YzWxzBVduMX6EQ4Z5srYFQRrvQx1tWCGaLxLK8JQrchmA1+5IKKd/dyIlSQKeUeZwkzw
         22X5u9ycdHGt90+HOaXI3iouCRpbA0YqY7S44PeqM7WibuliNb84uLtbCmvW+eCeiZrb
         Qd/3JA5b24GWQvFol18sfe+O9xuD7AqmyF9i6ajn/kmNB+UFRrJ36NLomeK2EgHwhF51
         iZ7wTcyMwWEmu2Ah6fN4VzXpiFz7GYhHvCbLuaxPhi3OKi5DCKpUTUrZe8QIy6jeyIQ8
         3UYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762804309; x=1763409109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwnhoUomw64HUQztzgJYcsDLgM3BoYLfj0X2UoQeEr0=;
        b=XeRyBQxTCkBsJ9W7q8Tq+fWq1EdbVaBHCgqWiKBkDN8pN/B5t1D8V2aV3nUhH+IAQ9
         Upc9xZ08MxNNUkMSnooNBaNZCvFSVGVZN1jJa6ITCdyLEvAsV7pDBQotPVfzgGeBMVmg
         FX/bfDYZBOr6QQl5TBVCZOodvnU3j0KeuDNUONKxrip4O5b6RtsPVNsoHTMK52LM35+B
         jh5Dsd+o/lJkdoYsETXfVOEOKYPjD+oH9mQGeve7NL/T3b9LKT6O8M/V1RyolwKiL34G
         hE1uxPhotJuLDNviM7YU8UPDPW5rj5TU92RZVI/aE4O1iFm+e4KNiU7ZHippoFyxH7vi
         Jgcg==
X-Gm-Message-State: AOJu0YzzYKXn0BTU7sFioWxx6MV0rLoOE+A87d+eKa2XIHT+VQl27U+/
	66qkKhqplqRV0qX7YuE+HjkzgmajlsOTA6GWjMuPAG2sJEmb88E64UFv
X-Gm-Gg: ASbGncsHVy2/YzPSUh4rLsDd3myEuzWo60VtI7qEOIH+4Yw2Mz73+6BBL+/asM13H0J
	YmW2pb9mE4PkEDw/zezcugeT+tn/gAxrkG+efoxZWv61zlMvaCiDmdNIj2dBsaA8efqanoo2Y/6
	vjC2oV/Bx0ImFlm64Acdva3JxhsHLVxlYHhPNLsLM/nNvO9kCqzMtV3/s7LYxxtaExY59mKftUW
	BHhl7ZAnCqGK/f4Y4wtnkON+HEqh61H9LmAkAJTnNXu6TdH8EmA/kFOGkaOruHBWPJ5tUJJGSvW
	PJr3+cxfecjCPi/D8e2WfK3ww2KCosg4AsON/M9LruAAadzoq9nCwNjGhvAiBhWbuXqnqxADuuA
	P4ymLwnGwCfaaMjjxuAx25x0iC9WRTM0i73YWlqxgrxoizhdULVrZcfpT3kO4b7QEhsQGg3+TDU
	ctJTdZEPI75NaOr++oPqEvwzBWgm4=
X-Google-Smtp-Source: AGHT+IEcdjjpBCPZmtRzTDq8PPd6/fWOBQ0tt6Y90TaCfOOsTB1S9g0eYsl5fdhEFnCj07aTnMpWpA==
X-Received: by 2002:a05:6a00:3d0d:b0:7b0:1d84:8634 with SMTP id d2e1a72fcca58-7b623afeac8mr689252b3a.15.1762804309058;
        Mon, 10 Nov 2025 11:51:49 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccb5a31esm12669098b3a.63.2025.11.10.11.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:51:48 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: Ivan Vecera <ivecera@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] dpll: zl3073x: fix kernel-doc name and missing parameter in fw.c
Date: Mon, 10 Nov 2025 19:50:30 +0000
Message-Id: <20251110195030.2248235-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation build reported:

  Warning: drivers/dpll/zl3073x/fw.c:365 function parameter 'comp' not described in 'zl3073x_fw_component_flash'
  Warning: drivers/dpll/zl3073x/fw.c:365 expecting prototype for zl3073x_flash_bundle_flash(). Prototype was for zl3073x_fw_component_flash() instead

The kernel-doc comment above `zl3073x_fw_component_flash()` used the wrong
function name (`zl3073x_flash_bundle_flash`) and omitted the `@comp` parameter.
This patch updates the comment to correctly document the
`zl3073x_fw_component_flash()` function and its arguments.

Fixes: ca017409da69 ("dpll: zl3073x: Add firmware loading functionality")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 drivers/dpll/zl3073x/fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/zl3073x/fw.c b/drivers/dpll/zl3073x/fw.c
index def37fe8d9b0..ca5210c0829d 100644
--- a/drivers/dpll/zl3073x/fw.c
+++ b/drivers/dpll/zl3073x/fw.c
@@ -352,9 +352,9 @@ struct zl3073x_fw *zl3073x_fw_load(struct zl3073x_dev *zldev, const char *data,
 }
 
 /**
- * zl3073x_flash_bundle_flash - Flash all components
+ * zl3073x_fw_component_flash - Flash all components
  * @zldev: zl3073x device structure
- * @components: pointer to components array
+ * @comp: pointer to components array
  * @extack: netlink extack pointer to report errors
  *
  * Returns 0 in case of success or negative number otherwise.
-- 
2.34.1



Return-Path: <netdev+bounces-235612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA2AC3347F
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EBB04EF72C
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51E634A3B9;
	Tue,  4 Nov 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0ADkr9B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D06531352E
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295961; cv=none; b=eRT11t3TTvx8mP+3Qqbds3cghtVdb6QAoqXv07y6Vyz0VK2B+sWoaauBdKy8mXp3CytHazW+mcO/6kmxOy0+ez9rxRpIrdMxNeh9ERbH/JkYBKv5XxxCl5WHOplDVmtlxm96x2FQJTxZWSjpGiW7zuar7+K193+4o6Q56pYrllo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295961; c=relaxed/simple;
	bh=XlP32tEwpZirdMr7sqd9mNrUqkac/qnWShul7Fw9yow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajgtjq1G1Uy2fiAZnPi0LyPS4q4/snGqxs+rm3f+QaXQhIfHkb0Wkzpfsl+KqMgbTxu5Q6DH8yfTiZCuQpRF+Et57u+HXo2Tok7wZb7Kjxp/R52rAbWL0rZ7w9q6XwAPr6PzkQ7/9ZB3EcZ6rN0w8Vk3T2A1fclcoHMKNuTCh0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0ADkr9B; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29570bcf220so42378355ad.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295958; x=1762900758; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TRuhdOoSSGipeIAHAxq+HN65/ys/fdjImQ5W470jiE=;
        b=G0ADkr9B9NpB2Bim0ypTHP3Mt/+mWa4mBYdFMoZrgxG+XmDpZ4hxIQwde8PAioo9vj
         YzWPL8FeNcoFD23u2bvudw/FoErDIYepIqTHQGYgnXvZd+Yy2XdPBl9JEBZIfTzViE7u
         20/XwvC3PtnqWzZhKFLt2QpsT4Jb4Y3y6tg/xeN/sh9XPR0EGPg2RgMab7SaIPSttdMK
         OHNp5LZuPDjU4fHufrYI1mA3kimf8JACMa+ejHdhNWAyPLOc5qHmuCxQLXTZmc3HDy/Q
         94rr1MV5GJxDgVezXdBZUzW7K/V9WZXIe/Ea9FpIsWjpPMfLJFWa+jjjsKWtYd38diIh
         Mxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295958; x=1762900758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TRuhdOoSSGipeIAHAxq+HN65/ys/fdjImQ5W470jiE=;
        b=T0V7beFSLShlS+wD6nAgR/r8aDbeMDmYF9HjVkcHoZaUG/5X+XO3upKyOoK+UXwWlA
         JmxhwH9XBZsrU97UuJqbmvsm0p3Xioi/SEEO4yvKO06PW25DmD/C2ds5BGJa1rKI9SYp
         yOfSCujHzuy20tUT/VFvB4DCIAKRMPmuRLgmalJdWC0XY3hNK6kBtP2IbkeHrygocYwz
         yGURYUrsCLKoIhfiHQeiQiGmSwpK6s0m44m1yxTCIutCDOIQt/7BXqGIOKPYiuvQmQfc
         SMeCpuFwZJqABQUniDjGnbMDrfcznaqKd52s0tUg5ZSb5+g1iYf8PWCtljXaRxHCBIQT
         TpGg==
X-Forwarded-Encrypted: i=1; AJvYcCX/qTocns8vhHZ4Gb25rT1ZhdOIcvtxcb3vq+UOS8u7tpssAT1PlaypVBwPgDf02guUCkpKS4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxuuUytNedUyjTPAvQc0iRMzzVnGM7mDQYLhPG4UlodljrfBOX
	NRlqnVqYrTc40afV8XXOqldptO41RkMRtCx4Xy3YwRcV9Jj8+AHI+6Xh
X-Gm-Gg: ASbGncs4W1Nu+D+rbNdBl6aCHlUzAALH8z3lP2LgOipk/ujezhUUM2RJi+JOJDjQpP1
	gjWGfCy1XQG35WTd147onei5ZttiXhNgA68MO28QLsLLCfShnxoK2OyAnwe8NPDqo/ZZ1cD0J1B
	imM4JDv8ufcya2CAo+fp+bBZXcV+9PyqCj0gWNkCo79GhcBIFAAgmeJ4x8eFeP1g3D54bC2m0qc
	+UUNw2R9yQWGFu2p8vPevkS6kizLmy8J1FXhhgFho+x7mEvyprpJb+9ynmZpq7SMYJaA4Bo2np+
	KfYO/3Hjvzw3k4uRHi8NZ9+YPAEOdxqnp/omOWq4r0E7hTPzmPgDhSR/2yCLLUIpk506KurbYoB
	RsZ3UubQt5u69fgLnouVQ6vPQbzVkDSqGSqhJYBOXdqHw5aBRgmK+aANeKalXc0epspxIXfKa
X-Google-Smtp-Source: AGHT+IGkcKOy3RYFgLwyd/NR+t0Lm3XzaO4mSqwdUYhsWqQ4Xq3qCSzgiAZO/1PlUw5asRlhZe6BpQ==
X-Received: by 2002:a17:902:d488:b0:26d:d860:3dae with SMTP id d9443c01a7336-2962ad83389mr16923805ad.3.1762295958422;
        Tue, 04 Nov 2025 14:39:18 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a36sm39341705ad.1.2025.11.04.14.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:18 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:39:00 -0800
Subject: [PATCH net-next v2 10/12] selftests/vsock: add 1.37 to tested
 virtme-ng versions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-10-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Testing with 1.37 shows all tests passing but emits the warning:

warning: vng version 'virtme-ng 1.37' has not been tested and may not function properly.
	The following versions have been tested: 1.33 1.36

This patch adds 1.37 to the virtme-ng versions to get rid of the above
warning.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 3ba9a0dfdd01..0657973b5067 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -152,7 +152,7 @@ check_vng() {
 	local version
 	local ok
 
-	tested_versions=("1.33" "1.36")
+	tested_versions=("1.33" "1.36" "1.37")
 	version="$(vng --version)"
 
 	ok=0

-- 
2.47.3



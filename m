Return-Path: <netdev+bounces-244944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7761BCC389C
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 15:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DF603061349
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016633446D5;
	Tue, 16 Dec 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khCGlvlx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F106343D98
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894903; cv=none; b=cmFXXAO10kb5MS0hPuLkQB6V6YUp6SW/nwcIHW/7i23dcPUKMTzteK3oPDZ2iAUjaGbK5QTHNtvwbWCbIKtYc7QELYKudU2QdoS41oWVby3Zi/SkmIPxykaonCOODnaT16hxl7V4pTx69aLzdAGJSlGk88yffFt3nirnFRrrvA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894903; c=relaxed/simple;
	bh=pXIiO6haHR0Tf/mUYKzHz3v/EFqAm+QdyNO3oE4TwoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DD1zLl83xRDykM+p20E185anScWoT0JqzyrWUhd0RwPYjmiqclpHrLNld+Jcawd6hxIYn/8BtJh0FAkVf48jPTGWy7Njb7/+s6ceteWH0aIzB9QJ3ECb372UGkJTUw8046ZpgpDIhRfWDABq2TK5fhR/SqXivZG1u+jEqqdHPzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khCGlvlx; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78e2fe1f568so40714697b3.2
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 06:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765894901; x=1766499701; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IVCcg/qre5aOV+b23PhiTRxysVG2ifmatqXUBtcww0=;
        b=khCGlvlx8cfTmjoRQwgilR06+xVk9rhRq0Iocx2OPdSG7JFCGgH30fH0lTJHhUtj5x
         RTB+1gCHhn99+ZffIjq0zFw3J4ywB8NhbHoJiFVoOhyV6MZmeiDMyBzVsX+h81BqkFM4
         kDVtOvPtJ8g7ggnoo/sqxKilTOekGC+ShS3QegmlLZolLL95PVnLU0922crYEamMOqZ+
         OIa2xZ0H8nIOAy11NvHHECVum3cHGsyUx3WtKq0zazsATUFTMeTb1rzala3CYzB6IACk
         7Z4y5PEca/3E5yClsX2SS23ZSIwMMAbmiM9c9adgM14VoDbE2Udny55hIzYwkwQu+jRT
         gQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765894901; x=1766499701;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8IVCcg/qre5aOV+b23PhiTRxysVG2ifmatqXUBtcww0=;
        b=bG8q2fPH2O0MpTZHcKho+w+IiLYu38Lh1R4V/hwBIxgbYjoedSofIApl6McRb+10EC
         LSBshoCuOOKMkq7ANspgQJGw9dthCjUz1oLJo2pPtLQrvMRxL4mqKq7VoBMkXoPVGlgd
         qmcNO+xvlqUa9kMfhv5gTcnq+A/u/S44/UbNJ5hm3Y6s/xwQSmerR1LYUqI8y9MT5Iz7
         PIw6a+ZxzPIRBrabpDW8aGrUid6HUP2FYJ0/M0wmZhXJ/x/DFMkOjvD71JGEs19GBPqG
         jaOkU8cgxYY6I41FEI39HstEvx/4P3WBosiUJ1wZ2+md5guUjUlQe8+sJGN8yb/aqGhT
         VPyA==
X-Gm-Message-State: AOJu0YxhOkF11ic/HenQv7bYhjwr1wuwdzJ7tS5hS6RuxyBVEDYtOjZY
	oD3ll2/RV4tZj/VVFxXvPocr2gz5rJmLp/7vUtVMXCbmJUdf4kqPYZMz
X-Gm-Gg: AY/fxX4DTAStgSpbmgfgMHmb1PSO1TpvqBwCjE4+R+Zrg7ht3ice2jN41vx6p0J+KPQ
	1o5b/QUyzuYPfmSHrt2GCfzkK7xsR+2bus+W0hXpdgwmRnnTtEbFnfSa2YK1PwCWDohwQAKOxlk
	/rUBRl7pXGBDQ9NTyWgdWFNrJpR+wP2xqu1sVmZuJuZ0z/LFT/zShq7ybnyhoZQGFixe1Fq0ZbI
	owAAdDXW3ca1iUAXLyE7uYOdicyu6RpC4ncC3UnlMnZ3izciRfGHiAFC1AvLfr7vXwp6fju4Clg
	llgY1w0bSKY6lSK1rLGrhHETtnIHnN0pyyVVE3phmHTDy44rWa2WvzVYeZqpYpbv8H8XMBDfAgt
	hyQyVNkNITnM+Zp0kv84h+9z7m8sBUNEWKNSOT5DnRhiNRnwMEEPljH+nF3HP3V84M7rOQaqtoF
	hvmIpqLfX8CA5w71c2
X-Google-Smtp-Source: AGHT+IFTtA6pkA0ey4PSA7sZYRNCSAgJx2il0bzaLO5i3/tN2rwaLMUoW2im+2O55ONV3Dj0O+NhjA==
X-Received: by 2002:a05:690c:48c9:b0:78c:5bb4:1d43 with SMTP id 00721157ae682-78e66e5219fmr116639627b3.45.1765894901104;
        Tue, 16 Dec 2025 06:21:41 -0800 (PST)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e748ef7b5sm39226127b3.14.2025.12.16.06.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:21:40 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 16 Dec 2025 06:21:36 -0800
Subject: [PATCH net 2/2] selftests: drv-net: psp: fix test names in
 ipver_test_builder()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-psp-test-fix-v1-2-3b5a6dde186f@gmail.com>
References: <20251216-psp-test-fix-v1-0-3b5a6dde186f@gmail.com>
In-Reply-To: <20251216-psp-test-fix-v1-0-3b5a6dde186f@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0

test_case will only take on the formatted name after being
called. This does not work with the way ksft_run() currently
works. Assign the name after the test_case is created.

Fixes: 81236c74dba6 ("selftests: drv-net: psp: add test for auto-adjusting TCP MSS")
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 56dee824bb4c..52523bdad240 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -583,8 +583,9 @@ def ipver_test_builder(name, test_func, ipver):
     """Build test cases for each IP version"""
     def test_case(cfg):
         cfg.require_ipver(ipver)
-        test_case.__name__ = f"{name}_ip{ipver}"
         test_func(cfg, ipver)
+
+    test_case.__name__ = f"{name}_ip{ipver}"
     return test_case
 
 

-- 
2.47.3



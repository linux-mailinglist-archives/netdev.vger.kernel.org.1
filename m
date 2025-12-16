Return-Path: <netdev+bounces-244942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F652CC38AE
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 15:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9C893038F51
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 14:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1316634321C;
	Tue, 16 Dec 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HERlvNf/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5567524A078
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765894902; cv=none; b=p6ltFidzWvdF2N9vT1VYshX+zjUW3L7bDf3+1EQyBseVCn3AXjtd4QPa6tBkn9A83hHnXPhCw3wG3eONNhiHxuudh3ZPrKbTeVQjnnfay9y9x5ucs41aR1DPqXBWDbqLhr8iNpZM4zbHFRNT5wa00Obka0++3dfzKSFrYPzJSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765894902; c=relaxed/simple;
	bh=xk4akIQ4zkMZwyNu5en5aAFYUYM6zO5HsLOJvD66TMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gtKGTZ312LP5JDtAQ0u48XC87eBjhCApP90gohyLNlLgaOyEc//Cb/Tx2H48RgJ7+7NAluLbgF4f9KllwgATHIBzgP5eFzwHip+KwwaFb7bgCH2POPJ+1yfepn3fMt6MiSJqRT2sQfqLmz0t7A3BZnRDekLi7RRZpQG1bx3Htgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HERlvNf/; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6420c08f886so5467402d50.3
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 06:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765894899; x=1766499699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1nOmunptNy3oemoV4rUx/DnbH6DXevdS7AhcMbpo7U=;
        b=HERlvNf/OOXZN7T7CHl/m8v5LKf//+2Bg3jEqISnK7TuDjomY9VjXHhtqFoMxn8rjw
         OqJu++veyBtKqjVkO9Z8EFW4/lyxA7hGlAorrUQN3Q6GCUvfxCBxvssVfMht10ZzMPfw
         JcMhfnyq82mAqjxGUe2t4Qa87bcqP6Pyw4Z7bzMY0q1T1NiEACTPRqr+uON2BOBjkc+h
         5hhGA1HqWH86IUyF7DEZeU1CkIUjMcaVfJd+ljW3YfJO1vYmwMBdCmuBlbaXEw757ptY
         HJIi/1tePBX6dA0acIYyrYraaU4QzC64m/LYRhGFZshTALKwwhGIc0Z2qtRHiwoxgYTK
         dO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765894899; x=1766499699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h1nOmunptNy3oemoV4rUx/DnbH6DXevdS7AhcMbpo7U=;
        b=ebZ99P1xf/pash1H1xe5NXqlMsIhGtCzAh9IcCwp8HruBcLmaLERkNfqFth+rCFKnu
         Upyiv5RVe7UovVv5MCvCa86wLQexK5jtqL1JxMVYA6fxzOEAWRMu9ve/RrqGOI7YYpNy
         Fgc4LnmSJKXY7VPXTJKHH/EEGjOM/pM709OcOHgEj19rl/+OHGoIDeu+sltvDgX42wZO
         oZSZ70+y07pSpqcR3uF3p7UHXf/LqQ5123N287qBbbd+B3hPqbRvUel23IdIpnvoh0dI
         w1bL0AHOA9GLfNAG7P1xI6KQVFMqa7/w1d90e5KL0zJIvWQMFOU6uEniN5PLqgz9M9wy
         o23A==
X-Gm-Message-State: AOJu0YzoeeemM2BXuZgZXh6lFiSseEmoAbubBXuVnameti4AsdCu68MA
	ItUXB6fYB1iliYa+j0BX0rsQvVABAGsBW56/liH3H7Vgrha1S06t6Uyp
X-Gm-Gg: AY/fxX6K6Kw7knlj2627BlVAFY1TGuyZ3hCRrH7gYTG1apB2qxGLfpUCQD2czRMdBN9
	7MFxHEa1HDNZ90+bmUuLeYxUx5Kia6H5ZUbHsHXMoIWgGC0C+cIMvxTovtm3iSwx/xjjXjDfMU4
	bUyT5++rc8UoTs5N8wcGLPqb/1EHsYO4fVE+4GBCH3bha3LFp92UyCaWsebplBfVk60/4/Ejcbv
	QmLo9R8Dn/Rqc0hNBpw41dU2x/l3n+/uhPzuFBEVeEEY5ZJcMug2+z6FHN1EOwUov3tYK1p0dB1
	W45+hSAGwEjCxYhsEO67sFfzxLg+nN086I9FaFzHLIcEM3RJH6u9YESbVr7GN/VTeKuN1A19r1y
	TR9w6eO9WAo377wkeZXonqoHfy+yHDqI+2yI6etRcm+88/yVWBdu//yhl+GP0Mz81pCurVYrG7M
	1/SmyCbANRrCRwD5nq7TQ=
X-Google-Smtp-Source: AGHT+IFEQrF+xExK5KQL1vPJpilA4DpXFZueEXCvaSd+rgtVfZpJUrEjgFisTuNBxOinrGlRuRt+ag==
X-Received: by 2002:a05:690e:118a:b0:646:518b:b179 with SMTP id 956f58d0204a3-646518bb635mr1685481d50.15.1765894899145;
        Tue, 16 Dec 2025 06:21:39 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e74a42aeasm39297997b3.52.2025.12.16.06.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:21:38 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 16 Dec 2025 06:21:35 -0800
Subject: [PATCH net 1/2] selftests: drv-net: psp: fix templated test names
 in psp_ip_ver_test_builder()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-psp-test-fix-v1-1-3b5a6dde186f@gmail.com>
References: <20251216-psp-test-fix-v1-0-3b5a6dde186f@gmail.com>
In-Reply-To: <20251216-psp-test-fix-v1-0-3b5a6dde186f@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0

test_case will only take on its formatted name after it is called by
the test runner. Move the assignment to test_case.__name__ to when the
test_case is constructed, not called.

Fixes: 8f90dc6e417a ("selftests: drv-net: psp: add basic data transfer and key rotation tests")
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 06559ef49b9a..56dee824bb4c 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -573,8 +573,9 @@ def psp_ip_ver_test_builder(name, test_func, psp_ver, ipver):
     """Build test cases for each combo of PSP version and IP version"""
     def test_case(cfg):
         cfg.require_ipver(ipver)
-        test_case.__name__ = f"{name}_v{psp_ver}_ip{ipver}"
         test_func(cfg, psp_ver, ipver)
+
+    test_case.__name__ = f"{name}_v{psp_ver}_ip{ipver}"
     return test_case
 
 

-- 
2.47.3



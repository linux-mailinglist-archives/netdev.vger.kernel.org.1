Return-Path: <netdev+bounces-97411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBED8CB6FF
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 03:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 151102816A4
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 01:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405D2F4E7;
	Wed, 22 May 2024 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PqoHaPo2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900DB846C
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339573; cv=none; b=izOAP1gSfJhp5scLP4fm4uAIp0b0XnUl3y9PcEBC3WrwXceCmNrLBdZDP1yS56U2MzYFBcz2A8x3GNUArgGVIGv/KZTYZ6SHZw40vO/ItBHEq5Ak/Qr6dVjr320nctBA1BjcPY+XimKIH9PbqxJOSUZshscprhazDJ4UUTUb8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339573; c=relaxed/simple;
	bh=x5mppV8WCT2sFoidaes26Q0BjcINGRNEO0wOAYpWIEM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D5Gl0+AFWa0vn2pTs1mUNq8DrMc9cwS7ScMaU/231oGeX2+UNdpfHwj49Ax4XS3WLqhBzDsaAU2292Gs982C5LHg2wvlRq8xR/G9SZGaD+FC+cxY8grfnByu98Qh4FDIfOjlyjFKHmhD29hKcBo6UVWm3h8wb7c/JIpHpOl+Uis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PqoHaPo2; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f6985cf246so2881390b3a.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 17:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339571; x=1716944371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=heKXSaMRYcwqfGx66xXaJ0v1/7TXmPatEe8vgsf1Ibg=;
        b=PqoHaPo2oFkcy7lLtSyreTK4fnqP1HM/aNZJvCwL8hG+I/+C4y7/txY9TpwFRGIFHK
         924PaH2dfP7PcbSslJIu/15uAVhU2y6t6vjR+aDwwr9JYgmVOuSlSLSlV6BvpkebQ/b3
         3TFo41UDnURvryKGx8u0y/hsgWOKIERv7QCTJW/zqA+Da4IYb/g9nbPYYyDppvLqc2gM
         JswhbKfe0Nu6GpAk+1lscOHmugFpOhIMf1zDmRuSPcH9im9ylnkw/yGMReszwG4G8GSo
         540TbtAmrIDlHfXRP+tDE/f8Dp+up6MuoRuhWVAkXemVNalJR3LALhqIUJeoLkMSV+0n
         3b1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339571; x=1716944371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heKXSaMRYcwqfGx66xXaJ0v1/7TXmPatEe8vgsf1Ibg=;
        b=DbulAbW6YZRMYfOF9jw3TsC+qwI7StkdeZnzUqiJNj4t3zLOKzGwtUNYXp4zdxD/3X
         /jVg3t98M9k8/IJCbt/mLWRxsp60OlfbyQwWzGCMMOcdX+lmZVIu6l87QW07fBJHW+xl
         SEH1yP0TPUWe7rz4YsNDjCP2v6cDjLPdl/w0vISuSJprMGn7MOhw3p9yp1DsfsnEFyLx
         a3QTbl4XSCy1NalilmdUSYTrp5P0idgwI7MqK6zfxs79hjPmPy7Zj8msOhSq298WKh1O
         EB3k0n9B5MfY5YFnmW+ssglAk1YzbzTGlLswzu0pmSd5vtlfYjiYaL76DPd0Um/97BlR
         OHbw==
X-Forwarded-Encrypted: i=1; AJvYcCVVOk1zdB0kg6MqZxph1FO2gBjgQn4nVNl53aWSi09OAJ/4OudvTZklV/SepKvf7VGx2TVeRu1EHVqVCrQ4ocxbuA3PuWUQ
X-Gm-Message-State: AOJu0YzaZI2OCGzbsVLTwG+IEugeKCvAw7oKVXRZz2Vk1BS982jTOQfr
	z8cPSGiazNY8M9h8p+lr5m/NdLmSt+OKiH98dCBECmMTklYtWqK1ZMg5bjtUvfLHqRDFcfJMKrt
	zGw==
X-Google-Smtp-Source: AGHT+IEobdompRA9RjJm2/dX+ug/Gh+Xw1AlGzUbj4XxipP2oWSmXIk82GLItQak2HzxiyPL3MdiyXobY5E=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:2d91:b0:6f4:9fc8:8cb0 with SMTP id
 d2e1a72fcca58-6f6d6504a94mr20246b3a.5.1716339570837; Tue, 21 May 2024
 17:59:30 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:48 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-3-edliaw@google.com>
Subject: [PATCH v5 02/68] kselftest: Desecalate reporting of missing _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Mark Brown <broonie@kernel.org>

Commit daef47b89efd0b7 ("selftests: Compile kselftest headers with
-D_GNU_SOURCE") adds a static_assert() which means that things which
would be warnings about undeclared functions get escalated into build
failures.  While we do actually want _GNU_SOURCE to be defined for users
of kselftest_harness we haven't actually done that yet and this is
causing widespread build breaks which were previously warnings about
uses of asprintf() without prototypes, including causing other test
programs in the same directory to fail to build.

Since the build failures that are introduced cause additional issues due
to make stopping builds early replace the static_assert() with a
missing without making the error more severe than it already was.  This
will be moot once the issue is fixed properly but reduces the disruption
while that happens.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index b634969cbb6f..8e53686b71cb 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -51,7 +51,7 @@
 #define __KSELFTEST_HARNESS_H
 
 #ifndef _GNU_SOURCE
-#define _GNU_SOURCE
+#warning kselftest harness requires _GNU_SOURCE to be defined
 #endif
 #include <asm/types.h>
 #include <ctype.h>
-- 
2.45.1.288.g0e0cd299f1-goog



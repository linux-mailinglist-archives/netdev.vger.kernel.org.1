Return-Path: <netdev+bounces-235606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9482C33433
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75A8F4EE8D7
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA897346FBF;
	Tue,  4 Nov 2025 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzY0SXqV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932123469FB
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295956; cv=none; b=jWk0rPvPIsjPPCR4OvYy0F+Cox5XmVyOwoeOGDZD29JsT+bu5gZlJm7w47TtWvYNstGLAIgCUQ15AKzSOWwf11YMreR1qhObRuqdIuRA0mQCPmM4e2fsFHD/aSER4DvKxXphwetlFFiNHFNvHwu7N6uzPelR6pBQknrj41PlUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295956; c=relaxed/simple;
	bh=dKYcrUk99CdeL/H3uIfsCxfnuKjJF+qFwDzoOr7kT4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SYYF3tXba0sbVAbFFL9AvPT5yfF57f+JVPnwjjXNYa9XnjAHGg1zq4u2+QvlYhEoO+q+N9sGgWk1vKHa96UsmKVUGmUIpC4LRk6989trQnhmHlyBFzWaPhcAVvXrh17WxcFee+blK+tHWleBielMmF2u4wHsB+jv1f0N6aSeDdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzY0SXqV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29524c38f4fso57772195ad.2
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295954; x=1762900754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDZPS+JOEPYnU4eck4h/T1RWdETtnpWwlslVEykWAIA=;
        b=CzY0SXqVwyO1GCzWMmjfNiQTq99E/p1LfzZkggbERkoMjPYz9sP/AVKSOa7Hok5Lhl
         vvH5npWNZVEBO/GQeBie7IwylCiwqBtSV+rxXNPrXjLTARr/9f0Wtjrf7Ynnn6uLrsv+
         czHhQA2Zy0xaMT0GJHiwNxlisk/MRuZyTWAsM5eXL3UwHsAtqv6gng0kBY7xEjnui9O3
         YwOnMoUfR7zo2yWTfn1zooEzEMqSRNnTsKjr7eezuKvrEhnfhpUGnCDp9TESuE86vPrb
         BMrke6JwS3NRyH4IlcwT6uq/ITVse6DCjYqMy8YkW5ZJMYiMXS40VkfUd9/ZR9Q5MqPA
         7mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295954; x=1762900754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDZPS+JOEPYnU4eck4h/T1RWdETtnpWwlslVEykWAIA=;
        b=W8kSk03nohlVkl+EbqyRJL6o/8uzE0Uqp0US/i1Xs9iqVBpb5mlEc7Hs3U5Qcdsiux
         Qhw7DTKSWpJw+q71yRJat5w1j0Cv/eWUQxUtk5QrJ2wtSi4PFRAAnXKIFE1Xn2bSER29
         XXSMY9PJvXKfe0KXG5HYvn8XjfkEgX/1j52xz5i0z5Ma7lNfehuwKwAhyoON3DgGXSZI
         6TV3XISbkqHnqP5FdL8ys3u6eR0zbzmW2i/lizr2DKaIfH8TQ5E4qfjPNCJllp9elnOo
         QlvzDavqMi2glo6siQtlS9//MS+Xr08Pt+arj0xfY78S/07VgVAC2JqoQ55TCl39GhPH
         uO+A==
X-Forwarded-Encrypted: i=1; AJvYcCXGDMHAq/mzUk7ijNg2cinCB1wQRIMXAopF67FLChFbzAECSBesePesVVlzI1EI9JlNHcK88II=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI5PVFT8lJ59Jd4SHKi8qsGWKvosG1fwtQStZnNJz5hG0tS3ZH
	vavFae5bTHRmw09PpX/uEYOaD3ErS3OZWUDbftf0QtioQVkjqtQDGPXP1pc6Ug==
X-Gm-Gg: ASbGnctA8ILAbtyegnjuuwXefTSfBAEnikV0R917E31uE8lkrwsuhhod0TV+16jGyiU
	qChBHJUygMcVEmnyH412uXVQ4QM7LZlAzQw86LHvELwWg4dUIHvps7tGWcFsijIHed+n4fug8D7
	s7QyTdtG76I9OTh5P+fHmYyFsqV1QcTqeYup+HOVU3BG/7/TKobD1fKBfNq2K+LcKeYBR3U++lr
	KAnLJ1OO+qfI2Bgv7KxEBgjOi7EcY29z5WaKWWMc2WM5anqC98Y9FNC5UpxnLWCagA5Lx2/r0B9
	Zw9K+DfIAjXTMm0ExJpoCXg3L8iOchWNKuebxA47DkAD8XIlSJ9sOr6Etckz/IrjPA9+BbQanlV
	HxgRwzKN6UCAoAEkLLsmSFcOQdmSYz9ic3dXoUBbeK56Rs0bhKSkc1dze0w53PmH1rlfAE6Vg
X-Google-Smtp-Source: AGHT+IGfGmQ8EXplL0hPzNqnOeWP5or72IZ12giPyrZz4vb4nazXJcS6uZFq2FRiYWZU3H7Y1pH3yg==
X-Received: by 2002:a17:902:ce89:b0:290:b14c:4f37 with SMTP id d9443c01a7336-2962ad95560mr17604575ad.30.1762295953856;
        Tue, 04 Nov 2025 14:39:13 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a36sm39340475ad.1.2025.11.04.14.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:13 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:55 -0800
Subject: [PATCH net-next v2 05/12] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-5-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

If QEMU fails to boot, then set the returncode (via timeout) instead of
unconditionally dying. This is in preparation for tests that expect QEMU
to fail to boot. In that case, we just want to know if the boot failed
or not so we can test the pass/fail criteria, and continue executing the
next test.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 5637c98d5fe8..81656b9acfaa 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -221,10 +221,8 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
-		die "failed to boot VM"
-	fi
+	timeout "${WAIT_TOTAL}" \
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 
 vm_wait_for_ssh() {

-- 
2.47.3



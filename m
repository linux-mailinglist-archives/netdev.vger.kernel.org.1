Return-Path: <netdev+bounces-231454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8717CBF952F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AEB18C86EB
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9612EE617;
	Tue, 21 Oct 2025 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5w6B0ZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5922E7651
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090435; cv=none; b=H25Ds8DeZFkvKpPpYMM/LlquZC7BM7fMalh+Nn4qBJTgvQgnPm0MAL2/VWaxobGEE5fC5YksTzIOHE19gsYcRYLmt4kYpiFG6gz13NgkUVmyPKkw4Lvsy422TytjRnNXW30ejFiRg698TAcOJN60Ya58d8NR31nIZ2wbePbFMpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090435; c=relaxed/simple;
	bh=sFmiWiqcfg8xXVngUspNtrgGk8pAsdPv+UUIRplZPLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MabS/1lGowXfYVv0MfhPJ2z15Pl9Bcp4neNJcHTHAghtZ9RWubDVGdVRHYH74yK4dwNknqU1dGQvgeV57ef/2TGfLDQ0N1K+so3qWwB+JCFNwzXxbp1yT3WRK9w3RNhoJQ5/w2BVrAz0QKYc2CFdqs2t8zAKmL7BsPW2nq18HvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5w6B0ZJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-789fb76b466so5173678b3a.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090430; x=1761695230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Lx0Vsy3+YgWmRX9GABJkmBtAr8R5JRasWccNZRzMeM=;
        b=V5w6B0ZJQCwTfCtO7I91J2tvyL/SZY+dKcKM/ZSTCGmXFn+uZS3Zgy9/vw/BmVhkJw
         Fo7qWb/fhwFDmXhHgWiEH6lTicnillbZmtMOG24ahvMSpaaZ+V0FMB2ob3F9X3W5MXvg
         eU6SdHEC32W7j0DyAIPbXGZ2gdnKRn4EonlVaavHMJ0a7rx30dEPOaeKw1wXVmx6unVW
         kyApOWzSE4uEG4ObG6H0kk5ooKvjCeo0o5fvKb+KxPSCkNFoKrjYLJwiVfDBA6QqaZ3A
         kts6xEGkq1UHN0AL7BQEw7x6L7ZKkpPnsQz0KIQaee9Rf1Oi3lyUg5c+I4mwnnR+Xn6R
         CDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090430; x=1761695230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Lx0Vsy3+YgWmRX9GABJkmBtAr8R5JRasWccNZRzMeM=;
        b=lRekLE1w466Q/sS9GeALpQKqbLwY1IOser3+2Yj6zKcCOGotfhmy2oOUL4ihGMJURd
         FiuwugGaKO9rQJRTl7OI4XwYAKhdxAO1BJcoHL9ox12TwvwJFb3yircr66LRGKBS1V6Z
         rhwUQSZ6db8lORxz+hLdE2YW61vBXDaGrApCUAbQisPa06l/OZj2tH1gEIkbNUNyvVx5
         2jwVtO5ucbeBimTeu0ADIhapnsJ+H4fzEEG5IEwXoSO81TQbDWtnzeAcd0d4Ln0xjrra
         fM+neGGTbDj56br4mr9AafvDzYVUN95S7shmFHAbAn9nvt6+Xsv3oSfXDEP5zDA6+304
         +8kw==
X-Forwarded-Encrypted: i=1; AJvYcCVhH/NPjF7tap8DVwcaIrmAgVGVwQEBBH32gXZrDa3n2mqOzycCKq4wusY3kRg8XD7U1AwDj6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzah2W0+lqkMv17DkFsl90qcZWKbEj07XsDexC3V7yb96N0PLbY
	FpWF8DVo0YasoBsZccfoGERnafjETKCGu+uCvEOA2CmvBanozqdDod3P
X-Gm-Gg: ASbGncuiEQjShlHdPf5dG7Udx5t6AvJ1I+1oO+5IKhAii8H6YPi7y9t9fkCTYLuOggd
	DRkb1mqw/Z2mEX5IJBWem1AwGkHPQ1PhTf3+1hbHUHfVMN44QXCLcSW4pLY3VQMiZQtaFq8UgHj
	WP8WNCewj4JijXo9kQR/OS3SF/Xn6eOV9L0keGLMXU3KBSTqPHkvrgTICR/WXxbxiI0xDoZzgve
	nR3fBXrndJ81K3Pusb5V2ERpg5ea4JkW2Z6qxkLPwmEpacZzIx6P3Zp91947tVE7L0JAkfqv8Ly
	AhrXrrJozZuhS6FTN6PMIEqzClJwXTiH1o7jxJQ3Hf3fsWQFkdwAbvQiaNGbWPSnpD/d59jjWmU
	7aJOUdxTP+1zUdtynyTJLoHa7b+f0AXyCN3i7n8ceB6NyhSz/DXtZoxhepL0w7WARitVHMfR7nj
	Ojf9jXAiT5nCwH8DLj04Y=
X-Google-Smtp-Source: AGHT+IHBIC1WFg0H2qiLSSMrqYIuCevWaKcWLpJLUcG8eiGjix0DgQfBr2qDeIJoI8W1LO6p9Cikzw==
X-Received: by 2002:a05:6a00:130e:b0:77e:8130:fda with SMTP id d2e1a72fcca58-7a220aa090dmr21331246b3a.13.1761090430385;
        Tue, 21 Oct 2025 16:47:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1599dsm12619953b3a.4.2025.10.21.16.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:10 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:55 -0700
Subject: [PATCH net-next v7 12/26] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-12-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

If QEMU fails to boot, then set the returncode (via timeout) instead of
unconditionally dying. This is in preparation for tests that expect QEMU
to fail to boot. In that case, we just want to know if the boot failed
or not so we can test the pass/fail criteria, and continue executing the
next test.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 9958b3250520..d53dd25f5b48 100755
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



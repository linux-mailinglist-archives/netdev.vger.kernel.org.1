Return-Path: <netdev+bounces-231933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B78BFEC5D
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C92F3A90B5
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A02E1F2BA4;
	Thu, 23 Oct 2025 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7Zg7hB5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8151D6194
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181229; cv=none; b=PXFbBHAiZUqFpe7Xy5c2K5QkHELZxZsDDPUzXdinAP6iFg4O3EMMdpfA+hIq3a/saNqumgnely8oSxnZsDkksnIVLY/DKRkXQHFVZ9d77f3tfmYN5O4zcTlpPDVOI7fx/gOBiDdqY9mD1Eu39KJsPAuCKdsSa5yHlwU8ztkc8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181229; c=relaxed/simple;
	bh=WLRIEtshDzL84rzcliCGLW0ha/QAvCdjX7baGObipwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A26rMo+Hj5ScJUTNr6pujEnQzrCnUI+x9PW/6L1qULPP7i4Y1cSu5NNzFaxSXbu5P6O8mx6ZsSYbJpnAxh9vKHI4SWsKBsYi0cRQrYa7oUQ26bZKxBGjCG18fs6AEPHPosYkALMF/4vhdE5/UraIi//LX1miudeJc1GOV3yp2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7Zg7hB5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781206cce18so221187b3a.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181226; x=1761786026; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRr57c0ypvpAqUCBQClyFAT6EHQRTScPRNGmNmK0UxI=;
        b=G7Zg7hB5B5G45aKO6sGu+HGKhvFnVHLdPiId/ttbkZ6v+Zll3y72h8s8Wr665LO85B
         I3iw4/PfcphvrSF8G7cnjKKMP9RXmlgEDHF9uALyCBg+OdVX/SOpEap6o0Ui4SMkc19U
         obrFFAm876jJwFx1VLZUOrAEfoHIxP+mlxgukO45L+pqlvsU5uM+tui/zOeB02cd+0Kd
         nkNBUH/W5ocT+Zn0Vw5ZPmz1uwVKxq19dVrS8Qr99BhNtE/01ftfMkOvOVukgWeg01oE
         TyTzaIOgfN96ex5WoTh6SZ2UW2A5Yeb6mM6gI10AyKAsz1Acx555DTNINgeT3vFn0KMD
         V7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181226; x=1761786026;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRr57c0ypvpAqUCBQClyFAT6EHQRTScPRNGmNmK0UxI=;
        b=Hp27QBAZ/mNHN2+f2g9WRmcX++VSPWWhiyEmiQN7C9o5IFve0a5Es4Aw/LcJsY3684
         oL6mcgRj960txM5ClD5iK4mOeHZOZB3U0mJu9GxD6ynVsOdDyH2LS33oaIjWoZGq3PTd
         YOhl03WErDr4mhmEzLGqjR5As/BL8h8E6hdqcWvjO6j+7oZmEN51qZ5T6clFuzuwtXGQ
         +ol4hjne3XzHT9zK7aSJrhsk/IjNmYw/QcWUzijP8DitRE+qTEnamYhQ45GEsR8J11rz
         8rZM3xVvn3nwdIJ0UGHxxrWBrbQv339Vpgu08pmZN9Q65TVMjB1SVPZLaviMV7jhHHMW
         iK1g==
X-Forwarded-Encrypted: i=1; AJvYcCWKmQdkdmUaFDARPfU2wbVDO0xMLrcicbt1VykZbtrjR6TD3Lk/3nL+T/1P302NwkLkY1wgiDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy64CnTH2frzGfgWYaQxu0HJjudPGDFTCjWfAkSEJn4KJOoP4AI
	dVeLeGpN+3lnez3aCN6ViMXrObwiXbVO0kfGDR/aEr+yi0op+/RdtBcU
X-Gm-Gg: ASbGncsE5jZP1aFO2c/wIjBLpWytE35USoJt12oM+Giwv+X9DJhrNM5CkPMtYmoH1as
	3FJ8HsVNhoiwjC1ah7o0n4plLkyrABawugkoYmBph7ljSV9BYBEm0hzIa5Ue+HoyKhaoVvh2efC
	nJ4qc0wPQhwFXMKBVohfPPRbAKwc2EVQ5L3O8EV0oZ2a8WV9RRo1Ag7qm252SKTpsUnYDtENoyB
	agpWtkyETl2EDN6UhnLht8a+uC2jqdu8gHfQOpy84yIoxKQwV16k0zgMB7KZhW2ENfAUS23rKSu
	bcev3MMtyuThPu0S6YJltIn2DXWzRvz2vMTvJuwoUXwBq2fesLGN5yqnn3wS+P+Bo3Rji8OYiM2
	Cv7xaqxaN7cg88lIsEfCOm8xniYHB9OeLs+Ju2A8s0st/iHyaniVZUS+1edXQJXAR9ln7RNDi
X-Google-Smtp-Source: AGHT+IHg3+CWJSd/e6BOgzi+f6DN5y9Cs7OSFyBJFrkPqO6Uo3OZWXDmlV8rzUOGTzBmE/tvar48Sw==
X-Received: by 2002:a05:6a00:859d:b0:77d:c625:f5d3 with SMTP id d2e1a72fcca58-7a26b3137a2mr3513332b3a.1.1761181226239;
        Wed, 22 Oct 2025 18:00:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9ce15sm576231b3a.23.2025.10.22.18.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:25 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:06 -0700
Subject: [PATCH net-next 02/12] selftests/vsock: make wait_for_listener()
 work even if pipefail is on
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-2-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Save/restore pipefail to not mistakenly trip the if-condition
in wait_for_listener().

awk doesn't gracefully handle SIGPIPE with a non-zero exit code, so grep
exiting upon finding a match causes false-positives when the pipefail
option is used. This will enable pipefail usage, so that we can losing
failures when piping test output into log() functions.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 561600814bef..ec3ff443f49a 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -243,6 +243,7 @@ wait_for_listener()
 	local port=$1
 	local interval=$2
 	local max_intervals=$3
+	local old_pipefail
 	local protocol=tcp
 	local pattern
 	local i
@@ -251,6 +252,13 @@ wait_for_listener()
 
 	# for tcp protocol additionally check the socket state
 	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
+
+	# 'grep -q' exits on match, sending SIGPIPE to 'awk', which exits with
+	# an error, causing the if-condition to fail when pipefail is set.
+	# Instead, temporarily disable pipefail and restore it later.
+	old_pipefail=$(set -o | awk '/^pipefail[[:space:]]+(on|off)$/{print $2}')
+	set +o pipefail
+
 	for i in $(seq "${max_intervals}"); do
 		if awk '{print $2" "$4}' /proc/net/"${protocol}"* | \
 		   grep -q "${pattern}"; then
@@ -258,6 +266,10 @@ wait_for_listener()
 		fi
 		sleep "${interval}"
 	done
+
+	if [[ "${old_pipefail}" == on ]]; then
+		set -o pipefail
+	fi
 }
 
 vm_wait_for_listener() {

-- 
2.47.3



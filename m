Return-Path: <netdev+bounces-231943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B882BFECCF
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C52C534759B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA0286887;
	Thu, 23 Oct 2025 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTarZ7Ql"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9526FDB3
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181239; cv=none; b=RL33BB8ejf3IkqP98FM/KL4t2xd2fyShsSkvjH9Fq2gQvNW14tMAe60xplpyKAlP48HBpeHPZDCqPtkQF+3EbNN2OAzW97Pn5Ow3+wPwSuUICBmsPtxWHWnf7bCggiUCF48lKTrJDP4H390nLUtWOiurLv1l6y/YduT+L9ysJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181239; c=relaxed/simple;
	bh=0gdl78nLUN6qDU9c49g00gHfPsOWu9yWlnAwLxCpxsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KvgroV0+s2/3a/MZyqritd08yxXmhM3V6ZZaa9Df/vTB00laKxophWSMlrMy0xy3Rgxd3t6b7UmDvOGaivZvGHW4Zo8xykosmkfNPeEGU443fAWxkjtK1N2adBMi71+Tq/9lM8lm7prHJWsXI+kHzGCLlxmXEuN/25sSJsYSIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTarZ7Ql; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781997d195aso171852b3a.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181237; x=1761786037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cswws6nw1UcLqOlSgHDjsHbmmRPUE9+8RNFOhZ/bbU=;
        b=LTarZ7QlXgJC0csl3gaT7S9YAatvTMy6Jsm4TgDLsRlWUiJPTcDr4DvaDkSM550oME
         J7LATX+3xtjdP5zJuwb3pr68XHLTbrq/KQ61fdkuVWXVAepqtVo3hpnfehikItxBBnBM
         1wtMthWMtZz5im8pGYOq6u/cgwJPZ23n2K49dwPkrHpxoHXWhaXX1X8zEmNCyeHtflrY
         +US+59b7b+bhkUCBqZ/xnwX1tZ2P2KWpR7+V3oBoOEoyhyjKiqZnQGci5i7geYb+GpIs
         EQWtydSCH51kqpojWNoComjEiA0LdDFqON0LXytY3dBURMJpn+/1ZGPaU0Xq338zq6pD
         DI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181237; x=1761786037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cswws6nw1UcLqOlSgHDjsHbmmRPUE9+8RNFOhZ/bbU=;
        b=mXsRIPRxTi9LKkSm+vKAUQ3kjz5WGZiJ9tjBbAiTq/j4m09TX+imbJwn6KMk3UMkof
         s8S3zNJVL5Om+SL0QPDSnMbTzVaxMetBoPM3AyGR36kk/uNLMrcChEu3aBw2qsQP1oGL
         0I9Tcp41HM8Hjy873WsO4wruC3ygyxuW4t6jKrpMMvSQDduli3H+YFzoKtQKQHCnK8a4
         e3V1aNdSTubKMcuucJgzZG2eZILybxhhrR2MmEUF6dhlaHAjn/W8WffIwssniKU3ckWg
         F3QOqlT56IZYqfko3F1d5su8Epe31uwyI8TLnuF+udswPfDMMzfgVurA2T56Vyss1YbX
         IK3w==
X-Forwarded-Encrypted: i=1; AJvYcCVrKaIvvGWrR/bYzsUL8vq3ff7WtwGYgEqh22WA5uGzF4x5BL8AdU5BpVfxyhfBHnVZexSMXEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOTqTR31UpSivlOGzPOSdsH3wAMcN6QyA0278Uzj3V0JESv3A
	JQT/PjkQFbQMSgox5LdIuU/5zmxuRY/1ZwqoL6b77pSKrnZGlxP0MdQt
X-Gm-Gg: ASbGncvPONoD9QShCt02pRFX+Dvq0xFOiz+1HLZ8RjFbRL72lPME+gb/m8wao3Pu7df
	Dj6CmjtknPAcaa2/aaEhGapRVlsOKMlUPoFbnFxlUWeF5DOOpXpXZCItHcsOm9zSALwHPNEPnWK
	FAUFPRNw3FRO3mz6PjhS3CR6Rs7y+fz0+c+y8qaxsctLUUP/n5i4j4QElvGtHbe1yMb/bf6qTA0
	A+RW7G8xBz/XIXXlRpCWsqL3VNeLFuNKmUSTMP8d1hsGdQ+9jPT3wlj2C43q3cA6uZdC0c9MWcX
	QDHXzEAIbDfVTQHxqy8gmR8JRClh50B07JGrooEUWVw9grSMaS9TO2jScPKTrBkvjRtdeAPlmcg
	wqBtLCEp5iJUGGWtSrSRLOHgQx29vSl9mHVQSBZjhYECVVthW/dOaPC2xtpK1pR/K/bqdBoGaRr
	zHY6PXEBE=
X-Google-Smtp-Source: AGHT+IHFMWz/k3rf0exIhdMWgyBNfPBQLd//9lK2ixQKJ308LaXrH8yGDSVFtVxEd+3WBYMDTmigrg==
X-Received: by 2002:a17:90b:5105:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-33bcf87a85amr32540449a91.13.1761181236821;
        Wed, 22 Oct 2025 18:00:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dfb67f151sm3310254a91.2.2025.10.22.18.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:36 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:16 -0700
Subject: [PATCH net-next 12/12] selftests/vsock: add vsock_loopback module
 loading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-12-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add vsock_loopback module loading to the loopback test.

When testing vsock_loopback as a module, it must be loaded before the
test executes or else the test will fail with errno 110.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 038bb5e2b5e2..62b4f5ede9f6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -445,6 +445,8 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
+	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+
 	if ! vm_vsock_test "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi

-- 
2.47.3



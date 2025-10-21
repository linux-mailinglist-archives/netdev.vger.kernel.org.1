Return-Path: <netdev+bounces-231456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0094BF9569
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8DA1335511A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EAD2F360E;
	Tue, 21 Oct 2025 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaeNva2E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839B62ECD19
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090439; cv=none; b=SXyT4YEeEaF5LLrqBhQ+xquODoUeE/evI48zYeeWeLb1LD05+7bPenXFLXITgDIuCgOzGegtGm/mgToXtEdbL9A3dEX93sliV47FYVKa0KZnpk7iAUXRo1QIP8NWqIEBD3JBunZZU/d09v/+nYz+PUOejyCCUh94iqdMJJ9nJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090439; c=relaxed/simple;
	bh=cSAsRDqBVRjV5+J5lLGOrcD4Yn/sBflKtNCYHEuiaRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GtXQodowrlotJAlf0qsorhgYp+EdAYxF/RPyLgQgfsxZBFSnFxAvfbn5oKMK2geL2RR1Md28VU89tJtWEU6LC1cwQ2sPPlF6P9WmcNbx6IKeO7asvtB0Vgz0HcNApc3sTPJcxSwv3wjTODmlg7zvyai5Y+JofZwrXQomBiInCC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaeNva2E; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27c369f898fso88075145ad.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090432; x=1761695232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERN+jbjLqe2GDwDaLELjNRkAEJw/pLWXwhebqrcXkEc=;
        b=FaeNva2EiD/NGgDwWGw28Af1TvmhCwwSrssU24IT9UtinFqoiRii3VR64u6+V/Rv5D
         NTk1K1Ju3nWPjPVkR5DXWNM8Zuf6cjMWjfI6JQf8u0z+P4pnKVasSVJV0vJvlM9xmTl4
         MpmYgR+PXE5M8B92PdVIhvSNYgVI0oX10aC0qq5iVvpsbaomVVS6SsXQ4nt918Kv55VQ
         DkDyQx+FrZqJ55dpT1i71vEJ6gYtvDK+FDFuqfEExcNimUiMRcMtHVMOOYQhLk/+oViV
         Q0hx0qxLdDO16BFZ7ICU3thERrmCamimPO2osMnPtC+U1NLhk/Ir16wcU4eydcsn6QCa
         ll5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090432; x=1761695232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERN+jbjLqe2GDwDaLELjNRkAEJw/pLWXwhebqrcXkEc=;
        b=HWVB8xqLPy7w6TjC3/LfOpm+EDJXbBWd+6iZfIftxN90sycsdPXEycvRKgVOmSzBs8
         xLWdRGiRawQQpbobkJ8H32c745AuvuHfPBtJqqDgRzi+mZzCgmGJTjzUTAdFiOYFmLsF
         DWi2BWTIIhUrpvILmppAMzaV5ExfauL1MET37yKt5QTBmGF1xytK0/DvGdmkVCXBFwOo
         5LaOa//zmZ6e0PnYuhDt8LGpZf0HWT/Nox0fRd/xhnRDluJBErN53QjB3ubkdtV1nm4w
         TDIRVKEDxN3C9pnh3k1EvXix0SBGQGuXGToNKZa7CjNXsrG/2tZtIrgpB7j/yoiMwW62
         /ZRg==
X-Forwarded-Encrypted: i=1; AJvYcCWEThy0wMzNG28eBuX/U3RinhW0cDm0gwFV8+RcsRF0NvjxcUHtbmigDldkfD+sTGm7ZHSZgZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOhs/Qf7MjsgzWwQYgi1eUDdzMfEG8vUfZ50JjqnxVDG5z2IIs
	lyfrQktSJE6Ht+UPtuzIQiLlTfHVemJuaXYEmAzXIEk51D9QzMvIe55W
X-Gm-Gg: ASbGncuILORALAv0rqZbvsjBjaflqHWkVu1HDARQzt+fBCSvWjV+FsEqfIPBcxsCVCK
	pHa3jFyI4Y8nS8KEAXfjufjdR0GcwOQt8tzU1xpAbSv3a3k1/Chf6LyVLsheu8HOsiWwEbBoOZV
	sZGk9nD+rEy3GKHdsqbewbGt7mWDe7n7Ro3R8VRQFFizExCPGmjz9sahEbq67oP3I0lmkrhc6Ty
	t6OXI/JocZ5beLFtY58jf2xvpq/7qihvG2ay/CtRVj3Fx8WNp6UvaDKuL2h8/RG7dXfExE0CU3j
	skGDlsMUxKTY65mSzpwGWOKYNcEep+zBnP4b3koqeBfP99OCOSVyjMCny8aFAaPAwGphZQwLodt
	uYw7HBBZ5lzMq+FvfmQBzYy68+KWeZsDaT+nNwG6+6khAxUOyBrSuShO7UXJuAOPU1fgzDap8eb
	aT8IEHVPBw255XIEjzhQ==
X-Google-Smtp-Source: AGHT+IFGmvrlTRJrVB5IZHQoRBZsqDSzVsYhhC0KT8URosDDz4O0ZlQ6n+lydCzN5y/3yUEEnGsBVg==
X-Received: by 2002:a17:902:cf0b:b0:24c:cb60:f6f0 with SMTP id d9443c01a7336-290cb66025amr253714265ad.58.1761090432218;
        Tue, 21 Oct 2025 16:47:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc2e0sm120841465ad.34.2025.10.21.16.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:57 -0700
Subject: [PATCH net-next v7 14/26] selftests/vsock: add check_result() for
 pass/fail counting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-14-0661b7b6f081@meta.com>
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

Add check_result() function to reuse logic for incrementing the
pass/fail counters. This function will get used by different callers as
we add different types of tests in future patches (namely, namespace and
non-namespace tests will be called at different places, and re-use this
function).

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 020796e1c31a..5368ec7b1895 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -78,6 +78,26 @@ die() {
 	exit "${KSFT_FAIL}"
 }
 
+check_result() {
+	local rc num
+
+	rc=$1
+	num=$(( cnt_total + 1 ))
+
+	if [[ ${rc} -eq $KSFT_PASS ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "ok ${num} ${arg}"
+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "ok ${num} ${arg} # SKIP"
+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "not ok ${num} ${arg} # exit=$rc"
+	fi
+
+	cnt_total=$(( cnt_total + 1 ))
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -523,17 +543,7 @@ cnt_total=0
 for arg in "${ARGS[@]}"; do
 	run_test "${arg}"
 	rc=$?
-	if [[ ${rc} -eq $KSFT_PASS ]]; then
-		cnt_pass=$(( cnt_pass + 1 ))
-		echo "ok ${cnt_total} ${arg}"
-	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
-		cnt_skip=$(( cnt_skip + 1 ))
-		echo "ok ${cnt_total} ${arg} # SKIP"
-	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
-		cnt_fail=$(( cnt_fail + 1 ))
-		echo "not ok ${cnt_total} ${arg} # exit=$rc"
-	fi
-	cnt_total=$(( cnt_total + 1 ))
+	check_result ${rc}
 done
 
 terminate_pidfiles "${pidfile}"

-- 
2.47.3



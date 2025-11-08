Return-Path: <netdev+bounces-237005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 324A0C42F92
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 17:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C83034E30BC
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 16:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57C4277CA4;
	Sat,  8 Nov 2025 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkMf05om"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B8228CBC
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617725; cv=none; b=jInkdh6Nlzd4WoOOLaMsztmp0wujlj1/BEHy1Sj6lhfcN3K/lW77nlUvM/SCmM85qakd2PNs23aoMH8n0vDbQqfFtKSl35EoJBaaSNaFXHQQz3Q7XuQdB6PVAuarxrVlzK5mLabDEmDkZJq2gBxSApqsGd0dJmycZaZkiapflGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617725; c=relaxed/simple;
	bh=oHgjWws1DBoTOYU7ER4ATIFMREmAxgb84D48zVV5FD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjBoQaoe0vj9iEEH2boHOE4nDMrp7mEHUG8rriKI9oMlM4h6fYfH2BT4twQ/dEkI4fetyXVUaxH/+zf+bQ3BRI8hUZi3RKGrLZp7sOT3lVd0HTthTyeK8MzYBPqiz7J9tBVXp1w6dtD8ma/0ba8T/QFJbvrKGMl7laNR5kwxhnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkMf05om; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso1303005b3a.3
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 08:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617722; x=1763222522; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=golzAGu/U48hdgp+/GOKuXZcnB4/AsbzkE6v0RidcZk=;
        b=CkMf05om2Vg00vdJ06rUhgEfh+e6dwVRfhLlnYsa8Z5CtlplWPMkFWtPvn2If8z7WS
         +g+XeMeqp+cszK1pdutUhoBLlvrAGhujpZlNI/LG6dc21YGhqB7dDVepQ3nkwcwGpL07
         mMMBx/MTYs+ldOHIeafzi3uV8nYeFAjLU3tgVwOqSlzSD6X47sYlgWV3QsMPddeED21N
         ZCR4nGepg1o1cTgllW6sZpPxsMsXLOO+CgcIocAvXcvK4uGwcmDLdq1qA1ktDth0dRKm
         Ed9siiIBSO7s6E7Juq7y7ETuYcVVxhsxQbn8S/h3n0/r2H5YjRmEXu33lw7C5kvpEqCK
         bS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617722; x=1763222522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=golzAGu/U48hdgp+/GOKuXZcnB4/AsbzkE6v0RidcZk=;
        b=MidZNXoeYT5pkB1FblVQV5gCiYqVDyfDNutviW0MWjPlm9qfU9VhBGfN9ZT87uVWnC
         scBr1WNH5G6LVVWQIBCUyITsi/URXTWJKQPqdi9S5feDr7dNQYqua3MQHTINamJZTutS
         PfpLZCcLGy7wYfZL9CLAAujXrNYgLEnllCZPsrvCGcDlorzx8mpHA2nbRqFer42PaIAs
         zK6028xJS4B8YuBMq/pqEkYMjrxpUvqhaycEKGf07keunCEGGauv93ckOAvUaOx9Y5Df
         9sM6XyGt1UkeC2xdYS00Cmv9NjhVMDvdd8QlGC7RarD2C2Df5CRz/Y7GGstgU22bEGuX
         tDjA==
X-Forwarded-Encrypted: i=1; AJvYcCXv4hCbn+6QbBiqf8v1aUDEEEvlpn1vrE9ZXfaPp2d6aZmAZbEutjZynfQhbJigzQNYliImiQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdQjuWCQUEkLSYnsOl0VmydQCwJDRuYxz0frhbw8Aqtis8QQTn
	7ltexoLLyXmK2ZXyIvjTFcNfkYrlQcSzGiOkJAfXVLpAP/USLXZpfOQTouqFpiON
X-Gm-Gg: ASbGncuI9sTZgRL2a055QuBAl2nPkUUh3OnqwDY1HjiyrJWBQo4+dh/zNkgkR5jqtBt
	LNkR/RuZtCRjPmsPE9egp3N+hBvdFTJvaYZapgkkMm0h1PNFgjXA/bNRVV3EsFROO/Z7sIn8dFm
	YNBjIJIeyaJdvZqYYIocTD+mRoEd/iLv7PirZxreQ5Xi51EqEEA0N7k/dDSzeS97+NnNtMi4kly
	UsyduiPXg9zBbeLVfqsPuBxpY+jNvMcrLLC8xBquUwZh5RWj/r8R2oLGfO9jAG16LV+OnACv2vJ
	R8SJg3tPZY0FhsPxjsRROtzVRD2ObcoIl4CPf8slbVayp91p7C7RtkxC+hs4YlU0ihmXbEOMFtY
	xwCjSA7Py4c+aYTwGTFXkAI50W3HjEgal3VisPgr7YoCpE8lZuLYc13xNR3T5L6DSDBYhCfCAmn
	NFXxZPij0=
X-Google-Smtp-Source: AGHT+IH+Vi5K6pMe8JfFAOXim3vTcOSLSn5qC8SzCV1Ipfc/i/Us/WTXuuK7P37jiIt7Ll9os7AY0g==
X-Received: by 2002:a17:90b:2708:b0:340:f7d6:dc70 with SMTP id 98e67ed59e1d1-3436cb89b05mr3302246a91.13.1762617722221;
        Sat, 08 Nov 2025 08:02:02 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343727dcf3dsm2104024a91.19.2025.11.08.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:02:02 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:01:03 -0800
Subject: [PATCH net-next v4 12/12] selftests/vsock: disable shellcheck
 SC2317 and SC2119
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-12-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Disable shellcheck rules SC2317 and SC2119. These rules are being
triggered due to false positives. For SC2317, many `return
"${KSFT_PASS}"` lines are reported as unreachable, even though they are
executed during normal runs. For SC2119, the fact that
log_guest/log_host accept either stdin or arguments triggers SC2119,
despite being valid.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 42e155b45602..c7b270dd77a9 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -7,6 +7,8 @@
 #		* virtme-ng
 #		* busybox-static (used by virtme-ng)
 #		* qemu	(used by virtme-ng)
+#
+# shellcheck disable=SC2317,SC2119
 
 readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
 readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)

-- 
2.47.3



Return-Path: <netdev+bounces-236998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB92C42F35
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 17:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E06D54E960C
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 16:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CF723C4E9;
	Sat,  8 Nov 2025 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnQLgxIs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F721B9DA
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617719; cv=none; b=l6v3bvYPZV9RZcGyUV+IE/8opY+EAhdrk0gVWg138ZzdCRNiajOPsZkD8a0Ct2KlbkAWpjUy49aZTU1atkJbWQZl+360ahSiTPkTZSFSa8nEJcfwPr8ZQu/BcB5oZDbslnvd/NkkEvzHRMlt4bYQczdA5nOj79TB+vVmmYUE+QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617719; c=relaxed/simple;
	bh=vFLZWv/FUrDafqhdvi7+WMCrHvjI3U/d+lidxcdSdHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HGePm6mcAaJs7jo1gw2naLeiaY/DxGPMUJEmMBX5eR3J0pLekmYLTRJYPSuGeD+cQisZMb6K8tf6PdzKNxDgD0qeDo2OmzbZdiOC9UyrxpVsuhOwDIoH1NsGThgz1LBSKy1LSn6ZOckq0O9ycU4waL1fQpL6qDne64G7aWOBUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnQLgxIs; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b62e7221351so1433650a12.1
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 08:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617716; x=1763222516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8TzgGQWG9WGn9L//XYwS5wGYUOE0Hzr54Zzu6AsNpCQ=;
        b=jnQLgxIswzz0nLjG+u0WujrtVyeGbMRC+j2q7GE3Yn+R02GssqD+BkAksaYf97VlHX
         tl7ePsSEzgYrxm9fV/q7ufil+ri0cW7gAxv3sRmXRd6M5tJKOPR6dJN6YkCdDkCIxB/D
         CjnwlOF23bluccGhNiZrb/4lDoI1iUsNU5YUyguPev0gElKN9hZmZqZpTMTy5xdY5A16
         B+reFJgK3yh/GW3EHuQWz3jkssTxbyhyLJz3NmtMDGQrHBaY9MTXllnucRu64IVa5knc
         4ve7XVVl6m40dxi7EopsM6SbTt+55LPrLf0xk8BZm/DFltpQKt9aogdqEoQEXrBU0AEc
         KauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617716; x=1763222516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8TzgGQWG9WGn9L//XYwS5wGYUOE0Hzr54Zzu6AsNpCQ=;
        b=IsKUb3s7CmZNQsMgCdoCFIyGpmMfBlijQtxJjVrONBECCOKt5Ud1XYUV/VqlrPrINJ
         /U4M5o8nwPDtkgdtYr5TIfwhpGPvMsMXs+k/uMSpusYsqHK5EpWT8WhlE0YdFZAxp8q4
         wxMpkC/8Z+YGLEPeyAf05FUJtIqtnLVPPDH/8ZzOiZ+UMQjn1I7z0Ttwr6iO8keaeaHB
         F/PfFvwa7jy6mQmhyB+UZ5WuBApevfdwMR+0ZlwDFV21DE+mP8c5WkUATdLd1KM3oKKS
         89Ir0jhptO38gp1un88zQFn2rthO/FlEYwDaQlLBP9PX0v71LPHkmhLLc79IvuFUHqvV
         CrCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+PgdHMCgWWFAZPZ5ojDqSjLXtjXPuqKznV3WIcWsngmx4GCpcxA5DWXTM2ZBXj8viFSsrK9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk8uciDTkIp9Pn7/dd1yNO0iG4n97COD7M2ND9qmO6RW5mn4mi
	t04b7aoB+IR1LPbwF7IL5o/hPlx+lsUqhImzUU5JAnmCJ/NAvqOXSu0P
X-Gm-Gg: ASbGncvcK/k3AQzqUWLWwLcC0sHD+V3aRYandSMyHgWp4Qa8tWGk45IaGLIJ4ASiVsR
	Ks57cI0LfNslaQIGXIUi/addEjP7fUfjR7um9rDRymw7ZWtzg5tITE/fzZJ4ToRR08xFd6XKjcg
	Do1fiyXdaO0mmGmT27qIXo2fhAUsFgmgPRfeZZXeYQfigppkryEvzBxfbPH69cd/Nm88FxHYfHr
	CKwaQYEMlNkxH66Oec0ZtwwQd4BLestTnGoI/uvl79hT1+EhauHCapujQhqc3KkapxGHFIj5o4z
	vYQctv0zzspP97P53Lmm7ZqyaN/77dR6p+E7P+MB2zil4bHl+jfMeBEgzy5L4kk0/HEPor6VEmi
	hhy4li1BSBJXC1FxoXV9EwLfOhfBXBXW6OMuueaFyqnHri7nR1f/K/VKoBw7Jk5DEhklJxdNEnL
	dnSF5fJh1W
X-Google-Smtp-Source: AGHT+IEfqRtwhtlx9re+8tiJC6AWXgiAQTuALNt7ZHJZ0Q9RkasCM/u0W7yOilEslz3OhmJAdBVkcA==
X-Received: by 2002:a17:903:244a:b0:295:592f:94a3 with SMTP id d9443c01a7336-297e57101bamr32706755ad.48.1762617715878;
        Sat, 08 Nov 2025 08:01:55 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0060sm92578535ad.108.2025.11.08.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:55 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:56 -0800
Subject: [PATCH net-next v4 05/12] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-5-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

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
index 13b685280a67..6889bdb8a31c 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -236,10 +236,8 @@ vm_start() {
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



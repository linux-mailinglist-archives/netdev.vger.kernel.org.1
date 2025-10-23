Return-Path: <netdev+bounces-231936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6957DBFEC7E
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 183DA4EBD2E
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162F52367CE;
	Thu, 23 Oct 2025 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWanEwaX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E734721FF47
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181232; cv=none; b=H3DZ5+hcS5iDoWZF0cJavgSRLPxF0yQitOnL6ytT+GnfyJYs/NkPhd4364bKhZwIozoeYhZ5LXRbACJgKTxOKBSlS0X3ajNCngKwTDzEVQ1gh6nGHzZAswqBZ9gIr5ocXZ2IfxTJ111ISyH1SpP0SNcR5wXhVJIAKvm57jNsEmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181232; c=relaxed/simple;
	bh=4pbEdZWO3naganJPGX2hHH04O1jq6bd0JAXIDNigrjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XP9JWNI6+vM22rMLy2z6/q0GwcRvq4sSEn8QVJvHu6tn5n66QAkbjSIy3zzxIy1Y7Hs70CIGqkxkZGaUAY9Zt1gU59hAyRp5ydkza9GGHCXBE7GTJU32KyeiO0G2ufE1iUsVjjmCU5hdf0+YkHtCtkcIRktT2+L8GLJk8/Maxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWanEwaX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33d962c0e9aso205687a91.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181230; x=1761786030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXOvnbfPKIC6rRblSxQAXqJxbJ18ywkGP6EdCLVk0Qg=;
        b=dWanEwaX4qyY4otH9BIzAq4fA1PfDUzVMnAhcpgGxSQyKL+3vz8DfW0CJNO3jDzZHW
         6AznwGs1VHGdF9gJcRWkbMC4eGVyGrf8raqGZNC7HiarvVLWYIeMo3/Dr+0nRUcH+++u
         wOLkjgy+6PMi8T0Q4WpXsNpW/QTkOW+PS4X9ziI+/tvkvpKMwrHFMV2N699B1th2lLD7
         ENwQOy763hnuGy+8o1Hgrgz7zC9GPWJpBFTHdBe7Xku7NcgBfyXHhBZv6jFJ/f7YLIVX
         MxpAsD8tPLnPust3OQtJKjMn1Wc5bdkahzrF2Ez6Ivq7XW1YzCeoXMD5Ok5QEQVxkv6a
         EPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181230; x=1761786030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXOvnbfPKIC6rRblSxQAXqJxbJ18ywkGP6EdCLVk0Qg=;
        b=YLDtXoIvkI7VafGuBQJZl0K1PCMzQZ6c/a6UCwwGNIUzuVeZMF0oiDkTAMj7P3qwEy
         L6SyoAoywLR+56v4QnP78gI/Sxb7HUcXUSJ6+h4PDWj229ETW1orpx8Kgm8pL+zYVMF2
         6UfvCZA1JTl12hQp0Hv4a85Y6X+15R/guEe54nBIFYD6ldvk12SeUgYE0dadaFbuXkKF
         Hd7b9Hr2pLi7jeGXYGKqacpAtkJox6IFlJzVN4K8r/5m/DuozgRdv7Ef6W3UuUveKVz/
         zQvxFxgdfiMcvhURO6Eae/EEkRgMy3vgwroQFqrDsUii5lEvyRJuWiD8h/+fW6BozFyG
         ND9A==
X-Forwarded-Encrypted: i=1; AJvYcCXYw347cVsuE6z1QewL+1+EzWHDhHOG3yjKvU9TWqD4ZlvKNxNHROjlm7CrKUk1pMQoIh06VZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoclQ8AfgOJ2EyhAdVDidTIerBGYZ+k23jM+IuvVrIm0wXfF82
	7jzpfv9BzYZsVJjqTXWj6PetKOqSyNhFh8ZUWPSGTfbr8YUZSiU1271V
X-Gm-Gg: ASbGncvA845bguP/qGHPV3+emd/wSU5MiKMHpKabspaigigmOjLINjj0vkewrGSRjdt
	VjFwXncpDm7J519nWgvbo8P/o5gQkTbi3wPc5SZ++GxrzsAZmc8Fgt3TkEMryD894HgMm8ld+o7
	1wqMdlPcw70bblVqrDzkoBU6A+meOtLou6Q9H4G8x8xWbqZwBQ0eug+zGMr20oocnKplr8yJ6hs
	1Tj0UnTTGAO2HjWrcrHewxuRSjVC9KcwFbHpNx2OVjPbLOpJ+GQW8923UxTb4IBPCf7WHriIlgH
	qVKgwUx51VfhgpU/IERD33YYXNV68Y/3CGzy9vh885Om4xlVd2AZoQJ5/EZ7KJmWlYMjZ2VExnJ
	YzmD2v5yGkyHmsiLBqXus/5Y0HSVY0jsSM/V0dir2XWAfxEN4O6uXT0iQkucODYlUT4Pc+VoIxB
	w49v2Om0Y=
X-Google-Smtp-Source: AGHT+IGDhjee3qb0RmCmk094kyxxRhSnp6cpHy/pZvteX5hCRnyEn25K/Mo2iLuTUZkw6wAqEltkkw==
X-Received: by 2002:a17:90b:4a03:b0:32e:7277:9a81 with SMTP id 98e67ed59e1d1-33e21ec3286mr7594732a91.4.1761181229218;
        Wed, 22 Oct 2025 18:00:29 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb016f865sm491272a91.11.2025.10.22.18.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:28 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:09 -0700
Subject: [PATCH net-next 05/12] selftests/vsock: do not unconditionally die
 if qemu fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-5-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
index 9c72559aa894..6c8f199b771b 100755
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



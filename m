Return-Path: <netdev+bounces-231941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF0ABFECD2
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5C53A7439
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D712749C1;
	Thu, 23 Oct 2025 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEV28/Rn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50C4267714
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181238; cv=none; b=piSYysggYhft5h4yjEaGR2UekDLcXk+nEbw+siWUh/j04rfVrzFwCmuvN1Pd6K3I8oznfC6KTliirR43rLtYgahjCBtlr9wkREvS4iFzfWjg/K+gcPWNUHU0hqO8qMd9iuBX3wH8HQcLwBS/Q4/DUGfq8BJAKjQFNjCyOfOeFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181238; c=relaxed/simple;
	bh=pCmUOoe9UEmIapGX09RMEqNq2xABcKupn8YH5c6OHyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ErMFUxWpiRXtX0b3mh20CFC2QcZ75l4YMRxxDUmERCFPvxWjsYu1iXgaVIEhyjkktpJhP+ODrHrKSar2f/VHEHpEjkxW1n9b0xMxRc1HARmadkGwQbxL8txMh6DhvC8bo6XTarmKuC6JFtn3UhqKgFQ3C9hqRacmm99OCJfY7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEV28/Rn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so226429b3a.0
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181235; x=1761786035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIqQl1yXpGD0T6lxJ76Go260cGhEq3Pe6FtGbdnc7zE=;
        b=kEV28/Rns5coJ3X5E4a6p02RCeuolU4ylPiMB+XyiMs1XlcLmodlQnakG015JngvrX
         Zm4CgaUWvlRgrc6cuH+UdxwvTmtHkTGRHQTs17EZb2UPfusIoHlf1nmroc0szh22xsNL
         AoTSa3IN3Sn60vYlWs4W7DXCm0ddpaUfjWVG80fVUqjO2YdeDkMDmSUkZgcNvMsUYhQP
         A3SrKdsV9U5tdPKg4E8jY0wOlwXD0JXQXS0TCyfJ5klo11OQOadvzpeNQbgD2/3WVhPZ
         OiI7c7xyzj1xTxA2rS0oZdC7XNM4kzkOMQS24hI4iXIP3Zgy2Nel6cNzNmss/xzz4O54
         aTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181235; x=1761786035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIqQl1yXpGD0T6lxJ76Go260cGhEq3Pe6FtGbdnc7zE=;
        b=JL/VKOxWKLYCgMmEbim0IktGZd2CFkx9/uwjriNekWLIwMYgOvdqK8D6v4XGGmZB6V
         bp4mCD+hbO308njXsJntwJ/nvwgOPl8kRf8VT14ZD4QWXUO2uPWb94gWsv3D4MupCFR4
         2ghY++gxncJH5wpi522X0eJiAasZ4V/BwvMrKMekr4O9U+/3zBPnAS50pkbgp637wgsJ
         TRz+u2osyFi1obdAFA+t9gCU7c8+mgwfff62thJvALtsn8tH7Kv497T1X9j++WRrKQdv
         6KdCdittiRuebqGsAtdiuu8oSwQoAQPGoX+UwvJCaaEN0rQQbB5tNIMhDIS+qjReWn0F
         Y/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWq/WZEWdJO3BVs376Yr9ToE7PtlURn4L4fnHnTVgyxnrd2k1dh0Q01yPRHkCTucyxIuBRI4Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwdOthYGKaegvnRFvd1QVUbYruVtnwSp3uN5zdyTusDfEcxVtP
	4vbuj3cQhGpwycdDxI4wzgBPWQvVTB+TqA9BnGD9m7FXYMU7PEpr4/8o
X-Gm-Gg: ASbGncuizjlvazyQ3AqerfH9rzbzCUHzG40/zLTSSRyMZ6eDbtzgaXdIhQ5lRoL28bV
	+pfo7gUQ92v9QCwLOFLY5YUPR7hRZqEj+5K75LNx+guxsYZEmtASw7y3h6DupA+qH7pgOwfHMso
	QHqD11tDv49LDlxaxIvTmRgH+XU69AA1x99tIb+WtOYafgPOgabFDKsiuIONcb5YDq7883i4F0X
	nMvhR1S/poKUyOwbIPedQ2kWZW7tRjQfSBuflvfLcVEQjf06F6UxyyTznLxsoE9ilaP4S68jRil
	+roDV7WxUeXslMVtb8lG3ueRHvDXR63y8xs3WzCdpEGp6W5HIYlP4IfB1yPQb6lInT/gjcj6Cx9
	LfDur+X/yx1SFrh9mtI5XCb14pyoNNeMN9euHPMRorK9m/kO6e1XWQLjjObUULrSzhzEuiz03/N
	PISegr1BFH
X-Google-Smtp-Source: AGHT+IFah4xKWnPJdJQRrSTe40MUJQKUAPG67skaDGCDDAujY8FssP4vUeP2QuBI2KiQcE2PGKu37w==
X-Received: by 2002:a05:6a00:2301:b0:78c:99a8:b748 with SMTP id d2e1a72fcca58-7a220144d3cmr26283193b3a.0.1761181234838;
        Wed, 22 Oct 2025 18:00:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9ceddsm584787b3a.24.2025.10.22.18.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:34 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:14 -0700
Subject: [PATCH net-next 10/12] selftests/vsock: avoid false-positives when
 checking dmesg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-10-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Sometimes VMs will have some intermittent dmesg warnings that are
unrelated to vsock. Change the dmesg parsing to filter on strings
containing 'vsock' to avoid false positive failures that are unrelated
to vsock. The downside is that it is possible for some vsock related
warnings to not contain the substring 'vsock', so those will be missed.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a312930cb8b7..aa7199c94780 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -506,9 +506,9 @@ run_shared_vm_test() {
 	local rc
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
-	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
 	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -520,7 +520,7 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i vsock)
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on host" | log_host
 		rc=$KSFT_FAIL
@@ -532,7 +532,7 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i vsock)
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3



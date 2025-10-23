Return-Path: <netdev+bounces-231937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE51BFEC9C
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A500C3A9798
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 01:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EAF23B62B;
	Thu, 23 Oct 2025 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcfT/tLC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C34A1D6194
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181233; cv=none; b=tF7EqA4oMUC/CXxclCuZ1yCvSaAAQqJvIvzhMwX7iDeikfeCD7DxWHjOKDmM5DtQwOGrqJK38gWadvv5fv7OSXrBt1ub9gPM9/Uvx+Zf4LBbkZN4vF4ttygxuvDo6PUPAdoXjeG9CHNHxsI6eYo33IWvqaZtIUapQj6mcAVRq70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181233; c=relaxed/simple;
	bh=53S5Zx5/+dq3CxymSoKg3PxckRbS+/iJdEXFwbACpeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGnmtAdycHqmpoZkAATBtf12ZUqp04FMpafXOzg9v7NK1gjNR03hu5GNuhLU/KygAVdcocQNJTjjRxVWl6wmvPfI3Z9rBc3g6kb5RKL0CY70cuTLn8VGBqovVjLQKcVgWbDAzV6jyTbTMYgWekmOv2Xg2lYa7N/uprP0C8UF0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcfT/tLC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-781997d195aso171759b3a.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761181230; x=1761786030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hhytdydN3st1fvO6O+FLwguIsO7CYdeOMt51FRiMAY=;
        b=VcfT/tLCM9qe93/s9wsAmucZa7SSwKxk8qkYaI5I93SRF0N+TGfTwwu5PDNEhkYqhS
         JWK31iSk4WICz+bvPoVUW53zHVBSYoAyg+iaxwp8NsrdI0JkxrEs0A1CKuMahafjhKJD
         7547O6hlO+eIOkaTEifFj1li4tk9Tuh70zSLJSGXuYBsG0LXvH0bPuBu84MiGck2ip4H
         F5WqniA03/2cZq3P26FPqZZFNJe7w7qTdNEUqjZBp1XPHjoOi3IPHhhblVaP3QAkrOP1
         Ryp35MorM7iq4DIySQaVOAHTUFN36koedCBpu9PQc8PXNOzE2ktYhHYdNPrPUUkPyKeH
         E2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761181230; x=1761786030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6hhytdydN3st1fvO6O+FLwguIsO7CYdeOMt51FRiMAY=;
        b=p9lPbgVCyf0uIZECn1ncdIeSaPyJyzpC1il1oAPkPH9Qcv5lui6Q4CVXHfbqiQA6QX
         44Uu11ae0qBlWnyaj75GdBPqNCuXPwEB/NCIYX19mUeL0e2BeXEvOzeZmFws0wjtsprz
         pelNdft9PaLxy5mAn7W/vHIdzjHZGmCsEkp0cNEJqpxgEE/GcQVYBd1BgU0Ev319GDlN
         t/mHl09SMBUHPxTZsWHdPt8O6LoLnEpCv9r4k4LqiepqdmU/UOMKh1h1dY9uiraAAicW
         swAnHC50dVKVNBWaUsoIEIfsscgBsSQpvqDKxGQiEfNE0h+ocQLtDsIpXnxO2xDn9Hex
         CAsg==
X-Forwarded-Encrypted: i=1; AJvYcCW+D7wgQI5mv4C3hed+U82/J/04eShGSYtcmsZ77DLn25fduuYazjqzL4HINNTS8xUkeCObEpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrvnkV/BepzMw/i2/75IsUsG7X43K3DXcNrCTQYkoSF9rcOXwo
	sCWqn3Mc9qva20HsuL+jDw6pQysQKkLNevoThv4333Xdf+ixbsL93gg6
X-Gm-Gg: ASbGnctE4QIoQZIRMi0F92ODPcs243pVq3yoVDU7ZTuO2uL18pAQxwrsW664CMQlnwM
	9iQf+OLkDT8qYK4zICxXIdXi6el6b1maPQhBnRytwyyRpiNy7Vgf5F+wnuTa3QeT9B9dgBhzjFe
	sm4GoyesIWVV/ZVmu0cb3BvJd2Z6J4yFu1OnnV7022FiIMCpNzCAvtS4GbIXmwW5gTRCNI0nrQY
	vy6bYDHWwhB/bzh93JA6zvTJK3gD6xED6Q7euk3wqsh2Q1uoJqJUAaHWYjzeBHAMlUDbxq1SecS
	Bu7zGxs+KO9kXu2VdaWQ8PzgnytFE3RUI8RRc/V8dpgABn7RPBfQVnTDjPWtMOXIfH+r8Z61hzQ
	rF9fKj6TPCH2RMl7f3Da6wrngHAgemrEVI1SzM4hJKTS5vCfpjlxtgFE8/afbFIrmTpFh5fsQWz
	uJMLVf4/vS
X-Google-Smtp-Source: AGHT+IEOLFrEwrP2Rf2uPvi/YyHr9hHzHgOPOlWS5DL5z4avx5Oje0geKjvDdLHF1RWLtx4Gg/89VA==
X-Received: by 2002:a05:6a00:4fc9:b0:7a2:7458:7fc8 with SMTP id d2e1a72fcca58-7a2745880c9mr1173130b3a.13.1761181230338;
        Wed, 22 Oct 2025 18:00:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8a0edsm560059b3a.35.2025.10.22.18.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:00:30 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 22 Oct 2025 18:00:10 -0700
Subject: [PATCH net-next 06/12] selftests/vsock: speed up tests by reducing
 the QEMU pidfile timeout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-vsock-selftests-fixes-and-improvements-v1-6-edeb179d6463@meta.com>
References: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
In-Reply-To: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Reduce the time waiting for the QEMU pidfile from three minutes to five
seconds. The three minute time window was chosen to make sure QEMU had
enough time to fully boot up. This, however, is an unreasonably long
delay for QEMU to write the pidfile, which happens earlier when the QEMU
process starts (not after VM boot). The three minute delay becomes
noticeably wasteful in future tests that expect QEMU to fail and wait a
full three minutes for a pidfile that will never exist.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 6c8f199b771b..99db2e415253 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -22,7 +22,7 @@ readonly SSH_HOST_PORT=2222
 readonly VSOCK_CID=1234
 readonly WAIT_PERIOD=3
 readonly WAIT_PERIOD_MAX=60
-readonly WAIT_TOTAL=$(( WAIT_PERIOD * WAIT_PERIOD_MAX ))
+readonly WAIT_QEMU=5
 readonly PIDFILE_TEMPLATE=/tmp/vsock_vmtest_XXXX.pid
 
 # virtme-ng offers a netdev for ssh when using "--ssh", but we also need a
@@ -221,7 +221,7 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	timeout "${WAIT_TOTAL}" \
+	timeout "${WAIT_QEMU}" \
 		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 

-- 
2.47.3



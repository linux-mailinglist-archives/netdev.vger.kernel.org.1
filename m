Return-Path: <netdev+bounces-240665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 587EDC776EA
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 06:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 8138F2CC84
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 05:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8702FE598;
	Fri, 21 Nov 2025 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIGiNvYy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB552FDC3C
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 05:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703903; cv=none; b=s6ctNqRGqS7/T8If7yoTZfhDTpwTscju0vNRRlbF7KOB4hPCBOwQMgXvNW50wrSjS45cWJ3nhU352ziUXYvqRaTUExpPMGTH5YulbIWoyxmps4S1lys/H+pSwFWKLgrThmoebYq9xfTEJa0EFwpzIzenayT2i1HWJx96rUHLtzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703903; c=relaxed/simple;
	bh=nx6UHyycvOx0nOMJPrniexSgcT4f8Lew6DQLvX17eQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CDKHeSCLX1tDy/je9WyJOXlufCgFv/dBvbQtvGn/nTmqVfue65KJNhzpNmnKME9YURDTf/2CO4zbrBm5p4AgiYMT4+f6soT+W7xZ9K5s8BOq+h8mmz8JedJSik/QWxqzYzx1ggfDiFqDBHU4QS/znEuyCzhf50m6/TTiNgb0xHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIGiNvYy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so1873999b3a.1
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 21:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703899; x=1764308699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WanE8FrhGxigttKl86eZszwf4U+f6tE0kVhiGDUGVY=;
        b=XIGiNvYy65++kSc1B1HqQC6TtCuiv5nxOxbFE3MP1nSN0Rn30KHMSEoG6W+f1pf5fa
         vQWTgyXdxY+RvJeCvEqPXSgtpjN/cb/DvG7ZMDnHiw9+LOaktknE3zrVLKMRZxyc4TGv
         15XuW1+Hjh/yi9t2cj2dqFPCP8IYlUPXZtMG/+1zokdyGyi0obrfvY8aTyX0cDQlKUx3
         FEDnidpQyx98b/LkBBl19spwy36Karcm3JTKxCPoxTHWCtosijdXCHddeSWWdDubBBdQ
         bc8E+oQhbItA3wSe2BmW0fUdaMskfmFzS1DkKOcarxSzD9ITLsqx0nPCmYYy82Kz1BWF
         whvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703899; x=1764308699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8WanE8FrhGxigttKl86eZszwf4U+f6tE0kVhiGDUGVY=;
        b=Cu99PC+r66Be6kUAJxnu0SodONYzA/xPEWiCpKh62RUDWAxHVF4s2AU4nDxA8XHa3A
         0Ct/mjw4UKHzososRSxJ/GsjG8ygx9JI7vEPqtnombVJ8QX+B8SfOSTl6TesGq2PTIRW
         IJT/JHqv7tmhc9bh+XG+DW90EEn1y11vY6Js1e8eW5TxDNpeyi3DFnwr+kzBm/19sPos
         dp+fSIfzZBFu2fvy271SyM9ArAJiVaNvIB3OKyMiGMpO7b9ytFId+MMmgapa4y32YckI
         5Eg6JM0ZR/Atgyc4nJrq6230V42PWtWw9Fwwhgc1xygGPMvkHlqnJMhtDLcDqUZD1NC/
         DtAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBykvmLdGp6evEvOu3A7y2Jk/DVw6FnoqE8KFcqYz1pQQGENmIgrnFmggutI9Dh8GVOeWF34w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzLGEOaFSuCw5MhnBF+Z95qh+sp7gumIKgQUJrKSJeJ8BGPtdk
	HXz1eeQZ6MbzKoSUhaSPaOusnJl8S3tXAsCuYJsyBZkQEJzYYIOXvUr7
X-Gm-Gg: ASbGncsCDBxQ3bqIZkEz7KobyspJ6ISmaRm+2YToZMHRp60ZnChbiv4e13reiuo0cdo
	CoDS1X8e2GtAGCSXBCx/Dz8F2ZWo17cJa2txCX2lHaGWytzylrxgS3w4o5LDq/asa3+d+MigVSN
	F1JbEZk2FAye8L6lbiXkx8BNL45z6HGB/T0TLLs8TAjoEQpoOKf87jz3KRtolU4n3+Sk10nxsCE
	+LsqxIddiRfrPZy0ngcv3+KNVzI4DzvHEBszUaEzeKRIP49TnABsRXshs4Q/WiC6YWW7VAjF7en
	OyEJ3VGtlgkPAnvd+wX/1p23/borSbiO3Eksjr+DsdE/zzPkD7a4TMmQT7tcBRgY6hEeUDw9+M6
	3M5uIYDvZeV/bAtsIjUuvmJBBUw5aO8QFIaCP00Kl53Kr3Vxm/pNi2XTbvEmySfoANQmF0Y0Z9J
	ilDPerEdnzZ/i8uaqLq2BO67hdx6GUNzk=
X-Google-Smtp-Source: AGHT+IHqyE0w19zDPkaB/Ash2VMSaGraMj87gNleVuj/tN2LhZMjdzS2nkC0fyQfEaBt2i2bVW/KCA==
X-Received: by 2002:a05:6a00:1ad2:b0:7a2:7237:79ff with SMTP id d2e1a72fcca58-7c58c4a4fe3mr1123886b3a.7.1763703898643;
        Thu, 20 Nov 2025 21:44:58 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:42::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63dbcsm4627465b3a.50.2025.11.20.21.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:44:58 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:40 -0800
Subject: [PATCH net-next v11 08/13] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-8-55cbc80249a7@meta.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
In-Reply-To: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

These functions are reused by the VM tests to collect and compare dmesg
warnings and oops counts. The future VM-specific tests use them heavily.
This patches relies on vm_ssh() already supporting namespaces.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- break these out into an earlier patch so that they can be used
  directly in new patches (instead of causing churn by adding this
  later)
---
 tools/testing/selftests/vsock/vmtest.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 4da91828a6a0..1623e4da15e2 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -389,6 +389,17 @@ host_wait_for_listener() {
 	fi
 }
 
+vm_dmesg_oops_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg 2>/dev/null | grep -c -i 'Oops'
+}
+
+vm_dmesg_warn_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock'
+}
 
 vm_vsock_test() {
 	local ns=$1
@@ -596,8 +607,8 @@ run_shared_vm_test() {
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_oops_cnt_before=$(vm_dmesg_oops_count "init_ns")
+	vm_warn_cnt_before=$(vm_dmesg_warn_count "init_ns")
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -615,13 +626,13 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	vm_oops_cnt_after=$(vm_dmesg_oops_count "init_ns")
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
 		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_warn_cnt_after=$(vm_dmesg_warn_count "init_ns")
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3



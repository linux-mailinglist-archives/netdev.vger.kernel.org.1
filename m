Return-Path: <netdev+bounces-235847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 942FEC36873
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 16:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4078034F30B
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 15:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED663203AA;
	Wed,  5 Nov 2025 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQKTB0pC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1C0330332
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358369; cv=none; b=Y0z7JnOs3Sc9TlEQ2Jm7nmzf35Fb5VmW53Kzcy1o/WQYYLeniRhy76QtBx9jNMGDxm/+8Zzea4gpuVV77qsJBhhbYOdfZb3CNW5tn/EJlgLhw2vci3LheWJbIUrNSJQrHLDOoOctha64zUeWgH1YxBikIfe7F49SaucA/d9yZiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358369; c=relaxed/simple;
	bh=pVSfoO/0UIFMSnMLr516HI0z/z9lVuUNXwJAeljB520=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jRK43CDBEsOFxcEVRk92VeggMJ9apu0sAK6Uyptx5yrJAdZrlvQlLRXZaF8os3+RfS7h8bH+c2HhIQLRu8ZoyL7VUp2UDRJBKaVG5LExYbSId3bt4wBz0jCRnSDziyX8SQ728JpBQcWlqohTK8/wxqs3eCzep0RdwXU3Y/bVTSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQKTB0pC; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7810289cd4bso17014b3a.2
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 07:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762358365; x=1762963165; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcWLW8qdCBVn4955Lh+XqTuvqquYHifTQdNcqINjy8Y=;
        b=JQKTB0pC7LcRg+weqNHESVw7FKSbK+2Wwr9uKEZ7mcOBbceGl4i8i3W9LhA3RW7rZ1
         ybebzcAlmQJ+u8YiWK/xizL9PUg42vcN5BNX6oYEA1fpK2SYm3SkdF9QGBP7teuHuuaU
         X/F9HT8iq9fw0pQb2fdIUAqiJU6Tf5sFxXX9SLz4XZ0KUTcSIuzAISgR0JolF3zH9oFC
         7hTnSoBM7Cw7E5vm+NjQW8itTFz1HLpmK+zmTnHXRe+KGWhbG9ZPA+OUgScTeTdkj6Ne
         xEnNsd3GN+iJBrPV0XBTRXvCNby3wpeQNlf3WlyGGPq20Mw9cLn4MEbabymca1AwNhxM
         0nzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358365; x=1762963165;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcWLW8qdCBVn4955Lh+XqTuvqquYHifTQdNcqINjy8Y=;
        b=eqPD1zEFbCDEmuD7awR/SoJx8LGpIvLU3gShKewV5TLnGxLO/rICxKAf72qrT1vpYy
         kVnFulviW6kyQVROysTA5F8TcF3Yge3s9rRjKpeUgphJfT4+1HaU4eG7SpEEU1pEtFWc
         GP3LY7eFqq75SQA3nVRCq2GiYcNq2D9D4LVKwJcAc+F4qC8JwOt2tUuqSwM0OSDDhfCH
         heVawy4dPm2lfbG4O0anEQ1yDvGBWm87vy8fVU9lh2TdcMP5fl8oNX8av05BUFOJvyPo
         SC8jLh7wEouR7U6BQ0i/luLXnHoiGOCZ/DjRSx4EDICpcUn0B0OKo2lp9emq//rK3Dpa
         irVg==
X-Forwarded-Encrypted: i=1; AJvYcCVOu4z0+c2DQDCAx4rOwKg/kjTY1h0mWTLXagg1+FNYc/qzHx+ltN+YSR6Qcec9d2OPM15Olps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwipIffnH5Il3hVEZZywe+QT9kvwBoJIFSvOAO4tECdHrW36BPG
	N4ySAJF4jTFPar9ddj6HNZnwuTE9hLz5Dbd6TdNOJ21i2yLpYJIO9UICUclR3KZC
X-Gm-Gg: ASbGnct0gj7ky8dyMGhtMIfQrV5v5bPiIlrqbYvOFzR07w2Tl+xfPFjK3UVLFJ/hDSf
	wMTohLxZzAGdqhuXq7whOr4rpuUeoIm9YoA9cLwMtD7Wkvp2cV4MWyg+b6ZlmwrU0PrsK21nC2L
	W2ntA1e9k+E7Ns34nCVfnRkR0iBIbF5yWxx24QLKGuVlrW8cvqTzWMR8/GxyqvIqiRKkeoTY8c0
	xtMXfugrAWzL9+OusAcu/X7tQ3cpID/eY5g2gvYBzYyQUMzLntDfgMo/lKxsRYDqyJgiO0CmLhC
	wFMwQWiuglyFJJXsUt3iuAgI/yDAcPsck90hhYAuO5zcoANgH9ODkZQ9p9mnNdcvGKwe3An09eh
	KhtT05wjEaXriHSa0mZUxwzvGtMp8iZTSEsN9mLQ5FTgwleWApAoqWzty/vb3V/Ni3LEYoeRU+Q
	==
X-Google-Smtp-Source: AGHT+IEe5YQ6JeJmA49ewbcYItDVFikNimAbp/SS4l9S+v7yYwjF6WuYS8I7WYaQuTYcUp7f9KrD4A==
X-Received: by 2002:a05:6a20:958f:b0:347:5ce0:6dda with SMTP id adf61e73a8af0-34f83d106fdmr5164430637.14.1762358365064;
        Wed, 05 Nov 2025 07:59:25 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2893bc6sm5859917a12.10.2025.11.05.07.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:59:24 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 05 Nov 2025 07:59:19 -0800
Subject: [PATCH net v2] selftests/vsock: avoid false-positives when
 checking dmesg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-vsock-vmtest-dmesg-fix-v2-1-1a042a14892c@meta.com>
X-B4-Tracking: v=1; b=H4sIAFZ0C2kC/4WNQQrDIBBFrxJm3SlqKpiueo+SRaJjIsVYHJGWk
 LtXcoEu//v893dgyoEY7t0OmWrgkLYW1KUDu07bQhhcy6CE0lKKG1ZO9oU1FuKCLhIv6MMHZ2X
 1QNINtjfQxu9MDZ/iJ2xUYGxwDVxS/p5nVZ7VP2+VKNEIa9zce+08PSKV6WpThPE4jh995KsJw
 AAAAA==
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@meta.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Sometimes VMs will have some intermittent dmesg warnings that are
unrelated to vsock. Change the dmesg parsing to filter on strings
containing 'vsock' to avoid false positive failures that are unrelated
to vsock. The downside is that it is possible for some vsock related
warnings to not contain the substring 'vsock', so those will be missed.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Previously was part of the series:
https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
---
Changes in v2:
- use consistent quoting for vsock string
- Link to v1: https://lore.kernel.org/r/20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com
---
 tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index edacebfc1632..8ceeb8a7894f 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -389,9 +389,9 @@ run_test() {
 	local rc
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
-	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
 	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -403,7 +403,7 @@ run_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
+	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i 'vsock')
 	if [[ ${host_warn_cnt_after} -gt ${host_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on host" | log_host "${name}"
 		rc=$KSFT_FAIL
@@ -415,7 +415,7 @@ run_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | wc -l)
+	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host "${name}"
 		rc=$KSFT_FAIL

---
base-commit: 89aec171d9d1ab168e43fcf9754b82e4c0aef9b9
change-id: 20251104-vsock-vmtest-dmesg-fix-b2c59e1d9c38

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>



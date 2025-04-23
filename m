Return-Path: <netdev+bounces-185277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7085A9999F
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8E1463022
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 20:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DFF26D4E1;
	Wed, 23 Apr 2025 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="K0BKg295"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9DF2580E7
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441245; cv=none; b=W92q7zj3k7KgJC1eWN9v5I59qk5IC0DdONbMiV546y8H84xYCPJC9gFo2pNmDCVqOHJ7jjgN0Pfi8VV8Yfj2z329WA9Qri6RVkjV283nlx8L0mKnKC6juTOktbS6djDzdUnL9eAmVyd+PYE8+ALdyHSoGj3KLt6mtwUrnk6JW1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441245; c=relaxed/simple;
	bh=9o+fog/E8/Y/Ep3sI6pTRlp7waYxHqWZlzLlUSvxIbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KyKPbt6TtOLYk2YV+9NtErJNPpfRpniRm1ws5wV8i7XjvDDlGp3IKAIxc2qPo8b9cvhUnDU+KStb/jPvawOrrJef4xqpGyRepglW1dogKzSbuDTAKkiZlcrdj8f66NkBy74o4VuXraGokIsoGVARjG4GExsOrwyj2AgpXZW/3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=K0BKg295; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30549dacd53so249708a91.1
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745441242; x=1746046042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qadNYoaJhFPVnikI7MqGvzeOQWIRrwJCqdY+2xJb3Ik=;
        b=K0BKg2958DiU4hWdg/ztCOoAJvYPW3CMDZWb+ZwOdV6Vl9Pv5dXsC/jmzEMVjtPXBB
         gHX+Xdkfw0E6jHzenQLnmmZkOTn8LG6zIg3qudIRXqOpWNqOQgUBOQJrAf9UIBrL5OLf
         LZeEWySKA3ix1BiFJxTB28jx3On+Wq0TN+eXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745441242; x=1746046042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qadNYoaJhFPVnikI7MqGvzeOQWIRrwJCqdY+2xJb3Ik=;
        b=XLcoy02uAj0vgzzwOB0+2xyt/LG/2HjYlz/TjySHC+LqIZNu1MCcN5/7Vcz9aCFYU3
         QWjuk4H9DChatPszitk0eA/ODfmSWDR/s4+LVYrd5+Ajovb+OrON/2YT1TsyvlTc+xjN
         HXPMez2Lg/ph6diqoLCDdCX9b6YLJPV1qIawqpunxOcsGHi9AhhmXXzenhNTjwa6Jiyn
         6g748Ka7yvQPzyIPKlufxDIw8Rm4Kue04j+lqksavBTKbrZj7ZhtS9n/RJy8+/Por+FF
         EueoTQpVETnN9snnSNvIjc7C+jGCIfZvrtGEZfSKUFOt2hpeHB1zj+uTkjC5rEbTfd43
         lW8w==
X-Gm-Message-State: AOJu0YzQIGVtZ4DaaDelTAQxePqfMpFJI5Rko+X19sKvi/8RRQ7Z2VEH
	POxaGkHaDpZ8Y4vA2KYMRiPCy2htI6RCmCqLlZO1cpp66S6A7vRiJvCcZlvsZtmGFL6r+J3wd3a
	/OYU66p3OUObpJKRDVVJISxptHUXvg+UwXuwXiGswN2jjAiKPvPJ1t2f30wG3TA6jWIKKiBUv+t
	VX8fwbEoaYPlUGEj/pDaLHf1yspRVtTzOtF+w=
X-Gm-Gg: ASbGncuaq/PhksVf6ky09o3mJrbfXKn+RXsWsi5aD5ayBUPRKaGhxoRGItQfzcRYHt+
	Hi9Ru3kLkoz+/qjp4orK8eydgqfA2goUQHRSTLoV2tg5VckfA3KKlT0v8xqe65nnE32AOAI4JaG
	qQW2dU8FQXbV5CrutDyKLBL2irSN22bzzdfG7Ryzzj9Nkr5GLQt8Rsn0IZ1O1+8GkBZ7W7HonaQ
	rwks/ODZwD2KPizDp+b7wyceV96JfCDUhBJ2T3dIisuynRJq1mbm1Lj8LafhW2cQKnHuup62pkS
	39f7AyCJEcIF3tUsbALdzvfut/FuynX171g2gnmuSeT/tBdBSV7JUkMFjyU=
X-Google-Smtp-Source: AGHT+IF5+OdbC6uuNEBaPHTOjQ76F8Y9VNe3wZx/cneGiXQy2TYO2E3fpZtgPx1i/wPR7pX74IsDUw==
X-Received: by 2002:a17:90b:2801:b0:2f1:2e10:8160 with SMTP id 98e67ed59e1d1-309edab1bd7mr1408a91.11.1745441241864;
        Wed, 23 Apr 2025 13:47:21 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309e0d09cacsm2120908a91.49.2025.04.23.13.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 13:47:21 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	donald.hunter@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Tejun Heo <tj@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tools/Makefile: Add ynl target
Date: Wed, 23 Apr 2025 20:46:44 +0000
Message-ID: <20250423204647.190784-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add targets to build, clean, and install ynl headers, libynl.a, and
python tooling.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 tools/Makefile | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 5e1254eb66de..c31cbbd12c45 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -41,6 +41,7 @@ help:
 	@echo '  mm                     - misc mm tools'
 	@echo '  wmi			- WMI interface examples'
 	@echo '  x86_energy_perf_policy - Intel energy policy tool'
+	@echo '  ynl			- ynl headers, library, and python tool'
 	@echo ''
 	@echo 'You can do:'
 	@echo ' $$ make -C tools/ <tool>_install'
@@ -118,11 +119,14 @@ freefall: FORCE
 kvm_stat: FORCE
 	$(call descend,kvm/$@)
 
+ynl: FORCE
+	$(call descend,net/ynl)
+
 all: acpi counter cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio mm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
-		debugging tracing thermal thermometer thermal-engine
+		debugging tracing thermal thermometer thermal-engine ynl
 
 acpi_install:
 	$(call descend,power/$(@:_install=),install)
@@ -157,13 +161,16 @@ freefall_install:
 kvm_stat_install:
 	$(call descend,kvm/$(@:_install=),install)
 
+ynl_install:
+	$(call descend,net/$(@:_install=),install)
+
 install: acpi_install counter_install cpupower_install gpio_install \
 		hv_install firewire_install iio_install \
 		perf_install selftests_install turbostat_install usb_install \
 		virtio_install mm_install bpf_install x86_energy_perf_policy_install \
 		tmon_install freefall_install objtool_install kvm_stat_install \
 		wmi_install debugging_install intel-speed-select_install \
-		tracing_install thermometer_install thermal-engine_install
+		tracing_install thermometer_install thermal-engine_install ynl_install
 
 acpi_clean:
 	$(call descend,power/acpi,clean)
@@ -214,12 +221,15 @@ freefall_clean:
 build_clean:
 	$(call descend,build,clean)
 
+ynl_clean:
+	$(call descend,net/$(@:_clean=),clean)
+
 clean: acpi_clean counter_clean cpupower_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
 		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean firmware_clean debugging_clean \
 		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean \
-		sched_ext_clean
+		sched_ext_clean ynl_clean
 
 .PHONY: FORCE

base-commit: 45bd443bfd8697a7da308c16c3e75e2bb353b3d1
-- 
2.43.0



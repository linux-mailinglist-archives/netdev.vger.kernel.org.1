Return-Path: <netdev+bounces-89302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AC48A9FA5
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECFA1F22FCC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2705316F8F9;
	Thu, 18 Apr 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GHK945kr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F48249ED
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456539; cv=none; b=FSEd3gLclns8xDcS2lUqJPY4sdEjvGqKTGRzXgUXhyxM7llXd2AliP5CnsEJ4i0LmgZKFBn3RObOyTU/+rtHAQlVuznXS9oE6QRpBleDu2WGPVvsw7hg1EJF87WtDpqdJDdRQ3cEcm9pMplB61vQSg5xMZXNJG26E/1NrXjEACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456539; c=relaxed/simple;
	bh=b0IPPzC2gZPsxNRT1JsNB/IxxUT5lL5pQHIYy4fkYB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsiEOyXsQXjtXApGpmrJBV3ikZEknQ1Dq7FP51N42eYRWWPZnF5wPUP+9wFBi2A/p9NiXhdusK0cQwG79Brg9AIOAt8LpnTS9NaPkyhZwek8TPl2veLCoiXckW4D9eWdDcrv13D+aOsVMT5+2dEQFm09iOTVc8jwRyH78D8nFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GHK945kr; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso424908e87.3
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713456536; x=1714061336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iDht4R3VqRW+yPNRz+ghqd2WBxn7y+zWhn1SiVJ1ZI=;
        b=GHK945krI2vEQIhTBmqvLPLg+kzAUCJKnQSxcqN5jlsdY7AQdPNsX8woDKt/X4rnnJ
         s6W0RO2y+PFMx6CWcLU8jW5oAp8rKbDq6W/3nXlbdOb+zacyNre/qyXt8xCUfLUQYCrl
         kvbnWL7tWH3PC42VP3DSloc3vAuwMm8PgdTLgDnmqc51xffvwQrq2CmbXufeppRoah3y
         qyQyQnXX0Fw8F14xFaonToawD38UlNf4EEfwLpgbVCPdv8JkaTsaerV2idnNxxnpc4bE
         eUCI5HP0Wa86nTPtHgq/FQj/Xqgf9xCuo7iceM7yhFemyyfUT7k++HdCACKuhEEmdpFd
         xyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713456536; x=1714061336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iDht4R3VqRW+yPNRz+ghqd2WBxn7y+zWhn1SiVJ1ZI=;
        b=v7wws785loy9l/i3kxIc7r/2Afagzl26OWRayztR+foue1G5THCNOa/WJH/k8B1GIv
         TeHkmqIwMJm9mYoH6dXOoi9qcRvZpMLrzAGo58aiQbK9n0DxNQNvsp4lxKcXwL+fpkRf
         QXGC72yY50GzI9GtZVUdyrAkv7TYUJ1io3AwbHV/JfOgKagUseMFEvHNC5eQNFb4ldrN
         vM5JUmTzG6SHaAgTp1H3T2jadccMlvBnJ6jbLUG5OT330MFNa30yMwZv4L8eqF9FEMpc
         SqVqQoEbQ8u5W7QP/LXHIxMFX3Rhh3yT2/ZXc+nRqLXkbcphkvxewGr9rFCL4Hw/+QAo
         MHVA==
X-Gm-Message-State: AOJu0YwbKLXpyFK7e8emlzb4ynrluGWvz50YcJNVotK93B/WUv4efWcv
	h4cxT3PxWM7xy08WRqi2cZg+3IXwv9X/+4m1LUGt3+s4j0ywD8bX8IAPgfL/COd5SZVodTqhSoG
	5jbU=
X-Google-Smtp-Source: AGHT+IHN1LuBKkkhmIVKUWQfuW1mI3eS+gdV3HtAN4KpyOxEft8HB8VKerh5b0bPC/3GBlEH8c1Y+A==
X-Received: by 2002:a19:7707:0:b0:518:d079:ffd9 with SMTP id s7-20020a197707000000b00518d079ffd9mr1878748lfc.13.1713456535870;
        Thu, 18 Apr 2024 09:08:55 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id l20-20020a170906795400b00a466af74ef2sm1077572ejo.2.2024.04.18.09.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:08:55 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	parav@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	vladimir.oltean@nxp.com,
	bpoirier@nvidia.com,
	idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: [patch net-next v4 5/6] selftests: forwarding: add wait_for_dev() helper
Date: Thu, 18 Apr 2024 18:08:29 +0200
Message-ID: <20240418160830.3751846-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418160830.3751846-1-jiri@resnulli.us>
References: <20240418160830.3751846-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

The existing setup_wait*() helper family check the status of the
interface to be up. Introduce wait_for_dev() to wait for the netdevice
to appear, for example after test script does manual device bind.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v3->v4:
- removed "up" from ip link command line
v1->v2:
- reworked wait_for_dev() helper to use slowwait() helper
---
 tools/testing/selftests/net/forwarding/lib.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 17f8b6b9ab9f..e81507686870 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -738,6 +738,19 @@ setup_wait()
 	sleep $WAIT_TIME
 }
 
+wait_for_dev()
+{
+        local dev=$1; shift
+        local timeout=${1:-$WAIT_TIMEOUT}; shift
+
+        slowwait $timeout ip link show dev $dev &> /dev/null
+        if (( $? )); then
+                check_err 1
+                log_test wait_for_dev "Interface $dev did not appear."
+                exit $EXIT_STATUS
+        fi
+}
+
 cmd_jq()
 {
 	local cmd=$1
-- 
2.44.0



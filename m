Return-Path: <netdev+bounces-87435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0808A3202
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00001F215B6
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA00148852;
	Fri, 12 Apr 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MU0r2yvm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D767514A4EE
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934810; cv=none; b=U6GjRSoYmIn5Z0jSdF/qNmqypi+cnOQpWaf84iFIVOygoZpilBH6LHd0G71H5NzlivOYkw2VoZWRZkKRjjp92Y/3vCMBGHw9bYLbuxuI8v4cckLdrorOPIu6X9Ho835Bv2deQ4tiSD54e563VnGmVbBEhjYOm62XPhUDycpfXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934810; c=relaxed/simple;
	bh=79Zpumn/yTRAxDTkzsf7dlFSKMtuRYIWNxG+eUi60Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvbajNTFfrTASsFXXsDeGpwIGe226bfJgQMqqvSLMRbuq2VlYRH9JIF2eS7daRQJeNLlELjIYzW3j+hP6yWA0JwBZiFrEN3EJUHCQXirCq7rr3Wna9vTYho1njdCUlyV+1gXmMlkz50uNmfMz/0KdCMdrPQNJoIezgw2UtDfiKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MU0r2yvm; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso11865541fa.1
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712934807; x=1713539607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSc1knfmuuKWVaRerlL6rWyI43/6CD3p6tfuDkKbsf0=;
        b=MU0r2yvmnbAeNNUm9dMW0CKdRI5C8QS9AjuOGF5pV28miwiXKSc6bHBwUFptbakvno
         q+sM7RRB4NZxOfUDOyuK/TbStg1ZjIa6Vg+UvIkzzySK02JXDbfkBJnH0OjoloeI7N77
         fNrJB0NyRqcaj8UltT2rImcaNYN9FAMgOnj1a3d4ruv/GyUQWObvUpaCAEAqqVvRmS5B
         HRlTYr9vKm3fKXufkcFf/sxAtYkiyYWAObA1PBf5rPzSOMO1V+JVdLq347CmuZ5P23hs
         abyVsCDCRI+mxKh1WK6e0gzB7tAGFAPD1LfNo4Y82fYB9ivVThKP6vcgrw7ea6yVJn6v
         P3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934807; x=1713539607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSc1knfmuuKWVaRerlL6rWyI43/6CD3p6tfuDkKbsf0=;
        b=sfrO50bONnkZx+wYUaaDnuCm4UDTrRPWi/2LPDPRwT01RqAr8myy1Zsp2qcNL4frmp
         eBj0NMpNzFNVAvDi6zOj7Z1foqqh0xMCFnssKG2xDFwJyuPEyW7g5vIvjj/Z9fU4Ho+j
         RuzaZZVHx5umOeLfBgwtbD+Q/K76PBYu5kARxeoEllduWMZb4oVfXEDHKeCLk/7Q/Q4i
         i2O+8N+Ovy6y3gkWoacIW1/avV24sHH6xvhj/7gHG+BcYT8EAzYIl3VXQa4BxTrccer/
         5P8SCZH1JiKwPxF/wKAHKYC77y63WG/MxxwCAZT3HcC2CdF5M0cAOFKiNiDjY302cCBM
         S5Nw==
X-Gm-Message-State: AOJu0Yx/mo5PtDdoJF//1AZuim2sWzs/oJoNQUuJBQ8vKEmdB/qE8hsm
	sqa0AHdpCf+L2QqkIrgRPv9yTd1nohaXornbfK9NH5q/Xh3qs4sYJM4z2uXasmf52RLx5t6Zmrn
	r
X-Google-Smtp-Source: AGHT+IG6s9o/5tFXaogDJI5ZYHJzmyIXl+4HeYCIRLyWTTBODB8qVVhF87Iesf1NL4Tbyh0b4rfvPA==
X-Received: by 2002:a05:651c:620:b0:2d9:f68a:d82c with SMTP id k32-20020a05651c062000b002d9f68ad82cmr1699020lje.41.1712934806885;
        Fri, 12 Apr 2024 08:13:26 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u15-20020a05651c140f00b002d834cb0400sm546450lje.17.2024.04.12.08.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:13:26 -0700 (PDT)
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
Subject: [patch net-next 3/6] selftests: forwarding: add ability to assemble NETIFS array by driver name
Date: Fri, 12 Apr 2024 17:13:11 +0200
Message-ID: <20240412151314.3365034-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412151314.3365034-1-jiri@resnulli.us>
References: <20240412151314.3365034-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Allow driver tests to work without specifying the netdevice names.
Introduce a possibility to search for available netdevices according to
set driver name. Allow test to specify the name by setting
NETIF_FIND_DRIVER variable.

Note that user overrides this either by passing netdevice names on the
command line or by declaring NETIFS array in custom forwarding.config
configuration file.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 6f6a0f13465f..06633518b3aa 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -55,6 +55,9 @@ declare -A NETIFS=(
 : "${NETIF_CREATE:=yes}"
 : "${NETIF_TYPE:=veth}"
 
+# Whether to find netdevice according to the specified driver.
+: "${NETIF_FIND_DRIVER:=}"
+
 # Constants for ping tests:
 # How many packets should be sent.
 : "${PING_COUNT:=10}"
@@ -94,6 +97,42 @@ if [[ ! -v NUM_NETIFS ]]; then
 	exit $ksft_skip
 fi
 
+##############################################################################
+# Find netifs by test-specified driver name
+
+driver_name_get()
+{
+	local dev=$1; shift
+	local driver_path="/sys/class/net/$dev/device/driver"
+
+	if [ ! -L $driver_path ]; then
+		echo ""
+	else
+		basename `realpath $driver_path`
+	fi
+}
+
+find_netif()
+{
+	local ifnames=`ip -j -p link show | jq -e -r ".[].ifname"`
+	local count=0
+
+	for ifname in $ifnames
+	do
+		local driver_name=`driver_name_get $ifname`
+		if [[ ! -z $driver_name && $driver_name == $NETIF_FIND_DRIVER ]]; then
+			count=$((count + 1))
+			NETIFS[p$count]="$ifname"
+		fi
+	done
+}
+
+if [[ ! -z $NETIF_FIND_DRIVER ]]; then
+	unset NETIFS
+	declare -A NETIFS
+	find_netif
+fi
+
 net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 if [[ -f $net_forwarding_dir/forwarding.config ]]; then
-- 
2.44.0



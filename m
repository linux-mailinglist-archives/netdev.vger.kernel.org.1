Return-Path: <netdev+bounces-89300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 348938A9FA2
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4E1283171
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC4F16F8EF;
	Thu, 18 Apr 2024 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NF8R86L0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE4416F8EB
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456530; cv=none; b=IBbzt6tM7tmPWIrVnrlms0o/L2XNL8jbKBck/cL8acFOK0mYkAOpPeTz1lTbOlFcqhK7YXPW6a1Qvp3CqrD2QBC7ka7+opT2+XhcZ7Bpm3eQQhabkgcKfIT6J06p1FelO7XUPDBPsCqw2lB7im1bwkbKw/zhxUJHnc5nJzjFVX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456530; c=relaxed/simple;
	bh=ODc2bT3Tgy1hAl/eXH6/NifpgPwvNvOsQzDYDnBF6ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnAFguqbJrgcYejmK61dCL0wFzHAHCwNEjT1Oglib4xIFSI+rtt/93e/hpuShoqS8vDoJJKTzt1GNa2+SPtv6wLBhnu76FQRFX95TVrzy2gjhsUAIYTsGiPQc5R+QxbbCig3+Zq3HDrMtaISmFGx9jaag9p9fv1eSNHB2F/9dpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=NF8R86L0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a51ddc783e3so119595566b.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713456527; x=1714061327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3kdsnr+4DRfl3oY8QVhe9j08BHEG8XpCARPL+ULDq0=;
        b=NF8R86L0gtkp3UMqNP/NaT5Q99GVCXsnmdZMjEKsdPEHDGD8T6rqm9tvX2i7caZoOv
         eP5qjJRRhJ0vqQomjLixBUChg1rVvJnlFuP2JjFNidgaMDALVF5TN3ZRccsgovMF31YH
         N4CjLaahm31r9szlkynIyNKYL4jpBp1q9/vVyQ/SMFQ8NlWffY3HmKq/sclhvT6wd/Ec
         os4ciolrRtO3GkenaqNnGIuQwGViZ18L5cSlcjf5ZAEJbsEigrMmNmmIcG0BZtgQ3nT+
         dD1ME/1LO1B4gd6BCdSymG9wmSnFWvmU3N4T//FlFaWVg+v+Dm1Og2xLvrj7OzgwvADy
         Lx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713456527; x=1714061327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3kdsnr+4DRfl3oY8QVhe9j08BHEG8XpCARPL+ULDq0=;
        b=HpDp85lwNjb4SMC551jlCoP12fSh3gYxgxMh6KiQf8je+HaPCj0QDn/k1wMrwbrLIH
         tgsUeaEz4KOmDdKf0GSLsYu67dNyhnFPGLFVfrRLlZ+TkIgzA1P7UXL/b7+/+h6My2EV
         nGvEkiyeHSNT6Uhu5f3W2KjtwFYRiUHvsx/M1sSt4oPA0l0U+OUPUp+cfa6uIOUQ/Fz0
         CdMQCqHzd8IQCCOv6qaZ8OC9uBGf+12ns4GojdDPiHHF19qnQBKYDE9x0FQirECVuRfG
         1T//Gzx1uuriCTUGCtAByq3zSB6zzs48hIg/1JRj9mDfLJnkot9QzCJV6UmO4xypJfN0
         JzfA==
X-Gm-Message-State: AOJu0Yy0WBkJAgSiuYYib0RPuUI1GY274tFg20WSFV+ukHBJuBP0oUay
	L/KiFmrtQTRllpFpYJHSE1B3LVzkt7MisuI/tik/OMWdaqag8bXzcrBmxXWeQy0qn/udtAG0ufh
	DKtA=
X-Google-Smtp-Source: AGHT+IECj0h1cFA9hl40JSPqLgCZoPju1GzoIrhuIDwBt2vpPWd0Qkgb6sqDhRdsWNEcVAVC2+4bzQ==
X-Received: by 2002:a17:906:470c:b0:a52:5a74:13f4 with SMTP id y12-20020a170906470c00b00a525a7413f4mr2185075ejq.12.1713456527053;
        Thu, 18 Apr 2024 09:08:47 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t21-20020a17090616d500b00a51a5c8ea6fsm1081695ejd.193.2024.04.18.09.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:08:46 -0700 (PDT)
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
Subject: [patch net-next v4 3/6] selftests: forwarding: add ability to assemble NETIFS array by driver name
Date: Thu, 18 Apr 2024 18:08:27 +0200
Message-ID: <20240418160830.3751846-4-jiri@resnulli.us>
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

Allow driver tests to work without specifying the netdevice names.
Introduce a possibility to search for available netdevices according to
set driver name. Allow test to specify the name by setting
NETIF_FIND_DRIVER variable.

Note that user overrides this either by passing netdevice names on the
command line or by declaring NETIFS array in custom forwarding.config
configuration file.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v3->v4:
- rebased on top of changes in patch #2
- reworded NETIF_FIND_DRIVER comment to explicitly refer to "importer"
- simplified driver_name_get() avoiding else branch
- s/find_netif/netif_find_driver/
v1->v2:
- removed unnecessary "-p" and "-e" options
- removed unnecessary "! -z" from the check
- moved NETIF_FIND_DRIVER declaration from the config options
---
 tools/testing/selftests/net/forwarding/lib.sh | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index b63a5866ce97..d49b97edb886 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -89,6 +89,43 @@ if [[ "$(id -u)" -ne 0 ]]; then
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
+	if [[ -L $driver_path ]]; then
+		basename `realpath $driver_path`
+	fi
+}
+
+netif_find_driver()
+{
+	local ifnames=`ip -j link show | jq -r ".[].ifname"`
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
+# Whether to find netdevice according to the driver speficied by the importer
+: "${NETIF_FIND_DRIVER:=}"
+
+if [[ $NETIF_FIND_DRIVER ]]; then
+	unset NETIFS
+	declare -A NETIFS
+	netif_find_driver
+fi
+
 net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 if [[ -f $net_forwarding_dir/forwarding.config ]]; then
-- 
2.44.0



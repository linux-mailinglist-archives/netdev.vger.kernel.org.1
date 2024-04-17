Return-Path: <netdev+bounces-88806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11D28A894A
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336E3B2561C
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509E917165E;
	Wed, 17 Apr 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="SoRJQLjY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA1B171066
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372365; cv=none; b=a/AGdWg36th6Y+bSIPrseWBpVCuVVpV2d5IR2kAHj1Zxykkx37JPlafYpGt0+lZtYXFieuRxJWSS983M0uJ2g4UkQO95z4e/6esSro+EIItS5d2pmLee0s5PxGfrdp6SCDvR215z7LakaiqY2hDPI9bSJkWNpV8Io0jWL86fxcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372365; c=relaxed/simple;
	bh=ywpHm7bmooFCjvprfvVd/Cbc8wvTaPUxL+QMQivo5Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ly4kEs82Vk7KxM40QZa2D4m2M6Lt444LAk+IreZarYlzr+MGOvMaQ8+6G3hgeTTYFOrPYDbZCcu2N8Wpv7iCrFDY0H1hQUcqBcpiZCpogF7/DLGP20Zy2sOM4EJcmg87KHJsikocMeWn45sNr3tcCbPmgvdiZhyR9M+S40WMpgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=SoRJQLjY; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e477db7fbso9655398a12.3
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713372361; x=1713977161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwpy2d8VdZTGzMFmGo4R2LG9kH0oGH0sJNWRTRWY9s0=;
        b=SoRJQLjYMnLOwnD4iGCQyDRUrUv5zpGsh0Kv/DhIsjbQHJ4+dOFqmpOhSnsUCZffem
         X2zq0jddW9OyOEwcQ6bdtVvTgKBZmqxMJm0pH2hV6OzTeeFhlmP/PlZ8G8VfWcwfEKCw
         Ydx9a8XXOl9ryjteP0HCFgtuBHjohd8Sy9qYtY/VmpPKn/bRQvyOU6Y5ETseWVALX6rf
         c0mNbjmWGdx/36z25OXYQhjJ4yB7PGYealfEFuIptsDQJt9jg316N4GGHBc59WqUpFSV
         GJ7g2R3gPThK5pH4V2dWjB8RbUQ4og/FwFY8QRVZD1XTOhjEHiSnyUmbqj5CWU+c/1HL
         XnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372361; x=1713977161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwpy2d8VdZTGzMFmGo4R2LG9kH0oGH0sJNWRTRWY9s0=;
        b=iAbqui2ksHX8U0VsLj6s28cx6prdgOvDXBYPIwWuNK+BFZt67K6zLRWqKruO8byhFq
         wG9nDyz8DOYKQ7S8kj1kzxAAUkLSHpzjLK9/t6HgyRkR8VY2MZnPPxJcqBZxJhAWeMLb
         gkwSXp2Rz4YctcQmzsF5RzKX/a5TJM2K2FonDzIFrtEIdXslXUgTsOx9QrkxhG+l1JHx
         QNyNvemnwqMJCo3J5uZldgoglZvQI6fVEOoroWnSmUoCCxypOeBR5/ldFpzRXiQM83rK
         0s7G4SdLDZxAIlzqNKto5A3Xow1/qqv4QFUhadONql459e3dvNgE8aEbFDyLd76wRy6v
         tQmw==
X-Gm-Message-State: AOJu0YzJyTmN+Mi6fWN36hKlQYGinpAJ2Qp1RbvHG2lcj67zrLxp7lOG
	eKfrMfcsaEREM6lCkqQQA5djscb3KfpgapZm3JwtXZOsR/ZjkE5Xz8P0ABqNnEqgDGfgr0fsJFF
	k
X-Google-Smtp-Source: AGHT+IG3Me+F0oYiJTCQwHguq194JAhZMF1Uoe5DU2QB6YsaeleSbRyFK+AQwlYwjcC3c8OqOgA3VQ==
X-Received: by 2002:a50:d655:0:b0:56e:64a:2a47 with SMTP id c21-20020a50d655000000b0056e064a2a47mr90004edj.42.1713372361527;
        Wed, 17 Apr 2024 09:46:01 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id b73-20020a509f4f000000b005705e7ee65esm876158edf.56.2024.04.17.09.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:46:01 -0700 (PDT)
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
Subject: [patch net-next v3 3/6] selftests: forwarding: add ability to assemble NETIFS array by driver name
Date: Wed, 17 Apr 2024 18:45:51 +0200
Message-ID: <20240417164554.3651321-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417164554.3651321-1-jiri@resnulli.us>
References: <20240417164554.3651321-1-jiri@resnulli.us>
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
v1->v2:
- removed unnecessary "-p" and "-e" options
- removed unnecessary "! -z" from the check
- moved NETIF_FIND_DRIVER declaration from the config options
---
 tools/testing/selftests/net/forwarding/lib.sh | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 2e7695b94b6b..b3fd0f052d71 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -94,6 +94,45 @@ if [[ ! -v NUM_NETIFS ]]; then
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
+# Whether to find netdevice according to the specified driver.
+: "${NETIF_FIND_DRIVER:=}"
+
+if [[ $NETIF_FIND_DRIVER ]]; then
+	unset NETIFS
+	declare -A NETIFS
+	find_netif
+fi
+
 net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 if [[ -f $net_forwarding_dir/forwarding.config ]]; then
-- 
2.44.0



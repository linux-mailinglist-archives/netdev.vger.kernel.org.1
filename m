Return-Path: <netdev+bounces-88054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F0B8A57AD
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E268F282798
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057B58062E;
	Mon, 15 Apr 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pmOVHKYZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07FA8062B
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198349; cv=none; b=pjlrLDvUkeStjzICa9Qhj1QPtxvpdJRq3HYzbUJ/yf9YF33xq21L5hTsBhMoxcDd64PHUsgpbaQKRuuQy5DKDXkY5ZK93RFtAaKg6FIPBAeX5waHen/hVnCrlRzfzx3ANH62ZQsENV9gjJxGstLXQkgsMM84am9O8hGqyOrSe08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198349; c=relaxed/simple;
	bh=wxFoEQXGXgP9lAoXIJl4FH/A6/EA6g2XPjytbEI7kbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jom7541hdht0UByadwKPF03fDvUp+T/KJwU6b8R5p/B+i0nH1RN8pnkkoRCpYSY4rfVLpzZJ/lt+mzK3r3kVpqgPl72lrKoMbWBLWrIuwTlt+cqd0AdNWgGnGbeP981vE/uykNAPcnac5Cx5DpI6lrWuJ4kIJAOvcadomFtYhgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pmOVHKYZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57013379e17so1931922a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713198345; x=1713803145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOjc7RskPi7a/HeDwvwVOXTy5sL+YjkDPnBm1m5pAYk=;
        b=pmOVHKYZj+5gozRpHQbw+8EDgsGkpN125mLhRi+kC9ZhhVSY3pDJazzdxE48aMjqpw
         oX65KPWy6We9Uk5gTgyzKVD8HKshqB5U6LDKeXCd/H/Exbx5ZAGWEaAQzPmHsPW1YXBI
         wJJ1Qp0W/zas3w07L3kBKCmU6/4libm4H/bAYPnHuKepcRGDp1f78eO90zc3RbmbtcC6
         KMPlfeNj2KzkqzyBxu6KAABPvpTxvtS2/rYH83NzaW1y3bWlsNd34iHn88H+3vKH/q5L
         Tt7Dse50WQ4Y28PIFv6BkZQPTMC2zRefzGQtpBKVg0jlrC2qb6PCenkp4nv9xOJ71xRV
         2sxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198345; x=1713803145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOjc7RskPi7a/HeDwvwVOXTy5sL+YjkDPnBm1m5pAYk=;
        b=ik79azOsZi+R9QwHg9DOiPFvLUuek6pM3bOm0l4L9xZP+BjZrC/iCfDMImWaHDmqx5
         33+1bzN4aPsvKyX5vj/q+X1Upc1KW/EDksEMv3dDqa7gWcH1yVhenRx4BxrJTxl8r8Mo
         n1rYuGBBLyJIMxJqZHAfR46q/q1Jj5v5ZfuYp3mvtJoT3HrMQLirO53mg++tdJRVxbEO
         q8+oDD8m2NbOt+F1dsuHYbJR2xsB8aFH+q6Lq8xUvSL2KLdbxgh1i1zxDKoVhUWzNGdz
         2B+aK0A9EYYushk2gDkMda+hNINKIBy0WPIyoRdOf3FIrxBx/7XopWuNDkGohRHrejI4
         FlYA==
X-Gm-Message-State: AOJu0YwRN99cFbcDkM+ifcBh3aj0f6cTJ+z/O5IjXjiyjuzrPHyhsMT4
	7QaXM/jetiV/m/UwpZ9gQYKo+J+cbcnNPOAqg0Dw8Y/HTFE/3Vo2MY+2+K3r7JmNsDZLswvSogJ
	A
X-Google-Smtp-Source: AGHT+IGsktiI0fRNTkM866z5w/QeMx2+qxChxXe2b1H+SAiQI3oyutgFmZXAflo3H33P1t2i05fsmA==
X-Received: by 2002:a50:9543:0:b0:56e:2b1c:d013 with SMTP id v3-20020a509543000000b0056e2b1cd013mr7749568eda.21.1713198345074;
        Mon, 15 Apr 2024 09:25:45 -0700 (PDT)
Received: from localhost (37-48-2-146.nat.epc.tmcz.cz. [37.48.2.146])
        by smtp.gmail.com with ESMTPSA id i8-20020a05640200c800b00562d908daf4sm5016938edu.84.2024.04.15.09.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:25:44 -0700 (PDT)
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
Subject: [patch net-next v2 3/6] selftests: forwarding: add ability to assemble NETIFS array by driver name
Date: Mon, 15 Apr 2024 18:25:27 +0200
Message-ID: <20240415162530.3594670-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415162530.3594670-1-jiri@resnulli.us>
References: <20240415162530.3594670-1-jiri@resnulli.us>
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
index 6f6a0f13465f..cc94de89bda3 100644
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



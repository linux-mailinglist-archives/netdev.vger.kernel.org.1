Return-Path: <netdev+bounces-90854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFC68B0787
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 12:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B735A1F24050
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 10:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA2E15958A;
	Wed, 24 Apr 2024 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1AHEfYIw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A7159579
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955269; cv=none; b=og27BCVPoCTr/WjpX+Ha4B/JOWXkyxJ0FmRyvNUHQ2jUV2owKxJZOvVpQCFnxYWFoMh+K9EU1eYbl2Bn4s+bSNR+076Jvy5jKEOPit3b9er9F7YdStM0h4R4qdhFDnZaoaUcRCv6WsmAQdukOdlk+2b60cunHg8M8WQ/Lbz8Kb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955269; c=relaxed/simple;
	bh=KaPtkaLJNQOUy4iNERAIFKq6ktm9TFozVxBCBQD6Z0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PENzA5loVUTwYDvYsMJqO35wHahtE+DKQH6aPU2SYlWD01y+3B8HK4+e4oOz3e5xOZDvfUUTFWRlLhkb6UcGSixxbTYuYs6K3fcE1QRDI0gay4SgqVud1rYt2oH021zHZMKLKgjrFBAO+ZqxxlJ4mOgTkML1PqnogjhG9z0BGxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=1AHEfYIw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57230faeb81so300443a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713955267; x=1714560067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQl5qEwVKE01f/9GRHQkz4a3z973Yhrxj9l6Q9lKgg8=;
        b=1AHEfYIwVQbiAbISrBKIbyLZNQ664MmjYKQBEoX1LUr9n8a1c+SgovDAX/46QbA2+7
         6w2OrYwXNPeDAPBAfjXhkvRW1ShBpWC900s3qTxwGdGQTM/uVQzXIw638L1Z0Mqa/2qR
         1hNyMwNlWWJerniURhooOeJ/LngPfTNVWfli2vEI9U7P/Ur3xo1Hui6yZwlRgczKspUL
         OaMgG19+KlYyex7lzHihpkmEhDWOuVzbtHifspO1RMUDq8NI7pjNkjjsgSJSN2RqWK5O
         /KyBdwxGoPEngXopgrvgP7JZoRLsOsCi3UX/u+Hime13pLGTwTqaIY7uyD37wkD1/Syu
         J1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713955267; x=1714560067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQl5qEwVKE01f/9GRHQkz4a3z973Yhrxj9l6Q9lKgg8=;
        b=G9/NSlcYhr+amglpR/vvGVSvBkh7nbR+fObUWQuJfpM2JaKUMg8agk6Kusd3T/3F3x
         zBeyA62EKso1gI3TG4SqojHHomSAGzKBqg/Vv4rXp6MF6GnicTZLqWmRBntfenqwhW52
         fowqeNzlwGeh8hfh0mn5Kjs8wTZ5lg/nKzkFODeES0L05cldt3S21kpY2CBhmZSZ2X+y
         L80y8tIRjfKAC0SKHE+Fk//cV2atJsTB0aizsSyAQEM5Pt6hn7qPL2pJ8085JyLcwrMt
         0ehgGQAPGgVLM53sMkfqL1t9+oJJl+ZPtIqC/dswmwNXQ9N2/v9T5hk6QbQtqXiZiOl7
         DZPQ==
X-Gm-Message-State: AOJu0YwvJ2pzpbpfpBiCZ4uM4xbQjUV7zM+iVclO5jwXzxLww0BBPWwX
	7eT21KmU52AYB34+/G5U9EpemheUFsCIaPVILUA49c9Y912fyQoy07AW4s1kDcE05rGXnYlKD4a
	WRf0=
X-Google-Smtp-Source: AGHT+IEcmmnN/LjVFLpWsyWulmkkwyLqo6DLvHVQYSvdmQmglzk6LQD8NgEQmHuc0kODNIK/8lCHYw==
X-Received: by 2002:a50:8716:0:b0:568:c6a2:f411 with SMTP id i22-20020a508716000000b00568c6a2f411mr1528361edb.32.1713955266379;
        Wed, 24 Apr 2024 03:41:06 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm7686627eds.45.2024.04.24.03.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 03:41:05 -0700 (PDT)
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
Subject: [patch net-next v6 2/5] selftests: forwarding: add ability to assemble NETIFS array by driver name
Date: Wed, 24 Apr 2024 12:40:46 +0200
Message-ID: <20240424104049.3935572-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424104049.3935572-1-jiri@resnulli.us>
References: <20240424104049.3935572-1-jiri@resnulli.us>
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
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
v4->v5:
- rebased on top of previous patch removal
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
index 7913c6ee418d..9d6802c6c023 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -84,6 +84,43 @@ declare -A NETIFS=(
 # e.g. a low-power board.
 : "${KSFT_MACHINE_SLOW:=no}"
 
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



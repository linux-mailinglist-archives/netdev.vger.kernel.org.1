Return-Path: <netdev+bounces-90200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2238AD0EB
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2481C2217A
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DAE15351E;
	Mon, 22 Apr 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AJDFeMwx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438C2153515
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799992; cv=none; b=Z9MegM9C+OgMfsOKXk+745R519eP8mHl7Enz/lKdrRmlFDXwCERrEMiOckgvqbnJB9B5Yb0e/GGqJDE7VUgIDPhAaVZ/mdopTLYTrlwYcWi8rGixfuliK3QfHdPkvH5AQTVeh30VTlaxgphiQf41JCwZpSikf1JOHneSNzCawuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799992; c=relaxed/simple;
	bh=KaPtkaLJNQOUy4iNERAIFKq6ktm9TFozVxBCBQD6Z0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGxo5r+Jkhl9Isg1rhROVTLcPibOuGv2TTiP2majM0Ff6RvNYm1YDV0a2YeJwgzamo+54hfitBftz9vIbapkfNqkwWW5u/MO/DcCPQiMZra8WWv44clOj4XCaRM0rRi3Mq+JZ9fh/6PTB371nDPls6gmZKSZWt31U4q2M69+2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=AJDFeMwx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso68956301fa.0
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 08:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713799987; x=1714404787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQl5qEwVKE01f/9GRHQkz4a3z973Yhrxj9l6Q9lKgg8=;
        b=AJDFeMwxGkoqumIgAxJAYdWpCiKRDPIPL6eF2mNyoCXcOnkSVcPaAKq0B9dUeRdZJ3
         eflO9Rx7dw6vKEOGuYXtCm2sygLGY8Q+aUoBzARaFwWcJKO6u1VASE+tZ05VvCz2N+Bp
         1FXS0NAsNrCEWiWU+rSR1zOfQqKTgttPc1/n3RR2XbbB2age+tZsCugOFNmPs7F40AQH
         CceGIkb3uKJYWhCaMEAz5kiBnelQMRtuf5zBvIybsQIOlKsO65FXsg1IJ8au/eRfR12L
         OmeKRmUiy0i3RVAlejJaO+vaouTBpYjWP57f3JYTpkfz+UplkDmduG1gpbiXz/duDUA2
         gIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713799987; x=1714404787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQl5qEwVKE01f/9GRHQkz4a3z973Yhrxj9l6Q9lKgg8=;
        b=kNeB4oJuKU/UCs6UjKQk8YMtPkF0TRzsoLmrc4biFtP5wuh6GF5PYutm4iUlq+tu3I
         jIba8K/gUCO5GHN6VM/ulC2KAyOa15cNBJJkzPq/Po02laOjvORHZGJldlrkY+1Azolq
         h7rQlHimTvpUKOQOAG4po/nv9LbKHXa190QL0CCr2srL4p/7fKqFH2ieubGqIRknSICK
         2+tqbejzGuTfz12naXiLqOnqN1SjTvGiecWXG11dJKZ4m03pRVPflGWMhH6pra9c5fRN
         FTmlZvS2FMc7YtojygrZPurahm32rygcsSDPomyjeM387QFG8ldNxBQivHXm+QjPzq1c
         Q7lA==
X-Gm-Message-State: AOJu0Yy33ipluYBxNbsZNOdqOxmeXEIs5h/NUuhd/lm2NL1TXbgkFAAH
	HgtiKp6hI4QtH31yQElu2fJaXZe0pIM8mtukFy1PbcsrZgSyT2msQl76D7e3nk+jh8Sj+Lu4rAQ
	f
X-Google-Smtp-Source: AGHT+IGlcxXfKgORGsiWYGG7is1cgixCK8Z1Y5WaBaCSGJYErcWa1XDZsrmGBwn5EZpXUNHomnJ1Hw==
X-Received: by 2002:a2e:b607:0:b0:2dc:d2c5:ee9 with SMTP id r7-20020a2eb607000000b002dcd2c50ee9mr5633241ljn.2.1713799987076;
        Mon, 22 Apr 2024 08:33:07 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id p19-20020a05640210d300b00572033ec969sm1836276edu.60.2024.04.22.08.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:33:06 -0700 (PDT)
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
Subject: [patch net-next v5 2/5] selftests: forwarding: add ability to assemble NETIFS array by driver name
Date: Mon, 22 Apr 2024 17:32:57 +0200
Message-ID: <20240422153303.3860947-2-jiri@resnulli.us>
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



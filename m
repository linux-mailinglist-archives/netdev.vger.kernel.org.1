Return-Path: <netdev+bounces-90447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4701C8AE277
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73AB8B231AF
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF2875802;
	Tue, 23 Apr 2024 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Kp1AzMvu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1477F13
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868882; cv=none; b=U/irb8MBMYCu5K29mlIvdWKmt08tAdGdulu9OXY0YbN12bxlixRi4So12mtQRt8e5h8n7BNGNb2merYHySm7TnxZ4bRzoDyPnVoIjycs5ai02qocMy48bZar0G7sk8gatqtck0R2jkpaw01+8oNOH96z0CxZjWAJob/E5Ok9AYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868882; c=relaxed/simple;
	bh=KaPtkaLJNQOUy4iNERAIFKq6ktm9TFozVxBCBQD6Z0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYAQhusrLt1xwpqp3lEcVzCYyfcveKL4pJY7dEl59/6pONyScGpHIXrcJeLomqs5L14HyW3eUWn+hSxo/N2DAX2HkiCc3FjDIaRb6zaucDTh+4e4jnXy+ytZyxegbh2MSSGGkNZYXD+rBYB5yQVTaAO17eDMF80TwUEENJXLJwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Kp1AzMvu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-571e3f40e31so2811949a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713868879; x=1714473679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQl5qEwVKE01f/9GRHQkz4a3z973Yhrxj9l6Q9lKgg8=;
        b=Kp1AzMvuqhhY07uIXIOVE5GcEQHbQOz9BNLrkzuoHiiZsw9+a57xBjPdCtxuSn1PXZ
         pgpPi6/Vb0BpVZgKYSs2WP+E/O3C4NKvxSMGTRj7KyWSmCYkVCINGTXHjiHBsTnkaYd8
         phJJKOQrfbGpKSNtn3e+/d+NOhlWLS7Xj/M5s2dOz00VVzULXEsbnpuXuRAmTwqhAyGW
         rttHH/JyFZp5iqZpBxn6CnvtAxE6LXcUwfE0bAAyU48T4uuqfLJSj4ElfnimjS3he3f+
         eZqM6JQ+x+jG29f2ATU7XY43lK5m48jFjiqrgVsWtAQkhGpn+B38UlZ1IB8DHP27zvZ8
         xLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713868879; x=1714473679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQl5qEwVKE01f/9GRHQkz4a3z973Yhrxj9l6Q9lKgg8=;
        b=KsotOvTtuRUeXtwfK1B1mxoTAxurf4VKySmaL/pUy5lrwDCLhyuJKNyiiBFKeeS9Cw
         /8YcL+z8rFFHmHnfmB4aGQTLNR5YbZCLr5H9tbOXE4Gb/kZ564TIl3zUr7ZNDElSqi07
         wQpzStQNwaJWWK8C60p4VdHt9rqdqiZm/2lnhaGwJD/OtPAv3MZLQOSozyA16gIlMDaZ
         JD6/sVfAZ23pJY7bHnzXTIH+0Svlg6FcESyLu0k5sajA/GCTvL0vL3lRmupTn6BIxoE4
         8XYexqp4f6Zq5zXDmcAL+lZ+hNoIeC6V4WdGDgezDbWqVHUGewBhvi2UUZskEbJDc4tp
         W1FA==
X-Gm-Message-State: AOJu0YzzKJjviKLv2tpiBYGpCakSwSVdY8MB19dMYl0j0CS84YCncZ5C
	TaZFoIpAbD9TApqJgN3ddmqbhu8shS7UM5HfyKtzpkeyXiYSEXzEMCr4zXpC8MF3ejc+ymElqNu
	c
X-Google-Smtp-Source: AGHT+IG+hOv6ETUr4XWph6lySqZB5qDDYJRKGSSrZIIlVz00gQt3waHz4MI2qIsvPg0J/EZVG/jMqQ==
X-Received: by 2002:a17:906:b105:b0:a55:75f6:ce0f with SMTP id u5-20020a170906b10500b00a5575f6ce0fmr7297845ejy.13.1713868879171;
        Tue, 23 Apr 2024 03:41:19 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id v16-20020a170906b01000b00a522c69f28asm6879534ejy.216.2024.04.23.03.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:41:18 -0700 (PDT)
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
Subject: [patch net-next v5 repost 2/5] selftests: forwarding: add ability to assemble NETIFS array by driver name
Date: Tue, 23 Apr 2024 12:41:06 +0200
Message-ID: <20240423104109.3880713-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423104109.3880713-1-jiri@resnulli.us>
References: <20240423104109.3880713-1-jiri@resnulli.us>
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



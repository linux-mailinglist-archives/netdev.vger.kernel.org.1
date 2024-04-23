Return-Path: <netdev+bounces-90448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C648AE278
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99D2282196
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4567477F13;
	Tue, 23 Apr 2024 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nVjyfESX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45BE78C6E
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868885; cv=none; b=VVImlAY2v65GcGsewvTsryvr2axeNR4exjOoVWKqpevxOtuRjN5fFw++AC91lp5BZRIyrcmnoczBZqn18eVUGLq1WJtdmZKWLgsg9wO53ZBJDkb7MrpEFWjHJXI+ItQSGS9BQZajdIOEO4WF0MEdC64iDOoptk5GiUfd7sEfTvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868885; c=relaxed/simple;
	bh=skJZVZU2JBI8WGJ+4NhCiFRl3ZLQsAGK0b5U2Pn3qOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJ0RSzukkadq8PmuKidZ2Ek5a4ochqUftvNo5Fimh9HpQX0qrXbaTw3hNZF2v2cwwEU/Mfx6+/+Z1dhSVRHn2wfTDrwc08FGAVk1iV2MjO06Sa7h/lxMcvVqs6/0XGMDUpmKWUpfMBqQfDVVAlwDBo0zaFzoGptH7YR+blheNdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=nVjyfESX; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso6797099a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713868882; x=1714473682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PEW2sq1fZZcUdcYFCd5NXPg9CZPy+bkUUV4EmPfc9U=;
        b=nVjyfESXLzD5Hes5/NvdYJMR5ViTaKJFJ8iFACf+rL49uhf//viY7xDlGVgg3+4XNq
         Sdj8F3Iw6npMySiegLm5UweInDINOrdNH9CE8Ukro0I7DJfxE9eLo+sRy+adCCXAygvN
         0F+5cbr2vydS52R2FMyvV5EHyD0vL1buZxXgPaLBc77axy0ehniv1fWWnVL5tOFsYUin
         99fsYiWbQ/iFbZuMqP3ZbNFJDqzXCBfev5fzQ1ipaPU1zEUa4eatub8m6exI+WW11DTb
         S9DEAZVk7ECX4ugY/ZuXunIxuk9XxA35o/6v6SE4baWq3YwxrpZ8ObMWsZNQHVTGUcWv
         RTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713868882; x=1714473682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PEW2sq1fZZcUdcYFCd5NXPg9CZPy+bkUUV4EmPfc9U=;
        b=wBKhZR3S/me5A4GQZmlnZ/6MXI6IMuZhkvvcju6YLP6MezqXOFQPH7IbheKzuCR3UN
         kD17ehZwH9RxXaFheUofNpKqWhIISIWqz3JazFjWN4MU7SuXh4Cm+6Xl9BIQw1H51sZv
         smzZ1A6CAvPctfu+lqPmRMVMD38drlpvMruNCBJlhBiqdWHIG+ijdZ6lpA43LwFXAhtU
         FFagRCJ2TMgZYrkXuO2UJRhWqSrBsoA9YiSUyN+IqVlm58rCbeBf62Zr3Dn5cPWYX3n/
         zsYVG3tVCUxLO0HrEJRAtSntjuEIULy4xu0VlcbWLtu4df6+cWUmgbKgh1Dn1EQPXhIp
         4FqA==
X-Gm-Message-State: AOJu0YybBM7CLfV/ebqn3GbQEer7fSbkp3jsx4tSiQZW9HCNBjzxALCf
	VnHq9k4o0xUlVPvp4CYT7HB8XWDfj+r2+09P2p0DFH5SXrIajOxupER3FjAFbuJUy8uca9vdMz5
	C
X-Google-Smtp-Source: AGHT+IH9gXunuU/J5xzGqAVceintwfiAZYNFxqLDRge/NzifRKTF5QZg7qXyi6QexPnSbsuTD1icXA==
X-Received: by 2002:a50:8717:0:b0:570:34c:91cb with SMTP id i23-20020a508717000000b00570034c91cbmr9656056edb.32.1713868881992;
        Tue, 23 Apr 2024 03:41:21 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id g1-20020a056402428100b00571bbaa1c45sm6428717edc.1.2024.04.23.03.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:41:20 -0700 (PDT)
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
Subject: [patch net-next v5 repost 3/5] selftests: forwarding: add check_driver() helper
Date: Tue, 23 Apr 2024 12:41:07 +0200
Message-ID: <20240423104109.3880713-4-jiri@resnulli.us>
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

Add a helper to be used to check if the netdevice is backed by specified
driver.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 9d6802c6c023..00e089dd951d 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -278,10 +278,17 @@ check_port_mab_support()
 	fi
 }
 
-if [[ "$(id -u)" -ne 0 ]]; then
-	echo "SKIP: need root privileges"
-	exit $ksft_skip
-fi
+check_driver()
+{
+	local dev=$1; shift
+	local expected=$1; shift
+	local driver_name=`driver_name_get $dev`
+
+	if [[ $driver_name != $expected ]]; then
+		echo "SKIP: expected driver $expected for $dev, got $driver_name instead"
+		exit $ksft_skip
+	fi
+}
 
 if [[ "$CHECK_TC" = "yes" ]]; then
 	check_tc_version
-- 
2.44.0



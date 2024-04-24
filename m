Return-Path: <netdev+bounces-90855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9A58B0789
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 12:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989D9286541
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 10:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC430159581;
	Wed, 24 Apr 2024 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ija7vE0T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2F15957D
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955275; cv=none; b=CXad2t2EDU+kLfSd/OcGwTDjsJ/czUdVwh6apYf/DnLb0BO2cvcU4Cq64umewd3wV/fjyL2NjnLLAPuZY3/97toT2RUleqzx3sinBlgJ30a21QNva0mPpfX28K/l4N0GBLacqE2SDoL/8Fm6gjzOiQeVaqRGyCeGuFxaFi8G5tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955275; c=relaxed/simple;
	bh=WvA9mi8zp8l2a6WFa91lX57zesLhrvAgkOfsOsQeM1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrDQ2befErLlU/2l4rA9+5Pj1LlUGRHpcDvk1poRDlQG0aP12V4cCm24bUzEuTqGpY7jYeeb0KNtqscRmQ+BtuXfmwjQxAhlZeQ5pS4JiW8aMgGX229G6iuuWLqpn1UZW5DHw6xcwnUoWUE21xTq+7d80Un7XPk5rIeCDxbnqxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ija7vE0T; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572347c2c16so134847a12.2
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 03:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713955273; x=1714560073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUHI9zilGVXMHsT3cMVzO8EqmG06SAbRC2e4DxW8mYI=;
        b=ija7vE0TOg6K9Ox/RhAyc8EcJsY08/+j943LP0yRiAeegcQOAqyAfWaB8AOn+gvAlN
         OWAbWAYYUYSaujWw90A6ZK69dea7EOEj07XKh6ta3CBfdXDGcxpePJNGeRUgG1q6OtTN
         5vlDzqjxcNTTAhm0zqVVCiAkaRpSz0Szava7qCnQPJDS4DisW4E8mGDeaNJEdxY462a6
         yrnnVFSQRwyvJ0A0U+iI7ImCQldkDhk/Rnl5TjEy8XJpKD2nKSLk58E+d2rF7F8NzaJi
         ID05hJHrBH7w3d/YJStFt4rP6HTD42YtGGYeKN1Jakz6ov3o+QvMCZvn3mUhbE+i+X/a
         XELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713955273; x=1714560073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUHI9zilGVXMHsT3cMVzO8EqmG06SAbRC2e4DxW8mYI=;
        b=D7c49qsfBXXOgEK3UqxCN3Nl1ismszgjAis5NBuaniHeH5hHwqAXPW7DLKDhD10VzU
         z6X5eXx3L3sR4mlMFOCUWLpa/NidHvg9+BAWLjHALBvbTydmQqdMdrXECcm993jIx0go
         3dEXEJAk2z5bjNuemHFMui79sdr4wO+/XRa3/sjy3GhlzfSQlSMEl69u8H5RfJUFrsSa
         9WGXhAyFBAlxHKKfHTL6wh/IqwHP6YEy5PDJkJ+JafxVGBeEo7Ak84hZ35jJXv8oo1oN
         ezs4X6M8YqDdvEqczTKb4pXl8xugGxwdjkZqWuCPmUdUjAxKSafpk4R2inNACroISMO+
         5AtQ==
X-Gm-Message-State: AOJu0Yxtw//5ur2I+/4jnz3ehqBfwhIx1yfUccQTTlNQnjhikMkMuoWN
	A0457f4SWzoRtJrHiuQ8zfy4vVSafpDi4h2/lkRwLDUFIUn8gV1Ib7eSmEcOyaf39d57/Mq75wv
	UB+Q=
X-Google-Smtp-Source: AGHT+IGE6LlafpU2Qxf9I6d9LJDd/D3TjhCV5n4qDef0tJciUVv5gQJnoUrU9VRAEN9NDhSSUuMJoQ==
X-Received: by 2002:a17:907:6d16:b0:a55:63de:9aa9 with SMTP id sa22-20020a1709076d1600b00a5563de9aa9mr1644449ejc.49.1713955272680;
        Wed, 24 Apr 2024 03:41:12 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id h2-20020a170906398200b00a4df061728fsm8181230eje.83.2024.04.24.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 03:41:11 -0700 (PDT)
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
Subject: [patch net-next v6 3/5] selftests: forwarding: add check_driver() helper
Date: Wed, 24 Apr 2024 12:40:47 +0200
Message-ID: <20240424104049.3935572-4-jiri@resnulli.us>
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

Add a helper to be used to check if the netdevice is backed by specified
driver.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v5->v6:
- removed the root check removal, that was a rebase mistake
---
 tools/testing/selftests/net/forwarding/lib.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 9d6802c6c023..2d57912d3973 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -283,6 +283,18 @@ if [[ "$(id -u)" -ne 0 ]]; then
 	exit $ksft_skip
 fi
 
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
+
 if [[ "$CHECK_TC" = "yes" ]]; then
 	check_tc_version
 fi
-- 
2.44.0



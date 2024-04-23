Return-Path: <netdev+bounces-90449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDB78AE27A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C36F281D49
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6198C7D3E6;
	Tue, 23 Apr 2024 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="e7YI6zNu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32FA78C6E
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868888; cv=none; b=CM/EQZhch/7u2WzbUqI2/YPlLoZnYrKUE+8QAhaY9GTcbpZGSzwPMIWHmX0LOG/S+NAPKwy3h/7/26Op/aPLwkc2NAquZI68Z7EVpwjp/zv8cvjy6fjx7fiZXBWTZKtQaVcHD1w/LTkJzj8T6/1L1AVU+5ezWqdTvIzP5QUgY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868888; c=relaxed/simple;
	bh=b3s3lonKXCUontl27cidtmw2bRxAlU6LH2RDIq6KhXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSwF+I9cf1s8R+LFDZY2i/dD5xn/5bbr2fkk0qG4UkThmbuPqmo5F2yBQ7djGWyAgxXyKk0ctLaAhUErf8og7YhoukjHmPGLPeUM31JRMrxfqOO/fbleleMR4nLKGjRcuzIL688Lq1ktpcXrHmK7hiXE9/Jr6RuGPXij3i9kAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=e7YI6zNu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572242ed990so334027a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713868885; x=1714473685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+SvETYZqEpQzbp95WnLsYBk6au1WM6Aqn9bo14n4zs=;
        b=e7YI6zNupUnNpY+C8iiB1f6b2tJ1KEtIt2JQ//4g8UZDjPk/ainyqQ3rhXbhCX5XBI
         e0PlVc5EA/APkToWUcD25LnxDIcMOgSP+RacBG32bgGl/HohpItFQ8Eux7+6lbPCuEN0
         j66ZhL3YMPXcexpN+Cv7usX63kdeGtdiRry+c174ya4/v9qpDtnU7t9YYokb1GCn4Vlr
         +MLnvHgNAqbrOS6xDCFJ9eVLnmCHRKa9pa6M7tltYZmmzHLBJ0h1JQHLpxONp38OzoxA
         WW1Njt2C04xNfucCAG1zc/ZcJqZA8KNH/aKPpqfKcizxhc2WMIV92CwnZKdZlYJfVvAC
         Wc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713868885; x=1714473685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+SvETYZqEpQzbp95WnLsYBk6au1WM6Aqn9bo14n4zs=;
        b=xDum4+Lkq+QDAxGiqHSw1b2N7yZ8AIR/K6S1LVfWuIr3ajWcSuHZad+pYIH6ILS+PE
         3/32qubIJ5tHV7ORza9xsdkS5iet2ocNgFqBtFBnyMYL8CZB1rG6FnHjfNuj+sFCZitJ
         4WYiBWrdImlm1c8X3XojyfDo1xU7BYyWyHeF5hSuL6wDOy853oCWtzFBJ7EhURmnYU+s
         V7BxQ2aMgqkfBYnwufKAlxAfcGQFnHMFsM6kbTPN1l9BJz5zoXak6TeqZUTdgpWYxfK+
         2kLVDI8IB+xK5aO1urd+vpz+4+m7wfgDVND0FpzggNt4MKGYJCchyrly8YkB7CDxu4Ta
         Cigw==
X-Gm-Message-State: AOJu0YwJmbXb7xMf78Bst8jfR1FdxbfCDLlq7a6I4Ktnxa9jjjRca6Gr
	Qxc4lnTQ/Y7JOePPecphSYTStYWMZIRiz3kUXp8EBK0T5uWE8O62hoon/FKe9DymyK62uUt0fya
	c
X-Google-Smtp-Source: AGHT+IF7EqsjRddLl+xv2aOwVOeKqbSfjmJfPOqlEpNdTPkVykzo0NuULllrdLvuLp28jrt9xZ4x3g==
X-Received: by 2002:a50:d682:0:b0:56b:9029:dd48 with SMTP id r2-20020a50d682000000b0056b9029dd48mr9614396edi.5.1713868885302;
        Tue, 23 Apr 2024 03:41:25 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id p23-20020aa7cc97000000b0056fede24155sm6500516edt.89.2024.04.23.03.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:41:24 -0700 (PDT)
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
Subject: [patch net-next v5 repost 4/5] selftests: forwarding: add wait_for_dev() helper
Date: Tue, 23 Apr 2024 12:41:08 +0200
Message-ID: <20240423104109.3880713-5-jiri@resnulli.us>
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

The existing setup_wait*() helper family check the status of the
interface to be up. Introduce wait_for_dev() to wait for the netdevice
to appear, for example after test script does manual device bind.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
v3->v4:
- removed "up" from ip link command line
v1->v2:
- reworked wait_for_dev() helper to use slowwait() helper
---
 tools/testing/selftests/net/forwarding/lib.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 00e089dd951d..94751993321c 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -733,6 +733,19 @@ setup_wait()
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



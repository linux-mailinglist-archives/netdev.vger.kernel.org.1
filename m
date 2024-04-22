Return-Path: <netdev+bounces-90202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840488AD0EE
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D861F22DCC
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FDB15358E;
	Mon, 22 Apr 2024 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MlPRVo7A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83CF153582
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799994; cv=none; b=hSvtkeZYzNqbdH0xXIggFLHODF40poB2TnccKgS4K2TKtUWawnBQbFLT50r8Rc3x9EkszisCgiT2jW2mLPywZxdT9KhEokqJtzuRGOa2f9Q0RwO5YybJ7AB7IEFdpAOSflajJXBW5ZgXnbKCk1io81g/yUPAesSjUsQ3Pg58nBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799994; c=relaxed/simple;
	bh=b3s3lonKXCUontl27cidtmw2bRxAlU6LH2RDIq6KhXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1gmess15RHrW22JRFeiSFD1ErQnwgW9WjvQEt2GPT1pHxAfbyGkFngMqD6QfGEuotXSg3Cg4bfjNZhM0/rX2IkWpjX7q8pKItYgGrAueatQdi8LK5y03Anx9Lp4NAr7sEgLi2QXUxr8DhogHPDol/+Z2k5cMbPOMbjMhpLc2J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MlPRVo7A; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a51a7d4466bso485944466b.2
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 08:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713799991; x=1714404791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+SvETYZqEpQzbp95WnLsYBk6au1WM6Aqn9bo14n4zs=;
        b=MlPRVo7A/9DZ8a5X7qSnnEWnYtTyF5KUfVWv9OqbcD0CEHbGwoq8an0XADIBpICfjf
         W67dze8FtJjZYVkBcfxddjb0K/pGsdljE+OSdBEcq1aB4+U6KbfdT4NubbF5VprOU4Ms
         DbwjH8/nsbHeAyk2X5zdbtPxZLees6d2v0clI9u7SNDBZ/FxgWKxGzthApMJsFsSK6w+
         SqrlE8zSZ9GdzGHoCYf9SxmWh38BqdYCWET9pEJdreXkHR+ETTqfhwKahBY/fz5laHCC
         xiGy8ud5os8L5+DYQR7t833tNyejrxsXiGEKu7+HcZ4oSdTUo6w1pGoZRfcKXn/dwkxX
         emsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713799991; x=1714404791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+SvETYZqEpQzbp95WnLsYBk6au1WM6Aqn9bo14n4zs=;
        b=rAT24ujPZBgbK+OW9yklq6Nn50Qj7mzaDD8c7e0hmhK+KEqsOyzcL+0hW6w0s4XMor
         gW7rjzZcYAIBHsCoZkH4CxI9qZJcdLMD9WGWjEbYrF8RNV9KYEzav4ev1OZwzw4701qt
         D+pYdAdt79T/Qp1RSwvd3m0zgYEyiAbnaWt/ih2UPDeuslfDk71jooQJ+/nKDvPi6pO2
         wRiW/QgOGRMff4CU9+/Iw3Cec8stkmfdQjQHWHxVFuvh6kdg6aVYVW/BrbtfWW1Jzyx6
         wUiPdWqC/DreKpwH5BHq/aqLx/5+Yvt3dTA3w2fEaebSa3HUPb2wz4PGhwmjAuOJxmTF
         hiKQ==
X-Gm-Message-State: AOJu0Yyi84jZ1Znrg0vEYzpfSoXZDJh01dXtTyD3mUyGy+J9t3JBfa07
	ACs6LwIcwMHL1XEA5XllIcNB6Nq23B03ggEpSADucwCZuKUzKM8pOFkLvc7+CHEveBW4CT8mdSU
	n
X-Google-Smtp-Source: AGHT+IHIEgOcibr9ucENpjaIIreAlXyqBrgAOhJK7PyeduoRLSEwUOBWPtvHYKh7djNpkMZpKeHA3g==
X-Received: by 2002:a17:907:86a5:b0:a55:ac7d:af14 with SMTP id qa37-20020a17090786a500b00a55ac7daf14mr3872553ejc.40.1713799991109;
        Mon, 22 Apr 2024 08:33:11 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id m24-20020a17090607d800b00a524216fe78sm5887199ejc.64.2024.04.22.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:33:10 -0700 (PDT)
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
Subject: [patch net-next v5 4/5] selftests: forwarding: add wait_for_dev() helper
Date: Mon, 22 Apr 2024 17:32:59 +0200
Message-ID: <20240422153303.3860947-4-jiri@resnulli.us>
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



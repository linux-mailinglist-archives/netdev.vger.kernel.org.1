Return-Path: <netdev+bounces-89299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 293B18A9F9E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37B728184C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9C816F855;
	Thu, 18 Apr 2024 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eikkMqQY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911FE16F8F5
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456526; cv=none; b=lx3OjOr7OjrGJUHdCblgzM28NvW3lIl2ZReTSAfA0K0Lk8EYlIR+21bml0Dl9DzSYTTYlR7N1m65VVfWJJ/jZNViVngLHeioPTvq9X6Tf/jeC2tExQchr/w+XGcockRphJtwXWOCHl8HMPZIP+DWb6qRdTWd8Fg2LZJeu3OUtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456526; c=relaxed/simple;
	bh=O2CXlE7WbZEsGwfjpXKOeRNmpABi1eqbjqUq5VnToZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jh4ZZaxxgKO2TvVUoKsC+AQTa1oleLCzsCmIcYV1jmsU6hN7Q24BgW1vZX3j6+vmipg+FLQynxQilIl8D2XTu+MbGxqkWhzVR6y+eLfANhndLDTdiDEZTmggPitvFHuoDQXF2Ro0d5Zfr+ATJBGx0gjprAMfFdaBmBzJO4SQ/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eikkMqQY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e2c1650d8so1105323a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713456523; x=1714061323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spywciv4H/4k+WYAUPcD4YDC9twSB1M/aeoXVh94Uao=;
        b=eikkMqQYP2Glu93TCWP9JYpkyI7mI5c8Jt08460a0fHOTucUyS3ev5mamN1sR+p0da
         1raniup5c7+DRJWvMCWnAiLQlNWqvX95AZ2Tn+syv0WrhyjJXPwfBfWJa0hWzNmkkC8P
         3i3XCyUfW4GMgivveJqfty0M5akR5w7LVPcfd2FmQ1P/tRHgE6qSPpab7PeHKrp9MbIz
         4AqNEun3NfE5pgoXNGn2QdlBexGDWVlH/iJpRl8gwWNwd0kmT0piYCYtqKoTji2nhTN1
         qJ/tyMvWYvVnvMZTerUwzN9KZeDTanAZmbTDUrXyTx8Oa1FieFZDhPxWiAVngnbt/tlV
         24EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713456523; x=1714061323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spywciv4H/4k+WYAUPcD4YDC9twSB1M/aeoXVh94Uao=;
        b=oRsHleHUpqoKH/3iUyUrPNLjUbZ42mAGEm6wjY8S5U2VmO82mzkOgoH8sdOwY+xJNN
         xo1dij4WiR8Et5iFUFEh+QnNkvVY4H/yef2QzV6nZVsw0de/AitNSCw6dF6VyYLjgeWv
         ezVwuRXbT9/jHxq4P54361ELsPmYeVP7BJNoJidr5L9VjGAQUgjajYivJmIoXo7hwk4f
         FWt6o1IJHJr+gufRW3KmMBMTtKAwFw6Z5Urf//7JKFAl2poHbZ1SzRRvQHvWSyFleOQV
         W9QKvHpEksFn27N1uKgJ4fXhrOC38feQ7Lqoq1BpEM8b9PLnXrw80ZiZaSdRWFLFO/Ou
         XF5A==
X-Gm-Message-State: AOJu0Yww/FLqjlTo+j4ylgERoXXuAzN1en+HeaUOoRSHEs9PhrPj6n+o
	Ov/veD3ugGTmOsFRARUc7t/BdAYPkk8oZyCzgojDYykaMV6DqeB07GzsMEioqG/xOqVc2m4tt3N
	E944=
X-Google-Smtp-Source: AGHT+IHqXWzlT9OXQCwTPdM0t4BTG9sgRzPtxKjEdbuLI/IWPbpqLaWrsM82W6TAJ+ud4ZdH7G7QDg==
X-Received: by 2002:a50:8a90:0:b0:56e:2d93:3f84 with SMTP id j16-20020a508a90000000b0056e2d933f84mr2027411edj.4.1713456522576;
        Thu, 18 Apr 2024 09:08:42 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id m15-20020aa7c2cf000000b00571c2712539sm424083edp.81.2024.04.18.09.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:08:41 -0700 (PDT)
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
Subject: [patch net-next v4 2/6] selftests: forwarding: move initial root check to the beginning
Date: Thu, 18 Apr 2024 18:08:26 +0200
Message-ID: <20240418160830.3751846-3-jiri@resnulli.us>
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

This check can be done at the very beginning of the script.
As the follow up patch needs to add early code that needs to be executed
after the check, move it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v3->v4:
- removed NUM_NETIFS mode, rephrased the patch subject and description
  accordingly
---
 tools/testing/selftests/net/forwarding/lib.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 7913c6ee418d..b63a5866ce97 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -84,6 +84,11 @@ declare -A NETIFS=(
 # e.g. a low-power board.
 : "${KSFT_MACHINE_SLOW:=no}"
 
+if [[ "$(id -u)" -ne 0 ]]; then
+	echo "SKIP: need root privileges"
+	exit $ksft_skip
+fi
+
 net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 if [[ -f $net_forwarding_dir/forwarding.config ]]; then
@@ -241,11 +246,6 @@ check_port_mab_support()
 	fi
 }
 
-if [[ "$(id -u)" -ne 0 ]]; then
-	echo "SKIP: need root privileges"
-	exit $ksft_skip
-fi
-
 if [[ "$CHECK_TC" = "yes" ]]; then
 	check_tc_version
 fi
-- 
2.44.0



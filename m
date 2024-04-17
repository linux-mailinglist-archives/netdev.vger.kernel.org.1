Return-Path: <netdev+bounces-88807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275F58A894B
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD921F23507
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991FD171066;
	Wed, 17 Apr 2024 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fGy5HfPH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2430817164F
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372366; cv=none; b=ldOgZYmG5BEJ70eABr0He6HQZrrS3CRCVWPDLPu6qPS1wEx9GEKypIpkNqh9s6hdONk9PnuxrssQsszLeKDxiZnjsNXe1zrnf32nNXZpLbXCeOOzfpBtJG+4kh0VFuYYmj40e5QuXCzgvjCSgj9bxJ6I2j5dCLvDGIMGREI5mdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372366; c=relaxed/simple;
	bh=NArpel64x6HJ2BR6Xpz3gBx1vpaFxO5gSoTpsKJXupk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R95u/zh8JJt+x2yiML+PoTXRdYa9BQl+ceU3LhfFS+IpUnH7b3dWWcTMo47AM8oix9U8D9FZxkYYQFB+E2wuLDs5UiuN3tLU9y4/7z3w0WQDwgIOdvWpuvqG+/+C4CKmAM2uvTVyvBOEoYZq81h3c78s0i3b+RoYQHLbg6QK+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fGy5HfPH; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5568bef315so14495466b.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713372363; x=1713977163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iDSoNx4io0wz5kFgpirLfiENKR8M2isWO5Sk2gRu9I=;
        b=fGy5HfPH1M9w1lUQ8nnCCr5yPAgRAliYDYnHjedxz5yeRSUoYJ+rFx1Q1gcpxEwWBI
         W9nN9tuZHX9KklOIqeQljYfz3Mx/gUOoLKX+cbQ0CxzSp3UeimtD/ddstPvGyTd6o50M
         oN7YD4a3SdPloa5fk+qWqsvBeKHAi3O9NGI96Oc/AOd3k+RqGIjOQZsA57mu1r3dkpK7
         nxyMpEQG6PdjCMQy1Ha5ypsQ651FWym0uyrxownmBw/AvCOonSUPn62kv2yT3TPKO5iC
         IoKM9Z/ru8ipG3olMSenqgnoJMTwQSFMx4G3NbHtx20Spcy3qzP3JeDzf8zOy/fKnVIV
         yBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372363; x=1713977163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iDSoNx4io0wz5kFgpirLfiENKR8M2isWO5Sk2gRu9I=;
        b=lndOT8Txptwy+ETFOH68/u7tOSD40N1m+XtT9TZc/VYiHkIEOo8OELQ5oawhA5iyBb
         V3WLQI2s84/7+cIFCwSSDOmGYAiKJru1l3PY7dJHDKZNxeJXKfOLWFZgXQinxT6sntDF
         67FarihFZoCklsRTiIrZKicZHydc2wom/fzGyRQQ1WSlKbbiKZP4Lqown/4nfzuMWoc+
         tLwpLZXIdzh7OvfTrJFHSgZtwmHGKk2I17FpycMjIniNPJ2X4wvh178fEHuDcYvtaRCt
         X9gcxMqE91KCU4cBEgvLETwSBX9JzbkUObYSRAGU0BvZQoyR0ZWcohh+r0NQU7iJf19/
         j8MQ==
X-Gm-Message-State: AOJu0Yw881GRGjXoMXmWl7D5CMHkUZyafYnf3eRzDiXC8uIYIVgfxKMZ
	C6jJZVkaeEConD0ZHaR3sJbf2auPiNz+KmHoHML2QjAcDB6g63Ow6Z4qLtWOQxTclMtQfy1yOPY
	i
X-Google-Smtp-Source: AGHT+IHZlMqMIGtxRS4VPRipmPp6ctstGqWnjPeHHS6MRuX7c9jXyizMoNyEw4tsWSDIIz4pcqv8hg==
X-Received: by 2002:a17:907:985:b0:a51:b49e:473e with SMTP id bf5-20020a170907098500b00a51b49e473emr5476534ejc.19.1713372363586;
        Wed, 17 Apr 2024 09:46:03 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id ox2-20020a170907100200b00a522bef9f06sm7720607ejb.181.2024.04.17.09.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:46:02 -0700 (PDT)
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
Subject: [patch net-next v3 4/6] selftests: forwarding: add check_driver() helper
Date: Wed, 17 Apr 2024 18:45:52 +0200
Message-ID: <20240417164554.3651321-5-jiri@resnulli.us>
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

Add a helper to be used to check if the netdevice is backed by specified
driver.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index b3fd0f052d71..edaec12c0575 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -290,6 +290,18 @@ check_port_mab_support()
 	fi
 }
 
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



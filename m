Return-Path: <netdev+bounces-87436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E368A3205
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1554D284464
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8C414D2BD;
	Fri, 12 Apr 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AtS9ua0p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5914C5BF
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934813; cv=none; b=kuJuwaAoOt45m6539C624P0cH2QFeAFaPHas5h/cMqCGCF764uBlFLmTTIf2O2UjR9ichdMEHroci1X7+FcfeUDpocrsuQ2choWCn5Fs24WBYQHSOaxCvC107bbNY/mCxhx7YAwzz8g8NxRiuM2AjX+TvIlNktVTal5Mm7YaaeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934813; c=relaxed/simple;
	bh=QbEpVnMQr5FleQ181phGUo98xW1xM6Rbox9biz8EFFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXMJ8UfE5WS/ysb1+MtuVoNzOgeI9HfKc4qn6LLfZva6/lWVeS7MesFgDLUAx/k5StzkyuRTnCWcOaxF1iR1Zk2mG2GbFfdutxt1bruZTXnu6zxUWwJTxm2W4WEDo8ISS8A3HCISRBTjWTCIwoG/22PaQLjJVxJ/a6qg8nOjo9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=AtS9ua0p; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516cdb21b34so1295336e87.1
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712934810; x=1713539610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRzBFs7nWe4OmdpxKyecIOsORdsbkwk80rMj+0LzMLM=;
        b=AtS9ua0pbd5zMq41JGEPg+D6WmayrRaLeTGoJMqqrvCk0GHdrUU+8uz0jmk5by70Y/
         sEB/lzMJL6OJyWEizS+G/R2tGN5IgLA8EdlDdSy7qpOykX315LIYVu+2q6Fg3eqlyp7c
         nR2xO/whVatlU6Me7n60MxARfH7nY8i9J8+4iPQpldTNrbESG6PCx3hguaVwLzZsKVlF
         lCQpJr1ZQTLiNYfwsWInmtIei1TkyoOve6LHdy0rb+IgeSs1/xwAiFkhAm+vFV6Lsj/E
         PZkGvH6iBRw7WKzHBBsqgHMUCXYTsA84M9GDzcjhhB5MC3KcxBEzv+AMiU60QuGxUaND
         el0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934810; x=1713539610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRzBFs7nWe4OmdpxKyecIOsORdsbkwk80rMj+0LzMLM=;
        b=Bc8yhG8VPfUowPXWa2esiea+/7WGqczHkeXNvNeQqBGdDlwtOQTdwFQYarvwWQfL23
         LAjItcD5hJ3/QHDBrRReWYyMxLDYx9ka+4CHBRav8iJYkjzCqLFGDByKw5YUr8douNDl
         twAb6qioHlbRf6jfNc46H1+fLwkg7Vgr3szM2iXqYYXjS6oB3DVdrrcig1y0C219ubiG
         v0gF7NB3NkryYsAWstZ3Ci6sP88SpNDc6q1vJK7vwWGvwUwIr07Zx405CN3g25U3Rudj
         ggr+nXsTlRZJd+5n061BSsSWcI+/e8gIYs3uluNH4q0XjKo0LlwGGfuO3F1UgVcM/I8M
         c+TQ==
X-Gm-Message-State: AOJu0Yyht72vwUEMyOX8zkUHltXmAceoW/Uy/ownbjHyjVoOfxg4a3jX
	CzsElxMvnQAodccqS6ov3n2xNguvKwMoHhEhfBSflcqDcZxKA0tVwD9GabKngY5nEkVbGUoyjJF
	O
X-Google-Smtp-Source: AGHT+IHjo69PdEvYDcnQbXnMCraCmXWHrBnaH7QnmydQNhJdAHZPMhXzQ804UbbE+RnVcalObrgcHA==
X-Received: by 2002:a2e:b8c4:0:b0:2d8:10d3:1a0b with SMTP id s4-20020a2eb8c4000000b002d810d31a0bmr2023490ljp.39.1712934809842;
        Fri, 12 Apr 2024 08:13:29 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k8-20020a05651c0a0800b002d85452f55csm536220ljq.47.2024.04.12.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:13:29 -0700 (PDT)
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
Subject: [patch net-next 4/6] selftests: forwarding: add check_driver() helper
Date: Fri, 12 Apr 2024 17:13:12 +0200
Message-ID: <20240412151314.3365034-5-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412151314.3365034-1-jiri@resnulli.us>
References: <20240412151314.3365034-1-jiri@resnulli.us>
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
index 06633518b3aa..959183b516ce 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -308,6 +308,18 @@ check_port_mab_support()
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



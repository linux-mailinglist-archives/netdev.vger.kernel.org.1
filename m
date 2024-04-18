Return-Path: <netdev+bounces-89301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2618A9FA4
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF861F22822
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF67716F919;
	Thu, 18 Apr 2024 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BBJVsYH0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801016C68F
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456534; cv=none; b=RwKde1tAzd/kxaWeyMYxqf2TjzMSQqr8RaV7CgMCxOlzPjcm9E7uAHBMMrO6FRmEvGfOYHa0tUuLAHsXtNn8mc71xnLRnzpFJyxyZb7Cg6YX5wccOfLrcaBbPHxz6XzUiK4+tv/rRScB8bT0aC1FAGekszkQM9AZ7vnZOOZydho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456534; c=relaxed/simple;
	bh=2jQPPr9mkTqJV56LvL7E1XGifU9BFqf1rQjL05mNI0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvtLk0DbjqmdExobHneYQ3NlW1RonUchyC1ypElHm5moR5UGmGqwXcJQlySxkoZf6VApoioYvcwpEYZLrJmrdOYE7euIXqzxeekoa7jb82zINUhIljEQjziK+LnZmdfFBbb9RIqDGkQhBPKvKrBfjBAdVlnXF6FKwQ8oTiOY2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BBJVsYH0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a524ecaf215so120214166b.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713456531; x=1714061331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSQx0/+CrkjLLqkpLado9VHrrZwCAyIq3CNsBoHFJwI=;
        b=BBJVsYH0zHjHjiLegWSlQuQg53xJk+uX+UhQ8WzRm4Q6keBl1e1fjc/bC1VjuXZqS+
         oZmNZUBUuAMA77hGqix3kanC/QPWLe37LxRhceeHaf2baemQ70U5UHZVIUiO+1wjVFoC
         sPcA7HPtDdTB3PGiJMhuXQYmDuQ93SoNh2Q9hDcIvLqCapWX7VEbkqrfx4l6P1Wc/pLp
         zWs6UTH3xU36xrwUUvmFxQoDNCdtFIdctnIDXxTILovZitnj8Y3z7yXX3z7Ax1jkKFvV
         jIhre8qZJGZnwUHV2M0YIqB7Um3eDguIamURYKCZ6tCLBnUoRNEySkY5JZdGisXOG58z
         df7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713456531; x=1714061331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSQx0/+CrkjLLqkpLado9VHrrZwCAyIq3CNsBoHFJwI=;
        b=Vh6t18//twWDj/uHEg7sFPtoUEcodZwK53kVj3YtK6+8Q+YsWA6EeDZoK7plTBAl0C
         iPVmO4VvCz8jj/vKHQ1VRngwZ1kROBvbdhyjDP2MjXyAdd5xSH5n//6bhnsYy1fDbKVf
         4MX0qVKrRHtogRcFbnJYLn3+d+GbJuDRzlwR0newTxNEjYz1EY8fsALBAtYrJRs1gL5H
         EeYl3IuucWYkaDDeWYR1w1zuz75ad7EC1uhEwNvtkPjvSLSA/xiw4iEIxo1O+gggGxQS
         ASyL11fSSl2feU/GPDTy6sl6txDJNCym1/LtRO28XtYMr+wvEpIjE8/5/1yQpM1p4FHn
         +/RQ==
X-Gm-Message-State: AOJu0YxNgsPlFH+vrO54LHkvGvTf8CTlDB96IfCqy5PLznMfDsQ4SF+b
	yV3e7Voyhvyx4eG6/xVvevxLAsST2PTx6fe76gKyg+0GtbDiHD0twJwQLH1XNRgVAB9Zb3o2iyk
	CntA=
X-Google-Smtp-Source: AGHT+IHiaBm2LKsHV2qQHTiD3aikXdD7pxY2WNALoqBcP1UifeUoqdQS7+b2n5gVV7we9OrzlrQ6pA==
X-Received: by 2002:a17:907:9724:b0:a55:766f:ce59 with SMTP id jg36-20020a170907972400b00a55766fce59mr1826260ejc.75.1713456531339;
        Thu, 18 Apr 2024 09:08:51 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k9-20020a17090666c900b00a52274ee0a7sm1079280ejp.171.2024.04.18.09.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:08:50 -0700 (PDT)
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
Subject: [patch net-next v4 4/6] selftests: forwarding: add check_driver() helper
Date: Thu, 18 Apr 2024 18:08:28 +0200
Message-ID: <20240418160830.3751846-5-jiri@resnulli.us>
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

Add a helper to be used to check if the netdevice is backed by specified
driver.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index d49b97edb886..17f8b6b9ab9f 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -283,6 +283,18 @@ check_port_mab_support()
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



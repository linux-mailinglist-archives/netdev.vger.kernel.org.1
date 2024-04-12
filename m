Return-Path: <netdev+bounces-87437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8589B8A3207
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0725DB25987
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0398E148310;
	Fri, 12 Apr 2024 15:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RHrb8Tjt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6662514900B
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934815; cv=none; b=PViOs5jRfD1q9n1hOPC4JekS0+rqec2XRXKkQHfHJS4UDkxPB6W0XFaC938bxlGZlsvpEK/2M3agmfj+hLp4A9Sz+5ZFqLc6kHm5kPCbwIjJjMaODkKHvIaUhldfQn3nZDTV+M1JI0eEyIdjrOTcV3DdDrQF/jDnIEB3a/BDo78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934815; c=relaxed/simple;
	bh=y4OsWKbOLTtBRExU+Hq2EPu4xoFPTa3O/91wuGNyqUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVOOpvVp1lSY5zuiLd4CJbfBmeLLfjLtTp5oZamE+td3Zea+lMi2gyBFITQVXeAwC7dfhxg/uQ8MDPZjkhT+K5TAdoraDb3qbLHRc1rKmUGkIjZGWz+yqImVc7p71j0KN846m+OtsqH7TmFxVP308+RFq1TGQsFEUPtg5Jsob58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RHrb8Tjt; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-518872fcb89so762290e87.3
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 08:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712934812; x=1713539612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sErkhIGmhf5usWez5Xl4XZ9oQzpvBj57cN4AShWReY=;
        b=RHrb8TjtgX9SYa4fyq5/UOKyQCUTIy/CvC27LXQO4YmjwzPQj7kYw2vw8/N4Om6w6x
         w5JyQVdg2iHTWQkNl9VFayxDGBMVwUPb5ys4zWsbYNfdUhjUW/pSRvCDmrHb7zm127E8
         lvOKYWOD6Zj4JIHqnTPPMImFicxcuASDctkEhR/s+DhApp35klsUhBWWak3POHQZIRVs
         KRe5zhjMEz/DJXQFC9jzCxEyO/BuZWyN/M8CMOP/+qLL+GVP5EyegnmUMmPpumwE4aJd
         wH0o9JoahtN3VGICEvtKoVGy2ELXE5y+jM5kIWU400IdlPLL/5HQ4Pf0uHAs0SkBgCnp
         sM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934812; x=1713539612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sErkhIGmhf5usWez5Xl4XZ9oQzpvBj57cN4AShWReY=;
        b=Paa/L0PXtXRGmbwlVrtDNYC0lnG+AMxRMh3smYqnJ0UnHysHI0Lqw713ziy893i3sh
         yaKNqtszHLAA0TmRbC6fBTWZKIJR8uP4Wc1+MGngdhaPq7tqAlhOJhE0l4SuyJYji3rx
         4qsl9aSd0Pm7/wRg04XqWTk1WxMHJcvkvaqKs+MxjkAVtbosuZ01Yr7kMNZHM0hm+Opa
         qM+AQ7RSOz89hw7WU3Q/qSiH02ybhG5QqZhj4jji+YZ1vDI+/wdWT5T5qi0T/yl+T6Ip
         pEx/ti0kWE7ixgZi+EhrSnsR4qJjmpntIHwkgUrRc98B7R14slGdTrpYClZt2omslfFu
         FHVw==
X-Gm-Message-State: AOJu0Yzpcy24ssYSqCKTPJDPKSxV/pfOFal1d9Acb5723sJWxPpOLcUO
	VwM6/ijvVJgYS97it8QouChbhp5bc1G5cJMcI+mS+ke1tHeYignnQ0H0kTfQkIn0tSlmgr1zUcm
	q
X-Google-Smtp-Source: AGHT+IHwWGW3bNG9GA57M2WThwmdHi3AxEYStvc4TMRAgXH1eI+v60ijR149hFgbWIu61VtE9NGtsA==
X-Received: by 2002:ac2:5502:0:b0:515:bf51:a533 with SMTP id j2-20020ac25502000000b00515bf51a533mr1829013lfk.23.1712934812639;
        Fri, 12 Apr 2024 08:13:32 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id u5-20020a056512094500b00516dabfa3ffsm532393lft.145.2024.04.12.08.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:13:32 -0700 (PDT)
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
Subject: [patch net-next 5/6] selftests: forwarding: add wait_for_dev() helper
Date: Fri, 12 Apr 2024 17:13:13 +0200
Message-ID: <20240412151314.3365034-6-jiri@resnulli.us>
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

The existing setup_wait*() helper family check the status of the
interface to be up. Introduce wait_for_dev() to wait for the netdevice
to appear, for example after test script does manual device bind.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 959183b516ce..74859f969997 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -746,6 +746,25 @@ setup_wait()
 	sleep $WAIT_TIME
 }
 
+wait_for_dev()
+{
+	local dev=$1; shift
+	local timeout=${1:-$WAIT_TIMEOUT}; shift
+	local max_iterations=$(($timeout * 10))
+
+	for ((i = 1; i <= $max_iterations; ++i)); do
+		ip link show dev $dev up &> /dev/null
+		if [[ $? -ne 0 ]]; then
+			sleep 0.1
+		else
+			return 0
+		fi
+	done
+
+	log_test wait_for_dev ": Interface $dev did not appear."
+	exit 1
+}
+
 cmd_jq()
 {
 	local cmd=$1
-- 
2.44.0



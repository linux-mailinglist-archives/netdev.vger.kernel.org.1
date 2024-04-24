Return-Path: <netdev+bounces-90856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3598B078C
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 12:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F53286999
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0BA15958C;
	Wed, 24 Apr 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="y/ZgGSy9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1076A158D79
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713955280; cv=none; b=AF0oVvKExCujosIH70rOUl4d+fj2cKloCDI5/fJCcZt/bbxgXl+WoJzCCA4ndmTroNxQhBxhY3wJsDpg6LsNSfLNBYR1TfZmkDXKdWK8HuYQ0CvzjoXLfCJlroSsl4HTUO/ZkuWICnvBsH+0nrTEjwUvVRkd8S5eS2n/44AWSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713955280; c=relaxed/simple;
	bh=B/zxzQcql6baNzn7gSc3PVV0UgMdGK4IKuqEzi13oS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEWrhLkcz5hdf3c0/yf/Ixv0TWajwr3X5rpJkQolplETFoFWXF3FwkY0e7JTAwdOVvUB1S1vrupVvMWUOkWOYqeKfFsGGSNwkPvisLrq49sLhsT/x8vZikxJlhoumiP2z0UK3AjoolEKkHfP0hw5cP34O93HjfHdBdguRzWSU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=y/ZgGSy9; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e78970853so1407642a12.0
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 03:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713955277; x=1714560077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/Z3z4Yi1jKKF2F7DPvPW7KYbmtrDxuE/DmY57trBRo=;
        b=y/ZgGSy98JGesRp2MfcRQ3Rrl4BPOlDsQCG5IyX9Sq6/wlZlMpIZkeItCGhHKgdZe+
         nEdefpG9JZmRyKUsL/M/NOAPHzg6S1ydXEqCMmTryQENvWyzd9fs4rRPDThWhheCaqYd
         I9U1HSUuPSAGey1NOpR24wR8rujL7PLRUKwsE96pcQx75UyiZQ2FvdTKcH/4hKvVl1hu
         OXoZElCw2f5D1BQPx296uZnLVArSxV+5h9ZPnuwqA7w9h0/e6mrYF3SNPRg7zmPRDxj9
         XfkGAdX6Rh0L5ODzsiDVe6UEquNeMYbsJ41GhOujqnRK6Legr/f9ILBHM9cmYZ9uZ0AG
         A2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713955277; x=1714560077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/Z3z4Yi1jKKF2F7DPvPW7KYbmtrDxuE/DmY57trBRo=;
        b=S76v8vcmM7BkziChdGJYPqFv9w8w8R0l0youyXYMw2wZWWqtMPNqShYPBKftMWMPzR
         RmDEF22Ei6ofIk3qxTe1fFEE+YooB589WwS2p9OU3SK7xScNrJbjw4XTwjV6qNKUGb4m
         jFTbhjbfvXzrbj76LbvoeP0WowvDABqVrFfG2zUkxqjmya/ADsv/wwMnsGMT/uVhqQMT
         Q4z3loNu86RxRnG4y6XyE9M2uOm53k3ofYpk4aph6bLg9W1JqE0ZjsL8Q1WReUH/aUIx
         Maakvwwz4NIIZSS3HLUnfrZYairgSBPrVlnn8kjJ31PHZmsqnwZZbYl1axnIr6jmy+M9
         C9oA==
X-Gm-Message-State: AOJu0YzeJjw0xzy74UOjSdRmGFUGMuWXoeTGFjEXm6Qk0cOoFuSu1Vfd
	Wh4yvzvGZPlB4xFqRU4yc2keKEoJ7hDXLc9nGMAEBzXxMd9t1Bee6o6MAKFh3JdKJlFbvNTPlsg
	uqyQ=
X-Google-Smtp-Source: AGHT+IHZZv1xVt6E3oyEe3yq9SW4nf/htg+PGNeigdjf8TVoO1Gvpm6evcpk2261/trhL4oabGxdmg==
X-Received: by 2002:a05:6402:40cf:b0:572:218e:1676 with SMTP id z15-20020a05640240cf00b00572218e1676mr5950886edb.4.1713955277277;
        Wed, 24 Apr 2024 03:41:17 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id p36-20020a056402502400b0056e064a6d2dsm7872600eda.2.2024.04.24.03.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 03:41:16 -0700 (PDT)
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
Subject: [patch net-next v6 4/5] selftests: forwarding: add wait_for_dev() helper
Date: Wed, 24 Apr 2024 12:40:48 +0200
Message-ID: <20240424104049.3935572-5-jiri@resnulli.us>
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
index 2d57912d3973..3353a1745946 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -738,6 +738,19 @@ setup_wait()
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



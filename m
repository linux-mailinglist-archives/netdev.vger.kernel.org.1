Return-Path: <netdev+bounces-88808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304C58A894D
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D984B1F21D6B
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB05171088;
	Wed, 17 Apr 2024 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="afnkKwPE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E2217107E
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372371; cv=none; b=LYzNqRSovEWSCkRfuDRUztFoaXK3Tdim/Vr9MUsl/iZfKv9/Qh4E/UXVaMtk/5WEoAh0x2xdndhISyf8Z+eEkELpgJltUJwAidkUg0L3N0TDAt4L2fD4LmKvqXfInHi1bx5wAhjh9wFHybiuJxhefR6YSnJwx892ciATgiq04Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372371; c=relaxed/simple;
	bh=cYWBkuVz2OqTjZZvkAAucx9ew5P7UCkfTJr6g5UPk0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/b096RdkHBp4+VS+KUwat2ueoRjdmVJFCqPyg0K0pXtMvza1z+/hrp5xdV+byC+x2Udrgz9DfHYct0dYPyVAJ+taBD46O/1ngQ/UVrS0C0qVj72deUNvk/m1dwRm9h3zrFviHDkTpVWKxAY25hF/qaNFEipW8E6N6TGmUsZYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=afnkKwPE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so1882227a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713372368; x=1713977168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REEmA/tIzrZxHwQ+eJVrb/dkT1DH8bvTei1p22/X+z0=;
        b=afnkKwPEev2KmLa9k5V7222k3hPq1MU5DupicMJJSPG4YGEqiamMi9i/IPbGDJgRZh
         0rl1dpIn5qs8FijXKfKPISP6aIe8m1NckHUnM3c3nUh4IMfp6lIOo2cA3MS6V7W4diUz
         w03FIHUIYcXUjj9odEzeF/hf1PoSiOpJUP30QC3E5DzAMleDs0RpErghGeTlyPzw1Wxk
         SDQrQ4JOMJFbq9yMCcOGCiAFRPpDzg2W4e5e6a0JrN5X6A6uFbhkmAlCLsKysoJM4UX6
         QtZgnHEH/wLRMKXaNw6aRH47DL1QjpmgyXepKnnKnKCVJ1tZpIJQ2r5mZNo/GkJgp6K7
         FdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372368; x=1713977168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REEmA/tIzrZxHwQ+eJVrb/dkT1DH8bvTei1p22/X+z0=;
        b=eAkol2c9LWXKkDwKekI83Ockz/1x0DQ2t8wL3IA+5l7dMuE+jTtVMBvDcyv6qwLR9j
         JL0h8CU2zRSwELnqX6n3U7PUPI/urahd0rB39fbdvcAvinTb6Mx32ucS0AYlDgpHVMyJ
         hA4E5fYdiIKHt/XwvAJAQzmb6FY8k0pcdmGAe7SZeNYV7qDxpEjO5eNHbrIqCHxsYOMS
         iXDbAYMj8xVvTnNYFPxojgWwqR/NMD2sjwBFl8rM+89vj6DqaKuEk4bevL4Na8k3dLK5
         RRkY1BEsZ50ak05MgvoESTobpKCKtMyt3f3IN1FCDZz62DspcjEmM8qXMzFHZPfatc6z
         bpvQ==
X-Gm-Message-State: AOJu0YzyVc+d/X8IHzdMhNoimwgKoOX8EiLrXOVc9hbNmtP3Uj2mBJbo
	aHgddTYSmEXzdF68EvhOZtykN2LBOQ0lRxCuPwO/sQussdngK8rkBcl5Vlpru8oAyLSUSkJQ5km
	y
X-Google-Smtp-Source: AGHT+IGPBnih1hbsQxAuPoauf1NR1vbfkoyGDLPTYY+zGlT9YkwztfAahhP8SZeYG4YKDO26lfsOCA==
X-Received: by 2002:a17:906:554:b0:a52:30d4:20e6 with SMTP id k20-20020a170906055400b00a5230d420e6mr4536310eja.10.1713372368374;
        Wed, 17 Apr 2024 09:46:08 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b00a526a99ccecsm4161102ejr.42.2024.04.17.09.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:46:07 -0700 (PDT)
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
Subject: [patch net-next v3 5/6] selftests: forwarding: add wait_for_dev() helper
Date: Wed, 17 Apr 2024 18:45:53 +0200
Message-ID: <20240417164554.3651321-6-jiri@resnulli.us>
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

The existing setup_wait*() helper family check the status of the
interface to be up. Introduce wait_for_dev() to wait for the netdevice
to appear, for example after test script does manual device bind.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- reworked wait_for_dev() helper to use slowwait() helper
---
 tools/testing/selftests/net/forwarding/lib.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index edaec12c0575..41c0b0ed430b 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -745,6 +745,19 @@ setup_wait()
 	sleep $WAIT_TIME
 }
 
+wait_for_dev()
+{
+        local dev=$1; shift
+        local timeout=${1:-$WAIT_TIMEOUT}; shift
+
+        slowwait $timeout ip link show dev $dev up &> /dev/null
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



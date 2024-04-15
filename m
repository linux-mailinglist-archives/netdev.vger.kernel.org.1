Return-Path: <netdev+bounces-88056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A23F8A57B0
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C652B1C20C4C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF17C82484;
	Mon, 15 Apr 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bQ7MWLxF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3653B8175E
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198355; cv=none; b=bl2enlqP2389fVSoAjufuc4WilRc2G6TzLczY5B4R5QNA9KytGpNfMPLhLn+x5IDqvQvgQskol7CL0hQFZ4T7g3p4BZa6xjOeX6p6+1JycddV6Kc8xiEOKOz6as9L5BF14m0PVjpoTTEdtcpUhr7Wcd9QacyujUiQqY2omznMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198355; c=relaxed/simple;
	bh=28bGfo/k1xHZ3BBi63D5YJEOeJXQ0EzebP5KwrPOH6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWlYRtqfzLz9z1rYaRvlosSBUXtryvFshTVwdL4v0CDEnEEFs1e94ucmiY/BCt0YaDNj1k/Dj0kiTQPDC5w80sRKWiYLVcFTFndWyBuZfj/UvCXSOuEFIcIOzxGnVVEkK8AtLLKDDHsDiQwZErLHApAFw7Tg8jUSSA71pZ4nW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bQ7MWLxF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a52aa665747so130421766b.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713198352; x=1713803152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hobzl0UFhcxWwRJMKvUjC2bqwhgf84pG3unrWYn5GIY=;
        b=bQ7MWLxFKpVNc0cavT65wnt5uHM3AWPV6CyljFJjse+pWztCej0LDw18mFOIeKnAq8
         FsEsIVUVLOt3kPkLgJOpu/wRuOMXgllSB2g3i+YRqpOsCSC2N+8KSl43WIUWJJGu4lTa
         LhMbKmH11ZkLpC/qtk8XccIb6t4hRO7FwlWzmehpXOwILjkGxLktgib7R6UPLSHuoESS
         n0myfmezVrhimC2oPthJt2Yn7jjFRPOxQdgduxmOC3L6fKvePj03jw5vyLSYh63WEeie
         5u1/U7GAGxeonNU1BMBmW4u1egh+2Zr0tdotilbvoMYrel2gw8Kw1yomyiz30bBApA90
         Jeww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198352; x=1713803152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hobzl0UFhcxWwRJMKvUjC2bqwhgf84pG3unrWYn5GIY=;
        b=dDD4Y4DQxWIf78KmE4f2ds/SFhyzfB8qWJCH0OleHcpuRUR6BsJb/cYRg1ufM9fRzS
         v7aozLJtWCaFW5hDckGZzUp/Uir9CcO/JmhMfkTbzm9N5UrTroa51jtr+JrC28nQbQKH
         sKcJQi/0ygZYRU4LDhVCfamE1paUQxR8oE1/y4A6CWlaOp5etx/Zs2hi6XZcO7pkElb5
         cfU7SKZpDip1MXTOiAk2c59n+HMjcck7hpIh3m2UB6dG1/mMMyCLmYJTR/XcSjWb/MLX
         c+DZdLvUCUCCpUJ26ZeFfX5xMWiNPeiFXxkDZgG9g3EoYGrSldc8j5C1EgY3UQ59jlip
         DKVg==
X-Gm-Message-State: AOJu0YzgHxUILAdgupeTjQZHdmydpYH6GQkifHqtRm2K/h/8hyQ2uH1n
	9TfZNG6hXOzWZbwDkDgbe6u64MwdaY6UH5bFbfDn9tONdGPb4Nf8ySzEh+4EzrRjl6QPh+jsx18
	j
X-Google-Smtp-Source: AGHT+IEoJb53bXVvb5Gi0iF9qZqsarg9CG4MfATrcj7oQ02oHBYqjagcwajf+AKPvrZpdhRvj2MvBQ==
X-Received: by 2002:a17:907:360d:b0:a55:201f:75a with SMTP id bk13-20020a170907360d00b00a55201f075amr1301928ejc.33.1713198352533;
        Mon, 15 Apr 2024 09:25:52 -0700 (PDT)
Received: from localhost (37-48-2-146.nat.epc.tmcz.cz. [37.48.2.146])
        by smtp.gmail.com with ESMTPSA id ci23-20020a170907267700b00a52431b57e4sm3766497ejc.121.2024.04.15.09.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:25:51 -0700 (PDT)
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
Subject: [patch net-next v2 5/6] selftests: forwarding: add wait_for_dev() helper
Date: Mon, 15 Apr 2024 18:25:29 +0200
Message-ID: <20240415162530.3594670-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415162530.3594670-1-jiri@resnulli.us>
References: <20240415162530.3594670-1-jiri@resnulli.us>
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
index 254698c6ba56..e85b361dc85d 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -746,6 +746,19 @@ setup_wait()
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



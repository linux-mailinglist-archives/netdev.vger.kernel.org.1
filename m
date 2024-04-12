Return-Path: <netdev+bounces-87434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 657E98A31F6
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5F8281F4A
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F22D149DF5;
	Fri, 12 Apr 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="m3KqIfN1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816AE1487CC
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934807; cv=none; b=YPcG0Lspw5FqMwXwBAOepbAxNA1EhX9ubUwvC2zM3iMgV6dZY1BN+K3WMEzjjrQinno+rp0xLdUWnW48A9hR5rIrTci687dudZhQy94XlAfOa5hC2DVLefRJo87zXBK4ZY7oSakyMQO9uKEM/dosYjPHxQUBEstmFf3dZmThVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934807; c=relaxed/simple;
	bh=j2PzpeP++wEtCimj6PizZGaulOFqRwTLU39GbwROnR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOCnrkWR9vOuIzMNXJs+ngsGjFFqpUg3LiFzyxweWToUYxO1OpjBihkxzxn4cGmBqqR2yrs9f3sd/vIyOb2bXx028wMvyE1QaAjoS19N/1fcJAL1raeD8f8stI4Nr+zWUvc0maWPqBHq8bRAieeS8x+AzQSxTS9m/QbdIWvI2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=m3KqIfN1; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2da0b3f7ad2so10480681fa.2
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712934804; x=1713539604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX/Tsfwpe953mO8yyC/qEHw3fIQWpZrg0eDPY2EH2gg=;
        b=m3KqIfN11/Q9mhKJJZIkGmf+SHpvlvnYZk4EbJ0z8hhFdsck+TYQOKKRs+sPdaCz5G
         lZAaz74K9SJgFLgmOW+2oqy7v7f44h0BxXUO4FMI7EfOqCqHb0wLPBVdZJRtmZ26u4Zn
         kuBEYmPWB/Z1D6Y5w1LQ561+pVZXY2l0g4ufcoCcmysv5pBbm74AFaz1xDxdJuzsf5KP
         WYSrieVJLID5oNLmP7pMijE/IQhr3epmTn4qDnmlZdV9H43WxEiDLAwaadX5TdHhVNC9
         kc/3jurx7S50IfehTHub80Kmn0Xf33FKraplK7qG2twBmeUxclL3UqfxcLEmcenWqDax
         2YkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712934804; x=1713539604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PX/Tsfwpe953mO8yyC/qEHw3fIQWpZrg0eDPY2EH2gg=;
        b=NMRBtorpQpwZHoF+iF+XenVrCX08EsicoC/4FtH9a6+iTE0f9XtpQ0+X2vmmT5Rf+6
         zDcCNLQqXq1rrRRtdVEwlJ9A1PY9zWXlBELFhkLXgubLdE8E4iCJb2M6ANpWPomcqi5d
         B5TOdbKuhMydFQSuCF1M9qsqOfM6qL8IUu2FTRUkZF5F+Y9U28FDMZWSIBMM52RAyEwm
         ylypYiYjtJnyLL/y+QuKkRjCMj2QxS1l9udzoo0vvnNtM7HMV6BA1HPz49GXdGKAc1/9
         fZP8ZNcv4zxpM/3mVPJ206zo+9C011u3KtlG41tX3U6JKmBMH5+PcNpEJdsYcGXuLHwE
         BAsw==
X-Gm-Message-State: AOJu0YymhrWViI+bX9ujbtdwN64wcSAbEVQzZ13PtPghAGFA0zxIjTS1
	BKeDpauaFrPCtgyJn2SQYmTCQk6H1/HLi/OzULYZVRqIkm5PHzBhsCDMuGj2xg2NUmesm1hjAlu
	V
X-Google-Smtp-Source: AGHT+IHFdKzw5NH68XHyEiCdbiwMKDRkLvCxllBdJm1UClw0RzjlT/6YxQPbu8l9bViiRw+3UWrtAg==
X-Received: by 2002:a05:651c:2124:b0:2d8:3a46:8ab6 with SMTP id a36-20020a05651c212400b002d83a468ab6mr1894565ljq.17.1712934803774;
        Fri, 12 Apr 2024 08:13:23 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b43-20020a05651c0b2b00b002d82bbf7862sm528050ljr.25.2024.04.12.08.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:13:23 -0700 (PDT)
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
Subject: [patch net-next 2/6] selftests: forwarding: move couple of initial check to the beginning
Date: Fri, 12 Apr 2024 17:13:10 +0200
Message-ID: <20240412151314.3365034-3-jiri@resnulli.us>
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

These two check can be done at he very beginning of the script.
As the follow up patch needs to add early code that needs to be executed
after the checks, move them.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 4103ed7afcde..6f6a0f13465f 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -84,6 +84,16 @@ declare -A NETIFS=(
 # e.g. a low-power board.
 : "${KSFT_MACHINE_SLOW:=no}"
 
+if [[ "$(id -u)" -ne 0 ]]; then
+	echo "SKIP: need root privileges"
+	exit $ksft_skip
+fi
+
+if [[ ! -v NUM_NETIFS ]]; then
+	echo "SKIP: importer does not define \"NUM_NETIFS\""
+	exit $ksft_skip
+fi
+
 net_forwarding_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
 
 if [[ -f $net_forwarding_dir/forwarding.config ]]; then
@@ -259,11 +269,6 @@ check_port_mab_support()
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
@@ -291,11 +296,6 @@ if [[ "$REQUIRE_MTOOLS" = "yes" ]]; then
 	require_command mreceive
 fi
 
-if [[ ! -v NUM_NETIFS ]]; then
-	echo "SKIP: importer does not define \"NUM_NETIFS\""
-	exit $ksft_skip
-fi
-
 ##############################################################################
 # Command line options handling
 
-- 
2.44.0



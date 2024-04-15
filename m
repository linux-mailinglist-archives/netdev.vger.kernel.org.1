Return-Path: <netdev+bounces-88055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453608A57AF
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4DEB2109D
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D22681203;
	Mon, 15 Apr 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nf8xJFwc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DBA81AC4
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198354; cv=none; b=bkbUTdvzOhOfhxdWHp75AH7Pvinrr6XijxjI3bJfx/eKYZ17PJjq9kHp35KhDHnR5qb1bBehwYcIj0qL3OKrhTf3sBTeoJt5RfnmFzbYX2QeXlCnwiqKuJCCXRxcrloQ3g4GgRxMZHc7aPZKyposQ3b5vC1pNm4aTIwCornuGPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198354; c=relaxed/simple;
	bh=6AWPtYIUVkIYogf/lFsvz7tOLfgL9m/gvfqRIzDJe9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+zN7y7NfpcpP9B3T/zpjVeEwPrMWlwKKigEPG2PKFGp/xazEaBLQgEQzMx0jAkF3er+Jzd9FYHr/6uQCB+BtXQFOnDBdtGEIQs3wXrDjUgBHpe17w+s2wE6rWf5lBRAQM/oBXcpKxiuMp4FJahjkERkAMCthQEDwfuGRGJ23vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=nf8xJFwc; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-518931f8d23so2407217e87.3
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713198349; x=1713803149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VClqDAQzBaKyJ8klxTyXU7hsV/mjaxzL9AK6EWM/QRo=;
        b=nf8xJFwcVLcZwYwHTBSY7jpPr6Gy9RhfoIpwgNmlYVgOEnfa3N5TB6Uc1fYlhQmMgk
         gX3xdn1xkY6M5NZO/0AfjMQB4w0OQBRTLvcql16xgLK7duYdZXbSW6W5fEGqE8MLcRDU
         Hsyq7t2yrtyjfY9xUn1zwj5hxr7uLtCN9hxDwEge4z4+aJyZXXc123CujOF4A5OjliIM
         JeQ3D6bvWY39N3vAlwwQ5XLKB0o2aBOTLFFCe6qpuNGTI9YjxjrtNvrixydk+gzXwZi4
         s0faH7DTdHSA8/xiF88Znqiec0Akswi/yH8vuj6+pLNyx4hwSljGdxwRtsz3m3rGe1SN
         SEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198349; x=1713803149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VClqDAQzBaKyJ8klxTyXU7hsV/mjaxzL9AK6EWM/QRo=;
        b=GJUm5lc7X90kLHEyFh0EtFFt2Z5Ol6ZY50DXC/2WkT3SwjEsglsZhQyCPTgFkYHca4
         Ii6OcoY6GopXpmVBcpwqF1brNIiy6Ef741Skza++bRfgMj4GohjzwmaX3oHNbflXDDQy
         +zOUhg9VSNYGslejlJPQ9R4gsLI4AODkp+o069otgBUqWdFtkZ3IdooOr8Q+ivgygGFQ
         S2T8d6jj9OM+M33u7eD0lAkBCehCrls5Dj5MoEiD1w2zlLN43gM9srJWrdp4uPEsuaHe
         9Nk9Xq8/hF3jd83Cp6n3I3vwA/b3Xcv5Xo7e5YuaA+JxoWfPj8VyNgk/NSL/7F+fsO6t
         GHnQ==
X-Gm-Message-State: AOJu0Ywe6nPPaFyGhvz7q5jWcZGdpB9U6iK0AH1D/CbL1O9ymGifMAug
	q4Syfuq9itw/nDsg3olvkc8HXWWpHuAGGCkyiXlxS5R8eFCqtgPJMbHXUJ8nodDmRafE5tr8too
	5
X-Google-Smtp-Source: AGHT+IEuucDhgvoXqySP3PjfT1QnbG5b75B2FPNdroFY03N44M1rruzD375UtJNVfLZzTmoq8qHT1A==
X-Received: by 2002:ac2:520d:0:b0:516:c9a7:82de with SMTP id a13-20020ac2520d000000b00516c9a782demr5949139lfl.38.1713198349145;
        Mon, 15 Apr 2024 09:25:49 -0700 (PDT)
Received: from localhost (37-48-2-146.nat.epc.tmcz.cz. [37.48.2.146])
        by smtp.gmail.com with ESMTPSA id b9-20020a1709063f8900b00a522e8740ecsm4847924ejj.139.2024.04.15.09.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:25:48 -0700 (PDT)
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
Subject: [patch net-next v2 4/6] selftests: forwarding: add check_driver() helper
Date: Mon, 15 Apr 2024 18:25:28 +0200
Message-ID: <20240415162530.3594670-5-jiri@resnulli.us>
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

Add a helper to be used to check if the netdevice is backed by specified
driver.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index cc94de89bda3..254698c6ba56 100644
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



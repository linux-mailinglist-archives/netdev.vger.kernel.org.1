Return-Path: <netdev+bounces-227343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3CDBACC12
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D65EA7A8344
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06982F7AB9;
	Tue, 30 Sep 2025 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He/33/UP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835BF25A326
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759233642; cv=none; b=BY9iITURCpmfYy2h3ZtjX6iQ3km8r+EkIVIeAzRZfhdGw4FSBRN9TVJHhSpD2wbgucfs9gFr8Oqsh+KahlHnp1hQf/TfoS9LGtB3qtdunFvmnlZKNfnQ3daIqYrkfFK/OdwbYIQNljpLY4u8CbbpLufOdapLEeIHrVu4X7k+rsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759233642; c=relaxed/simple;
	bh=FabH5mN4zhLuKZr9se2KR/RjA3IMi9d2QCJpAU9/dIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gnl/7AExyUA/Lw7vVcvjl304hSf/FuudWLWggrnUxL8Cj62lLin7q2Imn+A3dcBSAfVV55m/tBpnD7rIkLzC0GTKGctv0rVik2m8Q6FXci3WrpQuy7YIYqqwrK9/jG60HheC5TcSB57pLxShx/x+eUfNcWR3++QGMjQYBUyKXn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He/33/UP; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so4937820a91.0
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 05:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759233640; x=1759838440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SgDDrNZnsegWRc2V1qujx9PuTP9rgoyvrSx11R8wMak=;
        b=He/33/UPPkJFyCtjMmul8cs6OIRe8pjT7+NpUt/PV8ED45vLHXV6g4Rq4js9TuOVXc
         jH13D/v7Cql6EmLaRSP/BaIBBDqYhdFHEFBm6EBxyXdVk8XsdP5WiesgRteEU5aZSWwh
         VT5a1GH15m4P5ME1xiKP+1ajjTu4Xyt0Tz18XmQ5dvzipmsONPkhIXLHubuN5mAEJL1c
         83sYv+UiVAFsjtjogwvcTNpRls6erdVI9QegasV+9urFdaM2arOpC7y/ZeuZwP1pVYEb
         11L49g5EtZqPgt6s/Q4MchKFGzp9TmL8tzA/48XmwTWWp5vzfk6diDLr9OZgCN99tY5h
         burw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759233640; x=1759838440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SgDDrNZnsegWRc2V1qujx9PuTP9rgoyvrSx11R8wMak=;
        b=GRnLP7ETnZqPEQHiTjJHV0ALzGcFFZvpcFM+Jh5fCauzdoVwzA9d5/pcuKe87zjKLK
         1/EoJILnXAoQCg9HkEPQggf0KmSqCYjLvA5q3xVFcIqYMB3RwKL1SB0EnU9cfP+430bL
         hcZrS9oRRSKRnR49OVgwIwupZgATTZp0wziGrxoJlI5G/QnnEKeo15VNvab4aVAJrkpt
         /uiuMxMxNXNtXnTqqDEGXdGQhgqUa4NhJ/LpPXG5o8m49e6kd8U1+Ar/l7Kb5N5c5eG2
         vit5iar+v2eQZe9wOoQUMzqC9apUzISoakt5SoLUW66eRAOdOH9wSPUhrqPkhVnDBd4j
         hweg==
X-Gm-Message-State: AOJu0YzBtUoZDxHoQ9UAmKoWD0Z+/NV3AuBjspqSvtP9l0xHue+VsT0G
	I+d+rhPaHibVq8zOtBEIvkNUmns/aiHwfX19kuiaq728zCMBQrwRm67R
X-Gm-Gg: ASbGncsO3FpqMOyqMN6D7f+Ig1zYaNQFhyDs0ip7Brcl17DrH+nkZwabNHdJJMCxYGm
	yPvPYniWphpFgzBFmdX+8ci2fhk9gwqQUcseUyHHjtrlqMEZYzkEVs1z+dnt81ewSD4c9Ayqy85
	BQEmxCgmYwkYRdrGz5gSQ5sLHkVUXgN1KeFp8JmqX9KZtI3OEescRR4cLN7M5YNXEz5KtqkEtjK
	tl2YEjRYR4gsngomb3lJucZGdIeiXkEB3olNPwgIYXop+DnwKpvwd2eI6EuCGp4bjX2C/LSaiDj
	WjC1uFCxASYERQpPnAwa5smake91ud6gz4P9nd5Jc3vdNcY5UWpMbD3AHsMyPBXc9U1Hm+9atFm
	SejT7kxf5wQEKXx2i3p0aap6T2wiuvmmiyygfdQucYaj/Nrn+VQVfTwlajre3FJI=
X-Google-Smtp-Source: AGHT+IF5xytoamoNNnFsGzqI3I/1zL8QxwW1vpNTaidF0bgHfcirdj8j2+a5eRIDt+HWn3cuLf8DSQ==
X-Received: by 2002:a17:90b:4a4c:b0:32e:8c14:5d09 with SMTP id 98e67ed59e1d1-3342a23718dmr20535324a91.7.1759233639182;
        Tue, 30 Sep 2025 05:00:39 -0700 (PDT)
Received: from y740.local ([2401:4900:1f31:e91f:2d6d:e8a8:f2d7:94ae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399cd190e9sm823160a91.2.2025.09.30.05.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:00:38 -0700 (PDT)
From: Sidharth Seela <sidharthseela@gmail.com>
To: antonio@openvpn.net,
	sd@queasysnail.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	willemdebruijn.kernel@gmail.com,
	kernelxing@tencent.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	david.hunter.linux@gmail.com,
	Sidharth Seela <sidharthseela@gmail.com>
Subject: [PATCH net v5] selftest:net: Fix uninit return values
Date: Tue, 30 Sep 2025 17:30:28 +0530
Message-ID: <20250930120028.390405-1-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix functions that return undefined values. These issues were caught by
running clang using LLVM=1 option.

Clang warnings are as follows:
ovpn-cli.c:1587:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
 1587 |         if (!sock) {
      |             ^~~~~
ovpn-cli.c:1635:9: note: uninitialized use occurs here
 1635 |         return ret;
      |                ^~~
ovpn-cli.c:1587:2: note: remove the 'if' if its condition is always false
 1587 |         if (!sock) {
      |         ^~~~~~~~~~~~
 1588 |                 fprintf(stderr, "cannot allocate netlink socket\n");
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 1589 |                 goto err_free;
      |                 ~~~~~~~~~~~~~~
 1590 |         }
      |         ~
ovpn-cli.c:1584:15: note: initialize the variable 'ret' to silence this warning
 1584 |         int mcid, ret;
      |                      ^
      |                       = 0
ovpn-cli.c:2107:7: warning: variable 'ret' is used uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
 2107 |         case CMD_INVALID:
      |              ^~~~~~~~~~~
ovpn-cli.c:2111:9: note: uninitialized use occurs here
 2111 |         return ret;
      |                ^~~
ovpn-cli.c:1939:12: note: initialize the variable 'ret' to silence this warning
 1939 |         int n, ret;
      |                   ^
      |

Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
ovpn module")
Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
---

v5:
	- Assign -ENOMEM to ret inside if block.
	- Assign -EINVAL to ret inside case block.
v4:
	- Move changelog below sign-off.
	- Remove double-hyphens in commit description.
v3:
	- Use prefix net.
	- Remove so_txtime fix as default case calls error().
	- Changelog before sign-off.
	- Three dashes after sign-off
v2:
	- Use subsystem name "net".
	- Add fixes tags.
	- Remove txtimestamp fix as default case calls error.
	- Assign constant error string instead of NULL.

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 9201f2905f2c..8d0f2f61923c 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -1586,6 +1586,7 @@ static int ovpn_listen_mcast(void)
 	sock = nl_socket_alloc();
 	if (!sock) {
 		fprintf(stderr, "cannot allocate netlink socket\n");
+		ret = -ENOMEM;
 		goto err_free;
 	}
 
@@ -2105,6 +2106,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 		ret = ovpn_listen_mcast();
 		break;
 	case CMD_INVALID:
+		ret = -EINVAL;
 		break;
 	}
 
-- 
2.47.3



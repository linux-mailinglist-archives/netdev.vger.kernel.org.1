Return-Path: <netdev+bounces-227201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687DFBAA045
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 18:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247633AB6B7
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F72130BBA7;
	Mon, 29 Sep 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig8KDxvO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8AE2FAC17
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759163511; cv=none; b=oKNa1Srl0KoRcKznt2jGYxui7Ch4tXcAuxP5nRaiYrI6FCRmaNa4Qw5bqulai87uTuj7AC2MPijXNzG7vgNJS4cv8F3BeTy22O4MH+WL9L2SKkob4Qm9rPuY+u9QxOq6LElJb6YrjJBJr9pHkjgCyDHwDsLQFe7Y55hydYqqe9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759163511; c=relaxed/simple;
	bh=nTErp6MjM2H9FJt5b0VdfDXyFtxk1zguj9gOTg/Op1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vj78WFPqW3BL8cTCYBFykucp5fClvMi0KbIaASpDTFJVqHn2g96yBCEX4gscBq4RWOJidQPdnWGAkyh3an74ILw7AoS83+M1TpUSQ4ipofLd5jgNwCVspJOUmZ4NGzDdJxdnPTjDayPoBLzqDeY9zOHxcjPQG4qE86xs7pOG+7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig8KDxvO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3383ac4d130so428976a91.2
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759163509; x=1759768309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lka4+ZyxLfYllS696TYLXMts9dTS83swxEi3cmvk4F4=;
        b=ig8KDxvOg2N8ygrGO+MRxh/HOl/sue8Haw+ylPPuB564h0nVSAKa/bjPrWHhmt3Cdv
         ZDTdp+QyLn/lykIBpJI8m43f7p9M98JyyboaHFGYLXSnsP45JCmAIPFv/QTMSJZIqU0k
         CITqCeurdTd/d4Ap/ArWbYIXhmD83GU6JPvRsx4bNWC8PGkxIAYApmH01ybIM2303SJ+
         5njQ8AbGw9ry2Q82uy76+b/9OEfIvOIiHQ0WKhM2UPBB9VDBrMLd061fSreNT7eE0VHs
         lDHX2Bjnd6ZRRQWN42EEhI+AyaSBxKraXS+96NBtvIOAc2tY3TC/dFD2SCwr0XJUSOdC
         GAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759163509; x=1759768309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lka4+ZyxLfYllS696TYLXMts9dTS83swxEi3cmvk4F4=;
        b=gccWX+yAlu+ZDrD5r7rl/DAWDUIxYMymV1T3G9gZbPtK9TpC66c/pfHoBfyTyctUCp
         luD+yPxZoFPcr4dHrFr23C4gxtO3MZ+DSZu7F2dYcVIZVT72CZzuRxwDX4CAQ4ayQF/n
         5YNzHR+KIrU8MxVMNTZk3hdDO5T2D3AP1vJfglvP0H9ouWnoVpywTcFntAslJNQb29q5
         pKEuJIYIv1N816c0a2KCHu96gqzTpkNZrtmw3s4dMJ2olIdJsFHuz2/B2Hrfy21YwR/c
         xVGyA7oc54K8QuLttuwqWAlrgtW+x54rPj8lbC378pRu3jRd1SBA4SkvKNLexFLlKqtK
         mujA==
X-Forwarded-Encrypted: i=1; AJvYcCXEy4IX2aZsZvZ32soyNfMUTHALFAwPStDZZ287Pimz6N10S76prBvSj0SVa4eawvnJRcc6RMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJoeQlxKrBbidfTrK4OCIYq+2HylF2SI91p98J1qTozxinjlH
	QLrEc9wvhRRX53rg/wO3umO3c1qpcj4bUWf5dBvTa4yo1wMTEM6asPHT
X-Gm-Gg: ASbGncuwtbqDJBisUWnAHd0HzGHQhbDdSTVip0lAd6jYvrBPQExbNMf1TgFeFgAGFiA
	nKa4GlTpMIQ73epqsnPdOMe0obguoxOh5Jsr+J7L0rxkm8zonZtaM+k5i52cyXmlMBDvVV+Rq2/
	nIgSPUfdRDumHes7b9aoGrv2AUJffqQOunzXTKgggE8Vz+ZFSKDWGQzWrc5wZAcVLyMjDf496Uw
	pgFezOI2JxWkMn7j3ks4pf7o3JY/D8sDl5jCHN65vYnrk5hfEjgcBnc2oM7CQnfkVYn1BBtVOXn
	zyBcbvIYqOqXxunMOb6opC6XjWLw/hSqyjAAkkCuQRVu/pJYcTkLwM2/NzYF5Lqpe/8MUJ8IBjL
	ZHeMjYf8yBWpU+ePHCds8OczNXphYgvhQ4H2CmCzEyvAbPlMN2Ixi
X-Google-Smtp-Source: AGHT+IEZeT16n1Qx68AceriYoS2m5DQH3UD7/ggp2pq32iz566aW/AJGDTJkg6J0/p2eGeMqMpos2Q==
X-Received: by 2002:a17:90b:350c:b0:330:6c04:a72b with SMTP id 98e67ed59e1d1-3342a2498f2mr18362711a91.3.1759163508737;
        Mon, 29 Sep 2025 09:31:48 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bd90327sm17674419a91.3.2025.09.29.09.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 09:31:48 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH net-next] selftests/net: add tcp_port_share to .gitignore
Date: Mon, 29 Sep 2025 22:01:38 +0530
Message-ID: <20250929163140.122383-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the tcp_port_share test binary to .gitignore to avoid
accidentally staging the build artifact.

Fixes: 8a8241cdaa34 ("selftests/net: Test tcp port reuse after unbinding
a socket")
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 3d4b4a53dfda..439101b518ee 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -52,6 +52,7 @@ tap
 tcp_fastopen_backup_key
 tcp_inq
 tcp_mmap
+tcp_port_share
 tfo
 timestamping
 tls
-- 
2.43.0



Return-Path: <netdev+bounces-127163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E15974714
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4831F21034
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840AEBE;
	Wed, 11 Sep 2024 00:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVXvPCSn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AA0AD24
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726012921; cv=none; b=Hv7wm9N6RBTUfCpzeydbp7ut1M0PrcENql74rCG2hFmws2Rn7JvgURh2wCipKrAuO05YxSdEC46tbXZyT2+YyNCLafuXJIlXXx1V7E1m04Aoup6Vy/IFCEb2VKWf1szrL+ISkoctwKaGg6FuBwBuJskNMnjQMRuzaQveuWdSZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726012921; c=relaxed/simple;
	bh=dUhN8bSMlm11irM5ayNAJ66DaeiK6RUaLOfkAAuc/Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vCBe9+qSkLXUnyJcpKgQKu2+EAMG6urhibz7Twfmq7joQtM3y+NAKwfP3mrPZXCPW19tjeXYo6sKNxaDE/98Iu+vKaZniI+5WIA/UvK4P4xUDDh86SyL6HvMu9GKc21MGEt9wpsyas8TAF3Te3IdXrofgmbXl7+VLq4F5R3H/7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVXvPCSn; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9a7bea3d8so105183485a.3
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 17:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726012918; x=1726617718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHgPAowhU6S0FzK6dYFry4g5jmArIymQsMazZpOI2io=;
        b=JVXvPCSnzRMiAJCUlQ1W3NVwuT61Q/rkkosa0cWOLMHysERhzdSfZfqFEwCeeUw4cE
         qOpDySZOksOg/oOo220sBNNlYNVy4YYQk+DtMH2mmz2iL8e6jJQ8TUxuYQKkZ1SbIKVZ
         dviLYqzoqlJIpRtJWwnsB7pOGaxgHJ7SmFMyjv+KXhBcDo0hgIZ9i5NAZwly7Ex5V/Cu
         wSli9vJcGj2VtQrxCtX4+r2cc90NW0VKlSN/4YH7qaD6ykIWxR0fK2x268yJdvx0Pzoj
         OBdXBo0xsHBg1InJX20f8u3vjLp3Bzmw5EoQPra+OT98AWH68zQBF4Dr2b6H1iHMmC0Q
         hptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726012918; x=1726617718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHgPAowhU6S0FzK6dYFry4g5jmArIymQsMazZpOI2io=;
        b=mUXmLThIvNnWiOSuEtopZExPUiq+tKUJsjzVz4X54rYRnDmJdrvns0W8dSYHCZhgDm
         bPWYI8idIa4cHMDwV+yKsQiA9RDU+izK+J+fVwrEYuuU517ci/cojcNzpad23Q3AazXJ
         0w1+IVHcgH0Bs9lKHV+HcNTMcFTnrv6pG4ZPFetu1pOYjNoR1/9ZHOmmlEJLDByPdkDw
         jawAZY9HhOle2HFE8lQhSBg3qqbNgv9zj+wTFHrqpRHdGPhOWxRiVGH4jRr4KzErN/oJ
         WxnApOrd607k02EuxIIqf0s8rmYqVjhLEF7D6g9MrGbA/hiBg/XxCMaCAagn/UCn8Kys
         iSkQ==
X-Gm-Message-State: AOJu0YyCsTVUJ+g370Y6n2WuJ2g4sI6OiQUfzx3XVTZvalzuGxSYymv5
	KItsvkrU/7Gx4XgqGFNVaM3jWrJQJrb6EI0eQvzY41Oeo9+mcL3V16Z7Sg==
X-Google-Smtp-Source: AGHT+IHEGSvUj6sa8hxWYaAJXdIUrQapFECF1lTm9MkHiJfMvRPJfY5qBzHhQbFCA0CBrgsIzo3dHA==
X-Received: by 2002:a05:620a:1910:b0:7a9:c129:4e84 with SMTP id af79cd13be357-7a9d3d379f2mr232518985a.45.1726012918128;
        Tue, 10 Sep 2024 17:01:58 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a1d652sm354705785a.123.2024.09.10.17.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 17:01:57 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ncardwell@google.com,
	matttbe@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 0/3] selftests/net: packetdrill: netns and two
Date: Tue, 10 Sep 2024 19:59:56 -0400
Message-ID: <20240911000154.929317-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

1/3: run in nets, as discussed, and add missing CONFIGs
2/3: import tcp/zerocopy
3/3: import tcp/slow_start

Willem de Bruijn (3):
  selftests/net: packetdrill: run in netns and expand config
  selftests/net: packetdrill: import tcp/zerocopy
  selftests/net: packetdrill: import tcp/slow_start

 .../testing/selftests/net/packetdrill/config  |   6 +
 .../selftests/net/packetdrill/ksft_runner.sh  |   4 +-
 .../selftests/net/packetdrill/set_sysctls.py  |  38 ++++++
 ...tcp_slow_start_slow-start-ack-per-1pkt.pkt |  56 +++++++++
 ...tart_slow-start-ack-per-2pkt-send-5pkt.pkt |  33 +++++
 ...tart_slow-start-ack-per-2pkt-send-6pkt.pkt |  34 +++++
 ...tcp_slow_start_slow-start-ack-per-2pkt.pkt |  42 +++++++
 ...tcp_slow_start_slow-start-ack-per-4pkt.pkt |  35 ++++++
 .../tcp_slow_start_slow-start-after-idle.pkt  |  39 ++++++
 ...slow_start_slow-start-after-win-update.pkt |  50 ++++++++
 ...t_slow-start-app-limited-9-packets-out.pkt |  38 ++++++
 .../tcp_slow_start_slow-start-app-limited.pkt |  36 ++++++
 ..._slow_start_slow-start-fq-ack-per-2pkt.pkt |  63 ++++++++++
 .../net/packetdrill/tcp_zerocopy_basic.pkt    |  55 ++++++++
 .../net/packetdrill/tcp_zerocopy_batch.pkt    |  41 ++++++
 .../net/packetdrill/tcp_zerocopy_client.pkt   |  31 +++++
 .../net/packetdrill/tcp_zerocopy_closed.pkt   |  45 +++++++
 .../packetdrill/tcp_zerocopy_epoll_edge.pkt   |  61 +++++++++
 .../tcp_zerocopy_epoll_exclusive.pkt          |  63 ++++++++++
 .../tcp_zerocopy_epoll_oneshot.pkt            |  66 ++++++++++
 .../tcp_zerocopy_fastopen-client.pkt          |  56 +++++++++
 .../tcp_zerocopy_fastopen-server.pkt          |  44 +++++++
 .../net/packetdrill/tcp_zerocopy_maxfrags.pkt | 119 ++++++++++++++++++
 .../net/packetdrill/tcp_zerocopy_small.pkt    |  58 +++++++++
 24 files changed, 1111 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/net/packetdrill/set_sysctls.py
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-1pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-5pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt-send-6pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-2pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-ack-per-4pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-idle.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-after-win-update.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited-9-packets-out.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-limited.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-fq-ack-per-2pkt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_basic.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_closed.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-client.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_zerocopy_small.pkt

-- 
2.46.0.598.g6f2099f65c-goog



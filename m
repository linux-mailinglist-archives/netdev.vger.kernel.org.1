Return-Path: <netdev+bounces-285970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKUtOoZK/mllowAAu9opvQ
	(envelope-from <netdev+bounces-285970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:41:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 592EC4FB907
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1E56303258E
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 20:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654F23FD14C;
	Fri,  8 May 2026 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5Y9zmhc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F82C3FBED4
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272877; cv=none; b=ucOHSl4Kj2Q+drz9NnE4HHTThY2jAIS8ICB0UK4uKShC50RS444ZB3wpFIaDZS/kcfOujvbAbz1m69Luo10cFIEt+oGJrL0PYVyJ4r0JPeZNeM5TVjrmrGu6hrt7/wqaoe3m/2hDAeYKfQDVNmyEXglib7fUvVQfb5199s0TFWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272877; c=relaxed/simple;
	bh=BHxEIpMK8G8BcTyV+NZcQVK4IvHRt6K56iJzLlFCnZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hjAHnKyzLNG37riNqKAtIjh+zCkEn4cMYx3rcjbpBySGJ85MHuh7ZcmhZWWYqgaYIkxfcrsVpINSHwiP6lj0iEsjqXTvp252oJUD5k9TngV2JCJdNVa8FTAs1+/0CmlAYEmnrDzGf8gYd0Imnhn3fGE7ieC0rMFW7ZkVbrBMwsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5Y9zmhc; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-8354461da74so1216080b3a.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 13:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778272875; x=1778877675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNTn+4YV7+x6NLzvMwMCcxWiHzIYGE4tW6tqc6ZT6No=;
        b=l5Y9zmhc+QIu2o8LxzpXiJ3+Q7LC36NnfffwOTv0oY7B09cuwBK9JDwYQtc9S/ZAd3
         UtTPuFw110UdRX3RdTrQlISsWBZQ6nXTmVOzpqRj4sdUTA2FIzH2cdqjNw3C1yL2a0Nz
         UBbMzhMu2M5LdhoIwwTj3PKi5Y6nhtHcsknurf2QGMm87yyLRjQPpQou62j3M+ugRMpD
         dvpkrFeSBAGiAUZ2G632Fhr6qXg15vhgtvk5bPLs95syCuo1/SUaSLz2WjRmRcdMXk4V
         J4F72f9jG9bQJO1M8Vav7EU4MwnHDS3c2DFJMcXtLw4aGy2dKnlzeZLvvVyaO2QNnuGV
         jLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778272875; x=1778877675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNTn+4YV7+x6NLzvMwMCcxWiHzIYGE4tW6tqc6ZT6No=;
        b=DHGoU8tDXKWaN3bRHDhRned0YbpF/T+d5GwpqfyiH+fitDSSp7T64BRFhoNIZrr1th
         OwoNDPqKrbHkDpzEnLJwAdltP6WCH75SCGR9Sv6e96yzwCvatH1BsfV9KXdL+VhgX+6W
         OImY64SEnEsTLcxpokTlneguXvnwRIZhP84X8jQXI9TTZih3TN/YvZbRP7iGcV1kMpBh
         D4VPdcTUKEgGTo48dUCy+9I2ZuP7yr/rWS2Xd7+EaaFIiazWFsH4ICRdX9BLgQJ0wHu9
         nhiCmY9motwCkngk5EcdtHw4godXsdUhMO2++DY+8l5+6diPO1vvGRlI2hnj5+oV12il
         fBeQ==
X-Gm-Message-State: AOJu0Yww1oDBmcmzoBGAcrUxr1oQiJVpFQDze1kECPHAt+CSOm3zKi/F
	f9En9f0CavTC+Gyb5ORb8vKQN/KcqlnflUPNX4cHBAldlnygkWKYB2kKMFl9RX18
X-Gm-Gg: AeBDievik4oafhvTGSlcvR4cqnenbarjf8mBvGQWKMBwAyPfi7CH3Q3uJgfYMmprqF0
	qHAqXFtYePG0ArG41AzKx4wLukt6woWFggYF/wOfSjt/n64fp279asOnmBqxzRRhdJkH7hTTKcW
	Y675r2/R1EvILH9DF7a3EYP7MAaYxtaCQs2jjtzwRd9sQgJT6XCzgY2zDizqcQUh8nmut7mJpmN
	Ovk/ThUlX9RSQvZex1XTg24zBL2Splfj3t/ZiN1wgz8/X1zdF9ZD0BIHVvqMbH9wUMc3gPKSx+B
	QbYpCcu7XFuSJ+AvcS29upHuvf4qf+zQD+yPkGq+V5pmXbiFqBNgOi9/JDrhqRW1fNGeRyO3LE3
	gFOTdRNO4CqvudNs4ce6b8t6leyvav5SEeVE6KPs02spi97ijseV81f+RIyHuKljzB8UXY+FTOn
	3LsA6JUDRT0szZBad+
X-Received: by 2002:a05:6a00:10d2:b0:82c:6bcc:f3fa with SMTP id d2e1a72fcca58-83a5e23c9abmr13338999b3a.35.1778272875408;
        Fri, 08 May 2026 13:41:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:59::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8634sm15980813b3a.39.2026.05.08.13.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 13:41:14 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	horms@kernel.org,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] tools/ynl: add missing uapi header deps in Makefile.deps
Date: Fri,  8 May 2026 13:41:12 -0700
Message-ID: <20260508204114.205896-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 592EC4FB907
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285970-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When syncing ynl-cpp to net-next v7.0-rc3, typelimits.h (for ethtool) and
dev_energymodel.h had to be manually hacked into the downstream
Makefile.deps:

  https://github.com/linux-netdev/ynl-cpp/pull/16/changes/94bd9656423cab7dfce73dc824f75b59ef25668d

Fix the upstream Makefile.deps so that downstream copies stay in sync.

Stanislav Fomichev (2):
  tools/ynl: add missing uapi header deps in Makefile.deps
  tools/ynl: add check-deps target to verify Makefile.deps completeness

 tools/net/ynl/Makefile.deps      | 39 +++++++++++++++++++++++++++++++-
 tools/net/ynl/generated/Makefile |  6 ++++-
 2 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.53.0-Meta



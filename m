Return-Path: <netdev+bounces-213775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BBEB268F7
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA57A17EEA3
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2851E217F2E;
	Thu, 14 Aug 2025 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZx4Yq0G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E110215F56;
	Thu, 14 Aug 2025 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180209; cv=none; b=KKw50khDsnl0wY/eKm6FY2Nl+2vC65wsK/FkNl+6ImUNCNYgwflQWxtlQN+Cc+TEEH+1TuChLzClF3SrrACnbTMOo6An3948RRFMxqbVvbRHWHxi9ERMkNCInabVEZrJPPJFTs0ZYaVr8knrm1jLdQzoiOF2pTy5RwyiUCzgtNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180209; c=relaxed/simple;
	bh=tgwFBs9CvhsXnmD8b9d9j2xIVffo/wub6CS2aIbkwWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oS3YZuKHOSEt2Sl6dJQag/pJ/uTqaByQUuF35HcVxEKVWfbEmRWR2RXV8asBsehd0WF/8sSgTis/rmQA1FOuI1j/78Gz8NOwUQ2L6eOlw2LOQz0fkLV5l2yB2Gdp+tcfPZCylGINQxjVs+JadBBcu/zfxZzAdejSXf2Ae2yrkYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZx4Yq0G; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so7320945e9.3;
        Thu, 14 Aug 2025 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755180205; x=1755785005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9hLQCJaAQJVAvgePrFkZE0v0bAb94NAnHBS2z3x3jL4=;
        b=GZx4Yq0G2eondzoodh9rzTLMNqcqa9Hw6HLFSN/PDhCiiPtONjotYselg5yT7vAmC2
         WwBoW05W1P7vfWSCcYFUSm/rU2rwc0dRHHcFsKAH7kE6ecOWhVbSdK+MrVF140vaAYu2
         I84oF92C+LmksgxZEC4dHiWkYlKANYqbpQ6VBt3dFhDHpmkaOxyEdS5A98a4splAdUwp
         AKebnn5TPxcjcPcnFL0kHSTYkORPTqz2dEr28wjjoQIgC3dontkbn2xFxMHeK17Ksk66
         YYmBScoCLQG6y5phXsqgeDxZjqAWZkKmM/BxArsvbY5cU2U89filhUKy1hFvjTilmRMD
         3bMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180205; x=1755785005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hLQCJaAQJVAvgePrFkZE0v0bAb94NAnHBS2z3x3jL4=;
        b=aHzwEP+ZdYOhgpnotqonB8me5tit8VN+RLTbDc0v916t1duYJD62fanjSQVrLQ29cA
         XPtZajM52eakwsDZQTJei32Zx9penNLAzHU6KPPi9knN1SMd5wSSzlp+Dj3lUPgPrP+E
         7Mwj/BxsbkBCQMio0zwQRizBTJAnoUjQPr9aD2o8mXwLxy9kBrR61bdIjBQ0ZEshJ5PX
         Rt9MYPGOd/Z3UgccG84S2JGZ6LB4nKfuj0xfduhIQYfbcyU5nKFtE8/GgoDf9tuQ4yiY
         LUBSSMhRS8zcqlJhSNDpaoOdhI42Epi6uW5A4Fv1x0/kQhGzNepT4OXI4WlJDKoSlVRt
         xMsw==
X-Forwarded-Encrypted: i=1; AJvYcCWN/LJmLLqitEeUbax2UevvfVNjCbEzB/KSqx78wsZ+EhFaUMHSBZyls6FCvyHKM0WYtkBtPDyWOSR0J04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEdrvVFB2zWBraXG0M1HMOhiDwIpTLHewpMt1T3BK7D2Z/v35E
	hzPlXomrCwfBnOsr50jBjkau8AefN69qily/37tjVEvDjO7q6gncFvOYmr9M4A==
X-Gm-Gg: ASbGncsUZaGJSlTqNHNOSO3DizUXaPVCX6aYO4KDIwj3RSmgu/YwHCZ3pcPvHPEcwjp
	uGpcdecUsnREN/Br0fLRyw8l13U2Z+2qst2D5n6/MsS5ImNxSm459zUqSeNuFQD9bNbKDQ8fnsy
	mjie4/G/lW+2Sach3hHSJ/s5TAJwvcwwRHafSMumijDW29Hy7LxWwyGJfvGqko07i91FVjFIUTs
	sDzmWhTAMTZzjIzV9aEeJwkJcqdXSM71slmtUQhXfPdoLppjx7FtPczbdxv0WITx+MVnUISwsx/
	xQKysL91BRNbdHBLjx10rYb5PbofiXi31QD0KQ1uhnpnzqXlmMhinVYfqC+6DGssubsNgXFYuv2
	XEo1FiDzONz7TgCOzRzk4
X-Google-Smtp-Source: AGHT+IFDzfdtSmwEGUzTN8rD9wyLg3liPVjHlRx8xwcdRW3o/TEDOCKuaWpUfJySxaH2eHjl3OEOow==
X-Received: by 2002:a05:600c:314b:b0:456:1a69:950b with SMTP id 5b1f17b1804b1-45a1b646a68mr22827725e9.22.1755180205098;
        Thu, 14 Aug 2025 07:03:25 -0700 (PDT)
Received: from oscar-xps.. ([79.127.164.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6c2e95sm22483085e9.6.2025.08.14.07.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:03:24 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net-next v2 0/2] net: ipv4: allow directed broadcast routes to use dst hint
Date: Thu, 14 Aug 2025 16:03:07 +0200
Message-Id: <20250814140309.3742-1-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, ip_extract_route_hint uses RTN_BROADCAST to decide
whether to use the route dst hint mechanism.

This check is too strict, as it prevents directed broadcast
routes from using the hint, resulting in poor performance
during bursts of directed broadcast traffic.

This series fixes this, and adds a new selftest to ensure
this does not regress.

Changes in v2:
 - Removed unused variable
 - Fixed formatting
 - Added new selftest

Link to v1: https://lore.kernel.org/netdev/20250724124942.6895-1-oscmaes92@gmail.com/

Oscar Maes (2):
  net: ipv4: allow directed broadcast routes to use dst hint
  selftests: net: add test for dst hint mechanism with directed
    broadcast addresses

 net/ipv4/ip_input.c                       | 11 +++--
 net/ipv4/route.c                          |  2 +-
 tools/testing/selftests/net/route_hint.sh | 58 +++++++++++++++++++++++
 3 files changed, 66 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/net/route_hint.sh

-- 
2.39.5



Return-Path: <netdev+bounces-160728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18534A1AFE4
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 06:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6702216D688
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 05:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E42B1D8A08;
	Fri, 24 Jan 2025 05:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ONZ0oqjz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E21013A879
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737696798; cv=none; b=TjltZqgSW/CtVg7584bhKeSQUoylgf6MMZ7gZDhoCNVXxPfQMtUO73my/U0eysWJG5yVkwSx5n8cUqRnk18aXTG6V05Ghaj7dnvkiv8r3ZTgwjtLylAnBATrPAOzCJYGRDJValSM/7+r6dPeWT1uEs6WL0RVexhB833Xn1hZ81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737696798; c=relaxed/simple;
	bh=kfxJO7UryXOc2hUzcpX+Luo/YsLXqyKZVOcrkmyU5fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UTm0d8OcSH0cnFzWkv7zh1VMfq3cFlYoFERkIlrXQsekEILC+qiusWKskG2u1Ec6t/Jdo/ED74CRSmiJUQ/dslmIJiqEfl4eXBNaqDwODzz48y6CREfgrb+eoicInSHcAP0yFj5l/AlTSbcslrldCqiKn/IcUavhgmJ7TGUJlhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ONZ0oqjz; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f2d8e590e2so199016eaf.3
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 21:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737696794; x=1738301594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p7CHOhjlbqLmPqr3LdrpbxR4OF4uKkVOK28XhR8E+RE=;
        b=ONZ0oqjzh5RC9q3gwlhxGKy+Kmb65T2taJq9+iVQaEnKMRPXmHqw77mYGeKIHKwlP7
         8uhZSZmLaIv0H95X/g3ZngWla53LjqSONUgOEHwgfDb+kpdwkGxPvarvJ0Hhh15f/GL2
         TGLAI13Qqr0hLz78kmMgc3bvOxKtjkQGnmubg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737696794; x=1738301594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7CHOhjlbqLmPqr3LdrpbxR4OF4uKkVOK28XhR8E+RE=;
        b=kx7OfFDS40Uk6JUEmN1Avd7EXX1KoA01T7AL79F0v9hjFITDYq8Dp8f9HQyR9ilgX7
         hPMs4Mwj/j64Jmm2ub3fud9dXr4M6EJet0yenHBpBVvgNn0dmFHIMSD/Sobp4UzKXhbj
         AMknUKw9+07BuyJ+XCudwt+esabkYsAu2VzGY0UaZ9SgV9MAjPJYcU+WHElflgiGqExS
         jr44f6VftggIWSemCg41RdsIG5o7SEq9KytWAvy2bhQBrQx77Hy/whW+hgMC0aPS64kj
         ZpklrVKlJA6BZUvsfjo+D4S89Gw/0Woul48RggFprEl0YFy0O13wXPULSBXKZddczLCs
         bN2w==
X-Forwarded-Encrypted: i=1; AJvYcCX+81bl0CkexFNaJcnnZRdwFZGNNc8tuhTrtxDP5a7nizxxfGYeyklQgxoAIaEshgf+hLEfOUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxleTC8D8eOcx31n2p7GKvYI+d4/taxAa9CcZmKycTIn47oxUr7
	FZtSq4015XpHVtGnvyq2GAO2ju9c9/HrToj+sUCsJ00qFz5jGadejX1IegKoKA==
X-Gm-Gg: ASbGncsflgroffJAGPND/t8npUvgUGIbIOr41LODBCw0Aamz3fKhf1EWFa7mJailGJk
	wWDIvsQw2KDANbqPW9n7DDdbGhcjqW6k3ukO8e0HABUEZ4vymiJ5SU+bMMTEL4dMqqjv2PCJVPs
	TwyNEmrTGBRa+qJ6wLmP0dpLiU9gPBTREZDzqmuW4nqK3MJG9UHHjoVfn5Sv/K6o40gfItFymoy
	H5BDM4yGA2MUJxO0Avbm29+2iP0ggDPqvIYR0G+UZATM80J3s/AssnxnRLzr+nbD7K2leYb819w
	/G5H0mXRGaNjoE8WJXWby+Kk1JrlE4RKHS0Y8NIyt7zq/q5E
X-Google-Smtp-Source: AGHT+IGQxRrOihs5beELdvoOVX38HRb2136cNTduZLSSsPZwJtu5RxrcKh5Os+r1YzEkrCqDpPxjCw==
X-Received: by 2002:a05:6808:30aa:b0:3ea:f794:a5b with SMTP id 5614622812f47-3f19fc08ac4mr6705396b6e.1.1737696794267;
        Thu, 23 Jan 2025 21:33:14 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f1f09810f7sm270795b6e.37.2025.01.23.21.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 21:33:12 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Subject: [PATCH v2 v5.15.y 0/2] Backporting the patches to fix CVE-2024-35966
Date: Fri, 24 Jan 2025 05:33:04 +0000
Message-Id: <20250124053306.5028-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Diff from v1:
Adding a dependant patch [PATCH 1/2].
Link of v1:
https://lore.kernel.org/stable/2025012010-manager-dreamlike-b5c1@gregkh/

Backporting 2 patches to fix CVE-2024-35966

Luiz Augusto von Dentz (2):
  Bluetooth: SCO: Fix not validating setsockopt user input
  Bluetooth: RFCOMM: Fix not validating setsockopt user input

 include/net/bluetooth/bluetooth.h |  9 +++++++++
 net/bluetooth/rfcomm/sock.c       | 14 +++++---------
 net/bluetooth/sco.c               | 19 ++++++++-----------
 3 files changed, 22 insertions(+), 20 deletions(-)

-- 
2.39.4



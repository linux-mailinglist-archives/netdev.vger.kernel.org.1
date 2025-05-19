Return-Path: <netdev+bounces-191634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5923ABC891
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 22:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A6A1B64809
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 20:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C679218AAB;
	Mon, 19 May 2025 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L/VTV3Je"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A8BA4A
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747687409; cv=none; b=Knk1HXUPlwXUdlQ1nCquUWe0E71yHuMyRquRZI0JIxfyl1Sg8I0zLIFTQG+HFSzpJseCWJCp3va+GZri8Q8CmtKEh6WSMfCvX+5N1EK6Y2uA5SIN0jq6KN9wbd/SVbJWxI90bIfvRLphlXsWZiriDiL9vVOUjlKU7saThG6W1zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747687409; c=relaxed/simple;
	bh=j9UM7DP7yPQXNNbj4aJXBC48IUQSw7S1nvb9R6K4/4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ilfh9TZO7uvUhNkiimA9X179oTgrcMH0LqilfBhqEXvNE7+0mKKDezOJv8rOaWLSsF+aZ+wWwswP0mMgAJ3y4xqleoIXypgAas7WFF/7WKAgBa8WVWmbTdbehco0diQOef+cLBmS2pxZU8vHhohvQ7RKloGghZJPjebhg28mjmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L/VTV3Je; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7426c44e014so5080050b3a.3
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 13:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747687407; x=1748292207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSbfqE2wlB1dRVq05K6sR+N8ZhydxB6h3WK0/AECkLg=;
        b=L/VTV3Je1PqlUg41po7IhMXVTI1SYP5jk/OnOZqZggc6jBPhIy1RGx8d9ntJyYsiST
         NHJc7zskLkU6giFcOVE7qHcpmkxkoQ+kPyvCQbHPdES4J0lpjsxXzoEUa7wMsVwbMdsl
         TRta0ubLJhpltYtBGIdsuCdK/65bEScova5mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747687407; x=1748292207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSbfqE2wlB1dRVq05K6sR+N8ZhydxB6h3WK0/AECkLg=;
        b=gMy1uakWqziNxtOzkxXjirN8GadURNBiCeyHVZ5uldQZyfRIEVrIyF53Y2TYQlM6ff
         +v6EF1rUnOsCRmCswc1Omjg86PgkmBenH/uzNcq9oD517seH/39aH6dxtQzwlkUKwRXt
         V2lYzA3cumj4zw0q7GKA1hLOsfnG9Kgp3BIDGOogC8gonRK34DO6g2Mx6N90H5BlvLBq
         3vcdFdYQzqZrlVtjiFMbB0AaZyRAaDupBpTvmUggVyqKx8+6T2n5ik796hd1iYxF/CpW
         MHYXjz4NL8fFQLAtcWEuJ+eKbnrE5aHvi/iyyshS5r7KXTH9VyvZrG096/DhUKzkgPew
         OQCw==
X-Gm-Message-State: AOJu0Yykkg+vxm0l56X15wnSTuHzAKdozFQhG9DyGtv96wDJDm29mrSF
	/EiuhEp1Lc7wURDGKKyHswJpv3Nv15bel36+NVb7WtzarAP/8GuE7GNeS2Hye39lDQ==
X-Gm-Gg: ASbGnct4WvA8QGDxuy4JCoLBY3sBZs7TG9EqVAHJywICd9MEL+RL21SvHij06zsMN71
	AF4Vl0zArpBvLRJg/ToZSRQZt/25QSwn4t4UB4mvG6VvZgjoSmRPMOb2zbYvnEqhiEZ0nxND9tv
	MGlSUfpTOhT5SEF8zK/jnJn3eCOevH3zgEI5VU2CQg0vw3smbze64243HR+vK9n3bLuGsKwNF3L
	oG8D85M8uy8uLUwe/m6ro1Qzv+ahXXWnV05oCUgdbOGkF/8mMzM1tubgNnpGVLrGiFEsYha0O0y
	zB6msPc6U4+H27xMHD8E0GEArfY+shNiWh6TEX8ZIy5juIKhbpOCq3hzCjogjpyshSJtdoEkeDl
	JcS2JZI7b7RvCs7qG2Qcrtlbqxqw=
X-Google-Smtp-Source: AGHT+IHfNxMm/EaditDTxKhP6gdu10YKEKevTo8LK1FyQzb8P5Z88XEWaWH8G9G5uUwOkIkNJKSSEw==
X-Received: by 2002:a17:902:d4c8:b0:220:eade:d77e with SMTP id d9443c01a7336-231d452da59mr209216305ad.40.1747687406921;
        Mon, 19 May 2025 13:43:26 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4afe887sm64190955ad.88.2025.05.19.13.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 13:43:26 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 0/3] bnxt_en: 2 bug fixes
Date: Mon, 19 May 2025 13:41:27 -0700
Message-ID: <20250519204130.3097027-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is a bug fix for taking netdev_lock twice in the
AER code path if the RoCE driver is loaded.  The second patch is a
refactor patch needed by patch 3.  Patch 3 fixes a packet drop
issue if queue restart is done on a ring belonging to a non-default
RSS context.

Michael Chan (1):
  bnxt_en: Fix netdev locking in ULP IRQ functions

Pavan Chebbi (2):
  bnxt_en: Add a helper function to configure MRU and RSS
  bnxt_en: Update MRU and RSS table of RSS contexts on queue reset

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 59 +++++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  9 +--
 include/net/netdev_lock.h                     |  3 +
 3 files changed, 52 insertions(+), 19 deletions(-)

-- 
2.30.1



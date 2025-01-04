Return-Path: <netdev+bounces-155119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F17FFA01245
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 05:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71CF37A1EE6
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 04:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566E8136347;
	Sat,  4 Jan 2025 04:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QiANLlgt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A727F17BA3
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 04:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735965570; cv=none; b=Lq4dNoJnNgkNYVWrL2a+euQ3NYVar/n0QIX4Nzu0HCyhwgiIZQC9CwfYmJImHxR8GMnJe4nox/T419/9USTIE1kxBduO/XVFrjtg9YocIHX5cQUg6r1h867S+SV1lYSsh6o0LqCMhaC5d2omNelUe/nCCOJy8e0wKCkNYPUP/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735965570; c=relaxed/simple;
	bh=T//eiTDV7sExIe1rRAKjA4AOIPeytBEmt6fZiJqEIks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nPg3ZGmlFBWVSsfhenNYxXjsmLQTvEHDf8GUF0xBNW3K08Z59dMW6PoZObCpn/3fohsVHXxokNfh2EwGZrWpDsIMhGDR993xdsaZn3T7/uBK5vo9kSkReLOlw4lpiGcVgr+lM/DvDGOD5AOYuEW1pwudSpsuOp5fWa+O7Fy8+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QiANLlgt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21680814d42so153279815ad.2
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 20:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1735965568; x=1736570368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S7XjVN6LCsI6a+WbLjv++ZI67kiZA9z6cnH84jBwMsQ=;
        b=QiANLlgtYdSM34+L9sD0oOkEaqc5f/mNRjUv+HPK5O2q3PKErtOicNnA58o4+bRNDj
         ihcTxIhibz2N+BljsaAdqZvxN28eQxm1aYI/ILZKtUH6vmCxw5sPLShZAqCCIaSa5pmp
         qF5m2R1mpfCnIe3TABuGUtw2/sUC9NZDrtbyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735965568; x=1736570368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7XjVN6LCsI6a+WbLjv++ZI67kiZA9z6cnH84jBwMsQ=;
        b=LLCDQac9I5wkRkysKGL+PSLSLsJRUTcW0uA5rgN71sFrW5oCFcTW4pMJlB5y1CaJsQ
         kn2R6ppCtol3gjxjpRG5lq1jk+R+c+czaLM6WQWwmwp4lk3BjjEa72AsSJoJ2Z8CyA3K
         4kFeaNwb1UiB8D/Hc8jpLQsCyCMFT9Qm/wna0gQfbaXTrZuyfuigTzI9J7a22ZXwIJec
         t7TQhIZ9u+Z4KI/sco0/P6Fo4Nb0r4PRmF+y2Ryx5yOfp90r8Uc8bAV6nUH5f/qXMCvy
         LiPo/Mn4tb+druXjsbO2dnuXcXJsDx43z/GBOCedQTOYYAin4RjIPGf5UmJb3/vkfjWq
         Z/2g==
X-Gm-Message-State: AOJu0Ywz4is39DcmAjNDQMNxHAyLE8Pp8Ddi6BFq1UvLzr+y3SrTcpjZ
	hvCa0TIetIecwgMa10DaMpk7bozZCueQGMWbcE13HgZ7uqHKr2Tz1HcMm8Ru4A==
X-Gm-Gg: ASbGnctpAPpcBKpZxRLN9vBc6fOCLUjREB5hg1jufbZzHcGk1m8ZTrEX8HP1vxn23fV
	8/2npwPl76bA6y57RBf4HR4FbSPv1mmJFwzQjxUrpIFZ9wATzAF+dzpIzcyoVh5eAP0aiEwvvm+
	eNaZjGohj/AxS8XEnOhL/cSpkwUsNmgK1c3ffFruvkc0aQP7ZyEMerjMRU6y/6TyyEWQ/OB4vE5
	kKKAWnkVupu/iUkAm2bezl6velElRd+o8mIvc+BvxinDXgQQHob2UpYVj+/6c5qZMr6giAu7NHw
	Nb4LUEZGf76gSU15R0QBbfJuwzCRIEKV
X-Google-Smtp-Source: AGHT+IEuj1RG/lKqiMBMpQfBZ4XNrF2EjEjxaLV933X5lfNAorSK+DorwwXX4fr6/MDOKvox5rwewg==
X-Received: by 2002:a05:6a00:ac5:b0:726:41e:b310 with SMTP id d2e1a72fcca58-72abdec84b4mr63947958b3a.12.1735965567927;
        Fri, 03 Jan 2025 20:39:27 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad84eb5dsm27038105b3a.86.2025.01.03.20.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 20:39:27 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 0/2] bnxt_en: 2 Bug fixes
Date: Fri,  3 Jan 2025 20:38:46 -0800
Message-ID: <20250104043849.3482067-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch fixes a potential memory leak when sending a FW
message for the RoCE driver.  The second patch fixes the potential
issue of DIM modifying the coalescing parameters of a ring that has
been freed.

Kalesh AP (1):
  bnxt_en: Fix possible memory leak when hwrm_req_replace fails

Michael Chan (1):
  bnxt_en: Fix DIM shutdown

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 38 ++++++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  3 +-
 2 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.30.1



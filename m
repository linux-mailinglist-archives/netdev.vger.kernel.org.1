Return-Path: <netdev+bounces-191763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE50ABD200
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3F0189C977
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 08:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EBB264A7A;
	Tue, 20 May 2025 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RO4Y7hrc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40C25EF82
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729927; cv=none; b=iP0AoHNDQJo+Sn5gc57T7uWHGp/tSOiriDL7LrQeUjysynDV3MEetRnqOSj3yKmx2P6SEjDZld8x/B8Aecj/WBUptk9QKYAgKeHpeYwY+1ZWEFA/lT01PqBCHKSwrS+457IRWWltVgIyI1QlKEtz/MdaWdKOPaL+jz4QIKYN2Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729927; c=relaxed/simple;
	bh=k40OFAHJYa0LataLD0klUYgq+X4FjR9Se9KSHVB2tTc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=aX5HHfizLlKc0XcWgtNyrE5rMvLFbdhUEEot3v8Ozp9J+YVuAGxCR/FZ5gZn+sqUWUJMNk+VfIKY62VJ27vBDna/yGfgnCoxIrUT83y42AOVH/6P8sStEdzxk/VURJYMeOFX4vwit2eTsymnG4VDuZ7yMmdRrCUFoPgCV7fai2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RO4Y7hrc; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BC8053F048
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 08:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747729915;
	bh=aTx0P1G6SI1qG9PxfE9CEm6JpNMuUW8fc1VASYghmwA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=RO4Y7hrcflwEzfzeUDPacqOswSkt1tYk/HS5u9MBYjja1eS+0REWToubt0JcVh53Z
	 iOzT6iL+5iLqP0MxGctTYc8db742hF4LEr8comIPclgeBtlh91/r3TNwRQoEV8F0MM
	 qz+AMGKdMUWJayebCcBrBs0qXUm7iyFy/1XZQn4kwuq1X6B44vxKSy90x8y3e4A6Yc
	 bch3ryWYH2gfe7PKUpB4+adt2hBPDM2u9sbLaTvNsJJyhJo9zc6UklBJ39aOVMPLYY
	 E2dYjd+VuzU59ibMtbsDgyF3tsB9H426hFuGBGxtoZzWPikeyvRcsVOj5NGkb26A7Q
	 ndBPdTMofF6Jw==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-601d0aede8cso2286420a12.2
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 01:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747729914; x=1748334714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTx0P1G6SI1qG9PxfE9CEm6JpNMuUW8fc1VASYghmwA=;
        b=HFg3V6qZVdQovRucde1MKZypQlsCG2UJ0yf5YT8Ct8nLwXUrQ1ZE6EmlcgJzkZG0IK
         JfFbYeA2ccGg00i/gd3Y9ndGpmewc/ywIN15IiqnWMV/lS8lF7zb7J29puPthuxPJS9G
         Yc8eiUeJ/3Q96U67kmbNLDTi/Ofyuvdv50gFDoFm2MCHT/a/MFDlN9z7PrNvPruNsLQo
         50JET4bYjbYDvLDxHeW1HOunJQABGbk9mkcER2SvT3l3Gmc8YMiQNxrQ7q0Y5j8ItAVQ
         PQR0GdtS1uupanCb/VpWWGlvhpwbbHpzKreaHI0C/KORxfjy6xJD4DOSUXO9DmBA1uHC
         778g==
X-Gm-Message-State: AOJu0Yz4eT7Oz8KJrhOsBOBmNNFjvE7J4dCG+ZikFl2xn9NrJgkKdZAJ
	dfY+CkUv6jWfy7aoQgKR/6Jtus5di4wCVfsEkKWjAvjXVG9LcDrsGL8XGl+SvuFTMubFgU3YUkF
	9dZ/kaH9eZUqv9ltLvRsP4h0FrVXfsUap7UDVUNbYeqVoEF+wdbzdGsDegmEvbUFHea9d5tHnaK
	ghAMwZc+dH
X-Gm-Gg: ASbGncsCin7o2eGflNSeC5XuoiL6Tf1gy5J7o03JDyK347CUgG+qzNO5di7zN2PVpw6
	Wt3/kIQyi9wGaS74Juuo2aFOiOwYRF8IHPHe8Bo1zAn1jWs4w1tC0hlWm5zpJ1p2Wsfgc8vIB9S
	qe6Ecc4P+cvPvmstSa9zzzRXWvOuyAtO7FHChCOH095DsZVy5naKK5rXq3nXwZxkzjrF5c/ZPSK
	rqcUg0iIv4xLgIchuiROsZOIGK+JV5hAaqzWiCby9UZWMUPZhwzvXkdbbe1d+AamEs/cal/47bQ
	EZQH5zLTGgY=
X-Received: by 2002:a05:6402:13cf:b0:601:fcc7:44fa with SMTP id 4fb4d7f45d1cf-601fcc74949mr4041928a12.30.1747729914325;
        Tue, 20 May 2025 01:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0psxPx8N/qxisE9waXYgdmCXtHEe62Eh/zCNJLeEGY46QaLFyXluUGxFZ1x9EKkZ7ITtDkA==
X-Received: by 2002:a05:6402:13cf:b0:601:fcc7:44fa with SMTP id 4fb4d7f45d1cf-601fcc74949mr4041908a12.30.1747729913964;
        Tue, 20 May 2025 01:31:53 -0700 (PDT)
Received: from rmalz.. ([89.64.24.203])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ae3b824sm6857875a12.79.2025.05.20.01.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 01:31:53 -0700 (PDT)
From: Robert Malz <robert.malz@canonical.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sylwesterx.dziedziuch@intel.com,
	mateusz.palczewski@intel.com,
	jacob.e.keller@intel.com
Subject: [PATCH v3 0/2] improve i40e parallel VF reset handling
Date: Tue, 20 May 2025 10:31:50 +0200
Message-Id: <20250520083152.278979-1-robert.malz@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the i40e driver receives VF reset requests from multiple sources,
some requests may not be handled. For example, a VFLR interrupt might
be ignored if it occurs while a VF is already resetting as part of an
`ndo` request. In such scenarios, the VFLR is lost and, depending on
timing, the VF may be left uninitialized. This can cause the VF driver
to become stuck in an initialization loop until another VF reset is
triggered.

Currently, in i40e_vc_reset_vf, the driver attempts to reset the VF up
to 20 times, logging an error if all attempts fail. This logic assumes
that i40e_reset_vf returns false when another reset is already in
progress. However, i40e_reset_vf currently always returns true, which
causes overlapping resets to be silently ignored.

The first patch updates i40e_reset_vf to return false if a reset is
already in progress. This aligns with the retry logic used in
i40e_vc_reset_vf.

While the first patch addresses resets triggered via ndo operations,
VFLR interrupts can also initiate VF resets. In that case, the driver
directly calls i40e_reset_vf, and if the reset is skipped due to
another one being in progress, the VF reest is not retried. The
second patch addresses this by re-setting the I40E_VFLR_EVENT_PENDING
bit, ensuring the VFLR is handled during the next service task execution.

---
Changes in v2:
- Patch 1: modified doc string for i40e_reset_vf function
- Patch 2: removed unnecessary doc string changes from the patch
Changes in v3:
- Patch 1: aligned comment block with kdoc requirements

Robert Malz (2):
  i40e: return false from i40e_reset_vf if reset is in progress
  i40e: retry VFLR handling if there is ongoing VF reset

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.34.1



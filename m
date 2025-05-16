Return-Path: <netdev+bounces-190986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B232AB9947
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF8E7A377B
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DDA21B9E7;
	Fri, 16 May 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rB3hwvks"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE438163
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388855; cv=none; b=TT3xKsoVqqimt7nGLu6rLwTQ02XHlbgHR4uXMghXeZlfZSEt4+BuQ+cI/uhf0KltmRzENz5+OZMNzrI61SGBRBKASXhJXfvmZZx3Txwi1ugrW66UB4F5NHyGDc6O3PYqqxewX2V2ZS3PXDFrjvDZA+k+GzFmwjea1JY8Xv7qhn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388855; c=relaxed/simple;
	bh=s/BYJVOslwfQh2Gv9bUrvn16TrcErl6S+z/aEUFkoIQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=HtddWq+qdcGPrmbDHzLiIfHljWzulWbNjBWf/Ty2p5C21iDUrk45CExMvkLJ5Kw9i8CyEdo4qm2O0v9Zfo6IlvRF2CApjF/8w2fYo1x3cu69n4OQhxTSTwNjf/iIpPy1hfAtOgRhjix03IcN2+n2llEQrGtfWEIE4SjC1nYWj60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rB3hwvks; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 101973FC4D
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747388850;
	bh=rFz2hT4dJU8x+6xyAzn9MNouymJj5+a9kLkmNIJE3sY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=rB3hwvks/S++KJru3IB71kEl3ZZdyTzuao2+DFjW+yNJRhRj1hE+SHXxrHadhI93U
	 Wfbwf96rF60P3icaAfciAIg+sL5HoxbBrQC/v1TpabAWV7Ui+lnblx77NE10SKPx3b
	 AJKNY58jVYzC0xnWxXaK6LllxVdVyuXMu8d16oPXZQBZSWKvoSZiPS1S7a20dWKoLc
	 IWhXugJrROixPaWXYwkhIack8UFbwSbbpy5aeXscNJu8uh948UrAfdT4P9TyEYfEh1
	 dCmu48rKAxa9a8VXOc3VgytAN7y64lQCR2D746jCInlEkKRLvD5ub97d2smGOdxv/M
	 bHL6mk4Q695yQ==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39ee4b91d1cso1457676f8f.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 02:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747388848; x=1747993648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFz2hT4dJU8x+6xyAzn9MNouymJj5+a9kLkmNIJE3sY=;
        b=LgYAebEyAz+u11FhpkcNldpO87wg70JJonCBVerGMfuhURf0ctdRsyrVn+3BvYzvF2
         9FNVM0wty9POL/DJs4GxDkiegMnfXZ8TygJAgdLdrEhrymjwluPnMMV5DgdemYMn1SWj
         mpFyaSAJiebg9Iz0d5mNGhvhlVHw//iAz87RnQAqkFEXTc7wN9xNH4XSpSYcdST3ewxT
         HhrEDU1S0k4U1HFVIhGUt/V1kWGGhsm4k3py7T2iC5YY/KhphzeAVms9ohzoXU4Dpy3i
         QmEdnEjXPVzN1z0BEukD8sQ/4kAypj6wPKXY07ZXnL76wVCSr+bqaF3VUkrfovL59LA1
         nPuw==
X-Gm-Message-State: AOJu0Yzx6RgOd9fbADWIyKjYjCDAznywqA4wvPJja1aecpqUTc+hcsOe
	5pyohfRsD76nUuvzjpRhUlXb4Hr1Ct8uJ5rIu8CSXRW/QSO7BSI0bR6Ye0DRcfboFKjVcbx3yyo
	J/OOxPYcUgDkj6AHRM+OOYSgNyP4GmqoAvAAngPEHxnMexigjRpc26wpOp7Dc55z+/Jywn4CjZC
	JZfor1c4nkrZk=
X-Gm-Gg: ASbGnctEP9quN0FHWzPRiOKzCFs2YCydL9gQsrPkNHZUXTODFIh571LfWHdjKyvTI1b
	7OPPQ5QeRw/3/tosI25rJWA8SY1xTqjrqzo6rYUjDsHXctNs7Mjm9oS2UhopR1u8GiO5b+D1FhK
	nwcS7IMV4FsUNiqCo+Y0rYDVhcL36rwBVNkWiavNM5q4hOGPgGYfbMvPsKYILBvVq3jXbK7sVsq
	iI2IAZRZcKL3M0Q8F+/mmCRvnH6WtSs/k6N8R44SC0F/aYkB+1QWQE3aTwZFQReZeoJRqEN4DKa
	ymwsiJW+Rnt02Q==
X-Received: by 2002:a5d:59ab:0:b0:3a3:5c87:6e75 with SMTP id ffacd0b85a97d-3a35caa2ec2mr2611735f8f.25.1747388848061;
        Fri, 16 May 2025 02:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOz/bnJAGSk9AsZ4SS3NshUSa2NByjlHThL8Xa8m8s2R7j+UwYyrfzxT/4ncnhsaJdnYvq1g==
X-Received: by 2002:a5d:59ab:0:b0:3a3:5c87:6e75 with SMTP id ffacd0b85a97d-3a35caa2ec2mr2611705f8f.25.1747388847713;
        Fri, 16 May 2025 02:47:27 -0700 (PDT)
Received: from rmalz.. ([213.157.19.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88990sm2329962f8f.68.2025.05.16.02.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 02:47:27 -0700 (PDT)
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
Subject: [PATCH v2 0/2] improve i40e parallel VF reset handling  
Date: Fri, 16 May 2025 11:47:24 +0200
Message-Id: <20250516094726.20613-1-robert.malz@canonical.com>
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

Robert Malz (2):
  i40e: return false from i40e_reset_vf if reset is in progress
  i40e: retry VFLR handling if there is ongoing VF reset

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.34.1



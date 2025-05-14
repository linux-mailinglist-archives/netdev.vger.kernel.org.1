Return-Path: <netdev+bounces-190479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBB8AB6EA4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C4A8C190A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBB41B424A;
	Wed, 14 May 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="I/hfARu8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13A170A37
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234653; cv=none; b=rxw5BW6zuS/H6u2Y+Bd5Vb6w6iFl29JJPwJ6EQVtCLgCUDWveGQhF3Te/PMteoWV8QDqO2o0j0PatBEfGaADRY3rkUoSs+SwgtJHRCUBBShNQ7Fw3LdNjV7G/r/m09Q/xhr9Jlk3r+tUN3Y507RnWFUzn2K42scFmqMNXzdCz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234653; c=relaxed/simple;
	bh=G2dEUdFPWGhBcN/+EN78lXblc4jN96T9sbSWKPcxbbo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=s9AZNlLPBd9NvIaYTzymg94oGMx/bnXfBdP51R06XEo0FZ2+NLvzUi4/dmWrpoap2Dc9FUpsK+oUHwacLzP2O00l4AwghKO0z8xdiquUX5zwsMGqLvIIOVkW07Evb+eGGRRErUNbjeQ7UhkqImYBTTG4G8A6W2Iro//EpBJplrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=I/hfARu8; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DB99D3F51D
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747234642;
	bh=U7Vp8QljWnGGv48HmwPUUHanbPqKrIRkEiUDXnzutDY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=I/hfARu8dyljsAYTsmItsLb+RgGi/1zLBvf+O+7abpHDSP8inDeeFzJMRiQU6asPc
	 nb8C6GvjlicMft967RP2QtQ2UoJ41xozZ9wLFeqis90dexfFWIA1ySvmQ6MjYKKpCy
	 9HdbiLoUrwendewYLSOndX9x9YZbjlbxo//0YRLDtUdqAxJ7DR93/zMVfVpTT9XdPL
	 lDiHLuME8AaWcV7ebvAh2lamcxTpmOQz4Hf1Oq7RMj1ytQzty9QWJZ/9l6k2D0w3XG
	 IgZP1bwuG8zjGNi7CU45aieJaQG+C/4OSLiGCJ+BfrET9y9BItFmjcTXF7JlZxbO7y
	 jdj7SaQtMaEag==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so5491595e9.1
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747234642; x=1747839442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7Vp8QljWnGGv48HmwPUUHanbPqKrIRkEiUDXnzutDY=;
        b=FLeQjeinmb0c6KxuygUtGJ0FjfIu7B9EXb491d0qtUiqskicPoK2ng2Slxwa/no/1o
         aI1Gr3URqMxr4HKier7W8lcWPPc1flAvjwEBi67XWOuFtCzj5Xl5Pf6Y/V3T8E7NUgUA
         hYbmONaYoBY1VG9MF0MbR2gAvqd5QXXeK1urWWIx8C4lUC2wuVAqWv4q+vMykvjdE7S9
         oV9owJQZ7LFDgaoQNuy7dL92+5kVLzFlhrrGhxrOCrBEuhZLdkhtaEoh+R1boTrV9fUG
         rbmO7yCRAGuxYca+jq/0ZV8s1IJ/v/50s65Qh4wyML1IOZrcrRNxEles+wkNQbzfbI3y
         NwJA==
X-Gm-Message-State: AOJu0YzMpx+SkmBT8tNPEPSfirNHq0Was3tZiYWN+CXUQczhAffVnybh
	maW2zyGp/vZh5+paekxFAUGgrMAT/Cc4Urd2qaB8TQiw+Td1MC1dOEAxGbIRZapoE2eIRcvdUgQ
	habMBP3UQRB0CMRt0GXErrLLvmVjU6AFLjnMJ+HjgKOe/FIYQn+jm2x9bo4gp+IjvJbf3PEF/R8
	bQPPmq+rQ=
X-Gm-Gg: ASbGnctnnSjsw/wwOxsCH1z9atlL8XaedxuqXWEaDuLhEiFHnpIDgH0Zuc+uX0k2un4
	3ev/6oroc4hrE3BsuhWcbRI3YcZuIkQ8NpFUzSS6qt/OZaXv7RxvQ/B0liS0TNPVi1xy/FR7TtA
	GyPMQ2Fy3vcWo2sHTjrpqiaLeIH53O4W/2Vd1Mdxh0Z7eDiq5IH7Lq0wqN2zMYx3/jIf//RKmcz
	Din6UYtD5M3uACmYgAviEjfAgKPqRRz32hsVHbuwowDNS/Obu2H2CkjB5zye26wW7t7ys+Waaeb
	CthZM9weqMwmJg==
X-Received: by 2002:a05:600c:190a:b0:43b:ca8c:fca3 with SMTP id 5b1f17b1804b1-442f1a819bfmr33365925e9.11.1747234642117;
        Wed, 14 May 2025 07:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6CxowXUpdtASikfZ1ZZEQkSR1V6z1Cqw2+EJWQcHNLnMfwhuKxK8nw6AQE01cWIWj5PS4iA==
X-Received: by 2002:a05:600c:190a:b0:43b:ca8c:fca3 with SMTP id 5b1f17b1804b1-442f1a819bfmr33365755e9.11.1747234641755;
        Wed, 14 May 2025 07:57:21 -0700 (PDT)
Received: from rmalz.. ([213.157.19.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3369293sm34512765e9.6.2025.05.14.07.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 07:57:21 -0700 (PDT)
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
Subject: [PATCH 0/2] improve i40e parallel VF reset handling  
Date: Wed, 14 May 2025 16:57:18 +0200
Message-Id: <20250514145720.91675-1-robert.malz@canonical.com>
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

Robert Malz (2):
  i40e: return false from i40e_reset_vf if reset is in progress
  i40e: retry VFLR handling if there is ongoing VF reset

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.34.1



Return-Path: <netdev+bounces-172555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A56A55698
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D02176199
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F9126E639;
	Thu,  6 Mar 2025 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQABZbdu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299072080D5;
	Thu,  6 Mar 2025 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289241; cv=none; b=Si5uTyWfvcVlpuyp5wpvd6zpgXEfxgvD9RI4/vSWE6idPlrtUy7ramRJc9NPvhNV5QA1EengyZNNZaCtDgnf8+XVyfnGXXiFxu3nBOYPwp1Nc6rl7oRZrX4+saFDBCsfx6YIlq9tt2FZQUU40C3hpnrVPeFcZD62geP4FEdMFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289241; c=relaxed/simple;
	bh=bTJNuOZ2aT2YSfhiXMN/Kiyg7JC1qmQPr4BNndzLe74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PVnhVcRJtkafGsSTkGMljk+LTTrCNvFhVVkGuEpGlj+S4141rvzEHdTjV9azL8B4kaWjMMd90I3+HmfYV1jp0Wikjmwu1yCJYcA6l8JjUP9fhWP41DzdKzpPFx3l2Mp6EkGLbzXN3HUn+ZtpKjnEpYdHdSM6l2hGV/9lmwzBsHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQABZbdu; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f6740963b4so617903b6e.3;
        Thu, 06 Mar 2025 11:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289239; x=1741894039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3aiBBQRRRroN/DdzDWbnQJoRGBc41FuTpD8nPqfUZk=;
        b=fQABZbdu8cSLxH5TpeP9DKh7R19gaIez/uYTIa+BnltnUYULfvow+9Ut/IgCilCFqC
         C4/jQdciJWUZQnO+oRomoklQdav+IcoPVF/LSKW8+jCjxUOu50bMHH/6rvnazKeVLnGf
         BphKWU/4ZwcG4vNfhhSfQFHOI3ZBhjgrq+chW+apegEZz5XHzXp43r7UNtk02JON8b1N
         eCQEUctQ4hUsO3Eo/N3NHh7pVnT5xBQ/75Q0ZBbkKtgKBoWlzZ/I+csMnyg0JZTYnwoY
         Vke/GRPnBZ9j6uCud8Pj/CMk7qkC5HVJrqVazDh+9eBA+pYeJbSobtpEYuRDo86gnT0e
         tr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289239; x=1741894039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3aiBBQRRRroN/DdzDWbnQJoRGBc41FuTpD8nPqfUZk=;
        b=J17WgvUCMSDGkS/tN6S/VUe0ltCalJhIHSBF+FW09ofUB7Yd92QMtGfyVT2MXoTUIX
         RIl/LOLD6hkXbZBvM5rBLu6qmDjGL7Q3xxoVtONVCguSlbobyMrItN8PUld1OoNtyoNC
         W9yrV3hegiRB0r6OOGflt+iMwBnMBFQTTJ2qCJzuY3r2G19V6naQIRQ2QfeQV/zJJrxt
         z3rfcvNcyvepeO4MNQNQNWi/NING8mYQRnJMgLpATeZp81ZuB1RVp6Izbeqd9Go8V7PU
         +2MiyZCRo7QD79wLpxwb8y9i2+hdskXHOumRXn6AZRLHDvGe3wtnhHwYep1xJX3meOfa
         33XQ==
X-Forwarded-Encrypted: i=1; AJvYcCW22o05Eg7VNEboiDZ2g4WwXEjzmt1y+sZ+g/WYmmIDdym2zsM7EQzc+GecrzUW75D3WJUh3EiI@vger.kernel.org, AJvYcCXGY9yp0bQh2okQrgcqHmDJtlJtTOkgvAT4iFFara6yNYKZqDSjowWbU0Hj2eDtqn5Z/Q+Od3/43cYeiKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAk/YDyTaKFnxrtFgLMfXDqVWtTLpLuaArmZ86qsr0iRe2YOIW
	+t448qQ9DEHJYpWquk/stTGsuqJWFn/YpZqXrEn7Co9FHgzRe/iQ
X-Gm-Gg: ASbGncsKdBieshDsX2IZoMglzogQkgIbg6BIICH+QyB2OlyIVuVxdA7ZSXRtIsEu1ru
	eeTuEjKPipJxcZDoLH4wlcGxnCGZqOznj5HH0KhGjCsAO3Xo3Jkm5IIgADVKPs0GJ5SRxoFYTVz
	LumDCtOL0Go627zaMkdmHEOgLklnd1CnBY/nfqsMzaB3aTCen5X6Dw/2YflNQ7yLsQoTRA2z2xr
	KQrrw8Fr+dhg6LrP/wshTCKwjSfqgfNmHuqnyo0u6zIWhcRe2Ao2aaWW7W9I3eLT92r6mYryZw4
	P6eFaBlyr4vR2Rktm0DaJrx6y57Xbpm0CJmw2Uo8Y5hkZTcq9YQRB6tJM8kDEDvesvAembcws6I
	CLqRJFmr5W+DV
X-Google-Smtp-Source: AGHT+IF0sl6M5RF/deNg+LNRCH3tg2VVj7GlOB/M3/LCoyj7vQgsOiXDOQBRtmrF4lbcIq8UIlTJ9g==
X-Received: by 2002:a05:6808:221e:b0:3f4:7f2:a77e with SMTP id 5614622812f47-3f697afe2e4mr330666b6e.6.1741289239073;
        Thu, 06 Mar 2025 11:27:19 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2dac3887sm366338a34.7.2025.03.06.11.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:27:18 -0800 (PST)
From: Doug Berger <opendmb@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doug Berger <opendmb@gmail.com>
Subject: [PATCH net-next 00/14] net: bcmgenet: revise suspend/resume
Date: Thu,  6 Mar 2025 11:26:28 -0800
Message-Id: <20250306192643.2383632-1-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit set updates the GENET driver to reduce the delay to
resume the ethernet link when the Wake on Lan features are used.

In addition, the encoding of hardware versioning and features is
revised to avoid some redundancy and improve readability as well
as remove a warning that occurred for the BCM7712 device which
updated the device major version while maintaining compatibility
with the driver.

The assignment of hardware descriptor rings was modified to
simplify programming and to allow support for the hardware
RX_CLS_FLOW_DISC filter action.

Doug Berger (14):
  net: bcmgenet: bcmgenet_hw_params clean up
  net: bcmgenet: add bcmgenet_has_* helpers
  net: bcmgenet: move feature flags to bcmgenet_priv
  net: bcmgenet: BCM7712 is GENETv5 compatible
  net: bcmgenet: extend bcmgenet_hfb_* API
  net: bcmgenet: move DESC_INDEX flow to ring 0
  net: bcmgenet: add support for RX_CLS_FLOW_DISC
  net: bcmgenet: remove dma_ctrl argument
  net: bcmgenet: consolidate dma initialization
  net: bcmgenet: introduce bcmgenet_[r|t]dma_disable
  net: bcmgenet: support reclaiming unsent Tx packets
  net: bcmgenet: move bcmgenet_power_up into resume_noirq
  net: bcmgenet: allow return of power up status
  net: bcmgenet: revise suspend/resume

 .../net/ethernet/broadcom/genet/bcmgenet.c    | 1089 ++++++++---------
 .../net/ethernet/broadcom/genet/bcmgenet.h    |   52 +-
 .../ethernet/broadcom/genet/bcmgenet_wol.c    |   89 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c  |    6 +-
 4 files changed, 577 insertions(+), 659 deletions(-)

-- 
2.34.1



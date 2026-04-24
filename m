Return-Path: <netdev+bounces-280927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4A/eC6fk6mleFQAAu9opvQ
	(envelope-from <netdev+bounces-280927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:33:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7778945977A
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81BB230071EF
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6521B4F1F;
	Fri, 24 Apr 2026 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="badu0HUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFB519B5B1
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 03:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777001635; cv=none; b=Er8vaMEbTPlML7NJobVYtzKcwv0Cqqgv8HAlcCcCjcw6sx3KQPYTuX4Z3sL32wWSln3tYaTjEGkMtKVd3bqPa04mAfndsdOpbcUvf9xVqaQLdb2HsApRenMMDjzkvr4pzNnESs0k/9dZ3zqEFPqC0uwOZzRAHxtiMxdEYWxuBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777001635; c=relaxed/simple;
	bh=jJhyc6teF16Az0idq5ISRmXI9fjFyPjhRnFbLUL5Vz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mNAEUhpMDdvueBAEG2jHED4FLfsGrwq7mBgPSajVEfV6lulxb2YGE4Oh+armq14nJeqMFUDWvcmpHX89QY2JoZTB0in/xnmm4dyT4HrvFtiKe+b1fFx340GOmbERWvE6x6zr4ZOr4Z3gYXkQmAs9tk3QgI1a2lJ2zFyD5U0Jv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=badu0HUU; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82f4a53ae20so5419243b3a.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 20:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777001634; x=1777606434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4XT7jL0qVorV9DqZaeP2X21NLLxxWTXoipmOJgcSPnM=;
        b=badu0HUU1J/K/hPJMuPXn0bYhO+Z7o9s1iDCapvSt10QmopGO/zcz1rCwLlJl8CLq+
         TfcIS2sJP49/FHhw4YN1luppxtEnze3d/2cq6x5Tob3rIJtuZrFaNQwbqXDv0ZrMSnGm
         qyjQQUOh02Ypq3Fkf2uXIERoLh9fvHiRruypzvjEdhgC2QpxtT/swZewGrUJD1Or2JAD
         PqU7yl1qp+eCiIo4tmFj6SSSmXJzhJE+bU4WL/nYBBrOlqAUD3Pa/3djwkR39ehmfS0e
         mgivHEGdAxgSyXVW8wzqg7U6o6s040r5oCVVCvcFp55/ROke0U2aYcHZs+H5V7SWLynW
         /Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777001634; x=1777606434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XT7jL0qVorV9DqZaeP2X21NLLxxWTXoipmOJgcSPnM=;
        b=EPgCOApOy/1Ht35GBgMk22GVje/F/6QsT7z0BMW9VRGf49n7qACndMZIskEKHdjbUo
         UxDs2u9mmReHPPbXK++PFLtPrbrCHcHTktu4GHt8glqhxCh9Y4H4fKPJDVEKxi/+dkDY
         ZR6O960AaKUsm8uw4L4veM/AR886ytmp0/CIUerbINHaw6kPNXO8CLqUvWmHL1534u8u
         vkxriR0ygKI0Xd8TeY7IJ1xyJ9c8ZvLegOTmm0UUxoYxKOp3K2QRnqZ0Iz6vEy252MQP
         7CazQWRQXfjj01TYQui4xgcBgjTiQKQnRDnrFgIf0fx+xRMX+vDD6J8fXuDDfU3VDvj2
         4FUg==
X-Gm-Message-State: AOJu0YzmkWSKiWJQLpMlHWLUXA2Lc3kjwKOhXGZinduKkrZG+TqaTD1C
	aSp/v3EW6C9VF9Vs+lgFZ15JeXXvO6n8MT1Vb2riSq24FxDBdKvtfbAEO/BVBtKI
X-Gm-Gg: AeBDietcrTKZdP0OMqx5SE1lJFQFq25c2FN5mdR6BMqBYkmHCAOJzlifDRdCIh7zaIZ
	pT4BMorV/86f5N4c3I3/CtMPfYPCgiFyoLh4IfmOXvEZbieNvxWj1BzOdYZpJA8BlAl8KYr4NAa
	eSWIae/mq88I0cS3RhZB66P7KoHdCpGpyJfQgFh5lbRWvzOPguP2Jw02+hRPMDFV0gCIGtLaiK3
	MGXbKPhfwwHoyi0ZLzUPRSwNjkQTjHrqW8joJ61+SdVcWM600WRuowg5jaK+kEVQObNPIDzE1qv
	4w7A6H7AijXQLfY0Xe0+OWghFPCIl1R9PnsfjGuZqI6SzJnASAwRHIGy56TUjXWF+j0wrAJyIjq
	pl1kRVBrzJ1O39LUGAQFOlROIvL1I6rtxLHkVIhjM+7r2PFQTriYf8Qo4XkHpg1kzYQ2Uu546+f
	4DD27XJPgLDblMMNQpTmTOclapzff0RXzxBt56ro0RFta8iQnF1NuG+Ja3kWXDawoPN3H9yPPEL
	MpFMR5+xCw=
X-Received: by 2002:a05:6a00:80c6:b0:82f:8e9f:bdd5 with SMTP id d2e1a72fcca58-82f8e9fc333mr23566538b3a.1.1777001633897;
        Thu, 23 Apr 2026 20:33:53 -0700 (PDT)
Received: from ubunut-vm.. (c-73-240-82-137.hsd1.or.comcast.net. [73.240.82.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9cbb1dsm23797624b3a.14.2026.04.23.20.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 20:33:53 -0700 (PDT)
From: Joel <joelcrouch@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joel <joelcrouch@gmail.com>
Subject: [PATCH v2 0/2] sungem: PHY initialization fixes and style cleanup
Date: Fri, 24 Apr 2026 03:33:46 +0000
Message-ID: <20260424033348.1917-1-joelcrouch@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7778945977A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-280927-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joelcrouch@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]

This series splits the previous monolithic patch per feedback from Andrew Lunn.

Patch 1 cleans up pointer formatting and indentation to align with kernel coding standards across the file.

Patch 2 implements hardware validation for the BCM5411 PHY initialization and adds error reporting to the core gem_init_phy logic

Joel (2):
  sungem: fix pointer formatting and indentation
  sungem: validate BCM5411 PHY register reads

 drivers/net/ethernet/sun/sungem.c |  8 +++--
 drivers/net/sungem_phy.c          | 60 +++++++++++++++++--------------
 2 files changed, 39 insertions(+), 29 deletions(-)

-- 
2.43.0



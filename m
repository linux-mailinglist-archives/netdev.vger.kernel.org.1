Return-Path: <netdev+bounces-273567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOmYFoGmy2nJJwYAu9opvQ
	(envelope-from <netdev+bounces-273567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:48:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A806A3684D5
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BC5F3042896
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2246B3A7F69;
	Tue, 31 Mar 2026 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qzg2rNkp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D5C3A4F2F
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953791; cv=none; b=mIXmrppHvhGYWNlYpWmPhH6mesdAp85P3OqJBcG24bgX8rnlS5TOujPO8kwDPnu7OY137joHA6nM3nFnzjvXHu0sVzB0mee3lT7SGG6EEBEC+OB/CrUsGCHiNvK1g5dIkO1AWyLzHTeekVLL/25P376CygzuIbI4Y+It/6WEG3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953791; c=relaxed/simple;
	bh=8u72MSr0OxkiiZaBrCGji5L4mvea8Kp5QoTeUfhvxWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5yvU/2AKkScWqtF7gpXVN0I4kPf0YaPJO6NLGWyVIfjCSAED+aj4i9fi8RitvxS3GqQyWlHBDPvVEPpAs2vspuImdv3SVkHfZzIKe9vhpqjSL1gBmgUTdErwQN1O2fon5xtwVJi1uYNVv/x9spcayLovtZgi55fd7JGTbki2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qzg2rNkp; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so2248537a91.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 03:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774953789; x=1775558589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hkDa9izHEIAJX9uc+HQPy+UKJAsfOUb53e+2UosqcTo=;
        b=Qzg2rNkpdKbgTfnQPwbcT/fiSPWaWRLT88lNJwC5UA/FacfpGoPatLwZyJT7M8ruCG
         Sm/iTdDM7wlUPlVVyLUNH+wCCQR8Ed4WeWrzKpK1BzJ8B5nu02FxORhjVDWfP5LsRBhh
         76MnX+7uyIk1e1IBgrfHEfSCHFzL9T41++4VdQxOwR7/IoQXzR4lfB7n4w6RK/d0pfEO
         4Z3yyVhrT6LeEfn0pjy534mcAypOrFPIQ+5F7TGTAUZaDVIZ7UMrL3OO1kdlgkEGZl4j
         /SxfsI824gpAXqfY1S3gyuXG2x/UzkzKSI+AOi7P7Rj/PwU9WdB/f3wHQcurGwA5ot+s
         p6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774953789; x=1775558589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkDa9izHEIAJX9uc+HQPy+UKJAsfOUb53e+2UosqcTo=;
        b=Iem6bF8rl8MN6GbyjB3Avqa7GEq6X6cu9kSG1WHPfBGkbuI6McSB2pw+4XjYvhGybv
         Nhf7COOBSUFxgUzKgO9xKJc8VWUkfKOLRfur53q583Lla3rfX3rpzOqdQ6cHQkyTcGGT
         AYqh/2XORlSsH+xOGnv+fWcX5NqClBTzNGrPIuAYB1tvG9sTw00ZeGdZGcNJiSAGYLzm
         H9XPsFWBwyz5QmTOTrMKh4Ysw2gASuROONOLjm3HMEuDgHZDDckmJbcq8kI5IxCerF8I
         GXRFMLSECab14ODaZvq4qRTE58bfaehtb2QaCTrUUGBlU8Yf/hire+78FMxOksCQ703Y
         tZow==
X-Forwarded-Encrypted: i=1; AJvYcCXwLiH0kMf6ucbyuPzMucip1sNDCDZj2ItEXm4/P9LmI/doGDUE9xctvgCyqaBRrjH4eOUdp5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY7Y5YLmhbdVfpg9e1Rtmgjf3jRjF3fv2oqvfMgkirLGabRuKC
	BBIwthhO7+XmVlE2VpKNrSRNLqKOo1lCkkYzDqqxxMrE77Hcfqj0PJOb
X-Gm-Gg: ATEYQzzU3RUwl2ifgjiCjiXInQjZIp7JPsPPQLFChP4kTcN5JFYfjXpOjHFNjdHjp+P
	RqA1nYBLg6q3rQhVWrFY4HRHMNDfYNzTL7SPZDbNyce187sGdE8Ams9kqNBHfyglMsUxz7vDm05
	2/aZ3maXfajYHCL0ygS9CL/XJckovpPgvC14rREJiWbaq65U+R2kgAmg98ddiMcdOwI6m1fQOMX
	QpgwGGASMUD0l6t/C3YANeQvAeraWQZz63yuQ7zrNl9Wjcs5oA1VI8O2i2H4hXWgTO+djeSWs8J
	Ak0Erk3SNX3uG/GBZgQcsOGc683kEPuFagfklF67HxO8/puTZ6dIV+mTPAk2eqPx8NFJyqkUB9B
	gKRJj7sgkCUvDfnI3qGW55BGNvXDTZSVz1hEGdSuWsDRVETXHxMDXsc6MUlH1a0asdsMmgKUdxW
	S92gTOzIonJVOABZRxcrApvo8G4HQTecFjXCL/SlB2C0EKy70ep8uWuVekOGvn+nzQhE2xkUsN9
	+9N6YRRGGCnYUqGlJRKtHDKF4oBmHf1fqq61av4BrdyMoCGqtPL4MXd8w==
X-Received: by 2002:a17:902:d4cd:b0:2b2:53f5:4627 with SMTP id d9443c01a7336-2b253f548afmr65878125ad.4.1774953789256;
        Tue, 31 Mar 2026 03:43:09 -0700 (PDT)
Received: from ip-10-1-46-91.ap-northeast-1.compute.internal (ec2-176-32-72-196.ap-northeast-1.compute.amazonaws.com. [176.32.72.196])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427658e4sm134280415ad.48.2026.03.31.03.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 03:43:08 -0700 (PDT)
From: Daiki Harada <daiky0325@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daiki Harada <daiky0325@gmail.com>
Subject: [PATCH iwl-next v1 0/2] igb/igc: use napi_schedule_irqoff() instead of napi_schedule()
Date: Tue, 31 Mar 2026 10:39:18 +0000
Message-ID: <20260331103924.36422-1-daiky0325@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273567-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daiky0325@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A806A3684D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch set is meant to replace the calls to napi_schedule with
napi_schedule_irqoff as this should help to reduce the interrupt overhead
slightly by removing the unneeded call to local_irq_save and
local_irq_restore.

In the interrupt path, callers of napi_schedule() are invoked with local
IRQ disabled, so napi_schedule_irqoff() can be used instead.

This series applies the same optimization that was done for other drivers
in [1] to the igb/igc driver.

Link: https://lore.kernel.org/intel-wired-lan/20150929215117.3388.48642.stgit@ahduyck-vm-fedora22/ [1]

Daiki Harada (2):
  igb: use napi_schedule_irqoff() instead of napi_schedule()
  igc: use napi_schedule_irqoff() instead of napi_schedule()

 drivers/net/ethernet/intel/igb/igb_main.c | 6 +++---
 drivers/net/ethernet/intel/igc/igc_main.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.53.0



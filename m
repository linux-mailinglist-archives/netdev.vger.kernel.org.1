Return-Path: <netdev+bounces-236673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B45C3EE0C
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97C584E109B
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0176B30F800;
	Fri,  7 Nov 2025 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLZ5cJkh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611647494
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502882; cv=none; b=VC8HYWOcLLNN3ZE+/q1touJEkk0V4edDJlswMIK2p96eQnKF4aPH06tKn/TdJr1sRL9QnNwfNkvVL12DDdHcj4OaUtVotb6XVObfgMDFVzLgUpIAc+l4Rk1xyc2PqpqZsrexIhhBFYFV5s7TFsDpLr1F15JjHPjuUqS7TZYQIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502882; c=relaxed/simple;
	bh=7pgqQSLNxYY7EJISqsid9AK1bmRm9KX+sTAAQz6Z6Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W3F4BIyxE1xQsxRvzibCtdm725gLdFSo9UNjBksv9ebEv2YHyZGdYQq8bLfpsv3Kmf+1qLvU+0MlQ8BuGXEVLEJv2YMSknCSDDaIIbYge4CbDFB7blosp8ZEba/xi9kbR9OAaKsr81IOiKq6/T8vYDKVo5TRxCm2KKIOWU7Stqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLZ5cJkh; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so758501a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 00:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502880; x=1763107680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rajoUmRPnySxOOnX7A1RIrBkqp/yGkZaJwwdcAfDN6U=;
        b=DLZ5cJkhKO3IuJt03dP/smFXzfVt7FNG/F3l1RUY9BG+zzDfIRRfxpTMz69DO0baEl
         JoH3w+4gcz+453DoSdHnYo5M0ZSyR3SUncIQyOVUGDBNHL/8l30nrbrWOAlUrIQmFeoF
         fFfI/2Z1LI/Ho74YM8BiyDLhhWlhBawTc8LydU8aCBZ9hdE1SMekyaDTjIMZG/QV4TAz
         FS3Tv6Pw9IZsPXnpH1rqh/xKkMNnUNwndC8T3e6Z/KltLiYBw6JWamwuIaiViwnyvt5W
         PGjUd/Xqas/zYKPsY+4SqcC2GEcwDGrhB2EeT7xbhKSza4AXN0YpvkJ4ec6BJtCX9pSR
         JwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502880; x=1763107680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rajoUmRPnySxOOnX7A1RIrBkqp/yGkZaJwwdcAfDN6U=;
        b=BQCiDVIEsZEDBt5HoxBmsGMx3zz+hzdpjCtVe1evefCPXk4nCh3l+VuU86YydR0gAJ
         ac8oZQ5Dm1Kd2OITSvhPRgDRa9uOHFUSEtBhsqvhp3K/kytLJYSV+nXtzpNRb8S3nMGE
         pVoxJLo6Ge1FTVpiy247lwug3Aclsr2obW3UfPlWpXNrUcGWTXEimLD2baDnY4DLLXRZ
         zggp1lSf6DSssEGc817eOEnTqhJWe6FFZGzYRhrNRWGONGs+213loL+WYVAPUsxCohX8
         /Pd6JWZcUq+D3da6mDsSPIeGiUWenD4RMf1OormYC1CUa0ZXrfiG/8noI3TBUjLJgwf8
         n4EQ==
X-Gm-Message-State: AOJu0YxKPcmHKcnXwgf2vqKi81/eCAhEl7PeGzzGj/b1snZEbJf2d08v
	Z4tGSF1ZHN/ww3Dg4vVkWTxelsbTIZO8mh4oJIud4aq0fOC4qKmCRUnd
X-Gm-Gg: ASbGncuRj5sW85TQEF/LucZykOa1Djds8vJ4VvbplnSeBRFOD6SZlUEb1b/qwy1r9nl
	nYBDtnSZEbP8xwJhafEzHlRti+nYEAy8nt8/JJDA1OSZQhwKzU3VhMjBJ5Sk9TTjkS6KhfMxFvV
	JRLKjWw40/YJLYzMdVZGFp2ErWbXBxBylezP1zf+HDupmZESnUugJhWC3gGqXLHzjV+yZp5nE9v
	LguS6CRemRo4Pajx0ktgZtHFhozfDoKbSFhuG1u8QZqqvgC0AA5UQ3UYmRE4o2M9KdS/wqL69O2
	TyjL4UdCwkNhhhS193XUrwrSe5gmx4mhci0veGQf7LXe/h0T4pGRNtnoeN1yFLNUwGKYmj+cqHQ
	k9AhNUhnXAuu7szTTwHDaigS434GkSjxPbfUdP7XFWZ16l49cjRGngP1pb/c7RWMuHgpHUAwad5
	tfDlmhFJ+3/K0LdIkVBkpOCQS55GZQBYiJT1f57Szhi6C+mDlxin0bfH3galAbJaq01m0cxYVL3
	mxbuQ==
X-Google-Smtp-Source: AGHT+IHswEuiKJmXiY0EIHAe+BZtSgz7sojXyfyfy+l5UKKqokrRbUAW/iGvN9ZOnAwdkPQbCg7XeA==
X-Received: by 2002:a05:6402:5202:b0:640:96fe:c7c2 with SMTP id 4fb4d7f45d1cf-6413eeb9d78mr2308475a12.5.1762502879314;
        Fri, 07 Nov 2025 00:07:59 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713a68sm3545810a12.2.2025.11.07.00.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:07:58 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/8] net: dsa: b53: add support for BCM5389/97/98 and BCM63XX ARL formats
Date: Fri,  7 Nov 2025 09:07:41 +0100
Message-ID: <20251107080749.26936-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently b53 assumes that all switches apart from BCM5325/5365 use the
same ARL formats, but there are actually multiple formats in use.

Older switches use a format apparently introduced with BCM5387/BCM5389,
while newer chips use a format apparently introduced with BCM5395.

Note that these numbers are not linear, BCM5397/BCM5398 use the older
format.

In addition to that the switches integrated into BCM63XX SoCs use their
own format. While accessing these normal read/write ARL entries are the
same format as BCM5389 one, the search format is different.

So in order to support all these different format, split all code
accessing these entries into chip-family specific functions, and collect
them in appropriate arl ops structs to keep the code cleaner.

Sent as net-next since the ARL accesses have never worked before, and
the extensive refactoring might be too much to warrant a fix.

Jonas Gorski (8):
  net: dsa: b53: b53_arl_read{,25}(): use the entry for comparision
  net: dsa: b53: move reading ARL entries into their own function
  net: dsa: b53: move writing ARL entries into their own functions
  net: dsa: b53: provide accessors for accessing ARL_SRCH_CTL
  net: dsa: b53: split reading search entry into their own functions
  net: dsa: b53: move ARL entry functions into ops struct
  net: dsa: b53: add support for 5389/5397/5398 ARL entry format
  net: dsa: b53: add support for bcm63xx ARL entry format

 drivers/net/dsa/b53/b53_common.c | 316 +++++++++++++++++++++----------
 drivers/net/dsa/b53/b53_priv.h   |  71 +++++++
 drivers/net/dsa/b53/b53_regs.h   |  22 +++
 3 files changed, 312 insertions(+), 97 deletions(-)


base-commit: 6fc33710cd6c55397e606eeb544bdf56ee87aae5
-- 
2.43.0



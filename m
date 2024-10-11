Return-Path: <netdev+bounces-134647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF0699AB0F
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C919E1F223E9
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4581C9EC7;
	Fri, 11 Oct 2024 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfsJBdCT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1993198E7A;
	Fri, 11 Oct 2024 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671774; cv=none; b=D5OfBIUUneBdNB9brKOT/P6iEp0N2h/TvJJYNGD4bux3gywDSjPfmSyCiP5T9PCVvKMjKnBwnS+rUB0cK1Cfj1+ftIKq/NK2KSqhyPa2fd4ek8DefYCSLEFZS7Hh1++yG5+dok2Vs1BLr99T+/zBz7Rqr02awROyAvm7j4zO998=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671774; c=relaxed/simple;
	bh=rBkWPH98h9Vmzrak8POAh0AJdAU7RQ/vVuRVDh8pbos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZrtGYn13tkSUMdZZaS1lJq9CLNDoMn6JQbtFFO7ZfZsKrfBvAujPqbhu1Sbzg99uIShN03ET/uCVch37v/FCFMYF4FObjLVKL9z+oYn1NitZHEfujRcIQpJ9wQujJIL47HOH8W+nDaFXvQEZTubpI52AcEpl6gZb92lo4NT15Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfsJBdCT; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e305c2987bso22542087b3.0;
        Fri, 11 Oct 2024 11:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728671771; x=1729276571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=87JrInLPreFBjtgTZgSWBUU5IX5fdvL+2htm3aI6NSc=;
        b=RfsJBdCT8BHoSx/adT5gxvJZKMuPmk6h4N5M/KWN9C/00EqjxqjRZezzh477HRrnWR
         eBYAd4hP9ZEO6iBPvmkaP8Ke5+Kxz/T+sxOUl9qFQpr7b6WDDuV2VJiPEnU90Ar1Qwet
         xWwsdQcVCtLpJ5GGf42C1gYykrxWfgGLceUmDbBltA50U0oSPqpemJXW+5+rCwqPqc5r
         1bEmUs9t+Eh0NI+tOr+YvzG7q/KKluZ+e5S69RmP/jF0ED3h+wRoG9k4kbtP4aV6Tv0Q
         wNhoAyu+qJl1nvklNW55hkRf/32OLJfJ08ctOyDJEpNc5CmcudetRc3haun8wcHnQ58I
         H9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728671771; x=1729276571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87JrInLPreFBjtgTZgSWBUU5IX5fdvL+2htm3aI6NSc=;
        b=O0IFULkWV7tx/AZqUfhAGmHWUQDQ2ZoXc5f2b+SAyAK9iIMwVnm7PUraF+nuZylaNn
         vDWeCYceCwbM/gJBT6DUoCM+w4adcxz+qT9S7CcvQ+usFHwt7ofMQuFLz3H6hV8RLm9W
         kPhGf+9PbnvznIj3OpBBu8ycLcLuEMv/1xIb4QaO1hiqaqBgiN0hnK+SEsk4fHmJ1E+X
         kgUjyMHtpaFdSyP3dfs4/kdAfxSNF/ovvO0b0T3E7P7QOZt8bqASvIItShMz/6BV8OxE
         gxgz3tvKfItANSUK2EeDrp5U9gRcioLeZdll/o9ki4Rbj91sHy/fa6lb9AyiysF8UHTu
         kPLg==
X-Forwarded-Encrypted: i=1; AJvYcCWQGx1onhgy3LSCv196ogCvbKVv6wQWznxQwFSdvm4TfgaXWjb/xSpWVuIjCqnZi5jzS2erqtf0cGMD0hk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2/lJT45ls+LbeMxhSDXD4iYypXvwk5mDME3HZ3PbGEI5+Z4EA
	3hV008S2F7pUl71WVmqlhXsMZOrmA7ctSOqzvhWwb+CQJUP6gKuQk+T2CA==
X-Google-Smtp-Source: AGHT+IGZvXSxrjKKc1+3qdq9whigPDD9GfQq+VKngGBb5+gWIb5aVwIod7FsyJld+kZ17FQY4K9aaA==
X-Received: by 2002:a05:690c:2f85:b0:6e2:1336:55d8 with SMTP id 00721157ae682-6e3479b3da4mr26414077b3.10.1728671771588;
        Fri, 11 Oct 2024 11:36:11 -0700 (PDT)
Received: from localhost (fwdproxy-nha-009.fbsv.net. [2a03:2880:25ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332cb37f9sm6824627b3.144.2024.10.11.11.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:36:11 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] ethtool: rss: track rss ctx busy from core
Date: Fri, 11 Oct 2024 11:35:46 -0700
Message-ID: <20241011183549.1581021-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series prevents deletion of rss contexts that are
in use by ntuple filters from ethtool core.

Daniel Zahka (2):
  ethtool: rss: prevent rss ctx deletion when in use
  selftests: drv-net: rss_ctx: add rss ctx busy testcase

 net/ethtool/common.c                          | 48 +++++++++++++++++++
 net/ethtool/common.h                          |  1 +
 net/ethtool/ioctl.c                           |  7 +++
 .../selftests/drivers/net/hw/rss_ctx.py       | 32 ++++++++++++-
 4 files changed, 86 insertions(+), 2 deletions(-)

-- 
2.43.5



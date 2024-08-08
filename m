Return-Path: <netdev+bounces-117021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E5E94C605
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 22:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C5861C21AB2
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 20:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45067156641;
	Thu,  8 Aug 2024 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uoqjqmQx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CCF1494CF
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150549; cv=none; b=jpyvVYO8lNppqyxNNbF+S579pwjDOG661yRTiE8pDOkkDKdy0sZv/VJQPe/xCqXfxf8Z+FIrpXKBjwZRurEpyora6ZkEqiSi0pGdJ9BB9caqi/o1ffaSvRTAe97wmcR8vaDwGGS9dLzJLB8Xec8oqDO20gBeftPu6USr7GYCspU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150549; c=relaxed/simple;
	bh=yA7riSCwrkPXRhJOR+u4GOWjHV2/PWpnXELD5Rl6BQA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qdZ5hHpNORqjeKIToJJfnSVOPBqBMSP12Uluu4Xzg1rBAbXZXRIUfDWAD56qUeeAptUtPCmdNtOjmJJv7MCcB07YwfazNk095CSO5IVJ7pif88jcK9kGllRcTDaP1UhbYmylDQ6eBfqlyb7uTCY+75tgfI+xWYHC0L/W/m2hUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uoqjqmQx; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2cb4d02f34cso1831352a91.3
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723150547; x=1723755347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HH4wiKA/dlO3lUr0T99J2TjnLs863zoghhyAgfAi2Qo=;
        b=uoqjqmQx9sXgVqvi3PzkUuRfdrAuUpUAz64aF2ZRM0aQahpdDB0vf0K3flFUYlG7aj
         rNbpCY4Ea5NpqdesQKER7dbj4HtnPgLY/cdZASI111dwnw3J/LcPN/yM5H9VNU+l1awc
         cUyXMNhRjQOTtFG6/VTU6pa6hik78CUp8R5fMN+pW1kJ46ccfKIRm6oNLb9/RZ6lExGX
         74ZB+h4jVbSaSJ6zB0KPGNFWErRjua6sS6WaRitEsEXutUgYsrS1EcU/nty6/1i2x/56
         Zq8j4lDfR+zRW0ct5Jk3WiTZgI9OHXWI/Tz6wfbFL8CQJCxiel2yPuKrDOLh14HjSYiZ
         mSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723150547; x=1723755347;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HH4wiKA/dlO3lUr0T99J2TjnLs863zoghhyAgfAi2Qo=;
        b=Vlv3uxcMVahm0y82XmwU4yJ6xBPTFxhPjPNCu0QEItjRM6Pfd+nmyxBLWtDwwjTr8V
         Oyf8j1UvSg4AXmKdqH8FSFjqfL6Op0MkmInrNruEaJykX0AGOyxNS6MXIIYbxSwUOb77
         uljIxehwX4arn05JBiSjxVFUWb53kSqRugXy1h+xpEkdOC8vz2sXXZibMm5QovfXgi0M
         Wpq9OM/uHyMV497vyUMyUTtz1aek48nIoyMz1w9kwAEaZjVyans4EsfMpDDdkjk8P03j
         WOI16G2ICsvztM66D7YYE7f6ujEQbaiZ3b5mus7frvnboONsHRQeiSTJ7M7VAIkIAM3p
         ABIA==
X-Gm-Message-State: AOJu0YyzzoQvO/LGgVC5itlW4eG9U90QdEtbK3ANA8QpCSc9sER5cCQY
	lHXFRLDGEsuqCMGHZCh89xyHORH1Jybx4VQNzXJINHm+3m+46+12D7nWvVL4irDoOyt4pSOkcA0
	AQjogkx1vCKxj0R220lAbd+4yO4mVLmPGDlyifEJgZhbVMr2Y0THSUQLzPr9Sge7wTqVRUzss/6
	lXeFdjGwe2ybV9NgQ5hLUqhQk+poJhjhJgwHtFXkb/hSsi5WjTHlnDN2iLkUUszuv4
X-Google-Smtp-Source: AGHT+IElJQJJZiVSpj2cB6IyYl/6EhRFj3ZIdsPTZjI7m5AFwQRQwr03+y3GWrN/rpWdxWIef7q7/VFVEi/ggFz2YQw=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:2ed8:59c7:f3a7:4809])
 (user=pkaligineedi job=sendgmr) by 2002:a17:90a:e2d6:b0:2c7:899a:db36 with
 SMTP id 98e67ed59e1d1-2d1c3374bafmr127314a91.2.1723150545637; Thu, 08 Aug
 2024 13:55:45 -0700 (PDT)
Date: Thu,  8 Aug 2024 13:55:28 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240808205530.726871-1-pkaligineedi@google.com>
Subject: [PATCH net-next v2 0/2] gve: Add RSS config support
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, willemb@google.com, jeroendb@google.com, 
	shailend@google.com, hramamurthy@google.com, jfraker@google.com, 
	Ziwei Xiao <ziweixiao@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ziwei Xiao <ziweixiao@google.com>

These two patches are used to add RSS config support in GVE driver
between the device and ethtool.

Jeroen de Borst (1):
  gve: Add RSS adminq commands and ethtool support

Ziwei Xiao (1):
  gve: Add RSS device option

 drivers/net/ethernet/google/gve/gve.h         |   5 +
 drivers/net/ethernet/google/gve/gve_adminq.c  | 182 +++++++++++++++++-
 drivers/net/ethernet/google/gve/gve_adminq.h  |  59 +++++-
 drivers/net/ethernet/google/gve/gve_ethtool.c |  44 ++++-
 4 files changed, 286 insertions(+), 4 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog



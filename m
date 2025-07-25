Return-Path: <netdev+bounces-210055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90639B11FC8
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 16:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7A3E1634C3
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234C31DED63;
	Fri, 25 Jul 2025 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DAcW+Rq4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0E31DEFE8
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452453; cv=none; b=AQjFFdFNKWceYo52Wp7Y2Ss+uoihpmfprukBk0R7oJ8XLypKv31UwrUS+g2SWXLv3YvAECgIuvplGmzAHYk/3gg7UHNwypD2d28mKQp0/YNvvO8azOBtjB5VMQA0bca+ZEWCO+HIJo7W8MwznJSkXdxcpAg3SXJUuvF3RWgL6JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452453; c=relaxed/simple;
	bh=kxiX32bMjkhwzhDOzkS7wrrhbw7CdmsqvWRgBEIiEqE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RmtBEXT16AgSDBXmiGt/Ocjkgrp9m5xsZBTpW5G982ZEfZUDGBmSnIIw6UKPAMZDCs4XFZ4h6GjVITdgnuAQuElgrRjldQ+o5KHy8L7UC6p4JnQJoBb6l12Or7bXtDUgUMxx8Sj3EcjmNASNZKpGq4lqG9/Wb1he1tN7ndepPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DAcW+Rq4; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4ab99d1a223so44256741cf.1
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753452450; x=1754057250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SqjWWtDB5X6C7wX10vcS09OoFSLJknYCbCBnYcDL8BE=;
        b=DAcW+Rq4uhpd+DXKOnxaZmUl+gFi5FX3daRxXLA0w4xfkMMtAE84GSUHa7jc8dZyb6
         P6oPDo0+g6vmuHsbBkq8ajMdPFMOgght4ApkOoJxlM6Crbd3ekjh9xUE6O+1m/z2xbZN
         PFwYn55OEG2i/8bbjLKy+0D//CX8kNqRLaMh4UY9WgdUe+D3BDeOekEzEAOKzskkRrVv
         r2aR7wwUuYqDba2XnqSXBjt5TEZspSihAP9NGTEjBn5dEnuCg4shqy9qOx9wkalfcGnM
         I4Ttnumu54yn/9b6b2XAjIjj2PlttAYy9GzUJvqTpeo/l8Jfwkci4psj54EmwjDhXpfb
         l+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452450; x=1754057250;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SqjWWtDB5X6C7wX10vcS09OoFSLJknYCbCBnYcDL8BE=;
        b=j/7vUWz+yfQlSpxLNMy+P6Y+AvQxKvBL20bNpXwF5uo0w6DogjpkKYUWMKSxjb03EF
         m24TNhyUdPCP4LLc18CDGGWBS4iJQW8cwQ3if1XIKE0dQGcLL6cU55iu6+a+MXuDthD1
         aPsm08X8PnCs4jGPbroke49VAUxaElxy34jqF5WPLxaQy1tDietY4ITECjc4G0W3Aswj
         U2gImB03MbFrOmnDhECQkoJRHBZQn6H9B82emp+5LlCLp2UrZjjOmVvYN1QylMs81v6R
         GmDkuA8dYmFRDJYSXNb9DR/pFMgO5DkVU4UaC7KuSQJeJxf4TL/toLxqhR4xoPTnAqsf
         UlxA==
X-Forwarded-Encrypted: i=1; AJvYcCWp35jqgaS5bk7nxjv6MZVnWARrZT0HK9geohk+4fR28yvICOmr/wYPgToElMKIVVd8gxl4RhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6W/Ugg2vzspMXMlvIfATi18UOa4Q7oSvyw0PxnpGWvZcRUiV3
	+25QmfVbV3roHDJpBK/34uds/+dKDlImkyMQICACAk5Cs8C6sPrSS9lYVhb8gJ6Y/2YxJM9vL14
	SVALsD7NzWg8JXA==
X-Google-Smtp-Source: AGHT+IERy4I0Bn1d2FJmz5HvtM0XXcKmBrzLTl9r6a9g1hlM+xj3vvvMYHNeMBHfvmzd1/iQKZ8EkJb21qo3xA==
X-Received: from qtbff23.prod.google.com ([2002:a05:622a:4d97:b0:4ab:3da2:a9b9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7f8f:0:b0:4ab:61fc:ebce with SMTP id d75a77b69052e-4ae8f00cedemr23075111cf.27.1753452449932;
 Fri, 25 Jul 2025 07:07:29 -0700 (PDT)
Date: Fri, 25 Jul 2025 14:07:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725140725.3626540-1-edumazet@google.com>
Subject: [PATCH net 0/4] ipv6: f6i->fib6_siblings and rt->fib6_nsiblings fixes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Series based on an internal syzbot report with a repro.

After fixing (in the first patch) the original minor issue,
I found that syzbot repro was able to trigger a second
more serious bug in rt6_nlmsg_size().

Code review then led to the two final patches.

I have not released the syzbot bug, because other issues
still need investigations.

Eric Dumazet (4):
  ipv6: add a retry logic in net6_rt_notify()
  ipv6: prevent infinite loop in rt6_nlmsg_size()
  ipv6: fix possible infinite loop in fib6_info_uses_dev()
  ipv6: annotate data-races around rt->fib6_nsiblings

 net/ipv6/ip6_fib.c | 24 ++++++++++------
 net/ipv6/route.c   | 71 +++++++++++++++++++++++++++-------------------
 2 files changed, 57 insertions(+), 38 deletions(-)

-- 
2.50.1.470.g6ba607880d-goog



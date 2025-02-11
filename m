Return-Path: <netdev+bounces-165003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C408A2FFB5
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC489163D5B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E6C3EA98;
	Tue, 11 Feb 2025 00:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nw+9zMQe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D0D1805E;
	Tue, 11 Feb 2025 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739235238; cv=none; b=APaQ8CC4+87fcsVehfoE3y56vssE0kVfMfu/B0bu/s60kzptyxwtZiK3jMzaKptLE3VP+wTRsSp3Ph2D5Po/xD4HSBGsUtJRZGqYcr9WQO+0RpiiYbkN/wXjUlvNSHR+bIHvmTH27IeaXXyjIHriFAlS94JYevlK74O5DeMaQ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739235238; c=relaxed/simple;
	bh=wCnfSmd1I+LIaYhvs+Imzf8kxlCDilnuZpRJiQdVYQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hC1WibuLqwpC3+v+5F/pmbqnS7SYAC9TdRH/MNb1q/0v/J/c43Hqq0uYTStK5C/5MiBEuTcGnZqWa7VXGrq/JibRjfG7vrM1iAr64WVAgpV3vZsKAKFgNYYhyKsGvjvezANKB9GaxwJqJhDJ8PQcMq8IX3QZeiWE/85xnpHHtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nw+9zMQe; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739235237; x=1770771237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j+Fp9pt5Ka/rKRY3/i3MVZppX1Zzp2ghrU6Yeqo8nbA=;
  b=nw+9zMQe6ATFICIu7zfTYBO8U8ALT8DuRdg+5Oa8dds2IiwQGxdyv/V5
   LBZvgTKClKX1otiPz03nZYe6d+bW2Y5EHgXD6lHUUhHKh+OhzoA5Amcqk
   oQrzBnPosQLLlGTP3v6G1ZGIh5qy5XnnL7EYo67VlDTJqKGy0/Mv/pqE+
   U=;
X-IronPort-AV: E=Sophos;i="6.13,275,1732579200"; 
   d="scan'208";a="471062173"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 00:53:53 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:46751]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.136:2525] with esmtp (Farcaster)
 id 962acf39-feaf-433a-a928-105237c2eafa; Tue, 11 Feb 2025 00:53:52 +0000 (UTC)
X-Farcaster-Flow-ID: 962acf39-feaf-433a-a928-105237c2eafa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 11 Feb 2025 00:53:49 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.10.138) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Feb 2025 00:53:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kernel-team@meta.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next v2 1/2] net: document return value of dev_getbyhwaddr_rcu()
Date: Tue, 11 Feb 2025 09:53:34 +0900
Message-ID: <20250211005334.83813-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250210-arm_fix_selftest-v2-1-ba84b5bc58c8@debian.org>
References: <20250210-arm_fix_selftest-v2-1-ba84b5bc58c8@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Mon, 10 Feb 2025 03:56:13 -0800
> Add missing return value documentation in the kernel-doc comment for
> dev_getbyhwaddr_rcu(), clarifying that it returns either a pointer to
> net_device or NULL if no matching device is found.
> 
> This fix a warning found in NIPA[1]:
> 
> 	net/core/dev.c:1141: warning: No description found for return value of 'dev_getbyhwaddr_rcu'
> 
> [1] Link: https://netdev.bots.linux.dev/static/nipa/931564/13964899/kdoc/summary

nit: We usually use

  Link: https://.... [1]

, a bare space (not %20) indicates the end of URL.


> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


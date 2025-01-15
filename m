Return-Path: <netdev+bounces-158433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0CEA11D19
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EB167A121A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D141DB144;
	Wed, 15 Jan 2025 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sA4QF7jg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B69B246A17
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932577; cv=none; b=Zp9HDrU43cWocYd4/1YIgZo4je4l6DyzyfSYcePK2bpf9Hlo1Dd+wnL2X/wcd8P7ASVQKBUKTAVa4RNwmvQfZZXOrftAyWzCuJISBqwSYRotJDfC5bc3GOMTiofD5sRwmdSaa6vCZFZX4sSl+l/hdIIRIY/zmlkJDBqDkxoe4PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932577; c=relaxed/simple;
	bh=W/z1iN6pYmkByHmrnVk79YFpsMzNKjD9Fryccv2ChS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/MPJ4XwNJk4C4oDJwJep9wQPCOTv+2wUd532pZLqyRFJPAdRXt/V+7bZnfEkDqYvSAlNfXELOmR8W0/ytXQ0ORErU2ZXIK2hT8sBCdqhAFpMntbGX7miLDaeeF2g+hMrBV1qQAKK7+7Gizu7uvstTOrQvN1xBs+wURyKOi4TwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sA4QF7jg; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736932576; x=1768468576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ryz+ELzBsuplAnLYjAWiWV2St60ibo85pN+fatfS5Xc=;
  b=sA4QF7jgbiGYpovGsLnfT29cG0jC8BNuVaL6smj4oheTzNGqFkUHe4lv
   HJ2x7ITGfD55moCp8Kx8tyCiPxNDvp0l/xbjGrBVfcmF1HAc4es7quNat
   WxtKLtyzsLLrrQZTzmIYHy0e42vvC+d/3shfvoVUZBhUzFWGQCCWKGtMY
   0=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="458953443"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 09:16:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:29265]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.93:2525] with esmtp (Farcaster)
 id 78215192-d150-4181-8aab-542a231fe9a5; Wed, 15 Jan 2025 09:16:10 +0000 (UTC)
X-Farcaster-Flow-ID: 78215192-d150-4181-8aab-542a231fe9a5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:16:01 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:15:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <jdamato@fastly.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next v2 10/11] net: protect NAPI config fields with netdev_lock()
Date: Wed, 15 Jan 2025 18:15:48 +0900
Message-ID: <20250115091548.46397-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115035319.559603-11-kuba@kernel.org>
References: <20250115035319.559603-11-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 14 Jan 2025 19:53:18 -0800
> Protect the following members of netdev and napi by netdev_lock:
>  - defer_hard_irqs,
>  - gro_flush_timeout,
>  - irq_suspend_timeout.
> 
> The first two are written via sysfs (which this patch switches
> to new lock), and netdev genl which holds both netdev and rtnl locks.
> 
> irq_suspend_timeout is only written by netdev genl.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>



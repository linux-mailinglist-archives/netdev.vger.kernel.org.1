Return-Path: <netdev+bounces-161821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE69CA24312
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D73167D88
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD2254782;
	Fri, 31 Jan 2025 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="S8VrKj4s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C495C25760
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 19:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738350044; cv=none; b=CkdLPyooepenNp07uM2VFhi4AexHEIqCm2QgTNf8HcAaUmeeGtWL1hYr+8md0rBXvm2W31+e236ql3YrM6CkrGr6jTGX3Ga+7x+vKlTNExyzqq5+pQak3Rnhk+eQThuIE46i91DNrW5FswjPzUSWCYNrttG51U4V2Q2dVNrbFt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738350044; c=relaxed/simple;
	bh=5FwbvkxBPxzpWisdB+oVLZlMNPLUARGwbLDk+GYbe2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGFDQaYqQpKXsHnjqIZFy/4EpWy8Zoo/iRjviT0dUO4BgZyLsU5VevcdiZR/0xDNw0LuH2rTQhAV/N6U8EABelcVTTNvp/KQOLYBxHIGWbJ6miqH69Te1kXCZUeHTpzRJNyFgmgA4VpR8xgSG+VoCwB1Obxa2ixh0BdZMmNcTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=S8VrKj4s; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738350043; x=1769886043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wvf0UsC5XVjv5W1IsIE/TNPgnFx5iOnxbOZv1p70Su8=;
  b=S8VrKj4sH94OQUBY3cnbI52thNaEdj+N/RuvUW6Hvp4iQuZSwoNOYaXA
   ltjWg4k05JC5+RjatcMq7nb9OUSDoyU/E5gSCWap5xWmSmgnrAbABVmfp
   3ACh1V9fqLZS5TgnltraiRF8wyOy+CgZRorfT4Xglf3a+jvH1P/Yd+w9W
   E=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="267423068"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 19:00:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:60632]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.27:2525] with esmtp (Farcaster)
 id 7847226a-af53-4a95-bfa2-cae5066e86fc; Fri, 31 Jan 2025 19:00:38 +0000 (UTC)
X-Farcaster-Flow-ID: 7847226a-af53-4a95-bfa2-cae5066e86fc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:00:37 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:00:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 05/16] ipv4: use RCU protection in rt_is_expired()
Date: Fri, 31 Jan 2025 11:00:25 -0800
Message-ID: <20250131190025.93658-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131171334.1172661-6-edumazet@google.com>
References: <20250131171334.1172661-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 17:13:23 +0000
> rt_is_expired() must use RCU protection to make
> sure the net structure it reads does not disappear.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


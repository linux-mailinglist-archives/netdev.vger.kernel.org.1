Return-Path: <netdev+bounces-158420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E144A11C5D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D1B77A4588
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18511EEA41;
	Wed, 15 Jan 2025 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GLDJ2GJS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0881EEA36
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930780; cv=none; b=FN20p6oPeRsRxu7mayn2Y4ySy+FCo+SnWbzVOsFTdKo1GZpUQRHKF2zlmrEkQI3mNoXCJbXxvW0cQw6gKQPlarFjBSHn8Vht5gCVKXLyxHsdipKIBY1Gicy4yyb2GjQM5uBfLp8H881OOM1OdB5xLdB5NibMLZ8EfyEMQVXuOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930780; c=relaxed/simple;
	bh=bupKB/mSQ6eHWaBgvkBiW/8NTNX+xWhQYJeJSZRKK44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjdS0Ivq1yI8wSn5pv7iSy3k5xiGSNPZqEqLHyM+/HaedY8SADZ3tlRYIN6Sw07lCZYwy2TT3FBWfbuN2DJWu/5AR+5XQyjG1xcMw7mA+nchK69a+7yPGrQ0lWHXNWe/Q4L0IH4Puwjr5RFv7MTAkTdAQWNU2JAR7Rp2ZhEP42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GLDJ2GJS; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736930779; x=1768466779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SHGfLkmKfbZPbUQM9Xg2ENINwtPl4O+gJnUyCAujZwk=;
  b=GLDJ2GJS/I/YA5nPqjDXvxHEHCI1I5ZyGQwKd9bsOQ9qPmAfBxVQEO1y
   1AqPXz8y4eVpOZ1pmCd43S05PHHVl8MMiD4owFzpdnN3SDNGLlt0dHWoO
   qEXo/6ntHHpPXSDLAhqT/ZVkJxpv0xz6BhwqVVZTTXtmM9e+EIzRZ8sR7
   A=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="369218577"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:46:16 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:46781]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.70:2525] with esmtp (Farcaster)
 id ba549a2a-d3d1-41f0-a6bb-4dcac592d9ee; Wed, 15 Jan 2025 08:46:16 +0000 (UTC)
X-Farcaster-Flow-ID: ba549a2a-d3d1-41f0-a6bb-4dcac592d9ee
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:46:09 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:46:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <jdamato@fastly.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next v2 04/11] net: add netdev->up protected by netdev_lock()
Date: Wed, 15 Jan 2025 17:45:53 +0900
Message-ID: <20250115084553.38636-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115035319.559603-5-kuba@kernel.org>
References: <20250115035319.559603-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 14 Jan 2025 19:53:12 -0800
> Some uAPI (netdev netlink) hide net_device's sub-objects while
> the interface is down to ensure uniform behavior across drivers.
> To remove the rtnl_lock dependency from those uAPIs we need a way
> to safely tell if the device is down or up.
> 
> Add an indication of whether device is open or closed, protected
> by netdev->lock. The semantics are the same as IFF_UP, but taking
> netdev_lock around every write to ->flags would be a lot of code
> churn.
> 
> We don't want to blanket the entire open / close path by netdev_lock,
> because it will prevent us from applying it to specific structures -
> core helpers won't be able to take that lock from any function
> called by the drivers on open/close paths.
> 
> So the state of the flag is "pessimistic", as in it may report false
> negatives, but never false positives.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


Return-Path: <netdev+bounces-158426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D132CA11CC0
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE203A17A1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1816246A1A;
	Wed, 15 Jan 2025 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hBf+23QN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDEC246A05
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736931774; cv=none; b=kMYyllpaDFd3pFVvKqMmW6vXKJnGaARKP5Rf/015nhP7seVnAUZ3bjCpcu5QHGT7s/cMnVA5asB3SCoqhEBftec5Bg11GXsznZR5UQE1MdcysFBrW9nNlco0n9biOTdNfWww06jWQJszZ94aQMYJ6y0M2JdLxDUXhsit12fsD0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736931774; c=relaxed/simple;
	bh=7NlbeU6+JX9XYbXdnPH8u69fKAo27M3x6oQ1G3OZRu4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lG+9ba6RD6czZbdmh3DKZRFLlPPht7h7+tZoKzj/m00u8UfvzwwEKAbnYocXQ54fqPay8MfylDWNuj6aVRl+VyWua0hCAS8wzf1eIBhxy85BNbF7uSDj7vmsS5ryt3XZJH6xrzYEUf1koJie1zFkXclOJXsRRvb7I+dOz9mMXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=hBf+23QN; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736931774; x=1768467774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qXryafKByEyvHwYRX89absw6iir7thgBa+RFLnfsmPs=;
  b=hBf+23QNoISXDwdR2+qPTDypXIFOk0pbOcZ4vqTROar8SyvDDn7PAVeg
   RXcyadTetRMgCsqmw8Cn1+J09tQI3xRLpQ85WOTuxx3b+wETMkUMdzBco
   EqEJ+M6iQaaFuMrhBqQDt6uKqG9Ey5b0rupJo87r2l+VwTHRnUtQC9a+q
   o=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="369223282"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 09:02:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:3132]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.93:2525] with esmtp (Farcaster)
 id 2e5ad0f9-480f-4153-87d7-11f273578397; Wed, 15 Jan 2025 09:02:50 +0000 (UTC)
X-Farcaster-Flow-ID: 2e5ad0f9-480f-4153-87d7-11f273578397
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:02:50 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:02:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<jdamato@fastly.com>, <marcin.s.wojtas@gmail.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <pcnet32@frontier.com>, <przemyslaw.kitszel@intel.com>,
	<romieu@fr.zoreil.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next v2 06/11] net: protect NAPI enablement with netdev_lock()
Date: Wed, 15 Jan 2025 18:02:35 +0900
Message-ID: <20250115090235.44266-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115035319.559603-7-kuba@kernel.org>
References: <20250115035319.559603-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 14 Jan 2025 19:53:14 -0800
> Wrap napi_enable() / napi_disable() with netdev_lock().
> Provide the "already locked" flavor of the API.
> 
> iavf needs the usual adjustment. A number of drivers call
> napi_enable() under a spin lock, so they have to be modified
> to take netdev_lock() first, then spin lock then call
> napi_enable_locked().
> 
> Protecting napi_enable() implies that napi->napi_id is protected
> by netdev_lock().
> 
> Acked-by: Francois Romieu <romieu@fr.zoreil.com> # via-velocity
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


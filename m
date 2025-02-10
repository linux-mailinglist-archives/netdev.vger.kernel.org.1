Return-Path: <netdev+bounces-164535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DA2A2E1E1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 02:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8911887591
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC148F7D;
	Mon, 10 Feb 2025 01:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DTflqSFq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51011182
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 01:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739149756; cv=none; b=QVGDYpeWrH+2bVlBUDLQMk2nuzCKE+nNxlFq/IcdXQ7+p7eXxc2eDjo6STkpoS9eQF4THQR0Xdmxe8M4Wpftwi4sWUgTQoKiBrLRr/+/suhdco9sHfF+GLETfI6k3gzBe5TcrI/+nnfWrLkm/E7t/hKlY/y3DFTdhNh7sa2oHeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739149756; c=relaxed/simple;
	bh=euuwPj8pbRWKKiBhXkAXtWjDRA82UZYj/2GWbFr1Uwc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZbqQhdmJi8lvlg2dwjndodh6nzu3CnCIDlFEabOzQjc7HWcOzyRk+uzb2hiNwcPmWzc2YXKm+6pXn5vL5cxdTkRC4RSZERGlZM8JkCI/ZgIq4Is0Of8OiQmIeNbx/2GWJx84eOKlCSlKEDU/q+QS6OG3RGqrnMxeG6O29q60KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DTflqSFq; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739149755; x=1770685755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e5qhydwBp2ArDrwOzoBEiYakx3EswFGoIEYrGHUsQx4=;
  b=DTflqSFqlcK7H5UHISXFzUWCreioWXZbBmJFEVnORkqH9TYDYRGqjSkK
   WkKgtmoWyPdXNsl/CGhZ3g7oQVBP2OvumghGs31K7zeS0MxjePYmFumaA
   oYRTyI70dFXZ1bZQYeQfAOLaeKsbnMUQZDgNiUq9sfO2vxz6fTF+4HwoW
   U=;
X-IronPort-AV: E=Sophos;i="6.13,273,1732579200"; 
   d="scan'208";a="461072950"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:09:12 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:13532]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.27:2525] with esmtp (Farcaster)
 id d12e06df-ca85-4879-8dd9-7e3c2ad61638; Mon, 10 Feb 2025 01:09:11 +0000 (UTC)
X-Farcaster-Flow-ID: d12e06df-ca85-4879-8dd9-7e3c2ad61638
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 01:09:05 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 01:09:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <ssuryaextr@gmail.com>
Subject: Re: [PATCH net 1/8] ndisc: ndisc_send_redirect() must use dev_get_by_index_rcu()
Date: Mon, 10 Feb 2025 10:08:52 +0900
Message-ID: <20250210010852.53073-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207135841.1948589-2-edumazet@google.com>
References: <20250207135841.1948589-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  7 Feb 2025 13:58:33 +0000
> ndisc_send_redirect() is called under RCU protection, not RTNL.
> 
> It must use dev_get_by_index_rcu() instead of __dev_get_by_index()
> 
> Fixes: 2f17becfbea5 ("vrf: check the original netdevice for generating redirect")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


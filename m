Return-Path: <netdev+bounces-161816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 646FEA242F5
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F126D1889CC9
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D231F03E9;
	Fri, 31 Jan 2025 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BxcPtmiI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD17E1A8419
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738349488; cv=none; b=sIPQxns+w04cMQ+QciK2YYtwlIkntbNk0W2vpldY94ruiWhhw/egry1D5qFIXhT22Eo7Zt6IlEcYi3XwK77XMnKmgGk/qa+lYU306aHAVvDz7wKW2vN9jRKiX82uP/pfNbfZMtp5n/uBJB+7ffMyg6+tKqDTiFPWw7gMbNzJhO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738349488; c=relaxed/simple;
	bh=6FSRkCRsZIaiapma8W3UF8P1w/pcJO9E76x76+vRNcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQWWdbrZWJZ7OW6JYmGiO26bHy8txm5UQ7G6UADinCRozajreuPqJHWekKHjXX7KwDsYGRDOGCNWj181Rh2Cmx4eELqJIVCl5Awaz0GxNtziL+QvPk3K+MD6YD3O+kh5z8WXbozHw4pk0tw6DQMn1GKq4MJ1l9vMhTyNndpZhRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BxcPtmiI; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738349487; x=1769885487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5wryPyrQqbPtHVu9QE+WuoR/9/DNqNNyGMlaH508Yr4=;
  b=BxcPtmiIyYVmO8LOtBS2/BbAOUk9vxvH62WQBtuZO+bqE05o/ngHm/ip
   muBpTB+HuOHmHnzpYF3jwjrAsxP+tvcwva03dLRHEi3o4PiwrlCbgQd7W
   WNFLts5fWH6oUmBSyJG6BOjDmgx6W8ULUkIEMp0ooDemP4Q+jpVMOKEc9
   U=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="468423747"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 18:51:21 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:28972]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.41:2525] with esmtp (Farcaster)
 id a4029d5d-5e28-4625-908b-c321be4bf613; Fri, 31 Jan 2025 18:51:19 +0000 (UTC)
X-Farcaster-Flow-ID: a4029d5d-5e28-4625-908b-c321be4bf613
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 18:51:19 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 18:51:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 04/16] ipv4: use RCU protection in ipv4_default_advmss()
Date: Fri, 31 Jan 2025 10:51:06 -0800
Message-ID: <20250131185106.92839-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131171334.1172661-5-edumazet@google.com>
References: <20250131171334.1172661-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 17:13:22 +0000
> ipv4_default_advmss() must use RCU protection to make
> sure the net structure it reads does not disappear.
> 
> Fixes: 2e9589ff809e ("ipv4: Namespaceify min_adv_mss sysctl knob")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


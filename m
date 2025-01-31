Return-Path: <netdev+bounces-161825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 811BAA24325
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613913A7CE1
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E4A1F0E53;
	Fri, 31 Jan 2025 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RCHAM0iP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1926754782
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738350799; cv=none; b=dkhC2y/7n6bqwQ+TUsNqm3pg7OJgGfGz67PD0wQ1aus51dYwVs3HkjPDouUCJDO/BkVg5KwKa6+3fKa9W8KDywIe2eamA+Fty2oGE2kOms4OWhEU5MtLb98DCYZCwtQJCrog0h7cezoUYC5lIC5EJSoIatedr9KA/7nN4bjsIJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738350799; c=relaxed/simple;
	bh=I0tolol4rlLVhredn2HC0nbzGKmvvkNAAW0GT5D/cHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VeiVr1GcLNluwtmJsTKTWtngBHB4gK7ZTjXxyicVhvOxqic2qdNq8hV1KQgJU6l/w6Qt6PV9vCAOMfNiE124AMNGh5BxZkI0IJp9VLhrKkMgYvm8k491/iDIQk8UWNGlMclhSbPPdZwVIyFWkAEAe/YMcT+oVBv/614V9vSeSrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RCHAM0iP; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738350798; x=1769886798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bl8FACOOM8SeBTTl/xLU2Mik/vHmFhJl4mir/2AjR1E=;
  b=RCHAM0iPlQnIYahxImxKplX2wuk47OWxcZ9r212gdIKXnx+iFzGgugyo
   xzGcqnJqC4iIR7wTRifuTXjVU3gl7YIDUvSReUE6BhcX1HOo41d1pyObu
   7+ws1VEuOzzBtKh46RrzUazXwru75KpD6gPTeZwawE1E29QDxBn3LpZhl
   g=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="463137778"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 19:13:15 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:2520]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.242:2525] with esmtp (Farcaster)
 id 01129028-0f85-4993-8569-e9e5f4e7ee9e; Fri, 31 Jan 2025 19:13:13 +0000 (UTC)
X-Farcaster-Flow-ID: 01129028-0f85-4993-8569-e9e5f4e7ee9e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:13:02 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:13:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 09/16] ipv4: icmp: convert to dev_net_rcu()
Date: Fri, 31 Jan 2025 11:12:50 -0800
Message-ID: <20250131191250.95445-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131171334.1172661-10-edumazet@google.com>
References: <20250131171334.1172661-10-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 17:13:27 +0000
> ICMP uses of dev_net() are safe, change them to dev_net_rcu()
> to get LOCKDEP support.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


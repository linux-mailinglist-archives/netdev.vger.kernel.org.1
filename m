Return-Path: <netdev+bounces-183077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E40A8AD11
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D805443FB1
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071361E2834;
	Wed, 16 Apr 2025 00:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gkamztiO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779071E1DF2;
	Wed, 16 Apr 2025 00:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764880; cv=none; b=Tdb8yhTqFiu+klSRxHPZNk9EbjrgcM2BwI5zRoi6e13jReyGgDYw2FyEnOKd40C9gZkRspUUENB3tenL/PDE52xJejQIDiveQyhKzy3oeMd50i/DjIpZ8Ntq6Y2W/m+sEM/CtNYcnsrXUhUDwdMs8bcx5ahsMsWSiWJM+x66owo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764880; c=relaxed/simple;
	bh=IbDGs4PrOFaR6HXQoi1ilycK3t3OokJnQ3jcs7sXOLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKgQsEU63Mf6ZxWUCQHsKM4xhKUUV0nNbuaoG0tw17zpJi9NDU0eYCq4mbrgxMhINZYn8qm84zKqx8CwAgcsJGgCFEIGokqQb8FaLtY0Hgwm5qttfXKBZHtQ3bs4qQpU9QU4fXPGvDvY/UJELXOYJkasXSGmFUpE0bx/d+ySEew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gkamztiO; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744764879; x=1776300879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NN+5O8f4or8dFne7Nf9kIScYOPRq4oJrZau92nZz2cc=;
  b=gkamztiOC5MQdEk3Do3OKTJNCZU5vS7PatDJpHid2k/VMxMG2H/3Q1Kq
   G9eznaBsMJQH3RNHI8TW+7yZEFE4TVqCDZeeOkfNiwNAzFQ8E3MImshA1
   Y4SHbpvRKCIWxgyMP0pqhY47VcKhwD0JTYZfyX0W6kPiHLbMWjX07fz87
   A=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="191458062"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 00:54:37 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:40313]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.140:2525] with esmtp (Farcaster)
 id 3e787dd0-f8a6-4dfd-bbdf-58b5855a0907; Wed, 16 Apr 2025 00:54:37 +0000 (UTC)
X-Farcaster-Flow-ID: 3e787dd0-f8a6-4dfd-bbdf-58b5855a0907
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:54:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.149.87) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 00:54:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <horms@kernel.org>, <kernel-team@meta.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/8] ipv6: Use nlmsg_payload in addrlabel file
Date: Tue, 15 Apr 2025 17:54:24 -0700
Message-ID: <20250416005425.22127-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415-nlmsg_v2-v1-1-a1c75d493fd7@debian.org>
References: <20250415-nlmsg_v2-v1-1-a1c75d493fd7@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Tue, 15 Apr 2025 12:28:52 -0700
> Leverage the new nlmsg_payload() helper to avoid checking for message
> size and then reading the nlmsg data.
> 
> This changes function ip6addrlbl_valid_get_req() and
> ip6addrlbl_valid_dump_req().
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


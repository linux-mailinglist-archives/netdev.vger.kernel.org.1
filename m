Return-Path: <netdev+bounces-183937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A9AA92CC1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A000A444B1C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A8C20B7EC;
	Thu, 17 Apr 2025 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QxfgG6Ll"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D621DF756;
	Thu, 17 Apr 2025 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925818; cv=none; b=QGY4gy4kJFbycUPCX6hrkJiNax10t4GXtJHEOvC3gfDW6Qd9OXCuPioRsRp5D1+Kbq4iMDw4lYIzF0Dq5PrqSMSsZS0xXRCPEdvCTGNUeEWBcjK0WZyjh4fWD64xzQnrB70jZxZAYNHSwvOmaJ0njd10FPv+ZxYPa+eS94h0Bzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925818; c=relaxed/simple;
	bh=hqaw3k7g0UO7sTcEgs7fXoq+uaX8F4h+P404DSZ2kAw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iN76lC9d8jgE3uma9yHV6aRrtxsLJBXjb/gkkSeoI/3/RGAN0OWdL9de+yCTsBCTxkCHglCMxVjpbqZpt0Eew3Y7KZMnq8pWqQl7u6IRmiwiR8PwIRgTeJ18ZZ1GWrCg+NC/T+OXgr1BXGTYcoNaAb7PiRyPTlWLrc6xgWAYxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QxfgG6Ll; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744925816; x=1776461816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I+vW1PIaSldpoCiESfdZkkd8QMcNuuxnJ4cgcZwI9Zs=;
  b=QxfgG6LlMU0Tk+S66HfhjeczkvUd80hKf1e4xbzoWpt1nkI7W2cg2kYF
   NeLDvCezmXNhUz033G1s6kWEph9MrQyEXKrJjZCIhtc7XA6oLzPTu/nqG
   zOoD2H7cpdR4nEnbfmbIkWIDk9fRrWE1+sHqMHTmIgACFRX9Bxyl9JbK9
   E=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="396845048"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 21:35:46 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:11278]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.65:2525] with esmtp (Farcaster)
 id f4682754-45dd-48de-9739-0f441254e43d; Thu, 17 Apr 2025 21:35:45 +0000 (UTC)
X-Farcaster-Flow-ID: f4682754-45dd-48de-9739-0f441254e43d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 21:35:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 21:35:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kernel-team@meta.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] net: Use nlmsg_payload in neighbour file
Date: Thu, 17 Apr 2025 14:35:33 -0700
Message-ID: <20250417213534.19088-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417-nlmsg_v3-v1-1-9b09d9d7e61d@debian.org>
References: <20250417-nlmsg_v3-v1-1-9b09d9d7e61d@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA002.ant.amazon.com (10.13.139.113) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Thu, 17 Apr 2025 06:03:07 -0700
> Leverage the new nlmsg_payload() helper to avoid checking for message
> size and then reading the nlmsg data.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


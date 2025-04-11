Return-Path: <netdev+bounces-181825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7C4A8684F
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39AF03B1C0B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185CA29AB04;
	Fri, 11 Apr 2025 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mCwF0l8t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D90428F948;
	Fri, 11 Apr 2025 21:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744407020; cv=none; b=QUCTZS4dv1mztj3kvsmJ14j18mG3dAYMlKUJY16P+8T1T/HT9UbLJ/vu3svsgn2ZWZP4VMwMhG/cg75JzdZDPdaCeI0z56YP3ev2RXj/dcvQqDcAiVFJQqKBbW+DQCFh920KLFHa8xZNKdAviL6rIu477X59mWVtgCQ/m8op/fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744407020; c=relaxed/simple;
	bh=XVxw6LOgWRpGJiGsthLSryBgD3+rmO3MGOkkcc3ZEko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3jgaTMxMM2BLtrBOevP5HmC2tIACMzWKUfxuiCvxNPC2uLkr1jWr+ZVi15Uk+PHRuqOo5Fi43HRLYXKNvyCP56zwhD2Hryc3amsWSh1TF9Zbpl5nr0UBfoYRyg7wcHKjMONsNebs4J06WBnMPIYrkjwxjdLSr8NvZKwBt3q9Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mCwF0l8t; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744407019; x=1775943019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6s0hdPerFls8LLlhcTti2w0fnB1wx/SYJN/ngrhN6LE=;
  b=mCwF0l8t2OHYD13w6f7NHTc0pHL2w0AwKpQ1c7Soza0az2zvGHL1o4VG
   I7iBzcnYlIkfL9gHmPbz6xSkNQmAeywfI4+mUd0ku+eFAQXJhz9CHN9VX
   wgIVHQl/soG2kBE5JdPHd8qI5Oa63ci9mp8fI9B/21u/yeY5E/44qUJ6w
   8=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="713178947"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 21:30:14 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:9921]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.195:2525] with esmtp (Farcaster)
 id 5dee78f0-868d-480d-8c35-29481329231e; Fri, 11 Apr 2025 21:30:13 +0000 (UTC)
X-Farcaster-Flow-ID: 5dee78f0-868d-480d-8c35-29481329231e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 21:30:06 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 21:30:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next 6/9] ipv6: Use nlmsg_payload in inet6_valid_dump_ifaddr_req
Date: Fri, 11 Apr 2025 14:29:54 -0700
Message-ID: <20250411212955.68593-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411-nlmsg-v1-6-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-6-ddd4e065cb15@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:53 -0700
> Leverage the new nlmsg_payload() helper to avoid checking for message
> size and then reading the nlmsg data.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


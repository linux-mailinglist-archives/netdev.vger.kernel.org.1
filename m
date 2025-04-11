Return-Path: <netdev+bounces-181831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CCEA86866
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30F61BA52BE
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA5C298CCF;
	Fri, 11 Apr 2025 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Sjd09v6g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A10429C341;
	Fri, 11 Apr 2025 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744407609; cv=none; b=FcP5mfGFBtDAkWYDpXflBOooe4Ai9A8P9ZO+QMEAWs+jnHq9rZ7PWWG7KiT1yDCeSIIV9mdEl/TUQWtjAojubRY/eJTAZIbQOJ3T4rwx7K7KZlhPqeE6UcH749StrTSM8Rlk6QxZa2lvm8ket04WEIgrH4tHT/WagkbU7qi1Cbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744407609; c=relaxed/simple;
	bh=Mt2a35I53jsu9A544us224JUQZYKbTtpjaa7xvCQZDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7TuGj38VqkNI25rOfFkJkiL3CHQlOulA3b4caWb4VbQZEIbFCcYW7l9dHt/dozg/zaQT2gdYEg4xc8K4qFcAgi27exBNicKLJHkHwcEKRk5WBNbcKaRwlnlTZJOiXwlx4yU9alVoVFjuLf7Iw5u/yVH4+gfO3uiqd2OoIagLKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Sjd09v6g; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744407606; x=1775943606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iYHlqbx8y4PJSxEmStgrxa/NvcqvsYcwrtj/7zDr5Ng=;
  b=Sjd09v6gMtiNZzlVbXJHABqC8pgPI9x7P/g000r2TdztiLxN+hFaMMQ2
   7v8AuBs0RwjKwNYKkJa29E8XFKCiSgqxtr/Hp66WhfPmcx8QFyALG3g8u
   DYSnco7MrT2U2E4d2mON+9Hds4lYujxuZ/AQZgmTUAgqUCLfLYiVMqRWW
   o=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="39955674"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 21:40:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:14500]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.140:2525] with esmtp (Farcaster)
 id d6ccd4a2-5534-4ca4-8b82-1bb447317d6f; Fri, 11 Apr 2025 21:40:04 +0000 (UTC)
X-Farcaster-Flow-ID: d6ccd4a2-5534-4ca4-8b82-1bb447317d6f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 21:40:03 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 21:40:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next 9/9] net: fib_rules: Use nlmsg_payload in fib_valid_dumprule_req
Date: Fri, 11 Apr 2025 14:38:01 -0700
Message-ID: <20250411213952.69561-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411-nlmsg-v1-9-ddd4e065cb15@debian.org>
References: <20250411-nlmsg-v1-9-ddd4e065cb15@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Fri, 11 Apr 2025 10:00:56 -0700
> Leverage the new nlmsg_payload() helper to avoid checking for message
> size and then reading the nlmsg data.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

You can use it for fib_newrule() and fib_delrule() where
nlmsg_data() is prefetched.


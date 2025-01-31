Return-Path: <netdev+bounces-161850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C74B3A2436B
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68777188A28C
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7B114C5AA;
	Fri, 31 Jan 2025 19:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Zsn0dhEG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6531828373
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352247; cv=none; b=e13TAyX73C5NDKK38inyNf7nEP1WKEWXu0IahCS2uBzAuS5bxsIPR7b2fbHuRM/FkazVyteBmSx+3g/JLenzqW7GRalSUibk1tXoqtf4FHaQ42MJjyfzw2HTC/T9dmlosgX0X5hgoBApFlac+spj7Gugq5q6R9b5A1WbZzIFVyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352247; c=relaxed/simple;
	bh=lhBjsrDjvqt2tPnOVwxQSERdXKrfnNi1Dw46vrZyiYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cURGE6lOSSv/LRy07KNUgXzgHqzpd/lunCyeDDupMtq4QuRzESiwKAgrcpSGY5TxjXzApzMjJvCeFRTk0HUK3+iAZO8+/zPWiXfluKGz+H6GiAh87yIarUifrLAzt2z7KFdT3CzKwPr4ivyjR887gRV6cIQntClbY8NgJpst6aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Zsn0dhEG; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738352246; x=1769888246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aPlJXnwItP12RY/h6iE6SfFQPCLpPuNEA978K1Q5ank=;
  b=Zsn0dhEGtuzDLbdUvIlncYIiUWNrKA00BiwiPLDkEHuxUNpWsrOuKhld
   9ajDeo6IEpRklRdxHbNGW/rIEoF8BNkTW8ZEcY6VtQHgQDzmiy5hseCLU
   CIy5r5KwJMYI+BK00pNoSPee8mgdm6P70FMuu5GD38N2Tk//B7jX40iBZ
   I=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="373522932"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 19:37:24 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:55578]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.242:2525] with esmtp (Farcaster)
 id c4ee30be-2cbe-4b49-b841-c050ef2aefe8; Fri, 31 Jan 2025 19:37:24 +0000 (UTC)
X-Farcaster-Flow-ID: c4ee30be-2cbe-4b49-b841-c050ef2aefe8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:37:23 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:37:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 14/16] net: filter: convert to dev_net_rcu()
Date: Fri, 31 Jan 2025 11:37:11 -0800
Message-ID: <20250131193711.99152-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131171334.1172661-15-edumazet@google.com>
References: <20250131171334.1172661-15-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 17:13:32 +0000
> 
> All calls to dev_net() from net/core/filter.c are currently
> done under rcu_read_lock().
> 
> Convert them to dev_net_rcu() to ensure LOCKDEP support.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


Return-Path: <netdev+bounces-169171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA69A42C90
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45F1174C51
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CAC1FFC56;
	Mon, 24 Feb 2025 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FdAcFNF7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725C1FECD5
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424671; cv=none; b=mjyOxIRzZFIzead6VaQCRFcOt+fHXSc6P0MQytvU/ky6CeqFLCaMmeg4OlO5ZRu2j9pDcAq9gHzKAXyd7v6SoxPsuup2VHMoJmbYT3fY5lRxKN2o47oc6X1IyOKizrN0wi1lJzKdv1R5R6lPmlXpNNr+1uIEhy1aKT3dt7JnUgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424671; c=relaxed/simple;
	bh=bUWK8l5gYIguME8vJzYlwyCxo6qiVuoCXzW7Ml5FjjU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OiErNuh9yGByc/4Ie8fjFoKwH0CyAYRfNV/kImMydYMuTYzkN8pmNNYNq+gGUC3Engue/PuQaXqAHWMGm81qrbEHpnl8k/Q9UYxTDti3si0OPDsi++dKDm3UQr4tI+JGS8lkLC7DSqud8P/XKFQ0e0SA6u+xn1zYjugWcSBHZUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FdAcFNF7; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740424670; x=1771960670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1B7gOb+VXTeeZXN+t7SZ8gts/WvHKQv6jz5sYF0KJBA=;
  b=FdAcFNF7OtAHblTWZzQXux7XxVNye2hqvjOrfJZV7ZvGMcBvxyJQI150
   1Ts143bQTjmKwN4rMGSZP56Pb0X3FK8Lg95JfqJhSuz0EztvZ3gSEUV4l
   75ATKU4/AGTgp/GAF3gm53YkFbuX/NwXv2GYwG1gypl4M/QKkHlzQJJRj
   M=;
X-IronPort-AV: E=Sophos;i="6.13,312,1732579200"; 
   d="scan'208";a="273938525"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 19:17:46 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:17631]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.70:2525] with esmtp (Farcaster)
 id d31405ad-8d3b-49c5-9fd3-6c95802a0764; Mon, 24 Feb 2025 19:17:45 +0000 (UTC)
X-Farcaster-Flow-ID: d31405ad-8d3b-49c5-9fd3-6c95802a0764
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 19:17:44 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.221.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 19:17:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <nicolas.dichtel@6wind.com>
CC: <aleksander.lobakin@intel.com>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <idosch@idosch.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 1/3] net: rename netns_local to netns_immutable
Date: Mon, 24 Feb 2025 11:17:32 -0800
Message-ID: <20250224191732.78895-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250221133136.2049165-2-nicolas.dichtel@6wind.com>
References: <20250221133136.2049165-2-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Fri, 21 Feb 2025 14:30:26 +0100
> The name 'netns_local' is confusing. A following commit will export it via
> netlink, so let's use a more explicit name.
> 
> Reported-by: Eric Dumazet <edumazet@google.com>
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

It seems this patch does not apply cleanly to net-next.git and needs
a rebase.


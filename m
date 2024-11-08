Return-Path: <netdev+bounces-143106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 119EF9C12DD
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99CDCB2275E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2C838C;
	Fri,  8 Nov 2024 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oJcvlL7Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BC44C8E
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 00:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731024159; cv=none; b=trVGpOzabpWHFvezdRh3f/j3KUl/86rO1VjkEzMIzMBIewQQJZemzpHU+ljrsaW7g+t52BQmOKy+wdMvXCr30tTIquC5ev72bjsT+BBEs3Q16C7vcIQKtcGDZzrbTlDPZSXo+fhgJezvVRsu9vBNc8h/f3agq75NIlRuDF7JRug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731024159; c=relaxed/simple;
	bh=oXUGUG+9564CYpgrLnIkURdHqU8IX2iBR3MPRSRWQyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oT8x9es0tYLkf52lR2N59CBQt/t1bxB5dFZ6f54nIOs21guCKBuXyVSjNwIWd+vjKJTxGVBtNFvK/fFYZlBJdkrhOY+KeyzGtAGESR0w3K9TT3JTZWN5d8Jo/3kGmZcWNX2FI1sLaMzdwHZKGf/LFZK/sJHjXkur8GhjOJSYz80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oJcvlL7Z; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731024158; x=1762560158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PjII2ujcri3ryHuQEHgz8Tz5Lrjf9SmfY/JNNKCXeXw=;
  b=oJcvlL7ZbXTS48RdIEY9h6pEMJmHsgppITiuU5SpA6m+YzeXzINPRUHI
   wasCJlxGuLZs2RaudDy3tK7bIKP3WL131OQOXIBwdTFz2KZaXmxH6zMzh
   6b2n7DtQU1406YsXprQQW4Xvw2fUMoJj9ngcFQhbPRdH2ixVftI9gmr84
   A=;
X-IronPort-AV: E=Sophos;i="6.12,136,1728950400"; 
   d="scan'208";a="39868183"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:02:34 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:10244]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.42:2525] with esmtp (Farcaster)
 id 76595e35-3612-4449-903d-e4bea3d1a5dc; Fri, 8 Nov 2024 00:02:33 +0000 (UTC)
X-Farcaster-Flow-ID: 76595e35-3612-4449-903d-e4bea3d1a5dc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 8 Nov 2024 00:02:32 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 8 Nov 2024 00:02:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <mailhol.vincent@wanadoo.fr>, <mkl@pengutronix.de>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <razor@blackwall.org>
Subject: Re: [PATCH v3 net-next 00/10] rtnetlink: Convert rtnl_newlink() to per-netns RTNL.
Date: Thu, 7 Nov 2024 16:02:27 -0800
Message-ID: <20241108000227.25484-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241107155319.50f36bd2@kernel.org>
References: <20241107155319.50f36bd2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 7 Nov 2024 15:53:19 -0800
> On Wed, 6 Nov 2024 18:28:50 -0800 Kuniyuki Iwashima wrote:
> > Patch 5 - 8 are to prefetch the peer device's netns in rtnl_newlink().
> 
> Patch 5 did not make it to the list :(

Oh, I didn't notice that... thanks for the reminder !

It's in my gmail inbox at least, so probably something went
wrong on lore :S

Will resend v3.


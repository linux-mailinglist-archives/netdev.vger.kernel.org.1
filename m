Return-Path: <netdev+bounces-142156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD249BDA98
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C865CB21BA7
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7F37DA9E;
	Wed,  6 Nov 2024 00:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="r2YVcky3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0EF2D613
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 00:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854372; cv=none; b=HuxZm/IHnamNoXMO4HAy3kZqw7m/BB9mWYkdUJLbxyU5UV+pK+jciYzA7AXEaMVHEIriGP0ds1aS2g87OCweZ7ZCkrfNopFDxp46OfVQh44B0ZeArFDhpO+tQQueQ8WSuMRiiu4CDAaYTmkHJG/+ZBBPj9POMaVQdBQQPHAdZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854372; c=relaxed/simple;
	bh=+hTqxh2N7jZIcUQDjNbz/IAIJoQ1yIOH5tgA4NYW26w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nV+XHaXVNAuplv9IUbpzbDjSFcyLZB+mI0p2ewG5RlZuAjyJKd6enMQRbUl2vOfxx0CdWAIrcxydbAQEnrypdYxQuC/u9/qLa6oRimmXp0ZDSMC8jn5qCKshGmBUrKdOk7xlq4veFjdzgsYGzJHPde+qRGfa6HKA8rJOtwxkStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=r2YVcky3; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730854371; x=1762390371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pgqmTSlP/0yy0qHCLhlKn9xFuQIgDBodKW2AN+Ie+QQ=;
  b=r2YVcky3lQbQqNqOSyDlBHt0P+Hms8Cm5JaFcmGY1E4u71RTMkqs/Yxd
   RO8uOlEW9HP8a5Qipeo3aj57cL8p1dhH8g6xmtUAi6mTDyUk+hdSUeM2+
   5z8w03yH6EXx00cQ/NPy5iwX2L8/FtCkpl5okWd+xfnAhId+PKrp/qgH1
   k=;
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="scan'208";a="382751523"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 00:52:45 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:18757]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.125:2525] with esmtp (Farcaster)
 id 88c9a5bd-6e75-4e83-a8d9-a4c05af73cba; Wed, 6 Nov 2024 00:52:43 +0000 (UTC)
X-Farcaster-Flow-ID: 88c9a5bd-6e75-4e83-a8d9-a4c05af73cba
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 00:52:43 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 00:52:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <mailhol.vincent@wanadoo.fr>, <mkl@pengutronix.de>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <razor@blackwall.org>
Subject: Re: [PATCH v1 net-next 3/8] rtnetlink: Add peer_type in struct rtnl_link_ops.
Date: Tue, 5 Nov 2024 16:52:37 -0800
Message-ID: <20241106005237.2696-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241105163957.34e07588@kernel.org>
References: <20241105163957.34e07588@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 5 Nov 2024 16:39:57 -0800
> On Tue, 5 Nov 2024 16:39:11 -0800 Jakub Kicinski wrote:
> > On Mon, 4 Nov 2024 18:05:09 -0800 Kuniyuki Iwashima wrote:
> > > +	const unsigned char	peer_type;  
> > 
> > technically netlink attr types are 14b wide or some such
> 
> I guess compiler will warn if someone tries to use < 255

I chose 1 just because all of the three peer attr types were 1.
Should peer_type be u16 or extend when a future device use >255 for
peer ifla ?

  VETH_INFO_PEER
  VXCAN_INFO_PEER
  IFLA_NETKIT_PEER_INFO


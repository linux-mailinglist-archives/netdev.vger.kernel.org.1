Return-Path: <netdev+bounces-142152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B029BDA7F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00481F23980
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26521311AC;
	Wed,  6 Nov 2024 00:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="orY0rrPK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1686088F
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 00:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853875; cv=none; b=ksCXSqnNCGqp5F2PFk1IlnlqmP8ZOY7fBYsGFsljZcSjnzijQugy1zDFqco+Yp6jIxLhxPF9X++phHK+9DXkOZhBsZhyV3W2F6OTiQBoNPMVvVElwVoIDDJNl3cqyBVRgHGyqNZdTMwcN/yCwmjE7i4uxwdTnt1IIpTGhrCmDOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853875; c=relaxed/simple;
	bh=QaIPViRsns/5cDXHERIIY5j5oCLyZ5gXn4e8iw+vnvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hHan4gJDgERLEDJdsXh8u42Fyp3QMe/8pn+nNWh3DF9Qhz4GiJMF3UML9mzW/pHg7aATszsgPcvUF9nVVqVC7Z0dV+y46yIGbvnnANgM43c+mUAUMOt6FROBpNcja0/Kemh/OmGFDO/xj9zNv3oby8VvDSFhqKwyB+ftWlMrsJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=orY0rrPK; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730853875; x=1762389875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RKQkylrsX/UkuSZ7P7+AEtJocnJrMZ/aKLihnpBX218=;
  b=orY0rrPK7/62N8f05l4yBB0mmz+ism+vRCJGx2jU4V2NASM3OyrM3Gx5
   PwHlHMFaggMglHzXxbJRQWozr+8kaLJfNRA2OWGRoAsnx5q6OooCPex8t
   aoVE61ja2bpm1491qxVmDY9dNa6lORrSn1OcMp7XrOs0KgSYWvB7quWyp
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="scan'208";a="446691895"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 00:44:31 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:24236]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.130:2525] with esmtp (Farcaster)
 id ee54747d-d643-40e0-8c50-ac28dd66b422; Wed, 6 Nov 2024 00:44:29 +0000 (UTC)
X-Farcaster-Flow-ID: ee54747d-d643-40e0-8c50-ac28dd66b422
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 00:44:29 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 00:44:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <mailhol.vincent@wanadoo.fr>, <mkl@pengutronix.de>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <razor@blackwall.org>
Subject: Re: [PATCH v1 net-next 2/8] rtnetlink: Factorise rtnl_link_get_net_tb().
Date: Tue, 5 Nov 2024 16:44:23 -0800
Message-ID: <20241106004423.1802-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241105163707.7d90b418@kernel.org>
References: <20241105163707.7d90b418@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 5 Nov 2024 16:37:07 -0800
> On Mon, 4 Nov 2024 18:05:08 -0800 Kuniyuki Iwashima wrote:
> > +struct net *rtnl_link_get_net_tb(struct nlattr *tb[])
> 
> "tb" stands for "table", AFAIU, it's not a very meaningful suffix.
> I'd suggestrtnl_link_get_net_ifla or rtnl_get_net_ifla
> ifla == if_link attribute

Will use rtnl_get_net_ifla().


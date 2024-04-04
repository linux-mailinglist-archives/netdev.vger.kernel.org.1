Return-Path: <netdev+bounces-84778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 572B98984FA
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 12:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1551B1F245A6
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB88C7605E;
	Thu,  4 Apr 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="B2ZoEfOJ"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F312F74C09
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 10:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226567; cv=none; b=U2YxjXeu4kqV6bA4bK9Ft4gQGD5czmokswvXZ9Gk0UYzlnSi/nyT8ijwwKrbCmbqjZy2cURL8RtF6q3JZTcV05QV4jnGULsG8A7ZjIKOSDw8jMADz6EiHQg7poH7adQ3elgUv5BSIjIel3YIHhIUzWUDrZUYkoomI6bMezcn2B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226567; c=relaxed/simple;
	bh=Gtp2SksObY+NDzFHW+admBazrIh1OAW1HfcekLkJhTM=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kle69/lSLeS2W4XIu55cvVSq0HVeixUXZYe6PdZ6Z6MaPU3UUdC/Rtpyy9fSvUGyXjqt6F1t2QmCVpShrK+lvOcT4y70nGB+n0YywZiS6x9yQO+2OAw5c9mZRto9qNfM0UEhwxjAxusyouEqyUOLJjrWqp9mgG7hCZcMSg2M1ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=B2ZoEfOJ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E926F20868;
	Thu,  4 Apr 2024 12:29:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UUOqVG8tSbEN; Thu,  4 Apr 2024 12:29:22 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6F6472082B;
	Thu,  4 Apr 2024 12:29:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6F6472082B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1712226562;
	bh=xv4ss5dd2SBzbUNnCevGXbgiBGUEu0NCBz/IfybDPN4=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=B2ZoEfOJoWhKJlknitHgzRnEtUi1uRDzQ7DuAEQZSUaPPQm9TSCgYDlN0OEddukFe
	 DcaApd4Nw+KkHg3vFQI/HQ7MlNY5afxOvD4WUQ/ZDu1E4cH6yfXiNMgzeeCQvCD/HZ
	 KZA1/fEGgWLv+Ae96HW8oJ6iUam4IkTzIJYb6mCGkDxBtulOClpEB57OMvY5KDm53l
	 vJZvO2/ZDCxFHhqU5VK2rUToeNhThJmkl5qq5PGrZFHaKghmQv8lJP8Q+2fSl4AVX/
	 gKVwJm4juViwBpKcU/83P/dhtynF4pYNwsr/mLD6vkez4qJDsPFe+9AurgR4HN2NSh
	 buLqATaO0eXsA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 623A680004A;
	Thu,  4 Apr 2024 12:29:22 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 12:29:22 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 4 Apr
 2024 12:29:21 +0200
Date: Thu, 4 Apr 2024 12:29:16 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Antony Antony
	<antony.antony@secunet.com>, <devel@linux-ipsec.org>, Tobias Brunner
	<tobias@strongswan.org>
Subject: [PATCH net 0/1] fix icmp error source with ICMP reverse lookup
Message-ID: <cover.1712226175.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

Hi,

While this fix is for to XFRM/IPsec case, Steffen Klassert has recommended to
submit to the net tree.

The fix addresses a minor issue, source address, from an old 2011 commit;
415b3334a21a ("icmp: Fix regression in nexthop resolution during replies").

A "Fixes" tag has been deliberately omitted to avoid potential test failures
and subsequent regression issues that could arise from backporting.

More details are the next commit message.


Antony Antony (1):
  xfrm: fix source address in icmp error generation from IPsec gateway

 net/ipv4/icmp.c | 1 -
 1 file changed, 1 deletion(-)

--
2.30.2



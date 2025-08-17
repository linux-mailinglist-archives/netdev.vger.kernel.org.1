Return-Path: <netdev+bounces-214382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB59B29397
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D39A3AF79B
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 14:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FAC29CE6;
	Sun, 17 Aug 2025 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="vNZkMSOJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19081114;
	Sun, 17 Aug 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755442070; cv=none; b=B6nao+nE9NI156++rRHwGWjJCHWNbh+a4e6tHhlX/ikoZbvcYz2fPAb152DeG6O+Lo+BUyK0yBVQ+9CRpWrvzilQSk+YCYDGBBynfSIDZixRADg4M71ZbwHDC3kw/UM6TP9K6tHTbUuCRE06lfGVJjWprDcYSYOxsX7VSh0bIDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755442070; c=relaxed/simple;
	bh=yXARakI6k03ymGQSbr4dSPhBT/iQlvYnjX8gdJUZ974=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyUZ8YuFL6YSw+RO3gSwBkOSahIrI4ku8RCS0SiOa1bUC+KRqukc2ONk1+UkQ8loQwTcUmxOmXAnJ6s5xMa6L8PagoeuDUgRXSPp6uMUbOWHm8x8fhwdsmDd4xztFNUPeEoE2FK9YLmz8LHA5bxHsmn2VATlqcJDTNF+1el7N54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=vNZkMSOJ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D612620606;
	Sun, 17 Aug 2025 16:47:39 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cKvTaERl5Ngu; Sun, 17 Aug 2025 16:47:39 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E4A122050A;
	Sun, 17 Aug 2025 16:47:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E4A122050A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1755442058;
	bh=9ZP7Ld49nJmdiuSlDqBAd2NVgX/RMSwa8yk9QwTGslY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=vNZkMSOJGKLDsy49gGXtnEW6RPfia9sMRy0aepDBUSGLsMSSxpIRZ3ouetDDnupDy
	 YGwUovdPAx5a0mq7/Vvo3trWHca0BweV14G3/ZGdtyjVugrLDGO91wJVQVQIHEnpjh
	 mEOrNjK/2YOBECgHOSXSH+O1eyzyd3owmss9b4lyuDEwMs81AFGTGdjN+lopKNfChL
	 qG+rP3eXv1SBv3dEFGcqNvm7Im+Bzebb2XBSSVrgrwwKB2pBWyfQm5OU0GKds4BZcQ
	 qPTg+nMoScqjZ+IyxTZ1zyFFFX9D8XKNPybXjTFC4zwwWMqpwV2CQ2f+tP1q+AGnRs
	 wfBxGI9H24gPQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Sun, 17 Aug
 2025 16:47:38 +0200
Received: (nullmailer pid 2608436 invoked by uid 1000);
	Sun, 17 Aug 2025 14:47:37 -0000
Date: Sun, 17 Aug 2025 16:47:37 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Charalampos Mitrodimas <charmitro@posteo.net>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com>
Subject: Re: [PATCH ipsec-next v3] net: ipv6: fix field-spanning memcpy
 warning in AH output
Message-ID: <aKHriXFxwGlTHwnq@secunet.com>
References: <20250812-ah6-buffer-overflow-v3-1-446d4340c86f@posteo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250812-ah6-buffer-overflow-v3-1-446d4340c86f@posteo.net>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

On Tue, Aug 12, 2025 at 03:51:25PM +0000, Charalampos Mitrodimas wrote:
> Fix field-spanning memcpy warnings in ah6_output() and
> ah6_output_done() where extension headers are copied to/from IPv6
> address fields, triggering fortify-string warnings about writes beyond
> the 16-byte address fields.
> 
>   memcpy: detected field-spanning write (size 40) of single field "&top_iph->saddr" at net/ipv6/ah6.c:439 (size 16)
>   WARNING: CPU: 0 PID: 8838 at net/ipv6/ah6.c:439 ah6_output+0xe7e/0x14e0 net/ipv6/ah6.c:439
> 
> The warnings are false positives as the extension headers are
> intentionally placed after the IPv6 header in memory. Fix by properly
> copying addresses and extension headers separately, and introduce
> helper functions to avoid code duplication.
> 
> Reported-by: syzbot+01b0667934cdceb4451c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=01b0667934cdceb4451c
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>

Applied, thanks a lot!


Return-Path: <netdev+bounces-280129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SELsFW5852nC9QEAu9opvQ
	(envelope-from <netdev+bounces-280129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:32:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8C743B646
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FFA73020004
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF135241C8C;
	Tue, 21 Apr 2026 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="EYyr3rnX"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8146B5
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776778219; cv=none; b=J6DmkIY6FN47974/nz2cNxf0q+SqC5E+l5jUkIHq04nsaJKou6Cr9CTXsXevDdLzDcui4510Q1xMzJgUOLpkpZOOeH/R+8B/wB6WYxf4uf3Iu22IpQ1i9N5nCwDRv5vW9QXDVu74TG2RemGWFEV9cGIZ4+lpLwDkX1eBJf57JMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776778219; c=relaxed/simple;
	bh=Rg10/P7jeWvTDfsKaq4eNKycuEwlc6AiJGZgTfZ8v6k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDbkycQUUka5+WMPQ/QJpKJa6iR5SJk1YWA3AZ0f9n7IV2EfNt9QlqugByXo4RAL7iaGIhnEtIrC67WcRAVlOrJhFFLHK9SuWt/4ywC4xjOF7omuYL8auqd7omeudwZ94kCf0yOWbGZRGvgDegWsgTfIwZVOuAi1pfaTJPTlPmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=EYyr3rnX; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id D890A20868;
	Tue, 21 Apr 2026 15:30:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6gfYB6jFmBsq; Tue, 21 Apr 2026 15:30:03 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 76DBD207B0;
	Tue, 21 Apr 2026 15:30:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 76DBD207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1776778203;
	bh=tQPZkFrq9KzOVxiVwskoe1/Q5vcJjMH6EktytjGasTk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=EYyr3rnXcNjN9hcGb09GjBm1fKf1idzrwYPuAeb7IXkYscSHBPqs8UVF6JmJZomvm
	 CCkjXMTOcthNFQxU1AMdNWXxte4lYf1w3Von9AJKHmMQ2DZjCT4tKubCq2/RoTfUh7
	 A4aZ/IxHen4eeZ+MLwKIliv7pAoucCa4Zy2csEn0F4vfXxitVcrpxMKDaPNc4HzqDJ
	 knMZ/HYS2aAXYsdK+4Ybi9KVXcflv5kIaNVQV7w1Idw7iUPlSGozk2JJmnGaoi9wxz
	 jvk5vOt9S+a6doPBA/Hi2cWFqcVuVB0QmJwUQrzYN0IHr4lnfojlphHTKr6LRgVQrD
	 kFXEWAep4oLwQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 15:30:02 +0200
Received: (nullmailer pid 3292382 invoked by uid 1000);
	Tue, 21 Apr 2026 13:30:02 -0000
Date: Tue, 21 Apr 2026 15:30:02 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Ren Wei <n05ec@lzu.edu.cn>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<sd@queasysnail.net>, <yifanwucs@gmail.com>, <tomapufckgml@gmail.com>,
	<yuantan098@gmail.com>, <bird@lzu.edu.cn>, <caoruide123@gmail.com>,
	<zylzyl2333@gmail.com>
Subject: Re: [PATCH net 1/1] ipv6: xfrm6: release dst on error in
 xfrm6_rcv_encap()
Message-ID: <aed72ja2qG0s1xxX@secunet.com>
References: <cover.1775886482.git.zylzyl2333@gmail.com>
 <fc06a81e1c1cbbb3e918825a718046cb18204f3c.1775886483.git.zylzyl2333@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fc06a81e1c1cbbb3e918825a718046cb18204f3c.1775886483.git.zylzyl2333@gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gondor.apana.org.au,davemloft.net,kernel.org,google.com,redhat.com,queasysnail.net,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-280129-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:mid,lzu.edu.cn:email];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7C8C743B646
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 01:07:54PM +0800, Ren Wei wrote:
> From: Yilin Zhu <zylzyl2333@gmail.com>
> 
> xfrm6_rcv_encap() performs an IPv6 route lookup when the skb does not
> already have a dst attached. ip6_route_input_lookup() returns a
> referenced dst entry even when the lookup resolves to an error route.
> 
> If dst->error is set, xfrm6_rcv_encap() drops the skb without attaching
> the dst to the skb and without releasing the reference returned by the
> lookup. Repeated packets hitting this path therefore leak dst entries.
> 
> Release the dst before jumping to the drop path.
> 
> Fixes: 0146dca70b87 ("xfrm: add support for UDPv6 encapsulation of ESP")
> Cc: stable@kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ruide Cao <caoruide123@gmail.com>
> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Applied to the ipsec tree, thanks a lot!


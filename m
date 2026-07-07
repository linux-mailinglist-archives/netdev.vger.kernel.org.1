Return-Path: <netdev+bounces-305293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nPrzBoidTGp1nAEAu9opvQ
	(envelope-from <netdev+bounces-305293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:32:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2863717FF5
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:32:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=eikZaHj7;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305293-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305293-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1E2A3020BD9
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876A23A6EF7;
	Tue,  7 Jul 2026 06:32:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0753C39FCD8;
	Tue,  7 Jul 2026 06:32:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783405953; cv=none; b=m+DuUx6GzSGS4KdLLXA9ZaGFqahoZa9ZfAz6zwBNR9ThsJbKklEX18ke1Mi2O2pY4pb1VL/3TtlXnK5Sby6T5wTMqX8yNnrUdZg29hP49mn/GMGIDOVEeoLydQUXxchUcZyKSBe/Gc6I0gz93XiOly5h6HNAzYVlPneopI/iRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783405953; c=relaxed/simple;
	bh=zmEEoVghLmkXah8DON/RC3BV8nG8xs7yHSuN0CqZKiE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc0+jk4sAXOAby9Z6a79yVCrh+Qtn6xCPiRoSNwSsldIL5VQRD/2QsstAKp2jjk8OH2jQmZ0kQHoLThXQYsevbIuX2HYyxrovUfJVOHrJbJ3gZM5JKF09F4DHCulLR97JUYEu3XfVpuelQL0JVuzLdQUtCs9XjtdRDQ0ayRTGpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=eikZaHj7; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9221920684;
	Tue,  7 Jul 2026 08:32:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uqLy8jOnu6_F; Tue,  7 Jul 2026 08:32:23 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 141E6201A7;
	Tue,  7 Jul 2026 08:32:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 141E6201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783405943;
	bh=wWkuBF+/NnugGBdkdGrXTQ8g30ZR2qmwIVTaDD3O8LE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=eikZaHj7bDAkItp3a4U/CWsTwpBtrcvTh17OOkBiIHV7pmr1KyKcsW7ZXAN3tH1Js
	 +9V+LrhNohB5l7mokijTaQ/vEh0orZSvl5UYXqEBGkxK+BMz63MoiA34DEllXdLRUZ
	 lW0eBGb0m8QJ2ZtuPp9VzgeYBOHG1xSvVOVPWPS6f0a4xHX5kACzMECbLmICahqsfF
	 zlYP8k5OEiutPlbYKgOW3X7MuD2WggiRuw+fBewlrJEbQIorNBSb3kA/49e4ZhS+4C
	 cbat1oZfTBEK7Ne0JFNhn77SaJeL6NdKh7ZWuS8zXZwkh1aO5uPTRlTA+GD46LPFi6
	 e5RSYU6iarINg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 08:32:22 +0200
Received: (nullmailer pid 203123 invoked by uid 1000);
	Tue, 07 Jul 2026 06:32:21 -0000
Date: Tue, 7 Jul 2026 08:32:21 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Cen Zhang <zzzccc427@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Christian Hopps <chopps@labn.net>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<baijiaju1990@gmail.com>
Subject: Re: [PATCH] xfrm: clear mode callbacks after failed mode setup
Message-ID: <akyddVSYQzlfWkl7@secunet.com>
References: <20260627030117.2614741-1-zzzccc427@gmail.com>
 <CAFRLqsXvrfWE4MWVic+en7KGs6UuxwjDot2ygt2cWH2TCUgmBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFRLqsXvrfWE4MWVic+en7KGs6UuxwjDot2ygt2cWH2TCUgmBg@mail.gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305293-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,labn.net,vger.kernel.org,gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,secunet.com:from_mime,secunet.com:dkim,secunet.com:mid];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:zzzccc427@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:chopps@labn.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2863717FF5

On Tue, Jul 07, 2026 at 10:32:13AM +0800, Cen Zhang wrote:
> Hi all,
> 
> Sorry for the noise, but I wanted to gently follow up on this patch in
> case it got buried.
> 
> I would really appreciate any feedback when you have a chance. Please
> let me know if I should make any changes or provide more testing
> results.

It is not forgotten, I had it in my testing branch until now.

This is now applied to the ipsec tree, thanks a lot!


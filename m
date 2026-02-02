Return-Path: <netdev+bounces-255809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHo2Led2gGkV8gIAu9opvQ
	(envelope-from <netdev+bounces-255809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:05:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD56FCA76B
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A9433001CFD
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 10:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563B52DB7BC;
	Mon,  2 Feb 2026 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="UfVdUp3Q"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A77D2727F3
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026495; cv=none; b=Pxx1DoimTH9XUc/flfIDvMTkqEpYpeGhThBWgFrjf6EQkIypXeXRryN0NBA4m7+wTQZHMyDmhZbK3chtpWfeHp22JySkFobo24iF3a8Fr1Mac8d7shB55VaAjnNqUZg0UeEhp5GF3noOxNW0SOLr3YRIGIUy2SKQbBEHU555rys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026495; c=relaxed/simple;
	bh=BT27XXnsF8PVSkgMhuFXuuDVDHqgX3B43iAqZHoPKug=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6rJ5sBh3dGqtGgAuAm/PnepzM0AQnbwPasT/69kjmRKF7FlgLlQncfpAgqasAubD1iVO9ShZNty+e2cyfZzSoSgxEdn1iDsRF7iRqpYfuMe5Lq5mRo/XAPXKsq4XXZm9gzBbAdwbj+MJnu/tP0rRwcE20VmEuq0X2/VXp7h4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=UfVdUp3Q; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9824B20612;
	Mon,  2 Feb 2026 11:01:31 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YOTzhElci5aq; Mon,  2 Feb 2026 11:01:31 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1CCB920049;
	Mon,  2 Feb 2026 11:01:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1CCB920049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1770026491;
	bh=i90NN/5ACiS0RzdU5ZdUhx8eXQk0YKRJrIylpjF8U/s=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=UfVdUp3Qb/+taU+wKTnV9wx0KMoANOC6Ql+pGA7Z3CfVwkxSBpjgh10g3tYQQ0lx2
	 htHXLEJgKyJCx1Qvx4B/0+VpaXkDMCYYVJ2fJlT3sh0B0uHrqJmAbHlCnamk18TYd1
	 RmcP8z02WMcQA1zJatokmd0uMuD+4BFBEjpHnPlBcVmsFkxfHmKUN4s9Xvux6m9Z1N
	 C9OyYc5xPFhhoKz4MGGnT7jKTT63kWP3LWX+Ye+B0skOiR2Z9KmuHT6nNP2Fkc31F1
	 iyaVNR1jizydWmHjYe0AePDOuDHFkJcjpnaTS2xbIESj2GzHCoVNFowW7X7kwYKe1R
	 GhZnm4C1zWWyQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Feb
 2026 11:01:29 +0100
Received: (nullmailer pid 1585532 invoked by uid 1000);
	Mon, 02 Feb 2026 10:01:28 -0000
Date: Mon, 2 Feb 2026 11:01:28 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Sabrina Dubroca
	<sd@queasysnail.net>, Herbert Xu <herbert@gondor.apana.org.au>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Ilan Tayari <ilant@mellanox.com>, Guy Shapiro
	<guysh@mellanox.com>, Yossi Kuperman <yossiku@mellanox.com>, Network
 Development <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] xfrm: always flush state and policy upon
 NETDEV_UNREGISTER event
Message-ID: <aYB1-MtqQgPnjJjg@secunet.com>
References: <cea4b855-fe94-4b4e-9c2d-3cef7aac1be3@I-love.SAKURA.ne.jp>
 <20260201141739.GE34749@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260201141739.GE34749@unreal>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255809-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,secunet.com:mid,secunet.com:dkim];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DD56FCA76B
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 04:17:39PM +0200, Leon Romanovsky wrote:
> 
> Steffen,
> 
> If you decide to take it, please queue it in your -next branch, so we will have enough
> time to test in our regression. It seems too risky for -rc8.

I plan to take the patch as is. It is a fix, so I'll
take it into the ipsec tree, not ipsec-next. But
I can hold it off until after the release if that
will help regression testing.


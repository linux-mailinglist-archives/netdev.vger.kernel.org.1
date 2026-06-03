Return-Path: <netdev+bounces-294717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OgCZB6ULIGrMuwAAu9opvQ
	(envelope-from <netdev+bounces-294717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 13:10:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 765F1636DB9
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 13:10:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=Sc3G+lnI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294717-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294717-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28662304A7AB
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9BD4418F2;
	Wed,  3 Jun 2026 11:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B4402427;
	Wed,  3 Jun 2026 11:10:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485022; cv=none; b=C40rk6+AtC0Bej2Z/hFvQVa8THwFRSmsDiQwRjCbLlBwJYD5WaehAEUPaa++4hnGDFMT+OSmnnYv6HmqbXOWyRKjs/iChI/4HAPYluGefuP7IAG4E3IZs4U01cBlq1QcpehLRtXISaLdWcYW7mApoGmmAIf3GftY5IskNxbfmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485022; c=relaxed/simple;
	bh=B36P7iXGQkB+ohaaJ/k+ZwKyWHHtdSU5AtkoHuNCNGI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IG6k0Pe9Y3XZitlpMVV0gHbmBNTGVSLqOlPwXSIdZ7Z5/qbyo8uF39fE/xSEFlF58ciaD/+Q+clOWbVwF6FqWPrnvbeUwzvx9MGfmk60czhu2cY2ZpecTt3mhymixAQQcu65jU3Tyj1G4xmlID1+bELJX+xuNWc8NIpTu+tvfVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Sc3G+lnI; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CCB23206D2;
	Wed,  3 Jun 2026 13:10:18 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mgpu2YHX90Q9; Wed,  3 Jun 2026 13:10:18 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 57C71206BC;
	Wed,  3 Jun 2026 13:10:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 57C71206BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780485018;
	bh=B36P7iXGQkB+ohaaJ/k+ZwKyWHHtdSU5AtkoHuNCNGI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Sc3G+lnI8gsBMNgZYMS4Oe4CEVJwm11khuhkeWWNy1KkhamPJYmQmAvMM1kdARBSH
	 EYy950xsMnfO/iir30VZBqyA3bZPa0T1FSvjpu+HINoPXA9XcVYoVKjPUYVIMUkjl1
	 1AUJLCA6R1EiwocKObkDUe+i1IjydaqYq+XPnALt6qNjMiwt8x0dxjEb8iTjHQnfvO
	 NNLfTSEtxjITC21AE5PcdS8uMJLv0BuveAoNuyUplzTxDB1phPBNreB4+zy0ZyF0Z3
	 sA2pYdSmaT3pxNYYuzC+QpfVBJziIgblRtYsHN+6FRlqL5j4RQKT2LNrGdRu3YgNiT
	 INVVEyUMbwoXw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 13:10:17 +0200
Received: (nullmailer pid 1869479 invoked by uid 1000);
	Wed, 03 Jun 2026 11:10:17 -0000
Date: Wed, 3 Jun 2026 13:10:17 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Alessandro Schino <7991aleschino@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ipsec] esp: fix page frag reference leak on skb_to_sgvec
 failure
Message-ID: <aiALmb4vqswoHGLI@secunet.com>
References: <20260601134526.82-1-7991aleschino@gmail.com>
 <aiAIvUX8a43ci-DF@secunet.com>
 <CABNe9nMY+npo8uTourxOSDZobbGoWmH8qgTuKxxW+hFeFag-Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABNe9nMY+npo8uTourxOSDZobbGoWmH8qgTuKxxW+hFeFag-Sw@mail.gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:7991aleschino@gmail.com,m:netdev@vger.kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294717-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:mid,secunet.com:from_mime,secunet.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 765F1636DB9

On Wed, Jun 03, 2026 at 01:06:40PM +0200, Alessandro Schino wrote:
> Hi!
> Yes understood! Do you want me to format the code and send another patch?

Yes, please.

And version your patches like this:

[PATCH ipsec v2]

This makes it clear that it is not a duplicate.



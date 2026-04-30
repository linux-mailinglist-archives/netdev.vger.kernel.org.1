Return-Path: <netdev+bounces-282687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIlNA0UL82mSwwEAu9opvQ
	(envelope-from <netdev+bounces-282687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:56:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4BA49EF4D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 09:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 150B2300D9CC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 07:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3034A3FB7E0;
	Thu, 30 Apr 2026 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="rEvXyLEH"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2763B299AAB
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535797; cv=none; b=MOMnIauUBoSEAR8ibnZjkil881Dn5ZI5O2AB8aza9QDek4bM50mCR75GnStR7GO7cmg1tlYAzAUgrVnIOSZiVgl77GdDnsdgoXDfdWLcIVwosBSF+4cabu4TSXl5qYAXBClIgzCJaeL4+FFBkK2ZtACjoQcOl53gb9OZFu2MyAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535797; c=relaxed/simple;
	bh=yWqK1pQdaoehOit5NYMKf+hVOW0CIreYpIUXQ7XljR0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PC70ig0+itTEw5Y0uNdatyZIn0QPdomsts//ZGhPpzGoI9yXmI38CRo1q1suUEcupWFhyhP3avDD5p/+qbr9kZumxyOhP1C0Y3kqOqXtGBYvbjVs+bjg1nL5cK6GTEoGjAPaBKhvLVvSgHmt9uPzFS4l3Aron7HYJoNE7jexDAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=rEvXyLEH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8305F20892;
	Thu, 30 Apr 2026 09:56:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lX90_rhCkhKo; Thu, 30 Apr 2026 09:56:25 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 9F890207D1;
	Thu, 30 Apr 2026 09:56:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 9F890207D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777535785;
	bh=05E11VUoxO9K3UUbcl+ec946qAkTFQnioqeSg2ZlpJo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=rEvXyLEHra46jtg88cv9+Cazp5Xlh+KUzeYAB8NznKZcKiiRVIvY7lpC/SKls37US
	 SD5ZuRCd1VpyjAFu2lkshNxUAuxoCbcaM511W1pIrl/yaQXxLc53RmhZvIY19oMknI
	 8aJGOYnOUagSWPEzI93luRQIzOI+6GynVACADevIIs489T80SzOb/BzNdmcyFCw+kM
	 zvUlj3APK1JS2DWHmZuwWyFi1qWEzfTwglWhLddtnqb0TnaZQ4JbKPyxsBfLwAozu3
	 IQy6j6kUPF1Roz0eVcFdfPgLiJBxGJfbtia03xliGbIV0zKQfagbEktSzdolsGyvAA
	 N/HZsNixsVz1g==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 09:56:24 +0200
Received: (nullmailer pid 2405375 invoked by uid 1000);
	Thu, 30 Apr 2026 07:56:23 -0000
Date: Thu, 30 Apr 2026 09:56:23 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Ren Wei <n05ec@lzu.edu.cn>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <0x7f454c46@gmail.com>,
	<yuantan098@gmail.com>, <yifanwucs@gmail.com>, <tomapufckgml@gmail.com>,
	<bird@lzu.edu.cn>, <ruijieli51@gmail.com>
Subject: Re: [PATCH net 1/1] xfrm: provide message size for XFRM_MSG_MAPPING
Message-ID: <afMLJ8a26grtdzWw@secunet.com>
References: <cover.1777354203.git.ruijieli51@gmail.com>
 <93a1ffe802d9c5d741ab95dce75eb3e9368be97d.1777354203.git.ruijieli51@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <93a1ffe802d9c5d741ab95dce75eb3e9368be97d.1777354203.git.ruijieli51@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 6E4BA49EF4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-282687-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lzu.edu.cn:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Wed, Apr 29, 2026 at 12:41:43AM +0800, Ren Wei wrote:
> From: Ruijie Li <ruijieli51@gmail.com>
> 
> The compat 64=>32 translation path handles XFRM_MSG_MAPPING, but
> xfrm_msg_min[] does not provide the native payload size for this
> message type.
> 
> Add the missing XFRM_MSG_MAPPING entry so compat translation can size
> and translate mapping notifications correctly.
> 
> Fixes: 5461fc0c8d9f ("xfrm/compat: Add 64=>32-bit messages translator")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Ruijie Li <ruijieli51@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Applied, thanks a lot!


Return-Path: <netdev+bounces-276386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBdoNB4h1mklBQgAu9opvQ
	(envelope-from <netdev+bounces-276386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:34:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0455D3B9EB7
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 11:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BC59300C033
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0259C344020;
	Wed,  8 Apr 2026 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="UY4WtOSp"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C194224B04;
	Wed,  8 Apr 2026 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640720; cv=none; b=AphHAXWmpAer5UVfcYIzft1VqPhaKTJ2hosB2EdrsIjUWlfdSR3txJXS69GdPZ+jjdsR+D1ZcDcbeEMbS4nQ1Ai3ceSqdmYG5MKpwE+b37NyxwicfviuItn+0UJoAkU1y2SrFmuhcR+A7p3ux4qE/q51keg027NeBXGVBkGaVbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640720; c=relaxed/simple;
	bh=OvV9wkmcFlZpruDSXA0Z16jXkBBlkrhmm76Wj8dZTOw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iitiJWMC9Meah8wH6ioldrv3ei+HptPbWvioQ/tIDUfrQ9mFcCEI4NatgJmq32HCsIgT5CtGqDntsJm6DbxXdHiQighr50ekxqIRYCbR9sbAe6RFBD3jFmNpz+ItQrMMxRxc/TDqDfuABaJaGBAu+QFaQM9m7g47omozTMUuaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=UY4WtOSp; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CCAE4206D2;
	Wed,  8 Apr 2026 11:31:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yUkz1jWEx6l9; Wed,  8 Apr 2026 11:31:52 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id DC205201D5;
	Wed,  8 Apr 2026 11:31:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com DC205201D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775640712;
	bh=DYuGrSxn/yCMR2lUQoGYp52uTHcOUe99pk8PluWzEB8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=UY4WtOSpledfEc7taPgWeg1Q7ryqrRpXf6Qgbvk7vEClJPbX+mBNfdTeLJuEgf7JM
	 VKVvkbKa8indh1RhxCpaCNrH1Aqu1ELWb42EGrsXPfMV9e1YQQ9bC3Rv+t1IlpHDTb
	 j3N/zRskiO7nTObHD4hoq80fPQ+XZd8MAHFv4hc9SdBaYFrtruo0n1XiVauRM3b065
	 nD2itnk7r4u6KzBtYT1Pbs5Qc/tp4Ele23DSMYcDT1VPbldm+nGqbVmbNy1J+VbhFE
	 ozcIxMWULn8VUHyx6jDf7BYHWZbfInpYRl9XUNX70lwEch57t+6x4efKLwM20EG3PY
	 NMFEmZhfziZ6Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 11:31:51 +0200
Received: (nullmailer pid 77457 invoked by uid 1000);
	Wed, 08 Apr 2026 09:31:50 -0000
Date: Wed, 8 Apr 2026 11:31:50 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Zhengchuan Liang <zcliangcn@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <linux-kernel@vger.kernel.org>,
	<shinta.sugimoto@ericsson.com>, <nakam@linux-ipv6.org>,
	<yoshfuji@linux-ipv6.org>, <yifanwucs@gmail.com>, <tomapufckgml@gmail.com>,
	<yuantan098@gmail.com>, <bird@lzu.edu.cn>, <lx24@stu.ynu.edu.cn>
Subject: Re: [PATCH net] net: af_key: zero aligned sockaddr tail in PF_KEY
 exports
Message-ID: <adYghh-SE0eftCrH@secunet.com>
References: <20260322184608.1048146-1-zcliangcn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260322184608.1048146-1-zcliangcn@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276386-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,ericsson.com,linux-ipv6.org,gmail.com,lzu.edu.cn,stu.ynu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:dkim,secunet.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0455D3B9EB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 11:46:08AM -0700, Zhengchuan Liang wrote:
> PF_KEY export paths use `pfkey_sockaddr_size()` when reserving sockaddr
> payload space, so IPv6 addresses occupy 32 bytes on the wire. However,
> `pfkey_sockaddr_fill()` initializes only the first 28 bytes of
> `struct sockaddr_in6`, leaving the final 4 aligned bytes uninitialized.
> 
> Not every PF_KEY message is affected. The state and policy dump builders
> already zero the whole message buffer before filling the sockaddr
> payloads. Keep the fix to the export paths that still append aligned
> sockaddr payloads with plain `skb_put()`:
> 
>   - `SADB_ACQUIRE`
>   - `SADB_X_NAT_T_NEW_MAPPING`
>   - `SADB_X_MIGRATE`
> 
> Fix those paths by clearing only the aligned sockaddr tail after
> `pfkey_sockaddr_fill()`.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of endpoint address(es)")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Xiao Liu <lx24@stu.ynu.edu.cn>
> Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>

Applied, thanks a lot!


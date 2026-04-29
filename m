Return-Path: <netdev+bounces-282242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGGnGkCn8WmxjQEAu9opvQ
	(envelope-from <netdev+bounces-282242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:37:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D11F748FCBD
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 08:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00850302A516
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 06:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573B833BBC5;
	Wed, 29 Apr 2026 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Ab5qH6P8"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0261287259;
	Wed, 29 Apr 2026 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777444665; cv=none; b=XtnLlTeKVhyH01yCRnvZzo3V6X9gp0nDOwSFTOqGutG5KijhGAobB/5S45zrh9G5zhRPpTOlqUROW2zqBUYm1iSJwnjHRhgNDnsZZpfZLwU/8ABtMmbayxOKy3Nziv73MzIXLVVBT2rS9ecieago/dF07aVm3daqUGUuBIFAtEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777444665; c=relaxed/simple;
	bh=ztdIZGl3pb4eeE9tvP9Lh+oxVun+9BchYANGVaMJtCA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9MMrbd/+RwNSV73PEHqGB1Jgjd/wp7DJmkTiaAI9rP7JynrPqxVR176z0IpaKiNFk+0sG7RBZP6uRO0AlitSi/QsfepHhrv+m2ZLt8/rr3dOBjIgbS49ZeaWR9QjjCgY2n7r06U4/Bj9XT616Taz0SztOBRicTc2cP/nZoaO6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Ab5qH6P8; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 7A99A207D8;
	Wed, 29 Apr 2026 08:32:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nuB8dZEE3fM2; Wed, 29 Apr 2026 08:32:06 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id F117D207A4;
	Wed, 29 Apr 2026 08:32:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com F117D207A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777444326;
	bh=OTyYJiZ6y3LnoHBQ3NXMaVaQNDMKzYuFh7jLYAH1TSs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Ab5qH6P8gZpzgVv5zNZizo0OHb0V+jPqcyxz68izgufEph/JcymPviyPiE6D9nS30
	 RBvdZXzjdTuAljYqzNtZ8Bq5g8L+fsoDETJQw8edxk0Rui8iWPWtBDTPSrSjE66vyN
	 +zUZtxWVLtl0L8/q2JFsGzEYfQhtusnrEB6jAH0YtUvZbQ8A/D9FRZp8/zbCfijTS3
	 8Y9MY5jb88PM7Nqw50g+RdiA0v4nJljjrOj5eZNkrPqZmNR+7d7cuAyjzVOADf5WRp
	 szPgFSycu1ULk8cVqefwZ5Eksu2IOn7UeaZDB17A1B6tv04dgkEuFC7ozNaOQc49bl
	 yUM4Ab+WYP2vQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 08:32:04 +0200
Received: (nullmailer pid 1098860 invoked by uid 1000);
	Wed, 29 Apr 2026 06:32:03 -0000
Date: Wed, 29 Apr 2026 08:32:03 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan
	<shuah@kernel.org>, Nimrod Oren <noren@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH ipsec 0/3] xfrm: Don't clobber inner headers when already
 set
Message-ID: <afGl40FUuqiwV-B7@secunet.com>
References: <20260422140648.3877129-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260422140648.3877129-1-cratiu@nvidia.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: D11F748FCBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282242-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On Wed, Apr 22, 2026 at 05:06:45PM +0300, Cosmin Ratiu wrote:
> Commit [1] exposed an existing issue in xfrm which broke tunneling
> protocols over IPsec (e.g. VXLAN over IPsec).
> 
> This series fixes that and adds a test which exercises VXLAN over IPsec.
> For details please see the individual patches.
> 
> [1] commit 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> 
> Cosmin Ratiu (3):
>   tools/selftests: Use a sensible timeout value for iperf3 client
>   tools/selftests: Add a VXLAN+IPsec traffic test
>   xfrm: Don't clobber inner headers when already set

Series applied, thanks a lot Cosmin!


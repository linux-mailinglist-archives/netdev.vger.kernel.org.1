Return-Path: <netdev+bounces-305295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BMgfM/SdTGqHnAEAu9opvQ
	(envelope-from <netdev+bounces-305295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:34:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B60718026
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:34:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b="F/5ljjGb";
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305295-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305295-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D43DF300908E
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7AC3A7F6D;
	Tue,  7 Jul 2026 06:34:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E31231F98C
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 06:34:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406066; cv=none; b=Uwn2bmbRm/bcrauEtvkTrTWBXPIaNQpzRMyvBYePKF8tcGXKi1Xv7ppndYqHU4qcRNcWzoZKV6RdcDQriSENXJeB++04XXHcduJovKz19Y53lCfM/blJOpBwMyYPooG8073i32VaD4u2tPkPghFoNfXn2DCJw6598SSyGYcoedg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406066; c=relaxed/simple;
	bh=k11VdWHwY3cjmoxE1M32L0f9O0Yb6PtQ+fpGkmGMnt8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz6KIWgeao1aKk/EaoKcpwPJl2HOtelZCdA4ltrI9iM/xVnST1VtZBIh/e21P7AtYeDZigsk3Ac7UVSWbTMmwdS/ejBB+lJE/8FYmT1FWwQ2VtkpAI+7SWG+RP3yVLBGCY1WLloZfwEUiXXcyOGlfRvPkmOEzwtSy02yu2B7ais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=F/5ljjGb; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8DBB620684;
	Tue,  7 Jul 2026 08:34:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PPOsmWHX3Tdd; Tue,  7 Jul 2026 08:34:23 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id ED670201A7;
	Tue,  7 Jul 2026 08:34:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com ED670201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783406063;
	bh=vjJsBw3BtA6cE34lD/Mmnxd3QgrZqy4aN7wcsT/LSM4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=F/5ljjGb7Tw9xX0VnUzGtS2PObszEvQhp6csTZ/dN7UWe7z/LHtNtCABb4OCuh0IM
	 WdoobmkYyAdUGz0+DQyXHqfEoX1kbt7EMmkDQ1k9qWjkNAW48Hh6+kckbI6bZiFaHd
	 JRct4vFhj3JFvpgWZySzWWMPG9upVDs56SitimpwhG8z6eE2pyHKO+fxO8Fkvwe4cZ
	 CHrz/vda9RZzA2wnI7ecd77TUnSvE1WRDxQ22k1COcbfbs09F02xhqR6/XU+V9PBK6
	 qAQINtaJYYVyrdzB/vPLpEYIX+bnVC+iaL7d93g00h/JOp8n1yHGu7BW+3iblUhYLS
	 vxpwQJxGYI1Bg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 08:34:22 +0200
Received: (nullmailer pid 204818 invoked by uid 1000);
	Tue, 07 Jul 2026 06:34:21 -0000
Date: Tue, 7 Jul 2026 08:34:21 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, <netdev@vger.kernel.org>, Simon Horman
	<horms@kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<AutonomousCodeSecurity@microsoft.com>, <tgopinath@linux.microsoft.com>,
	<kys@microsoft.com>
Subject: Re: [PATCH ipsec] xfrm6: clear dst.dev on error to avoid double
 netdev_put in xfrm6_fill_dst()
Message-ID: <akyd7YVSczkMzK-h@secunet.com>
References: <20260702010516.221830-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260702010516.221830-1-xmei5@asu.edu>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305295-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:horms@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,secunet.com:from_mime,secunet.com:dkim,secunet.com:mid];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68B60718026

On Thu, Jul 02, 2026 at 01:05:16AM +0000, Xiang Mei (Microsoft) wrote:
> On the error path where in6_dev_get(dev) returns NULL, xfrm6_fill_dst()
> releases the device reference with netdev_put() but leaves
> xdst->u.dst.dev set. dst_destroy() later calls netdev_put(dst->dev)
> again, so the same net_device reference is released twice, underflowing
> its refcount (ref_tracker WARNING + "unregister_netdevice: waiting for
> <dev> to become free").
> 
> Clear xdst->u.dst.dev after the netdev_put(), the same way the XFRM
> device-offload paths xfrm_dev_state_add() and xfrm_dev_policy_add() in
> net/xfrm/xfrm_device.c NULL ->dev when releasing the reference on error.
> 
>   ref_tracker: reference already released.
>   ref_tracker: allocated in:
>    xfrm6_fill_dst (net/ipv6/xfrm6_policy.c:86)
>    ...
>    udpv6_sendmsg (net/ipv6/udp.c:1696)
>    ...
>   ref_tracker: freed in:
>    xfrm6_fill_dst (net/ipv6/xfrm6_policy.c:90)
>    ...
>   WARNING: lib/ref_tracker.c:322 at ref_tracker_free+0x58b/0x780
>    dst_destroy (net/core/dst.c:115)
>    rcu_core
>    handle_softirqs
>    ...
> 
> Fixes: 84c4a9dfbf43 ("xfrm6: release dev before returning error")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>

Applied, thanks a lot!


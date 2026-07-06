Return-Path: <netdev+bounces-304839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6oPUKVpIS2prOgEAu9opvQ
	(envelope-from <netdev+bounces-304839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 08:16:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 060A870CD39
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 08:16:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=ITaT7jwn;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304839-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304839-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75E973006177
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 06:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27B23BFAD3;
	Mon,  6 Jul 2026 06:14:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0087137D114;
	Mon,  6 Jul 2026 06:14:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318473; cv=none; b=bRREvERq9M073mUboSj7/zzHHxeQ3IyiQjbPXKNmWeoHdvc/HngK1dJFJn7ZVnZElIXAYSswLsX8M/7yuUXCp6hP7pJkF6kq2CSvfazYgpe//4c7r529WiuR4T97wB1Iu7c3X82quaZOdio1vTnOplZIoGy74sRb9+ba9ouUYwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318473; c=relaxed/simple;
	bh=w65UREZ80WJouNUP6MsJmKeDzE/nrCNf4x3UXUEadmk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9iSLgQKYEXOMfyu2YRtoinD84ImNbAVwUp+oH+16TKGQhHDqQLMHWRZ89jOrl32W6zHwFGs/zSifPNrWBTawkGhCmjS+6P6RoxuTp1fE9ZgBAwYg0IsB9eoB27GLWePY4jwLW+u+FkgYy+bva7atnh6W8OBacwS4XuxravgDkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ITaT7jwn; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 14CC220612;
	Mon,  6 Jul 2026 08:14:23 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2bCosAOgtaBU; Mon,  6 Jul 2026 08:14:22 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2DBD7201D5;
	Mon,  6 Jul 2026 08:14:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2DBD7201D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783318462;
	bh=l2AJRlR9vAR8iI1GYAxpkCYt479gVQ//nQa1XXb8mOY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ITaT7jwnADnjJN3odLpG+R3u1b7QU7AnhpPc8Gv7XJPvrypY8dJlEyfecxoNR1WE8
	 jo6f/7CxKD+U2LFVdiLSQLFydmX3/6pOBFArcfSOOT4x8TDTJ0lqG5KV3glPSejZzH
	 g4G7oeEkqlCBg1Ed72OyJafyQpl2NkhQyqzezJZ3cpC3NQsJ6jqjrOdNwucB/hrgyt
	 k0hAwAXYx+hMnJ1v/iMOEfDll2e4VCnmJVSkpLHWHm5+YFnq9r+RTIO1d6fJeu/HLq
	 0jt/iaQYc767uRVMiISJwgAAnHPHOADTIb2TGsh0SnUpbXWFPHPdQvrdFyz504O5cc
	 1dk7fCGwx2OKw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 6 Jul
 2026 08:14:21 +0200
Received: (nullmailer pid 3237375 invoked by uid 1000);
	Mon, 06 Jul 2026 06:14:20 -0000
Date: Mon, 6 Jul 2026 08:14:20 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<AutonomousCodeSecurity@microsoft.com>, <tgopinath@linux.microsoft.com>,
	<kys@microsoft.com>
Subject: Re: [PATCH ipsec] xfrm: fix sk_dst_cache double-free in
 xfrm_user_policy()
Message-ID: <aktHvEy7JC-eGClA@secunet.com>
References: <20260627024023.2201160-1-xmei5@asu.edi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260627024023.2201160-1-xmei5@asu.edi>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304839-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email,secunet.com:from_mime,secunet.com:dkim,secunet.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 060A870CD39

On Sat, Jun 27, 2026 at 02:40:23AM +0000, Xiang Mei (Microsoft) wrote:
> From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
> 
> xfrm_user_policy() clears the socket dst cache with __sk_dst_reset(),
> i.e. the non-atomic __sk_dst_set(sk, NULL): it reads sk_dst_cache with
> rcu_dereference_protected(), stores NULL and dst_release()s the old dst.
> That is only safe if no other thread modifies sk_dst_cache concurrently.
> 
> For a connected UDP socket that does not hold: the transmit fast path
> (udp_sendmsg -> sk_dst_check -> sk_dst_reset) resets the cache locklessly
> with an atomic xchg(). A per-socket policy change racing a send can make
> both sides observe the same old dst and each dst_release() it, dropping
> the socket's single reference twice and freeing the xfrm_dst bundle while
> it is still referenced:
> 
>   BUG: KASAN: slab-use-after-free in dst_release
>   Write of size 4 at addr ffff88801897b6c0 by task exploit/155
>   Call Trace:
>    ...
>    dst_release (... ./include/linux/rcuref.h:109)
>    xfrm_user_policy (./include/net/sock.h:2239 ./include/net/sock.h:2256 net/xfrm/xfrm_state.c:3053)
>    do_ip_setsockopt (net/ipv4/ip_sockglue.c:1347)
>    ip_setsockopt (net/ipv4/ip_sockglue.c:1417)
>    do_sock_setsockopt (net/socket.c:2368)
>    __sys_setsockopt (net/socket.c:2393)
>    __x64_sys_setsockopt (net/socket.c:2396)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
> 
> Reachable by an unprivileged user via a user+network namespace.
> 
> Use the atomic sk_dst_reset() so the cache is cleared and released with a
> single xchg(): whichever side wins releases the dst once, the other sees
> NULL and does nothing. Behaviour is otherwise unchanged.
> 
> Fixes: 2b06cdf3e688 ("xfrm: Clear sk_dst_cache when applying per-socket policy.")
> Fixes: be8f8284cd89 ("net: xfrm: allow clearing socket xfrm policies.")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>

Applied, thanks a lot!


Return-Path: <netdev+bounces-289795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEUPD0RcDWrBwQUAu9opvQ
	(envelope-from <netdev+bounces-289795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:01:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70457588954
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9895E304796A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902B73672A5;
	Wed, 20 May 2026 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="bi5h0/rU"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8393630AE;
	Wed, 20 May 2026 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260351; cv=none; b=M3swRzEF99lTQuDWe6oa9PU/VN+DxvmMW6yvOxsbgH1qOQaBZmf8GGgOWZ3ozzvBHgHVY/nPrpcQh7E+AuQYUiOEzCTgglervBadz2iKVDCBy6GhgWUnIeE2+yu49Jaiy7C5HT+YUvwFtHZSxipMGVHoWT03MhTC6GS1Kj30Axs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260351; c=relaxed/simple;
	bh=PPpeI7Xb3kaI0X22TfVMKt7kBUpv1MRvdTnnpuHCPLs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3W3B1EEnPDNMNg2uWg/9gbjbNdOJHT96VXQoo0qex54/Mq1lqakIEUA1anLyv4eSZa3aiB/Zubrgf3lncXOHl6dkdQCLZcgg2ZFRvF+kfbGww8PWO5/I/kjJ3vZVzlaD8GwJXsD5cW1pD4P4Pnv/+Uy1wot1dxtSOm4+Vi3kcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=bi5h0/rU; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id BCCF120190;
	Wed, 20 May 2026 08:59:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vOuMy8MEWuxJ; Wed, 20 May 2026 08:59:07 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 275A1207AC;
	Wed, 20 May 2026 08:59:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 275A1207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779260347;
	bh=bBAywpfg57qsi59u8EKjLYTUBp30UBP9K7ik84Iwvjc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=bi5h0/rUv3yV3Fa5mz5ohZRPheiYk2IBMQ70fDdxmgeMz1UoWJJlVS72aMo/uVgvp
	 TtUi1hQkE+GA4yydRVJQI4dyvp3F4GPVyAAAvOvvNVnypvREKTkxVfESv34ClWw+UP
	 XUlpNO/GwL3VoF4CTray2IldlhP3oqgimuc+mlbzQKG+HQxua+3t0O7oSTudFauuJJ
	 dt8KZvA+N/LpDNI044Bbvn8myUQkAEI0bqiS2IkhgE6QK03kGQdPY/rXsBfiYeFoxU
	 n5+kZqy10HvPqMHT7CeoDfvLyQGIm7w+IltFJakSUa/4r0JQFvrpIevEJ9sHDs7Bw+
	 jTPeLxbPHnZgQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 08:59:06 +0200
Received: (nullmailer pid 1147918 invoked by uid 1000);
	Wed, 20 May 2026 06:59:05 -0000
Date: Wed, 20 May 2026 08:59:05 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Evan Nimmo
	<evan.nimmo@alliedtelesis.co.nz>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: ah: use skb_to_full_sk in async output
 callbacks
Message-ID: <ag1budVqQmjiowDH@secunet.com>
References: <20260515154531.1386683-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260515154531.1386683-1-michael.bommarito@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:mid,secunet.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_FROM(0.00)[bounces-289795-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 70457588954
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026 at 11:45:31AM -0400, Michael Bommarito wrote:
> When AH output is offloaded to an asynchronous crypto provider
> (hardware accelerators such as AMD CCP, or a forced-async software
> shim used for testing), the digest completion fires
> ah_output_done() / ah6_output_done() on a workqueue.  The egress
> skb at that point may have been originated by a TCP listener
> sending a SYN-ACK, which sets skb->sk to a request_sock via
> skb_set_owner_edemux(); it may also have been originated by an
> inet_timewait_sock retransmit.  Neither is a full struct sock, and
> passing the raw skb->sk to xfrm_output_resume() then forwards a
> non-full socket through the rest of the xfrm output chain.
> 
> xfrm_output_resume() and its downstream consumers expect a full
> sk where they dereference at all.  The natural egress path
> through ah_output_done() does not crash today because the
> consumers that read past sock_common are either gated by
> sk_fullsock() or short-circuit on flags that are clear on a fresh
> request_sock; an exhaustive walk of the 50 most plausible
> consumers under sch_fq, dev_queue_xmit, netfilter, tc-egress and
> cgroup-egress BPF found no current unguarded deref.  The bug is
> still a real type confusion that future consumer changes could
> turn into a memory-corruption primitive.
> 
> This is the same bug class fixed for ESP in commit 1620c88887b1
> ("xfrm: Fix the usage of skb->sk").  Apply the analogous fix to
> AH: convert skb->sk to a full socket pointer (or NULL) via
> skb_to_full_sk() before handing it to xfrm_output_resume().
> 
> The same async AH callbacks were touched recently for an
> independent ESN-related ICV layout bug in commit ec54093e6a8f
> ("xfrm: ah: account for ESN high bits in async callbacks"); the
> sk type-confusion addressed here is orthogonal.  This patch is
> part of an ongoing audit of the AH callback paths; an ah_output
> ihl-validation hardening series is also currently under review on
> netdev.
> 
> Reproduced under UML + KASAN + lockdep with a forced-async
> hmac(sha1) shim that registers at priority 9999 and wraps the
> sync in-tree hmac-sha1-lib.  With the shim loaded, ah_output_done
> runs on every SYN-ACK egress through a transport-mode AH SA and
> skb->sk arrives as a request_sock (TCP_NEW_SYN_RECV); after this
> patch, xfrm_output_resume() receives the listener (the result of
> sk_to_full_sk()) and consumer derefs land on full-sock fields as
> intended.
> 
> Fixes: 9ab1265d5231 ("xfrm: Use actual socket sk instead of skb socket for xfrm_output_resume")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>

Applied to the ipsec tree, thanks!


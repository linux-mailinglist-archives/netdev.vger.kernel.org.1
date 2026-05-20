Return-Path: <netdev+bounces-289798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BJJHPFdDWpuwgUAu9opvQ
	(envelope-from <netdev+bounces-289798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:08:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 955B0588AE4
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0EF93004CA3
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 07:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9737834DCC8;
	Wed, 20 May 2026 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="C6CI0AGK"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA56F2D7DF1;
	Wed, 20 May 2026 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260906; cv=none; b=Z/5yKt8fR8xvZNWyQcyeNXUtkMPPQ8WicQjQn56iB6p+sJf3r4bh3c+rDX9mUaKQzKuFYI3j0oExCsChrI2/F7uR2ieFbxH+PP83ez8bQlPmNSAC9050d29jsvqW9C8xHqSZvpLk2av0cTGc5M9hjk2glvgLBryWmFhJaxjg9Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260906; c=relaxed/simple;
	bh=7e8Th0BuhXl2MkDAtDZAM7MVajY4tGN2uTMaCs7oVoc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVE+OIXsIGe3BmMTL3r6yFe3RYxb4Z90/eIYM8c1+yfoX21o23GEjZGxNX2al6fUcO2yCCJ5YGhkJzz4mOOJaPmqqsT1v5XTB5Z5vxuFHuGt7RyAtZlDnTdzuKcSM1wAjL1JT8K4lQCmHi8nWbNyspuVOP/uOwM5rB9qRxIYOUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=C6CI0AGK; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id E7DC6207BB;
	Wed, 20 May 2026 09:08:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G4Ej3aUujoXE; Wed, 20 May 2026 09:08:22 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E3DCB207BE;
	Wed, 20 May 2026 09:08:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E3DCB207BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779260901;
	bh=XwnNG9i8TVUgHbr/AHbDJRHNkp4k1BohQP+cShZ5oqc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=C6CI0AGKF+tJ6GVW1YqMMqw15osuaJ9klWEkZkAhCW8ygbpO1S6rYwNJ/FSd0VCTx
	 BHUT75aypZeatfRKvK3R22ci6FuNJniZo30lL/8tqQDfxQSu5J9I9hP+L5FwhoKwXp
	 ijbhqZdrkGKlqsea3SASbJAeyfhLgponhIDBPdGOwVnVGgsK71HGBBNskp2BSvsid2
	 as1zLkDyS/oQ3SUEetdnK5JVU8bBKoBYi7D76KS1fwtVLUxbJ75M37SHCHhmA12TC6
	 A81DiwVCnYpvPRs6Z7OprUxfTMVel35mWCy2F1c9LiWZ6OZlX2KUa+TMsyvKKhTaJm
	 gbwLvAkrFdlXA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 09:08:21 +0200
Received: (nullmailer pid 1155878 invoked by uid 1000);
	Wed, 20 May 2026 07:08:20 -0000
Date: Wed, 20 May 2026 09:08:20 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Alessandro Schino <7991aleschino@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <linux-kernel@vger.kernel.org>, e521588
	<alessandro.schino@sbb.ch>
Subject: Re: [PATCH] esp: fix page frag reference leak on skb_to_sgvec failure
Message-ID: <ag1d5JwwVZZoncDO@secunet.com>
References: <20260517111306.1881-1-7991aleschino@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260517111306.1881-1-7991aleschino@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289798-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,secunet.com:mid,secunet.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 955B0588AE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 01:13:06PM +0200, Alessandro Schino wrote:
> From: e521588 <alessandro.schino@sbb.ch>
> 
> In esp_output_tail(), when esp->inplace is false, the old skb page frags
> are replaced with a new page from the xfrm page_frag cache. The source
> scatterlist (sg) is built from the old frags before the replacement, and
> esp_ssg_unref() is responsible for releasing the old page references
> after the crypto operation completes.
> 
> However, if the second skb_to_sgvec() call (which builds the destination
> scatterlist from the new page) fails, the code jumps to error_free which
> only calls kfree(tmp). The old page frag references captured in the
> source scatterlist are never released:
> 
>   1. sg[] is built from old frags via skb_to_sgvec() (no extra get_page)
>   2. nr_frags is set to 1 and frag[0] is replaced with the new page
>   3. Second skb_to_sgvec() fails -> goto error_free
>   4. kfree(tmp) frees the sg[] memory but old frags are not unref'd
>   5. kfree_skb() only releases frag[0] (the new page), not the old ones
> 
> Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
> unconditionally unrefs the source scatterlist frags without checking
> req->src and req->dst, since those fields are not yet initialized by
> aead_request_set_crypt() at the point of the error. Existing callers
> pass false to preserve the original behavior.
> 
> The same issue exists in both esp4 and esp6 as the code is identical.
> 
> Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")

Remove this empty line.

> Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
> ---
>  net/ipv4/esp4.c | 10 +++++-----
>  net/ipv6/esp6.c | 10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)

Your patch does not appy to the ipsec tree, please rebase.

Also, the subject should be something like

[PATCH ipsec v2] esp: fix page frag reference leak on skb_to_sgvec failure

This clarifies on which tree it should be applied and the version.


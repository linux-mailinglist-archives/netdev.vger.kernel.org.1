Return-Path: <netdev+bounces-147710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA56F9DB4D7
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 10:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5A2282CC2
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 09:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B7A157469;
	Thu, 28 Nov 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="nnjh0d9j"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2804A156C63
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786489; cv=none; b=afyKhQpSPNhwXfJXxLY7JoXDux6TxWgQTdcBf86hRRfVW7aw+UlUIfz2rBQI0VphWYcjimiiX0BMVO8/3ZMz8tUInHr9hrzrl8ouzNlnZP768xujs4NCidG2KtDJWuuIy49KCQX+qhP0G6NhhAfpdI71jxEvScx2+4tdbGB4LtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786489; c=relaxed/simple;
	bh=V7cg76vuGzYlZBmb1xRuLdGLzh2wkZ8gVS5vi5aoQ+k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcpFdPuWq/ezzEsk36otiy+BxpPREAG3PHlG2tQUtcki8bY89SfRU3X3v9h7QQQ7W0oo6+2Wmd+gi76SyIJ5zVA3uoDA6Woptw6i0Une0MYpsthJYgy6tsIvdgZ7xpUgDUKCTu8e9YQl89M3IQmtESzgJfn+eDRAWS6eiqQ+1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=nnjh0d9j; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5869F2082B;
	Thu, 28 Nov 2024 10:34:45 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lwpqmTAjyeLb; Thu, 28 Nov 2024 10:34:44 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id BA1582080B;
	Thu, 28 Nov 2024 10:34:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com BA1582080B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1732786484;
	bh=q8TVP7TyBLN4XoDKRcFbbh8XKmYiaYth6lvXkuEkfOI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=nnjh0d9j4j8r6gWudcZp3i/Ix+HzH3DJ07UraGmI4LV+0W3QToYrb7dNX+g/L7obW
	 queu+XRJ22iTBq/+/hI6rlx9BQp1tS/dQP6H3+FNsw0kcM7p7UKTudR554rrGjdGEK
	 z9CiZ7xYHOQKtYOAyXvC634MflCd2OSlboFR9xr/LTPH6gkCDO/+89tNM6RtrGVeOh
	 GWHixuHsjb9sXV/ZvtqF/LwsnkRRnGMEeeqrkh/htHaSSQ1hZuuyBFD/Pc1kGAmjDK
	 Dv2Gl+fBb/ECEn2hxUK3FrpXbPXfHci2bgYzAuMKYQMUfgXWfBpTtf10L6YNzYnPhe
	 hJSb4VwWo3AMQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 10:34:44 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Nov
 2024 10:34:44 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id CBCCD3181FC0; Thu, 28 Nov 2024 10:34:43 +0100 (CET)
Date: Thu, 28 Nov 2024 10:34:43 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jianbo Liu <jianbol@nvidia.com>
CC: Leon Romanovsky <leon@kernel.org>, Christian Langrock
	<christian.langrock@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH ipsec-rc] xfrm: replay: Fix the update of
 replay_esn->oseq_hi for GSO
Message-ID: <Z0g5M4oFCUCxiDQo@gauss3.secunet.de>
References: <d364e4f9c5f04ed83b777b96e6e1b48f11cb34cf.1731413249.git.leon@kernel.org>
 <c9b051af-b4c7-49cb-aab5-74450bca7288@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c9b051af-b4c7-49cb-aab5-74450bca7288@nvidia.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Nov 28, 2024 at 09:48:10AM +0800, Jianbo Liu wrote:
> 
> 
> On 11/12/2024 8:10 PM, Leon Romanovsky wrote:
> > From: Jianbo Liu <jianbol@nvidia.com>
> > 
> > When skb needs GSO and wrap around happens, if xo->seq.low (seqno of
> > the first skb segment) is before the last seq number but oseq (seqno
> > of the last segment) is after it, xo->seq.low is still bigger than
> > replay_esn->oseq while oseq is smaller than it, so the update of
> > replay_esn->oseq_hi is missed for this case wrap around because of
> > the change in the cited commit.
> > 
> > For example, if sending a packet with gso_segs=3 while old
> > replay_esn->oseq=0xfffffffe, we calculate:
> >      xo->seq.low = 0xfffffffe + 1 = 0x0xffffffff
> >      oseq = 0xfffffffe + 3 = 0x1
> > (oseq < replay_esn->oseq) is true, but (xo->seq.low <
> > replay_esn->oseq) is false, so replay_esn->oseq_hi is not incremented.
> > 
> > To fix this issue, change the outer checking back for the update of
> > replay_esn->oseq_hi. And add new checking inside for the update of
> > packet's oseq_hi.
> > 
> > Fixes: 4b549ccce941 ("xfrm: replay: Fix ESN wrap around for GSO")
> > Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> > Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >   net/xfrm/xfrm_replay.c | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
> > index bc56c6305725..235bbefc2aba 100644
> > --- a/net/xfrm/xfrm_replay.c
> > +++ b/net/xfrm/xfrm_replay.c
> > @@ -714,10 +714,12 @@ static int xfrm_replay_overflow_offload_esn(struct xfrm_state *x, struct sk_buff
> >   			oseq += skb_shinfo(skb)->gso_segs;
> >   		}
> > -		if (unlikely(xo->seq.low < replay_esn->oseq)) {
> > -			XFRM_SKB_CB(skb)->seq.output.hi = ++oseq_hi;
> > -			xo->seq.hi = oseq_hi;
> > -			replay_esn->oseq_hi = oseq_hi;
> > +		if (unlikely(oseq < replay_esn->oseq)) {
> > +			replay_esn->oseq_hi = ++oseq_hi;
> > +			if (xo->seq.low < replay_esn->oseq) {
> > +				XFRM_SKB_CB(skb)->seq.output.hi = oseq_hi;
> > +				xo->seq.hi = oseq_hi;
> > +			}
> >   			if (replay_esn->oseq_hi == 0) {
> >   				replay_esn->oseq--;
> >   				replay_esn->oseq_hi--;
> 
> Gentle ping ...

I've applied that already to the ipsec tree. Just forgot to
send the 'applied' mail.

Anyway, applied thanks a lot!


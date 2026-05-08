Return-Path: <netdev+bounces-285715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OVBBj2Z/WkJgQAAu9opvQ
	(envelope-from <netdev+bounces-285715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 10:05:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D7B4F3767
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 10:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D97B300E5CB
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 08:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6695F34FF45;
	Fri,  8 May 2026 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5MS4k0B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD42D9EDB
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227513; cv=none; b=Uz2GqcfxBIUPT1uGKBUAB+5xnxti+fDeNMxgpmNv/awTe8z9Ik1Z5dL38eC3Gc62mf4INVMhe2lsHhwTjf+IepxCqgM/XvHpBNHIFzpmAxb+KeMGW7l9zOSVJnQBS+9xhYlp0GZ4hWcJ2Y5FnevvP1G6aMbzSi/GiYpe759Sfog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227513; c=relaxed/simple;
	bh=bUGg1zQZFjk2vrx8iWze362hyCNip3NXDXO8yXbGiyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fV4wH3gNsOeJCnLnohyxqXy10KSdH8lIt3qVlOL38y5ZTOe3SgZfAj2v44jK3NhXsUZzil6XLNxgpBKnx41BsmgXgwM5gT0x+JWLCvbpmzfg4Mr/klsNWY2k+NRFdA05P6PVQzqF3IewupvE2dW0UJWlhXQvFYqirVujvKMmt/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5MS4k0B; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-365d4d2f9c1so1116388a91.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 01:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778227511; x=1778832311; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MiizINovSXJGTZYnX3z1Q643KSdKiG0zUSqLPzbaFsM=;
        b=F5MS4k0BiREGhHGIsfzrRikOXkbDfmEc9LxX7dZDeZL3z77KaDqlIwpfv8S1+CVUfG
         SKQEA2xfJ/SimeafHKILreuUy4dGS7mNrVfDL3McsfsemXfHBIcdgJVX6tm+dvDw6IBZ
         h000pmED1yPFEaI4TovLOcur5ft0ZZTduXSaEK+ZQEJ53f3fFp1jpdnVKrliFdCBHszh
         RjUT+i/E3bskEeAmfESivNgTZzLEwe0rLfp7KjNd8hIK6a1Gke/6IUONkfqoSX/uKe9S
         o2u0s8m11mr6nrcA7X2YbYRLXIKemTh30cOM6nuFYsJzGehqL1pxLkV5nnznrv8O4GJg
         C7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778227511; x=1778832311;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MiizINovSXJGTZYnX3z1Q643KSdKiG0zUSqLPzbaFsM=;
        b=fk1Z5++9HyOD6rvCa1Zei3cgl/446HAla6NTVOoJm71nASvbCWYDGYzo0eTI248Es9
         9yiA3tBs6RIQa6GtzVEB7ZMk/25q1vkMikiQgH6KAa9o30OfVAQSpS33jJpgwQCQKiVv
         U1H4Sy08Nv20V1KYPWq0LE7SG2mnfqrxqe0PaOXvjpzV1KVegoqPCackn5UZFtM0VFen
         G/yf2aPwnWq6YRM+99azmAYYkDSeLkstVRH1FzVTWhY8r7VvWTyu6YcgEFWrf4VfBwoZ
         FgyRUpPD6TUNue3Qd21N1AKw9H2lrW1X3Sd6Mqdkt23mz12uwgOWcUgKpl/QBsmp/p/n
         A/9w==
X-Forwarded-Encrypted: i=1; AFNElJ/g8Cb3sPfhBdnAMv1sFCYOZeD2oHUEUmaJCZgEKZu1CfQBBg2EMS0uFZBnN/TvLxr2jz1XsAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyouXrTs0NJjfsCI6TEXScaIC0+Uh9BXoGpB5R6lOKkPNI/AOM0
	wsHbhx2NliMG7+Ou2qzosAwumK/YIHH4s7Gc9vpmSwS2yS59ms3b0yk1
X-Gm-Gg: Acq92OEhRtuOEvupM7ZT9ErFTb712vHieDvTMzYrqMT1+aXCMi2SLsk/0GrA/8FaWDV
	byKYCYWgAVHJsBV1rwrZCZ32tveyD3xOif+T5wCtJJUNWlPyjX3VO1RpEnr+T6NiKZg6cVNGs6M
	H/065z03TsOxkKn8FktH8MoKGSnYJBM0dXFstBtVIicptiqIfWWrEAjqncsqbEGpUkywDDZEskW
	z4+MaE9C6UlS26S1PTC1tjuiV2wkihQNLTJkW12j/xN/8yG65cbBGE4tfVNkqMgUKij9vzC4g2D
	HNrvSBT8zVlPS0mQWwO+9hq3jHBypdckZ+j3CdgDToRqk1DReLlzg8yd8YFuHXAsPLHLjSW23TP
	9nG98xkM8biKHIZ0NM1wtcRM+DEU8QKlQ/IkQ03/M3ZxcpicThrnsTdDoSS5rTyV/N6cE7fbwI0
	tD1q4rdGR8oWJAb8lT9E66zxCca2Q7pWxZcl/ATgO+Mxs=
X-Received: by 2002:a17:903:181:b0:2b0:61c2:8e83 with SMTP id d9443c01a7336-2ba79287515mr116584445ad.20.1778227511279;
        Fri, 08 May 2026 01:05:11 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ebe0e8sm13850335ad.76.2026.05.08.01.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 01:05:10 -0700 (PDT)
Date: Fri, 8 May 2026 17:05:06 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, qingfang.deng@linux.dev,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v2] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
Message-ID: <af2ZMmJ4Oa0tscfC@v4bel>
References: <af2F1FU5d4Q_Gn1W@v4bel>
 <6a1a50d1-9aa8-406d-90b1-4d5ca9fe0afb@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a1a50d1-9aa8-406d-90b1-4d5ca9fe0afb@linux.dev>
X-Rspamd-Queue-Id: 86D7B4F3767
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285715-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,davemloft.net,google.com,kernel.org,linux.dev,lists.infradead.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 03:58:34PM +0800, Jiayuan Chen wrote:
> 
> On 5/8/26 2:42 PM, Hyunwoo Kim wrote:
> > The DATA-packet handler in rxrpc_input_call_event() and the RESPONSE
> > handler in rxrpc_verify_response() copy the skb to a linear one before
> > calling into the security ops only when skb_cloned() is true.  An skb
> > that is not cloned but still carries paged fragments (skb->data_len != 0)
> > falls through to the in-place decryption path, which binds the frag
> > pages directly into the AEAD/skcipher SGL via skb_to_sgvec().
> > 
> > Extend the gate so that any skb with non-linear data is also copied,
> > ensuring the security handler always operates on a fully linear skb.
> > The OOM/trace handling already in place is reused.
> > 
> > Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> > Changes in v2:
> > - Use skb_is_nonlinear() instead of skb->data_len
> > - v1: https://lore.kernel.org/all/afKV2zGR6rrelPC7@v4bel/
> > ---
> >   net/rxrpc/call_event.c | 2 +-
> >   net/rxrpc/conn_event.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
> > index fdd683261226..a6ad5ff6ec5f 100644
> > --- a/net/rxrpc/call_event.c
> > +++ b/net/rxrpc/call_event.c
> > @@ -334,7 +334,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
> >   			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
> >   			    sp->hdr.securityIndex != 0 &&
> > -			    skb_cloned(skb)) {
> > +			    (skb_cloned(skb) || skb_is_nonlinear(skb))) {
> >   				/* Unshare the packet so that it can be
> >   				 * modified by in-place decryption.
> >   				 */
> > diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> > index a2130d25aaa9..632cbeff1f5d 100644
> > --- a/net/rxrpc/conn_event.c
> > +++ b/net/rxrpc/conn_event.c
> > @@ -245,7 +245,7 @@ static int rxrpc_verify_response(struct rxrpc_connection *conn,
> >   {
> >   	int ret;
> > -	if (skb_cloned(skb)) {
> > +	if (skb_cloned(skb) || skb_is_nonlinear(skb)) {
> >   		/* Copy the packet if shared so that we can do in-place
> >   		 * decryption.
> >   		 */
> 
> 
> Why not adopt the same gate as the ESP fix:
> 
> 
>     skb_cloned(skb) || skb_has_frag_list(skb) || skb_has_shared_frag(skb)
> 
> 
> so NIC page_pool RX keeps its zero-copy path while still catching the
> splice-loopback vector?

Yeah, that approach preserves the fast path. I'll test and submit v3.


Best regards,
Hyunwoo Kim


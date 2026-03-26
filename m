Return-Path: <netdev+bounces-272243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BZOOeSaxWnP/wQAu9opvQ
	(envelope-from <netdev+bounces-272243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:45:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6AD33B85A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B66E73017022
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D2B3A6EF8;
	Thu, 26 Mar 2026 20:44:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8753A39F165;
	Thu, 26 Mar 2026 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557881; cv=none; b=AbUWSWcnMO3F+pTcBKO8SWUexjwG1Rso354p0hl1mTvnSu1J+WQ0QHG/mmQRUfhILVWdZYPASbm7ycI9Fw4TuII3uZ5AyWsu+xadRBKYKkQOCSeQ2YPB06GVwqYSgRdRzB2UTjS9gR5MnptWxrK1Bas3jSisvh2x2BzV4M1Hv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557881; c=relaxed/simple;
	bh=fjPrbuyfnm0jixwV3/zI4L5gpztvZw3EKxXNkC9QFRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBXaneYVoZIvR87HqGk+BgiBUzypnuF8HcG28qfgzKLwbYfaR9X9gkkbjQtdyjvM2+EhtDWFuPLHvV6sc59v454b+PsEGs+UCB2wGINgDd1M/XYrueB5gP9C4a6Bw9SaWsMOUFnT/3wAH6yBWgs91OTd6I9o/FYNZADMpLJeFCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 47248605E7; Thu, 26 Mar 2026 21:44:37 +0100 (CET)
Date: Thu, 26 Mar 2026 21:44:17 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Weiming Shi <bestswngs@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH nf] netfilter: nf_conntrack_sip: fix use of uninitialized
 rtp_addr in process_sdp
Message-ID: <acWaoSUm9SrD8_pS@strlen.de>
References: <20260323080727.2932866-3-bestswngs@gmail.com>
 <acWVV__8xRMezYrU@chamomile>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acWVV__8xRMezYrU@chamomile>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272243-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nwl.cc,vger.kernel.org,netfilter.org,asu.edu];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,netfilter.org:email]
X-Rspamd-Queue-Id: EE6AD33B85A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > @@ -1091,9 +1095,11 @@ static int process_sdp(struct sk_buff *skb, unsigned int protoff,
> >  					  &matchoff, &matchlen, &maddr) > 0) {
> >  			maddr_len = matchlen;
> >  			memcpy(&rtp_addr, &maddr, sizeof(rtp_addr));
> > -		} else if (caddr_len)
> > +			have_rtp_addr = true;
> > +		} else if (caddr_len) {
> >  			memcpy(&rtp_addr, &caddr, sizeof(rtp_addr));
> > -		else {
> > +			have_rtp_addr = true;
> 
> After this update, this loop sets over rtp_addr, but this was already
> set by ct_sip_parse_sdp_addr() a bit above.
> 
> This new chunk results in:
> 
>                 } else if (caddr_len) {
>                        memcpy(&rtp_addr, &caddr, sizeof(rtp_addr));
>                        have_rtp_addr = true;
> 
> which is not needed? Why does caddr need to be copied over and over
> again to rtp_addr?

Code before update was:
                if (ct_sip_parse_sdp_addr(ct, *dptr, mediaoff, *datalen,
                                          SDP_HDR_CONNECTION, SDP_HDR_MEDIA,
                                          &matchoff, &matchlen, &maddr) > 0) {
                        maddr_len = matchlen;
                        memcpy(&rtp_addr, &maddr, sizeof(rtp_addr));
                } else if (caddr_len)
                        memcpy(&rtp_addr, &caddr, sizeof(rtp_addr));
                else {


so we re-set rtp_addr to the session description in case it was
overwritten by earlier iteration of the loop.

1. Extract session description (caddr_len set)
2. enter loop, parse media description (overwrite rtp_addr with media
   address)
3. next loop fails ct_sip_parse_sdp_addr() call
   Restore the original session address instead of using
   the previous media description.

I think its correct this way.


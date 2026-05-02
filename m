Return-Path: <netdev+bounces-283388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5c30AUC59WmAOQIAu9opvQ
	(envelope-from <netdev+bounces-283388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 10:43:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 523F34B17A0
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 10:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73E5230134A2
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 08:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0262DEA90;
	Sat,  2 May 2026 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WHgcvyx8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0C7209F43;
	Sat,  2 May 2026 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777711420; cv=none; b=j8rOvW8p9p/LsFRk/Q/q4OzTMA15PqyrmKlkuWERXkJEeoa0ULbazGiYsezCPJkjYBhIK54A0/2iFW6jhXayptrkD6tbmXDtfHK0NIaNigrIjpSGGJHekCp00nRhXsvD58XwyY7sngiMF5mCebA21HpPJKXx0mSdlauR3FJqMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777711420; c=relaxed/simple;
	bh=cGT2LsQdCuNfBjWP4h6E5RQfcN7GyBzIdyAZwXqCsII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8Xxo9hCAvBUceCmJcIdjJ7M8/LLbWJdldGQnCBKm7gRhFFitSK0iRG6uCtHzZZ/73eODjib+tVcrzEJyXXffVe3ObfRkfGMBVldcenNFgEPm9P+46acmsx8tZ1DO0vPDmz6NZ5WCxnzymAQr4VEFMUWwpNNklvZ0UvR4LZ8Xm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WHgcvyx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C810C19425;
	Sat,  2 May 2026 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777711420;
	bh=cGT2LsQdCuNfBjWP4h6E5RQfcN7GyBzIdyAZwXqCsII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHgcvyx8/S1amLAK7e2Ztp3yr7HLWIs+4kJGxKENpajrxypdEsYBoIYC7UsSvcfNK
	 SATUdZ3L7mqYn2PVaNY1aovGWzePgAdBL36FExXmdPhAv6vdigKZVzi9hyZFaF4P33
	 fMyuMjVxEbeski3JStShgMDFn66DjQVS8dhLFjqI=
Date: Sat, 2 May 2026 10:42:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yuan Tan <yuantan098@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, stable <stable@kernel.org>
Subject: Re: [PATCH net v3] ipv6: rpl: reserve mac_len headroom when
 recompressed SRH grows
Message-ID: <2026050237-subheader-footsie-9f72@gregkh>
References: <2026042133-gout-unvented-1bd9@gregkh>
 <CAPuPA7JS-yG_dYaPVjv9JiGOEXSpExXSQhsZaexUkr-WMeQHrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPuPA7JS-yG_dYaPVjv9JiGOEXSpExXSQhsZaexUkr-WMeQHrw@mail.gmail.com>
X-Rspamd-Queue-Id: 523F34B17A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283388-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,davemloft.net:email]

On Sat, May 02, 2026 at 01:36:18AM -0700, Yuan Tan wrote:
> On Tue, Apr 21, 2026 at 6:16 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > ipv6_rpl_srh_rcv() decompresses an RFC 6554 Source Routing Header, swaps
> > the next segment into ipv6_hdr->daddr, recompresses, then pulls the old
> > header and pushes the new one plus the IPv6 header back.  The
> > recompressed header can be larger than the received one when the swap
> > reduces the common-prefix length the segments share with daddr (CmprI=0,
> > CmprE>0, seg[0][0] != daddr[0] gives the maximum +8 bytes).
> >
> > pskb_expand_head() was gated on segments_left == 0, so on earlier
> > segments the push consumed unchecked headroom.  Once skb_push() leaves
> > fewer than skb->mac_len bytes in front of data,
> > skb_mac_header_rebuild()'s call to:
> >
> >         skb_set_mac_header(skb, -skb->mac_len);
> >
> > will store (data - head) - mac_len into the u16 mac_header field, which
> > wraps to ~65530, and the following memmove() writes mac_len bytes ~64KiB
> > past skb->head.
> >
> > A single AF_INET6/SOCK_RAW/IPV6_HDRINCL packet over lo with a two
> > segment type-3 SRH (CmprI=0, CmprE=15) reaches headroom 8 after one
> > pass; KASAN reports a 14-byte OOB write in ipv6_rthdr_rcv.
> >
> > Fix this by expanding the head whenever the remaining room is less than
> > the push size plus mac_len, and request that much extra so the rebuilt
> > MAC header fits afterwards.
> >
> > Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: David Ahern <dsahern@kernel.org>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Simon Horman <horms@kernel.org>
> > Cc: stable <stable@kernel.org>
> > Reported-by: Anthropic
> > Assisted-by: gkh_clanker_t1000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v3: - skb_postpull_rcsum() should not be changed, it's chdr NOT hdr, ugh
> >       Link to v2: https://lore.kernel.org/r/2026042158-sediment-elliptic-a954@gregkh
> >
> > v2: - fixed up if statement to actually work properly, and test it
> >       against a working poc (poc will be sent separately)
> >       Reworded the changelog and the subject to make more sense
> >       Link to v1: https://lore.kernel.org/r/2026042024-cabbie-gills-9371@gregkh
> >
> >  net/ipv6/exthdrs.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> > index 95558fd6f447..03cbce842c1a 100644
> > --- a/net/ipv6/exthdrs.c
> > +++ b/net/ipv6/exthdrs.c
> > @@ -491,6 +491,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
> >         struct net *net = dev_net(skb->dev);
> >         struct inet6_dev *idev;
> >         struct ipv6hdr *oldhdr;
> > +       unsigned int chdr_len;
> >         unsigned char *buf;
> >         int accept_rpl_seg;
> >         int i, err;
> > @@ -592,8 +593,10 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
> >         skb_pull(skb, ((hdr->hdrlen + 1) << 3));
> >         skb_postpull_rcsum(skb, oldhdr,
> >                            sizeof(struct ipv6hdr) + ((hdr->hdrlen + 1) << 3));
> > -       if (unlikely(!hdr->segments_left)) {
> > -               if (pskb_expand_head(skb, sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3), 0,
> > +       chdr_len = sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3);
> > +       if (unlikely(!hdr->segments_left ||
> > +                    skb_headroom(skb) < chdr_len + skb->mac_len)) {
> > +               if (pskb_expand_head(skb, chdr_len + skb->mac_len, 0,
> >                                      GFP_ATOMIC)) {
> >                         __IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_OUTDISCARDS);
> >                         kfree_skb(skb);
> > @@ -603,7 +606,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
> >
> >                 oldhdr = ipv6_hdr(skb);
> >         }
> > -       skb_push(skb, ((chdr->hdrlen + 1) << 3) + sizeof(struct ipv6hdr));
> > +       skb_push(skb, chdr_len);
> >         skb_reset_network_header(skb);
> >         skb_mac_header_rebuild(skb);
> >         skb_set_transport_header(skb, sizeof(struct ipv6hdr));
> > --
> > 2.53.0
> >
> 
> I am happy to see this bug is finally fixed.
> 
> However, it seems the Reported-by tag does not include our credit.
> 
> We first submitted the security report and patch to
> security@kernel.org on February 23, titled:
> 
> [SECURITY] IPv6/RPL: 14-byte controllable OOB write via SRH len
> overflow + skb_mac_header_rebuild() u16 wraparound
> 
> [PATCH] ipv6: rpl: rebuild MAC+metadata safely when rewriting SRH
> 
> We have aslo followed up and resent the patch several times, CCing all
> relevant maintainers.
> 
> Could our credit be added to the patch?
> 
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <dstsmallbird@foxmail.com>
> 
> I noticed this patch has already been merged into the mainline. Maybe
> it's too late to amend this patch. Is there any other way to document
> our reporting credit in the official records? Maybe in the stable
> backport?

Sorry, I made this patch based on a different report to me as is
documented in this patch, and did not notice that it was the same thing
as this one as I am drowning in reports.

This happens at times, and we can't rewrite public git history as that's
impossible to do, sorry about that.  You have a public confirmation here
that yes, you did report this same issue, and yes, you did submit a
patch to resolve this, but it ended up being different from the one that
was accepted.  Which again, happens all the time, it's just the nature
of development with a huge body of contributors.

thanks,

greg k-h


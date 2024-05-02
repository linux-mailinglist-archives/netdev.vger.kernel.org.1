Return-Path: <netdev+bounces-92997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FD58B98E7
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8590A282774
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29612E633;
	Thu,  2 May 2024 10:36:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08EA56B7B
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 10:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646183; cv=none; b=KY1+ZAyOQkuAkoimeNoLCBQyEvUnrc5OmMKBE9GYLGeYl1eu9liP4gwdG0CV+8i9PVCUctkS99o8wvA8nrcRmGhti29PepC6DeJQ1WvobU+3WYPCz+GxI91kIVR7LIBAbpNSITBVLjNYIrNuEslRNa80KbDsi5FLJhrltKiy97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646183; c=relaxed/simple;
	bh=M0fPfr4ELBWmMgf6GZptoG0JrEx/G7cqOC8iU32Qgwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDQvZR2yVb5bv9C4TJxuQXez04WEW9uSwWtYxC0KBsveAVE3CrZE3iAI1MVua6HTQJn+ebDg5to+Zi5xDM1v70dvmrt5LzyRJ9Dhfu23KawhnO2FDFdfGvaIQ1ndauipxY8iWH8dCvQNrynpgH/QNaBP7t9PIx83yH95nJ+2v6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Thu, 2 May 2024 12:36:13 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, fw@strlen.de
Subject: Re: [PATCH net-next 02/12] gtp: properly parse extension headers
Message-ID: <ZjNsnb-PEM0Hnie1@calendula>
References: <20240425105138.1361098-1-pablo@netfilter.org>
 <20240425105138.1361098-3-pablo@netfilter.org>
 <20240426202852.GD516117@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426202852.GD516117@kernel.org>

On Fri, Apr 26, 2024 at 09:28:52PM +0100, Simon Horman wrote:
> On Thu, Apr 25, 2024 at 12:51:28PM +0200, Pablo Neira Ayuso wrote:
> > Currently GTP packets are dropped if the next extension field is set to
> > non-zero value, but this are valid GTP packets.
> > 
> > TS 29.281 provides a longer header format, which is defined as struct
> > gtp1_header_long. Such long header format is used if any of the S, PN, E
> > flags is set.
> > 
> > This long header is 4 bytes longer than struct gtp1_header, plus
> > variable length (optional) extension headers. The next extension header
> > field is zero is no extension header is provided.
> > 
> > The extension header is composed of a length field which includes total
> > number of 4 byte words including the extension header itself (1 byte),
> > payload (variable length) and next type (1 byte). The extension header
> > size and its payload is aligned to 4 bytes.
> > 
> > A GTP packet might come with a chain extensions headers, which makes it
> > slightly cumbersome to parse because the extension next header field
> > comes at the end of the extension header, and there is a need to check
> > if this field becomes zero to stop the extension header parser.
> > 
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> >  drivers/net/gtp.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  include/net/gtp.h |  5 +++++
> >  2 files changed, 46 insertions(+)
> > 
> > diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> > index 4680cdf4fa70..9451c74c1a7d 100644
> > --- a/drivers/net/gtp.c
> > +++ b/drivers/net/gtp.c
> > @@ -567,6 +567,43 @@ static int gtp1u_handle_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
> >  				       msg, 0, GTP_GENL_MCGRP, GFP_ATOMIC);
> >  }
> >  
> > +static int gtp_parse_exthdrs(struct sk_buff *skb, unsigned int *hdrlen)
> > +{
> > +	struct gtp_ext_hdr *gtp_exthdr, _gtp_exthdr;
> > +	unsigned int offset = *hdrlen;
> > +	__u8 *next_type, _next_type;
> > +
> > +	/* From 29.060: "The Extension Header Length field specifies the length
> > +	 * of the particular Extension header in 4 octets units."
> > +	 *
> > +	 * This length field includes length field size itself (1 byte),
> > +	 * payload (variable length) and next type (1 byte). The extension
> > +	 * header is aligned to to 4 bytes.
> > +	 */
> > +
> > +	do {
> > +		gtp_exthdr = skb_header_pointer(skb, offset, sizeof(gtp_exthdr),
> 
> Hi Pablo,
> 
> Should this be sizeof(*gtp_exthdr)?

Indeed, coincidentally, extension header size if 4 bytes, then this is
checking 8 bytes on x86_64 and 4 bytes in x86.

> And likewise, in the ip_version calculation in gtp_inner_proto()
> in [PATCH 11/12] gtp: support for IPv4-in-IPv6-GTP and IPv6-in-IPv4-GTP 
> 
> Flagged by Coccinelle.

Thanks; I will fix and revamp.


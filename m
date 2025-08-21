Return-Path: <netdev+bounces-215639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 569F4B2FC03
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0235F1BA19BB
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7682356B9;
	Thu, 21 Aug 2025 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/ASva8X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8171623D7C0
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785232; cv=none; b=FjX+TYlxMt4kz7H05SXrV/uhF4rUW2Lpt5rfaPdnltpoiIRpeq0rbC4jQcriA5rYFsz4LuePQ/6QOFbAqzBktCpX+XFI11qiEB7ihZmErstzLbf/Blgdc5QXytx+0u0bxAS0PMufLXTa8wqmELAnPkp2pplQhbW66oDnsfSeCp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785232; c=relaxed/simple;
	bh=nVC4e7skfIJuT9Xx1y2TwqKkMvv2bnZ9KINS/xoKEjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvUyuQ4maregaQW0qTkNMOcjcnCVR/i0b0Is4N5eBbMpQjUqXCQYUUBpS3TBL9CKPtH2QuEmpOZE+p/1zVTDi+UKQmg+nK94oKgwA00tr/DAA8tN0vcBzo5UGUMsNCe/KTxpD4cZ/FSyZFfnyF2GBtX/dwf+4IJBbdip/gyuga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/ASva8X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755785229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pkI4mCYDrgguWBZNB4zbd1CX9VG2+lm5bnKjZZvuPqw=;
	b=h/ASva8X3n9pZjfwi3Ba+jdhOz6bFYalRCXiY0zJHpPEMvk5au5Ga5ysZrSlUWoNFgBhb4
	cjbmqsUHW4mXPFxGXxNSP9q76T4Urr6E/G5NRhtsSEvvpXdllHb0fIQpb7f2NPZZ/WP29n
	PYfmDr0tiKmhgByMzcu0ZrsnwX7b+7E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-ebuvXaoHNqSCdZh_W4_s0Q-1; Thu, 21 Aug 2025 10:07:07 -0400
X-MC-Unique: ebuvXaoHNqSCdZh_W4_s0Q-1
X-Mimecast-MFC-AGG-ID: ebuvXaoHNqSCdZh_W4_s0Q_1755785227
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109bd3fa0so10504411cf.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 07:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785227; x=1756390027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkI4mCYDrgguWBZNB4zbd1CX9VG2+lm5bnKjZZvuPqw=;
        b=ul025Rv/zXkgi5wBb18WE6ySRiizl4eKvI2+OgSLz7BEhN9RMioLwt3Fmu67S6vEu7
         IvChK6VjicFPNLVT2luCtI5Sy5kzIOwhgrVb+OgEIH4ubQrxeQaps9D+xZSfCjqyE5eS
         nfIgBy5kKeytUOlRd85sNL9i4Jxldnv61BUgZwvtevWZhT9ysD4M5NeGEdCbKQ0A3IuA
         81tWJ43tj6xEKgR85nYPB5p2iI64xjucc4756GAtN2WMwgehsthciOTs2Cq+d1DRWZUg
         b2jCIgBCu/M2XMQqjTd9i0HKn9BDK4GIc/e1A0ZC6ZJHxDWHSN01PdmRHjgUKWbfw6Jo
         4OOw==
X-Forwarded-Encrypted: i=1; AJvYcCV7oXLTBFnM5V5T7UnRRjKyu+uVNiAnrZ0WWuOqHqwuv2HSkORoUsWlX5ksF2ahl7wCtjhwnFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwSgoGVLuE92vMgg4f84Acli3GuoNiv6a7sfhuQG/cF5RHMGoF
	ufnKM383fC7gcblyDXiowfBaAvao5kV00nKfjgMibc0CtUMDBcQ5vDalrF3M3U1EPCuG+0Y4W+2
	NCQ4UrmuI0418/jnKhbfTFIlIB3wcMnD8v58vBrl/1FRuib4iEazQco5KDQ==
X-Gm-Gg: ASbGncuZq4ILK77lQEOlwaKTpD7qeVP5h4u4yEHAAiac0W9pYTjoM2xOuVavOkafh3F
	1kHMez/ZKZm6FAVAKhbTxdCcrxxkVzk0xs6Mgbo88gRYKT4g2Qp4PWOEh2xP+fBEYTiEB8WFZTS
	VRSFXaF0DBpPvY+PwET54gQhMCU1irFpc4OZAAPgv+bDFTc90pNv2zpfCa+KrOr45rJs4rRK8C5
	mhoTVwPtpuFW/WzbMh4VFJ5qDtJdo/oacz/wo6EVbJhewoB3YngOSitSIYo3kv5R8zbvFZsjb9y
	12AZtX2aVZ8A+We/n66MJe4fVWLgrovbK92aZwNFhJVakcWkQk1yK4nmv8dNnmKcsdJrQ1DXBlJ
	ePwxc2QrLJMBkE80fLJk=
X-Received: by 2002:a05:622a:4089:b0:4b0:86e5:ef94 with SMTP id d75a77b69052e-4b29ff95a5cmr28813131cf.55.1755785226668;
        Thu, 21 Aug 2025 07:07:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsCa1bqRsI4eZH/MPz64iUM+4n/41OhqcS9oKqt7zb6zdFMnfR53x2HdvE3gFBZ8B6W578TA==
X-Received: by 2002:a05:622a:4089:b0:4b0:86e5:ef94 with SMTP id d75a77b69052e-4b29ff95a5cmr28812371cf.55.1755785225958;
        Thu, 21 Aug 2025 07:07:05 -0700 (PDT)
Received: from debian (2a01cb058d23d600dec560d2f476214c.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:dec5:60d2:f476:214c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc5a17csm101529211cf.13.2025.08.21.07.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:07:05 -0700 (PDT)
Date: Thu, 21 Aug 2025 16:06:57 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	David Ahern <dsahern@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCH net-next] ipv4: Convert ->flowi4_tos to dscp_t.
Message-ID: <aKcoAbPXff_IT7MN@debian>
References: <5af3062dabed0fb45506a38114082b5090e61a52.1755715298.git.gnault@redhat.com>
 <aKbDCJWjMpUEOtXe@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKbDCJWjMpUEOtXe@shredder>

On Thu, Aug 21, 2025 at 09:56:08AM +0300, Ido Schimmel wrote:
> On Thu, Aug 21, 2025 at 01:32:03AM +0200, Guillaume Nault wrote:
> > Convert the ->flowic_tos field of struct flowi_common from __u8 to
> > dscp_t, rename it ->flowic_dscp and propagate these changes to struct
> > flowi and struct flowi4.
> > 
> > We've had several bugs in the past where ECN bits could interfere with
> > IPv4 routing, because these bits were not properly cleared when setting
> > ->flowi4_tos. These bugs should be fixed now and the dscp_t type has
> > been introduced to ensure that variables carrying DSCP values don't
> > accidentally have any ECN bits set. Several variables and structure
> > fields have been converted to dscp_t already, but the main IPv4 routing
> > structure, struct flowi4, is still using a __u8. To avoid any future
> > regression, this patch converts it to dscp_t.
> > 
> > There are many users to convert at once. Fortunately, around half of
> > ->flowi4_tos users already have a dscp_t value at hand, which they
> > currently convert to __u8 using inet_dscp_to_dsfield(). For all of
> > these users, we just need to drop that conversion.
> > 
> > But, although we try to do the __u8 <-> dscp_t conversions at the
> > boundaries of the network or of user space, some places still store
> > TOS/DSCP variables as __u8 in core networking code. Some structure
> > fields, like struct ip_tunnel_key::tos could be converted to dscp_t,
> > but that would require a lot of work, so this is left for later. Other
> > places can't be converted, for example because the data structure is
> > part of UAPI or because the same variable or field is also used for
> > handling ECN in other parts of the code. In all of these cases where we
> > don't have a dscp_t variable at hand, we need to use
> > inet_dsfield_to_dscp() when interacting with ->flowi4_dscp.
> > 
> > Signed-off-by: Guillaume Nault <gnault@redhat.com>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> Thanks! One nit below
> 
> [...]
> 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index da391e2b0788..c75f95c60af3 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2373,7 +2373,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
> >  		struct flowi4 fl4 = {
> >  			.flowi4_flags = FLOWI_FLAG_ANYSRC,
> >  			.flowi4_mark  = skb->mark,
> > -			.flowi4_tos   = inet_dscp_to_dsfield(ip4h_dscp(ip4h)),
> > +			.flowi4_dscp   = ip4h_dscp(ip4h),
> 
> Nit: alignment is off

Thanks. I thought I had carefully reviewed my patch before posting...

By the way, do you have an opinion about converting struct
ip_tunnel_key::tos? Do you think it'd be worth it, or just code churn?

> >  			.flowi4_oif   = dev->ifindex,
> >  			.flowi4_proto = ip4h->protocol,
> >  			.daddr	      = ip4h->daddr,
> 



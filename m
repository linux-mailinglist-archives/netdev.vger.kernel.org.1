Return-Path: <netdev+bounces-118580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69E29521CA
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 20:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD291F22AAC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222021BB699;
	Wed, 14 Aug 2024 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlmDG1X+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94461BD025
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658709; cv=none; b=fTd0A4VaXwlxe/G3GPsYXrWRNDqCHty02aZbmwvkycd/GDUXDjpkWUX2zXeIKOrnl/dpqTUojMXXbL5IiQ0zEv3FIim60tEnsXYKQ3p9k0v/7j2Q5O1FCIAnXsWzeT5WHf83h0RKJU0EANhpvAe8X6Zro0eOPU9x3h+GnS/JOUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658709; c=relaxed/simple;
	bh=62rETTyuNkVruC27CYCPISlviIZHaAYvVtTtYOii+M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWQxN3oGES9DBtGWjYRZ7zWD8oMq542E+LmKbnhxL8P+NPM/LaHFkySnDBvYLTRIziPNZ6pqXj1XEXGGLL+FAG6yhY3g5FtytQoVrt+ejjPV6MpG3n7ZamA1xFwdwNjagbqibtYbIw5vXXAkhnOiezj5of4VhFIPhzbH7Mlv5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlmDG1X+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-710ece280b6so58906b3a.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723658707; x=1724263507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Qdv2pjUYClueVHHYlVI8urUMsjeD3uGQyiP8PfAErE=;
        b=TlmDG1X+6m4iZcuMT+Y1hD0g7zIMxpDIOYSTuZuT/ueSaVouXFkMZ9F9Njr57fujCK
         qoV5d5diIuL0z1UMXFG1IFwrDu9yjRmnGNIUWYvy5Z6UjbPHnLRIq4w/CSYgXkAcFqd0
         b0i4QUi5kTHU/o4gsjHS0yAl5J6ULqgVXSyn2ybkfFsbKsC1eoKE4ja8GKYBV9ej7egS
         8WZ1IR0fL1+C+y0clkF6HJHTUpUOD2dcRQM/+auDlHCr+NdpYiBh/sm8WxDCoSuE+eNv
         NBmGXvmeeNLd2siZqnCbPFHcgAODId75ByR3jy0GNQOoExIy/WmtP1cWfpksAT952tOm
         +WsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723658707; x=1724263507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Qdv2pjUYClueVHHYlVI8urUMsjeD3uGQyiP8PfAErE=;
        b=X4Mm7xZhPHIflejnuUpawDTCWWpTA1jpP7eJdlPz7ktdllT29LLtjuoVHQ92WKXw0B
         tuwZcQrW5EPc9X3vcuy5Uv+CWUXbLLFOCn25XBlpazqO/yrbfpv+hB4h2xSRuubUA5kR
         I58v3LuwSWWPv4KSQGSbhfBxCk+eOQ4f/T/gz6+OS17jQvNxtXkZHCDjgOMoEkrvBHgP
         p3mhjYUZkobomO7E+lpABzumlC3bI8vE9+6WGQVWDskWiwHFs2ErqqTI1rGxbsvFQi6E
         pZ1BYVG60GHtcP6Pq3AVItA1/6GX1frid996mXwACd6MTViOD6eMrHDC9oJjR0Tc57Qr
         biCQ==
X-Gm-Message-State: AOJu0YzeImO7ya1UetR2pJWtWWp1SxGey4fULrMv/US597+1a0ufAw2N
	sVly4Y+5osirqvxULxDwCwnzy2RHhoJvgMplOHQ+LNwMHKobXcIg
X-Google-Smtp-Source: AGHT+IEy8hMC8Brbv0YZ1Ag/kY2WagXz/GIHM01Y7BjKr3FEmQDpgo90zRBjzMznLyjEod1xXOfKaw==
X-Received: by 2002:a05:6a20:9f0a:b0:1c8:9749:a4c1 with SMTP id adf61e73a8af0-1c8eaf96890mr4821745637.49.1723658706796;
        Wed, 14 Aug 2024 11:05:06 -0700 (PDT)
Received: from localhost ([12.216.211.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ab56f0sm7629825b3a.197.2024.08.14.11.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 11:05:06 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:05:05 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	tparkin@katalix.com, horms@kernel.org
Subject: Re: [PATCH v2 net-next 6/9] l2tp: use get_next APIs for management
 requests and procfs/debugfs
Message-ID: <Zrzx0RimFyQw063m@pop-os.localdomain>
References: <cover.1723011569.git.jchapman@katalix.com>
 <0ed95752e184f213260e84b4ff3ee4f4bedeed9e.1723011569.git.jchapman@katalix.com>
 <ZrkEofKqANg/9sTB@pop-os.localdomain>
 <6730f50c-929d-aaed-0282-60eb321f8679@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6730f50c-929d-aaed-0282-60eb321f8679@katalix.com>

On Mon, Aug 12, 2024 at 09:14:42AM +0100, James Chapman wrote:
> On 11/08/2024 19:36, Cong Wang wrote:
> > On Wed, Aug 07, 2024 at 07:54:49AM +0100, James Chapman wrote:
> > > diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
> > > index cc464982a7d9..0fabacffc3f3 100644
> > > --- a/net/l2tp/l2tp_core.h
> > > +++ b/net/l2tp/l2tp_core.h
> > > @@ -219,14 +219,12 @@ void l2tp_session_dec_refcount(struct l2tp_session *session);
> > >    * the caller must ensure that the reference is dropped appropriately.
> > >    */
> > >   struct l2tp_tunnel *l2tp_tunnel_get(const struct net *net, u32 tunnel_id);
> > > -struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth);
> > >   struct l2tp_tunnel *l2tp_tunnel_get_next(const struct net *net, unsigned long *key);
> > >   struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk, u32 session_id);
> > >   struct l2tp_session *l2tp_v2_session_get(const struct net *net, u16 tunnel_id, u16 session_id);
> > >   struct l2tp_session *l2tp_session_get(const struct net *net, struct sock *sk, int pver,
> > >   				      u32 tunnel_id, u32 session_id);
> > > -struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth);
> > >   struct l2tp_session *l2tp_session_get_next(const struct net *net, struct sock *sk, int pver,
> > >   					   u32 tunnel_id, unsigned long *key);
> > >   struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
> > > diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
> > > index 8755ae521154..b2134b57ed18 100644
> > > --- a/net/l2tp/l2tp_debugfs.c
> > > +++ b/net/l2tp/l2tp_debugfs.c
> > > @@ -34,8 +34,8 @@ static struct dentry *rootdir;
> > >   struct l2tp_dfs_seq_data {
> > >   	struct net	*net;
> > >   	netns_tracker	ns_tracker;
> > > -	int tunnel_idx;			/* current tunnel */
> > > -	int session_idx;		/* index of session within current tunnel */
> > > +	unsigned long tkey;		/* lookup key of current tunnel */
> > > +	unsigned long skey;		/* lookup key of current session */
> > 
> > Any reason to change the type from int to unsigned long?
> > 
> > Asking because tunnel ID remains to be 32bit unsigned int as a part of
> > UAPI.
> > 
> > Thanks.
> 
> It's used as the key in and potentially modified by idr_get_next_ul calls.

idr_get_next() takes an `int` ID. So the reason is not this API, it must be
something else.



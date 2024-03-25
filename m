Return-Path: <netdev+bounces-81575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2711C88A5CC
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1588320EC1
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32884146A65;
	Mon, 25 Mar 2024 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="fDrMuJmd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D468175C86
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369041; cv=none; b=Vkcq7+fmzmCaiaKA0buMtgllJuMBridVxwoA9/4siNmE5Wuv6fHUWV9C5o3GmRqM5ROSsgWxxISePwCrVhRymL+ulxall5lraMKms9v0aqYfxELgnIiBmC88FH14W0poyKLsH36UJmO5WY6gCmjAUW7+cyQFne3YHrYkUyegVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369041; c=relaxed/simple;
	bh=6AMK/q87suqkII+7ZbyK33MkYkUdhsUDBWrYZwGqU3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6JO7POs3YWuMefjllTJ8NsAR4tp+49VTo9cfJ9wbcfv4+CClvsVpUPJ5hstscBzaZBtNXs1aG9WHRcV2z1HXTitLiyNKx/Z4GF73o9nrHGlMBLN6MRPPPW89xQBbd3b8MJyedhAlS5J3/MugwUXgj40qTDHakjR8X0rh7moyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=fDrMuJmd; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513da1c1f26so5373042e87.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711369037; x=1711973837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XNMzfamP+H3LCnyrRUavRGrklxrlpW3waKKfl5hr9w=;
        b=fDrMuJmdRUPEGLzFbiciBHQTPypnEjzv2ZcOTZ3hUy9OcK1cK33BeKHVhOy5HULVCF
         kw9sWdEkME4Ij856Z1glzfEQz4AkBW+n3BSFpTjdLdKE1M417nBnHn6qmezbau/zWI0q
         UfpO1ThWz55A8mXriSQSKyiDoue9/bcb+pBP/2XvM0VT81YdpT/qrvHBiyO8BAHIUKaf
         WGCdwyPrXtfEMzbXKMAiVoxa2ecrc38Kkl9ID+3P1nvSiiizf4r33Xqv2YG9USUTIQ2j
         +gK6p2MP1/nVKV1nZBoE3Rm5sKarCWmWxL3Es9RlSSd4ZX+ACIKQNogGZnsSdN0NZe2b
         pT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711369037; x=1711973837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XNMzfamP+H3LCnyrRUavRGrklxrlpW3waKKfl5hr9w=;
        b=CLNSGqnkWz6/oBLPU4WsOw81RhnprGm7CmTgp7Kfmn4za3pd5i9BWVx31Yl7cclAfR
         WtJ6kc6SH0AqZHIavGuciPwaZB1Vr66oeN1qmSDB608h8M74ILj6Ahvzm12eaoKtr3iF
         LYN50t7CunjsLm57zdsVGogdkhqnPGwePCfLSn/jNVRL+QDMVePaE0cdwbCEC8mj7ZLk
         k4JSnK6EfWreCzb9i5e9a99E3/7FGyuu+JWYhyk46KkyxCLODZweRpWW3M/t1ubAEw7A
         fQuUAqorRTDSX6tl3Y1KJR8/s4xug0a13PuTUA+mLqQ3Y29az0V0OI/yzYcSyVHLRZV3
         z0hA==
X-Forwarded-Encrypted: i=1; AJvYcCUlgqT6PN0AmvRnjnO2yXXalI896cNvkMDF8T2Ai+YT2G+2WCKtlLtmxxoi1v7FbZYbMHlo15ScUi8sw6HjDBtjt04/zQLq
X-Gm-Message-State: AOJu0Yxp3Qf322boO0HvfgHdfpvuwsvRDrQsDxXYYYNRoH3gLDDHa7j7
	32Rqxe5Qe+J6nfG5OdqLrYuEDv9nckKiQ/XZX/s0m/JuhAwND6cu3xdlLYa78SU=
X-Google-Smtp-Source: AGHT+IFjvcvbj0q8urHhbZr+7DM7kWiyFmQUvMsttEpbgjFdaQqftjW3QY3zLGnjLP7+mzs7pSPv4Q==
X-Received: by 2002:a05:6512:3282:b0:515:a8c9:6ec0 with SMTP id p2-20020a056512328200b00515a8c96ec0mr2425698lfe.36.1711369036639;
        Mon, 25 Mar 2024 05:17:16 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id t6-20020a056512208600b005158569860bsm1065871lfr.138.2024.03.25.05.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 05:17:16 -0700 (PDT)
Date: Mon, 25 Mar 2024 12:19:15 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: David Ahern <dsahern@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
	Rumen Telbizov <rumen.telbizov@menlosecurity.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 1/2] bpf: add support for passing mark with
 bpf_fib_lookup
Message-ID: <ZgFrwxs4mUipq83e@zh-lab-node-5>
References: <20240322140244.50971-1-aspsk@isovalent.com>
 <20240322140244.50971-2-aspsk@isovalent.com>
 <6879f076-ff73-496c-84be-a18b639f94f0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6879f076-ff73-496c-84be-a18b639f94f0@kernel.org>

On Sun, Mar 24, 2024 at 11:38:44AM -0600, David Ahern wrote:
> On 3/22/24 8:02 AM, Anton Protopopov wrote:
> > Extend the bpf_fib_lookup() helper by making it to utilize mark if
> > the BPF_FIB_LOOKUP_MARK flag is set. In order to pass the mark the
> > four bytes of struct bpf_fib_lookup are used, shared with the
> > output-only smac/dmac fields.
> > 
> > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> > ---
> >  include/uapi/linux/bpf.h       | 20 ++++++++++++++++++--
> >  net/core/filter.c              | 12 +++++++++---
> >  tools/include/uapi/linux/bpf.h | 20 ++++++++++++++++++--
> >  3 files changed, 45 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 9585f5345353..96d57e483133 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -3394,6 +3394,10 @@ union bpf_attr {
> >   *			for the nexthop. If the src addr cannot be derived,
> >   *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned. In this
> >   *			case, *params*->dmac and *params*->smac are not set either.
> > + *		**BPF_FIB_LOOKUP_MARK**
> > + *			Use the mark present in *params*->mark for the fib lookup.
> > + *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
> > + *			as it only has meaning for full lookups.
> >   *
> >   *		*ctx* is either **struct xdp_md** for XDP programs or
> >   *		**struct sk_buff** tc cls_act programs.
> > @@ -7120,6 +7124,7 @@ enum {
> >  	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
> >  	BPF_FIB_LOOKUP_TBID    = (1U << 3),
> >  	BPF_FIB_LOOKUP_SRC     = (1U << 4),
> > +	BPF_FIB_LOOKUP_MARK    = (1U << 5),
> >  };
> >  
> >  enum {
> > @@ -7197,8 +7202,19 @@ struct bpf_fib_lookup {
> >  		__u32	tbid;
> >  	};
> >  
> > -	__u8	smac[6];     /* ETH_ALEN */
> > -	__u8	dmac[6];     /* ETH_ALEN */
> > +	union {
> > +		/* input */
> > +		struct {
> > +			__u32	mark;   /* policy routing */
> > +			/* 2 4-byte holes for input */
> > +		};
> > +
> > +		/* output: source and dest mac */
> > +		struct {
> > +			__u8	smac[6];	/* ETH_ALEN */
> > +			__u8	dmac[6];	/* ETH_ALEN */
> > +		};
> > +	};
> >  };
> >  
> >  struct bpf_redir_neigh {
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 0c66e4a3fc5b..1205dd777dc2 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5884,7 +5884,10 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
> >  
> >  		err = fib_table_lookup(tb, &fl4, &res, FIB_LOOKUP_NOREF);
> >  	} else {
> > -		fl4.flowi4_mark = 0;
> > +		if (flags & BPF_FIB_LOOKUP_MARK)
> > +			fl4.flowi4_mark = params->mark;
> > +		else
> > +			fl4.flowi4_mark = 0;
> >  		fl4.flowi4_secid = 0;
> >  		fl4.flowi4_tun_key.tun_id = 0;
> >  		fl4.flowi4_uid = sock_net_uid(net, NULL);
> > @@ -6027,7 +6030,10 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
> >  		err = ipv6_stub->fib6_table_lookup(net, tb, oif, &fl6, &res,
> >  						   strict);
> >  	} else {
> > -		fl6.flowi6_mark = 0;
> > +		if (flags & BPF_FIB_LOOKUP_MARK)
> > +			fl6.flowi6_mark = params->mark;
> > +		else
> > +			fl6.flowi6_mark = 0;
> >  		fl6.flowi6_secid = 0;
> >  		fl6.flowi6_tun_key.tun_id = 0;
> >  		fl6.flowi6_uid = sock_net_uid(net, NULL);
> > @@ -6105,7 +6111,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
> >  
> >  #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
> >  			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
> > -			     BPF_FIB_LOOKUP_SRC)
> > +			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK)
> >  
> >  BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
> >  	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index bf80b614c4db..4c9b5bfbd9c6 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -3393,6 +3393,10 @@ union bpf_attr {
> >   *			for the nexthop. If the src addr cannot be derived,
> >   *			**BPF_FIB_LKUP_RET_NO_SRC_ADDR** is returned. In this
> >   *			case, *params*->dmac and *params*->smac are not set either.
> > + *		**BPF_FIB_LOOKUP_MARK**
> > + *			Use the mark present in *params*->mark for the fib lookup.
> > + *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
> > + *			as it only has meaning for full lookups.
> >   *
> >   *		*ctx* is either **struct xdp_md** for XDP programs or
> >   *		**struct sk_buff** tc cls_act programs.
> > @@ -7119,6 +7123,7 @@ enum {
> >  	BPF_FIB_LOOKUP_SKIP_NEIGH = (1U << 2),
> >  	BPF_FIB_LOOKUP_TBID    = (1U << 3),
> >  	BPF_FIB_LOOKUP_SRC     = (1U << 4),
> > +	BPF_FIB_LOOKUP_MARK    = (1U << 5),
> >  };
> >  
> >  enum {
> > @@ -7196,8 +7201,19 @@ struct bpf_fib_lookup {
> >  		__u32	tbid;
> >  	};
> >  
> > -	__u8	smac[6];     /* ETH_ALEN */
> > -	__u8	dmac[6];     /* ETH_ALEN */
> > +	union {
> > +		/* input */
> > +		struct {
> > +			__u32	mark;   /* policy routing */
> > +			/* 2 4-byte holes for input */
> > +		};
> > +
> > +		/* output: source and dest mac */
> > +		struct {
> > +			__u8	smac[6];	/* ETH_ALEN */
> > +			__u8	dmac[6];	/* ETH_ALEN */
> > +		};
> > +	};
> >  };
> >  
> >  struct bpf_redir_neigh {
> 
> It would be good to add
> 
> static_assert(sizeof(struct bpf_fib_lookup) == 64, "bpf_fib_lookup size
> check");
> 
> to ensure this struct never exceeds a cacheline.

Thanks, added: https://github.com/aspsk/bpf-next/commit/7cd3685e52d5

> 
> The patch itself looks good to me:
> 
> Reviewed-by: David Ahern <dsahern@kernel.org>

Thanks!


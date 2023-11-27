Return-Path: <netdev+bounces-51389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE1E7FA7E5
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 18:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C606A2817DB
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8E7374F3;
	Mon, 27 Nov 2023 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awaaRXCG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5D585
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 09:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701105972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5sgz+dPrJi2LbCPoMbhu83f8xz9BMuNKJzwPx7gRdYY=;
	b=awaaRXCGxPGi3eTcxsTPces9pw4WRuhP4Lvxsmo0nYUUHlEutwQ8QKjZE1QtgGJmVaMttP
	9J/k1R/EE0LbpkwZ6ZUbN5EjUfLiuV5eC7acmSGs/F98Obwm7EYqK1fe18+GlXDl+hDSeR
	Wc3OsbsPUZko55OtfuFVaa7AnD8wkpo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-ccEiIUBDMbyYM7AMMV9r8w-1; Mon, 27 Nov 2023 12:26:10 -0500
X-MC-Unique: ccEiIUBDMbyYM7AMMV9r8w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332f91f43d0so1522762f8f.1
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 09:26:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701105969; x=1701710769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sgz+dPrJi2LbCPoMbhu83f8xz9BMuNKJzwPx7gRdYY=;
        b=bz3iHH4O3uhRfLddmb2F0hUBPmmq/OdXIiJ5nA4haUnTT2v0DZ6MTSIzAdhvbJiAbF
         FPGETUr4WMB8CfD0OkVMDYCRKcU09f4BOATK6l8qCfJBuQuZC7UMauFm+XXxq4iTViGZ
         Jv0thwEaXAydUigEoBCsGpvORx98uT60BDT17/wrD3PLSop9UJ7SOEK/hd8yjiw+hvxK
         T9BwCuJlAkCiQ3aSkJKzjJgESxDyBQf9cAzym/d2zS7ki5egYQZqTuUIdo5kA4b7Ecpb
         ffc99ygpHKBLZ4vSX7qrU3ByTL/U2MRU0Rhz1dT6RVarWVHLMHGdPKC3YIhleIV1GoRi
         +JUg==
X-Gm-Message-State: AOJu0YwsfoPzN0oLJ0rFg3DZTrfSpivoXV2gfA7hkByIV9ffWz49D4PE
	tQWn5A6lHPLFbOcint676W/ZCAu/O1kr4yCNkLiQSfut0sGLO40jONE8OtB1SUkWtwzGG+N6mpv
	1GsrVrEMtB51/TggVnysz53O9
X-Received: by 2002:a5d:69cd:0:b0:332:c548:3ea4 with SMTP id s13-20020a5d69cd000000b00332c5483ea4mr9062234wrw.49.1701105968926;
        Mon, 27 Nov 2023 09:26:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZnmCDUTJctXtqa4SDUPm/VxpJZOzwn5L/8O2DiipJd/fV8ZNW3VO+ZRJwyjv1zuD0gXse+Q==
X-Received: by 2002:a5d:69cd:0:b0:332:c548:3ea4 with SMTP id s13-20020a5d69cd000000b00332c5483ea4mr9062214wrw.49.1701105968639;
        Mon, 27 Nov 2023 09:26:08 -0800 (PST)
Received: from debian (2a01cb058d23d6006a401020715c53db.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:6a40:1020:715c:53db])
        by smtp.gmail.com with ESMTPSA id f8-20020adff988000000b00332e75eae4asm10690129wrr.85.2023.11.27.09.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 09:26:08 -0800 (PST)
Date: Mon, 27 Nov 2023 18:26:05 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, mkubecek@suse.cz, netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2] tcp: Dump bound-only sockets in inet_diag.
Message-ID: <ZWTRLVuFF+575qrI@debian>
References: <bfb52b5103de808cda022e2d16bac6cf3ef747d6.1700780828.git.gnault@redhat.com>
 <20231125013942.80997-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125013942.80997-1-kuniyu@amazon.com>

On Fri, Nov 24, 2023 at 05:39:42PM -0800, Kuniyuki Iwashima wrote:
> > +			spin_lock_bh(&ibb->lock);
> > +			inet_bind_bucket_for_each(tb2, &ibb->chain) {
> > +				if (!net_eq(ib2_net(tb2), net))
> > +					continue;
> > +
> > +				sk_for_each_bound_bhash2(sk, &tb2->owners) {
> > +					struct inet_sock *inet = inet_sk(sk);
> > +
> > +					if (num < s_num)
> > +						goto next_bind;
> > +
> > +					if (sk->sk_state != TCP_CLOSE ||
> > +					    !inet->inet_num)
> > +						goto next_bind;
> > +
> > +					if (r->sdiag_family != AF_UNSPEC &&
> > +					    r->sdiag_family != sk->sk_family)
> > +						goto next_bind;
> > +
> > +					if (!inet_diag_bc_sk(bc, sk))
> > +						goto next_bind;
> > +
> > +					if (!refcount_inc_not_zero(&sk->sk_refcnt))
> > +						goto next_bind;
> 
> I guess this is copied from the ehash code below, but could
> refcount_inc_not_zero() fail for bhash2 under spin_lock_bh() ?

My understanding is that it can't fail, but I prefered to keep the test
to be on the safe side.

I can post a v3 using a plain sock_hold(), if you prefer.

> > +
> > +					num_arr[accum] = num;
> > +					sk_arr[accum] = sk;
> > +					if (++accum == SKARR_SZ)
> > +						goto pause_bind_walk;
> > +next_bind:
> > +					num++;
> > +				}
> > +			}



Return-Path: <netdev+bounces-136081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DF09A041E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 10:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217AE281E4A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0041CBA16;
	Wed, 16 Oct 2024 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aH4Euhs+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03FA1C4A28
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067024; cv=none; b=ar7g0WIcdRhgH3OGFPDDPwSweqVcs5HW9CxDuzpk3vlcUpzL+IS2kwLW1m9MKYYk4hcFw1k5HucckMXF10p3sLvyrVs+oAr7/KsDqY+Qr0hC7uXJha0vBJYFR6nMpnnOwbg1v9ZcmuVIQkdfxmEkIphQB1PKoOOduupj07e5wpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067024; c=relaxed/simple;
	bh=4dGE/PKnvNd9BZ62hRwhmNRs+VwRHQzn0prnZeTP7l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeXkY1/ig+6VOXzY7vlu5chwtDthnRHCj0ZbCJ7QxXeCiwokovoXFSBHJKgjUwHAPpvg5gphxsRSk+XFxtyW30GfuCvKsvqjcSRvypVp8h3d+6DkBwnOpFD4H/R4Hazn11BdO6iIdezEYIgzHO8ETDYNppzotl7Ay1s/obfdUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aH4Euhs+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729067021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEsxxEQOcdbMKQHiKLo+mdA07kLotpEkIp3Sd06HSzk=;
	b=aH4Euhs+cPTYVqTHoCWFgROX50qwIu7z8fSoU5FAoEYE6U1ZCQB3XV3qdqtw61hEoVFc7S
	zCNL1DL1kT0N6J0mTHF04zPdGnUOpwAlrueerjhkiq93Fa/+xihaeJuyXkKdSFpKyVu0mG
	+iCfyX/W6+4M/FS663DixaNfVRgnwQE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-1P4VCzFFOxS5bppq1CY33w-1; Wed, 16 Oct 2024 04:23:39 -0400
X-MC-Unique: 1P4VCzFFOxS5bppq1CY33w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43057c9b32bso40725365e9.0
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067019; x=1729671819;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEsxxEQOcdbMKQHiKLo+mdA07kLotpEkIp3Sd06HSzk=;
        b=SQYmU41yPSbrKPi7xER5626B4sVACCmYcEUGVIRk3uwf/401gSXYhA32s1IMIge870
         ZZ4KKNfConLC+ZnqZOoG3wCym48DM1f5k/D0dnbe78acd9TsdTrbfXi60nbOaQoYc1dm
         QVD9GYa42G9V1hn5WykGUhATTurGupmNoZfUDYNrqdErcBh83UZdBuJuW64XWFQ/r3tK
         6tkY7NWeVdz5oXcQgLJhjGTqqucOapNdX+n3ymyCNVbLYmG1ulhllFyG5mpsrZqguY/o
         MtpmHaJ7luqjGEAa5FJGFSeqtY8LHvZNgd+UntNiGagctSfx5n9l9YuFiNWQyesMMoIU
         7yYg==
X-Forwarded-Encrypted: i=1; AJvYcCVpKp53vs7nyIg6+lrB/Qj+wYm3CZQ1423edVF7Th/FrxRt76ckpouvAS7AXk8r6t8s5bDMDpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyhQ+8qJFKw2XeoBLeXefC5EwEgHVH4hq6r0jaVHA7qJ3RttHb
	KVuT4tQBcwlY2gMMDIVOnZiLD0l957DlpGPpzk8/s5fRs6Mq0AK6u48vV6FsxD+I0csg2g4butc
	2x01sWshSMd1qA8Pq98EaYjyeKbmsQgxHjXAxzngLC0A+Qjn5KwfEEA==
X-Received: by 2002:a5d:5265:0:b0:37d:5299:c406 with SMTP id ffacd0b85a97d-37d86d4feedmr2007416f8f.38.1729067018705;
        Wed, 16 Oct 2024 01:23:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs64bGGaS3ynkjoPFnFeZQ9jS4icfu+KNi1CJWZP2VZWmRmUZElAd7wqKyTb9Ggpy91H4IPA==
X-Received: by 2002:a5d:5265:0:b0:37d:5299:c406 with SMTP id ffacd0b85a97d-37d86d4feedmr2007378f8f.38.1729067017680;
        Wed, 16 Oct 2024 01:23:37 -0700 (PDT)
Received: from debian (2a01cb058d23d600ed3260535fdcfb7e.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:ed32:6053:5fdc:fb7e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7faa4085sm3695346f8f.65.2024.10.16.01.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 01:23:37 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:23:35 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next 3/6] xfrm: Convert xfrm_dst_lookup() to dscp_t.
Message-ID: <Zw94B4DMmprR4M1J@debian>
References: <cover.1728982714.git.gnault@redhat.com>
 <4c397061eb9f054cdcc3f5e60716b77c6b7912ad.1728982714.git.gnault@redhat.com>
 <CAHsH6GuCd4K_cWzc4LF3YkXACcY3GAVN4ZT_hLsHk0r=B+t8zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsH6GuCd4K_cWzc4LF3YkXACcY3GAVN4ZT_hLsHk0r=B+t8zQ@mail.gmail.com>

On Tue, Oct 15, 2024 at 04:48:57AM -0700, Eyal Birger wrote:
> On Tue, Oct 15, 2024 at 2:14 AM Guillaume Nault <gnault@redhat.com> wrote:
> >
> > Pass a dscp_t variable to xfrm_dst_lookup(), instead of an int, to
> > prevent accidental setting of ECN bits in ->flowi4_tos.
> >
> > Only xfrm_bundle_create() actually calls xfrm_dst_lookup(). Since it
> > already has a dscp_t variable to pass as parameter, we only need to
> > remove the inet_dscp_to_dsfield() conversion.
> >
> > Signed-off-by: Guillaume Nault <gnault@redhat.com>
> > ---
> >  net/xfrm/xfrm_policy.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
> > index c6ea3ca69e95..6e30b110accf 100644
> > --- a/net/xfrm/xfrm_policy.c
> > +++ b/net/xfrm/xfrm_policy.c
> > @@ -291,7 +291,7 @@ struct dst_entry *__xfrm_dst_lookup(struct net *net, int tos, int oif,
> >  EXPORT_SYMBOL(__xfrm_dst_lookup);
> >
> >  static inline struct dst_entry *xfrm_dst_lookup(struct xfrm_state *x,
> > -                                               int tos, int oif,
> > +                                               dscp_t dscp, int oif,
> 
> 
> FWIW this looks like it's going to conflict with a commit currently in
> the ipsec tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git/commit/?id=e509996b16728e37d5a909a5c63c1bd64f23b306

Indeed. I'll send v2 once the ipsec tree will be merged.
Thanks!

> Eyal.
> 



Return-Path: <netdev+bounces-94007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAF18BDEBF
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1641C221A5
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 09:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F631509BE;
	Tue,  7 May 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHwir4OW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BFC1509AF
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074748; cv=none; b=p9+wlDNCko1lqFijtAwVuyGKf4U4uHJRuLhSI3orfzxC06h6JeAY/nQL6aNOzd52CSY61ZZ/z5gkeFmcCgooQpbrtPSF+QV/apDoyuUFs9ASYT0SvjOICmormOco+mBggjdDOuzv7UMqlSo2inE7zvJIjUQO6CAuWas+GxyTh5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074748; c=relaxed/simple;
	bh=UbrhQk3lFv/cVpiLncndgkL/SFSp+j4ozN4TxmDYB2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8ro5ObV+4e9fhtfySfgaM8Qm41aLZgjl7gzT+G0KySqqQoKvV9h+ii7vEZJRME8dJ3Cl7hSX1x9noK/uZn/aWskTF1mOE4JWSjKf21Uy4I5MKN8qYGXumNpKYWrX198+q2IAQeFi89mAS2/aVPg9tRTMi2Xx6vpCMVIjobtFL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHwir4OW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f45f1179c3so2029410b3a.3
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 02:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074746; x=1715679546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUXQ3oL5kIRHQBIJ6ce1aaMGennAXmfFLs/CWASyQxk=;
        b=YHwir4OWDg2T6FVBFzy++H/e+tMc9eLZ9+H9e82jne4NxlnSsBW5D6XXBAbDNwjrGL
         pr42SaGalbAO6zY+nupGi9XdqySCTlsqwZWRKA0KRsCnYpYGp4RomZ5rfkMFLm32TntI
         O8KBDYKvYQLswHQw3AxBHEJob/8KS8syoUAwYOnKwKbKkw0+eWF3uy9l7CesSSh6UmyP
         QJC6OyeyeZWTxGDcK2VigTpfRN/lt+9lDqQrgfLhXoGHoQ791hsNUxvN9znJfXwMVgZd
         Lv8IKFIqDvVQjA9/A4+hig+MwwA9ul5jasciiBZv+0d+R7uT9pSCnEtU/olFou6Dryox
         5ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074746; x=1715679546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUXQ3oL5kIRHQBIJ6ce1aaMGennAXmfFLs/CWASyQxk=;
        b=o3I9vWauL6AE3rxEb2Fx/eEBrhMcoVT98ykslLaqe9kBE79u5WnSBEt02N2zEq7ErT
         bfjSVVXQWBJy2Lr1fdcl7Ye2vbTZDZ4R9CFJWHclSBi8XnsBZY8XUZg4wxaP5HuBs1Pn
         a5iFB9vy6PVpqwEY3rxnIgd1YXoK68y3+u7bfwG0vhoCTXs/SlZxP6xx71HtmiwrHM6L
         qsL2g/RFKlIJ0NhnTAgZ0Cpow1GyRIaQT0FnITnQLqdpIN/uPzPfV+Xe84bvmY2vxD0u
         4rMYJc0hkUGLAeuxsHprDQnZNnAFyk8OuIdvPUa3WvHnnUPSPh+uCj1veMjLdNZgeYmp
         I+eA==
X-Gm-Message-State: AOJu0YyBC6i+kjayEfb/n9XZwfpcD+JhqszJyqyX0PBrSbbH1QNO4lm3
	BjSONiJtnkN5+gYgxcPVbg+rnBH1pdwRlaTcWsqoC1vwfRIb9qal
X-Google-Smtp-Source: AGHT+IHKGduNPvro78UHNxf4yB7bOgZ8JVOdGSHhXtT45H5qi931E3eALF8EbCAVD/YKi7Y6vIpz9Q==
X-Received: by 2002:a05:6a20:daa1:b0:1ad:999b:de47 with SMTP id iy33-20020a056a20daa100b001ad999bde47mr13013403pzb.51.1715074745901;
        Tue, 07 May 2024 02:39:05 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902ed5300b001ecacdd23a7sm9630608plb.281.2024.05.07.02.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:39:05 -0700 (PDT)
Date: Tue, 7 May 2024 17:39:00 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCH net] ipv6: sr: fix invalid unregister error path
Message-ID: <Zjn2tNTJF-sq1Aoe@Laptop-X1>
References: <20240507081100.363677-1-liuhangbin@gmail.com>
 <ZjnxBVJDNkyGgNE6@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjnxBVJDNkyGgNE6@hog>

On Tue, May 07, 2024 at 11:14:45AM +0200, Sabrina Dubroca wrote:
> 2024-05-07, 16:11:00 +0800, Hangbin Liu wrote:
> > The error path of seg6_init() is wrong in case CONFIG_IPV6_SEG6_LWTUNNEL
> > is not defined. In that case if seg6_hmac_init() fails, the
> > genl_unregister_family() isn't called.
> > 
> > At the same time, add seg6_local_exit() and fix the genl unregister order
> > in seg6_exit().
> > 
> > Fixes: 5559cea2d5aa ("ipv6: sr: fix possible use-after-free and null-ptr-deref")
> > Reported-by: Guillaume Nault <gnault@redhat.com>
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> >  net/ipv6/seg6.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> > index 35508abd76f4..3c5ccc52d0e1 100644
> > --- a/net/ipv6/seg6.c
> > +++ b/net/ipv6/seg6.c
> > @@ -549,10 +549,8 @@ int __init seg6_init(void)
> >  	seg6_iptunnel_exit();
> >  #endif
> >  #endif
> > -#ifdef CONFIG_IPV6_SEG6_LWTUNNEL
> >  out_unregister_genl:
> >  	genl_unregister_family(&seg6_genl_family);
> 
> That label will be defined but unused for !CONFIG_IPV6_SEG6_LWTUNNEL.

Ah, yes, I will add the CONFIG_IPV6_SEG6_LWTUNNEL definition in v2.

diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 3c5ccc52d0e1..6a80d93399ce 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -549,7 +549,9 @@ int __init seg6_init(void)
        seg6_iptunnel_exit();
 #endif
 #endif
+#ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 out_unregister_genl:
+#endif
        genl_unregister_family(&seg6_genl_family);
 out_unregister_pernet:
        unregister_pernet_subsys(&ip6_segments_ops);

Thanks
Hangbin


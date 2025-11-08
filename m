Return-Path: <netdev+bounces-237008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D74C431FC
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 18:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3753A89E2
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 17:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3C826A1CF;
	Sat,  8 Nov 2025 17:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xz7PhYlN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08135267F58
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762623013; cv=none; b=it4t/nTjDwf4hi5RBdkS0a2jbPRh7+OqqmUBxmSG0GfRCBemtKAItpBwslY0Synzmbc8WCcFL9yQbFNFUAo1qfGzS9PuEoq3VEMHDFTcwElCdpqbEyCUoCVl40wgJualkzNnq7QCXd/l+ySO+lmrNWsh/PbkrSU6hjqMXglvwDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762623013; c=relaxed/simple;
	bh=mqvOz/c5PMEmaEMrlMTr9mIFRYBwkDh40KxWBaUTkP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F22BiPHq9qzllkbP/YhgPOhAPOwVxCHUDxN2vWM7xh8Nny/Bb1fqie+YDqpQN5ah9rXFYJ70H2P74E+ihKKg4bmWMXdjYCQ5Hlmj+ejiMs6R7J6tg8EcezukkvZJjXbjxlFiRl8oxejt8rga3NXHtEfnrbtPii25IOBo8JCfMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xz7PhYlN; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29599f08202so21599715ad.3
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 09:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762623010; x=1763227810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksh9yCu4UesSZktaqp077/wo5kGK4/tiGrzTuoLqT7M=;
        b=Xz7PhYlN7QTrZUnk7vH9yXuvdg9pHlnstZrtSYCJ4rBT6tpcyp3w01cJ/sPGTP5nwS
         2mYMqN6cRkR1XTdbATmjJ5bRrcRPIVZtAHX4tfrXYVtmRiX9xSWj0gYvaQasTc7dfCw1
         g4mmHseOONvyXw+6NJ9ofaiTrvFPoaSG4RnPQqGrmslUEcFB6Ojgz34engdIkjWdgLVo
         UduqA2rm6968FfzKoeExcrYtoQKVakkccjkE3V8//OfNw7iv66nZ8Iipk0yGy0CJZQmC
         9XvLvKVRdH9n/93wifslMqka4cGgKRrTvrJINn+r9jMPhJsPlyE6ga51lGyt5aVHWmu/
         zhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762623010; x=1763227810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ksh9yCu4UesSZktaqp077/wo5kGK4/tiGrzTuoLqT7M=;
        b=sccYQPx2UzC6G+6AaQxHiRmWzJv3nwgK+UlW8yL7g6dKl/H+cI1EUqfoLVhlrQt7U2
         2GPPcZcve02VSj4mH5MERMU5rnjLV5LMc8tuDGTb87Fx1NuPU7fF1/GVzjqpFXeoleZZ
         PBirxQ52MDeVuzU5+G2pU39SnJCLzxduzbMulPExvOnRloYiqDVFkN68pGuq/44Uvruw
         rSiiV932KVXGgXLEoPnU5DZRf5p8PGfRkUBgpCIK8L3syI2+W3wEKkwBWkdHZWAw8mMd
         WJRq1e8Cxq+7GRXLVSy1cBjiySwvp1aqqgXXJfhPa/jU2sWn98AFrlYkF3oSYEjVD6rg
         IDwg==
X-Forwarded-Encrypted: i=1; AJvYcCVtQ1RNjMV0XW+9PYa4HtSAp2AnDGQSIuoD3BjSJiIm459K5eHS2Ol3VUjK3QnZwiupF32afgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykIc7NbjQyvZ6JEWuriDsdezcqKokd6NvFMKYRICtB+6Ymd/EF
	g+2De/rmvfyiHCMc1zCP9d/sWKrGXLGOtrv5T7tNo+NsXUST3ZQH3/6kwhi1FznJ
X-Gm-Gg: ASbGncvrUX73KiUx05Qdf6vYk8LzZEEHNdQzD/Ikr5M//RlFtND+Fn2uu6P5v/51gm3
	BWxnuzhF/8u+CkSbe3qv3lax/7MdmMgpR5p5Vjz81t/ZMondbbzxmMDSzic2GRAETDFn5oOsF0T
	xC8+O4Qq0FtIBTaSZ1+sYBxDTywdd7rO9KdI5uTTAB0VlCEo+sNW6GEqgOdLaD7mcPq+LOMbpmo
	5yGXr/grgGubNBFww1gxTa71NbOiCWWa+aW1YHx/LfIl2pd5/NoJQ01nzJcQDwAe3EaI5eATJAG
	OlJpIhg9f6elqiBTNTnMqiTY/wU/UBK+BrgORNochBt6XgMhcr9I36PrBCYlDBSYxfjp9hzpp2w
	JqAVc9Ek39OgRQVcjKGc/G8bQi/XNcpDuYaBRoE3e665aeHRgg8dlrFG2urMTOIOa40cX1eJ8Ch
	fsXwrAKwh7afUZe8XG8co=
X-Google-Smtp-Source: AGHT+IFLUU/VWag8EJzSY/0xYAOHUmVtlabS8D9NAS2JD/HU1e2hrzCK0vE/MQxp1herrE49UHd/uA==
X-Received: by 2002:a17:902:e848:b0:296:3f23:b939 with SMTP id d9443c01a7336-297e56ce0b1mr51308795ad.42.1762623010252;
        Sat, 08 Nov 2025 09:30:10 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5c72esm93914635ad.33.2025.11.08.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 09:30:09 -0800 (PST)
Date: Sat, 8 Nov 2025 22:59:59 +0530
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Xing <kernelxing@tencent.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftest: net: fix variable sized type not at the end of
 struct warnings
Message-ID: <aQ9-F34aW__rlMuD@fedora>
References: <20251027050856.30270-1-ankitkhushwaha.linux@gmail.com>
 <aQD8AOZduY4Fit3k@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQD8AOZduY4Fit3k@horms.kernel.org>

On Tue, Oct 28, 2025 at 05:23:12PM +0000, Simon Horman wrote:
> On Mon, Oct 27, 2025 at 10:38:56AM +0530, Ankit Khushwaha wrote:
> > Some network selftests defined variable-sized types defined at the end of
> > struct causing -Wgnu-variable-sized-type-not-at-end warning.
> > 
> > warning:
> > timestamping.c:285:18: warning: field 'cm' with variable sized type 
> > 'struct cmsghdr' not at the end of a struct or class is a GNU 
> > extension [-Wgnu-variable-sized-type-not-at-end]
> >   285 |                 struct cmsghdr cm;
> >       |                                ^
> > 
> > ipsec.c:835:5: warning: field 'u' with variable sized type 'union 
> > (unnamed union at ipsec.c:831:3)' not at the end of a struct or class 
> > is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
> >   835 |                 } u;
> >       |                   ^
> > 
> > This patch move these field at the end of struct to fix these warnings.
> > 
> > Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
> 
> Hi Ankit,
> 
> I don't believe this change is correct.
> 
> I think that the intention of the code is the char arrays (buf and control)
> provide the buffer space for the variable-length trailing field
> of the preceding structure. Where we basically have a header followed
> by data. But your patch would place the before the header.
>
Hi Simon,
So if buf and control providing the buffer space, then i think it is
better to suppress `-Wgnu-variable-sized-type-not-at-end` warning 
within this block of code.

	#pragma GCC diagnostic push
	#pragma GCC diagnostic ignored "-Wgnu-variable-sized-type-not-at-end"

	struct {
		union {
			struct xfrm_algo        alg;
			struct xfrm_algo_aead   aead;
			struct xfrm_algo_auth   auth;
		} u;
		char buf[XFRM_ALGO_KEY_BUF_SIZE];
	} alg = {};

	#pragma GCC diagnostic pop

I think this would be fine.

Thanks
-- Ankit


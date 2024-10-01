Return-Path: <netdev+bounces-131015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F89E98C622
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95C8AB21D6D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 19:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859BA1CDA19;
	Tue,  1 Oct 2024 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYE2w+GN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4571CDA16;
	Tue,  1 Oct 2024 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811350; cv=none; b=gQyoEkf0cN0zgH3EKncVyqxPODWtFvtqaJqvebUUUyNxqBfD/b65nG5/RnELOWP9iuZI5m4g2ix10KZxn8WCKnqKVHTgt+pGzpu/+sLy32RK3ptJ/+RKpdWQxhR+yqvJ3iMGY9XvTLSPOiYjFGc1CDdiDG98bFnT5unf7APppV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811350; c=relaxed/simple;
	bh=x9J72+X6RbGpK0Ne6szZE/mdMKFE9BPb4/G7X5kR1fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZVuUMsiNkFT2z683tge8pUdPeI4n2z7EWuFYRMYxG5UsQe/Rxl+pSf7I0C5Fk7oH08EOXJcpX///bYzg/FjgCx5O0X8z2d03Drq8r8Q4FyN8p9w+Dyo1ad2G1FLL0OuHQKHyROPP05+Is0QqzjaY0Mkz501bUyon5hMefsOtdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYE2w+GN; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e22f10cc11so47123717b3.1;
        Tue, 01 Oct 2024 12:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727811348; x=1728416148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBLj6ECKGkCfzMGPZ8xR8xxTPPECGbgqTbKg7ceMZog=;
        b=eYE2w+GNDjxe+BKg4XIjnfB8qwh8KliZd22LBZCJueApZ8eG+NmSY4Lv2WC7Qn3axv
         7LxK10xSgQx+JgsvsEoPVelxciX274hiMYarzpHxlvC24dmhFNFc4/TOiZ5xASGEymOD
         5JTr80TKI9IiDzRNLAf8ZEvEKCfF0WsY/alqQ5wBpc6AhBC8IJp5LfIV37kHcVLCYU9o
         /s6RTaqWkK31e3CVqlZw/ybBZ8aL1Vo6jl62tx6bTIOMEgXzPrX2Do+njkACFwEiXDzm
         e1e5mAwS4Tgk/tu2uZJJ9SIG4xAJptVWq5wOYe4YBmBZZDgNgRTomklfvm9Po+lKTWBN
         Wp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727811348; x=1728416148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBLj6ECKGkCfzMGPZ8xR8xxTPPECGbgqTbKg7ceMZog=;
        b=FUShIbl9nb7TRO4Gilj6YcNkqqsxLgIW0jVyROoSBTJaRbvFIBnSrkv/SHhsKdv5++
         OsrwDgJuc7HVxYFz5RtBlhZ862OKoHVAanJ1CNgjIM2hnm4XyDSirPTw/akLyNlQrO2e
         EQ0022q0bnDP0O0JRO1g7lvHC8oHe77MBhEfxx1+9kroGHE+GFpSGUPJr4F432QQiXvL
         WSM4VFVW22R3ivy+yJyt027qCro2m1951DZ3nXeicZ6UlJX0AFyjSNSpZOpuAit77Blk
         rdgf79fV1XyVGNEt08dF/PWo5fXR1GpZECl4ge8GI2caBlu8c/488eziENBZNBamo191
         aL6w==
X-Forwarded-Encrypted: i=1; AJvYcCWXGyG7rYxerXsP4rfOP0qCG9zv4q6P+/0EBcARq6SbWBslCVfGmgJ8dpM7ZNUE3jL83x3FiA8Q@vger.kernel.org, AJvYcCWul2B/Dk7Qi69KXTtexecx7aSj2bLTVZtNDq6YTMWiUvAYtAiUL93y9moXwriXyhHhw4fOoMDzw2wkkEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+H45mAwEQ/Qklj9LCgYRibXN4+iV4lCoGlbguW1YFALWdahd
	OQY5bGEXnajFi7QPKnZFYaqJmK+nK2YZSCoarFp0u9jmhduMxARlxpQO4NxUNuzwR+jh5VFUkrt
	wo/LdZurIOXXURJwuqM3loLxukdM=
X-Google-Smtp-Source: AGHT+IFt6ebOZXlFPwAUz87Ey07oOJrSi9nZ/86w4eb7im14Km6lgJ/qaXMMZ+KlopjGrvcKTPnMCXjquF6OdIKZKuY=
X-Received: by 2002:a05:690c:386:b0:6db:c69d:e30d with SMTP id
 00721157ae682-6e2a2b55289mr10862017b3.20.1727811347706; Tue, 01 Oct 2024
 12:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930180036.87598-10-rosenp@gmail.com> <202410011636.QtBtiUKi-lkp@intel.com>
 <20241001132523.GQ1310185@kernel.org>
In-Reply-To: <20241001132523.GQ1310185@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 1 Oct 2024 12:35:36 -0700
Message-ID: <CAKxU2N_nBmrn__AEhOYpVaQzQBcW_1=4uwcFoYnap7UbkvdpPg@mail.gmail.com>
Subject: Re: [PATCH net-next 09/13] net: ibm: emac: rgmii: devm_platform_get_resource
To: Simon Horman <horms@kernel.org>
Cc: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linux-kernel@vger.kernel.org, jacob.e.keller@intel.com, 
	sd@queasysnail.net, chunkeey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:25=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Tue, Oct 01, 2024 at 04:24:39PM +0800, kernel test robot wrote:
> > Hi Rosen,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on net-next/main]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-=
ibm-emac-remove-custom-init-exit-functions/20241001-020553
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20240930180036.87598-10-rosenp=
%40gmail.com
> > patch subject: [PATCH net-next 09/13] net: ibm: emac: rgmii: devm_platf=
orm_get_resource
> > config: powerpc-fsp2_defconfig (https://download.01.org/0day-ci/archive=
/20241001/202410011636.QtBtiUKi-lkp@intel.com/config)
> > compiler: powerpc-linux-gcc (GCC) 14.1.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20241001/202410011636.QtBtiUKi-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202410011636.QtBtiUKi-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/net/ethernet/ibm/emac/rgmii.c: In function 'rgmii_probe':
> > >> drivers/net/ethernet/ibm/emac/rgmii.c:229:21: error: implicit declar=
ation of function 'devm_platform_get_resource'; did you mean 'platform_get_=
resource'? [-Wimplicit-function-declaration]
> >      229 |         dev->base =3D devm_platform_get_resource(ofdev, 0);
> >          |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >          |                     platform_get_resource
>
> Hi Rosen,
>
> I'm curious to know where devm_platform_get_resource comes from.
Lovely typo.
>
> In any case, it would need to be present in net-next, when patches that u=
se
> it are posted, for use of it to be accepted there.


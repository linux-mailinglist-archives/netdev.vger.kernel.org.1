Return-Path: <netdev+bounces-120114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8291958568
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC371F21D88
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FBA18DF87;
	Tue, 20 Aug 2024 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkItoHkz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CEE18DF80;
	Tue, 20 Aug 2024 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152039; cv=none; b=A0yafDc+ZRV73nBjGvgyscGB/5YOXkCMiG022F9MocGGw0EtkIXrQaa8vE7Af3Y0mT5aI8C9bwLbcDJxKPx/PsUAWibv3EZ5i8gA1AcBsONKHBQ2pPh6kMZb91D0AjWddTEkz6fSvuQYVpPTiDDWnADUpYWuMi1y0YQvJnSikoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152039; c=relaxed/simple;
	bh=pdKZ+poCDkyUjHKhQ7eA6CHjDwZhCYhrJj7O4fe6Vnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQCrMi6ddasZydxY2aFxROlwHfqW1zrBLJx+WiYB1eACiSDUZnnMnXahf3pLtnKkzpKdFAqpEuzd+Po8dhjuT/MjJPsT+cmUZnz2ReMOHlGojwPwls6nYZTbGMleuedvP19aULm20ml1VEOlPOBqPbNoJxekmUo0oPBMsjhkXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkItoHkz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso58645425e9.3;
        Tue, 20 Aug 2024 04:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724152036; x=1724756836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTHIbJW4PTufCBdo0wrYwqNtwp0woxl7LZM1lU3pOT0=;
        b=SkItoHkzLRRZakZIkuL66kND4ZKNkChfGKs0DuoELjrvEXVd+QNdlxFNeochDzVo4O
         o6iJs6mznBmJoWCKVjWWKjVwauPC9avdVFsSivYX2pr23wMJ6tYNchucgc02TUqB8mtx
         xql24yIjwkRyxsbE27hJwjPRrJAOqIlCgfhkHiSr0CsbPeSo5274HC48ro87Je6qu+3Y
         wm4EjER3rdGiunjPbXc/NdkIK8xWeRcfwiOkshEyQ4zSLRdIUicYqezwR3ojwSCKcaEg
         cNvanZ0K0+T1kNUEM2x1DzNOktY2CbQ8QIpXUFmJH2XXDhPzJG218s7L8bN+OchvxBR2
         92oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724152036; x=1724756836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTHIbJW4PTufCBdo0wrYwqNtwp0woxl7LZM1lU3pOT0=;
        b=akBhk6vnjswFMRQRiXNayB05UhQYqxQBh+HHj/u0yEjvc47aRkjv6BvRd/2MPcF30B
         c/zjvssfXviOTYtAcyrGcnyqYiqR9q0mMg+Ur+4mmlYyF5eTLod/ynujHZ6roBlq/xDf
         zhPb1oxuhtvJglkcgwrIB0Ugf8rmniF8l3ezE8cy1oj09+ckPSLZlZSSsGGxduxZAuTI
         u1m9aLld6++ARBxeE1TTpOjbNlOMx+2icIxjW2Pc4QwanspQHHJQHRnkI/Uzh5G85LVD
         huEpxZtu0hzKeNz1Bf29cKZPaxfAWnKyaGMM5L2OKhGLUzIMY7iMcRUuSByr9lKGvW3r
         wX3A==
X-Forwarded-Encrypted: i=1; AJvYcCUQnV6bQLcObwlpRCZByazVGBJDu96DTylMtK/M4Hgvft5K2rTHiq1ECepDHS1ma3PbuBQpU5pk@vger.kernel.org, AJvYcCX/ro3DGXuuAw+/5In3tRANX0LjVL1e6+FCYKdH3FNmMwdQdqkjpepmyIBbRgzCqKp41U2sx38G1uPqy+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYstJlUFFaYnbrZ7p/SFU1XZ4+u/g2TvJgzr+oAYPe1Ix3ffCg
	rC65iKSlQnYz4NT62vJYLcCZakkSLEtY0NO150Humc/yiHxxq7EB8NFkkibwV57K2rgG0WUa6A1
	36LzTWv6rE7EZ1o50cEeXu6zVHbvEjm60
X-Google-Smtp-Source: AGHT+IHJJoh7ByBUVHlRrAx656Syu5KPYzB2KBb5xbYcOrfnCoWKqK79LfodYqW4nO+k2z1N/UcTBZhckIqcKe4fmbY=
X-Received: by 2002:a05:600c:45cd:b0:426:6e9a:7a1e with SMTP id
 5b1f17b1804b1-429ed7ed5c0mr101719985e9.35.1724152035123; Tue, 20 Aug 2024
 04:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819123237.490603-1-bbhushan2@marvell.com> <20240819152744.GA543198@kernel.org>
In-Reply-To: <20240819152744.GA543198@kernel.org>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Tue, 20 Aug 2024 16:37:02 +0530
Message-ID: <CAAeCc_ngtvx7LNWB2CMgfA6Vyitx8BTZbahJby+ZDgTEC5JYbA@mail.gmail.com>
Subject: Re: [net PATCH v2] octeontx2-af: Fix CPT AF register offset calculation
To: Simon Horman <horms@kernel.org>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com, 
	lcherian@marvell.com, ndabilpuram@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 8:57=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Aug 19, 2024 at 06:02:37PM +0530, Bharat Bhushan wrote:
> > Some CPT AF registers are per LF and others are global.
> > Translation of PF/VF local LF slot number to actual LF slot
> > number is required only for accessing perf LF registers.
> > CPT AF global registers access do not require any LF
> > slot number.
> >
> > Also there is no reason CPT PF/VF to know actual lf's register
> > offset.
> >
> > Fixes: bc35e28af789 ("octeontx2-af: replace cpt slot with lf id on reg =
write")
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
>
> Hi Bharat,
>
> It would be very nice to have links (to lore) to earlier version and
> descriptions of what has changed between versions here.

Hi Simon,

Will add below in next version of this patch

v3:
  - Updated patch description about what's broken without this fix
  - Added patch history

v2: https://lore.kernel.org/netdev/20240819152744.GA543198@kernel.org/T/
  - Spelling fixes in patch description

v1: https://lore.kernel.org/lkml/CAAeCc_nJtR2ryzoaXop8-bbw_0RGciZsniiUqS+NV=
Mg7dHahiQ@mail.gmail.com/T/
  - Added "net" in patch subject prefix, missed in previous patch:
    https://lore.kernel.org/lkml/20240806070239.1541623-1-bbhushan2@marvell=
.com/


Thanks
-Bharat

>
> Using b4 to manage patch submissions will help with this.
>


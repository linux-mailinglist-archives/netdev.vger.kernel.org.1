Return-Path: <netdev+bounces-76494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0671D86DF38
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 11:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38AD31C21348
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 10:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7466A8DC;
	Fri,  1 Mar 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oHVyS9RI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BACB6BB39
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709288891; cv=none; b=blmio+tJFBJBRe8zVbZh1VYONy1WHwMmgbZQ4wNimDGDhOQVGUliUooLpHOz14LoaSIpt0m4w1bo1jhPbfBc5GpAaI97LKDl+qvjiyVHhs/sQ/rvDWsLcfylhFjl7NB3Zhc+aYoIqMRjKc+GUqFgRAUuj/k2K2lj9Etqcd8CBtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709288891; c=relaxed/simple;
	bh=ZFUvqVo1lT37K+8NimNwFnn1EIPrImNJyzm+T+5iP48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H0gD+dhR5NmOZjI57WtM6jz08tkHntYN3bP5JAXV6/YyVFtPUkL6FUkr9yu8prIgN5fgNYtv64QXkKZZ1UbxOUI8WrjmkNqM2EKraYdFseXfx6OygOmYOCDMdWakVfrYIZ2/iGgRKW/exf27LDodx/4oQ3oFfzlSW+AhG+GFcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oHVyS9RI; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d33986dbc0so5301111fa.2
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 02:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709288887; x=1709893687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6I1gRYzxfTJHfTTS+4YUgGUdEjo0E1Z3WWe3oLF96Wk=;
        b=oHVyS9RIYmhXvuB1drEIOt/A36CuYQE7dYx4m2GTbFOlUjhjFyBG5VnTuKrfK0ax8g
         JTkLCuyyxrXxeSRejtUq+hBuud2zWyA434PfiO1T3U9IKX52YhHBj+wLbvM4hUgm3FoT
         BjMIJoLjZK9mGRLIUCN49sCjc91WgHK5RECKws+GqCRLanEFa72VWOmsMZF79Hc5C011
         x9hvSOifxNz+MK+tTaulCzWOB9w4jCJYlNW0taTcSkXfTr/9Ck6n6qOxCgJ0MOZaci29
         H+vNIU9FtlGntLn9aLL4O+yllRBVfhiTvcT46J1OVujSQ6JdF930DvuysORYtUnAl/uK
         Q3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709288887; x=1709893687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6I1gRYzxfTJHfTTS+4YUgGUdEjo0E1Z3WWe3oLF96Wk=;
        b=PW8LfNneGexTK5XIU/ZPEPqzp06+r3SSmva44CZfo8gzu5UgfJAiiQKqhaoADs9j1W
         naffBaprvWEEkQ6nWH90blmcuKtGV0NFTlNfmB3SpBACxe0Doqwl9JSB8MoGmpEzCHN3
         5c0mi7YoarQLSOS7dICvOX4AhWWlgQZAjwrqV3m1Aii3pobaXyx0mzWblWuAk6oslzeW
         NrNW5bqZuYIziv792GHhZdaewotUwECzOjtrT2JL5EtLVRl7wkpoBoqxlzvQ3Nk3rHBO
         IvsdcOIQy7R5+SwRaqGBZ4JhH5of/M0rcwVaBvlo+4TrDkqoBM3gtaALF3H/eMjexaH4
         NJgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCczuycCj3n4p2U58xuRoOQNVDXo7Wpa1xwRUAeSRO1FfZRbwYHwB08lso+Ys1iewZR5rmYwXiVkMAfOvOJqvBMocrzple
X-Gm-Message-State: AOJu0Yx90VAuSuV17l2dmvZcWrrvKnQGCF5nzu//fXfSIMtAb1h2nK71
	rhvb3hrfurVoC9lvHttR/mZj58+IKmzIGVZTxyAydufYOgt3BrOjgEtoq7lErxzaFaV5To4SyUa
	bEV84+cW6SQLSJi7THs5Zsyqgw6Kko6FLdZwuCg==
X-Google-Smtp-Source: AGHT+IEY2BlVnMl9VRkGSiL35s6fB9JHHMJ+cWRH3F8O9x9VZ0yWHdNXfA3aqjSKQv2NrFo8rDm/gPLU5FrRbnC8GuA=
X-Received: by 2002:a05:6512:3c9a:b0:512:d7e8:7046 with SMTP id
 h26-20020a0565123c9a00b00512d7e87046mr1111983lfv.42.1709288887550; Fri, 01
 Mar 2024 02:28:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <499bc85ca1d96ec1f7daff6b7df4350dc50e9256.1707931443.git.lorenzo@kernel.org>
 <20240214101450.25ee7e5d@kernel.org> <Zc0RIWXBnS1TXOnM@lore-desk>
In-Reply-To: <Zc0RIWXBnS1TXOnM@lore-desk>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 1 Mar 2024 12:27:31 +0200
Message-ID: <CAC_iWj+5TMe8ixXrLM3DUS+RAmDu+gmb1rfcHiU04re8phQVDA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: page_pool: make page_pool_create inline
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Lorenzo,

On Wed, 14 Feb 2024 at 21:14, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > On Wed, 14 Feb 2024 19:01:28 +0100 Lorenzo Bianconi wrote:
> > > Make page_pool_create utility routine inline a remove exported symbol.
> >
> > But why? If you add the kdoc back the LoC saved will be 1.
>
> I would remove the symbol exported since it is just a wrapper for
> page_pool_create_percpu()

I don't mind either. But the explanation above must be part of the
commit message.

Thanks
/Ilias
>
> >
> > >  include/net/page_pool/types.h |  6 +++++-
> > >  net/core/page_pool.c          | 10 ----------
> > >  2 files changed, 5 insertions(+), 11 deletions(-)
> >
> > No strong opinion, but if you want to do it please put the helper
> > in helpers.h  Let's keep the static inlines clearly separated.
>
> ack, fine to me. I put it there since we already have some inlines in
> page_pool/types.h.
>
> Regards,
> Lorenzo


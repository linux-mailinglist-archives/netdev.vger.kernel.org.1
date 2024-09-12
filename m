Return-Path: <netdev+bounces-127965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C369773C7
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 23:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A33F1F24A20
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D277C1C1AB8;
	Thu, 12 Sep 2024 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8k/o21Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD718EFDB
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177714; cv=none; b=Tn432RffwvCvz8uWgzU6wDz+Zqqt5pulwQ+3vVCG/ItcM2FQTQ1Mf6+NtVikhUIugMnx43k6lcVgZF6hRgv21D6UeCyR3kFlnB1MSSUCZhsUr48Q3pyw2p+1wRxNw6nUEvYRobuEFsT3BVAaaAarjFvLtNt1eVGYOVylWdJZDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177714; c=relaxed/simple;
	bh=ViikGuG+oVsrD60pgRvkDtQ4eabn7klDdH/VT15sUlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3X1Jc2AkG49DpOUNbdeIOnyK/VUgHulvbAQ1FzHEy7gDxqKKDagtI42n6T9TuaQQwsV9U0wt8PlHCResKd1hLYojFEgKebskTZB6yJ0hsmDq/KlKWPmwrFDabbhI3dxOmWm0QFvIl+P5ic68nJE5VPO1HKGT2FEduMbov6QzdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8k/o21Z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2059204f448so14143635ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 14:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726177712; x=1726782512; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vwFahowCPECXazaweoJXQBSgqM9W7+toDKRNpGFYldw=;
        b=h8k/o21ZaxwQ2J9oWAiSkwD2vgEQS4PoB/dVZD8dxuePpHN+MpNqzHjOwUPeZti4Cy
         mq1ExOUvi/A72Dvwuszl3UfCaIlokMjsep0A5O17ChOYbOZmzOI9w8j6sbh2yz7Zmtd2
         7F3A0gnSgLtyKUK/L2Yqk3JMMpUpjaDbZvo6UosfNuFl3W7WfH5SxKFDuo/RlODYuUOh
         VdjmVC7fSGNZwwZJp+rw/q25k+wWsYzigwDBwZgICVNhqtHUwpq07oRg8MqArROT8U5S
         a+HqfFO4blsre5UKeJB9YmpGNaZhn8CZOF2xx6Uq/q6FOqOloq0rGr5cNoLVT2dcGhzh
         RjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726177712; x=1726782512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwFahowCPECXazaweoJXQBSgqM9W7+toDKRNpGFYldw=;
        b=TvcnB3QL4gZzeJbBahhbqizcLnp41BNricEI6XTdmCNb41FhaqSd0pIdZYMBqhExKC
         wJkMJqaS8wqZAVI+7a4aOIdwIUnWqeNSqydxyVedaw1BWDNvrJyk+JeSTjm/02LQ28hM
         ppYRKOGQ1IgTLl2/ZajAAFoIvmEi6WVyWUK6mui2jvGZ4I9/AEuZthn+qTondFP4CUZ+
         c4nBiFyap9bV+46qofPBguyuccKpZtwVmJBkoYkFYrc/t3XhS4Wt66UXXzW5alVCRwEj
         h5LsYo4kNC6o2WSSN83WwPavn2vqvQFJR8mViYCMnEILIw7cwtY7UVg+7FNSc0+JL2lQ
         vTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgSadDy97wgv61Tq7h7YMZUzmXDBawQEEMyuSLpxwu6J/e+s3FCM+tLFCbY3zL4cOfex+tPRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyAmFPypTAqlj7WyFIr5Z0Do0IVRPChmhT1ZtR2FUYd/DtZGTi
	eT73wOWgk7xeCg3Uvi83H1E0pQlzeWpFNG5C7GpemdBAR+0SdPw=
X-Google-Smtp-Source: AGHT+IFAQgnSOJvtqLU8teFbX2f40L/DkyKeRvPYJLp6ZMvAwgp0oO8OhzmTOEhpdxkP/5HRTgutYA==
X-Received: by 2002:a17:903:104b:b0:205:76f3:fc2c with SMTP id d9443c01a7336-2076e3522e6mr40470125ad.16.1726177712441;
        Thu, 12 Sep 2024 14:48:32 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b00974esm18341495ad.253.2024.09.12.14.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:48:31 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:48:31 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Ziwei Xiao <ziweixiao@google.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 06/13] selftests: ncdevmem: Remove client_ip
Message-ID: <ZuNhr8I8P1joS8xr@mini-arch>
References: <20240912171251.937743-1-sdf@fomichev.me>
 <20240912171251.937743-7-sdf@fomichev.me>
 <CAHS8izNbzurO3TNFNmzdxnCeZBizaBP4KFidxV2xtDj2nuobQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNbzurO3TNFNmzdxnCeZBizaBP4KFidxV2xtDj2nuobQw@mail.gmail.com>

On 09/12, Mina Almasry wrote:
> On Thu, Sep 12, 2024 at 10:13 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > It's used only in ntuple filter, but having dst address/port should
> > be enough.
> >
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  tools/testing/selftests/net/ncdevmem.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> > index c0da2b2e077f..77f6cb166ada 100644
> > --- a/tools/testing/selftests/net/ncdevmem.c
> > +++ b/tools/testing/selftests/net/ncdevmem.c
> > @@ -62,7 +62,6 @@
> >   */
> >
> >  static char *server_ip = "192.168.1.4";
> > -static char *client_ip = "192.168.1.2";
> >  static char *port = "5201";
> >  static int start_queue = 8;
> >  static int num_queues = 8;
> > @@ -228,8 +227,8 @@ static int configure_channels(unsigned int rx, unsigned int tx)
> >
> >  static int configure_flow_steering(void)
> >  {
> > -       return run_command("sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s src-port %s dst-port %s queue %d >&2",
> > -                          ifname, client_ip, server_ip, port, port, start_queue);
> > +       return run_command("sudo ethtool -N %s flow-type tcp4 dst-ip %s dst-port %s queue %d >&2",
> > +                          ifname, server_ip, port, start_queue);
> >  }
> 
> Oh, sorry. I need 5-tuple rules here. Unfortunately GVE doesn't (yet)
> support 3 tuple rules that you're converting to here, AFAIR. Other
> drivers may also have a similar limitation.
> 
> If you would like to add support for 3-tuples rules because your
> driver needs it, that's more than fine, but I would ask that this be
> configurable via a flag, or auto-detected by ncdevmem.

Ah, cool, in this case I'll make client ip optional (will keep existing
behavior when client_ip is provided).


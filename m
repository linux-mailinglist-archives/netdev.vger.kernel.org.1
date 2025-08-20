Return-Path: <netdev+bounces-215363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0D5B2E414
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 19:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9DB171398
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6D323B62C;
	Wed, 20 Aug 2025 17:36:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3439219301;
	Wed, 20 Aug 2025 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711375; cv=none; b=htzLDhPVp37jfLIivXWF+wpZmtQu+do9Mr0kSDlmxY/N7GwcmQeEiv8UVpxpcXh2J1SnafZVSsPewZBtzm/KPiexZwGSeayiEZQIHTvynC0PsTQBcwyLMezcRJdii5C3dCkYPsv2Pr3on3S0F/ywvq0vZuGEv6aNGjYkr4YX48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711375; c=relaxed/simple;
	bh=NQ8RwiOcADEkk2TpDkN9wI+BbdrSzJ3LNupEjhHpjag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT0yxlOPVJpR824rXkI6KS/3wixvOpYdnVdrPZE1N49Gx9wvuBTRbnJWfb+CSeW3y8g9GIagtDOOEUtiqu9Xe5N71zFiDZYOKM+7y2aIOPv/NtRBp+w7xO0sP43qyflQjscbFylRS3omGA+qVLOHrpNbrZy131VDN/gp2yEnf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb72d51dcso17692566b.0;
        Wed, 20 Aug 2025 10:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755711372; x=1756316172;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqWnIxv960cSlDAqbtsES7iXH4HnBlPxl1crXNWQ3eM=;
        b=vdsvaCw13ZLYDsZ+xz9r1mEJ+gRdvYrhL4QssPP1OrZHiTtUumL1RbVTVa1rwHmFjG
         h4kRg27F4JAa/yEYABFdXFgHpZL/Ihsx4r+SxjzL/eqXPpzHlIRiS62p4x1Kzzs9QShk
         gwOlMC77pM0+pj+fZruiGF2TqmN2KxlUX0szmnnVp2zz+uuII5kidmLUeGq7I+nxnz2t
         7CedMunRmo6SVmJxH30Dr/4MYXwfYSkli7pSomb2q3yfZxHpOdz8dY77Eq58mt7s+XGF
         jSZLVDjoKbMz6svkBOuQN43NfiCUvxew+mKd8Q7yqWie/2e//8sFG9aGOxJx86O31HoC
         iXPw==
X-Forwarded-Encrypted: i=1; AJvYcCVDMRh/+v0XhT8L4GCxJuCzTnGe4CiJ8bUwWjWR4MPqmjtvP7ZVvl6xR80fGFBOzdPjydLvBZow@vger.kernel.org, AJvYcCWq3roCK1SqD2vAv49VZnGJQzROPJecgYkBNL+SftS4w9zYn6x3VwKWE/cxoD6TEq2R+aDuiEWeRzg1Myc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2nTI+f+LD+5VWKiSvnvGRn8y/K6HK1r5Mnaj61viGPaVWTzYm
	JLh1+CJpE2WJKZNy8WUP/4eegGVewaxBCi0yuB0pfZx3mK+DmyHm/4Hh
X-Gm-Gg: ASbGncv05/55pkK2OijifblGy9Qy3mg4t7+TKuQmJDm6djRott5bHb7sSzAUSMuFVWx
	c+Dw0aEGFavIdAjIlg/FzJfCwjfXi0IfJZnISm6XIkhLzlbe5FNWbzbpcTqXn37OQor9WXIu8t2
	eHmpl+1g0w23pUDMVXHJlLXmh6tBM/Yvja/AAiaUDJ04L3FlEiggIKNCcLqtcCkYmasoqhQW7pX
	B4SNPKiqXcit9/kiYewwll5Nh6yC+wk1dK7zLYHC32Z8oafW9rxtAdxRXVlHnmLBeS/11nrFx6W
	7qWg1kpLHqBvTr+F4ztMhHSS26rdhYQrRZ6fUQIsRVcThQpL2o4LzRB+F8+rQRpGS6aUNVXlYxL
	0DmNBQGsqNHFP
X-Google-Smtp-Source: AGHT+IEJlNHEzmGfRqnix0ksa7wsO3R+AgU1Fg5EfVD+iwLJCVSAZoi7KYfJ63eUsa7JjqZvLksjvA==
X-Received: by 2002:a17:907:7f0b:b0:ae0:bee7:ad7c with SMTP id a640c23a62f3a-afdf029e077mr316048766b.46.1755711372086;
        Wed, 20 Aug 2025 10:36:12 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded478d69sm214280366b.73.2025.08.20.10.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 10:36:11 -0700 (PDT)
Date: Wed, 20 Aug 2025 10:36:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, paulmck@kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
 <20250814172326.18cf2d72@kernel.org>
 <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
 <20250815094217.1cce7116@kernel.org>
 <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
 <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
 <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>

On Wed, Aug 20, 2025 at 02:31:02PM +0200, Mike Galbraith wrote:
> On Tue, 2025-08-19 at 10:27 -0700, Breno Leitao wrote:
> > 
> > I’ve continued investigating possible solutions, and it looks like
> > moving netconsole over to the non‑blocking console (nbcon) framework
> > might be the right approach. Unlike the classic console path, nbcon
> > doesn’t rely on the global console lock, which was one of the main
> > concerns regarding the possible deadlock.
> 
> ATM at least, classic can remotely log a crash whereas nbcon can't per
> test drive, so it would be nice for classic to stick around until nbcon
> learns some atomic packet blasting.

Oh, does it mean that during crash nbcon invokes `write_atomic` call
back, and because this patch doesn't implement it, it will not send
those pkts? Am I reading it correct?

> > The new path is protected by NETCONSOLE_NBCON, which is disabled by
> > default. This allows us to experiment and test both approaches.
> 
> As patch sits, interrupts being disabled is still a problem, gripes
> below.

You mean that the IRQs are disabled at the acquire of target_list_lock?
If so, an option is to turn that list an RCU list ?!

> Not disabling IRQs makes nbcon gripe free, but creates the
> issue of netpoll_tx_running() lying to the rest of NETPOLL consumers.
> 
> RT and the wireless stack have in common that IRQs being disabled in
> netpoll.c sucks rocks for them.  I've been carrying a hack to allow RT
> to use netconsole since 5.15, and adapted it to squelch nbcons inspired
> gripes as well (had to whack irqsave/restore in your patch as well). 
> Once the dust settles, perhaps RT can simply select NETCONSOLE_NBCON to
> solve its netconsole woes for free.

What is this patch you have?

Thanks
--breno


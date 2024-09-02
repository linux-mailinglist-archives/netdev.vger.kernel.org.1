Return-Path: <netdev+bounces-124218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A41968A00
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 16:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492D41C215A2
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D31A210190;
	Mon,  2 Sep 2024 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMNzTTtH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080D71A2635;
	Mon,  2 Sep 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287453; cv=none; b=MTPvydc/VgqGLHxbYOAG1sac0qYbwrLUlsJnfUyLxqRoZbyUYMgg4Q7ZXDIJTp7PV1ErKP7PAwlcyJOZ+ePJArCknHahQnOVEVXhThWhapfLLuN3nhCqVa8Mnj1BnWWHbbU2+c04lcFfWy+uceVTsPeVIa7uqK84xqGTxV8lcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287453; c=relaxed/simple;
	bh=2hAH5QkrAb4QGYhA4EW70+aq6QJZeVXXuzVsNX5k9L8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oUFzaUVPsYPB0BwK+ppFoZxIRuDCqIQ+2UuwbD/s08cd8xvCAugZLIhjWuPHlUYe5NOCvUcnkjJiDcTT7z2zsd35yKK9UtfFkCSnzIhyPVdJhPgVDywaRl8iyf/ayeXJSOKBDM4JowHyubp+wCY+t/0QSJBhkxpH1XUQ+Q9olcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMNzTTtH; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-457ce5fda1aso8589141cf.1;
        Mon, 02 Sep 2024 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725287451; x=1725892251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWWTjaMW9Ko+2AruYroLKFk93sCipLt90Wh5KGJSmPQ=;
        b=AMNzTTtH32vyFKbcnumdQyOCoRtucP/HuR/6A07DNJYLeIjDKHGFTphQlnh8BNuKz5
         0YnyM3nHauVowjyEL6XvPwiigqPsa2ejVQ62yKetRdrafBrWGRbzFvrPI+O53WJFptTd
         d/EA5WFds5+CxbAYh9p2BXBOwlSZ3/DFBCxjQi6EsiA9RWXi6OAd4eiLBI8MnKCREmZm
         TA9ooRG3ygWHfJjjNhGizB0/uRlOnUUQwGFG++1L3h4QkRVLPKr8syYchzY/vKntWq3D
         N1VFT/RD8io1JwUxTIjmXhOS4b/2SnJvAUj4tWnSUPVCfh8ACYLmBLMbkNkIHRQQqGRK
         yzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287451; x=1725892251;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nWWTjaMW9Ko+2AruYroLKFk93sCipLt90Wh5KGJSmPQ=;
        b=qf0cmJowcqq/azIXbo3Vl0yP1nkE1fdiFKHI4eIGFfA698WjdDmk2rtf54DFvrkfvU
         E15eQky60z+75KqW5gUn8hmzgy5QG5PeExcwd5TbDqEl8nTcMWKT7m0wsPyPSr4c5bIY
         pirNeOkiiEsT6xRRBDWg8i/+waMnVAuoVZGAOfDmefE6pPjqG3b24/+i/Q23mq3p/SII
         5dFFzTMu31yeQ4QLT89WtDmgtT8ymV7jNGcI03HaE9lPTIGra3tNGQZr1A0xI0G5QpA7
         Uo6pMfKqqG7i6kBKkyCQ3HlDp/2mLD7/KMnyGK6F162ij9bfq8RZXf1O+pQRu5uh51cZ
         YBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOIxEDai5WBk9/YoWQsmleDjbMbE5/L9MDGhQAD/DQ+V3QNKt3i2AAAAUDaLMyjIfb372LfMSF@vger.kernel.org, AJvYcCXiJC05Q9dd6mfEIT96kgjSOzbVDL/ZMOMZpUZWjrcD790RlxxVXgpxTqO2+PaCBhYXbWmCJppbdgNXugtFMMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywff39tI3JpHENfNfzyl86RSLWY1JkM1GBU1LFe5PEdinFfnUYE
	duZvg2SLXiAlxzLHBKXlvUT+qW+1oRwKKwA1TJc3B2Ivb+zInYXW
X-Google-Smtp-Source: AGHT+IGv/l7eBJBzS0r0UAuzxt/6jjUp/xvP4dsSMZSBjT+uXKNWAJ1q1y5viRm6+kzthjCbx6pc/g==
X-Received: by 2002:a05:622a:5cd:b0:457:c851:8b0f with SMTP id d75a77b69052e-457c8518f3amr91501291cf.53.1725287450619;
        Mon, 02 Sep 2024 07:30:50 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682db8326sm39983191cf.95.2024.09.02.07.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:30:50 -0700 (PDT)
Date: Mon, 02 Sep 2024 10:30:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Andy Shevchenko <andy@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, 
 kees@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 akpm@linux-foundation.org, 
 linux-hardening@vger.kernel.org, 
 netdev@vger.kernel.org, 
 linux-mm@kvack.org
Message-ID: <66d5cc19d34c6_613882942a@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZtWYO-atol0Qx58h@smile.fi.intel.com>
References: <20240831095840.4173362-1-lihongbo22@huawei.com>
 <20240831095840.4173362-3-lihongbo22@huawei.com>
 <20240831130741.768da6da@kernel.org>
 <ZtWYO-atol0Qx58h@smile.fi.intel.com>
Subject: Re: [PATCH -next 2/4] tun: Make use of str_disabled_enabled helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andy Shevchenko wrote:
> On Sat, Aug 31, 2024 at 01:07:41PM -0700, Jakub Kicinski wrote:
> > On Sat, 31 Aug 2024 17:58:38 +0800 Hongbo Li wrote:
> > > Use str_disabled_enabled() helper instead of open
> > > coding the same.
> 
> ...
> 
> > >  		netif_info(tun, drv, tun->dev, "ignored: set checksum %s\n",
> > > -			   arg ? "disabled" : "enabled");
> > > +			   str_disabled_enabled(arg));
> > 
> > You don't explain the 'why'. How is this an improvement?
> > nack on this and 2 similar networking changes you sent
> 
> Side opinion: This makes the messages more unified and not prone to typos
> and/or grammatical mistakes. Unification allows to shrink binary due to
> linker efforts on string literals deduplication.

This adds a layer of indirection.

The original code is immediately obvious. When I see the new code I
have to take a detour through cscope to figure out what it does.

To me, in this case, the benefit is too marginal to justify that.


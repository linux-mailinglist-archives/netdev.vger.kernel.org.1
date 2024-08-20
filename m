Return-Path: <netdev+bounces-120288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3950F958D97
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 19:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E595D2865C2
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF451BD51E;
	Tue, 20 Aug 2024 17:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqIYQD+C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B071BA87C
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 17:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724175802; cv=none; b=JpDUWeX1T1kzq7h0eDo3Ekj/9mEfgTgUwoCzRWUlPABloTnTNvegIAIfMNJq6Tb/fNxztrz3C2ktOJg/uR8n0KVygyIQDNkm82vquV8f8qKWiA7JN4z3cwFUyWOQTg3qNaK880pcwgCzehjO2+QxBcCg/S1HbUaSKHCbYJFpoXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724175802; c=relaxed/simple;
	bh=tiU6DHp6HoBKqyuLI7uigGdcx6YuKXN3BUUD1DPggTc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=m+nWdsPpH3rofTnTEwW/KKrrRz+FyvClVcKBa7a75K9syb8lDMzZZN0bdIankggbtcxSuG1NuopTQIJsB8Q74x65Ge87+1XxXmmuH4wpTE2NMVJ2yLDVMwrFIh71ONcY4gEZHSNZHIBva1rmL7xGPawttFkp6YvIpFRok7kbajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqIYQD+C; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-690af536546so57360367b3.3
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724175800; x=1724780600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nOLtDu8hVKwzSiAUMGJGuj5i4WK8Nv303ULCrUXvzc=;
        b=fqIYQD+Ck5DOMRgvrINydpgshQwb62N+2UUFhhWBX6DZvOXCBiGdZwGAQy6QSMtqiY
         /+JblHPBH3QsxvUhLnHqjWBkAUd/Xh4qs6rVgfiUDfKrYzugi+XshUTCj8RR7ErHDO/C
         /Z4X8vweW4iIcC3P65uVd3WgUQ6EPKJWb5ZY9+EvpP2FGaW9Q5wHIi+FMxzza/3yyWqv
         Rbj2SScrMxMOzZCOUq82NSGSgAMDvAks33Q8nCwSmRtHL6xUyDD/7Ivv2cjgSaEEGH6f
         enjUvv0RiTTw7RlbZIAZPEygMq4cEMO2Tv78BvTXf/FN1p1LMBo4UFrODto8q2oLfxy9
         UtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724175800; x=1724780600;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6nOLtDu8hVKwzSiAUMGJGuj5i4WK8Nv303ULCrUXvzc=;
        b=G56/OqCYlemSR9IA9BGwavMv802fljIVg+mN8MgBuwNKwKp66ay30idjOg60R82dyi
         83dqau3QZLfibtvLkoSabqF/liQKiyyPXSVhd6d2Mt9wYCYSd/yvmkvQ/0ktfi/nvZah
         HskrNuoRQy3jxko2/GuxO/gVSAjDJxKGD4rJ+R6oMF4+5wFBvrHkiJCrKoZ/R0/plFHl
         5uLxicL9eLjXQ1ruCIWX2gp56Tmn4kncQo6bOB278OxES391PIzEq2bWzVa6H6nNQt07
         Xwi9qE8We79dJVzKu7Ukpe3hhLgms3fFdFh8FHdl5KPTOSbieVN4wswlxqxeiQ8E/SHJ
         W5bw==
X-Forwarded-Encrypted: i=1; AJvYcCVDz+UjY+z2KDOcgDbrrtR8bOFsEkDiduw/mu6Uo4dugRHDUhAyuhaA6Y3AdRqMMWcV4iStpUPW/cY2AUMtVZYTQFahKxS+
X-Gm-Message-State: AOJu0YxlAYf2YgHbpNeB8EOEPZTzIUJViPPkL/6/aLYuw31ctiC/5lTM
	3CxhIZ5XYd0xtIw8WfFL+NcebSKfm2YEgjS/gndA1Vxltbp8o69+
X-Google-Smtp-Source: AGHT+IGW7na7zNZ+QtbC2pd+VCvb85WtwFsC70xwDQrVHDnGe2HfzNSo8cd7R2YzpLwCYdPMnsW1YA==
X-Received: by 2002:a05:690c:f94:b0:697:7cc0:ce1 with SMTP id 00721157ae682-6c09ba07a09mr725067b3.7.1724175800002;
        Tue, 20 Aug 2024 10:43:20 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e002dsm547185585a.77.2024.08.20.10.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 10:43:19 -0700 (PDT)
Date: Tue, 20 Aug 2024 13:43:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io
Message-ID: <66c4d5b72c3ec_b14fa2943a@willemb.c.googlers.com.notmuch>
In-Reply-To: <CALx6S35b-YPCaen7D0THQ++giSM6cXJHVOtysg1pi5itKT-mFA@mail.gmail.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
 <20240815214527.2100137-2-tom@herbertland.com>
 <66bfa0823734a_184d66294a3@willemb.c.googlers.com.notmuch>
 <CALx6S37CEvh1zBijdP7NWfom8_5YByUegAaYr4jibeKOoO=TpQ@mail.gmail.com>
 <66c4c493543_aed9229422@willemb.c.googlers.com.notmuch>
 <CALx6S35b-YPCaen7D0THQ++giSM6cXJHVOtysg1pi5itKT-mFA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 01/12] flow_dissector: Parse ETH_P_TEB and
 move out of GRE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > > > > +             /* Cap headers that we access via pointers at the
> > > > > +              * end of the Ethernet header as our maximum alignment
> > > > > +              * at that point is only 2 bytes.
> > > > > +              */
> > > > > +             if (NET_IP_ALIGN)
> > > > > +                     hlen = nhoff;
> > > >
> > > > I wonder why this exists. But besides the point of this move.
> > >
> > > Willem,
> > >
> > > Ethernet header breaks 4-byte alignment of encapsulated protocols
> > > since it's 14 bytes, so the NET_IP_ALIGN can be used on architectures
> > > that don't like unaligned loads.
> >
> > I understand how NET_IP_ALIGN is used by drivers.
> >
> > I don't understand its use here in the flow dissector. Why is hlen
> > capped if it is set?
> 
> Willem,
> 
> For the real Ethernet header the receive skbuf is offset by two so
> that device places the packet such that the Ethernet payload, i.e. IP
> header, is aligned to four bytes (14+2=16 which will be offset of IP
> header). When a packets contains an encapsulated Ethernet header, the
> offset of the header is aligned to four bytes which means the payload
> of that Ethernet header, i.e. an encapsulated IP header, is not four
> byte aligned and neither are any subsequent headers (TCP, UDP, etc.).

> On some architectures, performing unaligned loads is expensive
> compared to aligned loads, so hlen is being capped here to avoid
> having flow dissector do that on unaligned headers after the Ethernet
> header. It's a tradeoff between performance and deeper flow
> dissection.

Thanks Tom. That explains.

So flow dissector behavior differs in this subtle way depending on
platform.

Maybe this is a good opportunity to add a comment. This thread alone
also already documents it to some extent.



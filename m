Return-Path: <netdev+bounces-80803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00879881201
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 14:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA521F23908
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1F240843;
	Wed, 20 Mar 2024 13:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kgqyfjwf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C367F3CF6A
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710939652; cv=none; b=eDMTKTsSTgZzZbGxKdSZE3fcgzXTlu6/G6d4Mdzh/V3Gk7vRU9GlBHGeNSeOiNmjRX2tFCGng4XuMqoxjg1UAIv15wFGAJdmWulBwS4g5PwsnGz7vWGc4QKJdjN91HnqRlVyPh57BO+nRaOeQ6mJ5+45HoZxNgwWUPt/vpZqCaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710939652; c=relaxed/simple;
	bh=mogu6oi2i5SnONJEgzaKOYx011gPldHPJqRkX8BBUFU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nhGXGvFdzVYWej8wrnyVZP7s2AF8f6XDPOLdHVFBHLLk5XouS1Xebc3cuDnSSZjLbTrFy92MveswH79+WJi92bs4Yjua5/zhM+iDeg4mKsWCZ1yxjRlZFJQLgleb+pnVSvAN6oREMbO46oMJhUDra/f8gbSFwMHf+sR6r9sGa28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kgqyfjwf; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-788598094c4so344328885a.0
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 06:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710939650; x=1711544450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITZSoMNaASAzc8f5sDgqSRcARRHnEcq+/Joeh2zcAs8=;
        b=KgqyfjwfYwRFoDaBjdpwLE8XHrJteZ1Ds7vuzHaLiSUWG0QvOKEzDdKQJsAMyNqQqE
         +XyyfVop7uOk31YwZiRajShXK6ysnJ9btpDbxLmkWspYOGdT1RkJ386Uq0RhXhTGqVpt
         vZjSxTVtgSDvuxjRxnz6Lu767Dj6jjoNojT0+FVG8gwnSlI27zfDWiHNFC8b5zYJ4aoB
         +HPraoDuT5Q/FU/OdtPDEfAKIi5YyNqOJWFjmuXcXI9LrAPwcsKcKj6sZKVqWNZ3LXlS
         Qz3eOHQkG/1xu3+YX6d4IfBE/KLczS9EjCgGs2fi7Ov0kjiYKs1M441CF9ROkwAuchFR
         MXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710939650; x=1711544450;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ITZSoMNaASAzc8f5sDgqSRcARRHnEcq+/Joeh2zcAs8=;
        b=wmcBWu3rEtHE22clNcJHwFBd0G2c9puZxmuUbDIJ64FRSc8PsON0KQZcAjnCW/QmgH
         +s5ompm5RkRH5PLg1hxSHhxPw9PWShCnPU7KuLO+j5o8H8eHcm4NRq8+5c+wzqViaq/k
         U2R2wZJfHYlXPOQZEc4OEjM0dplnAQomuSbx691uTY0x85wxvn6G7VobWRczsdABbpkp
         8lPjfoZi2vQGGq4hNW5bsQA329190uBPvgAnb6j02GNcctxpXy4RxpYEOeQvz0xgPBQs
         FwZBUkeRxZOQbaKzWwYnapYI0MgqVywBrD9YTYMu8DGqKDcNHImQkK2hmVYgCjl2Wu4D
         gcog==
X-Forwarded-Encrypted: i=1; AJvYcCVvztuE/YlBrXWt/BVnhnLwMpWbg5nOj2MapiKM3iQn1U3RITU/Q0AJjlsGull3+nb8Gu06GjZoe2BX1banVmTTcTUUg4KB
X-Gm-Message-State: AOJu0Yx6uDdcEMpLDQpa+Hge2yu0xx4e42o3ZVHr66G6GQbeVKZvS98p
	wSS8FLio/Z+ZCdARYBjtzcMabokwog5TVHlkUGkI423yk01m5pjX
X-Google-Smtp-Source: AGHT+IFHOlVf6spfyanNdzJiIXGT7Wb/uCHfAvAoj1WK0f4uyCL1CICLP7g4DE/2SDElbGQXeUPohA==
X-Received: by 2002:a05:6214:514:b0:690:bb11:2a0 with SMTP id px20-20020a056214051400b00690bb1102a0mr19825604qvb.10.1710939649512;
        Wed, 20 Mar 2024 06:00:49 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id im14-20020a056214246e00b0069049298fccsm7757924qvb.65.2024.03.20.06.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:00:49 -0700 (PDT)
Date: Wed, 20 Mar 2024 09:00:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antoine Tenart <atenart@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: steffen.klassert@secunet.com, 
 willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org
Message-ID: <65fade00e4c24_1c19b8294cf@willemb.c.googlers.com.notmuch>
In-Reply-To: <171086409633.4835.11427072260403202761@kwain>
References: <20240319093140.499123-1-atenart@kernel.org>
 <20240319093140.499123-4-atenart@kernel.org>
 <65f9954c70e28_11543d294f3@willemb.c.googlers.com.notmuch>
 <171086409633.4835.11427072260403202761@kwain>
Subject: Re: [PATCH net v2 3/4] udp: do not transition UDP fraglist to
 unnecessary checksum
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antoine Tenart wrote:
> Quoting Willem de Bruijn (2024-03-19 14:38:20)
> > Antoine Tenart wrote:
> > > udp4/6_gro_complete transition fraglist packets to CHECKSUM_UNNECESSARY
> > > and sets their checksum level based on if the packet is recognized to be
> > > a tunneled one. However there is no safe way to detect a packet is a
> > > tunneled one and in case such packet is GROed at the UDP level, setting
> > > a wrong checksum level will lead to later errors. For example if those
> > > packets are forwarded to the Tx path they could produce the following
> > > dump:
> > > 
> > >   gen01: hw csum failure
> > >   skb len=3008 headroom=160 headlen=1376 tailroom=0
> > >   mac=(106,14) net=(120,40) trans=160
> > >   shinfo(txflags=0 nr_frags=0 gso(size=0 type=0 segs=0))
> > >   csum(0xffff232e ip_summed=2 complete_sw=0 valid=0 level=0)
> > >   hash(0x77e3d716 sw=1 l4=1) proto=0x86dd pkttype=0 iif=12
> > >   ...
> > > 
> > > Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> > > Signed-off-by: Antoine Tenart <atenart@kernel.org>
> > 
> > The original patch converted to CHECKSUM_UNNECESSARY for a reason.
> > The skb->csum of the main gso_skb is not valid?
> > 
> > Should instead only the csum_level be adjusted, to always keep
> > csum_level == 0?
> 
> The above trace is an ICMPv6 packet being tunneled and GROed at the UDP
> level, thus we have:
>   UDP(CHECKSUM_PARTIAL)/Geneve/ICMPv6(was CHECKSUM_NONE)
> csum_level would need to be 1 here; but we can't know that.

Is this a packet looped internally? Else it is not CHECKSUM_PARTIAL.
Looped packets can trivially be converted to CHECKSUM_UNNECESSARY.
It just has to be level 0 if only the outer checksum is known.

> There is another issue (no kernel trace): if a packet has partial csum
> and is being GROed that information is lost and the packet ends up with
> an invalid csum.

CHECKSUM_PARTIAL should be converted to CHECKSUM_UNNECESSARY for this
reason. CHECKSUM_PARTIAL implies the header is prepared with pseudo
header checksum. Similarly CHECKSUM_COMPLETE implies skb csum is valid.
CHECKSUM_UNNECESSARY has neither expectations.
 
> Packets with CHECKSUM_UNNECESSARY should end up with the same info. My
> impression is this checksum conversion is at best setting the same info
> and otherwise is overriding valuable csum information.
> 
> Or would packets with CSUM_NONE being GROed would benefit from the
> CHECKSUM_UNNECESSARY conversion?

Definitely. If the packet has CHECKSUM_NONE and GRO checks its
validity in software, converting it to CHECKSUM_UNNECESSARY avoids
potential additional checks at later stages in the packet path.

> 
> For reference, original commit says:
> """
> After validating the csum,  we mark ip_summed as
> CHECKSUM_UNNECESSARY for fraglist GRO packets to
> make sure that the csum is not touched.
> """
> 
> But I'm failing to see where that would happen and how the none to
> unnecessary conversion would help. WDYT?

I would appreciate the GRO and fraglist GRO authors to also review
this series and chime in.

> 
> Thanks,
> Antoine




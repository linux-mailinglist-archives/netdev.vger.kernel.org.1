Return-Path: <netdev+bounces-136774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE609A31BA
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BC1282483
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 00:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C963BB48;
	Fri, 18 Oct 2024 00:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/aUa3Zt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B233981;
	Fri, 18 Oct 2024 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729212220; cv=none; b=vASNsuZjfOjsSFM3VQMV5LY50AFmaNJ7abGxRkKNL3eGw+Kzmes2P8SMbvMVsjEOir/3blsd4zG7w6XqxVp9JybwwAzytkpoB3xe9qDzInW+QiL4AvnrPNGAff0OJJT7Asv/VED+hQ6Whb9iGkjmOcm+zQ3O2IBczwh0ZliTGwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729212220; c=relaxed/simple;
	bh=fZNxleGIrejHhWeofmO6EkaM1yPGKgZxLP09Xxx3GnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SL3Xx1wTnQC4QSfCs2pFr/dpD7MvLfMS40ls85wMTODm6Pf/Z9jO0RkJ3wnMzdk/2s6spLNVzQHRC7OB7Sglpa2uowpMY7jvv2n7yJOY8BIFA8WVUWhGu31OnVumX73/nvKLJog/MBFFyBzjfW0l8u4ywi14SWof+4spQHxpjFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/aUa3Zt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cceb8d8b4so9886555ad.1;
        Thu, 17 Oct 2024 17:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729212219; x=1729817019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RXagPdrIMEuSMYlenqkB9AtogEOA7JRFBZk7dn6AKM8=;
        b=T/aUa3Zt7Rixnh41hUXUEGn5rKaX4AdPENmrvDXYlB6qwQObWkJQL8np0O2/+GFGy8
         8laDPz/nfwKfUzHLE22nMtDWcmVBuKuZO/Pi572LzTY32yFaEt6Rxp2Sf/BgZoLv/Ebe
         A0rjOo5F/4PNLpjjem8HmAtTreAER3uS1ajAQL2yMzjwtWwZ1Etsart8lfl/42Mnex60
         XNIUEupvL7GjpDRIY98xGWihH/pktnGOFkERfd93FUE4Ck2oVHRId4XbUvdjHzj6FzUW
         VS0+YibVk3XLwT1x4gcjXiw2FjrMhwQ5Bu9pbi+cBBKaI6oauA0CJDsrZVRs3CpieyAi
         B6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729212219; x=1729817019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXagPdrIMEuSMYlenqkB9AtogEOA7JRFBZk7dn6AKM8=;
        b=iSdxmCF8/SYVD63HlKnGeRQlGuBhDdFtiZRaIjT57i8aP0l9BzAqNBOrVjqjrHxTjC
         iUtOADKvTQzgnu42V8pO4ayjUrdpxeYyB3TCZJ6XdviAh/qr438sebMXFq8MwRICBHiT
         71bb0v92fBJS1HlhkIqwR7zKeeztEyVeV/ObkGop3B0wTTslR6J15sAzSC2AXmcV6Z0B
         5hPQUNF2IxpuGdHHMyRLDF9OE/8SNaqiPIr/DFye8QPKI3HIeOB2Jxglv27Z6ZXYsADG
         hTokYD2LVKSyJ9ipRnl9dyBlS/nyjQxlqgzfoCHP3ajQdhv0wecwtvkga55TBlVbKvG0
         n8vw==
X-Forwarded-Encrypted: i=1; AJvYcCU9LXU9knaV55aj1f1huX+bpUs0J7h9jtsKyQxOfb0wsLYKIBoA/YTeiGbXvwtVOqdUPodnN36/4h83Ff4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwAAmenPPkWUDGxD4SGsv2Vb2jsuRdFkYb/vlIBRsGnKLOnr50
	cfWaBTgTwasqBZMqX2Fwu1Dtp5HoC4LgJygUka2ViBWZHEB5i4nr
X-Google-Smtp-Source: AGHT+IGMB8EDu9k5GiFTgaGSMuyYB3DIMZW6ubYgsU8dkXccGtCaWhmYEbyuYSrkn7Bz9KJO8kXfPw==
X-Received: by 2002:a17:902:c40c:b0:20c:7196:a1e9 with SMTP id d9443c01a7336-20e5c148ad9mr8076265ad.13.1729212218529;
        Thu, 17 Oct 2024 17:43:38 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a71ec36sm2303595ad.53.2024.10.17.17.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 17:43:38 -0700 (PDT)
Date: Fri, 18 Oct 2024 00:43:32 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kevin Hao <haokexin@gmail.com>,
	Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	linux-kernel@vger.kernel.org, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next] MAINTAINERS: add samples/pktgen to NETWORKING
 [GENERAL]
Message-ID: <ZxGvNKoBL-27Iak0@fedora>
References: <20241017111601.9292-1-liuhangbin@gmail.com>
 <20241017163942.GA1697@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017163942.GA1697@kernel.org>

On Thu, Oct 17, 2024 at 05:39:42PM +0100, Simon Horman wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 44d599651690..3b11a2aa2861 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16202,6 +16202,7 @@ F:	lib/random32.c
> >  F:	net/
> >  F:	tools/net/
> >  F:	tools/testing/selftests/net/
> > +F:	samples/pktgen/
> >  X:	Documentation/networking/mac80211-injection.rst
> >  X:	Documentation/networking/mac80211_hwsim/
> >  X:	Documentation/networking/regulatory.rst
> 
> Hi Hangbin,
> 
> Nice find.
> But lets preserve alphabetical order.

Opps, don't know what I was thought that I feel s behinds t...

I will fix it.

Thanks
Hangbin


Return-Path: <netdev+bounces-98559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB99B8D1C0B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8E71F23D39
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666CF16D9DC;
	Tue, 28 May 2024 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIboOBdr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099E513D61E
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901225; cv=none; b=G8R2ShzdzGgH2UY/AhjXi3LkHu6+pxkN/g2RqS0S36+MLpebce8NXCFN0XD3kMPoUtGXx4dBidDOgVy1p57QwJ7CnOGu6xWFrdXJg6EfyuIwxjpXhxzBzEygvS2cQDvJsgk6eXV39lbjZWslB9YP31QREg3JOPbZgGTTSGzBg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901225; c=relaxed/simple;
	bh=xku3JO402J5hjxFtbY5mOTmvTiyUgaFYBDY/iIO18Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akI9O26S/pMKEZtZWZ+AaR0pOGngedroF+W9iAMIgXLPIVfEfuD2K8UzFDbIhj0v3WHQviQUFWTUEH93F+vG8OYsd0FRO5Y1+wh8zULWnlH6N5uRCuDzGRYWEETy1SEuUwZ7ey6e8Vttyq103lynFpolxqhTGQPi097eqciEb0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIboOBdr; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-681ad081695so602897a12.3
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716901223; x=1717506023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=flVu77TEXfI7ID1YVTwyjph35sgclLhApkkGh84za9c=;
        b=WIboOBdrlFXozChNf/oG3g4THtLn6GZJNzoc72hwB7O4OlM56aRPucPOK1O4OVOvSw
         RrHbLy1YOR8Nh6dRNZRSMkFUA7dhNEU04WiyfF6SOyiqXhM+daEaL2o9u8F64uJuXqM6
         xkHQ0m3/76IBU1uns6S2pCWFDrzUAqkCVeeXbXySBdWXNpXnkOp8c+ukWz6WtDHs3VQn
         21/XJlAQmYEZRk5QKwLWmd2MZaNi8WEvs2KzoUh4SIuXPuys24hPoGT800OwaCttvPiR
         rojOXwBH6k12YNSmqYbY1S/uRX1zKfnomYXpuJXAwo/rhUsAx1sGhn4sHQCZ9gM3slWh
         gkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716901223; x=1717506023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flVu77TEXfI7ID1YVTwyjph35sgclLhApkkGh84za9c=;
        b=DP8Z/JgoMps1lYVQ0z0l0lVosB6LbvqU2LtUza3LPkmM+p6kM33OPN7kZoGV9sDZJ9
         oFUgJ7e8j4GYZ9CRwa3gjgxy6gUSaHQvDkwntmgjDprT/TWFM9R4QUBoxqmB+ACiCukN
         BPSv8/w+WgQZEbJ2bs9UKEZ5FCmNVoIyjehSvD5Yd0KQdeE38smDy7FwutlMrUko+lEj
         37D49vgyuIggw51kWDpIsXebA3FX7Wd3rCjTpdn9hpQUFoX0UdhSwB5nLd6/8MMyDlgI
         0j89WAkVtWHZq1MmSqBvUnrrYMiutzzkHMToNRPxaLcMVpPYtdvVEeKGfW8Z6yBceHO8
         3GJw==
X-Gm-Message-State: AOJu0YzmQlOzJ3E11Cs/0IfQ9dKGzxUEACLBpvJMMteiGU1Q9FkIDTBa
	SzQJIixoGQCewlquzDZqv9Bso6eB+u/bPA4y7Vp6r3TpCyid6cW3
X-Google-Smtp-Source: AGHT+IGKIBRSqBtWHnwSlwjnt3n86LqYUrs9VNyeJ8a2UdWcKieTUWgeNk5xb6rG3YHZMrHLcCCUlA==
X-Received: by 2002:a17:90b:1098:b0:2bd:e8d7:8a17 with SMTP id 98e67ed59e1d1-2bf5ee170d0mr10527854a91.12.1716901221621;
        Tue, 28 May 2024 06:00:21 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf8ccb7543sm5835856a91.0.2024.05.28.06.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:00:20 -0700 (PDT)
Date: Tue, 28 May 2024 21:00:13 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Lebrun <david.lebrun@uclouvain.be>
Subject: Re: [PATCH net-next] ipv6: sr: restruct ifdefines
Message-ID: <ZlXVXblc20QmZXlf@Laptop-X1>
References: <20240528032530.2182346-1-liuhangbin@gmail.com>
 <ZlWsWDFWDCcEa4r9@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlWsWDFWDCcEa4r9@hog>

On Tue, May 28, 2024 at 12:05:12PM +0200, Sabrina Dubroca wrote:
> Hi Hangbin,
> 
> 2024-05-28, 11:25:30 +0800, Hangbin Liu wrote:
> > There are too many ifdef in IPv6 segment routing code that may cause logic
> > problems. like commit 160e9d275218 ("ipv6: sr: fix invalid unregister error
> > path"). To avoid this, the init functions are redefined for both cases. The
> > code could be more clear after all fidefs are removed.
> > 
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> I think this was suggested by Simon?

Yes, and David Ahern also suggested this. And I thought you also mentioned it?
I was afraid there are too many suggested-by tags here :) I can add them
in next version patch.

> 
> 
> > @@ -520,7 +514,6 @@ int __init seg6_init(void)
> >  	if (err)
> >  		goto out_unregister_pernet;
> >  
> 
> (With a bit more context around this:)
> 
> > -#ifdef CONFIG_IPV6_SEG6_LWTUNNEL
> >  	err = seg6_iptunnel_init();
> >  	if (err)
> >  		goto out_unregister_genl;
> >  
> >  	err = seg6_local_init();
> >  	if (err) {
> >  		seg6_iptunnel_exit();
> 
> With those changes, we don't need this weird partial uninit anymore,
> we can just create a new label above the other seg6_iptunnel_exit()
> call and jump there directly.

Yes.

Thanks
Hangbin


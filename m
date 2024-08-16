Return-Path: <netdev+bounces-119132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E16954473
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1DD2825FA
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14BF13AD3F;
	Fri, 16 Aug 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClfQzRVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730E113AD03
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797186; cv=none; b=qSwSGNWlHkC/sxrNkVpGXXBDLOB+bHNWg5j/Y4m2vuDeHyPQANLwKJmfr8TEbJMCWjm5oELPH+CmUSC84WaQt++6Ssu11J4cuqVaKs+NSIHA8Xw81IUaFM00uCt6yNIbPHs1z3UebKDysItccT4Uu7BbxITYtsTlBhasJ/x+6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797186; c=relaxed/simple;
	bh=T55uUjatejs1wLNE96EenvhWq+izynTvh8Pf1QVKpWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zs/SG3dkCZU88fIC+jdxblG/ooMD0OVfqsjGynJa6fxFBDs8Nl6HbH1U9uY45oo2Sz1LARAEpomHlYBAyTkf2Yu7qz8vrQR0O+acJq5FajMQ6/nutvlXNSS7rNE4yyF2i/094Ptw2GU/4Y8XTxh0+pycS3hnflFvcwIwDJbJZFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClfQzRVV; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3bae081efso1293649a91.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 01:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723797185; x=1724401985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yKfnKyn/c2PY+CaH/VZMybQrRdLmlnGQxAI/e9+DIUA=;
        b=ClfQzRVVOsk9koFdLGEJmACs5PzeGeD4qtvA4PHtsCHgK7lA1om/6uUJFYfyAhAEZC
         8kljd9G1/Y4J7hPPjSnYsMUqZpTIITgOzqyM2JqcQea8A6N/SMPyuA4cdAu3DqL+aecw
         RZjF+pluh7YlARf+NpYIKfUhqSahwfiohliXVtsmK2kX1bNLM3k+yaPCxiTK2IlFEXky
         iA6gkrI6807Q4Zb/ic1XXGWK8VcBgma6/KQ/XOujSjGBQZeatCPyk8WDwuMvvCCFutWu
         r/KWRvVvXZfAdgFkI5GDkRHfgBxTX372M84Ext35/M7osIyJpcdc0HiuUqbXviW4WxQa
         xA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723797185; x=1724401985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKfnKyn/c2PY+CaH/VZMybQrRdLmlnGQxAI/e9+DIUA=;
        b=uzCdSQTb7nrj6fv9ChdpmnplRx9sIUsfmQmgEYYtpeR5pHdmvcg9NaWvWNZUNnNXy0
         bU0WuPYFAAlBXFO1zTZ9qvn2y7XHaGwB0TaExq2e42ydQVcYtKjvWdQg6+W1Dv77hwsl
         OreAod3aY5wmZWvahGKtRq5mZfox7o2YlAWG1LQom9qOpb9iBmcKYt9NysgVXQYicetr
         SMmiO+FhhGYgfZP0dIWOylifR56kmqpueHhFUxmcqZTZFanuFpwfyGDWUTk5VwpDRxBt
         aX3fzcdm2Da8A91nrR80AfXyHBYa570869APKLIN3z0YnheuK68ETsVU9NfmENQ1PHcr
         vPIQ==
X-Gm-Message-State: AOJu0YwbOd7OoqNmuo5VAO3nkINoezZLLAxIfGPquYCMtNkq+z7oOAQ1
	Px5tEecgELpRM6XxOH5dBVWPGHt2w7sfPa6sqh/BQA6fL0NTcyHx
X-Google-Smtp-Source: AGHT+IFGwm0p59P5II/Oz8zkeKZY/T2aBaTGW9S1+s1p7GFCKL8UY+2BT4441JfzB5MKeHhO0a8HUA==
X-Received: by 2002:a17:90b:1284:b0:2cc:f2c1:88fb with SMTP id 98e67ed59e1d1-2d3dfc58e77mr2421913a91.16.1723797184648;
        Fri, 16 Aug 2024 01:33:04 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7ca33dsm5066221a91.6.2024.08.16.01.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:33:04 -0700 (PDT)
Date: Fri, 16 Aug 2024 16:32:58 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net-next 0/2] Bonding: support new xfrm state offload
 functions
Message-ID: <Zr8Ouho0gi_oKIBu@Laptop-X1>
References: <20240816035518.203704-1-liuhangbin@gmail.com>
 <334c87f5-cec8-46b5-a4d4-72b2165726d9@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <334c87f5-cec8-46b5-a4d4-72b2165726d9@blackwall.org>

On Fri, Aug 16, 2024 at 09:06:12AM +0300, Nikolay Aleksandrov wrote:
> On 16/08/2024 06:55, Hangbin Liu wrote:
> > I planned to add the new XFRM state offload functions after Jianbo's
> > patchset [1], but it seems that may take some time. Therefore, I am
> > posting these two patches to net-next now, as our users are waiting for
> > this functionality. If Jianbo's patch is applied first, I can update these
> > patches accordingly.
> > 
> > [1] https://lore.kernel.org/netdev/20240815142103.2253886-2-tariqt@nvidia.com
> > 
> > Hangbin Liu (2):
> >   bonding: Add ESN support to IPSec HW offload
> >   bonding: support xfrm state update
> > 
> >  drivers/net/bonding/bond_main.c | 76 +++++++++++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> > 
> 
> (not related to this set, but to bond xfrm)
> By the way looking at bond's xfrm code, what prevents bond_ipsec_offload_ok()
> from dereferencing a null ptr?
> I mean it does:
>         curr_active = rcu_dereference(bond->curr_active_slave);
>         real_dev = curr_active->dev;
> 
> If this is running only under RCU as the code suggests then
> curr_active_slave can change to NULL in parallel. Should there be a
> check for curr_active before deref or am I missing something?

Yes, we can do like
real_dev = curr_active ? curr_active->dev : NULL;

Thanks
Hangbin


Return-Path: <netdev+bounces-119613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9895654F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA0A1F22C8C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 08:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CB515B10D;
	Mon, 19 Aug 2024 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ecq3Y/Lp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1E15B0F2
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055153; cv=none; b=omZQEblL3tOcBMgykGyz0cVwOacc0RUV70Je4qY2qtvqYePa8heUyCtuh3OEhXulMzNY6D28EMwZ1ocMmbMvdorgA+uzl+MMg7LtPEAwikPrbRBH31B2Qb3AQ96e/uXHSbFTbfk180b56ZQ6LdjqeTGkdsgCBrerO5CZblu1niw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055153; c=relaxed/simple;
	bh=lM0fIpjZjg4/XuokPszymKQGUdvfnYHj/CXpdQTpVBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkWkGx24YF3uyHIrXfctjBuCba6JMlR2rU56PUKIStuYhEz72ONo5ay7no6Auu/95HRA4kykWPmfIXn4tzC1Xh5ib8Hsm+69wrBRWf6EDwcVXItm8d4NG4fE/keFglZu4b5v2CctSJXLa7GsnqAlbsKSgduOUbHqoAeqYW0CA7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ecq3Y/Lp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7b8884631c4so1583177a12.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 01:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724055151; x=1724659951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DVaXvMkv8vDEE/Zf2G2u7hhrmGEB//VPykx9k4HgcT4=;
        b=Ecq3Y/LpGOUDO14TfE6jVjllTyUs9LYlq07hjWEr8WvQ6gcPzk4BbkFph5lqFN4e34
         z0BM2izgYNKRjMhM2kEUhqCnKERsyoZoZOVy4td5xHr1Q5aMfUTzvu7wob0pKPUgQie1
         lkLFud9gdcc885PL7XmTexBbXcae4X78doKHbB/dzr7hXI568YkcRdkxCirH0ko6tO40
         7Bt2qEyQVyA5PKfzxRGbh3fhagkUFW0aZRfxtm+iwr2RCB/wLh5DzgX/NlIL6S1TBL8h
         gbbjB7NHhZmKk7dOxNEGTMFIJjcpL2H4LnaCwH0tzwEAoHJfuNqLcZ0i1fvPN3uoaDZ2
         XJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724055151; x=1724659951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVaXvMkv8vDEE/Zf2G2u7hhrmGEB//VPykx9k4HgcT4=;
        b=goVEDjEBjXv680IJujEzfa2n2pVBp9t25+R5LeM4tkAtj2psB5Xcy5EtdeUTVDPg/k
         ywqARvC3pav87rxZ0wAAWSq3JwTWjdoyJzjHAI52vJn+tmI4j7PZwddbWBjhzYgOdC3w
         FbtggtZ+vFWyE81BfOtDAWZLLOrw7UY5Z6YwVH1DtUQxh59/XmPvqkOGumhoobZvfaR4
         8sxYF7y90CfEjltX5rt59wohv1CSBQoaIH26Rsz7S70sNGxnjd98KONaur+J78MEyWLa
         SkkWgaPH9ns4xQ6RwZsBK6uOmUhxZaSaQFbEV4QVBDoTnyFkclj00ThED3scAxrP8xvF
         q09g==
X-Gm-Message-State: AOJu0Yzh5n8MWBI3XglCg97k3dHmBus+d+/LK3gxY+2SKdVQBFWYKPq2
	TXY8WpA4J7lMKJBQdWuL53Jet9g9BxE8XwwoFnWAsfu1hFLHFIHZ
X-Google-Smtp-Source: AGHT+IH84PejePqGDYRDLae6nGsmktIMiB4Sogpgtp3zj3gCRQ7X6J6tisaD3yEc4RqgOsq+JjJUNQ==
X-Received: by 2002:a05:6a21:3946:b0:1c4:b4d5:e140 with SMTP id adf61e73a8af0-1c90506e42fmr12523052637.47.1724055151265;
        Mon, 19 Aug 2024 01:12:31 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d42a1dc5edsm2615141a91.33.2024.08.19.01.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 01:12:30 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:12:25 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
	davem@davemloft.net, jv@jvosburgh.net, andy@greyhouse.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jarod@redhat.com
Subject: Re: [PATCH net 2/4] bonding: fix null pointer deref in
 bond_ipsec_offload_ok
Message-ID: <ZsL-aVPLJ1EmM53y@Laptop-X1>
References: <20240816114813.326645-1-razor@blackwall.org>
 <20240816114813.326645-3-razor@blackwall.org>
 <ZsKzmpnXsKLAneIe@Laptop-X1>
 <a8ebc617-dc20-4803-9332-246d54ccf8d8@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8ebc617-dc20-4803-9332-246d54ccf8d8@blackwall.org>

On Mon, Aug 19, 2024 at 10:25:37AM +0300, Nikolay Aleksandrov wrote:
> On 19/08/2024 05:53, Hangbin Liu wrote:
> > On Fri, Aug 16, 2024 at 02:48:11PM +0300, Nikolay Aleksandrov wrote:
> >> We must check if there is an active slave before dereferencing the pointer.
> >>
> >> Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")
> >> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> >> ---
> >>  drivers/net/bonding/bond_main.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >> index 85b5868deeea..65ddb71eebcd 100644
> >> --- a/drivers/net/bonding/bond_main.c
> >> +++ b/drivers/net/bonding/bond_main.c
> >> @@ -604,6 +604,8 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
> >>  	bond = netdev_priv(bond_dev);
> >>  	rcu_read_lock();
> >>  	curr_active = rcu_dereference(bond->curr_active_slave);
> >> +	if (!curr_active)
> >> +		goto out;
> >>  	real_dev = curr_active->dev;
> >>  
> >>  	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
> >> -- 
> >> 2.44.0
> >>
> > 
> > BTW, the bond_ipsec_offload_ok() only checks !xs->xso.real_dev, should we also
> > add WARN_ON(xs->xso.real_dev != slave->dev) checking?
> > 
> > Thanks
> > Hangbin
> 
> We could, but not a warn_on() because I bet it can be easily triggered
> by changing the active slave in parallel. real_dev is read without a

OK, maybe a pr_warn or salve_warn()?

> lock here so we cannot guarantee a sane state if policies are changed
> under us. I think the callback should handle it by checking that the
> new device doesn't have the policy setup yet, because the case happens
> when an active slave changes which means policies are about to be
> installed on the new one.

Hmm, how to check if a device has policy setup except ipsec->xs->xso.real_dev?

Hangbin


Return-Path: <netdev+bounces-238158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E3AC54D2E
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 00:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A5D83443E3
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 23:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E182E8882;
	Wed, 12 Nov 2025 23:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNzgPqhh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058372737F3
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762990934; cv=none; b=YKwDPx50Q8QlXWcByixzGPUvYDhR0IyQdcS5XVbe5JbbMe/ele8sERrUPozrs9EIJsnSgRNpf4xLGv95JLw/JQx777xJzn+rlTu2Bn27cod/pPAPu1wTFQysiXIcY10P2zW2RSNqGY+yktV3volJWEODOYv1xmqPK39cqh8wLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762990934; c=relaxed/simple;
	bh=1lMoFMACzbECk38vPby/3BbYs6Z3LfIE8mVZSaO1JLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RyPf6633m6VMA0RWvsvSmraIK2hazkxQtEz0PBEv3/db8ysz0oRwW0RrHKTq1txOKQh3/fRK0/661ZHCMULQu8seLT1fbMg6FsXIEc0fVLOIwS9GYyDMajsw37GV8O2Z3UQmOIXE9xP2f4/zbY3IEkOLYQKHyNS1fBD7cWZc6Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNzgPqhh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477632d9326so1629235e9.1
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 15:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762990931; x=1763595731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TshU2etaSOogd1M2K3cI72dRrmMqzWKUmJSokl5dOkg=;
        b=KNzgPqhh7/bu2fGYbsl+Imz2xNGDo0JoWjIH+/0TkRhmmy/p6zLe5vE3qM7ujpKNIZ
         iCDDpOupX+oOWTe4cMXXOqA0baZNu2sZSMDvUs/z6+t2MM8uifBgwGwBz8OmcF3ZXDC6
         Z86YfSAUROymmb+DRUWtnqU8/Ohbbd1JsgKcpZ5Jgupt4MGTFfV0lGL39RG8UeznO2TZ
         fILhu8SH2xIjKvLLu35Bw1k4lMQ9mxez2sVSUwLStqNsgJw0H3LMK+0fCt27MfD2MBkJ
         xKanfAXxXlJkxemqmW6dXX2CW+TUopQOe2p1O2w26PBVb65ZlYR7q95dTviWLaZ8Qfmk
         h56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762990931; x=1763595731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TshU2etaSOogd1M2K3cI72dRrmMqzWKUmJSokl5dOkg=;
        b=vlSNzWyMyRfJCUrjCG1GIPYtU5I+6X/GmvdBobD+U4zY9kbhjie37+7B4clWorgsnX
         6iTbBJNhkA3n6ydbXhzi9BMCAVzJS5+K0e7NB635yv1ee4yOTxg/2P+5by7u/asam6ow
         FIZnQmMWPP9XJLG7Tm+65gM0ExaYIcTvOQXEVKoOm+nsXOUxCSxzidHjeYB7fM81gvdP
         hVdve1KukEFfimQUjsf5V0AP+Wmpq0q/gdQJxRMvTF57ZKFhAib4/mJVPHBtGvUHkMyv
         NcRMhVHVieGONr9Ttx7icbAHKqZioj3rsbDSpkqzsl78YPKKcBmO77MUvQ9OD8usTfzc
         9a4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/H2HrxMObl/YBS5Vm6ptur0CwIYEODrI8mZ8JY/336JKDmLgDsN9bedzQfYGdW7Ufkf8LmXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ANWScqMayTy4Ti8bnpbgbq7V16SNQmAn6Zn4iDgOZFz+Nguz
	bYADrhnharOaQD0Fkb6OYr17owT73sQchTPmoEtBvkyyvL9sJXqUDCAy
X-Gm-Gg: ASbGncsK9nPj46trs2KK+uJtTg/Ex4OVL6qhYlF7x0dDxzi0BUsFeT4dm/UoWrSMo+s
	csMHGystAi6BBQ/qpSo91rVkNVnGDWssDCx7aMzLc8la7DM2ZGoUNLk2bTqtrmRLNID3SCS8IgG
	aTVbJi0nHQFjFow9w7QMXFh5UfC5Dv68REqutop8cYOnxuWVLvr7OCxRxlqtQ+9kcgR8I5KfMtG
	YOLLOkRoQ/H2yxphVhjCtqe87jiIrHRRmHwC9LTnlZsVpjqGXsCpnc+0qp5A2sJGov3O68Unjr0
	cGlvTc07T0n9IWW2dPNhdkJSaF7OgmiLyo5vsHHn2RAj1T+vYflOuetvVhbI/Xvcsjds0fLayNe
	+6IPbMJFvE523a+fDu9lu6wWtjeXNMa5x765D794mVH08Adq4MY4jFTF8GOsLpBEQGGdhZZeD
X-Google-Smtp-Source: AGHT+IFFAk8S1cUSmChXmujEvmDeQzGglCBvYNUZFPq/4dEK7j7TC7hepzqst+d+TMDKaX2Il38imA==
X-Received: by 2002:a05:600c:3546:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-4778703e738mr51144505e9.3.1762990931152;
        Wed, 12 Nov 2025 15:42:11 -0800 (PST)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7ae98sm368059f8f.2.2025.11.12.15.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 15:42:10 -0800 (PST)
Date: Wed, 12 Nov 2025 23:42:08 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/6] netconsole: resume previously
 deactivated target
Message-ID: <faql444wbuoqwtfsl2722xjphijchannmdk2d5gemupnpluhom@bvv2k6zy7lhx>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
 <20251109-netcons-retrigger-v3-5-1654c280bbe6@gmail.com>
 <e4loxbog76cspufl7hu37uhdc54dtqjqryikwsnktdncpqvonb@mu6rsa3qbtvk>
 <h5tdoarzjg2b5v3bvkmrlwgquejlhr5xjbrb6hn2ro4s46dpfs@4clrqzup6szk>
 <j67rta6sn3c2tgor3gtcrr2hvcdnxk6iqvzkhqkjkr6cgaezbh@vri4vhhzv5rf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j67rta6sn3c2tgor3gtcrr2hvcdnxk6iqvzkhqkjkr6cgaezbh@vri4vhhzv5rf>

On Wed, Nov 12, 2025 at 09:52:10AM -0800, Breno Leitao wrote:
> > The main reason why I opted for a helper in netpoll was to keep reference
> > tracking for these devices strictly inside netpoll and have simmetry between
> > setup and cleanup. Having said that, this might be an overkill and I'm fine with 
> > dropping the helper and taking your suggestion.
> 
> Right, that makes sense. Would we have other owners for that function?

I've looked at other drivers using netpoll and from what I could find all of them
are using __netpoll_setup paired with __netpoll_free. They don't seem to 
rely on dev_tracker to track references, I'd need to look a bit more to be certain,
but I think other callers are own the devices and track their lifecycle separately.
So I don't think this would be useful for them.

Since we are moving netpoll_cleanup to netconsole in your patch below, I think I should
drop the netpoll helper and keep it in netconsole. I wonder if we should consider
moving do_netpoll_cleanup to netconsole as well, since it seems to be the only caller
and then we would have the same symmetry I mentioned above.

So, to summarize, given your refactor patch I think it makes sense drop the previous
patch and do the netdev_hold in netconsole as you suggested. Does that sound good?

-- 
Andre Carvalho


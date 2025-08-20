Return-Path: <netdev+bounces-215413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0F2B2E876
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781B31C8815B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 23:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B79F2C11CB;
	Wed, 20 Aug 2025 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="aL5EOl8S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1336CE0E
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731362; cv=none; b=ll5mOVl7/7OufPqj7q+2YBp36u5jbY0fzkHrAvx3QME0lq6FRYR1hdwrir2joNF7OZpE1Zt8JfoRcKsSAxNqTLi5hnOfCq/GSeBk/ElIN8ds0V6iuMZzEZOjqlR89bWZNSq1Lc2SBKZNQGTa1/6vl4kGRge08iUrQGbitFX3RDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731362; c=relaxed/simple;
	bh=0MvkcO4mhSlpud9CTh58nSyQC+3/p6Nxn3ZWMBIjpXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGkRRX+yCgwCbUU0IBjt0qYVySGvzFzjJ8LHDN5oWND3ZxgYganykQJg/2mjZwT4KPUh6uSSyWCEUGxD2zDy1EtSCww+Ru3pvOwZ9khka3acouIbknTdmoOllJbWSO9H112Uvey2IzPcXAot889yQVRO44GnjyyEfxctBC0pFxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=aL5EOl8S; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e43ee62b8so309492b3a.2
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 16:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755731359; x=1756336159; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+tyuLMv7fowbfjD40sfmjyli4eEIuNfpbDs2bqEjHDc=;
        b=aL5EOl8SA+UBfAbOqMXqy1phBrMai2TFNbeFGPn00HNiOYJOPsAoRa5OyRuJfoVixN
         BiGcxPp/7iULrkZykRx6LQI6V2/ZANPrzmSSKV9tyXVg+18VAshuNVssM4RxU3I9h7ak
         5rPk0zHuumjXAMFMCgW5eJKFcubzjhlnqRVpTlQol47xL1wnLK5ECyIlJpYbwjixRUYm
         uGe/BjyL+rwZBvXCMjf43u0hOJVM0OmDbm8xq+qEDOx7mEsZztMewY6oxqRhyfExob6r
         I4C1QS5mvdSc0lJIARARnAqBEBon5BCyclGxz+6YSDTEDxtNJtEveNVmX58Ur8Nl5vfo
         /MXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755731359; x=1756336159;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+tyuLMv7fowbfjD40sfmjyli4eEIuNfpbDs2bqEjHDc=;
        b=M1YHGQlLy2q2t+F27vOLxKrv2USZ3EhsGrYR/nduGklprDVKQETjk0vcx6heKUJnCq
         b+LGj9WZOdDtCDNpplX9DfPAiqLWrYzMwQSnyDITrsXPzWkJVkg70OAy001/uUsz2rW1
         Bs7t3zzNJNjzCckTVc9xN6wuontcFHsVSVxMqyJtgUCzLDFIofDMKJMdXw0mkj/3hgmw
         C/Sxef2gWXkTaTqntnMTPQupcPu6+H4XkqkP6dgwvXltHLfwd9mgf64HihCkjlt4qIq+
         +2ZFgQISGMTVyHfLT/AtXJxCZVOb1u4gQeshh6N4lBTC29kWhCGn+dZg8y1+F7ap9Jpp
         n8hA==
X-Forwarded-Encrypted: i=1; AJvYcCW5ywdl1uz1n+xzwi7SgECbt68T9dYIZy8VvQNfX417eFuLRg+aeWoR+u55OG9rW/OM+lVO9dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYJV4RRWQfE1RQx7+/CmGQC5i3n5vbhAmC5UBozfZ/ZqkHS9e
	xGIn2TuP5VGW2K6EAo6RNKhbJ1NwczjAaoTP4u8q3JEoRB8YYPXfpC3iC1bcKY6fdzw=
X-Gm-Gg: ASbGncuhNtWdlQstL7Yl7Z01BtDnLj5HqW9D5eeBdUyyDjHe4LYWTH/pXNgScpNfbnL
	9hsf81oZIG3FYT4wHV7Nige4jTLJtcu173MGBMGpl9UDcWxWYuZTghPQzZr7KnVtYkGd61e33FY
	vXLW1FEmvrLD9pWyU70xzEK3BP1uyq2PWhWkxTLtQUKj8RvQIT76XNaNyb/s5bXsvSOTfGz6eAh
	laQ9JYa2GQev6Qvp9Yr6UeFrdpKmvI8evAE1NOJk5JCqnL26D4nkFn4atGq0y5fqjFhd1bYJjKN
	kNzELY/Zu936LAZw8zKyqScYHFWyhTnnhKl5EscUtFG6eIt+uyiBusuMZdCqtkRtkcyUaxrkrwA
	S5+Dl2bfdMKx3KahSZRlb0Tnl
X-Google-Smtp-Source: AGHT+IFTC4LLt5KycWqz0CRruTcc9AAbBVXRBu/bAtT4l8lBZAyrQijVfp3CZ6NeR2DmzF+sRssJQg==
X-Received: by 2002:a05:6a20:6a0f:b0:243:78a:82ac with SMTP id adf61e73a8af0-24330ab8681mr356174637.52.1755731358637;
        Wed, 20 Aug 2025 16:09:18 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f76b5sm6286301b3a.59.2025.08.20.16.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:09:18 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:09:15 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Michal Schmidt <mschmidt@redhat.com>, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Ivan Vecera <ivecera@redhat.com>, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] i40e: Prevent unwanted interface name changes
Message-ID: <aKZVm-0iiMsUfexu@mozart.vkv.me>
References: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
 <CADEbmW100menFu3KACm4p72yPSjbnQwnYumDCGRw+GxpgXeMJA@mail.gmail.com>
 <089ba88e-e19d-40eb-844d-541d39e648e8@intel.com>
 <aKXzzxgsIQWYFQ9l@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aKXzzxgsIQWYFQ9l@mozart.vkv.me>

On Wednesday 08/20 at 09:11 -0700, Calvin Owens wrote:
> On Wednesday 08/20 at 11:41 +0200, Przemek Kitszel wrote:
> > On 8/20/25 08:42, Michal Schmidt wrote:
> > > On Wed, Aug 20, 2025 at 6:30 AM Calvin Owens <calvin@wbinvd.org> wrote:
> > > > The same naming regression which was reported in ixgbe and fixed in
> > > > commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
> > > > changes") still exists in i40e.
> > > > 
> > > > Fix i40e by setting the same flag, added in commit c5ec7f49b480
> > > > ("devlink: let driver opt out of automatic phys_port_name generation").
> > > > 
> > > > Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
> > > 
> > > But this one's almost two years old. By now, there may be more users
> > > relying on the new name than on the old one.
> > > Michal
> > > 
> > 
> > And, more importantly, noone was complaining on the new name ;)
> 
> I'm just guessing with the Fixes tag, I didn't actually go back and try
> to figure out when it broke. Let me double check, it would certainly
> make more sense if it broke more recently.

I actually checked, it really goes back that far.

> But there are a lot of reasons I still think it should be fixed:
> 
> 	1) I have ixgbe and i40e cards in one machine, the mis-match
> 	   between the interface naming pattern is irritating. Can't we
> 	   at least be consistent within the same manufacturer?
> 
> 	2) The new names have zero real value: "enp2s0fX" vs
> 	   "enp2s0fXnpX", the "npX" prefix is entirely redundant for
> 	   this i40e card. Is there some case where it can have meaning?
> 	   I apologize if I'm glossing over something here, but it looks
> 	   entirely pointless. If it solved some real problem, I'd be a
> 	   lot more amenable to it.
> 
> 	3) It's a userspace ABI regression which causes previously
> 	   working servers to be unable to connect to the network after
> 	   a simple kernel upgrade.
> 
> And, at the end of the day, it *is* a userspace ABI regression. If it
> matters enough in ixgbe to warrant a *second* userspace ABI regression
> to fix it, I think it warrants that in i40e too.

I just want to be clear: I'm not here to whine at you all about having
to spend ten minutes fixing some configuration files. My goal is to save
a bunch other people the trouble of doing it over the next five years,
if it's not too late.

If it is true the majority of i40e users have converted, than yes, this
should stay the way it is. I'm *very* skeptical that would be true only
19 months after the release... but I don't have any real data to argue
either way.

> Thanks,
> Calvin


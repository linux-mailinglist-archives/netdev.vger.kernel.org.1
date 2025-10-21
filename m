Return-Path: <netdev+bounces-231082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF2ABF491B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 06:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17778462AF3
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 04:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28E223AB98;
	Tue, 21 Oct 2025 04:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGxhb3mW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1211EB193
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 04:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761019423; cv=none; b=QzKafQ1oVK38nwu4WQSDbgWiKmrsHoA0v8DZC2EuIG/C+LfQQzK8Bh8owg1tGWGXbEb635RMz246AbFcOI277tVLs7gHT6GKuLUMRiByN70PENg8hOCgJIf+/4BtBHMU5DBeHsBtqRrkQPo4c/pbnqfCLYlNqPrw9tMHZbO7OV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761019423; c=relaxed/simple;
	bh=FGw9uKLVYLz8Atlzf9NPOuGFgink3pTJjbUmcWekYM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfjqTpOB79nEMa3bypGifoBr1Ty26ZO8d9VjVhrTS8Rm9TtVwmWdv9BLZEfV1CFkizH0Yn6Txe3rf4uTfTlNBmoo1/+wHAvGvXx+JMIRgo84Dx/Jm/qNurDMwyj2ZhIgOTnn1S0tjhRwziEYIUDiJ2kaymEFHdg7VhtWy32hjRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGxhb3mW; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso4448535a91.0
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 21:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761019422; x=1761624222; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CzjId5UhLzcQWxSkjMlTd353fisikKEHJ9Xlvn4jmOs=;
        b=VGxhb3mWnVIiQCZZfA8VgNgnCKZvHnfLJu+Hy9mFVGyw1dFSfmM27GUBl1AyZAaYl2
         JFhiYQ2yEfWmn5CJH/MM9Edr6miIKotEna3xyIu3K2k1a0FJVg9z+gLIgZtmFZ6XRHGU
         IRvBt5tiaEDuQKpCjpIzhlCNtTwaIN+yb/WdTe6gC+NcZOPG6Lqw4FF29WemTl0XrPpv
         67h1Ex2dWfa5YxijOanGIgeFHBHz1hBlWEq6sXKoU4RIzQy3GJ/rIkG8YIY1I1xgycC2
         p5pI9H9vwdV0LW4hbYUatf3ICrNoKaj5KgVcZXGx1oj0vwMpejd9k8W3gIkjKOwpR8nI
         JzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761019422; x=1761624222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzjId5UhLzcQWxSkjMlTd353fisikKEHJ9Xlvn4jmOs=;
        b=MjVpOehOX/iewcsqUZMAy3ibdHHn3MgOHTqVTTj7dAYxIrv3A40MeyA98X87PkmmFC
         Pk74Fkf/PpITUpm1lYoh2xrETURanN4/n8Z6pmkvPK0+CFROh6VtDzFsckIdey9knQp8
         cBWejx62DHfpY9pc630mmkZvppE6ZnSObQuiNuNPq6cEzGHCO8zu3X5Wx4yP9bStydPg
         9D3HzrEuGXqMvAgdOBSfqfqcLxGyoTRLa00ZVqUrni/yIF3v4RljKLHOSmE8+zgfd0S8
         le3iwEoZJMxrq3nC/rrhohBp5K1sIwa2HLYTLWZDfE1ERGhyGgMnx7TZ5XpZKe5cytI8
         PCyg==
X-Gm-Message-State: AOJu0YywRd4ySW4+BJ9M9ZBu+2MWKq5CWc1/Bvq+cOzXgLAT4rpyvbDh
	IF0KgRhKT/bR+mHR861sxpfjS/hv3GxlTWymTVbtxCkI8hBCv7AybXuz
X-Gm-Gg: ASbGncusul4gzQA9dKASxHwl7pOfI0hWfAOtR1DNbiGAyJ8cYEgDjo0stpaJBF9X4qM
	eAH9TBlCZqMhtgodprNKG8FAHHeyqqSGr5TV5PwINh/Q/9SCyoER9IdAMNP9LqdgrOwVS4k/3Sv
	sOb0VOvpd0cIK0aR8csxd1bb47IUSxvdok1jUBTmcv4y3GzNjFN+M1h3F57E+1tTY8gK37Q7Oxs
	B3weojzI9Hjx5OYtvrAhIIFHFnPSOZ8uzeVPo3nDqSfkzMKLkhHM3yzawn+u+5s1LKkqds1gCGj
	uLM+p9Zln/L6kispNSSARq/2HbAkVxpvw2jk8f0NshzL/kzxcFJ6AJVoCTE+ugAfRklLpH99xZ4
	pEuPdzrI3qy0VKCnBJioCWHJUZKfeTTNucsayrofWdZOpdW94CSMgw8Sv2s6Xd/DUTvnr4TXFk6
	HALaH1aIQA0SjD2BI=
X-Google-Smtp-Source: AGHT+IEGLHBHLBcEiZkt0e0q2lpyK6XnA2EHB5p+AIeBPMFAHNsp8qccXxyZON/4GBnP34d68j285w==
X-Received: by 2002:a17:90b:4cce:b0:32e:dd8c:dd18 with SMTP id 98e67ed59e1d1-33bcf8f7617mr21437755a91.17.1761019421547;
        Mon, 20 Oct 2025 21:03:41 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5df93591sm9771411a91.17.2025.10.20.21.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 21:03:40 -0700 (PDT)
Date: Tue, 21 Oct 2025 04:03:31 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev
Subject: Re: [PATCHv6 net-next 1/4] net: add a common function to compute
 features for upper devices
Message-ID: <aPcGE36U9DSza8xU@fedora>
References: <20251017034155.61990-1-liuhangbin@gmail.com>
 <20251017034155.61990-2-liuhangbin@gmail.com>
 <aPX8di8QX96JvIZY@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPX8di8QX96JvIZY@krikkit>

On Mon, Oct 20, 2025 at 11:10:14AM +0200, Sabrina Dubroca wrote:
> > +/**
> > + *	netdev_compute_master_upper_features - compute feature from lowers
> 
> nit: I'm slightly annoyed (that's not quite the right word, sorry)
> that we're adding a new function to "compute features" that doesn't
> touch netdev->features, but I can't come up with a better name
> (the best I got was "compute extra features" and it doesn't help).

Ah, yes, the term "compute features" can be confusing since we don’t actually
 update netdev->features. We can rename it if there’s a better alternative.

> 
> > + *	@dev: the upper device
> > + *	@update_header: whether to update upper device's header_len/headroom/tailroom
> > + *
> > + *	Recompute the upper device's feature based on all lower devices.
> > + */
> > +void netdev_compute_master_upper_features(struct net_device *dev, bool update_header)
> > +{
> [...]
> > +	netif_set_tso_max_segs(dev, tso_max_segs);
> > +	netif_set_tso_max_size(dev, tso_max_size);
> > +
> > +	netdev_change_features(dev);
> 
> Maybe a dumb idea: I'm wondering if we're doing this from the wrong
> side.
> 
> Right now we have:
> 
> [some device op] -> [this new function] -> netdev_change_features -> __netdev_update_features -> ndo_fix_features
> 
> Would it make more sense to go instead:
> 
> [some device op] -> netdev_change_features -> __netdev_update_features -> ndo_fix_features -> [this new function]

Since we actually doesn't touch netdev->feature. I think [this new function]
and netdev_change_features() should be in parallel relationship.

> 
> Possible benefit: not forgetting to fix up the "extra" features in
> some cases?  (ie calling netdev_change_features when we should have
> called netdev_compute_master_upper_features)

That’s a good reason to call them together. However, ndo_fix_features is used
for computing new features for later use. Since we both compute and set them,
maybe we should put this in ndo_set_features instead?

Thanks
Hangbin


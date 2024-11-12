Return-Path: <netdev+bounces-144177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A152D9C5E92
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6787C282996
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 17:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2715120E03F;
	Tue, 12 Nov 2024 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SOYNY2Ef"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6820920DD7D
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431555; cv=none; b=JsFZFEI2aM3lJ7etZ9Y3xB9OfOxwK7EcrP69/eGWzuEatgmXRnJtMWEAVQURHfk6anKhbNWW0LCLhw0N1NWlP/7GeLrwgEq5gyb3/C7HlFVZQbvP58TDnsPqrflfchV1NP+VkCCLC4zwL07+l2EYDLvkVD62jd/x/kxaq3ufyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431555; c=relaxed/simple;
	bh=TdzpcklWfEhp7EcpvlOKYcfJ97+wlSHkK4bmooydx5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnKdVEK9Xw5EMfGWPMt/45weMUnlmI+iGWobmOjGS2H3KRMf+k84+1tzRwY07/J/0df0z34v8dQuLzrmXnCIXXKSop6SuKZz1MtTdWKPZt8O4QiSBLsiUZEESgN3ZXHI+2TTjwMg/4pKM5v+WuBAf1CSexFhooTxckbIQUzAzDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SOYNY2Ef; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7f46d5d1ad5so1066830a12.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 09:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731431553; x=1732036353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmPMChd4WbEPTL5e81SXkrz17ths1pwbljRI9exq6GI=;
        b=SOYNY2EfzWWyz3qwP+Pl/alNhhwk9yYxIhq3AI/ycip2oBPNuod92vSi5v5/OKm8L5
         8ywQLtIF1HV/XSZD6S09m7A0jWzGtseeoGaVs/CFlWVXlvNrXq2gC37J4BZcWMx51gh1
         bU+AMocF6A689zXw3bzWl8QZlHi1gGgBhbUy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731431553; x=1732036353;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmPMChd4WbEPTL5e81SXkrz17ths1pwbljRI9exq6GI=;
        b=eyHGaE6gIbtg4qH+Ge3CbgGHTJmZ3nFmUc02OMs9hndI6N+NJfDPJWZYOJ9UVKzDWB
         H0moE932Pf7lXJriumu7+i0rNS9P+1MXNIJ5k0mjSwi7MvisH0SSpgqNAYQhzaGYrhpj
         aOO0ym8vcW2RzPkLuTqVLe2DHxfklg4UogZ5Vkyqd4anYStABcR5ZJV1O30pgj714swr
         e9TdlbVxYIeCbbmJbgHdehlCAihGhhqf0Kg3HoPQccxZzdYOsxvx1RLCdpj59t8vKRqB
         9q8tfu1YUKkkICx6BGfVi/nH3u/x7+cJcOpKDEKjBwKIrH4+Qo+woaEfUubVyCbGlKeA
         JXaQ==
X-Gm-Message-State: AOJu0Yz24U/n26jf9mzu5ca+06sgICPKGGcUvVHsSr2gDMa3lLMQtOYC
	1XELP27RUwUmXD7I2B9DAU59xgpi/ORwjxlqC04fl+bp8JfQnIgYk1y5uPjqkxA=
X-Google-Smtp-Source: AGHT+IEiTYFVdPTb3PjYCmKuSEFa48d0HpO+EW8w5bhH4jOmBmAPg32KlL9egQP6+QW0TVexRc9bLQ==
X-Received: by 2002:a17:902:db09:b0:20c:8331:cb6e with SMTP id d9443c01a7336-2118350cf44mr234478795ad.19.1731431552570;
        Tue, 12 Nov 2024 09:12:32 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f52cacsm10867477a91.6.2024.11.12.09.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:12:32 -0800 (PST)
Date: Tue, 12 Nov 2024 09:12:29 -0800
From: Joe Damato <jdamato@fastly.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	edumazet@google.com, Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v6 6/9] netdev-genl: Support setting per-NAPI config
 values
Message-ID: <ZzOMfec9pRhfua-6@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	edumazet@google.com, Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241011184527.16393-1-jdamato@fastly.com>
 <20241011184527.16393-7-jdamato@fastly.com>
 <719083c2-e277-447b-b6ea-ca3acb293a03@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <719083c2-e277-447b-b6ea-ca3acb293a03@redhat.com>

On Tue, Nov 12, 2024 at 10:17:40AM +0100, Paolo Abeni wrote:
> On 10/11/24 20:45, Joe Damato wrote:
> > +int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +	struct napi_struct *napi;
> > +	unsigned int napi_id;
> > +	int err;
> > +
> > +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_ID))
> > +		return -EINVAL;
> > +
> > +	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
> > +
> > +	rtnl_lock();
> > +
> > +	napi = napi_by_id(napi_id);
> 
> AFAICS the above causes a RCU splat in the selftests:
> 
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/856342/61-busy-poll-test-sh/stderr
> 
> because napi_by_id() only checks for the RCU lock.
> 
> Could you please have a look?

Thanks for letting me know.

I rebuilt my kernel with CONFIG_PROVE_RCU_LIST and a couple other
debugging options and I was able to reproduce the splat you
mentioned.

I took a look and it looks like there might be two things:
  - netdev_nl_napi_set_doit needs to call rcu_read_lock /
    rcu_read_unlock, which would be a Fixes on the commit in the
    series just merged, and
  - netdev_nl_napi_get_doit also has the same issue and should be
    fixed in a separate commit with its own fixes tag.

If that sounds right to you, I'll propose a short series of 2
patches, 1 to fix each.

Let me know if that sounds OK?

In the meantime, I'm rebuilding a kernel now to ensure my proposed
fix fixes the splat.


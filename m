Return-Path: <netdev+bounces-134321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A64F998C91
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586DC1C24506
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EB71CCEE3;
	Thu, 10 Oct 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="AQ5s48re"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725811C9B63
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575976; cv=none; b=ZMkafNZwiL1g9t4CwpxUapw9robrJcWSLUhzeA9qO8bcDbyGIV7WUvAKSJAX8dfN5WWUOqW6WZ4l1jGsTQo/hcoy3CytOeedfVp00wlsqPch7O7IHG2u48yi6TBQL4MJ65GwdbsrV0becC14tAvN8Cu3XIHfjiuWTvi8xorf1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575976; c=relaxed/simple;
	bh=PfZeNcFw1bT/pN+WBxONE28O+RahXMikU7YuitEDd84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJYNFYjhRaUEsZi9C6UeT0dShxa72PHNtSrbZtb9q5fHBMTVIBfIcyW+2pOWEScaWQBm05cAimLfCBGPlVMaF9nV4jXK0xa7ZMjFQFIG0HdvIU+YIaU3g8sa1sH3+K3m3vIBvgJilvNt2aMbKvEgcD0YWvm3SnWkCgMVtQs0tnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=AQ5s48re; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e039889ca0so621825b6e.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728575973; x=1729180773; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yeku9+EKhD0eyLZNLUrY1WzCvsvKi1BJ6gq9NUUHrtQ=;
        b=AQ5s48rekCCbw87iaHEPqcoXvyhDm9vluE6oNylcuF6w+wuBxJVKv56ryVuJkFKOa5
         ri9P2mcx05hSIH9qyyi92wKEmr6ZD21ffUSYSr+j0NtQhMirHt/IruIgViA8nYqTHJ6x
         32mpUl8ubnnI42uggIv3yr8QWFwAoYqcZGvmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728575973; x=1729180773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeku9+EKhD0eyLZNLUrY1WzCvsvKi1BJ6gq9NUUHrtQ=;
        b=lJMh26X5PmLwMWkzlW+hTzipkwjSvt1f6xrphQUu/7on57Jmhq/59HGBUCTV9dXgGj
         rgXHEjtuh4RUlfANDA8OUy2d1Yk6KQKqVhQXmJxnwO5uItE8yIeg2DZM01mZB4ZLPKMR
         A9PlwkOkfyE5IXlp048gF5H16qILkIbnt5F0rSU1iYZNNV0rA43JN0L8JASMHcHa4k77
         8H8qqf6hN7q6FXrE+P2T1s5FxBYoWGFEhHxqJ6AL43pnoYFu17D46deb+TIE6qpwkoDY
         rRz7zGiqLLb2eIjZ8KwwUO1OUdcGRTyDzCeqLZyUCXuJnPUB+17bWwpKqsTSjS2uzHQB
         eJTA==
X-Gm-Message-State: AOJu0Yypau0wZBXvmTUKycILluCneDjl6MSuumGKIUsn0Ahh3JlhOTRE
	8bvouWS32M0uikNf/nwQWJSlgT4G31CZbTduybWBWYXLPHzdI3LUMxJYCHzaFBY=
X-Google-Smtp-Source: AGHT+IEtL6WXGzPYuh+MnBkT5NJl2Cl0DdJhepAOU04VKXDoCawCLBlrMQZVO/pkGBZrqJMIhISK1A==
X-Received: by 2002:a05:6808:1918:b0:3d2:18c1:bf35 with SMTP id 5614622812f47-3e4d71beaddmr4147622b6e.33.1728575973406;
        Thu, 10 Oct 2024 08:59:33 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4495d331sm1152526a12.60.2024.10.10.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:59:32 -0700 (PDT)
Date: Thu, 10 Oct 2024 08:59:29 -0700
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v5 5/9] net: napi: Add napi_config
Message-ID: <Zwf54UVvfyx830sk@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241009005525.13651-1-jdamato@fastly.com>
 <20241009005525.13651-6-jdamato@fastly.com>
 <CANn89iKytfwyax_d+7U8Xw-Wvj5z1d7xoi4LNhmUQphDiborDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKytfwyax_d+7U8Xw-Wvj5z1d7xoi4LNhmUQphDiborDQ@mail.gmail.com>

On Thu, Oct 10, 2024 at 06:20:57AM +0200, Eric Dumazet wrote:
> On Wed, Oct 9, 2024 at 2:56 AM Joe Damato <jdamato@fastly.com> wrote:

[...]

> > +
> > +static void napi_hash_add_with_id(struct napi_struct *napi,
> > +                                 unsigned int napi_id)
> > +{
> > +       spin_lock(&napi_hash_lock);
> > +       __napi_hash_add_with_id(napi, napi_id);
> 
> Hmmm... there is no check if 'napi_id' is already used and hashed.
> 
> I would add
> 
> WARN_ON_ONCE(napi_by_id(napi_id));

Thanks for the careful review, Eric.

I agree that adding this is a good idea and I will do so for the v6.

Jakub: I hope that it's OK if I retain your Reviewed-by tag as the
change Eric suggested is a minor one?

If you'd prefer I drop your Reviewed-by from this one, please let me
know.


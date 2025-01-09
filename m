Return-Path: <netdev+bounces-156749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DC2A07C2E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3486E7A3DA4
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1222A21D011;
	Thu,  9 Jan 2025 15:43:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2821921CA1E
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437431; cv=none; b=INbNqD2/dxRkg7YtWDmdkc83E2T8fzxDTvx6GotKLzBy9cloT+af6jRRAXEfHpV1aliXcLWLoM3o/ZFE4WaHLmGwf0P3+Ddz78SSjaqUzwt1IXfuCArAJ4cJqo5y6R31OnLsH2MyIRFiacE/KFMJ5fWFmNlr2PhlPj8TSKH+SGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437431; c=relaxed/simple;
	bh=5p2r9SS1SGIbQHLhhZLP3Pec6ZYcA5M/qieUa07qiT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPlRGpvJ8Z7kkqdTmSSM6y9Skc8t+NGSGYkmK00QA+7B/20Kr5RBbW0S9BHUgBkrpRFMfnTCYRCDlk08C7LK4dlxlRnw7SFL3RPGI9LS27QyqGo2TA5LAbsGLZ7OCU9ttaXTL0ojccSzIaybBNmNJSrPezJ3Cn0+c1TV+QYZuhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so1457116a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 07:43:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736437427; x=1737042227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khP8+ltKDGelTiS2ZFWAn+MUEtAnmIpQ/BxNljP04bc=;
        b=sd4azortEmYesUPheZz1O9wyiJG9oFq2S91rWaCNSaOEXrs7j0BoPMEXc/BTJPY+ng
         cUGX6zGNFRJBZV/a2RflH7hTqUs6rYqBYryZ6Zj4RwE0AM2bMukqk1nbnZ/WCs00Q5GP
         eltX1En43cHxvNm/M50UIJrbG0AWqZ4xKQ/SzKLgyNarWk99x3qzx6KAgBG3mDiEJtN9
         8HlXCleV87M+btr61I63R+ps3a3WqAopr+Xox9w9L2vp1w2coOStuVTsckuw1a9W0U9R
         FmDRXyMQfNXChMNN9MKFIShG4qDQIpJIGCZCf6ofZ8MbzJnASNgw+iBoKsKtjsMufyXX
         S76w==
X-Forwarded-Encrypted: i=1; AJvYcCWslrvJn20I/ScazFLTILXWve/bvcXxLGfvWKmsScgluV6FZ/vGWzL8H8HQZ2D1to+bG646pzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYVUvAxSrtyHNVCtfl8+5CnCRjF8booTQzEI4AhlP6ezV7sIpi
	6RXIQmVsVgR2tOtvDO2l3L+5ujORaidWsDyLoBBl5l/zyrrRmPd+
X-Gm-Gg: ASbGncuA8TVkIHWPyd9dX8I2M0US9LEyrN9SaPD4XaBecxd7VEemMoBOHtMw1IFS+P5
	7P2k9nkK9fNAvmi/jjW5LfVe8WCg+Vi0hg2WRW1ec4X59s3tarJbcQF9nVjcwRN7RdxtdaUBmx+
	t/UvHvRly8rF3uN6ysznkKy9GFDvTWTcMLPpQoRwLj5Z47/yXWZ62yz35frbVcXLisHtGU4PGXB
	OVQG6W92pJsu2c0UEUsGF5dFZBFMVJY1ztR2FMB2g2eSZ8=
X-Google-Smtp-Source: AGHT+IHkvt2WBIW+pG9OuHuA1oBUs0ZBpj3ZofS8m6hZ8KBB9qT6OHVjWOQUJF6JTN45SZF7Z5D/4g==
X-Received: by 2002:a05:6402:40c1:b0:5d1:1064:326a with SMTP id 4fb4d7f45d1cf-5d972e1c39fmr16480363a12.15.1736437427075;
        Thu, 09 Jan 2025 07:43:47 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9645408sm81400766b.166.2025.01.09.07.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:43:46 -0800 (PST)
Date: Thu, 9 Jan 2025 07:43:44 -0800
From: Breno Leitao <leitao@debian.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] netconsole: allow selection of egress interface via MAC
 address
Message-ID: <20250109-nonchalant-oarfish-of-perception-7befae@leitao>
References: <20241211021851.1442842-1-ushankar@purestorage.com>
 <20250103-loutish-heavy-caracal-1dfb5d@leitao>
 <Z36TlACdNMwFD7wv@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z36TlACdNMwFD7wv@dev-ushankar.dev.purestorage.com>

Hello Uday,

On Wed, Jan 08, 2025 at 08:02:44AM -0700, Uday Shankar wrote:
> On Fri, Jan 03, 2025 at 03:41:17AM -0800, Breno Leitao wrote:

> > This will change slightly local_mac meaning. At the same time, I am not
> > sure local_mac is a very useful field as-is. The configuration might be
> > a bit confusing using `local_mac` to define the target interface. I am
> > wondering if creating a new field might be more appropriate. Maybe
> > `dev_mac`? (I am not super confident this approach is better TBH, but, it
> > seems easier to reason about).
> 
> Do you mean creating a new field called dev_mac which replaces
> local_mac? I do agree that naming is a bit better but I'd be worried
> about breaking programs which expect local_mac to exist. Having the
> field go read-only --> read-write via this change feels a lot less
> disruptive to preexisting programs than renaming the field.
> 
> Or do you mean creating a new field dev_mac which will live alongside
> local_mac, and letting local_mac keep its existing semantics? It feels

Right, that is what I meant originally.

> like that would lead to messier code, since dev_mac's semantics are kind
> of a superset of local_mac's semantics (e.g. after selecting and
> enabling a netconsole via dev_name, local_mac is populated with the mac
> address of the interface and we'd probably want the same for dev_mac as
> well).
> 
> A third option would be dropping the configfs changes altogether, which
> I'd be okay with - as I highlighted in the commit message, I suspect
> this interface is far less likely to see real use than the command-line
> parameter. 

I like this option better, in fact. I agree we don't need to expose it via
configfs (at least for now), since configfs configuration solves a
slightly different problem.

> A downside of this option though is that automated testing
> becomes difficult, as we can't write a variant of netcons_basic.sh

True. I _think_ it is better to optimize for simplicity in such case,
and skip the configfs changes (at least for now).

> without configfs support. We'd have to have a test which uses the
> parameter directly, and I'm not sure if we have a testing framework for
> the kernel which would support that.
 
 I am wondering if we can test it by turning netconsole into a module in
 the test .config, and passing the netconsole parameters when loading
 the module? 

--breno


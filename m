Return-Path: <netdev+bounces-162070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A68A25A7B
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE3A3A8105
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C5D2A1A4;
	Mon,  3 Feb 2025 13:12:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687C9204C3D
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588364; cv=none; b=OWIzP7+uLW3T5/QY4E2mZkxnriO7jy0CRZ4EMTXK3sn56TJnbaRs6a1C96FrsR9IndIOzJO+Q+C+TSgBCEyFqMfXr62zJFdtJQU7DRqvYCW4U71eCuARSZu6NkZi+DF9yBI8ZjIk9pOw1C4rWm+FNfyUn+VE0eZQtwcJsxFXhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588364; c=relaxed/simple;
	bh=bl/VsZhd4GDU41uemUdBWY4YlWnCmFJSbM7+BNNjyZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVS2dQrmYs5Q6TL4DznfNXTV/dAlLejyIBjfZL+CBFO0CH9bkxDBbsK/WK3ZO7s7FunaWY0NXTXVKHivc0FNA1hYuAvKB4fH5mEijzh9MgxsmAKVHNGGdaobKVvEsUzpYgg9+BCAS/0o/2ukiSCCGbs6sfsisqiL/xBl3Oj09FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso4666564a12.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 05:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738588360; x=1739193160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmO++Dj5YclSEoKZ+SbNGgyDOSbX9fIMMJINUFzxHVM=;
        b=G4/zfiSiyAG9lijHOz6ww/Q7WzVfpCt55m30W2GvsnZY6g8jeQzHqRrcoOP2Nf3qiy
         WMoH45MsCZ5NGa3FhhBPsd+wQo7jg4Do7A9uD9h+X82gGzK7xuGEMNXUJ7d+5IGXLhhi
         rfY9lZqK70TCqALqFVoqpeenzSdVPiReIo36EuxTx4P6+S5bDqdcXfeAiZcFDaF/5d3O
         X7s+NFbFQt43wRdrmYSwZe2thUpsWzpJtdIIletHXpGvUgRctwW8OPlH97EHBdJ0h3IK
         v6e9ZmolH5NyQLWHVB6fM5yaFzCvAhirhH7sLFmwMuRxoNBIf3KDv9SMA5V1eQN7T/sh
         Yp6g==
X-Forwarded-Encrypted: i=1; AJvYcCUChdQ2R+9hLssLPaOnnQQmRgDisVPNz7bk6fcmXEC7YPzki5jez1DO5wk1iiVxZL2/X8NaxoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsISewHfQQPGP2ImDJ0BQfyDScT4KFurWVAhT4LcVFQ5ueW7yt
	T+e76Xql8bNmM4RcsbCdGNXCWbQjjJSfJwiJg4rK8A8IyDBemqep
X-Gm-Gg: ASbGncsRwHEJSkw/2vf2DRoHUqYoW2VGCD2EFwXo8xwc5eIY8X+wmsiX1Ny89p7k2HA
	6PQV15p6RU2jm4DrvivAUGrCffFtAWHYoZQFXUli1vJ36g+BfS2EpMjF+Yzq0FFzLLIhNGlf0be
	hUNxuiR6cpmonD6mkNehgiInNg/NUKOmwEdCisHtOKLWqoY7qh9eZzYPw0yWXQpmFkPAwo9sUIc
	OshYEDOvhVbx+Fzd3Q+/We4cbb0bF4oy51gTz9cmU93wNV2mU7G03oFtRDlZI3Vd3mUljNTrpM1
	EseslA==
X-Google-Smtp-Source: AGHT+IEWKF+QiDVeJdsH8PK6F8uux9rFuNxvC+iEqMRMNJNgJGvuxz8HfmeE84fVYinTxgJgTGBkEg==
X-Received: by 2002:a05:6402:2710:b0:5db:f26d:fff1 with SMTP id 4fb4d7f45d1cf-5dc5efe74b5mr21897380a12.21.1738588360240;
        Mon, 03 Feb 2025 05:12:40 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724be323sm7709910a12.65.2025.02.03.05.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 05:12:39 -0800 (PST)
Date: Mon, 3 Feb 2025 05:12:37 -0800
From: Breno Leitao <leitao@debian.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH] netconsole: allow selection of egress interface via MAC
 address
Message-ID: <20250203-capable-manipulative-angelfish-bebe71@leitao>
References: <20241211021851.1442842-1-ushankar@purestorage.com>
 <20250103-loutish-heavy-caracal-1dfb5d@leitao>
 <Z36TlACdNMwFD7wv@dev-ushankar.dev.purestorage.com>
 <20250109-nonchalant-oarfish-of-perception-7befae@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-nonchalant-oarfish-of-perception-7befae@leitao>

Hello Uday,

On Thu, Jan 09, 2025 at 07:43:44AM -0800, Breno Leitao wrote:
> On Wed, Jan 08, 2025 at 08:02:44AM -0700, Uday Shankar wrote:
> > On Fri, Jan 03, 2025 at 03:41:17AM -0800, Breno Leitao wrote:
> 
> > > This will change slightly local_mac meaning. At the same time, I am not
> > > sure local_mac is a very useful field as-is. The configuration might be
> > > a bit confusing using `local_mac` to define the target interface. I am
> > > wondering if creating a new field might be more appropriate. Maybe
> > > `dev_mac`? (I am not super confident this approach is better TBH, but, it
> > > seems easier to reason about).
> > 
> > Do you mean creating a new field called dev_mac which replaces
> > local_mac? I do agree that naming is a bit better but I'd be worried
> > about breaking programs which expect local_mac to exist. Having the
> > field go read-only --> read-write via this change feels a lot less
> > disruptive to preexisting programs than renaming the field.
> > 
> > Or do you mean creating a new field dev_mac which will live alongside
> > local_mac, and letting local_mac keep its existing semantics? It feels
> 
> Right, that is what I meant originally.
> 
> > like that would lead to messier code, since dev_mac's semantics are kind
> > of a superset of local_mac's semantics (e.g. after selecting and
> > enabling a netconsole via dev_name, local_mac is populated with the mac
> > address of the interface and we'd probably want the same for dev_mac as
> > well).
> > 
> > A third option would be dropping the configfs changes altogether, which
> > I'd be okay with - as I highlighted in the commit message, I suspect
> > this interface is far less likely to see real use than the command-line
> > parameter. 
> 
> I like this option better, in fact. I agree we don't need to expose it via
> configfs (at least for now), since configfs configuration solves a
> slightly different problem.
> 
> > A downside of this option though is that automated testing
> > becomes difficult, as we can't write a variant of netcons_basic.sh
> 
> True. I _think_ it is better to optimize for simplicity in such case,
> and skip the configfs changes (at least for now).
> 
> > without configfs support. We'd have to have a test which uses the
> > parameter directly, and I'm not sure if we have a testing framework for
> > the kernel which would support that.
>  
>  I am wondering if we can test it by turning netconsole into a module in
>  the test .config, and passing the netconsole parameters when loading
>  the module? 

I wanted to check in on the status of this patchset, as I haven't
received any updates in the past two weeks. I remain enthusiastic about
this feature and believe it would be a valuable addition to the next
major merge window.

If you need any assistance or support, please don't hesitate to reach
out. I'm more than happy to help.


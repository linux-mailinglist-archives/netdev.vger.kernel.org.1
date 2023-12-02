Return-Path: <netdev+bounces-53228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC540801ABA
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 05:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34FE1C20AE6
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 04:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6188C17;
	Sat,  2 Dec 2023 04:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iSCU+o24"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4B9D48
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 20:39:47 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cde14ff73bso2288594b3a.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 20:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701491986; x=1702096786; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Y6F/avy73hBdHBfGZhJm2X6H2KWeohwE7b2q/RCBhw=;
        b=iSCU+o241H1kCkeCYWpFLy2r2uzCWe49UkV+VaLP90OcfaAj1vTJ4d3EbfmX622+7M
         dDpB+xco/Hg3NwLEZYw0/JFjQYbLhyQtA5Y9nHXzzPuOiVCWPp/uGpmB3rzL17ere0Pw
         XO+DaAYeyVMS6brG2XVU+u+wzpJV2LyTvZXw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701491986; x=1702096786;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Y6F/avy73hBdHBfGZhJm2X6H2KWeohwE7b2q/RCBhw=;
        b=MDdk3F6waX78U0qYPVQbK19Rjljyx3TdsL/4by2elvR5+PliThc3R21eDgzAVsHG0e
         TOmOXjI53mFSOxh8bz42HVW5KYyGQxu8oEnr09e7RtCuTgHE1/BVkNqJKQ0FDiR9KBYF
         9wwht+kqRlVHLAMfRc8lmqFZnZuvnU1RcrGU78/IJVl6lA2t7kZbAc+Ljmr/h2WSZYvR
         PRD51q4b6EI2zBLuQBGPF/fQecfXi9CR3lo2MM1igM8DfNHbAdgZzxHzTHyXIKEampxp
         u23WR7Rk9EilMAb6AOF2n/vTxJH9yuvmR5DjFcRK11vfRS6ucDIbJf9Kmqih4DGgAf2K
         o3bg==
X-Gm-Message-State: AOJu0YxmDE5glIvh2rNz+1ZiL+KrRga91wdA1H1nfprmZoltFg2G4d0x
	n5Q2cMN8JxN5vKJT9nDXs4dapQ==
X-Google-Smtp-Source: AGHT+IH/BdewRMQ/fzaT4gRUZfAvLUViODtXGwcWXeQUBcu4ap+HfQc5J3caVqaEYx2QUqjXLsHQUg==
X-Received: by 2002:a05:6a00:180f:b0:6ce:2757:7858 with SMTP id y15-20020a056a00180f00b006ce27577858mr746645pfa.19.1701491986409;
        Fri, 01 Dec 2023 20:39:46 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x13-20020aa784cd000000b006cde2889213sm3848668pfn.14.2023.12.01.20.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 20:39:45 -0800 (PST)
Date: Fri, 1 Dec 2023 20:39:44 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Michael Walle <mwalle@kernel.org>,
	Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netlink: Return unsigned value for nla_len()
Message-ID: <202312012026.A0178237@keescook>
References: <20231130200058.work.520-kees@kernel.org>
 <20231130172520.5a56ae50@kernel.org>
 <202312010953.BEDC06111@keescook>
 <20231201104505.44ec5c89@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201104505.44ec5c89@kernel.org>

On Fri, Dec 01, 2023 at 10:45:05AM -0800, Jakub Kicinski wrote:
> On Fri, 1 Dec 2023 10:17:02 -0800 Kees Cook wrote:
> > > > -static inline int nla_len(const struct nlattr *nla)
> > > > +static inline u16 nla_len(const struct nlattr *nla)
> > > >  {
> > > > -	return nla->nla_len - NLA_HDRLEN;
> > > > +	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN : 0;
> > > >  }  
> > > 
> > > Note the the NLA_HDRLEN is the length of struct nlattr.
> > > I mean of the @nla object that gets passed in as argument here.
> > > So accepting that nla->nla_len may be < NLA_HDRLEN means
> > > that we are okay with dereferencing a truncated object...
> > > 
> > > We can consider making the return unsinged without the condition maybe?  
> > 
> > Yes, if we did it without the check, it'd do "less" damage on
> > wrap-around. (i.e. off by U16_MAX instead off by INT_MAX).
> > 
> > But I'd like to understand: what's the harm in adding the clamp? The
> > changes to the assembly are tiny:
> > https://godbolt.org/z/Ecvbzn1a1
> 
> Hm, I wonder if my explanation was unclear or you disagree..
> 
> This is the structure:
> 
> struct nlattr {
> 	__u16           nla_len; // attr len, incl. this header
> 	__u16           nla_type;
> };
> 
> and (removing no-op wrappers):
> 
> #define NLA_HDRLEN	sizeof(struct nlattr)
> 
> So going back to the code:
> 
> 	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN...
> 
> We are reading nla->nla_len, which is the first 2 bytes of the structure.
> And then we check if the structure is... there?

I'm not debating whether it's there or not -- I'm saying the _contents_ of
"nlattr::nla_len", in the face of corruption or lack of initialization,
may be less than NLA_HDRLEN. (There's a lot of "but that's can't happen"
that _does_ happen in the kernel, so I'm extra paranoid.)

> If we don't trust that struct nlattr which gets passed here is at least
> NLA_HDRLEN (4B) then why do we think it's safe to read nla_len (the
> first 2B of it)?

Type confusion (usually due to Use-after-Free flaws) means that a memory
region is valid (i.e. good pointer), but that the contents might have
gotten changed through other means. (To see examples of this with
struct msg_msg, see: https://syst3mfailure.io/wall-of-perdition/)

(On a related note, why does nla_len start at 4 instead of 0? i.e. why
does it include the size of nlattr? That seems redundant based on the
same logic you're using here.)

> That's why I was pointing at nla_ok(). nla_ok() takes the size of the
> buffer / message as an arg, so that it can also check if looking at
> nla_len itself is not going to be an OOB access. 99% of netlink buffers
> we parse come from user space. So it's not like someone could have
> mis-initialized the nla_len in the kernel and being graceful is helpful.
> 
> The extra conditional is just a minor thing. The major thing is that
> unless I'm missing something the check makes me go 🤨️

My concern is that there are 562 callers of nla_len():

$ git grep '\bnla_len(\b' | wc -l
562

We have no way to be certain that all callers follow a successful
nla_ok() call.

Regardless, just moving from "int" to "u16" solves a bunch of value
range tracking pain that GCC appears to get upset about, so if you
really don't want the (tiny) sanity check, I can just send the u16
change.

-Kees

-- 
Kees Cook


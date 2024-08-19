Return-Path: <netdev+bounces-119691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB469569EF
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1DA1F24032
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7786A1684BB;
	Mon, 19 Aug 2024 11:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xLZNPuAw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB554166F11
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068396; cv=none; b=MYDB+9zBKAJGxmrcd352sPS2x/96qEubElWx3OSNQXXUKDjhCe7UnhJ/0BmZwxd8Ry55r5VUtY2OyUkTFNGleuOB1vfF227XmrSFk907/d14re+AxzFyol/p1cano6vj8rePxvcubMMECh0WHxMJ8ISsA7Im5fV7MIiU24MHV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068396; c=relaxed/simple;
	bh=slL7Eq8i8Zc4B/aAg6ReoMiW8Oo2iVk9Zs4zTsJfF9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ochp40JHxZCW4uvUfZn2bvzeRkxY2cVaZZWqRwTam1WJTrh5YFO9jSw+sD36N1dQ4W8Dm1YBVKu9/9QJaYgvEIx8w078BpHTr5vrH6KWVunD4//YwIAHJfY0gZnRG6e+J6zvQ1/AxR5PooUakY7KZHDDYB+YpfsYWSUPN4z1ycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xLZNPuAw; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5beb6ea9ed6so4071436a12.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 04:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724068392; x=1724673192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFUauvP8/Zzae9Bcs/cH9Wglrabg3pmi9d/BUA6OkYI=;
        b=xLZNPuAwaEDYwndNOLA5BCkdfK5xFX2N65KK18MhCmO8aQrdDW3FDUQ5FsWRldFr+s
         IGrdEysGbZNZfuT473JZhCBYR2sXcEfIy7O5aO4+H6IVl9VCPzFOPUMmi8A9w7dmbXiy
         qjIMEYPlrN0lP7h/2C/+J4Orlr94dK5Ze+FsCF8bAcJK9d1DoMoMnojMWaJSUjQw/w4M
         4bet1mHHkF1olBBwjbk5fyLZDwLmUZstTJz/oX4f3ILW2Fxyq+Iep9V/paXXHQJARr4J
         +7fZJOO2AFdlbQYrxmWb3E5oF/4edp96/Xglr3RQACM6NC88DyPbnVxPuS87+TV6wMUk
         VL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724068392; x=1724673192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFUauvP8/Zzae9Bcs/cH9Wglrabg3pmi9d/BUA6OkYI=;
        b=HFd6LjvauSW4mjN2C53YIk/QRQtmPXkkQNUrkcOIF5tGE4X8kGUeskIfXIy0Q5T/nP
         rxHTxsuSp2XICM27W4CwJKthZgNlBuU8IddtjtRFqCBQKQNLxXfwLoZ9O0MBlXBE7xBn
         GR3l/WNZCb5xpzTTvj5M4QWDRhe0fsBSdeg6afkMXK5IIKsmq4R+Qqsl4MxngX6399K1
         s5GUeizHdiK3fRaj3z39tVnwSxQhxM25FUWnncYxFnZGbhaQzGzEeWjmLpggV+tiJ0r4
         6CUAgyeCXEaWpjWOOc5USAwo6JRC5yxPk2LKXGaTjcfryIy7yBJb2G4ua/OJSSig71Vv
         Z/cQ==
X-Gm-Message-State: AOJu0Yw1uSjIlSU+1wHef7d9DxMsmKW+BXSmNwkV85yIHIpG7ZBUnKnj
	wTVJGJXo1l6YWMZVe0TN4x3t3mwu57sA+eLQnLeqhcUGIhfQYdTJ59gGhsRJ7ek=
X-Google-Smtp-Source: AGHT+IG7j2Eww4ZdB2kbq1Njj+1YoqoLcfmsG5PkObhTxpHKFJUbJzzFWTu7LExsX023XwvZ3srYGg==
X-Received: by 2002:a05:6402:4401:b0:5a7:464a:ab9 with SMTP id 4fb4d7f45d1cf-5beca5942admr8039016a12.21.1724068391687;
        Mon, 19 Aug 2024 04:53:11 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde7cd4sm5517305a12.39.2024.08.19.04.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:53:10 -0700 (PDT)
Date: Mon, 19 Aug 2024 13:53:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <ZsMyI0UOn4o7OfBj@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
 <7ed5d9b312ccda58c3400c7ba78bca8e5f8ea853.1722357745.git.pabeni@redhat.com>
 <ZquQyd6OTh8Hytql@nanopsycho.orion>
 <b75dfc17-303a-4b91-bd16-5580feefe177@redhat.com>
 <ZrxsvRzijiSv0Ji8@nanopsycho.orion>
 <f320213f-7b1a-4a7b-9e0c-94168ca187db@redhat.com>
 <Zr8Y1rcXVdYhsp9q@nanopsycho.orion>
 <4cb6fe12-a561-47a4-9046-bb54ad1f4d4e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cb6fe12-a561-47a4-9046-bb54ad1f4d4e@redhat.com>

Mon, Aug 19, 2024 at 11:33:28AM CEST, pabeni@redhat.com wrote:
>
>
>On 8/16/24 11:16, Jiri Pirko wrote:
>> Fri, Aug 16, 2024 at 10:52:58AM CEST, pabeni@redhat.com wrote:
>> > On 8/14/24 10:37, Jiri Pirko wrote:
>> > > Tue, Aug 13, 2024 at 05:17:12PM CEST, pabeni@redhat.com wrote:
>> > > > On 8/1/24 15:42, Jiri Pirko wrote:
>> > > > [...]
>> > > > > > int net_shaper_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
>> > > > > > {
>> > > > > > -	return -EOPNOTSUPP;
>> > > > > > +	struct net_shaper_info *shaper;
>> > > > > > +	struct net_device *dev;
>> > > > > > +	struct sk_buff *msg;
>> > > > > > +	u32 handle;
>> > > > > > +	int ret;
>> > > > > > +
>> > > > > > +	ret = fetch_dev(info, &dev);
>> > > > > 
>> > > > > This is quite net_device centric. Devlink rate shaper should be
>> > > > > eventually visible throught this api as well, won't they? How do you
>> > > > > imagine that?
>> > > > 
>> > > > I'm unsure we are on the same page. Do you foresee this to replace and
>> > > > obsoleted the existing devlink rate API? It was not our so far.
>> > > 
>> > > Driver-api-wise, yes. I believe that was the goal, to have drivers to
>> > > implement one rate api.
>> > 
>> > I initially underlooked at this point, I'm sorry.
>> > 
>> > Re-reading this I think we are not on the same page.
>> > 
>> > The net_shaper_ops are per network device operations: they are aimed (also)
>> > at consolidating network device shaping related callbacks, but they can't
>> > operate on non-network device objects (devlink port).
>> 
>> Why not?
>
>Isn't the whole point of devlink to configure objects that are directly
>related to any network device? Would be somewhat awkward accessing devlink

Yeah, not even network. Just "a device".


>port going through some net_device?

I'm not sure why you are asking that. I didn't suggest anything like
that. On contrary, as your API is netdev centric, I suggested to
disconnect from netdev to the shapers could be used not only with them.
This is what I understood was a plan from very beginning. I may be wrong
though....


>
>Side note: I experimented adding the 'binging' abstraction to this API and
>gives a quite significant uglification to the user syntax (due to the
>additional nesting required) and the code.
>
>Still, if there is a very strong need for controlling devlink rate via this
>API _and_ we can assume that each net_device "relates" (/references/is
>connected to) at most a single devlink object (out of sheer ignorance on my
>side I'm unsure about this point, but skimming over the existing
>implementations it looks so), the current API definition would be IMHO
>sufficient and clean enough to reach for both devlink port rate objects and
>devlink node rate objects.

Don't assume this. Not always true.


>
>We could define additional scopes for each of such objects and use the id to
>discriminate the specific port or node within the relevant devlink.

But you still want to use some netdevice as a handle IIUC, is that
right?


>
>I think such scopes definition should come with related implementation, e.g.
>not with this series.
>
>Thanks,
>
>Paolo
>


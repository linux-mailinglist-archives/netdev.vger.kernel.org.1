Return-Path: <netdev+bounces-115482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFA894686D
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 08:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372BD1F21566
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 06:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444FA14D6F6;
	Sat,  3 Aug 2024 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GDQslmXK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A8723CB
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722668343; cv=none; b=mWlQpK5b4ilxOQ0F25zBiNQcYyitswHtX3Z6IXugoRARcilCNZoMDSeIppfoJ3BROyXrKKkNnV3xOAQll+fnK+zbHzkw0M+ms3eJEX0n1Tlet664Ve0HfL9tAtvG+Z7cGwBsVlVBvhSlrf6gCIa1SrMznKuymGHSDrN3eHeLsPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722668343; c=relaxed/simple;
	bh=xZMHYnEp9ACeLinOnxTuRVM6r3QO72tdIYq0FDV7YhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDBh/Re5bDaUnrUoKQtx5LwY6VL5dUIWDc3GXAzQpjyd+s06D//IaVYxk4d55NMLxIpCEr5mi8S8u6bBwiknrmT7gaqwpLSrNbDuM+Y8yVsQ4r4smUhcqGr5uWAnh8422A9UopLjkUUTfVd9XIpvcOK4heGnl4cLgMyHNsHVyn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GDQslmXK; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ed741fe46so10136305e87.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 23:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722668338; x=1723273138; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ng8ZLCpRwpNDRO9+xd5xTYxAZgsQpYwXSash6jlxffo=;
        b=GDQslmXKpuORgoY3u0bw9gfR8L5g79nhczoYwXUo7Qbagb5mY/LAUh435HldOUZosa
         6mSC2TT70kmrC2c8mxsQi0Aq68YMeRdQzwhmUQvzGT5VGUUS+hIHNM4iKjY20rLhgCcE
         4G/OKU953O3+DJ9OnEETFyvzSlvpmEtbRzqkcgnaSkSswRlAgqRY7cAAZnwHod9Dsnlj
         11X5rixv1s+27lKbwzeGa+ETP2r5WZpb/RSy3pTRkZZnhkse9YtClNi75s0e+fY100A2
         ++3yuDrcj2tIUo0ykDPlrm/qqWJqYhG1NE7vV/aQS/3SU9YwqOf+p4YosQnTJClVNLmW
         9XXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722668338; x=1723273138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ng8ZLCpRwpNDRO9+xd5xTYxAZgsQpYwXSash6jlxffo=;
        b=FpSg4pFYesYNjYbADk7uMdIVrkKE3pn27ShLi9n2dVSd9MiEF9q8PlYrdc9z1gFX28
         BSuAopz8OEPvO+0L4gGwaXY1o2JfkFrWSKkq2vkxMmV2o6AXglRVm+mDpiEoyaMIC/lO
         NPfjVwIHXbHMk7DBYnhR7+nmBP5FXMwrZUso7Ln/aYDrBFKpLr4EDg3L9A332gmjkgWF
         1Pzan9Ok2GQSwv7m1IZlxrtC3GGpo4wpzs3nk2kaGMv3QekU4q87aKSfE4MNkKhUaYrb
         y1dbrCvvstR38OM+vXpuM0UTW20LxrpTo9qV0iHrrb8MO8d4c2XUlepRgwqvdbE/em3W
         wVpw==
X-Forwarded-Encrypted: i=1; AJvYcCXPyRJp2Xvd1lKCFyhd0Ij3JXWsHZVBNn3hBDZQfxr2auLvsBk26heVh43/9c0OE4ZfP90GGz94VCEIiBXFWtEEwDjV2u4A
X-Gm-Message-State: AOJu0YzaCWudTIVkZxicKbqK+tlAdiucMYn+3hTwDFik6e+nEPUR4zxu
	RDc4n8papp86fHPc6V8Ul76n+Vwq7KnHDuJiWKFCpoy9/z5b3OtE1udMOhpUeyo=
X-Google-Smtp-Source: AGHT+IH+M0fjMuP4QYyjNbpxoo4tGJ632ILIVdkxBT+yyY3Gct8Gu6Hsvsa+d2Wksc2b54jC9krJCg==
X-Received: by 2002:a05:6512:39c7:b0:52e:f2a6:8e1a with SMTP id 2adb3069b0e04-530bb3b6f59mr4145712e87.29.1722668337686;
        Fri, 02 Aug 2024 23:58:57 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b7245f8sm1991298a12.74.2024.08.02.23.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 23:58:56 -0700 (PDT)
Date: Sat, 3 Aug 2024 08:58:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jeongjun Park <aha310510@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Subject: Re: [PATCH net,v2] team: fix possible deadlock in
 team_port_change_check
Message-ID: <Zq3VLwc51pmn9ToA@nanopsycho.orion>
References: <Zq0akdhiSeoiOLsY@nanopsycho.orion>
 <4E6F3146-AE8D-4C70-A068-A6EE8588F13D@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4E6F3146-AE8D-4C70-A068-A6EE8588F13D@gmail.com>

Sat, Aug 03, 2024 at 03:36:48AM CEST, aha310510@gmail.com wrote:
>
>
>> Jiri Pirko wrote:
>> 
>> ﻿Fri, Aug 02, 2024 at 06:25:31PM CEST, aha310510@gmail.com wrote:
>>> Eric Dumazet wrote:
>>>> 
>>>>> On Fri, Aug 2, 2024 at 5:00 PM Jeongjun Park <aha310510@gmail.com> wrote:
>>>>>> 
>>> 
>>> [..]
>>> 
>>> @@ -2501,6 +2470,11 @@ int team_nl_options_get_doit(struct sk_buff *skb, struct genl_info *info)
>>>    int err;
>>>    LIST_HEAD(sel_opt_inst_list);
>>> 
>>> +    if (!rtnl_is_locked()) {
>> 
>> This is completely wrong, other thread may hold the lock.
>> 
>> 
>>> +        rtnl_lock();
>> 
>> NACK! I wrote it in the other thread. Don't take rtnl for get options
>> command. It is used for repeated fetch of stats. It's read only. Should
>> be converted to RCU.
>> 
>
>I see. But, in the current, when called through the following path:
>team_nl_send_event_options_get()->
>team_nl_send_options_get()->
>team_nl_fill_one_option_get()
>, it was protected through rtnl. Does this mean that rcu should be 

Not true. team_nl_send_event_options_get() is sometimes called without
rtnl (from lb_stats_refresh() for example).


>used instead of rtnl in this case as well?
>
>> Why are you so obsessed by this hypothetical syzcaller bug? Are you
>> hitting this in real? If not, please let it go. I will fix it myself
>> when I find some spare cycles.
>
>Sorry for the inconvenience, but I don't want to give up on this bug 
>so easily since it is a valid bug that we have started analyzing 
>anyway and the direction of how to fix it is clear. I hope you 
>understand and I will send you a patch that uses rcu instead 

I don't understand, sorry. Apparently you don't have any clue what you
are doing and only waste people time. Can't you find another toy to
play?

Please add my
Nacked-by: Jiri Pirko <jiri@nvidia.com>
tag to your any future attempt, as I'm sure it won't be correct.

Thanks!



>of rtnl soon.
>
>Regards,
>Jeongjun Park


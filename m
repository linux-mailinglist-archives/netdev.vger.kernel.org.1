Return-Path: <netdev+bounces-49969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 648617F41A5
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0015AB20D07
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7832A3E480;
	Wed, 22 Nov 2023 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jpSrwuh1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287FF198
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:29:48 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo9454503a12.3
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700645386; x=1701250186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BxCAwmqwwP638oFlO2L4rvJOufvZC0fSDKXjbIn7rAg=;
        b=jpSrwuh1rUnJhTC6aIFqdx25aWvcSKbmsxXFwnZRhNowcgXjz9g166hWuOGk23hy7O
         LD9tj48kM0qlBWDqh67LjuF4KYP5f2/qHXTA8R+E+m3SxIQQ7rlrQbE7abJKOOiijnCe
         Lky6lrtQ00ETY5CVOikLWkPDD4KjmOSa82TPqz5XMtv+BR+SLnqdkE9wsWFOlb7p5acO
         jIjn3u7U8D9AmF926EGWo6TdC/Ibl+7DOGfmy8c6rqLASoaniED/qyhBvwrFGDc8QFdB
         e4vrx0SfRn/wrqGKy2KKDvZfeOTjd75AbnaYfZ22OYuGp9j07+Hyl23tzJgd7XEaovwm
         3JQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700645386; x=1701250186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxCAwmqwwP638oFlO2L4rvJOufvZC0fSDKXjbIn7rAg=;
        b=W1pRZ7Z3O74hUJQmDHuvQlQkcdPergc3+L8R8PU7Ro1a/YQUlwy/TCSzfUfHD/DnKq
         P4EPnTa1q9RTU6FC1GZJ1E03YFGiOgMqx/dolznLflkf5CDY7WXLucZQ8bbveyBBbzQz
         qJZgKHPba6kF1knyN6X6UjGruLa+2D6PkG64M1RHQM4AZ75UZyk576z/BQpQ1ffeMe4W
         m8lzh5H/5YASe+P+ONNTAM2SLsGYI7Xguzq/Z/XL6hn82msmEDmBknRss7ItKR8ipk1U
         M7SFBaAu7wyy7L7O8jEUH3nNIv5sV0iKYmYZyxbdwLsw7dtJ0n7x74gCya5PT5KQFiqS
         +hdg==
X-Gm-Message-State: AOJu0YyLmb8fFs1/WMo+yiynrK7g4bg55lJN0uZ2M5h8S71mLFUoGNsB
	dN25J2NjiTLcn9bay0N1WiJ3Eg==
X-Google-Smtp-Source: AGHT+IEZhGQveEL0NAEy2D81+siiIU3j4S5kNdBGH48FfaGFRgRKwjyO+VK/8lbH3plT8xX817eeWg==
X-Received: by 2002:aa7:d9d5:0:b0:548:89b7:f590 with SMTP id v21-20020aa7d9d5000000b0054889b7f590mr1461251eds.35.1700645386628;
        Wed, 22 Nov 2023 01:29:46 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id be6-20020a0564021a2600b00548a0e8c316sm3880655edb.20.2023.11.22.01.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 01:29:45 -0800 (PST)
Date: Wed, 22 Nov 2023 10:29:44 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v3 5/9] genetlink: implement release callback
 and free sk_user_data there
Message-ID: <ZV3KCF7Q2fwZyzg4@nanopsycho>
References: <20231120084657.458076-1-jiri@resnulli.us>
 <20231120084657.458076-6-jiri@resnulli.us>
 <20231120185022.78f10188@kernel.org>
 <ZVys11ToRj+oo75s@nanopsycho>
 <20231121095512.089139f9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121095512.089139f9@kernel.org>

Tue, Nov 21, 2023 at 06:55:12PM CET, kuba@kernel.org wrote:
>On Tue, 21 Nov 2023 14:12:55 +0100 Jiri Pirko wrote:
>> >How is this supposed to work?
>> >
>> >genetlink sockets are not bound to a family. User can use a single
>> >socket to subscribe to notifications from all families and presumably
>> >each one of the would interpret sk->sk_user_data as their own state?
>> >
>> >You need to store the state locally in the family, keyed
>> >on pid, and free it using the NETLINK_URELEASE notifier...  
>> 
>> Well, pin can have 2 sockets of different config. I think that sk/family
>> tuple is needed. I'm exploring a possibility to have genetlink
>> sk->sk_user_data used to store the hashlist keyed by the sk/family tuple.
>
>If you're doing it centrally, please put the state as a new field in
>the netlink socket. sk_user_data is for the user.

I planned to use sk_user_data. What do you mean it is for the user?
I see it is already used for similar usecase by connector for example:

$ git grep sk_user_data drivers/connector/
drivers/connector/cn_proc.c:    if (!dsk || !dsk->sk_user_data || !data)
drivers/connector/cn_proc.c:    val = ((struct proc_input *)(dsk->sk_user_data))->event_type;
drivers/connector/cn_proc.c:    mc_op = ((struct proc_input *)(dsk->sk_user_data))->mcast_op;
drivers/connector/cn_proc.c:            if (sk->sk_user_data == NULL) {
drivers/connector/cn_proc.c:                    sk->sk_user_data = kzalloc(sizeof(struct proc_input),
drivers/connector/cn_proc.c:                    if (sk->sk_user_data == NULL) {
drivers/connector/cn_proc.c:                    ((struct proc_input *)(sk->sk_user_data))->mcast_op;
drivers/connector/cn_proc.c:            ((struct proc_input *)(sk->sk_user_data))->event_type =
drivers/connector/cn_proc.c:            ((struct proc_input *)(sk->sk_user_data))->mcast_op = mc_op;
drivers/connector/cn_proc.c:            ((struct proc_input *)(sk->sk_user_data))->event_type =
drivers/connector/connector.c:          kfree(sk->sk_user_data);
drivers/connector/connector.c:          sk->sk_user_data = NULL;


>
>Also let's start with a list, practically speaking using one socket 
>in many families should be very rare.

Okay.


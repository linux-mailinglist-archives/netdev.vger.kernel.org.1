Return-Path: <netdev+bounces-52172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E78097FDB54
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22ACB1C2031B
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C6E38DDF;
	Wed, 29 Nov 2023 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OoJeyAfR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5585A1BF3
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 07:25:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a02d12a2444so986683566b.3
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 07:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701271527; x=1701876327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EgYWpKLNErfu13BFJAcWaeBfQj9tEc8uJTd7cUhrg6s=;
        b=OoJeyAfRxv2Ul50XIaUhDF1X4WL4y4gFz7Q+4ucs9Up3w94DZtFEe4r7SfKoRlmMR6
         7yAV/E9ERGd1I8LqHINw2KbwxJ7PsxgWZgCo6UnEqxOhsCwdzyh0GyUkLgqcsjYUrqzb
         2v76v7s4c10GUMCrkf90wvd1K1FzINZR66Xk3PGBznfC08AcI2BayUWIK2sNusbT+nj1
         iYtQ/T6uduNPTUWRs6UJYC9NlVZ8I+TTiSRKj0Of4XEdFcOaAEfEU4oNbq7DWLog6j6Y
         ileioKb7dhF/YdbRrQ2P4CQ3Vzvvocb9NimXN0c6omvoHp8NlcXj8oDB8UAQnJJfCI13
         gRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701271527; x=1701876327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgYWpKLNErfu13BFJAcWaeBfQj9tEc8uJTd7cUhrg6s=;
        b=TLGaDVkeLZDwE7gaqNef2XRZH7CiWP6pM9+fDwZMxUBpWnVtDiBOkfu4ovAyNZLZlw
         dbWYdaHUh6VyvqoYqx2Cp1eq8NRh9A7fRFuDY7ty+gnhLW5SLSpJFvKMbOcjtqy73quU
         mXPSMTybsHffrflo5cmYjiQs/nptuQ6svL9QA5CNbs8iuK9RieKq9a05eKSJEjna4WNL
         z2Vu70pnWRHYGhqSXJuRKJtPrl1T+XaoCQ4O4GRuaLZP5+NhPWjE1WHVRZf9iTlmpWFM
         aIKCVU/s+PEtK7DwP+dW+LC6O+vSYPWRZ7dxNxhODXcE6xN4yYHvYWCYCIpq+gLTH0Kb
         iP/g==
X-Gm-Message-State: AOJu0Yyb37+J0OfRUGJye+VV1QmVV1Mz1Fnac0P5iOWX621dNf1IuvOy
	BKiP4/URltp6A6PYJG7IJAhN+A==
X-Google-Smtp-Source: AGHT+IFfl8X0miMz06A4l2QgSCTEvccBqr0xvkZMo+SGGMsx1wSeSkSkU2kmJWD3q7I4TcZARBhsVg==
X-Received: by 2002:a17:906:2cb:b0:a0f:76dc:febc with SMTP id 11-20020a17090602cb00b00a0f76dcfebcmr7241328ejk.70.1701271527583;
        Wed, 29 Nov 2023 07:25:27 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id r21-20020a170906351500b00a0bd234566bsm5371392eja.143.2023.11.29.07.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:25:27 -0800 (PST)
Date: Wed, 29 Nov 2023 16:25:25 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
Message-ID: <ZWdX5ccvLxuUh0Eb@nanopsycho>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-6-jiri@resnulli.us>
 <20231127144626.0abb7260@kernel.org>
 <ZWWj8VZF5Puww2gm@nanopsycho>
 <20231128071116.1b6aed13@kernel.org>
 <ZWYP3H0wtaWxwneR@nanopsycho>
 <20231128083605.0c8868cd@kernel.org>
 <ZWdDw2EJJbv6ecJ5@nanopsycho>
 <20231129070157.41d17b26@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129070157.41d17b26@kernel.org>

Wed, Nov 29, 2023 at 04:01:57PM CET, kuba@kernel.org wrote:
>On Wed, 29 Nov 2023 14:59:31 +0100 Jiri Pirko wrote:
>> Tue, Nov 28, 2023 at 05:36:05PM CET, kuba@kernel.org wrote:
>> >No, you can do exact same thing, just instead of putting the string
>> >directly into the xarray you put a struct which points to the string.  
>> 
>> I'm lost. What "string" are you talking about exactly? I'm not putting
>> any string to xarray.
>> 
>> In the existing implementation, I have following struct:
>> struct devlink_obj_desc {
>>         struct rcu_head rcu;
>>         const char *bus_name;
>>         const char *dev_name;
>>         unsigned int port_index;
>>         bool port_index_valid;
>>         long data[];
>> };
>> 
>> This is the struct put pointer to into the xarray. Pointer to this
>> struct is dereferenced under rcu in notification code and the struct
>> is freed by kfree_rcu().
>
>Sorry I was looking at patch 8 which has only:
>
>+struct devlink_obj_desc {
>+	struct rcu_head rcu;
>+	const char *bus_name;
>+	const char *dev_name;
>+	long data[];
>+};
>
>that's basically a string and an rcu_head, that's what I meant.
>
>> >Core still does the kfree of the container (struct devlink_sk_priv).
>> >But what's inside the container struct (string pointer) has to be
>> >handled by the destructor.
>> >
>> >Feels like you focus on how to prove me wrong more than on
>> >understanding what I'm saying :|  
>> 
>> Not at all, I have no reason for it. I just want to get my job done
>> and I am having very hard time to understand what you want exactly.
>
>Sockets may want to hold state for more than filtering.
>Try to look past your singular use case.

Okay, I'll try to make another V. But please don't be mad I
misunderstood something if I do :)


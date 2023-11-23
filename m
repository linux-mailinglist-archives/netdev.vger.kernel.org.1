Return-Path: <netdev+bounces-50575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3174D7F628D
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617371C21149
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0EE3418D;
	Thu, 23 Nov 2023 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EeQurxJh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8FED66
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 07:17:33 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a03a900956dso191543366b.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 07:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700752651; x=1701357451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ADAjgusH+XqoSZ46F1hzyIJthXriEo1DA4CaE5bJB2s=;
        b=EeQurxJhZASF10TjBamL1rftg7hv1nJQj49Z2OyVbeU43qkPsTJF4ncZcsVxEJEVbs
         FW513H2eHR31HxZ6J/GHHNJmDdzP4vfQ4kIr6YMah3oEL3eRVfb/ewqPpupO0MO4uFZu
         3d5z2QF2g6A81fSytaS/f9bsml0BSvH+nc777eR+jZJFdOm7NacYhD+eVO67W0Nw+/FC
         /khJOJ5RbriiGEWnJXjYH2cAi1OpGXbPhQXqZ4svHWtcjuc7by8fLPtzr/IUGabgFJ7G
         jedV9wkajAUyQuEyAwEue1foT1au4zH9k2GgdOTnAWhSI9u420qlsrbBfAR9LDYdVOlu
         EKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700752651; x=1701357451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADAjgusH+XqoSZ46F1hzyIJthXriEo1DA4CaE5bJB2s=;
        b=URSDRnTdfIlrLupAFVh0EZOFwbB5w+w6BoiivOAxHWrJ/+yKrVRfL24ovd62ITA2dP
         uw1/GaCvUwKk4aK7P/uhXFN5Squh4JpayYSu4nTtlvIPvetS1bSWpEorIQC6VOInHc4G
         NTEs0EYCEPkDEw4RnyFQuU6MrB10E8GrHrLZm2N9xVVqW5zrqyjyrfudGpdXspY9p+Y7
         0V9oxIBEUaEufCw2YBNi4/+AvjHoZ9m+kpyerLyl3EJeivGXf61Dl2s0dTyzyRUYckP2
         lmFYb9xR+C6RLHgl7keo4WvO559z5DQgg3dqMTYBict2y11NXJ5uo8p4ZRPlrhJrwQX3
         Qbhw==
X-Gm-Message-State: AOJu0Yz/nlUzuha0cp6w8TPmKqvzgStGOnM9/BPg/ozzTwlWE/AhD9bM
	MueCdDLJPmeSwlHZ2rglcI7J8Q==
X-Google-Smtp-Source: AGHT+IFOmLDOMLAl5OqZDmJSjKFukbwEChChzJvWacN2Fw49jL+VB+gA3xHEphBwxZOjUt6pOnBeqQ==
X-Received: by 2002:a17:907:da3:b0:9fa:d1df:c2c4 with SMTP id go35-20020a1709070da300b009fad1dfc2c4mr2900303ejc.36.1700752651491;
        Thu, 23 Nov 2023 07:17:31 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id a20-20020a1709063e9400b00a0369e232bfsm894620ejj.75.2023.11.23.07.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 07:17:31 -0800 (PST)
Date: Thu, 23 Nov 2023 16:17:29 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xiyou.wangcong@gmail.com, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
Message-ID: <ZV9tCT9d7dm7dOeA@nanopsycho>
References: <20231110214618.1883611-1-victor@mojatatu.com>
 <20231110214618.1883611-5-victor@mojatatu.com>
 <ZV8SnZPBV4if5umR@nanopsycho>
 <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>
 <ZV9b0HrM5WespGMW@nanopsycho>
 <CAM0EoMnwAHO_AvEYiL=aTwNBjs29ww075Lq1qwvCwuYtB_Qz7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMnwAHO_AvEYiL=aTwNBjs29ww075Lq1qwvCwuYtB_Qz7A@mail.gmail.com>

Thu, Nov 23, 2023 at 03:38:35PM CET, jhs@mojatatu.com wrote:
>On Thu, Nov 23, 2023 at 9:04 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Nov 23, 2023 at 02:37:13PM CET, jhs@mojatatu.com wrote:
>> >On Thu, Nov 23, 2023 at 3:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Fri, Nov 10, 2023 at 10:46:18PM CET, victor@mojatatu.com wrote:
>> >> >This action takes advantage of the presence of tc block ports set in the
>> >> >datapath and multicasts a packet to ports on a block. By default, it will
>> >> >broadcast the packet to a block, that is send to all members of the block except
>> >> >the port in which the packet arrived on. However, the user may specify
>> >> >the option "tx_type all", which will send the packet to all members of the
>> >> >block indiscriminately.
>> >> >
>> >> >Example usage:
>> >> >    $ tc qdisc add dev ens7 ingress_block 22
>> >> >    $ tc qdisc add dev ens8 ingress_block 22
>> >> >
>> >> >Now we can add a filter to broadcast packets to ports on ingress block id 22:
>> >> >$ tc filter add block 22 protocol ip pref 25 \
>> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22
>> >>
>> >> Name the arg "block" so it is consistent with "filter add block". Make
>> >> sure this is aligned netlink-wise as well.
>> >>
>> >>
>> >> >
>> >> >Or if we wish to send to all ports in the block:
>> >> >$ tc filter add block 22 protocol ip pref 25 \
>> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 tx_type all
>> >>
>> >> I read the discussion the the previous version again. I suggested this
>> >> to be part of mirred. Why exactly that was not addressed?
>> >>
>> >
>> >I am the one who pushed back (in that discussion). Actions should be
>> >small and specific. Like i had said in that earlier discussion it was
>> >a mistake to make mirred do both mirror and redirect - they should
>>
>> For mirror and redirect, I agree. For redirect and redirect, does not
>> make much sense. It's just confusing for the user.
>>
>
>Blockcast only emulates the mirror part. I agree redirect doesnt make
>any sense because once you redirect the packet is gone.

How is it mirror? It is redirect to multiple, isn't it?


>
>> >have been two actions. So i feel like adding a block to mirred is
>> >adding more knobs. We are also going to add dev->group as a way to
>> >select what devices to mirror to. Should that be in mirred as well?
>>
>> I need more details.
>>
>
>You set any port you want to be mirrored to using ip link, example:
>ip link set dev $DEV1 group 2
>ip link set dev $DEV2 group 2

That does not looks correct at all. Do tc stuff in tc, no?


>...
>
>Then you can blockcast:
>tc filter add devx protocol ip pref 25 \
>  flower dst_ip 192.168.0.0/16 action blockcast group 2

"blockcasting" to something that is not a block anymore. Not nice.

>
>cheers,
>jamal
>
>>
>> >
>> >cheers,
>> >jamal
>> >
>> >> Instead of:
>> >> $ tc filter add block 22 protocol ip pref 25 \
>> >>   flower dst_ip 192.168.0.0/16 action blockcast blockid 22
>> >> You'd have:
>> >> $ tc filter add block 22 protocol ip pref 25 \
>> >>   flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
>> >>
>> >> I don't see why we need special action for this.
>> >>
>> >> Regarding "tx_type all":
>> >> Do you expect to have another "tx_type"? Seems to me a bit odd. Why not
>> >> to have this as "no_src_skip" or some other similar arg, without value
>> >> acting as a bool (flag) on netlink level.
>> >>
>> >>


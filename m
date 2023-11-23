Return-Path: <netdev+bounces-50576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B99507F628F
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64369B214A3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9269833CD3;
	Thu, 23 Nov 2023 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZvQbxY8s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86567C1
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 07:18:50 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50797cf5b69so1287598e87.2
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 07:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700752729; x=1701357529; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xAlPC4b02BVieNKxJLZxYFfz+uR4sUicWUNBqx1d7U8=;
        b=ZvQbxY8szmH/qXcujuioch8JLn6q6RJgIqcIbtpxKPJr0lrAduWFtP0DLJiE+KgZ3Y
         YjdD7uiFwuKnbikHdowqi1CijGLFzVH/IIu3VwT8S0YSlmhMn4jRKHAvs2nj5tYKVqYJ
         6wT8mabq/G8E9beQRmznM5qZu7k3jI7XsMDygIEXWGadsHx6ZWEEivTjQENb6uY1m7hC
         bPW7vLQD5hk26A0gJrk4v3FYu2bEPReWMx+UmkvmgYI8i41r1t+N/FhPjHVi1lAwmKbm
         SBIJvn5a9tuHBzw5U79VnjlJLRlguPnszNua/3ES/s10+kktxEQf9P1NFpBBgavkmd+R
         ZgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700752729; x=1701357529;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xAlPC4b02BVieNKxJLZxYFfz+uR4sUicWUNBqx1d7U8=;
        b=NQpwAGo6MwNZnaPlEm4TsXJOMD6onDTsb6EBuSIoZMLwHQbI6ZLBP71kJNy4hVw2cN
         JrKXL2Uex/6XcyG0XEr900hC4XuUo2uEWqzc5lqa3qKL6jTl8Du8gqt9TLdn5FuQlKei
         wb5oZG9b5uHoyYWvR8gpCcqTG3UYNpKE+698DR+Ul0r3skLRNRY/JH7R7ocKsSpUGxgg
         5O1t+Op8qEzVERpjl+FXXVwgFpQiSxCXfVZMbjHO87Zh+Y2Ft8wORiIitwCS7kj1I5Jw
         XJi9niTz9VeR65PQZE+dTKC6PY/yvjo19PMWYYONa4Rke9Uocqv/FEMd/Q7e//6jWFjx
         92XA==
X-Gm-Message-State: AOJu0YwVgNdJCFIEsU6x43euzKiBddv9oF51pa8UU7+f0Xm0QkVwBb/P
	sDP0H+FUMYGtgSZpo0WexU58Fw==
X-Google-Smtp-Source: AGHT+IENmfZ/ZnR4/HdvZmDJguhT1uPOu9Q/YleG4wELcim49Y7m7AywK9AzTMDvmBWiRGuP/09TeQ==
X-Received: by 2002:ac2:52af:0:b0:50a:a7e2:f2b8 with SMTP id r15-20020ac252af000000b0050aa7e2f2b8mr4051486lfm.62.1700752728624;
        Thu, 23 Nov 2023 07:18:48 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id jt13-20020a170906ca0d00b0099c53c4407dsm895920ejb.78.2023.11.23.07.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 07:18:48 -0800 (PST)
Date: Thu, 23 Nov 2023 16:18:46 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xiyou.wangcong@gmail.com, vladbu@nvidia.com, paulb@nvidia.com,
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
Message-ID: <ZV9tVuENB9XT1fjO@nanopsycho>
References: <20231110214618.1883611-1-victor@mojatatu.com>
 <20231110214618.1883611-5-victor@mojatatu.com>
 <ZV8SnZPBV4if5umR@nanopsycho>
 <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>
 <CALnP8ZZkee5kKAFeNhQdVFxJgcs1DREEmtEk9pN8isGOuh0s-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnP8ZZkee5kKAFeNhQdVFxJgcs1DREEmtEk9pN8isGOuh0s-w@mail.gmail.com>

Thu, Nov 23, 2023 at 03:29:00PM CET, mleitner@redhat.com wrote:
>On Thu, Nov 23, 2023 at 08:37:13AM -0500, Jamal Hadi Salim wrote:
>> On Thu, Nov 23, 2023 at 3:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >
>> > Fri, Nov 10, 2023 at 10:46:18PM CET, victor@mojatatu.com wrote:
>> > >This action takes advantage of the presence of tc block ports set in the
>> > >datapath and multicasts a packet to ports on a block. By default, it will
>> > >broadcast the packet to a block, that is send to all members of the block except
>> > >the port in which the packet arrived on. However, the user may specify
>> > >the option "tx_type all", which will send the packet to all members of the
>> > >block indiscriminately.
>> > >
>> > >Example usage:
>> > >    $ tc qdisc add dev ens7 ingress_block 22
>> > >    $ tc qdisc add dev ens8 ingress_block 22
>> > >
>> > >Now we can add a filter to broadcast packets to ports on ingress block id 22:
>> > >$ tc filter add block 22 protocol ip pref 25 \
>> > >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22
>> >
>> > Name the arg "block" so it is consistent with "filter add block". Make
>> > sure this is aligned netlink-wise as well.
>> >
>> >
>> > >
>> > >Or if we wish to send to all ports in the block:
>> > >$ tc filter add block 22 protocol ip pref 25 \
>> > >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 tx_type all
>> >
>> > I read the discussion the the previous version again. I suggested this
>> > to be part of mirred. Why exactly that was not addressed?
>> >
>>
>> I am the one who pushed back (in that discussion). Actions should be
>
>Me too, and actually I thought Jiri had agreed to it with some
>remarks to be addressed (which I don't know if there were, I didn't
>read this version yet).

I looked today and didn't' find it. If I missed it, sorry. I still don't
understand why new action is needed for redirect to X instead of Y.

>
>> small and specific. Like i had said in that earlier discussion it was
>> a mistake to make mirred do both mirror and redirect - they should
>> have been two actions. So i feel like adding a block to mirred is
>> adding more knobs. We are also going to add dev->group as a way to
>> select what devices to mirror to. Should that be in mirred as well?
>>
>> cheers,
>> jamal
>>
>> > Instead of:
>> > $ tc filter add block 22 protocol ip pref 25 \
>> >   flower dst_ip 192.168.0.0/16 action blockcast blockid 22
>> > You'd have:
>> > $ tc filter add block 22 protocol ip pref 25 \
>> >   flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
>> >
>> > I don't see why we need special action for this.
>> >
>> > Regarding "tx_type all":
>> > Do you expect to have another "tx_type"? Seems to me a bit odd. Why not
>> > to have this as "no_src_skip" or some other similar arg, without value
>> > acting as a bool (flag) on netlink level.
>> >
>> >
>>
>


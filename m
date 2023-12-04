Return-Path: <netdev+bounces-53432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CC7802F3C
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E21280AA2
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE4C1D55E;
	Mon,  4 Dec 2023 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LHrfQJej"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75017F5
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 01:49:57 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a195e0145acso452879066b.2
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 01:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701683396; x=1702288196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FKDrOQ3Luurl78QbveDsEJM+HcJjUaziSp8FhtwEN84=;
        b=LHrfQJejhs+qU/GQcxnJV/XFTYqwYwgLbrlP3fbH7XK9xrm+IwftFFaoMMeCRcxv12
         dlTmb7ES1MhCTs4/k2ILBDZnzxCFs9TkoHVOSS6MKPiAayvKrrxSt281Q25Ol3sDLBlX
         PxFFXFgP7SSiUNQRqPwGf91UBdqpPd5T4TfcZ9HYPM4S/xN6+iouO+aGryF7niplIN51
         4DYeApEZvLOEmm1WBNmiLIzTDvs1OBDd5GER69/X9qwlLDUS4JjnCmcyEeRsHjCCQ8c1
         8+/6rBvz2uCDb0/j25FLWR374SxlHFFw3EsTWHXL18mTFXvKasuAvqwtiCnCTIKZiBL2
         Ek0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701683396; x=1702288196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKDrOQ3Luurl78QbveDsEJM+HcJjUaziSp8FhtwEN84=;
        b=lLVEh7cxVAarTbJcSrjdoKNrlW0mHvL38MqxcTekUQeMNb3h5vt+mq4PdjaUMcpMKl
         +f/OQH6hLjFVsS5luP3DCX/hZLYZcnlCyAAnMH4VDoNnP9s7NbtAGR7RKhQn39O1K7Xo
         oLlgg5Skl0wFXf8UwTmUm44v7YSB3yqH6lRTU36uRLQ1mDfY+pXxuCHGRDtdDMSa0aPx
         oiB7dywdip9/okJZX4AeuAIgpi7YhPIsyeMH9BYP5KXB5Ff7nnJ554p3B4gXnfDQp9Is
         BLOWUDuxpCT/BwJ4guE0krdDj8WQruEZPvQqT32I+z8D7fyaQVE40RC9FGdZP6Fq8sPm
         S7+Q==
X-Gm-Message-State: AOJu0Yzp7QjPThrSWqQkxkP7/sWykY5lO0YmgaSXg7+Dx1MU8VmlLlPT
	uNOpWY99Y1eWFhlTrEqW6DtJxQ==
X-Google-Smtp-Source: AGHT+IFcWyciPkFD13/7WHVqOx6IAkgOU8n5GAaQfedz/MRw/uyYf+7mTXXAnBZo/VlZ7T2AziFALg==
X-Received: by 2002:a17:906:51c6:b0:a19:9b79:8b46 with SMTP id v6-20020a17090651c600b00a199b798b46mr2231154ejk.87.1701683395654;
        Mon, 04 Dec 2023 01:49:55 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id oz11-20020a170906cd0b00b009fc990d9edbsm5069482ejb.192.2023.12.04.01.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 01:49:54 -0800 (PST)
Date: Mon, 4 Dec 2023 10:49:53 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Marcelo Ricardo Leitner <mleitner@redhat.com>,
	Jamal Hadi Salim <hadi@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xiyou.wangcong@gmail.com, vladbu@nvidia.com, paulb@nvidia.com,
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
Message-ID: <ZW2gwaj/LBNL8J3P@nanopsycho>
References: <ZV8SnZPBV4if5umR@nanopsycho>
 <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>
 <ZV9b0HrM5WespGMW@nanopsycho>
 <CAM0EoMnwAHO_AvEYiL=aTwNBjs29ww075Lq1qwvCwuYtB_Qz7A@mail.gmail.com>
 <ZV9tCT9d7dm7dOeA@nanopsycho>
 <CAAFAkD-awfzQTO6yRYeooXwW+7zEub0BiGkbke=o=fTKpzN__g@mail.gmail.com>
 <ZV+DPmXrANEh6gF8@nanopsycho>
 <CAM0EoMkQaEAaKc7D6kVe+p6f=-Ddd7enoKgRdeWBnqbN2zPhfA@mail.gmail.com>
 <CALnP8ZbaT+jdBvaggAPW=yiW61fip6cjnZcU48tb2-5orqdeMg@mail.gmail.com>
 <CAM0EoMmso7Y0g9jQ=FfJLuV9JTDct5Qqb5-W4+nd0Xb9DBkGkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmso7Y0g9jQ=FfJLuV9JTDct5Qqb5-W4+nd0Xb9DBkGkA@mail.gmail.com>

Fri, Dec 01, 2023 at 07:45:47PM CET, jhs@mojatatu.com wrote:
>On Mon, Nov 27, 2023 at 1:52 PM Marcelo Ricardo Leitner
><mleitner@redhat.com> wrote:
>>
>> On Mon, Nov 27, 2023 at 10:50:48AM -0500, Jamal Hadi Salim wrote:
>> > On Thu, Nov 23, 2023 at 11:52 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> > >
>> > > Thu, Nov 23, 2023 at 05:21:51PM CET, hadi@mojatatu.com wrote:
>> > > >On Thu, Nov 23, 2023 at 10:17 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> > > >>
>> > > >> Thu, Nov 23, 2023 at 03:38:35PM CET, jhs@mojatatu.com wrote:
>> > > >> >On Thu, Nov 23, 2023 at 9:04 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> > > >> >>
>> > > >> >> Thu, Nov 23, 2023 at 02:37:13PM CET, jhs@mojatatu.com wrote:
>> > > >> >> >On Thu, Nov 23, 2023 at 3:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> > > >> >> >>
>> > > >> >> >> Fri, Nov 10, 2023 at 10:46:18PM CET, victor@mojatatu.com wrote:
>> > > >> >> >> >This action takes advantage of the presence of tc block ports set in the
>> > > >> >> >> >datapath and multicasts a packet to ports on a block. By default, it will
>> > > >> >> >> >broadcast the packet to a block, that is send to all members of the block except
>> > > >> >> >> >the port in which the packet arrived on. However, the user may specify
>> > > >> >> >> >the option "tx_type all", which will send the packet to all members of the
>> > > >> >> >> >block indiscriminately.
>> > > >> >> >> >
>> > > >> >> >> >Example usage:
>> > > >> >> >> >    $ tc qdisc add dev ens7 ingress_block 22
>> > > >> >> >> >    $ tc qdisc add dev ens8 ingress_block 22
>> > > >> >> >> >
>> > > >> >> >> >Now we can add a filter to broadcast packets to ports on ingress block id 22:
>> > > >> >> >> >$ tc filter add block 22 protocol ip pref 25 \
>> > > >> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22
>> > > >> >> >>
>> > > >> >> >> Name the arg "block" so it is consistent with "filter add block". Make
>> > > >> >> >> sure this is aligned netlink-wise as well.
>> > > >> >> >>
>> > > >> >> >>
>> > > >> >> >> >
>> > > >> >> >> >Or if we wish to send to all ports in the block:
>> > > >> >> >> >$ tc filter add block 22 protocol ip pref 25 \
>> > > >> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 tx_type all
>> > > >> >> >>
>> > > >> >> >> I read the discussion the the previous version again. I suggested this
>> > > >> >> >> to be part of mirred. Why exactly that was not addressed?
>> > > >> >> >>
>> > > >> >> >
>> > > >> >> >I am the one who pushed back (in that discussion). Actions should be
>> > > >> >> >small and specific. Like i had said in that earlier discussion it was
>> > > >> >> >a mistake to make mirred do both mirror and redirect - they should
>> > > >> >>
>> > > >> >> For mirror and redirect, I agree. For redirect and redirect, does not
>> > > >> >> make much sense. It's just confusing for the user.
>> > > >> >>
>> > > >> >
>> > > >> >Blockcast only emulates the mirror part. I agree redirect doesnt make
>> > > >> >any sense because once you redirect the packet is gone.
>> > > >>
>> > > >> How is it mirror? It is redirect to multiple, isn't it?
>> > > >>
>> > > >>
>> > > >> >
>> > > >> >> >have been two actions. So i feel like adding a block to mirred is
>> > > >> >> >adding more knobs. We are also going to add dev->group as a way to
>> > > >> >> >select what devices to mirror to. Should that be in mirred as well?
>> > > >> >>
>> > > >> >> I need more details.
>> > > >> >>
>> > > >> >
>> > > >> >You set any port you want to be mirrored to using ip link, example:
>> > > >> >ip link set dev $DEV1 group 2
>> > > >> >ip link set dev $DEV2 group 2
>> > > >>
>> > > >> That does not looks correct at all. Do tc stuff in tc, no?
>> > > >>
>> > > >>
>> > > >> >...
>> > > >> >
>> > > >> >Then you can blockcast:
>> > > >> >tc filter add devx protocol ip pref 25 \
>> > > >> >  flower dst_ip 192.168.0.0/16 action blockcast group 2
>> > > >>
>> > > >> "blockcasting" to something that is not a block anymore. Not nice.
>>
>> +1
>>
>> > > >>
>> > > >
>> > > >Sorry, missed this one. Yes blockcasting is no longer appropriate  -
>> > > >perhaps a different action altogether.
>> > >
>> > > mirret redirect? :)
>> > >
>> > > With target of:
>> > > 1) dev (the current one)
>> > > 2) block
>> > > 3) group
>> > > ?
>> >
>> > tbh, I dont like it - but we need to make progress. I will defer to Marcelo.
>>
>> With the addition of a new output type that I didn't foresee, that
>> AFAICS will use the same parameters as the block output, creating a
>> new action for it is a lot of boilerplate for just having a different
>> name. If these new two actions can share parsing code and everything,
>> then it's not too far for mirred also use. And if we stick to the
>> concept of one single action for outputting to multiple interfaces,
>> even just deciding on the new name became quite challenging now.
>> "groupcast" is misleading. "multicast" no good, "multimirred" not
>> intuitive, "supermirred" what? and so on..
>>
>> I still think that it will become a very complex action, but well,
>> hopefully the man page can be updated in a way to minimize the
>> confusion.
>
>Ok, so we are moving forward with mirred "mirror" option only for this then...

Could you remind me why mirror and not redirect? Does the packet
continue through the stack?


>
>cheers,
>jamal
>
>> Cheers,
>> Marcelo
>>
>> >
>> > cheers,
>> > jamal
>> >
>> > >
>> > > >
>> > > >cheers,
>> > > >jamal
>> > > >> >
>> > > >> >cheers,
>> > > >> >jamal
>> > > >> >
>> > > >> >>
>> > > >> >> >
>> > > >> >> >cheers,
>> > > >> >> >jamal
>> > > >> >> >
>> > > >> >> >> Instead of:
>> > > >> >> >> $ tc filter add block 22 protocol ip pref 25 \
>> > > >> >> >>   flower dst_ip 192.168.0.0/16 action blockcast blockid 22
>> > > >> >> >> You'd have:
>> > > >> >> >> $ tc filter add block 22 protocol ip pref 25 \
>> > > >> >> >>   flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
>> > > >> >> >>
>> > > >> >> >> I don't see why we need special action for this.
>> > > >> >> >>
>> > > >> >> >> Regarding "tx_type all":
>> > > >> >> >> Do you expect to have another "tx_type"? Seems to me a bit odd. Why not
>> > > >> >> >> to have this as "no_src_skip" or some other similar arg, without value
>> > > >> >> >> acting as a bool (flag) on netlink level.
>> > > >> >> >>
>> > > >> >> >>
>> >
>>


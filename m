Return-Path: <netdev+bounces-50602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F3A7F6465
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19EFDB20DD4
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2533D39F;
	Thu, 23 Nov 2023 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="q2/EgMOV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D85A91
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:52:17 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a002562bd8bso211465866b.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700758336; x=1701363136; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6u3MGS7GDIBFAKs2TxjC217U/5ossQpg1sc+mHVST0I=;
        b=q2/EgMOVy8rTgFjNF3U1ey7/6ryDi7ExYXbPOI67QuYfowF3NCy4ENC1Sm2wLBlaZ/
         gGwpSR37Mp1kuYA2Ty9rZfhTZkKLFCPoB6ycZHA1wdM+v5xXmc9IWjDo/uziDW/viZAr
         S+z/qFIEVjcBAoBDeASTVJfJR2Zw4qBIom5wKbxYkMUc/9/guk0Ucqtsp7wYGvabzyCx
         kNnTsMrygytxwqveQuKparHjCjFDq8PPx3OK5a0sH+geeXltfqgldT5Fue1pGlHfuvG4
         WS/gAWJpbjKvMAxzb875nYFpBm9Rc1u/prtNzVMEc4v4lu6EXoTG9mslPAYceC7d38We
         DD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700758336; x=1701363136;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6u3MGS7GDIBFAKs2TxjC217U/5ossQpg1sc+mHVST0I=;
        b=DKa4FeOgf0pho0SYhEZothlMxBK5DgNFc952alJhaHBOwCfOWv3ds7Y2H9DdLPlaf/
         /NJRhvbNUiE+nUb8k/WA6at7IOxOMDt7wvGwkQhDgKLvl9kwcb8N1Hxv+VkAahlcqqSb
         ekdvsiYCLbj+/6iaOPVR6U67FZfJ1IKZEB1elbl2iHwBmo+zVTsm0fbJ7mZF76+PT0lm
         fFbX+MHl35wKUOjoo1Pcu/tJ4XVlv3vQPMQPpL/mPprIkXtVaql6ImpL6Ucfsh7vvTQ5
         EBcimumBptvPWHjczeh+ltlTgUAkWaiNzsRP1NHt4D2/GQQMsR3ic8xN+fYxNiBq6UxU
         aINQ==
X-Gm-Message-State: AOJu0YwFI1EZVccyxaU5+wXQxFzZSQxu8t1INTB4xmLgs7zcTO5kLAAA
	Bfu7Aj9X5ROndGX8N24Zp5IM9w==
X-Google-Smtp-Source: AGHT+IE5wzSnZN8BxphK1jGKzqgnJUPar7nbjr8hJ1PKrT+YwSoiBIliOEhOJrPcwQwgArCml2tw/A==
X-Received: by 2002:a17:906:5308:b0:a01:bd67:d2fb with SMTP id h8-20020a170906530800b00a01bd67d2fbmr2708081ejo.0.1700758335741;
        Thu, 23 Nov 2023 08:52:15 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ks18-20020a170906f85200b009c503bf61c9sm979436ejb.165.2023.11.23.08.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:52:15 -0800 (PST)
Date: Thu, 23 Nov 2023 17:52:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <hadi@mojatatu.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xiyou.wangcong@gmail.com, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
Message-ID: <ZV+DPmXrANEh6gF8@nanopsycho>
References: <20231110214618.1883611-1-victor@mojatatu.com>
 <20231110214618.1883611-5-victor@mojatatu.com>
 <ZV8SnZPBV4if5umR@nanopsycho>
 <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>
 <ZV9b0HrM5WespGMW@nanopsycho>
 <CAM0EoMnwAHO_AvEYiL=aTwNBjs29ww075Lq1qwvCwuYtB_Qz7A@mail.gmail.com>
 <ZV9tCT9d7dm7dOeA@nanopsycho>
 <CAAFAkD-awfzQTO6yRYeooXwW+7zEub0BiGkbke=o=fTKpzN__g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAFAkD-awfzQTO6yRYeooXwW+7zEub0BiGkbke=o=fTKpzN__g@mail.gmail.com>

Thu, Nov 23, 2023 at 05:21:51PM CET, hadi@mojatatu.com wrote:
>On Thu, Nov 23, 2023 at 10:17 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Nov 23, 2023 at 03:38:35PM CET, jhs@mojatatu.com wrote:
>> >On Thu, Nov 23, 2023 at 9:04 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Thu, Nov 23, 2023 at 02:37:13PM CET, jhs@mojatatu.com wrote:
>> >> >On Thu, Nov 23, 2023 at 3:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> >>
>> >> >> Fri, Nov 10, 2023 at 10:46:18PM CET, victor@mojatatu.com wrote:
>> >> >> >This action takes advantage of the presence of tc block ports set in the
>> >> >> >datapath and multicasts a packet to ports on a block. By default, it will
>> >> >> >broadcast the packet to a block, that is send to all members of the block except
>> >> >> >the port in which the packet arrived on. However, the user may specify
>> >> >> >the option "tx_type all", which will send the packet to all members of the
>> >> >> >block indiscriminately.
>> >> >> >
>> >> >> >Example usage:
>> >> >> >    $ tc qdisc add dev ens7 ingress_block 22
>> >> >> >    $ tc qdisc add dev ens8 ingress_block 22
>> >> >> >
>> >> >> >Now we can add a filter to broadcast packets to ports on ingress block id 22:
>> >> >> >$ tc filter add block 22 protocol ip pref 25 \
>> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22
>> >> >>
>> >> >> Name the arg "block" so it is consistent with "filter add block". Make
>> >> >> sure this is aligned netlink-wise as well.
>> >> >>
>> >> >>
>> >> >> >
>> >> >> >Or if we wish to send to all ports in the block:
>> >> >> >$ tc filter add block 22 protocol ip pref 25 \
>> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 tx_type all
>> >> >>
>> >> >> I read the discussion the the previous version again. I suggested this
>> >> >> to be part of mirred. Why exactly that was not addressed?
>> >> >>
>> >> >
>> >> >I am the one who pushed back (in that discussion). Actions should be
>> >> >small and specific. Like i had said in that earlier discussion it was
>> >> >a mistake to make mirred do both mirror and redirect - they should
>> >>
>> >> For mirror and redirect, I agree. For redirect and redirect, does not
>> >> make much sense. It's just confusing for the user.
>> >>
>> >
>> >Blockcast only emulates the mirror part. I agree redirect doesnt make
>> >any sense because once you redirect the packet is gone.
>>
>> How is it mirror? It is redirect to multiple, isn't it?
>>
>>
>> >
>> >> >have been two actions. So i feel like adding a block to mirred is
>> >> >adding more knobs. We are also going to add dev->group as a way to
>> >> >select what devices to mirror to. Should that be in mirred as well?
>> >>
>> >> I need more details.
>> >>
>> >
>> >You set any port you want to be mirrored to using ip link, example:
>> >ip link set dev $DEV1 group 2
>> >ip link set dev $DEV2 group 2
>>
>> That does not looks correct at all. Do tc stuff in tc, no?
>>
>>
>> >...
>> >
>> >Then you can blockcast:
>> >tc filter add devx protocol ip pref 25 \
>> >  flower dst_ip 192.168.0.0/16 action blockcast group 2
>>
>> "blockcasting" to something that is not a block anymore. Not nice.
>>
>
>Sorry, missed this one. Yes blockcasting is no longer appropriate  -
>perhaps a different action altogether.

mirret redirect? :)

With target of:
1) dev (the current one)
2) block
3) group
?


>
>cheers,
>jamal
>> >
>> >cheers,
>> >jamal
>> >
>> >>
>> >> >
>> >> >cheers,
>> >> >jamal
>> >> >
>> >> >> Instead of:
>> >> >> $ tc filter add block 22 protocol ip pref 25 \
>> >> >>   flower dst_ip 192.168.0.0/16 action blockcast blockid 22
>> >> >> You'd have:
>> >> >> $ tc filter add block 22 protocol ip pref 25 \
>> >> >>   flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
>> >> >>
>> >> >> I don't see why we need special action for this.
>> >> >>
>> >> >> Regarding "tx_type all":
>> >> >> Do you expect to have another "tx_type"? Seems to me a bit odd. Why not
>> >> >> to have this as "no_src_skip" or some other similar arg, without value
>> >> >> acting as a bool (flag) on netlink level.
>> >> >>
>> >> >>


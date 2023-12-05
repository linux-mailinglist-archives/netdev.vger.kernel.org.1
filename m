Return-Path: <netdev+bounces-53834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96DF804CC7
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14CE41C20D52
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 08:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ABD241E8;
	Tue,  5 Dec 2023 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YckqmP0P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE2D9C
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 00:41:05 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54c846da5e9so2461147a12.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 00:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701765664; x=1702370464; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4gvIYZNGKC5V1TKXAsB6opS8k0gKBhdEDI5JBpE5yRI=;
        b=YckqmP0PEsLzRd8fLw7B2EbAnyxSCJCijEMaMC2X/hB6G+DvjJoMG7QLBWMalM/mlv
         zYFHvxud/srYLe6lax7vna0exPWL3NtWoDqEN0Y0y8v7oW4l+z6cxBKP9+Rb9t4eMVuu
         g2gY8T6pdjMtDx2N90LUtzF0Qiju6WJrXRdHVI1lIIOcxerHBp9H3gppAogTY+hpOu2j
         uchRLUbXYGAbWRFSJEe6akP3YFRj+FPl0bcVTVaDd489l/jDz/DqitA76kpLE7GK2aYw
         0/rZFVnzTGP29agoHhKoy7zRTDgA+WlPRHlK6pqyPRfoDUlvWp0NieyRhQIz/2V19rg/
         f1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765664; x=1702370464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gvIYZNGKC5V1TKXAsB6opS8k0gKBhdEDI5JBpE5yRI=;
        b=j72TNeYrCLtOmURW+MNCyoE/gAmR8jIZSB8Ij9NNnu212BbpmwFZ9KLgDvLlhEOcHO
         RFbA8ITNDvz3kfvwXucl6p/Ztzzw3MZIktLZoAG0lzS45bNUke5Bzi+Z5n3TxDrnhgB4
         9Hy29WrIEDy1E92CZYB57bRrQiRKGUcWPgUkAdNAL6zXJeG9X6ATpBPAjSotw6YM8zUq
         tWakWP+dXn1bxHNonCxM0l4cxsPhE6Q+sWK0uMYYU+CGLDV7ML7e72HAONu+22+/hTdc
         FD0+aanv9K4FuzCGs0yOmbOdRaB+UNRHIBx24L03aHhZAsg5VuuHlb9nmUykSgXE4+I0
         5JvA==
X-Gm-Message-State: AOJu0Yw5Tk78oMvAdfBQEMXvXh7jmMP3HG+UgJxrsNN3UTVLBDbmoz6Y
	/7zFZKTG+f0kd1yGLKaVHrRS9w==
X-Google-Smtp-Source: AGHT+IFgBK20UXoI1hWHYBOOTTulTwp6tvH8cR2S4DYdBQKIpVPE9we21jY1uk0BJKJBz6B/64djew==
X-Received: by 2002:a50:d68d:0:b0:54b:53f0:2696 with SMTP id r13-20020a50d68d000000b0054b53f02696mr3842151edi.30.1701765664023;
        Tue, 05 Dec 2023 00:41:04 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f26-20020aa7d85a000000b0054ccc3b2109sm763476eds.57.2023.12.05.00.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:41:03 -0800 (PST)
Date: Tue, 5 Dec 2023 09:41:02 +0100
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
Message-ID: <ZW7iHub0oM5SZ/SF@nanopsycho>
References: <ZV9b0HrM5WespGMW@nanopsycho>
 <CAM0EoMnwAHO_AvEYiL=aTwNBjs29ww075Lq1qwvCwuYtB_Qz7A@mail.gmail.com>
 <ZV9tCT9d7dm7dOeA@nanopsycho>
 <CAAFAkD-awfzQTO6yRYeooXwW+7zEub0BiGkbke=o=fTKpzN__g@mail.gmail.com>
 <ZV+DPmXrANEh6gF8@nanopsycho>
 <CAM0EoMkQaEAaKc7D6kVe+p6f=-Ddd7enoKgRdeWBnqbN2zPhfA@mail.gmail.com>
 <CALnP8ZbaT+jdBvaggAPW=yiW61fip6cjnZcU48tb2-5orqdeMg@mail.gmail.com>
 <CAM0EoMmso7Y0g9jQ=FfJLuV9JTDct5Qqb5-W4+nd0Xb9DBkGkA@mail.gmail.com>
 <ZW2gwaj/LBNL8J3P@nanopsycho>
 <CAM0EoMmvkT5JEm7tUNa-zGD1g80usR=KUAF0zO5uDV70Z-5hmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmvkT5JEm7tUNa-zGD1g80usR=KUAF0zO5uDV70Z-5hmA@mail.gmail.com>

Mon, Dec 04, 2023 at 09:10:18PM CET, jhs@mojatatu.com wrote:
>On Mon, Dec 4, 2023 at 4:49 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Fri, Dec 01, 2023 at 07:45:47PM CET, jhs@mojatatu.com wrote:
>> >On Mon, Nov 27, 2023 at 1:52 PM Marcelo Ricardo Leitner
>> ><mleitner@redhat.com> wrote:
>> >>
>> >> On Mon, Nov 27, 2023 at 10:50:48AM -0500, Jamal Hadi Salim wrote:
>> >> > On Thu, Nov 23, 2023 at 11:52 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> > >
>> >> > > Thu, Nov 23, 2023 at 05:21:51PM CET, hadi@mojatatu.com wrote:
>> >> > > >On Thu, Nov 23, 2023 at 10:17 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> > > >>
>> >> > > >> Thu, Nov 23, 2023 at 03:38:35PM CET, jhs@mojatatu.com wrote:
>> >> > > >> >On Thu, Nov 23, 2023 at 9:04 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> > > >> >>
>> >> > > >> >> Thu, Nov 23, 2023 at 02:37:13PM CET, jhs@mojatatu.com wrote:
>> >> > > >> >> >On Thu, Nov 23, 2023 at 3:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> > > >> >> >>
>> >> > > >> >> >> Fri, Nov 10, 2023 at 10:46:18PM CET, victor@mojatatu.com wrote:
>> >> > > >> >> >> >This action takes advantage of the presence of tc block ports set in the
>> >> > > >> >> >> >datapath and multicasts a packet to ports on a block. By default, it will
>> >> > > >> >> >> >broadcast the packet to a block, that is send to all members of the block except
>> >> > > >> >> >> >the port in which the packet arrived on. However, the user may specify
>> >> > > >> >> >> >the option "tx_type all", which will send the packet to all members of the
>> >> > > >> >> >> >block indiscriminately.
>> >> > > >> >> >> >
>> >> > > >> >> >> >Example usage:
>> >> > > >> >> >> >    $ tc qdisc add dev ens7 ingress_block 22
>> >> > > >> >> >> >    $ tc qdisc add dev ens8 ingress_block 22
>> >> > > >> >> >> >
>> >> > > >> >> >> >Now we can add a filter to broadcast packets to ports on ingress block id 22:
>> >> > > >> >> >> >$ tc filter add block 22 protocol ip pref 25 \
>> >> > > >> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22
>> >> > > >> >> >>
>> >> > > >> >> >> Name the arg "block" so it is consistent with "filter add block". Make
>> >> > > >> >> >> sure this is aligned netlink-wise as well.
>> >> > > >> >> >>
>> >> > > >> >> >>
>> >> > > >> >> >> >
>> >> > > >> >> >> >Or if we wish to send to all ports in the block:
>> >> > > >> >> >> >$ tc filter add block 22 protocol ip pref 25 \
>> >> > > >> >> >> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 tx_type all
>> >> > > >> >> >>
>> >> > > >> >> >> I read the discussion the the previous version again. I suggested this
>> >> > > >> >> >> to be part of mirred. Why exactly that was not addressed?
>> >> > > >> >> >>
>> >> > > >> >> >
>> >> > > >> >> >I am the one who pushed back (in that discussion). Actions should be
>> >> > > >> >> >small and specific. Like i had said in that earlier discussion it was
>> >> > > >> >> >a mistake to make mirred do both mirror and redirect - they should
>> >> > > >> >>
>> >> > > >> >> For mirror and redirect, I agree. For redirect and redirect, does not
>> >> > > >> >> make much sense. It's just confusing for the user.
>> >> > > >> >>
>> >> > > >> >
>> >> > > >> >Blockcast only emulates the mirror part. I agree redirect doesnt make
>> >> > > >> >any sense because once you redirect the packet is gone.
>> >> > > >>
>> >> > > >> How is it mirror? It is redirect to multiple, isn't it?
>> >> > > >>
>> >> > > >>
>> >> > > >> >
>> >> > > >> >> >have been two actions. So i feel like adding a block to mirred is
>> >> > > >> >> >adding more knobs. We are also going to add dev->group as a way to
>> >> > > >> >> >select what devices to mirror to. Should that be in mirred as well?
>> >> > > >> >>
>> >> > > >> >> I need more details.
>> >> > > >> >>
>> >> > > >> >
>> >> > > >> >You set any port you want to be mirrored to using ip link, example:
>> >> > > >> >ip link set dev $DEV1 group 2
>> >> > > >> >ip link set dev $DEV2 group 2
>> >> > > >>
>> >> > > >> That does not looks correct at all. Do tc stuff in tc, no?
>> >> > > >>
>> >> > > >>
>> >> > > >> >...
>> >> > > >> >
>> >> > > >> >Then you can blockcast:
>> >> > > >> >tc filter add devx protocol ip pref 25 \
>> >> > > >> >  flower dst_ip 192.168.0.0/16 action blockcast group 2
>> >> > > >>
>> >> > > >> "blockcasting" to something that is not a block anymore. Not nice.
>> >>
>> >> +1
>> >>
>> >> > > >>
>> >> > > >
>> >> > > >Sorry, missed this one. Yes blockcasting is no longer appropriate  -
>> >> > > >perhaps a different action altogether.
>> >> > >
>> >> > > mirret redirect? :)
>> >> > >
>> >> > > With target of:
>> >> > > 1) dev (the current one)
>> >> > > 2) block
>> >> > > 3) group
>> >> > > ?
>> >> >
>> >> > tbh, I dont like it - but we need to make progress. I will defer to Marcelo.
>> >>
>> >> With the addition of a new output type that I didn't foresee, that
>> >> AFAICS will use the same parameters as the block output, creating a
>> >> new action for it is a lot of boilerplate for just having a different
>> >> name. If these new two actions can share parsing code and everything,
>> >> then it's not too far for mirred also use. And if we stick to the
>> >> concept of one single action for outputting to multiple interfaces,
>> >> even just deciding on the new name became quite challenging now.
>> >> "groupcast" is misleading. "multicast" no good, "multimirred" not
>> >> intuitive, "supermirred" what? and so on..
>> >>
>> >> I still think that it will become a very complex action, but well,
>> >> hopefully the man page can be updated in a way to minimize the
>> >> confusion.
>> >
>> >Ok, so we are moving forward with mirred "mirror" option only for this then...
>>
>> Could you remind me why mirror and not redirect? Does the packet
>> continue through the stack?
>
>For mirror it is _a copy_ of the packet so it continues up the stack
>and you can have other actions follow it (including multiple mirrors
>after the first mirror). For redirect the packet is TC_ACT_CONSUMED -
>so removed from the stack processing (and cant be sent to more ports).
>That is how mirred has always worked and i believe thats how most
>hardware works as well.
>So sending to multiple ports has to be mirroring semantics (most
>hardware assumes the same semantics).

You assume cloning (sending to multiple ports) means mirror,
that is I believe a mistake. Look at it from the perspective of
replacing device by target for each action. Currently we have:

1) mirred mirror TARGET_DEVICE
   Clones, sends to TARGET_DEVICE and continues up the stack
2) mirred redirect TARGET_DEVICE
   Sends to TARGET_DEVICE, nothing is sent up the stack

For block target, there should be exacly the same semantics:

1) mirred mirror TARGET_BLOCK
   Clones (multiple times, for each block member), sends to TARGET_BLOCK
   and continues up the stack
2) mirred redirect TARGET_BLOCK
   Clones (multiple times, for each block member - 1), sends to
   TARGET_BLOCK, nothing is sent up the stack



>
>cheers,
>jamal
>
>>
>> >
>> >cheers,
>> >jamal
>> >
>> >> Cheers,
>> >> Marcelo
>> >>
>> >> >
>> >> > cheers,
>> >> > jamal
>> >> >
>> >> > >
>> >> > > >
>> >> > > >cheers,
>> >> > > >jamal
>> >> > > >> >
>> >> > > >> >cheers,
>> >> > > >> >jamal
>> >> > > >> >
>> >> > > >> >>
>> >> > > >> >> >
>> >> > > >> >> >cheers,
>> >> > > >> >> >jamal
>> >> > > >> >> >
>> >> > > >> >> >> Instead of:
>> >> > > >> >> >> $ tc filter add block 22 protocol ip pref 25 \
>> >> > > >> >> >>   flower dst_ip 192.168.0.0/16 action blockcast blockid 22
>> >> > > >> >> >> You'd have:
>> >> > > >> >> >> $ tc filter add block 22 protocol ip pref 25 \
>> >> > > >> >> >>   flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
>> >> > > >> >> >>
>> >> > > >> >> >> I don't see why we need special action for this.
>> >> > > >> >> >>
>> >> > > >> >> >> Regarding "tx_type all":
>> >> > > >> >> >> Do you expect to have another "tx_type"? Seems to me a bit odd. Why not
>> >> > > >> >> >> to have this as "no_src_skip" or some other similar arg, without value
>> >> > > >> >> >> acting as a bool (flag) on netlink level.
>> >> > > >> >> >>
>> >> > > >> >> >>
>> >> >
>> >>


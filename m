Return-Path: <netdev+bounces-50601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6597F6464
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B1F28198C
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96933E46B;
	Thu, 23 Nov 2023 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UJakKzA+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF2810CF
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:51:15 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a03a9009572so140204966b.3
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700758274; x=1701363074; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qYKmQ4OvqkfMEXpdSiBMoCLw1RSZ6d3cZjuHGfNHz0o=;
        b=UJakKzA+CUtRSwXq2wYRZSpwZZND9+/0mvbiRuqsrrxcYBYj+3CUrSZXjUDt/LFq1H
         kbJzmNkizOIc1UKkkTL3PpddbKIO57DAVNeuiY4lOpv0xpw6eE9+A+PtIBuXhKxY7Ms8
         WLt19MHfHEYUwTqDvTiLXE5UXr7XMieYwOHj9oRHBvvk2GeXoELp4559P6GSO5O8yBNG
         hqqpe3yWAJ4eKdI5ccbl4q64EL6hCMx6z8M+2L3fnHDaVGKRVKmZf8qMqsZKH3sHcqXw
         3/ZYp9Pv0Hx6d97crr4ac9WDKgpK2zwxNOWm46MjSwz5X3hLqy41If0QReBntjdZVurk
         Z89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700758274; x=1701363074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYKmQ4OvqkfMEXpdSiBMoCLw1RSZ6d3cZjuHGfNHz0o=;
        b=s9yARlOR/1uWeyka/LUK/pwc+Oj51Jl1iHor5lDnNBQ7TiC9KL+mAM7Jkhj1h2uBVi
         h+GKnfzrqurDavpPc70O7cSLcIWH4wkcJ0YhYShQzd3awWbD7O8Ch2lJ5hkH4fo8AHZx
         NwRfYygOU66Jhhe4s/lfXXGLXuzI/zbiPU8WfeNmAtvNthxvj6chdducVjqGM918r+Ve
         MMrxsN8OmFxFHMlGVTpn08VgWAp4OMiCnWuGO6KzHXMY9lFHyTNXjShy7mEpERfPxpo8
         8lcfOFr0RIHXwbTE9+Ifw11mviOKqZrmUuqrn9x39gZTtDCqkrDd3KTwqX/AmRpqcgkv
         zaeA==
X-Gm-Message-State: AOJu0YygiPr4/nkIDXbKEWjehiGnwl0FuRN8O83943hB5txNWoSdCFeB
	Er8P9g1oY+ujNncIUxgn7cV49Q==
X-Google-Smtp-Source: AGHT+IGaPkSs5GhkCywLoY2S+LsJnEJWqWxICYS0NjaZLD8pgt1AqnkNf3f2GPTOPjdDfBl7lMjnFw==
X-Received: by 2002:a17:907:801d:b0:a04:995b:6a96 with SMTP id ft29-20020a170907801d00b00a04995b6a96mr3498923ejc.26.1700758274070;
        Thu, 23 Nov 2023 08:51:14 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k18-20020a170906579200b009ffe3e82bbasm986337ejq.136.2023.11.23.08.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:51:13 -0800 (PST)
Date: Thu, 23 Nov 2023 17:51:12 +0100
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
Message-ID: <ZV+DAMUwzW92trVS@nanopsycho>
References: <20231110214618.1883611-1-victor@mojatatu.com>
 <20231110214618.1883611-5-victor@mojatatu.com>
 <ZV8SnZPBV4if5umR@nanopsycho>
 <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>
 <ZV9b0HrM5WespGMW@nanopsycho>
 <CAM0EoMnwAHO_AvEYiL=aTwNBjs29ww075Lq1qwvCwuYtB_Qz7A@mail.gmail.com>
 <ZV9tCT9d7dm7dOeA@nanopsycho>
 <CAAFAkD8G+m6foAjyc==njMw6zzCyRcQKwWaPnhnudVcWBGP0HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAFAkD8G+m6foAjyc==njMw6zzCyRcQKwWaPnhnudVcWBGP0HQ@mail.gmail.com>

Thu, Nov 23, 2023 at 05:20:27PM CET, hadi@mojatatu.com wrote:
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
>
>mirror has been used (so far in mirred action and i believe in the
>industry in general) to mean  "send a copy of the packet" - meaning
>you can send to many ports and even when you are done sending to all
>those ports the packet is still in the pipeline and you can continue
>to execute other action on it. Whereas redirect means the packet is
>stolen from the pipeline i.e if you redirect to a port the packet is
>not available to redirect to the next port or for any other action
>after that.
>You could argue a loose interpretation of redirect to a block to mean
>"mirror to all ports on the block but on the last port redirect".

it's stolen from the pipeline, right? That would be redirect from my
perspective.


>
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
>
>We could certainly annotate the dev group via tc but it seems odd ....
>
>cheers,
>jamal
>>
>> >...
>> >
>> >Then you can blockcast:
>> >tc filter add devx protocol ip pref 25 \
>> >  flower dst_ip 192.168.0.0/16 action blockcast group 2
>>
>> "blockcasting" to something that is not a block anymore. Not nice.
>>
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


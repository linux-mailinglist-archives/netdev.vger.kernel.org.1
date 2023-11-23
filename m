Return-Path: <netdev+bounces-50545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835A47F60FD
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A801C21069
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA622E83E;
	Thu, 23 Nov 2023 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HUtb9Hgj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E1AD50
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:04:03 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a0064353af8so389963566b.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 06:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700748242; x=1701353042; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vp0FrGivVs4yCWv/dN/nvmU5zXDj82c70KYcbWhJHc8=;
        b=HUtb9Hgjhy0EUQtr7rSpkvSejrSR/lIFpatQjsYHyAf0KtMIFHRL4+tyvtwliBPcli
         /GEKytQak/nT1h2JysFAzCPTJxKI93tOTvWIUZpajfuNmPYeABqCCQkUc7pnkVNHb126
         G+KxaAivz8Agh6YVZ0mrjMvX/jWHtRmzjgsHEs2hHGD8QBCIAhUGZBTznRTWfdf0Qb5g
         H66K2MoD5KM7Yx28yzpi96WZFpmH9vXmLJ0lMZXyWz/poQe6ZWTRt7Iy1Py+2Pr96t0Y
         9SOFUUKgQyW701BF4icmeeH2nUCmqOD2JzAM4LfujHNiOp+6/Cz5AjNZY0oeoGJf8ZQ8
         9LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700748242; x=1701353042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vp0FrGivVs4yCWv/dN/nvmU5zXDj82c70KYcbWhJHc8=;
        b=dqllBIz4Hn10GqVTyjnchyZOgfvgPDgtXeebvu/nl1N2Ow+lu65EqGxv2IW2cnkjab
         zPXcM92Z2Vv0vP098zBnQkkg2XtDCwfdXuerq9hWo6YNVUM8BDabtcH6zPsXaz9CsBcp
         szu1UbpwPq24oTXfXaRZY8e/af12xJ9RxSduzxv5vSiTTdNYSz2qjEUcnxzrTBQP0zez
         ZJWuG6xUu7RK+ksa433QHoYV0p7sEUbOgluZ/Bf6e5VchxtCLfxV5n8KvHlGF3R9re60
         PhSuGSc0iaXN8PepHQqoGoiyW7XZzwKP0c+fzZbdLancSRAF8gF4Oh6gBiuK4F22l94S
         PlVg==
X-Gm-Message-State: AOJu0YzCLlgJHfVe3Y0R7sqeTW0sbxHHTL6ZVCC28NxTFZhYOpFfFgPi
	95omFQ5/S7gwbout+Yj8fVV+zQ==
X-Google-Smtp-Source: AGHT+IH/PXM3yuzQlHUa6uS6rtofkXHx0g/PsQ42TgRDFYQXorBERTO9kUddOeDz2esRhI8a2fpk8Q==
X-Received: by 2002:a17:906:240b:b0:9c7:59ff:b7fd with SMTP id z11-20020a170906240b00b009c759ffb7fdmr2416748eja.28.1700748242345;
        Thu, 23 Nov 2023 06:04:02 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v5-20020a170906488500b0099cc3c7ace2sm832577ejq.140.2023.11.23.06.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 06:04:01 -0800 (PST)
Date: Thu, 23 Nov 2023 15:04:00 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xiyou.wangcong@gmail.com, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
Message-ID: <ZV9b0HrM5WespGMW@nanopsycho>
References: <20231110214618.1883611-1-victor@mojatatu.com>
 <20231110214618.1883611-5-victor@mojatatu.com>
 <ZV8SnZPBV4if5umR@nanopsycho>
 <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMnwM836zTWJJsLa0QcqByGkcw0dMs8ScW7Cct3aBAQOMw@mail.gmail.com>

Thu, Nov 23, 2023 at 02:37:13PM CET, jhs@mojatatu.com wrote:
>On Thu, Nov 23, 2023 at 3:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Fri, Nov 10, 2023 at 10:46:18PM CET, victor@mojatatu.com wrote:
>> >This action takes advantage of the presence of tc block ports set in the
>> >datapath and multicasts a packet to ports on a block. By default, it will
>> >broadcast the packet to a block, that is send to all members of the block except
>> >the port in which the packet arrived on. However, the user may specify
>> >the option "tx_type all", which will send the packet to all members of the
>> >block indiscriminately.
>> >
>> >Example usage:
>> >    $ tc qdisc add dev ens7 ingress_block 22
>> >    $ tc qdisc add dev ens8 ingress_block 22
>> >
>> >Now we can add a filter to broadcast packets to ports on ingress block id 22:
>> >$ tc filter add block 22 protocol ip pref 25 \
>> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22
>>
>> Name the arg "block" so it is consistent with "filter add block". Make
>> sure this is aligned netlink-wise as well.
>>
>>
>> >
>> >Or if we wish to send to all ports in the block:
>> >$ tc filter add block 22 protocol ip pref 25 \
>> >  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 tx_type all
>>
>> I read the discussion the the previous version again. I suggested this
>> to be part of mirred. Why exactly that was not addressed?
>>
>
>I am the one who pushed back (in that discussion). Actions should be
>small and specific. Like i had said in that earlier discussion it was
>a mistake to make mirred do both mirror and redirect - they should

For mirror and redirect, I agree. For redirect and redirect, does not
make much sense. It's just confusing for the user.


>have been two actions. So i feel like adding a block to mirred is
>adding more knobs. We are also going to add dev->group as a way to
>select what devices to mirror to. Should that be in mirred as well?

I need more details.


>
>cheers,
>jamal
>
>> Instead of:
>> $ tc filter add block 22 protocol ip pref 25 \
>>   flower dst_ip 192.168.0.0/16 action blockcast blockid 22
>> You'd have:
>> $ tc filter add block 22 protocol ip pref 25 \
>>   flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22
>>
>> I don't see why we need special action for this.
>>
>> Regarding "tx_type all":
>> Do you expect to have another "tx_type"? Seems to me a bit odd. Why not
>> to have this as "no_src_skip" or some other similar arg, without value
>> acting as a bool (flag) on netlink level.
>>
>>


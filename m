Return-Path: <netdev+bounces-54318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E5E8068FF
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 08:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11AE1F211B7
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 07:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E1F182AB;
	Wed,  6 Dec 2023 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="L3YAIfNP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2162D50
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 23:55:58 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c09dfd82aso44513795e9.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 23:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701849357; x=1702454157; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ak/OnPwBf8e0M0LGkfCI+Sl8z6MgqYsX+2xH7aaCSWg=;
        b=L3YAIfNPSGlGp/saIklMXnBlrF5RFT/3cBHeuEoHcYkX63jwY6iihQWrbihlkbCtiz
         J9Nt5rvgSSzVfkYUQyRQ7uzsHT+TBxaf/WVpZ0C89mH5LPqxQfWpI/lJ/PMT5CivMwVp
         jyAMD05Xmj+LtFFz05VwqlZJMGgwac+KpOyaUDHznhcGEcKuMWw9+R2LVAhYytEkih4M
         eL46GWj7z5QCYBVAQ7Ro0U+dResz9Qg2z2vm/kZNU6WzpNBMszyFIqjzZbIOqpNI2/QZ
         +7e9qJv+pQ9P/VrCiVntOjNdkUQBYizAJ7wHxWsJAKS/U9OH0VveeFI1gPCd2ZeJmLZS
         5xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701849357; x=1702454157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ak/OnPwBf8e0M0LGkfCI+Sl8z6MgqYsX+2xH7aaCSWg=;
        b=T43VPAJ+yCmgGzdVM1ok9/BpGIaiWFH8mu8cMEhGAPpyvFAnXwH1oRK/Isxx0dD+aE
         sqb9Q+21PZEU91zA/5xfDxqfx1WfYT+B9JOCc42JhBt9m6oRN2DJwBrmEg/Ri/4BbJSy
         Mi2+ZKsnBMRg2tRfr+fGOnSVM9UM8I4zqKop5pFnobiqjnc52Ci61V/rxXi0JBLcDFTj
         81VSVCDJJdn5QcdTErQmI56sdHVwnLzYR0PXdK3t7SCEIDx0k4GM+DrH18JPva58r+XC
         i8aoWsp3x0wtzghAhfFwQ1GLzn4JUqDVsUpjk+5/euzQC6tN/SepktGuF6EWypgnO7Dt
         f73A==
X-Gm-Message-State: AOJu0YxIv775TeyWuDIy3zzW1u1s4eaG5TA6kzGrFrT3Wo0V7wj4uEr4
	Rx5eKmUN6jClEMIzajeyH62Ssg==
X-Google-Smtp-Source: AGHT+IG5XWtSLPuVZ6gBtPCoN5YGVt8emO30tz237w331E3Vn90zOnLLCI7MW20cCcqCmy7zanWgVQ==
X-Received: by 2002:a05:600c:4751:b0:40b:2bad:7f61 with SMTP id w17-20020a05600c475100b0040b2bad7f61mr362428wmo.10.1701849357166;
        Tue, 05 Dec 2023 23:55:57 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id f14-20020a170906084e00b00a1d4a920dffsm926845ejd.88.2023.12.05.23.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 23:55:56 -0800 (PST)
Date: Wed, 6 Dec 2023 08:55:55 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jamal Hadi Salim <hadi@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	xiyou.wangcong@gmail.com, vladbu@nvidia.com, paulb@nvidia.com,
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
Message-ID: <ZXApC8od2deGjKYi@nanopsycho>
References: <ZV+DPmXrANEh6gF8@nanopsycho>
 <CAM0EoMkQaEAaKc7D6kVe+p6f=-Ddd7enoKgRdeWBnqbN2zPhfA@mail.gmail.com>
 <CALnP8ZbaT+jdBvaggAPW=yiW61fip6cjnZcU48tb2-5orqdeMg@mail.gmail.com>
 <CAM0EoMmso7Y0g9jQ=FfJLuV9JTDct5Qqb5-W4+nd0Xb9DBkGkA@mail.gmail.com>
 <ZW2gwaj/LBNL8J3P@nanopsycho>
 <CAM0EoMmvkT5JEm7tUNa-zGD1g80usR=KUAF0zO5uDV70Z-5hmA@mail.gmail.com>
 <ZW7iHub0oM5SZ/SF@nanopsycho>
 <CALnP8ZYm2T1TaajZ6RejyaHqhs71VrVGfYr-+Ssj=7GhmwO0Hw@mail.gmail.com>
 <CAM0EoMmax-t+ZiaQAOJxhDOtRK2Gi3_TcqVoLEhDQWjsfOaRJQ@mail.gmail.com>
 <CALnP8Zavd8N=9n42sbeKqE-mMKXHsFtmCHKOuG7sZEN5Z8m7kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnP8Zavd8N=9n42sbeKqE-mMKXHsFtmCHKOuG7sZEN5Z8m7kw@mail.gmail.com>

Tue, Dec 05, 2023 at 11:12:23PM CET, mleitner@redhat.com wrote:
>On Tue, Dec 05, 2023 at 10:27:31AM -0500, Jamal Hadi Salim wrote:
>> On Tue, Dec 5, 2023 at 9:52 AM Marcelo Ricardo Leitner
>> <mleitner@redhat.com> wrote:
>> >
>> > On Tue, Dec 05, 2023 at 09:41:02AM +0100, Jiri Pirko wrote:
>> > > Mon, Dec 04, 2023 at 09:10:18PM CET, jhs@mojatatu.com wrote:
>> > > >On Mon, Dec 4, 2023 at 4:49 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> > > >>
>> > > >> Fri, Dec 01, 2023 at 07:45:47PM CET, jhs@mojatatu.com wrote:
>> > ...
>> > > >> >Ok, so we are moving forward with mirred "mirror" option only for this then...
>> > > >>
>> > > >> Could you remind me why mirror and not redirect? Does the packet
>> > > >> continue through the stack?
>> > > >
>> > > >For mirror it is _a copy_ of the packet so it continues up the stack
>> > > >and you can have other actions follow it (including multiple mirrors
>> > > >after the first mirror). For redirect the packet is TC_ACT_CONSUMED -
>> > > >so removed from the stack processing (and cant be sent to more ports).
>> > > >That is how mirred has always worked and i believe thats how most
>> > > >hardware works as well.
>> > > >So sending to multiple ports has to be mirroring semantics (most
>> > > >hardware assumes the same semantics).
>> > >
>> > > You assume cloning (sending to multiple ports) means mirror,
>> > > that is I believe a mistake. Look at it from the perspective of
>> > > replacing device by target for each action. Currently we have:
>> > >
>> > > 1) mirred mirror TARGET_DEVICE
>> > >    Clones, sends to TARGET_DEVICE and continues up the stack
>> > > 2) mirred redirect TARGET_DEVICE
>> > >    Sends to TARGET_DEVICE, nothing is sent up the stack
>> > >
>> > > For block target, there should be exacly the same semantics:
>> > >
>> > > 1) mirred mirror TARGET_BLOCK
>> > >    Clones (multiple times, for each block member), sends to TARGET_BLOCK
>> > >    and continues up the stack
>> > > 2) mirred redirect TARGET_BLOCK
>> > >    Clones (multiple times, for each block member - 1), sends to
>> > >    TARGET_BLOCK, nothing is sent up the stack
>> >
>> > This makes sense to me as well. When I first read Jamal's email I
>> > didn't spot any confusion, but now I see there can be some. I think he
>> > meant pretty much the same thing, referencing cascading other outputs
>> > after blockcast (and not the inner outputs, lets say), but that's just
>> > my interpretation. :)
>>
>> In my (shall i say long experience) I have never seen the prescribed
>> behavior of redirect meaning mirror to (all - last one) then redirect
>> on last one.. Jiri, does spectrum work like this?
>> Neither in s/w nor in h/w. From h/w - example, the nvidia CX6 you have
>> to give explicit mirror, mirror, mirror, redirect. IOW, i dont think
>> the hardware can be told "here's a list of ports, please mirror to all
>> of them and for the last one steal the packet and redirect".
>
>Precisely. I/(we?) were talking about tc sw/user expectations, not how
>to offload it.
>
>From a tc user perspective, the user should still be able to do this:
>1) mirred mirror TARGET_BLOCK
>2) mirred redirect TARGET_BLOCK
>regardless of how the implementation actually works. Because ovs and
>other users will rely on this semantic.

Exactly. Forget about hw for now.


>
>As for the actual implementation, as you said, it will have to somehow
>unpack that into "[mirror, mirror, ...,] <mirror/redirect>", depending
>on what the user requested, as I doubt there will be hw support for
>outputting to multiple ports in one action.
>
>> Having said that i am not opposed to it - it will just make the code
>> slightly more complex and i am sure slightly slower in the datapath.
>>
>> cheers,
>> jamal
>>
>


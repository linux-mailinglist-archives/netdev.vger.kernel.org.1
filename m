Return-Path: <netdev+bounces-53991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730B58058A0
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE3B281CA1
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA8868EA1;
	Tue,  5 Dec 2023 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="d6NIrTO+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC12483
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 07:27:43 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d719a2004fso23750807b3.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 07:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701790063; x=1702394863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7NMZBJFuzJm9QBSqDeCnakSBPeijOZp7b6KYiwK9sU=;
        b=d6NIrTO+jku1s3fp5i7AW/CinZBicOfjIyx/eFwd4l9HLeipMIZJGhidF0dZkttXE4
         G+xsCiwbntSOg5Gqs/55NILN+KhZBafrxL+mMRc/yVXMEaCS2ihGDMDRVoVJo4/CLmrs
         dIyjOjQ8fvc1cb3ZHTNi8kwoale/xXvh/WARIPbJRc4a0cDexCwT8MeGX9PdYRw5paEK
         7MIURJnpZsrf29L/aIjr3GBApGdf98FBjOELQAwIH0HnZ+iVpyWGGEeXBwKKqid3j2VA
         0aZYHTcPHOTWOQSUp35yMpS4Qlg79zXA0OuWOQLWjqO0P6pAcT4sQ2jGEmhNUIlWJSCa
         Fg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790063; x=1702394863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7NMZBJFuzJm9QBSqDeCnakSBPeijOZp7b6KYiwK9sU=;
        b=Dv1nAbNx6n07rRVNyREQXMC+M5gSNsyVAKeHArfFaNpmx5/dP3xizfC7RUjRdQ8SIM
         wADZIBFHVfqPsFsO6l1C0wcCR/tV89zYuquUoELSqj6xqzSSn+3Y0h0B1fdgv1gchl3X
         XnUGEXR92xa/MC2rjgGtXTKDh6TmlPC8YHZylfkchcTH11EZw2eyr9Euqza8YV9Pf+zY
         KXilmdu2xLTypdNb/hPWciUlqL/DTgMsUj+I8kFUy0/CdzS7OeukAV2ZoOc9/NIBOqhL
         WGKfXXNGcYqKMZhEaQOkX44LUxXwSLMKKH4CTAmxTA/nxrcHRDrp0aYoZiuBpVopYxr9
         e9Vw==
X-Gm-Message-State: AOJu0YwmNQT0zc5uxbmR2QFwxU6z69Uo6NB5jQ2c53hQdNQz3z4Khg7w
	4/cGgQHhUcNYpX7IjWPhEl+1/Z+MQhJix56DE+HrdDlwIGxC92m/
X-Google-Smtp-Source: AGHT+IEHd/PFJoDos4SbsYnXSfYkz28GiyIuHqh3uNGMY9nOEwZ+4T3tZkiUWWR3P2CZcQ1czcCQob5d76iUvisd+TA=
X-Received: by 2002:a81:9b04:0:b0:5d7:1940:8dde with SMTP id
 s4-20020a819b04000000b005d719408ddemr2828349ywg.69.1701790063052; Tue, 05 Dec
 2023 07:27:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMnwAHO_AvEYiL=aTwNBjs29ww075Lq1qwvCwuYtB_Qz7A@mail.gmail.com>
 <ZV9tCT9d7dm7dOeA@nanopsycho> <CAAFAkD-awfzQTO6yRYeooXwW+7zEub0BiGkbke=o=fTKpzN__g@mail.gmail.com>
 <ZV+DPmXrANEh6gF8@nanopsycho> <CAM0EoMkQaEAaKc7D6kVe+p6f=-Ddd7enoKgRdeWBnqbN2zPhfA@mail.gmail.com>
 <CALnP8ZbaT+jdBvaggAPW=yiW61fip6cjnZcU48tb2-5orqdeMg@mail.gmail.com>
 <CAM0EoMmso7Y0g9jQ=FfJLuV9JTDct5Qqb5-W4+nd0Xb9DBkGkA@mail.gmail.com>
 <ZW2gwaj/LBNL8J3P@nanopsycho> <CAM0EoMmvkT5JEm7tUNa-zGD1g80usR=KUAF0zO5uDV70Z-5hmA@mail.gmail.com>
 <ZW7iHub0oM5SZ/SF@nanopsycho> <CALnP8ZYm2T1TaajZ6RejyaHqhs71VrVGfYr-+Ssj=7GhmwO0Hw@mail.gmail.com>
In-Reply-To: <CALnP8ZYm2T1TaajZ6RejyaHqhs71VrVGfYr-+Ssj=7GhmwO0Hw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 5 Dec 2023 10:27:31 -0500
Message-ID: <CAM0EoMmax-t+ZiaQAOJxhDOtRK2Gi3_TcqVoLEhDQWjsfOaRJQ@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jamal Hadi Salim <hadi@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	vladbu@nvidia.com, paulb@nvidia.com, pctammela@mojatatu.com, 
	netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 9:52=E2=80=AFAM Marcelo Ricardo Leitner
<mleitner@redhat.com> wrote:
>
> On Tue, Dec 05, 2023 at 09:41:02AM +0100, Jiri Pirko wrote:
> > Mon, Dec 04, 2023 at 09:10:18PM CET, jhs@mojatatu.com wrote:
> > >On Mon, Dec 4, 2023 at 4:49=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> w=
rote:
> > >>
> > >> Fri, Dec 01, 2023 at 07:45:47PM CET, jhs@mojatatu.com wrote:
> ...
> > >> >Ok, so we are moving forward with mirred "mirror" option only for t=
his then...
> > >>
> > >> Could you remind me why mirror and not redirect? Does the packet
> > >> continue through the stack?
> > >
> > >For mirror it is _a copy_ of the packet so it continues up the stack
> > >and you can have other actions follow it (including multiple mirrors
> > >after the first mirror). For redirect the packet is TC_ACT_CONSUMED -
> > >so removed from the stack processing (and cant be sent to more ports).
> > >That is how mirred has always worked and i believe thats how most
> > >hardware works as well.
> > >So sending to multiple ports has to be mirroring semantics (most
> > >hardware assumes the same semantics).
> >
> > You assume cloning (sending to multiple ports) means mirror,
> > that is I believe a mistake. Look at it from the perspective of
> > replacing device by target for each action. Currently we have:
> >
> > 1) mirred mirror TARGET_DEVICE
> >    Clones, sends to TARGET_DEVICE and continues up the stack
> > 2) mirred redirect TARGET_DEVICE
> >    Sends to TARGET_DEVICE, nothing is sent up the stack
> >
> > For block target, there should be exacly the same semantics:
> >
> > 1) mirred mirror TARGET_BLOCK
> >    Clones (multiple times, for each block member), sends to TARGET_BLOC=
K
> >    and continues up the stack
> > 2) mirred redirect TARGET_BLOCK
> >    Clones (multiple times, for each block member - 1), sends to
> >    TARGET_BLOCK, nothing is sent up the stack
>
> This makes sense to me as well. When I first read Jamal's email I
> didn't spot any confusion, but now I see there can be some. I think he
> meant pretty much the same thing, referencing cascading other outputs
> after blockcast (and not the inner outputs, lets say), but that's just
> my interpretation. :)

In my (shall i say long experience) I have never seen the prescribed
behavior of redirect meaning mirror to (all - last one) then redirect
on last one.. Jiri, does spectrum work like this?
Neither in s/w nor in h/w. From h/w - example, the nvidia CX6 you have
to give explicit mirror, mirror, mirror, redirect. IOW, i dont think
the hardware can be told "here's a list of ports, please mirror to all
of them and for the last one steal the packet and redirect".
Having said that i am not opposed to it - it will just make the code
slightly more complex and i am sure slightly slower in the datapath.

cheers,
jamal


Return-Path: <netdev+bounces-54148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F21C480617A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 23:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B1E1C20D27
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B366D1D2;
	Tue,  5 Dec 2023 22:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJe0yS3q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B35183
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 14:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701814441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RADvDjVl6X6JLa+/tGtzcc55iwEyCI878lBGfltJ73c=;
	b=JJe0yS3qzHoejk6wqs2R1fmIhLCzzKSQl76W/MUJrFNhR506NGD68s4jRj2W5lXCjp/C5v
	4F9frhs0PN1kT/9LhXs7RaIoPe3PNE1XpK51I1HFmlx+guR3bblQ7cxowmcCaXbzZXBTFA
	iU6pUdDju/bTnGpeePTo+jqc6iGAxgw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-6RtY_GGAOl6zTvIziVUZ4g-1; Tue, 05 Dec 2023 17:12:27 -0500
X-MC-Unique: 6RtY_GGAOl6zTvIziVUZ4g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1c748317easo7042666b.2
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 14:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701814346; x=1702419146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RADvDjVl6X6JLa+/tGtzcc55iwEyCI878lBGfltJ73c=;
        b=eJqLWA+DGEhTdwKK4sgC1qEy05JLfgGzxSMCzZbshuycMWdgS4wAonbu5BiwZPTpSA
         5zl+MVC5fJkpuuHbK1XNjvXfx0bxltQVWTI572NUr6C1mYz3BD1jkPgRti3jjj0akcvz
         0nNak2dELUD0/DVMxGO8opvDWhi1J3N0dt0Z6xQFufceDcvW1v5+Dk3apDqNw/30BNoD
         /qIbYncjh0HUnonxhCYb23xbkuLp686nIj+HhEOFuO2yW0fQK93hs9EIS5H/1Vr5RxYD
         7iv/95Klo1LYuH7HzzDiRD2ZcDKz2467TmL5p5WZHwrTArYFAOByYFifcZQjyBAlbPk3
         m+0Q==
X-Gm-Message-State: AOJu0YwB30ONvFJYxI/GaBiRQaDNvcpkAv0kep5CWVfkFMiqOcwBtU0O
	3H2gT+WxKoXnXwa5EyfIiU9CeqQD9NTXgObRgIdh7oZI33xQDvAi/BZBrTzLAemgGsOmrYnlv1y
	CAGvWXffm26g/tCLES7ywFLBliNyVTWzA
X-Received: by 2002:a50:d4d6:0:b0:54c:f342:ea32 with SMTP id e22-20020a50d4d6000000b0054cf342ea32mr8217edj.76.1701814345964;
        Tue, 05 Dec 2023 14:12:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEosEvlpaszZ12uBrzJCTHmA4SwzPT+/BeHLqblzy+Exmu4H0UpeJH+FRTJXvr1W4bQ/NZwHrInLKzWkJXDe8g=
X-Received: by 2002:a50:d4d6:0:b0:54c:f342:ea32 with SMTP id
 e22-20020a50d4d6000000b0054cf342ea32mr8198edj.76.1701814345638; Tue, 05 Dec
 2023 14:12:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Dec 2023 14:12:23 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <CAAFAkD-awfzQTO6yRYeooXwW+7zEub0BiGkbke=o=fTKpzN__g@mail.gmail.com>
 <ZV+DPmXrANEh6gF8@nanopsycho> <CAM0EoMkQaEAaKc7D6kVe+p6f=-Ddd7enoKgRdeWBnqbN2zPhfA@mail.gmail.com>
 <CALnP8ZbaT+jdBvaggAPW=yiW61fip6cjnZcU48tb2-5orqdeMg@mail.gmail.com>
 <CAM0EoMmso7Y0g9jQ=FfJLuV9JTDct5Qqb5-W4+nd0Xb9DBkGkA@mail.gmail.com>
 <ZW2gwaj/LBNL8J3P@nanopsycho> <CAM0EoMmvkT5JEm7tUNa-zGD1g80usR=KUAF0zO5uDV70Z-5hmA@mail.gmail.com>
 <ZW7iHub0oM5SZ/SF@nanopsycho> <CALnP8ZYm2T1TaajZ6RejyaHqhs71VrVGfYr-+Ssj=7GhmwO0Hw@mail.gmail.com>
 <CAM0EoMmax-t+ZiaQAOJxhDOtRK2Gi3_TcqVoLEhDQWjsfOaRJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoMmax-t+ZiaQAOJxhDOtRK2Gi3_TcqVoLEhDQWjsfOaRJQ@mail.gmail.com>
Date: Tue, 5 Dec 2023 14:12:23 -0800
Message-ID: <CALnP8Zavd8N=9n42sbeKqE-mMKXHsFtmCHKOuG7sZEN5Z8m7kw@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jamal Hadi Salim <hadi@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	vladbu@nvidia.com, paulb@nvidia.com, pctammela@mojatatu.com, 
	netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 10:27:31AM -0500, Jamal Hadi Salim wrote:
> On Tue, Dec 5, 2023 at 9:52=E2=80=AFAM Marcelo Ricardo Leitner
> <mleitner@redhat.com> wrote:
> >
> > On Tue, Dec 05, 2023 at 09:41:02AM +0100, Jiri Pirko wrote:
> > > Mon, Dec 04, 2023 at 09:10:18PM CET, jhs@mojatatu.com wrote:
> > > >On Mon, Dec 4, 2023 at 4:49=E2=80=AFAM Jiri Pirko <jiri@resnulli.us>=
 wrote:
> > > >>
> > > >> Fri, Dec 01, 2023 at 07:45:47PM CET, jhs@mojatatu.com wrote:
> > ...
> > > >> >Ok, so we are moving forward with mirred "mirror" option only for=
 this then...
> > > >>
> > > >> Could you remind me why mirror and not redirect? Does the packet
> > > >> continue through the stack?
> > > >
> > > >For mirror it is _a copy_ of the packet so it continues up the stack
> > > >and you can have other actions follow it (including multiple mirrors
> > > >after the first mirror). For redirect the packet is TC_ACT_CONSUMED =
-
> > > >so removed from the stack processing (and cant be sent to more ports=
).
> > > >That is how mirred has always worked and i believe thats how most
> > > >hardware works as well.
> > > >So sending to multiple ports has to be mirroring semantics (most
> > > >hardware assumes the same semantics).
> > >
> > > You assume cloning (sending to multiple ports) means mirror,
> > > that is I believe a mistake. Look at it from the perspective of
> > > replacing device by target for each action. Currently we have:
> > >
> > > 1) mirred mirror TARGET_DEVICE
> > >    Clones, sends to TARGET_DEVICE and continues up the stack
> > > 2) mirred redirect TARGET_DEVICE
> > >    Sends to TARGET_DEVICE, nothing is sent up the stack
> > >
> > > For block target, there should be exacly the same semantics:
> > >
> > > 1) mirred mirror TARGET_BLOCK
> > >    Clones (multiple times, for each block member), sends to TARGET_BL=
OCK
> > >    and continues up the stack
> > > 2) mirred redirect TARGET_BLOCK
> > >    Clones (multiple times, for each block member - 1), sends to
> > >    TARGET_BLOCK, nothing is sent up the stack
> >
> > This makes sense to me as well. When I first read Jamal's email I
> > didn't spot any confusion, but now I see there can be some. I think he
> > meant pretty much the same thing, referencing cascading other outputs
> > after blockcast (and not the inner outputs, lets say), but that's just
> > my interpretation. :)
>
> In my (shall i say long experience) I have never seen the prescribed
> behavior of redirect meaning mirror to (all - last one) then redirect
> on last one.. Jiri, does spectrum work like this?
> Neither in s/w nor in h/w. From h/w - example, the nvidia CX6 you have
> to give explicit mirror, mirror, mirror, redirect. IOW, i dont think
> the hardware can be told "here's a list of ports, please mirror to all
> of them and for the last one steal the packet and redirect".

Precisely. I/(we?) were talking about tc sw/user expectations, not how
to offload it.

From a tc user perspective, the user should still be able to do this:
1) mirred mirror TARGET_BLOCK
2) mirred redirect TARGET_BLOCK
regardless of how the implementation actually works. Because ovs and
other users will rely on this semantic.

As for the actual implementation, as you said, it will have to somehow
unpack that into "[mirror, mirror, ...,] <mirror/redirect>", depending
on what the user requested, as I doubt there will be hw support for
outputting to multiple ports in one action.

> Having said that i am not opposed to it - it will just make the code
> slightly more complex and i am sure slightly slower in the datapath.
>
> cheers,
> jamal
>



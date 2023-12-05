Return-Path: <netdev+bounces-53977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E14E48057E7
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBCE1F216EF
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DE165ED6;
	Tue,  5 Dec 2023 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgZFma2x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3173AAF
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 06:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701787951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5b9ICmGb9DxpKxl+9PGIfBQtujfsEu6RSslnaS/2WBA=;
	b=TgZFma2xmnEzU6PWyFYlKznjW++yD2JacgcNsYzJfawNGwbAa4d/OF76Qlz0GEwY9bROgR
	EZxAdBYrxnDnyja73KD13BkIQSA/ufN34AlKFwH0cEBdgIxUFitVE+91zMXp7k8fJ/Pd6y
	VgJdNyb7Ozb8qCqrezOd0xD/gAtBbKw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-IN_ZaOGPPwuhf9U_Th-q5w-1; Tue, 05 Dec 2023 09:51:21 -0500
X-MC-Unique: IN_ZaOGPPwuhf9U_Th-q5w-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c9c99a4fdbso56151081fa.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 06:51:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787880; x=1702392680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5b9ICmGb9DxpKxl+9PGIfBQtujfsEu6RSslnaS/2WBA=;
        b=AcbWdOvRgYzliO0oqQoHwwU/zCWRnWZZv2rd4QkoqjRexFCe5litggGaaRjsGx1+qn
         ZkV/QdMTuavfA9Z7PgTvEgEHk/leJK8BNUHMDyQta4SHKBsYn6SbaBgMuaK5UTMq7Bkx
         sOuwbnwytP06wpzQ6gpHtWNpPI9tp28txCvhybE4HVIiEjWyzFdK2CJRnuFhC9RGGVgg
         wsdqkvysogFkbcaR3FDfLgah+nzr1aKL9TAbaWktCUyNOutR4c34bBUhKR2pbg7R5o8r
         nySVBNQbR2spEHLCJOiM7r6d3elFKnR/MojkQYSnBC72TfcnCQaWnASXAuc2+gwORvqv
         df7w==
X-Gm-Message-State: AOJu0YzMbwWB/C+CnEckkzO0gkGrgiGlq2vH2ebH9o7JL7iyXygAs4Gf
	My7pku1rFqY1S7/68EuZ/Vbx+Qd2DVFRN2hNgdM8eRNnK01X8xeTgj6JrH0qe5oQHsmQZ61S8jr
	Tjo+hYfYpaNvouTwAGR5TjKHEifyINiBm
X-Received: by 2002:a05:6512:791:b0:50b:f8b5:7464 with SMTP id x17-20020a056512079100b0050bf8b57464mr1450854lfr.100.1701787880222;
        Tue, 05 Dec 2023 06:51:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZdfav+0+MOMwYfaoEDgQ76qKdv/0dmxH7GodSelyddj6piIX/5qinOLn+BtpS55L3iM92bQd3RpL6/zF7Tbg=
X-Received: by 2002:a05:6512:791:b0:50b:f8b5:7464 with SMTP id
 x17-20020a056512079100b0050bf8b57464mr1450848lfr.100.1701787879894; Tue, 05
 Dec 2023 06:51:19 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Dec 2023 06:51:18 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <CAM0EoMnwAHO_AvEYiL=aTwNBjs29ww075Lq1qwvCwuYtB_Qz7A@mail.gmail.com>
 <ZV9tCT9d7dm7dOeA@nanopsycho> <CAAFAkD-awfzQTO6yRYeooXwW+7zEub0BiGkbke=o=fTKpzN__g@mail.gmail.com>
 <ZV+DPmXrANEh6gF8@nanopsycho> <CAM0EoMkQaEAaKc7D6kVe+p6f=-Ddd7enoKgRdeWBnqbN2zPhfA@mail.gmail.com>
 <CALnP8ZbaT+jdBvaggAPW=yiW61fip6cjnZcU48tb2-5orqdeMg@mail.gmail.com>
 <CAM0EoMmso7Y0g9jQ=FfJLuV9JTDct5Qqb5-W4+nd0Xb9DBkGkA@mail.gmail.com>
 <ZW2gwaj/LBNL8J3P@nanopsycho> <CAM0EoMmvkT5JEm7tUNa-zGD1g80usR=KUAF0zO5uDV70Z-5hmA@mail.gmail.com>
 <ZW7iHub0oM5SZ/SF@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZW7iHub0oM5SZ/SF@nanopsycho>
Date: Tue, 5 Dec 2023 06:51:18 -0800
Message-ID: <CALnP8ZYm2T1TaajZ6RejyaHqhs71VrVGfYr-+Ssj=7GhmwO0Hw@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jamal Hadi Salim <hadi@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	vladbu@nvidia.com, paulb@nvidia.com, pctammela@mojatatu.com, 
	netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 09:41:02AM +0100, Jiri Pirko wrote:
> Mon, Dec 04, 2023 at 09:10:18PM CET, jhs@mojatatu.com wrote:
> >On Mon, Dec 4, 2023 at 4:49=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Fri, Dec 01, 2023 at 07:45:47PM CET, jhs@mojatatu.com wrote:
...
> >> >Ok, so we are moving forward with mirred "mirror" option only for thi=
s then...
> >>
> >> Could you remind me why mirror and not redirect? Does the packet
> >> continue through the stack?
> >
> >For mirror it is _a copy_ of the packet so it continues up the stack
> >and you can have other actions follow it (including multiple mirrors
> >after the first mirror). For redirect the packet is TC_ACT_CONSUMED -
> >so removed from the stack processing (and cant be sent to more ports).
> >That is how mirred has always worked and i believe thats how most
> >hardware works as well.
> >So sending to multiple ports has to be mirroring semantics (most
> >hardware assumes the same semantics).
>
> You assume cloning (sending to multiple ports) means mirror,
> that is I believe a mistake. Look at it from the perspective of
> replacing device by target for each action. Currently we have:
>
> 1) mirred mirror TARGET_DEVICE
>    Clones, sends to TARGET_DEVICE and continues up the stack
> 2) mirred redirect TARGET_DEVICE
>    Sends to TARGET_DEVICE, nothing is sent up the stack
>
> For block target, there should be exacly the same semantics:
>
> 1) mirred mirror TARGET_BLOCK
>    Clones (multiple times, for each block member), sends to TARGET_BLOCK
>    and continues up the stack
> 2) mirred redirect TARGET_BLOCK
>    Clones (multiple times, for each block member - 1), sends to
>    TARGET_BLOCK, nothing is sent up the stack

This makes sense to me as well. When I first read Jamal's email I
didn't spot any confusion, but now I see there can be some. I think he
meant pretty much the same thing, referencing cascading other outputs
after blockcast (and not the inner outputs, lets say), but that's just
my interpretation. :)

  Marcelo



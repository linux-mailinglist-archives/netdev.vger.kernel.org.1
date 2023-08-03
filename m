Return-Path: <netdev+bounces-24065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37F676EAD1
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187FD1C21537
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA35F1F926;
	Thu,  3 Aug 2023 13:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB0D1F164
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:40:24 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCE55254;
	Thu,  3 Aug 2023 06:40:21 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686ed1d2594so827508b3a.2;
        Thu, 03 Aug 2023 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691070020; x=1691674820;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19BZNGqKOrPHBBOl2OIBFvG7nlcaxoTrDeHm2ZDX1TA=;
        b=W8tofW1SuF9HGXbhGt1RS/OKnyCIc2o+7Q4E9Mvb83NSzkw0Hb4y2WpDlL7esofUW3
         7mH1po3DNTYdhcCGWsprQxa2uJUUAnjP5wDkcGZ2K3EP9v9gj9O+UNFPS/A8mMEd9toh
         f0HlDQrKVRnEb2tnRNGvcQIElWx5TAsmw3agJmEjK4BBPRXVRDKR3SDJ6M69cVKVjAkW
         Mqhjoo9XseJODyFp3nHgOOLMahILyVBza2cZZS8zlhAXTtn/jVYbz6lRqAU2VSR2qHz6
         9vLBEaxd1hL/VZV5lBW08+dFZTaqgdkQssZeBS3/tsJksBGZVva9PW1RXRaL1P6FQmvM
         fQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691070020; x=1691674820;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19BZNGqKOrPHBBOl2OIBFvG7nlcaxoTrDeHm2ZDX1TA=;
        b=Ol/sKTMWInE/fxfpdwV0CIAClJmqnJeGHS5IkvPJrPRO7gUzoiOmYKeNIQOuT5hC1k
         Z1XdHUjBktY3ghc/AtFa2T75ggOs468OPFk+OqI90CN43Jcn7SBpouOw4YSBnxF0aDdZ
         fownoocPlu0ozCJN89VR0D7VSgZH08Q+KxlORED394l1QeBuRs4+poUF+LEegCrr4W55
         IpnVX+H6QV+yQ0oFGdQJ47XMmYvroQxIwWq4AhJD96DQTDs1CWOiVC9uxQqEA5NPGafu
         vtvJOxAwNycYlBtXlK6gWJ83UnEck7ce9Xudd3eWKFADGjAxZLDvmAlKioeSnRNNELEp
         14mQ==
X-Gm-Message-State: ABy/qLaUBAQvw34T8Yzc+zy523AL/Q5H0xGLwybNGyUFtQ8rFOqgUsi5
	nbGoCNLotmKaOhQyJCZUsqs=
X-Google-Smtp-Source: APBJJlGlp+yWSQxPakMHTH8CBwof/o0IZJ7MoBfjMU7WLatUWtIjgSM1mqoZAnKguzbKZ/FUlKnKEw==
X-Received: by 2002:a05:6a00:148b:b0:67b:2eba:bed4 with SMTP id v11-20020a056a00148b00b0067b2ebabed4mr25209241pfu.14.1691070020449;
        Thu, 03 Aug 2023 06:40:20 -0700 (PDT)
Received: from [127.0.0.1] ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78e59000000b0062cf75a9e6bsm12841091pfr.131.2023.08.03.06.40.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:40:20 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <43d29007-3c59-4497-a1e5-26f182a7f4c5@paulmck-laptop>
Date: Thu, 3 Aug 2023 21:40:11 +0800
Cc: Joel Fernandes <joel@joelfernandes.org>,
 Eric Dumazet <edumazet@google.com>,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 rcu@vger.kernel.org,
 roman.gushchin@linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <784ABF9D-303F-4FC8-8AFF-A3FF319B4E7A@gmail.com>
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org>
 <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
 <43d29007-3c59-4497-a1e5-26f182a7f4c5@paulmck-laptop>
To: "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> 2023=E5=B9=B48=E6=9C=881=E6=97=A5 =E4=B8=8A=E5=8D=884:09=EF=BC=8CPaul =
E. McKenney <paulmck@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Fri, Jul 21, 2023 at 10:27:04PM +0800, Alan Huang wrote:
>>=20
>>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 20:54=EF=BC=8CJoel Fernandes =
<joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>>=20
>>>=20
>>>> On Jul 20, 2023, at 4:00 PM, Alan Huang <mmpgouride@gmail.com> =
wrote:
>>>>=20
>>>> =EF=BB=BF
>>>>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 03:22=EF=BC=8CEric Dumazet =
<edumazet@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>>=20
>>>>>> On Thu, Jul 20, 2023 at 8:54=E2=80=AFPM Alan Huang =
<mmpgouride@gmail.com> wrote:
>>>>>>=20
>>>>>> Hi,
>>>>>>=20
>>>>>> I noticed a commit c87a124a5d5e(=E2=80=9Cnet: force a reload of =
first item in hlist_nulls_for_each_entry_rcu=E2=80=9D)
>>>>>> and a related discussion [1].
>>>>>>=20
>>>>>> After reading the whole discussion, it seems like that ptr->field =
was cached by gcc even with the deprecated
>>>>>> ACCESS_ONCE(), so my question is:
>>>>>>=20
>>>>>>     Is that a compiler bug? If so, has this bug been fixed today, =
ten years later?
>>>>>>=20
>>>>>>     What about READ_ONCE(ptr->field)?
>>>>>=20
>>>>> Make sure sparse is happy.
>>>>=20
>>>> It caused a problem without barrier(), and the deprecated =
ACCESS_ONCE() didn=E2=80=99t help:
>>>>=20
>>>>  https://lore.kernel.org/all/519D19DA.50400@yandex-team.ru/
>>>>=20
>>>> So, my real question is: With READ_ONCE(ptr->field), are there =
still some unusual cases where gcc=20
>>>> decides not to reload ptr->field?
>>>=20
>>> I am a bit doubtful there will be strong (any?) interest in =
replacing the barrier() with READ_ONCE() without any tangible reason, =
regardless of whether a gcc issue was fixed.
>>>=20
>>> But hey, if you want to float the idea=E2=80=A6
>>=20
>> We already had the READ_ONCE() in rcu_deference_raw().
>>=20
>> The barrier() here makes me think we need write code like below:
>> =09
>> 	READ_ONCE(head->first);
>> 	barrier();
>> 	READ_ONCE(head->first);
>>=20
>> With READ_ONCE (or the deprecated ACCESS_ONCE),
>> I don=E2=80=99t think a compiler should cache the value of =
head->first.
>=20
> Apologies for the late reply!
>=20
> If both are READ_ONCE(), you should not need the barrier().  Unless =
there
> is some other code not shown in your example that requires it, that =
is.

And unless the compiler has a bug. :)=20

So, the barrier() in hlist_nulls_for_each_entry_rcu() is a workaround =
for a compiler bug.

>=20
> 							Thanx, Paul
>=20
>>> Thanks,
>>>=20
>>> - Joel
>>>=20
>>>>=20
>>>>>=20
>>>>> Do you have a patch for review ?
>>>>=20
>>>> Possibly next month. :)
>>>>=20
>>>>>=20
>>>>>=20
>>>>>>=20
>>>>>>=20
>>>>>> [1] =
https://lore.kernel.org/all/1369699930.3301.494.camel@edumazet-glaptop/
>>>>>>=20
>>>>>> Thanks,
>>>>>> Alan



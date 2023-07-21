Return-Path: <netdev+bounces-19864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4C775C9FF
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7646F281F08
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800981ED25;
	Fri, 21 Jul 2023 14:27:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734511EA9D
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:27:34 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5B61BD;
	Fri, 21 Jul 2023 07:27:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666ed230c81so1794762b3a.0;
        Fri, 21 Jul 2023 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689949652; x=1690554452;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AF7tCZuwq+7c0GWnUSkmQBp9SWKqeqYjs69ZFgQZ6/0=;
        b=sAZr0HTeun5o4leNcfqFqWEcQpk/QFEaCNV2+hVfs8oDk/d/b4+nkakv6bKZtz3rCN
         N5+LGFJiDK8K+/2+c+wCeKaPUPdnhQGo+Wam+Ee6wYW+Q/uaobNzON4AAYq2ibELIMR+
         YJOZ22TP//Olc8+xWh12X+BjKvnwffUh4B7aJcGIoWiVsfFkQU3kwZuoFuYoLpw4uKui
         ihIluiFAmsyMVIQE7TSnjtFaJ87sIDLWBYHW69sDfWeukFN4fMOsi+m1f5m42Lol9kJm
         Ag7aW+yz8QqhYTecTULWr9csPb5fBaqxgQ4LGZDm8BQ2fFn4fgcNyqHadr6fBkksH6vl
         2ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689949652; x=1690554452;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AF7tCZuwq+7c0GWnUSkmQBp9SWKqeqYjs69ZFgQZ6/0=;
        b=GhMY0xxl88wPROhA/AU+MZ6PejUr1ZrogZtj/+8BVKi1D4krqeJVc+ic5rMmbAn3ai
         UPIbH5yPfBO9SfAf53N2QH2IMbca4yDXbvmrftI2oc2xGmZ1qQjOAAnCI39urKGf26HV
         f7quuSYKEQcsrxKMeMWjbQgTeGZwghkt9pXmvQDihBfczm7+M7m5fN5bsgyP+jozDOXy
         C78eTSeDMySRPnUN/WiWteDbkfD91mBZo9seDzrvO2W+xQZVr48HgqJLmPVxUZHC4wGI
         MM4qIgIHQiFW48vKvJ4auTe0TtiE23QVD7CIpXLgnt/ZysMOWpynLLhEn8+2bkURnLLc
         wHrA==
X-Gm-Message-State: ABy/qLbL6QT4yzC/SMfZ1iLcgqx2BqZmjsuSyzIDI8+3FGY0yAlLcEcN
	hvb8Y7A7x6Rtiiu+c4WOZ3I=
X-Google-Smtp-Source: APBJJlH0fUBj49AhwwYk/EthIBUkAlu3Lt3Vcp3X972820zaXpul3Od1X33iDe7vyQe6a8Ba8hhK8g==
X-Received: by 2002:a05:6a00:1995:b0:676:76ea:e992 with SMTP id d21-20020a056a00199500b0067676eae992mr276148pfl.5.1689949652460;
        Fri, 21 Jul 2023 07:27:32 -0700 (PDT)
Received: from smtpclient.apple ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id e2-20020aa78c42000000b00666e2dac482sm3051742pfd.124.2023.07.21.07.27.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:27:32 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
From: Alan Huang <mmpgouride@gmail.com>
In-Reply-To: <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org>
Date: Fri, 21 Jul 2023 22:27:04 +0800
Cc: Eric Dumazet <edumazet@google.com>,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 rcu@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>,
 roman.gushchin@linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org>
To: Joel Fernandes <joel@joelfernandes.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 20:54=EF=BC=8CJoel Fernandes =
<joel@joelfernandes.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
>> On Jul 20, 2023, at 4:00 PM, Alan Huang <mmpgouride@gmail.com> wrote:
>>=20
>> =EF=BB=BF
>>> 2023=E5=B9=B47=E6=9C=8821=E6=97=A5 03:22=EF=BC=8CEric Dumazet =
<edumazet@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>>> On Thu, Jul 20, 2023 at 8:54=E2=80=AFPM Alan Huang =
<mmpgouride@gmail.com> wrote:
>>>>=20
>>>> Hi,
>>>>=20
>>>> I noticed a commit c87a124a5d5e(=E2=80=9Cnet: force a reload of =
first item in hlist_nulls_for_each_entry_rcu=E2=80=9D)
>>>> and a related discussion [1].
>>>>=20
>>>> After reading the whole discussion, it seems like that ptr->field =
was cached by gcc even with the deprecated
>>>> ACCESS_ONCE(), so my question is:
>>>>=20
>>>>      Is that a compiler bug? If so, has this bug been fixed today, =
ten years later?
>>>>=20
>>>>      What about READ_ONCE(ptr->field)?
>>>=20
>>> Make sure sparse is happy.
>>=20
>> It caused a problem without barrier(), and the deprecated =
ACCESS_ONCE() didn=E2=80=99t help:
>>=20
>>   https://lore.kernel.org/all/519D19DA.50400@yandex-team.ru/
>>=20
>> So, my real question is: With READ_ONCE(ptr->field), are there still =
some unusual cases where gcc=20
>> decides not to reload ptr->field?
>=20
> I am a bit doubtful there will be strong (any?) interest in replacing =
the barrier() with READ_ONCE() without any tangible reason, regardless =
of whether a gcc issue was fixed.
>=20
> But hey, if you want to float the idea=E2=80=A6

We already had the READ_ONCE() in rcu_deference_raw().

The barrier() here makes me think we need write code like below:
=09
	READ_ONCE(head->first);
	barrier();
	READ_ONCE(head->first);

With READ_ONCE (or the deprecated ACCESS_ONCE),
I don=E2=80=99t think a compiler should cache the value of head->first.

>=20
> Thanks,
>=20
> - Joel
>=20
>>=20
>>>=20
>>> Do you have a patch for review ?
>>=20
>> Possibly next month. :)
>>=20
>>>=20
>>>=20
>>>>=20
>>>>=20
>>>> [1] =
https://lore.kernel.org/all/1369699930.3301.494.camel@edumazet-glaptop/
>>>>=20
>>>> Thanks,
>>>> Alan
>>=20



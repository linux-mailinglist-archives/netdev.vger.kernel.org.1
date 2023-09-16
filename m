Return-Path: <netdev+bounces-34327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9569C7A32AE
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 23:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43DC5281AE7
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 21:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095881C298;
	Sat, 16 Sep 2023 21:43:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA441C293
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 21:43:46 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91BC1B2
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 14:43:44 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-773a0f36b4bso188877385a.0
        for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 14:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694900624; x=1695505424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJEfctCZBqQ6mIfPM+zM88cjNEScD9/MIC5SahQqh6w=;
        b=T7nvTgVrJhxOCDWfmblrGWzS5xwuAbmL3/23I1oPykdv6KgMR42LXtJDJWrIQdv40M
         0FArVWJIaN9rw6DrLRreNDrtZa5OmsgIGSBQAlhU0Aq7eu4mMvpXSeKI5l02Jcj5lxHb
         NDdCQ1q373SxQvTur4t+Mv1tEtQjS73nHAVyNc9bsaBoZbv7e60xI5JR1RwMooFQDwev
         MWafgdydGB+JmQeRY8mlQrueMYg7uc8lQlau1kYMm4f5mBlTvKY4xQIQfscyFOReR2Pw
         hgEjP6Upehln4hfsCPdEIEnxsURwfC9HTuuZIavrd8HhBXDxYZVSKRf3wX40eyNadTKP
         pETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694900624; x=1695505424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJEfctCZBqQ6mIfPM+zM88cjNEScD9/MIC5SahQqh6w=;
        b=btox55YMz6oV6OPKE/iVLa2sfTdj9BWvlDVvuoKkt0feUATUMY4yNx1rNRvPnZKu6J
         B0UidALOv7t3lwTMxzpkCZ/9k0LoPOSFtTUT6+Trau1+5FNnhcO0BLIXK3xu+OxTHoEO
         AOe8umiCegkLtMX2BZqhkKq9ybsJW1/FFF796QXC6L6Z1jJ1kR6EWKOpZR2TOynUbF46
         lqjzfFN9o6cLJ9zT3l8uDBmz1UV8uJ/KUeQGMlIglRQUuCu51OXP9YNyaD1lLDGzNt1B
         erxJXzt3QEnZM9r7QAgMYSOwBMXbnAv9kXdrNL9vKPPXseoeHgS154WBKElZqtyG/sS4
         PJ4Q==
X-Gm-Message-State: AOJu0YwRiQFgqTx4d6T3aMNZG5l2hE/wimeFOB67sRrEggCtz9K/r+1P
	t92L93FmUdNwwT2tI/DC4bPxE5rTq5cm/k8FZf1QksWscS4=
X-Google-Smtp-Source: AGHT+IEmVNGWQgR1Pn5e5C2ss2oGYVk96DFKan39sDRGAf9PxW1IZkaDlvxNu2l2aJROBEuaS89pqmLO6XeVe8sSPQU=
X-Received: by 2002:a05:620a:46a1:b0:76e:fea0:3f3e with SMTP id
 bq33-20020a05620a46a100b0076efea03f3emr6215487qkb.48.1694900623826; Sat, 16
 Sep 2023 14:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5AE3HkjRb9-UsoG44XL064Lca7zx9gG47+==GbhVPUFsw@mail.gmail.com>
 <8020f97d-a5c9-4b78-bcf2-fc5245c67138@lunn.ch> <CAOMZO5BzaJ3Bw2hwWZ3iiMCX3_VejnZ=LHDhkdU8YmhKHuA5xw@mail.gmail.com>
 <CAOMZO5DJXsbgEDAZSjWJXBesHad1oWR9ht3a3Xjf=Q-faHm1rg@mail.gmail.com> <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch>
In-Reply-To: <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch>
From: Alfred Lee <l00g33k@gmail.com>
Date: Sat, 16 Sep 2023 14:43:32 -0700
Message-ID: <CANZWyGLmB6M5_Kb5+rmUS5-q=68DoKZSthR8g-XY52Ce2oU4dw@mail.gmail.com>
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
To: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 2:38=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> Alfred: How do you have the reset GPIO configured in your DT?
> GPIO_ACTIVE_LOW?
>
>     Andrew

I will check the schematic when I get in the office on Monday.

Alfred


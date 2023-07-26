Return-Path: <netdev+bounces-21575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E7D763EE3
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F393281EC0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710D14CE72;
	Wed, 26 Jul 2023 18:49:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BE27E1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:49:05 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84DA26A8
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:49:03 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so170783e87.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690397342; x=1691002142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gssK/9t+yReI1WWHhHksFFEr4iOJwLuyj2VWyW67HMg=;
        b=RNrtpRSLTvNO2OgHpwCznWmRSNMi2w23oMmAxuJFWeOxkQubF2lAVOF2bvMae444OD
         9zVJxJePna8u2jocJu+ZX/i0HqTIpTM12WXczC5ccoG307ABuL+lZIt/qGg+brMh6r0l
         GeeZ73/ZiEJuzwhEiNEyNGla4a0mrOuFpGwVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690397342; x=1691002142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gssK/9t+yReI1WWHhHksFFEr4iOJwLuyj2VWyW67HMg=;
        b=g8WzaMRss7PBLlGK0uiMkVAgEzY/8bQo5RA/LvYFBPwDrSdZo8mnLf2QPrG9kurlnH
         iU2vvwN4Ce/WwsQwjpli+GyNdRnlKwqtVqXQaMRDL53RFJi76wUBmyfFlfXX+WK2N8XN
         MjufdjwHDwepAwhOXD/Ah6W7yh1gTGQ35Celz7GUilMuYGFc5LU5gU1R0VeZUFm1LXka
         dBiDV5IazaIcn4CF7SM5whTI5OZ21SfW5tlbNZyv8C6pPvnP4y3+TNqIT5BOTqXer26m
         /FFdw/t3u7HJD58Av5057x3yex+fZ+u9Qbb1HFLRdeCQD2/YnBBxF3TjS0X2SNQMvIjO
         F6lQ==
X-Gm-Message-State: ABy/qLYVo0MgRZ28yF/A/OOWKsX9evPKTtBgqQbwvTgmVsq7eIVMdncZ
	s1V0LPsLubKCE0Fu4fiHbfm4H6KgfWFw0cskI1pAyiYS
X-Google-Smtp-Source: APBJJlHrUJNPuical9nZYanDOWzsTBghHh02i7UIRjR/oEMoL+WTgR8PDfWZ0IghaD53pScBBcqKlQ==
X-Received: by 2002:a05:6512:32b7:b0:4fd:f889:b9d2 with SMTP id q23-20020a05651232b700b004fdf889b9d2mr24618lfe.38.1690397341673;
        Wed, 26 Jul 2023 11:49:01 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id m14-20020a19520e000000b004fbad682ffesm3403984lfb.88.2023.07.26.11.49.01
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 11:49:01 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so207235e87.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:49:01 -0700 (PDT)
X-Received: by 2002:a05:6512:2107:b0:4f9:5d2a:e0f5 with SMTP id
 q7-20020a056512210700b004f95d2ae0f5mr16955lfr.19.1690397340786; Wed, 26 Jul
 2023 11:49:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726151515.1650519-1-kuba@kernel.org> <11ec5b3819ff17c7013348b766eab571eee5ca96.camel@perches.com>
 <20230726092312.799503d6@kernel.org> <CAHk-=wjEj2fGiaQXrYUZu65EPdgbGEAEMzch8LTtiUp6UveRCw@mail.gmail.com>
 <20230726112031.61bd0c62@kernel.org> <CAHk-=wi9MyyWmP_HAddLrmGfdANkut6_2f9hzv9HcyTBvg3+kA@mail.gmail.com>
 <63361a8f-ffa5-50e7-97d6-297d8e8b059f@amd.com>
In-Reply-To: <63361a8f-ffa5-50e7-97d6-297d8e8b059f@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Jul 2023 11:48:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whOT-r-W+pOnbkGatKVUpEfNkRwwYxkuy=Stxf475y_Mg@mail.gmail.com>
Message-ID: <CAHk-=whOT-r-W+pOnbkGatKVUpEfNkRwwYxkuy=Stxf475y_Mg@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from using
 file paths
To: "Limonciello, Mario" <mario.limonciello@amd.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Joe Perches <joe@perches.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, geert@linux-m68k.org, 
	gregkh@linuxfoundation.org, netdev@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 26 Jul 2023 at 11:45, Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> If the goal is to get people who are involved with a file, how about
> some variation of:

No, that isn't the goal.

The goal is to get the maintainer responsible for that file, so that I
can bring them in.

Maybe it's a security issue that gets reported. Maybe it's an oops.
Maybe it's a regression, but not clear what caused it.

Maybe we could have a script to help do that, and call it
'get_maintainer' or something like that?

              Linus


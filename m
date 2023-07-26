Return-Path: <netdev+bounces-21526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F652763CCE
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3F3281DA0
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353231AA72;
	Wed, 26 Jul 2023 16:45:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294E61AA61
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:45:55 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7572728
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:45:46 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so104392971fa.2
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690389944; x=1690994744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C4mt+ojB+SP10w1OfygrpNmF+pEvocjVGgRwsRvZpZc=;
        b=IZvMpzLllqI8kGs63oQoxaC1ivFZGhcl+AxYkXdEKCrmxPQAUEx3GMR3wfTSEkYK4n
         VqzB51zQqfLo2hjrSdi5Bt1vmQdBFUdzb/lb6J/qVRkabrV6+79Qn/N2BoZKZ+tMeZdP
         ewvhq6vfigxca10zBIuKGek8CV9a9N6g8Bc00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690389944; x=1690994744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4mt+ojB+SP10w1OfygrpNmF+pEvocjVGgRwsRvZpZc=;
        b=ZX2qnDPpKHKiTDBz/FuR+IO/ZOHOeOUnGhJPq/7+3WMCIy4slhqLe4w4xMq6i7o5fN
         TQ1lZqixT6q3FyZXaQJXkM7YZNMwwZLA05IdHSbLI5A7/JsItKr3kiXwLvKcmsk4t6Xx
         Vib5Z3my7+kUVu/Eo/V24D5fYBTaYCLDNd1sJwGE3xdbpNklT1lT9y4P0Bm/KiqTYgoc
         E0QdrCZARFu1QGMnHZr3a8LTuH1XBvMqJV0ce00mHCSMDUtKCiF5sI7FiFwXXV9L752x
         gECf2fwjI3hh6snCsteGyGQYqRDE5CygUVctxXGV0Xh8z0tonBoEwQLUVSzS779ikywq
         fd9g==
X-Gm-Message-State: ABy/qLZSnk8iE5qfXTPDCBuTqwKvO+3QSmyjURajKbASwUAfpbLUP3qn
	iwDXAJni6tJLdReQtQv0hoRx+YVg5O5BqxxitbGpuL//
X-Google-Smtp-Source: APBJJlGOtFkTYRhMO88Q65OzlUQlex0CufvEpYlBpyjwHHgENmlu3JyYQfYa1eqG8cHAdFWWrfZKtA==
X-Received: by 2002:a2e:9150:0:b0:2b9:b41a:aa66 with SMTP id q16-20020a2e9150000000b002b9b41aaa66mr2316754ljg.20.1690389943769;
        Wed, 26 Jul 2023 09:45:43 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id w21-20020a2e9995000000b002b95cc9fa30sm4234856lji.71.2023.07.26.09.45.42
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 09:45:43 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4fcd615d7d6so10817318e87.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 09:45:42 -0700 (PDT)
X-Received: by 2002:a05:6512:3b8:b0:4f4:c6ab:f119 with SMTP id
 v24-20020a05651203b800b004f4c6abf119mr1714334lfp.64.1690389942453; Wed, 26
 Jul 2023 09:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726151515.1650519-1-kuba@kernel.org> <11ec5b3819ff17c7013348b766eab571eee5ca96.camel@perches.com>
 <20230726092312.799503d6@kernel.org>
In-Reply-To: <20230726092312.799503d6@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Jul 2023 09:45:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEj2fGiaQXrYUZu65EPdgbGEAEMzch8LTtiUp6UveRCw@mail.gmail.com>
Message-ID: <CAHk-=wjEj2fGiaQXrYUZu65EPdgbGEAEMzch8LTtiUp6UveRCw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from using
 file paths
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Perches <joe@perches.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	geert@linux-m68k.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org, 
	workflows@vger.kernel.org, mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 26 Jul 2023 at 09:23, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 26 Jul 2023 08:43:30 -0700 Joe Perches wrote:
> > > Print a warning when someone tries to use -f and remove
> > > the "auto-guessing" of file paths.
> >
> > Nack on that bit.
> > My recollection is it's Linus' preferred mechanism.
>
> Let Linus speak for himself, hopefully he's okay with throwing
> in the -f.

It's not the '-f' that would be the problem - that's how the script
used to work long ago, and I still occasionally end up adding the -f
by habit.

So removing the auto-guessing of file paths wouldn't be a problem.

But the annoying warning is wrong.

I use get_maintainers all the time, and I *only* use it for file
paths. If I know the commit, I get the list of people from the commit
itself, so why should I *ever* use that script if I have a patch?

So the whole "use of get_maintainers is only for patches, and we
should warn about file paths" is insane.

No. If I get that patch, I will remove the warning. The *only* reason
for me to ever use that script is for the file path lookup.

             Linus


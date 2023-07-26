Return-Path: <netdev+bounces-21601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733BA763FD5
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFA6281F36
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 19:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68B14CE90;
	Wed, 26 Jul 2023 19:37:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978184CE89
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 19:37:36 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56F6E73
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:37:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992f15c36fcso9419566b.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690400253; x=1691005053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p+iMlIz9uQbnImW6R6xhQWYY5Lm4RTCv4TZdvPS1rcA=;
        b=CJQldOJMx34hVnMk6LaZxcxB3dAuK5dGvI8w3Fg7dW9Jt+T8j0E360Emf67BiNc3m0
         7wEOl8WlkSnozAIDGmAgOCqjvNlpGMC02S2/WCZjdBC9SSgOGD6RR0OuinfaBvY/j45R
         u3eAi0PwgK0IPiK+Rk0zlxMqNu+aIzeePFUaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690400253; x=1691005053;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+iMlIz9uQbnImW6R6xhQWYY5Lm4RTCv4TZdvPS1rcA=;
        b=iDKxUaTFKKMc5hD8lPQ4lzIBeo8Mk84E4nr0kioO+Wjdt2BLYWucCvuoyPhN3Y2QG4
         taJb9lD28fKGFARxZBUAx/ir6G88b+J8i6yvc4iZrspD856W6yeaiBjL836UQE7XUlPF
         DZQk4WWNar5nacITuznCaN/QVvE45EZ7S708xqpym3mBzXKdAtuaGc/UIA43a0kXc6aH
         yNsxJolBLyo8AuOi3wCJm5HC8PUvSUH5H9u/Y+yihxscZpxx/FjSMYn64qPj65UisEuT
         HFZDbPC+9dxRs3kHqJ1EEcDZ6Y0NFQHP/DZcWhpoIVevsnVIuHNsIIuP1Ch3pnutYOVM
         2G/Q==
X-Gm-Message-State: ABy/qLaznosRXvSK6Ng6gCFfH6mClabDUEnDBJW0wdFrufLN2XA8fscD
	k4ofXzNiQ98Rrl8khjrbsFLFaWNzD2Fly36PhecgdLfB
X-Google-Smtp-Source: APBJJlGCbNXuuXTTwM9XQTpNGd9vGL+uUwMDPPzbgMHVN6HmWUGQ3wi9yYYm+w0oNNmian0quYbSkw==
X-Received: by 2002:a17:906:64c1:b0:991:d727:6977 with SMTP id p1-20020a17090664c100b00991d7276977mr152738ejn.38.1690400253200;
        Wed, 26 Jul 2023 12:37:33 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id q6-20020a1709060f8600b00993b381f808sm9889179ejj.38.2023.07.26.12.37.31
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 12:37:32 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5222b917e0cso183943a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 12:37:31 -0700 (PDT)
X-Received: by 2002:a50:ee89:0:b0:522:678d:45e5 with SMTP id
 f9-20020a50ee89000000b00522678d45e5mr93988edr.30.1690400251387; Wed, 26 Jul
 2023 12:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726151515.1650519-1-kuba@kernel.org> <11ec5b3819ff17c7013348b766eab571eee5ca96.camel@perches.com>
 <20230726092312.799503d6@kernel.org> <CAHk-=wjEj2fGiaQXrYUZu65EPdgbGEAEMzch8LTtiUp6UveRCw@mail.gmail.com>
 <20230726112031.61bd0c62@kernel.org> <CAHk-=wi9MyyWmP_HAddLrmGfdANkut6_2f9hzv9HcyTBvg3+kA@mail.gmail.com>
 <20230726114817.1bd52d48@kernel.org> <CAHk-=wiuR7_A=PbN8jhmqGPJQHypUHR+W4-UuSVhOVWvYXs1Tg@mail.gmail.com>
 <CAHk-=wh4pbrNZGqfV9u1urZr3Xjci=UV-MP+KneB6a5yo7-VOQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh4pbrNZGqfV9u1urZr3Xjci=UV-MP+KneB6a5yo7-VOQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Jul 2023 12:37:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCE9cWmTXu54WFQ7x-aH8n=dhCux2h49=pYN=14ybkxg@mail.gmail.com>
Message-ID: <CAHk-=whCE9cWmTXu54WFQ7x-aH8n=dhCux2h49=pYN=14ybkxg@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from using
 file paths
To: Jakub Kicinski <kuba@kernel.org>
Cc: Joe Perches <joe@perches.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	geert@linux-m68k.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org, 
	workflows@vger.kernel.org, mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 26 Jul 2023 at 12:05, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Except it looks like it might be set up to just complain
> ("netdev/cc_maintainers"). Which seems to be why you're complaining.
>
> IOW, you're complaining about *another* tool, because your own tool
> use is set up to complain instead of being helpful.

The very first case I actually looked at wasn't even some
"inexperienced developer" - the kind you claim is the problem, and the
kind you claim this would help.

It was a random fix from Florian Westphal, who has been around for
more than a decade, is credited with over 1500 commits (and mentioned
in many many more), and knows what he's doing.

He has a patch that references a "Fixes:" line, and clearly didn't go
through the get_maintainer script as such, and the
netdev/cc_maintainers script complains as a result.

So Jakub, I think you are barking *entirely* up the wrong tree.

The reason you blame this on mis-use by inexperienced maintainers is
that you probably never even react to the experienced ones that do the
very same things, because you trust them and never bother to tell them
"you didn't use get_maintainers to get the precise list of people that
patchwork complains about".

So the problem is not in get_maintainers. It's in having expectations
that are simply not realistic.

You seem to think that those inexperienced developers should do something that

 (a) experienced developers don't do *EITHER*

 (b) the scripts complain about instead of just doing

and then you think that changing get_maintainers would somehow hide the issue.

You definitely shouldn't require inexperienced developers to do
something that clearly experienced people then don't do.

Now, maybe I happened to just randomly pick a patchwork entry that was
very unusual. But I doubt it.

           Linus


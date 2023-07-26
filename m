Return-Path: <netdev+bounces-21621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 680F87640E5
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE201C212FB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CF11BEFC;
	Wed, 26 Jul 2023 21:07:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66871BEF5
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:07:51 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538C62116
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:07:49 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so3138261fa.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690405667; x=1691010467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JM13H80q5tPRBtw1RJRrx00S2873BE47S6LyMBoeLrc=;
        b=KEzCk7K3VMZv1Q9p+eTxjPua8ZoW08eSA46go8tymGRj2oezeXzYiP/zGW3GR+TcJN
         3/jeakllZgu3CXMylcF2Y2uGmbv4w3IKd2Cysd1XW6t9uM3bhIYItMfxOTrjwyANPWn+
         0z4a+nqFzRdPlaVxnA48PKLxRSlQkRwHNU51o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690405667; x=1691010467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JM13H80q5tPRBtw1RJRrx00S2873BE47S6LyMBoeLrc=;
        b=dfmUL77FfxZGy4Qh/9LDcHKXosvbmLBFnJE2a9qZ4oWw1mKWD7uaSvr0JvIPEu7b1j
         ISrnQZ7tmEQS+A3V5stHCj1G0S2zi7lgzcogzNwOEav0gKtq9GSLVMjb0ggBMrleNSzf
         Yk54vLn4FLfhNbr4Nqf2ApvEMR0RvnQzcuO+E3KZzSc8fMb7UMABNUIBiVtedX1c5CLB
         kKqy8jYM9BF7JLiFlZNLlyKMkZ+yWQLepcNNE+6B+Rqs3NeGAZi01zYYQXALbrVPHG5t
         wRKB4yK0DjOSF0rIHxP0L3ioZfh9+xG69aNarZY9eNLl0h/YSBUg3bPuB48syAL5nWHK
         uqwQ==
X-Gm-Message-State: ABy/qLbp4wAf94kOjeDYnHulsqMSza6+X5MrHKCISeYI/1KGCBHL8G5E
	70tBJ9HCAu3btvoyPU5sHv5MNmHNL6UhiwRBT8rIzQNo
X-Google-Smtp-Source: APBJJlFvIh5D9+txi69NiBbX2O6ZCkc6W3LaTz3M7Uxm1gR08doIGjyghDqh7oRIN2paQY8FSpGtEg==
X-Received: by 2002:a2e:9058:0:b0:2b6:fa3f:9230 with SMTP id n24-20020a2e9058000000b002b6fa3f9230mr165100ljg.46.1690405666778;
        Wed, 26 Jul 2023 14:07:46 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id lf26-20020a170906ae5a00b0098e42bef736sm10171696ejb.176.2023.07.26.14.07.45
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 14:07:45 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5221f193817so249870a12.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:07:45 -0700 (PDT)
X-Received: by 2002:a05:6402:1816:b0:522:3790:1303 with SMTP id
 g22-20020a056402181600b0052237901303mr235650edy.32.1690405665337; Wed, 26 Jul
 2023 14:07:45 -0700 (PDT)
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
 <CAHk-=whCE9cWmTXu54WFQ7x-aH8n=dhCux2h49=pYN=14ybkxg@mail.gmail.com>
 <20230726130318.099f96fc@kernel.org> <CAHk-=wjfC4tFnOC0Lk_GcU4buf+X-Jv965pWg+kMRkDb6hX6mw@mail.gmail.com>
 <20230726133648.54277d76@kernel.org>
In-Reply-To: <20230726133648.54277d76@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Jul 2023 14:07:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZHcergYrraQGgazmOGMbuPsDfRMBXjFLo1aEQPqH2xQ@mail.gmail.com>
Message-ID: <CAHk-=whZHcergYrraQGgazmOGMbuPsDfRMBXjFLo1aEQPqH2xQ@mail.gmail.com>
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

On Wed, 26 Jul 2023 at 13:36, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Just so I fully understand what you're saying - what do you expect me
> to do? Send the developer a notifications saying "please repost" with
> this CC list? How is that preferable to making them do it right the
> first time?!

Not at all.

The whole point is that you already end up relying on scripting to
notice that some people should be cc'd, so just add them
automatically.

Why would you

 (a) waste your own time asking the original developer to re-do his submission

 (b) ask the original developer to do something that clearly long-time
developers don't do

 (c) waste *everybody's* time re-submitting a change that was detected
automatically and could just have been done automatically in the first
place?

just make patchwork add the cc's automatically to the patch - and send
out emails to the people it added.

Patchwork already sends out emails for other things. Guess how I know?
Because I get the patchwork-bot emails all the time for things I have
been cc'd on.  Including, very much, the netdevbpf ones.

And people who don't want to be notified can already register with
patchwork to not be notified. It's right there in that

   Deet-doot-dot, I am a bot.
   https://korg.docs.kernel.org/patchwork/pwbot.html

footer.

So I would literally suggest you just stop asking people to do things
that automation CAN DO BETTER.

The patchwork notification could be just a small note (the same way
the pull request notes are) that point to the submission, and say
"your name has been added to the Cc for this patch because it claims
to fix something you authored or acked".

See what I'm saying? Why are you wasting your time on this? Why are
you making new developers do pointless stuff that is better done by a
script, since you're just asking the developer to run a script in the
first place?

You are just wasting literally EVERYBODY'S time with your workflow
rules. For no actual advantage, since the whole - and only - point of
this all was that it was scriptable, and is in fact already being
scripted, which is how you even notice the issue in the first place.

You seem to be just overly attached to having people waste their time
on running a script that you run automatically *anyway*, and make that
some "required thing for inexperienced developers".

And it can't even be the right thing to do, when experienced
developers don't do it.

That, to me, seems completely crazy.

                   Linus


Return-Path: <netdev+bounces-21656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6777641FD
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 00:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37097281FDB
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 22:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6321F198A7;
	Wed, 26 Jul 2023 22:16:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B8198A6
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 22:16:03 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CBA270E
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:16:01 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so486182e87.3
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690409760; x=1691014560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P/sqc18KIK7dshywkzhq0KOuh2Dzddlts3yGF32bqfQ=;
        b=dchqpLV7SRPQprn70CICb5MoiAOapA8YyqfY1jkvko2beqSDEfKw9OZBzldPdmlRZo
         1ypAoRkik5SI9cBKp8JkqX5C5fmiKcVZCaSjZw/5VSzKupD6dRL8aGafGoKJ59w2lnH7
         BFTMVvkYfRg5lW6uzaa6K9oedCu/piEuq88Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690409760; x=1691014560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/sqc18KIK7dshywkzhq0KOuh2Dzddlts3yGF32bqfQ=;
        b=GT1VYZhGD8Mrb7NAR9io7VRw+K5OILy5KhDHkL+cUmo5Lc0mo18FM8aX6yxoYRxlXg
         3psMRQyxyFXOHitWU47WeCpJ0Vt9Yz43hwfYpyJRQh2jV4MjZ1katDLSxwoFk57iBzOs
         lDT6F79u8XwNxEQ1nM09cI6w0xC+TDJWR4T62855pb28muvppi5nvbKg7U4ck4hLhv9I
         +TQEjQ9rYThzjDEp4R/XUVwxhRJ5S+bvbhmfO7ivmvsu7j6L0o4MDfSwTwt7HEoh55OA
         4uBP0HDA8cpjKSDIJXf5obIJRlepBLcd+KAvfdpfWFBEN7Af1fPLTeCqp3F+XmljC14+
         OXyQ==
X-Gm-Message-State: ABy/qLYUt31hdxijo6u/lBDowgWLsH/kfEGsM3qiQL7xzJGleyoQDBb/
	MRu/K6/7QcvYEIqQsk3Nl2EdWouZImv47a5xxUBgb6XD
X-Google-Smtp-Source: APBJJlFPtmCLFiXRzizlfvtw8rYdMomTEPvcENKLndlz7Yh+/ojjBiOaWFr6SGiQ4qUNjy+WGEXC4Q==
X-Received: by 2002:ac2:4c39:0:b0:4fd:fef7:95a5 with SMTP id u25-20020ac24c39000000b004fdfef795a5mr291014lfq.11.1690409760023;
        Wed, 26 Jul 2023 15:16:00 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 17-20020ac24851000000b004fdc9ee07d3sm11910lfy.156.2023.07.26.15.15.58
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 15:15:58 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fdd31bf179so487349e87.2
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:15:58 -0700 (PDT)
X-Received: by 2002:ac2:5592:0:b0:4fb:772a:af17 with SMTP id
 v18-20020ac25592000000b004fb772aaf17mr288800lfg.37.1690409758357; Wed, 26 Jul
 2023 15:15:58 -0700 (PDT)
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
 <20230726133648.54277d76@kernel.org> <CAHk-=whZHcergYrraQGgazmOGMbuPsDfRMBXjFLo1aEQPqH2xQ@mail.gmail.com>
 <20230726145721.52a20cb7@kernel.org>
In-Reply-To: <20230726145721.52a20cb7@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Jul 2023 15:15:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrk1O+a74xKbKMNshZc9dKByWbyXvW+Wre=DQwPjTKGA@mail.gmail.com>
Message-ID: <CAHk-=wjrk1O+a74xKbKMNshZc9dKByWbyXvW+Wre=DQwPjTKGA@mail.gmail.com>
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

On Wed, 26 Jul 2023 at 14:57, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Lots of those will be false positives, and also I do not want
> to sign up to maintain a bot which actively bothers people.

I don't really see the difference between creating a bot that
"actively bothers people" and asking _people_ to run a script and then
re-send the patch to actively bother the exact same people.

They'd get bothered either way.

At least with the bot, they can opt out of the automation.

> Sidebar, but IMO we should work on lore to create a way to *subscribe*
> to patches based on paths without running any local agents.

I already contacted Konstantin to see how hard it would be to change
patchwork-bot scripting, and he's trawling this thread.

Maybe he will just go "the code already does all the patch detection
and looks up pathnames in them anyway, and we already maintain a list
of people who do not want to be bothered, it would be easy to add the
'please bother me for these paths' script too".

             Linus


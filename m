Return-Path: <netdev+bounces-21613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11968764057
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 22:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468262802AE
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4F51988F;
	Wed, 26 Jul 2023 20:13:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFF04CE6C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 20:13:32 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8001C11B
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:13:31 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99454855de1so13345966b.2
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690402409; x=1691007209;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9CJQI8Qdop0YIXvc46Q9cOG1BD1fZ1dUQROtQfx9W58=;
        b=HWeE6BYHQldG/g9aD2RlJWlrwEqBefZ0wRSion9GC2NbR8uOYIPDV0KCBPRjtLlt/F
         ouofWwC5054sE8u2erErqII+w/DCye6AiiGEle30Q8V7pn5Pk/rCPo8PjNEkEyd7W7aC
         VoBoBVApvYK8AfKl4/CVzylgrSnDNs83fMeqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690402409; x=1691007209;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9CJQI8Qdop0YIXvc46Q9cOG1BD1fZ1dUQROtQfx9W58=;
        b=jp5l+BDGxiagLmvR3Dr+xLDBAdfjoo/hoYZX5e3DjjPscE6AvzcEcOOPYAbkl6F26H
         A67TNP8fOiDO1wCz3LjWWaR7ceU/Ot/GenViuvAfbYx84FZ6yNAPuN8bUcmWX/AH4V7j
         Nh8TxFMEfm8kML89cVDbTvVy3+gj6vJC0U4MFUe2nQM0jm4dHsF4ZVrNTOWD64/JNsuN
         Zeoiv0sP6+XJ01/RCewWTjFyrPTcteG3VtrlrYkcWrH0bdrx7E6ZW/QasMi1KUCgpEFe
         dZsB/WNnIyBvryeThf7IkGRrmVOdZuuDNAyrfX/VTX0QFK3COTBGwxBKQoVczm+t6zn1
         CR/w==
X-Gm-Message-State: ABy/qLZb6a3+nKRnYMxTvoYbsPgd1gmFXhsT7slzamzJtg/1oTUZYAx3
	Doo+C3QcN7wxOgieTNmcrvqcMlu68eks+VetprwhIfV9
X-Google-Smtp-Source: APBJJlGbdqMiTKiF2Gd2TXwQ6dfMksMmoyr3FZUlgx7pwbntI734yyzMUlUQXtOESPni//u99cHh+g==
X-Received: by 2002:a17:906:5a64:b0:99b:cb7a:c164 with SMTP id my36-20020a1709065a6400b0099bcb7ac164mr166215ejc.62.1690402409778;
        Wed, 26 Jul 2023 13:13:29 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id ks17-20020a170906f85100b009930c80b87csm10141264ejb.142.2023.07.26.13.13.28
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 13:13:29 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso1451865e9.2
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 13:13:28 -0700 (PDT)
X-Received: by 2002:a05:6000:1289:b0:313:ee2e:dae5 with SMTP id
 f9-20020a056000128900b00313ee2edae5mr156669wrx.21.1690402408465; Wed, 26 Jul
 2023 13:13:28 -0700 (PDT)
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
 <CAHk-=whCE9cWmTXu54WFQ7x-aH8n=dhCux2h49=pYN=14ybkxg@mail.gmail.com> <20230726130318.099f96fc@kernel.org>
In-Reply-To: <20230726130318.099f96fc@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Jul 2023 13:13:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfC4tFnOC0Lk_GcU4buf+X-Jv965pWg+kMRkDb6hX6mw@mail.gmail.com>
Message-ID: <CAHk-=wjfC4tFnOC0Lk_GcU4buf+X-Jv965pWg+kMRkDb6hX6mw@mail.gmail.com>
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

On Wed, 26 Jul 2023 at 13:03, Jakub Kicinski <kuba@kernel.org> wrote:
>
> IOW solving the _actually_ missing CCs is higher priority for me.

You have the script. It's already being run. Use it.

Having scripting that complains about missing Cc's, even *lists* them,
and then requires a human to do something about it - that's stupid.

Why are you using computers and automation in the first place, if said
automation then just makes for more work?

Then requiring inexperienced developers to do those extra things,
knowing - and not caring - that the experienced ones won't even
bother, that goes from stupid to actively malicious.

And then asking me to change my workflow because I use a different
script that does exactly what I want - that takes "stupid and
malicious" to something where I will just ignore you.

In other words: those changes to get_maintainer are simply not going to happen.

Fix your own scripts, and fix your bad workflows.

Your bad workflow not only makes it harder for new people to get
involved, they apparently waste your *own* time so much that you are
upset about it all.

Don't shoot yourself in the foot - and if you insist on doing so,
don't ask *others* to join you in your self-destructive tendencies.

               Linus


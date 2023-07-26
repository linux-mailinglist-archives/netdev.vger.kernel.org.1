Return-Path: <netdev+bounces-21668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C7C7642B4
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 01:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379F5282007
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A09DDCA;
	Wed, 26 Jul 2023 23:47:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B18EDDCE
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 23:47:43 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C26AA
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:47:42 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63cf57c79b5so2791846d6.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 16:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690415261; x=1691020061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b2NTLb/puU8U6C4ofXhlTQlXpZUglV4pD0JYAgBXbl0=;
        b=er1zrpYeIqGlzNrbH19Q6aMGuLmQQWTkL0L5MxIcF5ltPL3FTkYondsKru27rr5YST
         odC8GsnYuWW417RCXirGSvREgx3bAR4weKKRv66/tqjy3QVATAOE/xAT/QALb/fFibev
         xe2Gd6LOoDZ73xURnhSf+oV1bGTSauXHHfuMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690415261; x=1691020061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2NTLb/puU8U6C4ofXhlTQlXpZUglV4pD0JYAgBXbl0=;
        b=Ne1Sug0CoJwPi36TrlkVt0Be3urL8e2aETgTOkw1dKer2LMSi+TPSBZmZiFovfzDjL
         k2koglGuNSMMU/MTvFobkIFkKJF5/0h8CQyxiV46wsEBXTBIb5BDSgwXJVjYcPrlwmCF
         cQqHCtOGB2N+Umd2F8kby55vi3LOGHAUC559oolvbDmuwPSgowKw/2oksQbwX+9Ekk1w
         lr/8k2XtU+bKUdzGMk7WKYdTGytddxvIbNc1Fe8SogVRNoCIFnQWdZmEeo2Cofl8IeV0
         YNRSAyKaTbbwDtXeWWODuv+4+j8i1E1LYz3216px7JF8cJ+8yOk2/5pzCQ0nwYI/08Oq
         kFGQ==
X-Gm-Message-State: ABy/qLY1c2clhNepiXBzJLHbPTpy8UgtI8z0Bv0MP3XFOF+C01+0svrZ
	vCo8dQFLQ4i8t1Eg7RiQyiBr9w==
X-Google-Smtp-Source: APBJJlGCKembOaaHRK5Xt40R50gl2FC9xqA985Mdk/VdrxNGSAgyQc07IxqGLUBRm723Qx6jo99l6Q==
X-Received: by 2002:a05:6214:d46:b0:636:2e7c:4955 with SMTP id 6-20020a0562140d4600b006362e7c4955mr4994336qvr.20.1690415261717;
        Wed, 26 Jul 2023 16:47:41 -0700 (PDT)
Received: from meerkat.local ([142.113.79.114])
        by smtp.gmail.com with ESMTPSA id v6-20020a0c9c06000000b00623839cba8csm11576qve.44.2023.07.26.16.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 16:47:40 -0700 (PDT)
Date: Wed, 26 Jul 2023 19:47:31 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Joe Perches <joe@perches.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	geert@linux-m68k.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org, 
	workflows@vger.kernel.org, mario.limonciello@amd.com
Subject: Re: [PATCH v2] scripts: get_maintainer: steer people away from using
 file paths
Message-ID: <20230726-june-mocha-ad6809@meerkat>
References: <CAHk-=wi9MyyWmP_HAddLrmGfdANkut6_2f9hzv9HcyTBvg3+kA@mail.gmail.com>
 <20230726114817.1bd52d48@kernel.org>
 <CAHk-=wiuR7_A=PbN8jhmqGPJQHypUHR+W4-UuSVhOVWvYXs1Tg@mail.gmail.com>
 <CAHk-=wh4pbrNZGqfV9u1urZr3Xjci=UV-MP+KneB6a5yo7-VOQ@mail.gmail.com>
 <CAHk-=whCE9cWmTXu54WFQ7x-aH8n=dhCux2h49=pYN=14ybkxg@mail.gmail.com>
 <20230726130318.099f96fc@kernel.org>
 <CAHk-=wjfC4tFnOC0Lk_GcU4buf+X-Jv965pWg+kMRkDb6hX6mw@mail.gmail.com>
 <20230726133648.54277d76@kernel.org>
 <CAHk-=whZHcergYrraQGgazmOGMbuPsDfRMBXjFLo1aEQPqH2xQ@mail.gmail.com>
 <20230726145721.52a20cb7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230726145721.52a20cb7@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 02:57:21PM -0700, Jakub Kicinski wrote:
> > The patchwork notification could be just a small note (the same way
> > the pull request notes are) that point to the submission, and say
> > "your name has been added to the Cc for this patch because it claims
> > to fix something you authored or acked".
> 
> Lots of those will be false positives, and also I do not want 
> to sign up to maintain a bot which actively bothers people.

I feel seen.

> And have every other subsystem replicate something of that nature.
> 
> Sidebar, but IMO we should work on lore to create a way to *subscribe*
> to patches based on paths without running any local agents. But if I
> can't explain how get_maintainers is misused I'm sure I'll have a lot
> of luck explaining that one :D

I just need to get off my ass and implement this. We should be able to offer
the following:

- subsystem maintainers come up with query language for what they want
  to monitor (basically, whatever the query box of lore.kernel.org takes)
- we maintain a bot that runs these queries and populates a public-inbox feed
- this feed is available via read-only pop/imap/nntp (pull subscription)
- it is also fed to a mailing list service (push subscription)

The goal is to turn the tables -- instead of patch submitters needing to
figure out where the patch needs to go (via get_maintainer or similar
scripts), they just send everything to lkml or patches@lists.linux.dev and let
the system figure out who needs to look at them.

That's for the part that I was already planning to do. In addition, coming
back to the topic of this thread, we could also look at individual patches
hitting the feed, pass them through any desired configuration of
get_maintainer.pl, and send them off any recipients not already cc'd by the
patch author. I believe this is what you want to have in place, right, Jakub?

-K


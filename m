Return-Path: <netdev+bounces-31074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE33378B3F1
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 17:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54508280E3E
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C7E12B95;
	Mon, 28 Aug 2023 15:04:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016E446AB
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 15:04:21 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6661719A
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 08:04:19 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56f89b2535dso3446051a12.2
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693235058; x=1693839858;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44z04Upq456UQmw678VVBxGUGBJlGyeCqGamftbBzBI=;
        b=Bca4GV07GnbP4IljcxqEtjvbsFZpcG4jPrU5WCCNXdm1k7CxCyQpMXViKrpKJaC0dx
         iamXNq+8E7JJiDekFSF0SVuwpVErBsBnqY5ZypsRzZFH3VfgHFLvfMnDkuBu97EqHDAD
         86bQuk3Ad/V+x8rtBRA8BH/UaGumufTYqkgM2osFH61TTOqSMwvoOKlzEQiBIOjfe7JT
         pMSTlYYBSRIy6Xf9GaNSazM8a7j0TD7UanUPOzdNgA0kTGMUTZsVF4vTb6zLWgU+wRxJ
         WTuz+btHaHim7sZsyRloJ/sZdF9lwWHtOltS3RmQMKVntJvkiF9jgv/hCCIaqmQUrUpU
         x4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235058; x=1693839858;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44z04Upq456UQmw678VVBxGUGBJlGyeCqGamftbBzBI=;
        b=O/Vdgt+qYGD/zFRiDjk/cpUKkcH0fv0KviEXkKhHIIty3VJwTUsR0S8hbNTVGUXjdq
         I7G9v7Buk4udT8txzrHba2pZubBtOxhJv4tduKWM8uhEU4wNpWZ2usYBVWaRJIM0XsXz
         nEKewEeEcFShQVVhhRh6l2IxAoboY5ZWIys7Y2p/u5xTmNIXr/aBOZbjHrYDg52t5wZm
         1bzcuMA+l0SyfBfR+WQyWZILsZ74WOItPu5lueOT377SvqpCblvcdVUTT12ods/ZQgk0
         fPh8kiXFB8Zxi5nkWyQqgpcrXJnecXxyYneom2I5v+YEf8gzFBrzABRqnUUk+zE/+dzx
         JUtg==
X-Gm-Message-State: AOJu0YyxT0P2LTo1E2sX3Y9xDnyljK2sAmqXYcDl20wRac5xYV729Sa/
	1iKJNAbzM+zG7pMcEx87mnKFHqciANI=
X-Google-Smtp-Source: AGHT+IHx8QoPWXG0uiFs074kxBJ4wZlo7XAZfUZCF9qCl2ZpFWDd3rF0lIPdKRvJ34ciqAdr+HR2gVtKTXk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:6d83:0:b0:566:2d6:f720 with SMTP id
 i125-20020a636d83000000b0056602d6f720mr4944654pgc.7.1693235058652; Mon, 28
 Aug 2023 08:04:18 -0700 (PDT)
Date: Mon, 28 Aug 2023 08:04:17 -0700
In-Reply-To: <20230826094523.bl6kbcwelj23cydu@mmaatuq-HP-Laptop-15-dy2xxx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230824202415.131824-1-mahmoudmatook.mm@gmail.com>
 <ZOjIHo2A6HZ8K4Qp@google.com> <20230826094523.bl6kbcwelj23cydu@mmaatuq-HP-Laptop-15-dy2xxx>
Message-ID: <ZOy3cXUJld0FskSk@google.com>
Subject: Re: [PATCH v2 1/2] selftests: Provide local define of min() and max()
From: Sean Christopherson <seanjc@google.com>
To: keescook@chromium.org, edumazet@google.com, 
	willemdebruijn.kernel@gmail.com, wad@chromium.org, luto@amacapital.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org, 
	shuah@kernel.org, pabeni@redhat.com, linux-kselftest@vger.kernel.org, 
	davem@davemloft.net, linux-kernel-mentees@lists.linuxfoundation.org, 
	David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 26, 2023, Mahmoud Matook wrote:
> On 08/25, Sean Christopherson wrote:
> 
> > On Fri, Aug 25, 2023, Mahmoud Maatuq wrote:
> > > to avoid manual calculation of min and max values
> > > and fix coccinelle warnings such WARNING opportunity for min()/max()
> > > adding one common definition that could be used in multiple files
> > > under selftests.
> > > there are also some defines for min/max scattered locally inside sources
> > > under selftests.
> > > this also prepares for cleaning up those redundant defines and include
> > > kselftest.h instead.
> > > 
> > > Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> > > Suggested-by: David Laight <David.Laight@aculab.com>
> > > ---
> > > changes in v2:
> > > redefine min/max in a more strict way to avoid 
> > > signedness mismatch and multiple evaluation.
> > > is_signed_type() moved from selftests/kselftest_harness.h 
> > > to selftests/kselftest.h.
> > > ---
> > >  tools/testing/selftests/kselftest.h         | 24 +++++++++++++++++++++
> > 
> > Heh, reminds me of https://xkcd.com/927.
> > 
> > All of these #defines are available in tools/include/linux/kernel.h, and it's
> > trivially easy for selftests to add all of tools/include to their include path.
> > I don't see any reason for the selftests framework to define yet another version,
> > just fix the individual tests.
> 
> giving the reviews seems that patchset is useless.
> still a confusing point for me; after adding tools/include to the
> include path of selftes how we can differentaite between  #include
> <linux/kernel.h> that under tools/include and one under usr/include.

AFAIK, it's up to the individual selftest (or it's "local" framework) to declare
the tools/include path before usr/include, e.g. see tools/testing/selftests/kvm/Makefile.

The whole setup is definitely a bit kludgy, but IMO it's better than conditionally
providing selftests specific fallbacks and potentially ending up with multiple
definitions of min/max within a single test.


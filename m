Return-Path: <netdev+bounces-37917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD8B7B7CA8
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 11:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 82A451F22100
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F4110A3B;
	Wed,  4 Oct 2023 09:56:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980B10979
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 09:56:20 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9A0AC
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 02:56:18 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c5ff5f858dso14551315ad.2
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 02:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696413378; x=1697018178; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GykaW6kDbjL87sfPlGqTF+d4Ec65ZCIYQ7rMG6z62s=;
        b=gWbOjlytZgV0+fT/G2gHgq51Rrg298sJyUdtxhLi0EBNbsq3MNOKJdU6LWlsszCvRT
         bJ8JZLhp88nXqvOjmnA4Wk2UiOqMzyqG/Uvyoz9w6mfbAz730TO9uemMrj6Li9jBtVg5
         bqjDl91IBEmDs30LtMBd4jlMQedR07NeTDl6/Gc7bVVPCAOs8W2WFXhJzGAE3XNLKV8f
         OuHjGqeFy9QXkUESTjhJqiQ+acA0kLar5RUtIItwnbKkapRaRFfkn+Xu8LWgT5Ed+43w
         EVGjf0vBZyoT2a2qMTVfdjUrbr8rJmA4dRfQMonbcMHlpHlDRdRw0C7vaBBdFXI3mX2T
         Ct2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696413378; x=1697018178;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5GykaW6kDbjL87sfPlGqTF+d4Ec65ZCIYQ7rMG6z62s=;
        b=RxnFgsWJEeJ7Ln+wgBf64bdc2+rctaEPm9y8jeMe0xQALkZhPX5GC4vm88D5lu+8ct
         F81fvy4xlSTVeGpt3kzcoY7CFmRWq6bR1k3425LEWoSBvclm6/wlVDDUY6To18ntuQzO
         5A6eKXdYng8uvxRV3+9mE8DyFIJXBxtdgTMPcY5trspR+wpSA33Z/lNHyIFJyaCeTZCu
         Ire3vFSdn6d1YXCf1mgL/D7Oc+phX+9m4QBLijr2A2NVseqIQXHZOZABfJ/M1qCnbqh4
         wT7E8wQ8Du5/ZGRIgseEX3Os/FXH2RcGxq1fbXCpWUGdOTNUkF/4DOfEPLRW/ebYL/qW
         siGg==
X-Gm-Message-State: AOJu0YwtnBcZfmmb1wnzlUU+UvyfePFqsgkVRORjkIIt0VCN5xmkhbBb
	t5624sVHII0fJcDo44Vkv1k=
X-Google-Smtp-Source: AGHT+IE09KBZD8Dp5MUlnhkuOUecFjnWNRhC4y8wKwLtrF1KvaE0lzlU+sGIM/uRSyeEoNKMoQvy7w==
X-Received: by 2002:a17:903:41c3:b0:1c7:362f:18d5 with SMTP id u3-20020a17090341c300b001c7362f18d5mr2017211ple.18.1696413377925;
        Wed, 04 Oct 2023 02:56:17 -0700 (PDT)
Received: from localhost ([203.221.51.174])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902d3c400b001c60a04e1cesm3223156plb.36.2023.10.04.02.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 02:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Oct 2023 19:56:12 +1000
Message-Id: <CVZKCOOZ2SF4.2DYPVWT5C2TDQ@wheely>
Cc: <dev@openvswitch.org>, "Aaron Conole" <aconole@redhat.com>, "Eelco
 Chaudron" <echaudro@redhat.com>, "Simon Horman" <horms@ovn.org>
Subject: Re: [ovs-dev] [RFC PATCH 0/7] net: openvswitch: Reduce stack usage
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Ilya Maximets" <i.maximets@ovn.org>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20230927001308.749910-1-npiggin@gmail.com>
 <a018e82f-5cce-fb81-b52c-901e106c16eb@ovn.org>
 <CVU6AV9T8CVH.GCHC8KB7QZ28@wheely>
 <21f2a427-ad07-ee73-30f5-d9a8f1ed4f85@ovn.org>
In-Reply-To: <21f2a427-ad07-ee73-30f5-d9a8f1ed4f85@ovn.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon Oct 2, 2023 at 9:54 PM AEST, Ilya Maximets wrote:
> On 9/28/23 03:52, Nicholas Piggin wrote:
> > On Wed Sep 27, 2023 at 6:36 PM AEST, Ilya Maximets wrote:
> >> On 9/27/23 02:13, Nicholas Piggin wrote:
> >>> Hi,
> >>>
> >>> We've got a report of a stack overflow on ppc64le with a 16kB kernel
> >>> stack. Openvswitch is just one of many things in the stack, but it
> >>> does cause recursion and contributes to some usage.
> >>>
> >>> Here are a few patches for reducing stack overhead. I don't know the
> >>> code well so consider them just ideas. GFP_ATOMIC allocations
> >>> introduced in a couple of places might be controversial, but there
> >>> is still some savings to be had if you skip those.
> >>>
> >>> Here is one place detected where the stack reaches >14kB before
> >>> overflowing a little later. I massaged the output so it just shows
> >>> the stack frame address on the left.
> >>
> >> Hi, Nicholas.  Thanks for the patches!
> >=20
> > Hey, sorry your mail didn't come through for me (though it's on the
> > list)... Anyway thanks for the feedback.
> >=20
> > And the important thing I forgot to mention: this was reproduced on a
> > RHEL9 kernel and that's where the traces are from. Upstream is quite
> > similar though so the code and call chains and stack use should be
> > pretty close.
> >=20
> > It's a complicated configuration we're having difficulty with testing
> > upstream kernel. People are working to test things on the RHEL kernel
> > but I wanted to bring this upstream before we get too far down that
> > road.
> >=20
> > Unfortunately that means I don't have performance or exact stack
> > use savings yet. But I will let you know if/when I get results.
> >=20
> >> Though it looks like OVS is not really playing a huge role in the
> >> stack trace below.  How much of the stack does the patch set save
> >> in total?  How much patches 2-7 contribute (I posted a patch similar
> >> to the first one last week, so we may not count it)?
> >=20
> > ovs functions themselves are maybe 30% of stack use, so significant.  I
> > did find they are the ones with some of the biggest structures in local
> > variables though, so low hanging fruit. This series should save about
> > 2kB of stack, by eyeball. Should be enough to get us out of trouble for
> > this scenario, at least.
>
> Unfortunately, the only low handing fruit in this set is patch #1,
> the rest needs a serious performance evaluation.
>
> >=20
> > I don't suggest ovs is the only problem, I'm just trying to trim things
> > where possible. I have been trying to find other savings too, e.g.,
> > https://lore.kernel.org/linux-nfs/20230927001624.750031-1-npiggin@gmail=
.com/
> >=20
> > Recursion is a difficulty. I think we recursed 3 times in ovs, and it
> > looks like there's either 1 or 2 more recursions possible before the
> > limit (depending on how the accounting works, not sure if it stops at
> > 4 or 5), so we're a long way off. ppc64le doesn't use an unusually larg=
e
> > amount of stack, probably more than x86-64, but shouldn't be by a big
> > factor. So it could be risky for any arch with 16kB stack.
>
> The stack trace looks like a very standard trace for something like
> an ovn-kubernetes setup.  And I haven't seen such issues on x86 or
> aarch64 systems.  What architectures beside ppc64le use 16kB stack?

AFAIKS from browsing defines of defaults for 64-bit builds, all I
looked at do (riscv, s390, loongarch, mips, sparc).

They will all be different about how much stack the compiler uses,
some type sizes that could be in local variables, and details of
kernel entry and how irq stacks are implemented. Would be interesting
to compare typical stack usage of different archs, I haven't made a
good study of it.

> >=20
> > I wonder if we should have an arch function that can be called by
> > significant recursion points such as this, which signals free stack is
> > low and you should bail out ASAP. I don't think it's reasonable to
> > expect ovs to know about all arch size and usage of stack. You could
> > keep your hard limit for consistency, but if that goes wrong the
> > low free stack indication could save you.
>
> Every part of the code will need to react somehow to such a signal,
> so I'm not sure how the implementations would look like.

Not every, it can be few strategic checks. The recursion test that
is already in ovs, for example.

Thanks,
Nick


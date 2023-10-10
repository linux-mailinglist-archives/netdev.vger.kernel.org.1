Return-Path: <netdev+bounces-39608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 902C67C00CE
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C174E1C20B20
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C7527474;
	Tue, 10 Oct 2023 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C12746C
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:52:38 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62D293;
	Tue, 10 Oct 2023 08:52:35 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so1217589276.0;
        Tue, 10 Oct 2023 08:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696953154; x=1697557954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5v3FkTbsb5hlPcYZ5mv1Oy8Tmvc6KnvkZoVnkmSSDg=;
        b=k3pJ23ONIHrCNoDUe28TRszODo7jcEY1U5HarBRcVHFW4hkHEFtyN0CH8q8NvnssUa
         dLWBuyYfgZYgVA9V+VpGdU8KVDOgDeBHg96CUt+m60G/Oxx9za6xI+dldsDPs03/ZTqv
         qHlGT1SEbNi8/1K8BHIXYLF6IYMoPAzGkp4NZvq2/XeutSjMtzannYt/41fnQ2TkcWmh
         RDad+nwvB3dGS9YVxRr0AFDbfzPUf4mUtZIGBZKQ2sHTYpLObwG4JqKX0msSsj1STQmZ
         TP/+Y+/HzgpXIiNRYUwJDD++OWqF+6dq06AKDx1C8UieuJ9PrDBBqi2Y164a6wm+zI1O
         y9oA==
X-Gm-Message-State: AOJu0Yxg6gp0dBmFECk37V5KmqfOdntOHMxByWtjR70QehCNe1Zq4jDx
	qMQLBRvo38Q1G1JxjH3i43HCTrfdah1kcQ==
X-Google-Smtp-Source: AGHT+IFt0vKNtPkILiaAeP/D0jfhIzsY2LwiAXkwDw5v00zw7f43GtXDGyssFhelJmu6ro0DhEzdIg==
X-Received: by 2002:a25:cb90:0:b0:d81:65a9:ac6c with SMTP id b138-20020a25cb90000000b00d8165a9ac6cmr18084788ybg.24.1696953154595;
        Tue, 10 Oct 2023 08:52:34 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 64-20020a250a43000000b00d814d8dfd69sm3844650ybk.27.2023.10.10.08.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 08:52:34 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a505762c9dso71494297b3.2;
        Tue, 10 Oct 2023 08:52:34 -0700 (PDT)
X-Received: by 2002:a0d:d546:0:b0:58f:a19f:2b79 with SMTP id
 x67-20020a0dd546000000b0058fa19f2b79mr20030944ywd.9.1696953154216; Tue, 10
 Oct 2023 08:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009225637.3785359-1-kuba@kernel.org> <2403fd80-e32c-4e5b-a215-55c7bb88df8d@kernel.org>
In-Reply-To: <2403fd80-e32c-4e5b-a215-55c7bb88df8d@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Oct 2023 17:52:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXXO3jHWkry6NNuvF_nQkvfb87b_Ca8E_so=1LWghrV9w@mail.gmail.com>
Message-ID: <CAMuHMdXXO3jHWkry6NNuvF_nQkvfb87b_Ca8E_so=1LWghrV9w@mail.gmail.com>
Subject: Re: [PATCH net-next] docs: try to encourage (netdev?) reviewers
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	edumazet@google.com, pabeni@redhat.com, corbet@lwn.net, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, andrew@lunn.ch, 
	jesse.brandeburg@intel.com, sd@queasysnail.net, horms@verge.net.au, 
	przemyslaw.kitszel@intel.com, f.fainelli@gmail.com, jiri@resnulli.us, 
	ecree.xilinx@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Matt,

On Tue, Oct 10, 2023 at 5:19=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
> On 10/10/2023 00:56, Jakub Kicinski wrote:
> > Add a section to netdev maintainer doc encouraging reviewers
> > to chime in on the mailing list.
> >
> > The questions about "when is it okay to share feedback"
> > keep coming up (most recently at netconf) and the answer
> > is "pretty much always".
> >
> > Extend the section of 7.AdvancedTopics.rst which deals
> > with reviews a little bit to add stuff we had been recommending
> > locally.
>
> Good idea to encourage everybody to review, even the less experimented
> ones. That might push me to send more reviews, even when I don't know
> well the area that is being modified, thanks! :)
>
> (...)
>
> > diff --git a/Documentation/process/7.AdvancedTopics.rst b/Documentation=
/process/7.AdvancedTopics.rst
> > index bf7cbfb4caa5..415749feed17 100644
> > --- a/Documentation/process/7.AdvancedTopics.rst
> > +++ b/Documentation/process/7.AdvancedTopics.rst
> > @@ -146,6 +146,7 @@ pull.  The git request-pull command can be helpful =
in this regard; it will
> >  format the request as other developers expect, and will also check to =
be
> >  sure that you have remembered to push those changes to the public serv=
er.
> >
> > +.. _development_advancedtopics_reviews:
> >
> >  Reviewing patches
> >  -----------------
> > @@ -167,6 +168,12 @@ comments as questions rather than criticisms.  Ask=
ing "how does the lock
> >  get released in this path?" will always work better than stating "the
> >  locking here is wrong."
>
> The paragraph just above ("it is OK to question the code") is very nice!
> When I'm cced on some patches modifying some code I'm not familiar with
> and there are some parts that look "strange" to me, I sometimes feel
> like I only have two possibilities: either I spend quite some time
> understanding that part or I give up if I don't have such time. I often
> feel like I cannot say "I don't know well this part, but this looks
> strange to me: are you sure it is OK to do that in such conditions?",
> especially when the audience is large and/or the author of the patch is
> an experienced developer.

Yes you can (even experienced developers can make mistakes ;-)!

If it is not obvious that something is safe, it is better to point it
out, so the submitter (or someone else) can give it a (second) thought.
In case it is safe, and you didn't miss the ball completely, it probably
warrants a comment in the code, or an improved patch description.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


Return-Path: <netdev+bounces-21652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEB17641D6
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 00:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576BB1C21370
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 22:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4378318050;
	Wed, 26 Jul 2023 22:02:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AED1BF07
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 22:02:24 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57486211F
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:02:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so50478666b.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690408941; x=1691013741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GY186T8m/bDCmaQhdLceOK7QlWH6sfqqrFjk853Mroc=;
        b=ZlEjpgTswNyeC2aD0u7KqX182+Wu6Nm28qo4hUgQFXpkqndCJIElxjRMV07rPz0N6T
         jsGpz5JKATZ169JHR2xHD9FTAnM0KHilfcnXF96kX9OvYQlUtU7NqZnedbDfb2YmxanL
         qsBl6n3as/e3vD792jT3SkgiM6SDbk+rHgkAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690408941; x=1691013741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GY186T8m/bDCmaQhdLceOK7QlWH6sfqqrFjk853Mroc=;
        b=GBAHe6tlej9RhcCSGHsaUqSbz0m0N6+ZyueWj+tmE7Y5LkAQRqNHY4zwOWRCaISSLg
         t44xGwfGUodW9aJcZfbtPz7orKGfV+B4NgmaHZJbfjQkc4dQVl+xKZO7/A9f2Zu0+j/p
         cBvohExkBHuo0S8Z93l3QCKOx840We14Ah12gp2VLxuynyfS+BbDoxyq3eMcEF5SLHTv
         UIxQEIYovBSXOIZHuG9V+E3l0SmaegAxxhNs++Xd9om7kxM5LcVBb0YkInOEwjlBw+LL
         3qGVLIAhNcoHsoZzF7lwCCOiDm9H0U5v/XquBXe9Em3Um8Eh6maYED0fjRIgdGrbkPtu
         jGPA==
X-Gm-Message-State: ABy/qLat8i24zC6Iqed7AcZ6sOh9Gf4TWNDPEtm8C57ej0DRstmL/Zc3
	6LDsz+6BqbRgJ9Ei16bNsZ7O+t2ukIIUwg4fsxPt9yeX
X-Google-Smtp-Source: APBJJlH269cKUpwNyxDNQzXEhEm53a9GrmQEst+L32h2Y5zMawPThw/ez3ZmD5GGVBrCFDPI7o493g==
X-Received: by 2002:a17:907:3f0c:b0:988:565f:bf46 with SMTP id hq12-20020a1709073f0c00b00988565fbf46mr364171ejc.32.1690408941741;
        Wed, 26 Jul 2023 15:02:21 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709060b1200b00991faf3810esm10243959ejg.146.2023.07.26.15.02.20
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 15:02:20 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so3174378a12.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:02:20 -0700 (PDT)
X-Received: by 2002:a05:6402:3552:b0:522:405f:a7 with SMTP id
 f18-20020a056402355200b00522405f00a7mr344715edd.16.1690408939880; Wed, 26 Jul
 2023 15:02:19 -0700 (PDT)
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
Date: Wed, 26 Jul 2023 15:02:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJx-FDuH6+22D+L2gMdVOpYi948oWpJr7BpbS-0pEqFg@mail.gmail.com>
Message-ID: <CAHk-=wiJx-FDuH6+22D+L2gMdVOpYi948oWpJr7BpbS-0pEqFg@mail.gmail.com>
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

On Wed, 26 Jul 2023 at 14:57, Jakub Kicinski <kuba@kernel.org> wrote:
>
> > And it can't even be the right thing to do, when experienced
> > developers don't do it.
>
> I explained to you already that Florian's posting is a PR.

.. and your point is?

The fact is, experienced developers don't add cc'd when they commit
their own patches, and nobody bats an eye on it.

So you are *literally* saying that inexperienced people should do this
pointless thing that can be - and is - automated, even though it's
clearly not the thing that is required in general.

And you're saying that I should have to change my workflow to make it
MORE INCONVENIENT to do the thing that you claim inexperienced people
do now.

Yup. We're done here.

               Linus


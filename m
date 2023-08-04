Return-Path: <netdev+bounces-24488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE76770545
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38851C218C5
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8C218056;
	Fri,  4 Aug 2023 15:52:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D7E18053
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50B5C433CA;
	Fri,  4 Aug 2023 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691164354;
	bh=LOq7RS20TqfH4Hdkn/iEhzGYnzzqU4MxbtyZDje5DTM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=db/QpyGWZiGv+hOkDcQmId64EfLtCECXdj6SVN9iqNnUz87wDzhSDSDKkPqhesxXc
	 XkYO8574UAfmZclBZdnsGi8VAqj7rHu/+xeRD5KvG+ijc7xo9ROK2jfD8yKTKqRCsq
	 zX7BT0Uug6JnRWvDTte1vdDZs+zBhkIs/jjQPHMmwIvSG5BIkp48BbFKST0uVCujlZ
	 cjAylaRSCFsl6gdna/65Ckv7KfS6T+R/op7i0mliGSpS53yTpBcmy7X+2F4JyUZyFj
	 GtkGEVfoBBfJpXmPTUq+8Kd9wNfncXOGt2deJxPXuSrP9bccesOId7cwFMM5+Q17UG
	 R0JgvLmb+aF9g==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso35377221fa.0;
        Fri, 04 Aug 2023 08:52:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YwqQwElZ+9EW5E8jDLO+uma3SHv/xdX+z8dcOj3ad9CUYgwuOPY
	Qezacz6yOc2vvZJLp6AO/yw0rB+E2HANBn2XmQ==
X-Google-Smtp-Source: AGHT+IGTRbQZ164zyFuRSDnd5vaQ7H79WmuECLzjpyyzN1RdAra6RmdexIM3oHlL3swhcI2UIbnez1POXc8rZk7AbpE=
X-Received: by 2002:a2e:9d5a:0:b0:2b9:53bd:47a7 with SMTP id
 y26-20020a2e9d5a000000b002b953bd47a7mr1705190ljj.30.1691164352899; Fri, 04
 Aug 2023 08:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
In-Reply-To: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 4 Aug 2023 09:52:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
Message-ID: <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To: Nick Bowler <nbowler@draconx.ca>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 4, 2023 at 9:27=E2=80=AFAM Nick Bowler <nbowler@draconx.ca> wro=
te:
>
> Hi,
>
> With recent kernels (5.18 and newer) the ethernet is all wonky on my
> ZCU104 board.
>
> There is some behaviour inconsistency between kernel versions identified
> during bisection, so maybe there is more than one issue with the ethernet=
?
>
>   6.5-rc4: after 10 seconds, the following message is printed:
>
>     [   10.761808] platform ff0e0000.ethernet: deferred probe pending
>
>   but the network device seemingly never appears (I waited about a minute=
).
>
>   6.1 and 6.4: after 10 seconds, the device suddenly appears and starts
>   working (but this is way too late).

10 sec is probably the deferred probe timeout. You can set this to
less time on the kernel command line.

>   5.18: the device never appears and no unusual messages are printed
>   (I waited ten minutes).
>
> With 5.17 and earlier versions, the eth0 device appears without any delay=
.
>
> Unfortunately, as bisection closed on the problematic section, all the
> built kernels became untestable as they appear to crash during early
> boot.  Nevertheless, I manually selected a commit that sounded relevant:
>
>   commit e461bd6f43f4e568f7436a8b6bc21c4ce6914c36
>   Author: Robert Hancock <robert.hancock@calian.com>
>   Date:   Thu Jan 27 10:37:36 2022 -0600
>
>       arm64: dts: zynqmp: Added GEM reset definitions
>
> Reverting this fixes the problem on 5.18.  Reverting this fixes the
> problem on 6.1.  Reverting this fixes the problem on 6.4.  In all of
> these versions, with this change reverted, the network device appears
> without delay.

With the above change, the kernel is going to be waiting for the reset
driver which either didn't exist or wasn't enabled in your config
(maybe kconfig needs to be tweaked to enable it automatically).

There's not really a better solution than the probe timeout when the
DT was incomplete and new dependencies get added.

> Unfortunately, it seems this is not sufficient to correct the problem on
> 6.5-rc4 -- there is no apparent change in behaviour, so maybe there is
> a new, different problem?

Probably. You might check what changed with fw_devlink in that period.
(Offhand, I don't recall many changes)

> I guess I can kick off another bisection to find out when this revert
> stops fixing things...

That always helps.

Rob


Return-Path: <netdev+bounces-79599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4016487A182
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 03:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE981C21C74
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 02:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27245BA39;
	Wed, 13 Mar 2024 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2RVamJh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFCAAD5D;
	Wed, 13 Mar 2024 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710296064; cv=none; b=JJUgeVTcTcVAu9PcwPnVyvFQhylxnsXGzh/1mAcvrAli5M42BawFhYxTyp8QXh3hsMM6qkPcxQ3Y19jIvLK5veccKCHGJdj6xy8J5s30oTdokff+9AP7XFW0Wi9jk2XYczjD827CQFKIrnUh67cjFmbgf5kxNL2tXMaz58sAB3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710296064; c=relaxed/simple;
	bh=bQvKaUNuxOLbh2Zd7Bm9Wzhd4YERT55XdZepeKceQZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lErpPC16+hfUYzbGdrYpdIftjfWk1+9qpn7PbUMpbwO8M4sFX7I06cTqVOlJvsZf+Bfds9ApKEzCHLV5IO007yxIqbH2T7Gc9lVb9xnuMrAJ1t/CwG9CNwQk+xQyfrkAWIRJGDKxBHWOVvAYHIsbhyNwGv8pzy34dy/nxDXegpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2RVamJh; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d094bc2244so94715571fa.1;
        Tue, 12 Mar 2024 19:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710296060; x=1710900860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWlGMgtGFUDMiub9lfEOWyd26iBw50mR//BdH28ZBac=;
        b=Z2RVamJh5+SNWmNCaVh6Zn6Roi6fF8wcqrPiG+yasEVsRfSk5MjUmSli4OPiJXI6sI
         K2C40nQsO2+q3c/e1EG/fxiDx79+XtPMoOxqT4LDtFylnZk9EjK1WaklQopwk1pMxPyd
         Nn8ShIA4CgrSxZtjFZYqvK18DRmbbL1zAIw8A2qk/hHQrPFUvE1tFEqAePMxjlR4nZwB
         dqNj6dOZvPELtXjdT9eNU9ebG+hJJ5aiek6GP8NH/kuC24T1jj0nbzOSaYTkzmUrlKy+
         HXenvS5GjEbeQUABPFKkzJzWKLwS+WM43dqQlzkpgc5ToXMPegLR6QR/jij5pSVsOVm/
         7gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710296060; x=1710900860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWlGMgtGFUDMiub9lfEOWyd26iBw50mR//BdH28ZBac=;
        b=wGktq14NPbWRzLhGeCwzy6qfEBpKvPUbixlUiYQBbdrLCO/Sk4JVpdy8SBi4LSZlGA
         M5XcjtTNA5yerMisIvTx92918MGumjDA5C/ZUU+ji5fdPqKVEN8PINvfh8+ms4fH0TzZ
         lvAd4BJDBHmOmXYeUEW572Np7/q+tx7WnDz9/HvtAcVJyUOCRf5+qbSL4nN8XVgsp52g
         4OmqccAVw1AQo2aSIqVRkfXxmDzQHVdrGf3jIqNGA6yjKvbsyVWWO47bMwndUBSEME+M
         5DerEKwXdS/KQstI3s1qnIPUgB8mQ3vX15uZIZTdjJqs36SuXBsULkKN9djkBn00u3pe
         8OXg==
X-Forwarded-Encrypted: i=1; AJvYcCUk66lIooi3vM3SHX6tsPowEjmLdlIzvUEt3ZJMMse/ADkUb1ohkIHv0I2tRIvLao8lBGeDfcwdDBwEa5hiTI5eURpy/FjNv4Dl8F7qkaFbuv9GqRXe2r0=
X-Gm-Message-State: AOJu0YzRShJKg9IR7x0O/y4RbNetEjgjaFYySr3iH4aepEzS/m013LrL
	jr8/gnRcpgBXXWh3HblqtPWtYejN9o2cjQiMOoecIy8E6AM453s6A8FADR+2jo66PKzuAkDugMh
	dERSgKlhZOqlrr1e7zcpSPKFeWL17HB9wZ0M=
X-Google-Smtp-Source: AGHT+IEMNUUD0glvCyZqVBRE5TsR+eQSdfMjPhznYFa8NDoPXBM0wrzle3fQkgY/waXDuRxikTR4VDyrxkqh9DVbqRQ=
X-Received: by 2002:a05:6512:2343:b0:513:2ead:4f86 with SMTP id
 p3-20020a056512234300b005132ead4f86mr3279260lfu.12.1710296060128; Tue, 12 Mar
 2024 19:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312124346.5aa3b14a@kernel.org>
In-Reply-To: <20240312124346.5aa3b14a@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 13 Mar 2024 10:13:43 +0800
Message-ID: <CAL+tcoBzHNt86-4OC7Jck1WBG+YuadWDhQrkyEPBaxQxcET6YQ@mail.gmail.com>
Subject: Re: [ANN] netdev development stats for 6.9
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 3:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Intro
> -----
>
> We have posted our pull requests with networking changes for the 6.9
> kernel release last night. As is tradition here are the development
> statistics based on mailing list traffic on netdev@vger.
>
> These stats are somewhat like LWN stats: https://lwn.net/Articles/956765/
> but more focused on review participation.
>
> Previous stats (for 6.8): https://lore.kernel.org/all/20240109134053.33d3=
17dd@kernel.org/
>
> Testing
> -------
>
> The selftest runner went live early during this release.
> I don't have any great ideas on how to quantify the progress
> but, first, I'd like to thank everyone who contributed to improving
> and fixing the tests, and those who contributed to NIPA directly.
> We are reporting results from 243 tests to patchwork (not counting
> kunit tests), each test on two kernel flavors and with many sub-cases.
>
> There's still work to be done fixing some of the tests but we made
> more progress than I anticipated! There are 66 test + kernel config
> combinations which we currently ignore, either because they permanently
> skip / fail or are too flaky. I should mention that those tests do matter=
,
> recently the ignored pmtu test would have caught a last minute xfrm
> regression :(
>
> Speaking of catching regressions, I do not have an objective count but
> subjectively our tests do in fact catch bugs. In fact the signal to noise
> ratio is higher than I initially expected. I wish it was easier to write
> driver tests and use YNL in the tests, but we'll get there..
>
> General stats
> -------------
>
> Cycle started on Tue, 09 Jan, ended Mon, 11 Mar. That's 63 days,
> one week shorter than the previous cycle.
>
> We have seen 264 msg/day on the list, and 24 commits/day.
> The number of messages is back to the level we have seen in 6.6,
> and has recovered after couple of slower releases (last one being
> particularly slow due to the winter break). The number of commits
> applied directly by netdev maintainers is 9% higher than in 6.6
> and highest on the record.
>
> The total number of review tags in git history have dipped again,
> 61% of commits contain a review tag (down from 69%). The number
> of commits with a review tag from an email domain different than
> the author, however, dropped only by 1% to 53%. Similarly our statistic
> of series which received at least one ack / review tag on the list did
> not change much, increasing by 1% to 67%.
>
> Rankings
> --------
>
> As promised last time, the left side of the stats is now in "change
> sets" (cs) rather than threads, IOW trying to track multiple revisions
> of the same series as one.
>
> Top reviewers (cs):                  Top reviewers (msg):
>    1 ( +1) [30] Jakub Kicinski          1 (   ) [66] Jakub Kicinski
>    2 ( -1) [26] Simon Horman            2 (   ) [45] Simon Horman
>    3 (   ) [14] Andrew Lunn             3 (   ) [44] Andrew Lunn
>    4 ( +1) [12] Paolo Abeni             4 ( +3) [25] Jiri Pirko
>    5 ( +4) [11] Jiri Pirko              5 (   ) [23] Eric Dumazet
>    6 ( -2) [10] Eric Dumazet            6 ( +3) [20] Paolo Abeni
>    7 (   ) [ 5] David Ahern             7 ( +1) [15] Krzysztof Kozlowski
>    8 ( +6) [ 4] Stephen Hemminger       8 ( +2) [11] David Ahern
>    9 ( +2) [ 4] Willem de Bruijn        9 ( +4) [10] Florian Fainelli
>   10 (   ) [ 4] Krzysztof Kozlowski    10 ( -6) [10] Vladimir Oltean
>   11 ( +1) [ 4] Florian Fainelli       11 ( -5) [ 9] Russell King
>   12 ( -6) [ 4] Russell King           12 (   ) [ 9] Willem de Bruijn
>   13 ( +3) [ 2] Jacob Keller           13 ( -2) [ 8] Sergey Shtylyov
>   14 ( +1) [ 2] Rob Herring            14 ( +6) [ 7] Jacob Keller
>   15 ( +2) [ 2] Jamal Hadi Salim       15 (+16) [ 7] Jason Wang
>
> Jiri jumps into top 5, reviewing various driver and netlink changes.
> Stephen largely works on iproute2 reviews. Russell and Vladimir have
> indicated that they are occupied outside of netdev, and slip by a few
> positions.
>
> Thank you all for your work!
>
> Top authors (cs):                    Top authors (msg):
>    1 ( +1) [7] Eric Dumazet             1 (+35) [40] Eric Dumazet
>    2 ( -1) [7] Jakub Kicinski           2 ( +5) [26] Jakub Kicinski
>    3 (+46) [4] Breno Leitao             3 ( +1) [20] Saeed Mahameed
>    4 (   ) [3] Heiner Kallweit          4 (+18) [17] Xuan Zhuo
>    5 ( +8) [2] Stephen Hemminger        5 (***) [15] Jason Xing
>    6 (+24) [2] Paolo Abeni              6 (***) [15] Matthieu Baerts
>    7 (+11) [2] Kuniyuki Iwashima        7 (***) [14] Breno Leitao
>    8 (***) [2] Maks Mishin              8 ( -3) [14] Tony Nguyen
>    9 ( +6) [2] Kunwu Chan               9 ( -3) [13] Kuniyuki Iwashima
>   10 (***) [2] Matthieu Baerts         10 ( -8) [11] Christian Marangi
>
> Thanks to switching from threads to changes sets we see Eric rightfully
> claim the #1 spot, previously occupied by yours truly. Breno added
> missing MODULE_DESCRIPTION()s and refactored drivers using per-cpu
> stats. Paolo contributed a number of MPTCP changes and many selftest
> improvements. Maks Mishin sent a lot of individual iproute2 patches.
> Xuan Zhuo is working on vhost / virtio changes for AF_XDP.
>
> Top scores (positive):               Top scores (negative):
>    1 ( +1) [398] Jakub Kicinski         1 ( +2) [80] Saeed Mahameed
>    2 ( -1) [371] Simon Horman           2 (+17) [60] Xuan Zhuo
>    3 (   ) [243] Andrew Lunn            3 (***) [46] Jason Xing
>    4 ( +8) [160] Jiri Pirko             4 (***) [43] Yang Xiwen via B4 Re=
lay
>    5 ( +2) [152] Paolo Abeni            5 (***) [42] Matthieu Baerts
>    6 ( +2) [ 78] Krzysztof Kozlowski    6 ( -2) [40] Tony Nguyen
>    7 ( +2) [ 76] David Ahern            7 ( -6) [38] David Howells
>    8 ( +2) [ 68] Willem de Bruijn       8 ( -6) [37] Christian Marangi
>    9 ( +2) [ 60] Florian Fainelli       9 (+30) [37] Kory Maincent
>   10 ( -5) [ 54] Russell King          10 (***) [36] Breno Leitao
>
> Corporate stats
> ---------------
>
> Top reviewers (cs):                  Top reviewers (msg):
>    1 (   ) [42] RedHat                  1 (   ) [98] RedHat
>    2 (   ) [32] Meta                    2 (   ) [74] Meta
>    3 ( +2) [16] Google                  3 (   ) [44] Andrew Lunn
>    4 (   ) [14] Andrew Lunn             4 ( +1) [43] Google
>    5 ( -2) [13] Intel                   5 ( -1) [36] Intel
>    6 ( +1) [13] nVidia                  6 ( +2) [31] Linaro
>    7 ( +1) [ 8] Linaro                  7 (   ) [31] nVidia
>
> Top authors (cs):                    Top authors (msg):
>    1 ( +1) [12] RedHat                  1 (   ) [69] Intel
>    2 ( +2) [12] Meta                    2 ( +2) [60] Meta
>    3 ( -2) [10] Intel                   3 ( +2) [55] Google
>    4 ( -1) [10] Google                  4 ( -1) [50] nVidia
>    5 (   ) [ 7] nVidia                  5 ( -3) [47] RedHat
>    6 ( +2) [ 3] Huawei                  6 ( +4) [32] Bootlin
>    7 ( +7) [ 3] Wirecard                7 ( -1) [23] Alibaba
>
> Top scores (positive):               Top scores (negative):
>    1 (   ) [496] RedHat                 1 ( +7) [89] Bootlin
>    2 (   ) [303] Meta                   2 (   ) [79] Alibaba
>    3 (   ) [243] Andrew Lunn            3 (***) [46] Tencent
>    4 ( +2) [138] Linaro                 4 (***) [43] Yang Xiwen
>    5 (   ) [ 79] Google                 5 (***) [42] Tessares
>    6 ( +2) [ 76] Enfabrica              6 ( +6) [38] AMD
>    7 ( -3) [ 60] Oracle                 7 ( -6) [37] Christian Marangi
>
> RedHat remains unbeatable with the combined powers of Simon and Paolo,
> as well as high participation of the less active authors.
> Alibaba maintains its strongly net-negative review score.
> Tencent (Jason Xing) joins them (Tencent doesn't use their email
> domain so it's likely under-counted). Yang Xiwen makes the negative

Interesting numbers.

Well, actually, I always send patches by using the company address and
review patches by using my personal address, which probably makes my
scores negative :S

Next time I'll try to use the same address. Hope I will not appear on
the top of the negative scores list.

> list as well, cost of reposting large series too often...
> --
> Code: https://github.com/kuba-moo/ml-stat
> Raw output: https://netdev.bots.linux.dev/static/nipa/stats-6.9/stdout
>


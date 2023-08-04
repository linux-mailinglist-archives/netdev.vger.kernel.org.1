Return-Path: <netdev+bounces-24483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BA1770514
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E782827A7
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780771804B;
	Fri,  4 Aug 2023 15:45:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D120134B3
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:45:57 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31241734;
	Fri,  4 Aug 2023 08:45:55 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1qRwzw-0003nI-H1; Fri, 04 Aug 2023 17:45:52 +0200
Message-ID: <3a3a53ec-81c0-c5f7-3c37-2c07212a6330@leemhuis.info>
Date: Fri, 4 Aug 2023 17:45:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18
 (regression)
Content-Language: en-US, de-DE
To: Robert Hancock <robert.hancock@calian.com>
Cc: regressions@lists.linux.dev, netdev@vger.kernel.org,
 Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691163955;39030b40;
X-HE-SMSGID: 1qRwzw-0003nI-H1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[adding Robert Hancock (the author of the likely culprit) to the list of
recipients as well as the network maintainers]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 04.08.23 17:26, Nick Bowler wrote:
> Hi,
> 
> With recent kernels (5.18 and newer) the ethernet is all wonky on my
> ZCU104 board.
> 
> There is some behaviour inconsistency between kernel versions identified
> during bisection, so maybe there is more than one issue with the ethernet?
> 
>   6.5-rc4: after 10 seconds, the following message is printed:
> 
>     [   10.761808] platform ff0e0000.ethernet: deferred probe pending
> 
>   but the network device seemingly never appears (I waited about a minute).
> 
>   6.1 and 6.4: after 10 seconds, the device suddenly appears and starts
>   working (but this is way too late).
> 
>   5.18: the device never appears and no unusual messages are printed
>   (I waited ten minutes).
> 
> With 5.17 and earlier versions, the eth0 device appears without any delay.
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
> 
> Unfortunately, it seems this is not sufficient to correct the problem on
> 6.5-rc4 -- there is no apparent change in behaviour, so maybe there is
> a new, different problem?
> 
> I guess I can kick off another bisection to find out when this revert
> stops fixing things...
> 
> Let me know if you need any more info!

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced e461bd6f43f4e5
#regzbot title net/arm64: dts: Broken or delayed ethernet on Xilinx ZCU104
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


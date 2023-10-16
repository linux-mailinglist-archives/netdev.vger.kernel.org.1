Return-Path: <netdev+bounces-41332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6839C7CA93F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989A41C20925
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF49127ED8;
	Mon, 16 Oct 2023 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fo5wLOpf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA0C27EC6
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 13:19:36 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFE39B
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:19:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e16f076b3so8177109a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 06:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697462373; x=1698067173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ofsX2ld2Y35hldDs43R40eV9lYWcpyBA4x3tj2sdNUM=;
        b=Fo5wLOpfEpziYpTAd/VKyBQPkgXnEhmQ9X2NW8SbRkjzaowKOINivrVjt0DPqpk8uh
         Nn0XlCzQeh5p1pL0HjbU9n3CfJI86eK8jE+TX7SAdY8sHc5X2MFL+tDU8wD16c4CTIng
         aba+Pfs7wpfnpSVyqWH5bUXu7iLb/jrmc/BAwnu1GBecQe2hvtB6GsjrMiN54aXMxe4o
         766zlzB+zSgux+p950OFktfPuvIoS7R8+j1jJA6B/qlxkL/Omecumjv3nj+Yvd8eRWbc
         T4HbblWAk9h9LtOMUByQWxbJVL/SGmNcmXZCfNTuYak6VZ1S0BwGQjFo1FZ7DLBWzcSu
         j/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697462373; x=1698067173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ofsX2ld2Y35hldDs43R40eV9lYWcpyBA4x3tj2sdNUM=;
        b=nuV3W1E2PF3JnEHTzWoKOv/4LNdEfnUGa7WbNgSJifa01kVxIhp4p4eHMNBATWbhM2
         WWu7xPwaZF2TAFhPfV9BNJrIQF7Xq3lCazNWAbgEHibOWKBEVSeADxjDMQAXmJPOBvRS
         Ov+BFBxfMP+UOerfvFU96pm37yk5N2VoZH7BPBgOwVjE3Df1/bk7fLvWE0mo6g2Or1hl
         DKGWZ438CueGTbwn6bgUGe2p0Slul+7tjR9UhrRmHszWCmhO5ba+GPk6kCE6uh4Mqm1g
         ju/5vv4xwslfQ/avLdrIBn0Gpa6We8/2lIO3uzGZjOUPxxB9SV6C6e9BbKNU0331DX4K
         d7AA==
X-Gm-Message-State: AOJu0Yx7EYvdMAjEkzFG1umWrY8LWQdBZhyWiqrq7tZofStiCPxFQ7IF
	r9KUe12x1+xnRtgAl/lPwTULsIy7rtOFv3avjbMhSg==
X-Google-Smtp-Source: AGHT+IFuH/XgysB7Sxky39MfcG4hkkSZ6xm21/9jC7buhA0x7DsWtKnFalffqQ9KEVpl9pkg+JUIfKq8xTStyGVkKkM=
X-Received: by 2002:a17:907:5ca:b0:9ae:6648:9b53 with SMTP id
 wg10-20020a17090705ca00b009ae66489b53mr6876194ejb.23.1697462373491; Mon, 16
 Oct 2023 06:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <267abf02-4b60-4a2e-92cd-709e3da6f7d3@gmail.com>
 <CAMZdPi9RDSAsA8bCwN1f-4v3Ahqh8+eFLTArdyE5qZeocAMhtQ@mail.gmail.com> <ZSiJdxjokD0P9wRc@debian.me>
In-Reply-To: <ZSiJdxjokD0P9wRc@debian.me>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Mon, 16 Oct 2023 15:18:56 +0200
Message-ID: <CAMZdPi8qmc4aKPsm3J60Fb+wa0ixVCV+KK11TDsvqFJk81Gfrw@mail.gmail.com>
Subject: Re: Intel 7560 LTE Modem stops working after resuming from standby
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: M Chetan Kumar <m.chetan.kumar@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, Linux Networking <netdev@vger.kernel.org>, 
	Linux Intel Wireless WAN <linuxwwan@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Bagas,

On Fri, 13 Oct 2023 at 02:04, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Thu, Oct 12, 2023 at 06:54:11PM +0200, Loic Poulain wrote:
> > Hi Chetan,
> >
> > On Thu, 12 Oct 2023 at 11:52, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > > I notice a regression report on Bugzilla [1]. Quoting from it:
> > >
> > > > I noticed a few days ago, after Fedora moved to Kernel 6.5, that my Intel LTE Modem was not working anymore after resuming from standby.
> > > >
> > > > The journal listed this error message multiple times:
> > > > kernel: iosm 0000:01:00.0: msg timeout
> > > >
> > > > It took me a while to determine the root cause of the problem, since the modem did not work either in the following warm reboots.
> > > > Only a shutdown revived the modem.
> > > >
> > > > I did a bisection of the error and I was able to find the culprit:
> > > >
> > > > [e4f5073d53be6cec0c654fac98372047efb66947] net: wwan: iosm: enable runtime pm support for 7560
> >
> > Any quick fix for this issue? alternatively we will probably revert e4f5073d53.
>
> Chetan can't be contacted as sending to his address bounces (error 550)
> (had he left Intel?). Last message on LKML is this culprit patch [1].
> Hence, revert for now.

Could you please submit the revert fix?

Regards,
Loic


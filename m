Return-Path: <netdev+bounces-31729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC7578FCAF
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 13:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DC8281A19
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 11:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966A1BA4B;
	Fri,  1 Sep 2023 11:53:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3042572
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 11:53:38 +0000 (UTC)
Received: from nbd.name (nbd.name [46.4.11.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3455591
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 04:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l+CicTddsXcglclry0G7IFJYJAq+L6P+FuEUiadAHPo=; b=kb1VtxpyJiAtfBYOOmVXHCSFNj
	fkwKjqH0K2fpNtHv7AU0C9O9tlpdipk1DYk5t+yvY80h1ukuGY8j6jr+8e2Y+mELee2eVQ+0o3rtF
	c0Ogm+rvovOKSdrW6bANDluRPSTBfPIxnnAOwSiUy7He1z2WWNdnD6/l/pPe2qQ1+3mQ=;
Received: from p4ff13705.dip0.t-ipconnect.de ([79.241.55.5] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1qc2iK-00EyVX-Br; Fri, 01 Sep 2023 13:53:24 +0200
Message-ID: <44ebe3fd-5898-4e48-a642-ee7457c0c032@nbd.name>
Date: Fri, 1 Sep 2023 13:53:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: Use hrtimer for TX coalescing
Content-Language: en-US
To: Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
 "joabreu@synopsys.com" <joabreu@synopsys.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
 "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 kernel <kernel@axis.com>
References: <20201120150208.6838-1-vincent.whitchurch@axis.com>
 <732f3c01-a36f-4c9b-8273-a55aba9094d8@nbd.name>
 <2e1db3c654b4e76c7249e90ecf8fa9d64046cbb8.camel@axis.com>
 <a4ee2e37-6b2f-4cab-aab8-b9c46a7c1334@nbd.name>
 <f3c70b8e345a174817e6a7f38725d958f8193bf1.camel@axis.com>
 <8a2d04f5-7cd8-4b49-b538-c85e3c1caec9@nbd.name>
 <a583c9fae69a4b2db8ddd70ed2c086c11456871a.camel@axis.com>
From: Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <a583c9fae69a4b2db8ddd70ed2c086c11456871a.camel@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 01.09.23 13:31, Vincent Whitchurch wrote:
> On Wed, 2023-08-30 at 23:06 +0200, Felix Fietkau wrote:
>> On 30.08.23 16:55, Vincent Whitchurch wrote:
>> > I looked at it some more and the continuous postponing behaviour strikes
>> > me as quite odd.  For example, if you set tx-frames coalescing to 0 then
>> > cleanups could happen much later than the specified tx-usecs period, in
>> > the absence of RX traffic.  Also, if we'd have to have a shared
>> > timestamp between the callers of stmmac_tx_timer_arm() and the hrtimer
>> > to preserve this continuous postponing behaviour, then we'd need to
>> > introduce some locking between the timer expiry and those functions, to
>> > avoid race conditions.
>> 
>> I just spent some time digging through the history of the timer code, 
>> figuring out the intention behind the continuous postponing behavior.
>> 
>> It's an interrupt mitigation scheme where DMA descriptors are configured 
>> to only generate a completion event every 25 packets, and the only 
>> purpose of the timer is to avoid keeping packets in the queue for too 
>> long after tx activity has stopped.
>> Based on that design, I believe that the continuous postponing actually 
>> makes sense and the patches that eliminate it are misguided. When there 
>> is constant activity, there will be tx completion interrupts that 
>> trigger cleanup.
> 
> The tx-frames value (25) can be controlled from user space.  If it is
> set to zero then the driver should still coalesce interrupts based on
> the interval specified in the tx-usecs setting, but the driver fails to
> do so because it keeps postponing the cleanup and increasing the latency
> of the cleanups far beyond the programmed period.
> 
>> That said, I did even more digging and I found out that the timer code 
>> was added at a time when the driver didn't even disable tx and rx 
>> interrupts individually, which means that it could not take advantage of 
>> interrupt mitigation via NAPI scheduling + IRQ disable/enable.
>> 
>> I have a hunch that given the changes made to the driver over time, the 
>> timer based interrupt mitigation strategy might just be completely 
>> useless and actively harmful now. It certainly messes with things like 
>> TSQ and BQL in a nasty way.
>> 
>> I suspect that the best and easiest way to deal with this issue is to 
>> simply rip out all that timer nonsense, rely on tx IRQs entirely and 
>> just let NAPI do its thing.
> 
> If you want an interrupt for every packet, you can turn off coalescing
> by setting tx-frames to 1 and tx-usecs 0.  Currently, the driver does
> not turn off the timer even if tx-usecs is set to zero, but that is
> trivially fixed.  With such a fix and that setting, the result is a 30x
> increase in the number of interrupts in a tx-only test.
> 
> And tx-frames 25 tx-usecs 0 is of course also bad for throughput since
> cleanups will not happen when fewer than 25 frames are transmitted.
If the CPU is not saturated, the increase in interrupts is expected, 
given that NAPI doesn't do any timer based mitigation.

I guess for devices operating on battery, the timer based coalescing 
might conserve some power, unless the power drain caused by the CPU 
overhead of the timer rescheduling is bigger than the power drain from 
extra wakeups.

For a devices where performance matters more (e.g. the ones used with 
OpenWrt), I believe that the increase in the number of IRQs won't 
matter, because mitigation should kick in under load.

Could you please post your fix? I think in order to avoid accidental 
breakage, we should make tx-usecs=0 imply tx-frames=1.

Thanks,

- Felix


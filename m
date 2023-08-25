Return-Path: <netdev+bounces-30750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7035F788DDE
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 19:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27791C20F0B
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEE518033;
	Fri, 25 Aug 2023 17:38:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1AB11720
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 17:38:34 +0000 (UTC)
Received: from nbd.name (nbd.name [46.4.11.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE3A2127
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SE41FhtO0HqL1h4OkVbcGXUmViDcQMDrybnQEXfR0rs=; b=dTIxGI2E8uTCtlWcsWzuTAKHrQ
	aRmpp1YUu+ubFrNS+zSQPCaZgUvBswmY0vgNmjs8fKrZLkq3NlHf6uuIjC5YUasONpmkSg1605A0v
	kowJGBSz7hkfsFOfjU9F8rmChXsd0qkynlbAXeniTQmNjoByxjpgtamJMW4Agvq1wp9Q=;
Received: from p4ff13705.dip0.t-ipconnect.de ([79.241.55.5] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1qZalH-00D4CK-3l; Fri, 25 Aug 2023 19:38:19 +0200
Message-ID: <a4ee2e37-6b2f-4cab-aab8-b9c46a7c1334@nbd.name>
Date: Fri, 25 Aug 2023 19:38:18 +0200
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
 "kuba@kernel.org" <kuba@kernel.org>,
 "joabreu@synopsys.com" <joabreu@synopsys.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
 "alexandre.torgue@st.com" <alexandre.torgue@st.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 kernel <kernel@axis.com>
References: <20201120150208.6838-1-vincent.whitchurch@axis.com>
 <732f3c01-a36f-4c9b-8273-a55aba9094d8@nbd.name>
 <2e1db3c654b4e76c7249e90ecf8fa9d64046cbb8.camel@axis.com>
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
In-Reply-To: <2e1db3c654b4e76c7249e90ecf8fa9d64046cbb8.camel@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 25.08.23 15:42, Vincent Whitchurch wrote:
> On Wed, 2023-08-23 at 22:18 +0200, Felix Fietkau wrote:
>> Based on tests by OpenWrt users, it seems that this one is causing a 
>> significant performance regression caused by wasting lots of CPU cycles 
>> re-arming the hrtimer on every single packet. More info:
>> https://github.com/openwrt/openwrt/issues/11676#issuecomment-1690492666
> 
> It looks like there was an attempt to avoid the re-arming of the timer
> in ->xmit() a while ago (pre-dating the hrtimer usage) in commit
> 4ae0169fd1b3c792b66be58995b7e6b629919ecf ("net: stmmac: Do not keep
> rearming the coalesce timer in stmmac_xmit"), but that got reverted
> later due to regressions.  The coalescing code has been reworked since
> then but the removal of the re-arming was never attempted again.
> 
>> My suggestion for fixing this properly would be:
>> - keep a separate timestamp for last tx packet
>> - do not modify the timer if it's scheduled already
>> - in the timer function, check the last tx timestamp and re-arm the 
>> timer if necessary.
> 
> Would you mind explain the reasons for maintaining a timestamp and
> checking it in the expiry function?  Is that to obtain the same effect
> as the driver's current behaviour of postponing the expiry of the timer
> for each packet? 

Exactly. I did something very similar in mac80211 in the past, when 
expensive mod_timer calls were showing up in my perf measurements.
Functionally it should be the same, it just avoids excessive re-sorting 
in timer data structures.

> Is that really desired?  According to the commit
> message in 4ae0169fd1b3c792b66be58995b7e6b629919ecf, "Once the timer is
> armed it should run after the time expires for the first packet sent and
> not the last one."
> 
> Since the timer expiry function schedules napi, and the napi poll
> function stmmac_tx_clean() re-arms the timer if it sees that there are
> pending tx packets, shouldn't an implementation similar to hip04_eth.c
> (which doesn't save/check the last tx timestamp) be sufficient?

To be honest, I didn't look very closely at what the timer does and how 
coalescing works. I don't know if delaying the timer processing with 
every tx is the right choice, or if it should be armed only once. 
However, as you pointed out, the commit that dropped the re-arming was 
reverted because of regressions.

My suggestions are intended to preserve the existing behavior as much as 
possible (in order to avoid regressions), while also achieving the 
benefit of significantly reducing CPU cycles wasted by re-arming the timer.

- Felix


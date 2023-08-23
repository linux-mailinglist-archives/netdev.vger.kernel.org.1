Return-Path: <netdev+bounces-30127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF6578614A
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 22:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A40628137D
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 20:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806D11FB59;
	Wed, 23 Aug 2023 20:18:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F362C2E6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 20:18:55 +0000 (UTC)
Received: from nbd.name (nbd.name [46.4.11.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BCE10D3
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 13:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9y1c2QB/wPmOKO8c1J8GFP8cWm6qJVYXSVOUxWf0OB4=; b=h4D6xbdM7cRGwJDKHd9L7LYH57
	o2bmxI19u6LHrh/BwLEaTZZtv4ZRQwAyUeYLT1jhlEmGtsbhSmMpkm+7tNNgZyO6X6P3dJzD1Cnnw
	b3rQW/lgwL5zF5p9lyb2XHPUVWmUb9ySPq23LiDEcsfhf0Gh6nVDLQow7WmswUR6g3gg=;
Received: from p4ff13705.dip0.t-ipconnect.de ([79.241.55.5] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1qYuJG-00CX7D-DA; Wed, 23 Aug 2023 22:18:34 +0200
Message-ID: <732f3c01-a36f-4c9b-8273-a55aba9094d8@nbd.name>
Date: Wed, 23 Aug 2023 22:18:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: Use hrtimer for TX coalescing
Content-Language: en-US
To: Vincent Whitchurch <vincent.whitchurch@axis.com>, peppe.cavallaro@st.com,
 alexandre.torgue@st.com, joabreu@synopsys.com, davem@davemloft.net,
 kuba@kernel.org
Cc: kernel@axis.com, netdev@vger.kernel.org
References: <20201120150208.6838-1-vincent.whitchurch@axis.com>
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
In-Reply-To: <20201120150208.6838-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20.11.20 16:02, Vincent Whitchurch wrote:
> This driver uses a normal timer for TX coalescing, which means that the
> with the default tx-usecs of 1000 microseconds the cleanups actually
> happen 10 ms or more later with HZ=100.  This leads to very low
> througput with TCP when bridged to a slow link such as a 4G modem.  Fix
> this by using an hrtimer instead.
> 
> On my ARM platform with HZ=100 and the default TX coalescing settings
> (tx-frames 25 tx-usecs 1000), with "tc qdisc add dev eth0 root netem
> delay 60ms 40ms rate 50Mbit" run on the server, netperf's TCP_STREAM
> improves from ~5.5 Mbps to ~100 Mbps.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Based on tests by OpenWrt users, it seems that this one is causing a 
significant performance regression caused by wasting lots of CPU cycles 
re-arming the hrtimer on every single packet. More info:
https://github.com/openwrt/openwrt/issues/11676#issuecomment-1690492666

My suggestion for fixing this properly would be:
- keep a separate timestamp for last tx packet
- do not modify the timer if it's scheduled already
- in the timer function, check the last tx timestamp and re-arm the 
timer if necessary.

This should significantly reduce the number of wasted CPU cycles, even 
when accounting for the additional overhead of hrtimer vs regular timer.

- Felix


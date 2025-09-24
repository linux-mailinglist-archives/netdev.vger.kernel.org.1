Return-Path: <netdev+bounces-226019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2CFB9AE09
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 18:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2651709C1
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 16:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E712330C622;
	Wed, 24 Sep 2025 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nxUPglwS"
X-Original-To: netdev@vger.kernel.org
Received: from sonic314-20.consmr.mail.ne1.yahoo.com (sonic314-20.consmr.mail.ne1.yahoo.com [66.163.189.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F9718C034
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758731284; cv=none; b=HLP1xMbXpGMN3PPNE+3sDRasjoMnX6/AfChT9t1JBrvDyOKuWftlg1FVihWTrtjTCsNf8uGCnQGi+bz7QiGWXenTLO3vKhFlompWuCKlM3WVbYH1SIT1IWQEXVsFXHvH4VTcz7Ck4kJjoOKnOPwzWyIOf7GIMeteeiNczoPYqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758731284; c=relaxed/simple;
	bh=XZtKio9Cb4GVPCg7WbHGNN1FzcEhyERcmH5B00Si3/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECaX6wE37VAp/D/6tOBGRIqb3u4Ez4wXez18wK+UE1RpivsNnt/j/qS4kmS4isSwhGYJF2KdpOZRwdrCPcEvkG8sC5TvWiQoamBjAuhli15D5UV1aZr3ZVCEwc+hJgXx9eOafijZrdvpvyIaNIlQNuUOqDEpkxpSiFpHTyHPsNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=nxUPglwS; arc=none smtp.client-ip=66.163.189.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758731276; bh=rhrY+0rc5RGy49wVuDazTYpMf9P73mg2TQhHdzhAwdw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=nxUPglwSRz2jeLY1STKMyZc3q4f5hhKd+a2QYJPD7G0fTVy9kQJ70wdSjRv5uz5nNppCwGg+dWtE0YiPJmThxwZi4qn4Kg6J9vgaSKbVTACo+inG/3zZNppOpVIdDJsFi1+4mBs6YeDUtaEQzfpUdIzgQfK2VIJYWYsUqffARuFmUYrZ70wv0mVVHH5Q7sSmf8Y0o6vnARafaZB7gU4nsGnw+ajdSAY3uVUPsrJYpVjH1TClzdMHBX/e1YRLiDeBCMOzJdLxgvfRKZHXUJbiszVwTEyNeDd4s8v74HM1BfuBHiYYJofpWC3r5lDrzC3zo0nwU6iP6C0B6poevdGA8Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1758731276; bh=86Oa65abceXpjfgS3uiarFsjuigj/9zbuMPPW9kJSiB=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=eNn3bcLx+bXZ75RBesB7yXrBBG6GSp87kjo3j+beNJ9iSpjAbjK2wfStVBRrx3ownXeakHgYyZkGQFqmJOg/e9aFsQjPyLu8OI6ux+StxDVlv2a2yISwih0i1ccd/uRzadcgE3PovMLmCn79DDkFGMimEQ+ZS4ZOl1JbeXY2AWjQRsRsOATZSk7QZIYa8dx0YnJBYxr7ddyOYjPNRyKXn452UDjNykCm7haEmrQuMfXnQ0BmAacS5BhjzsAFJ/9m4lTqugmbTLqoP1NQDhyAkA7i+TCCyNKfB44TQ2duWsMwhN4jJ5qUqcX7i/xN/sR3k3A7N8s0qCPbJXUhwneQ0A==
X-YMail-OSG: S_.apQgVM1mShf6LlHKsUsfImGtniVkSz8jRrEMZSqrUiYR31gWUmhYMJFjlT1o
 8On5g.BDtmdsBPSbVpBhCP_HwygrvUA81xty7XDWUtT4IqNRYXPYLlyEe6JmvY.iIseo5vssNrQ5
 M5MMhjYBMygMpB9e3SxctduyoNQaeqR8V8yLqcMSaOiL_fac7RfMQ6BjytGTsJcZDsQ1Era.pcFQ
 hicBiMm9un07861kjT7EzNDtieVsb_GyP4P80Aphhwm6qis30vOw0reGxXXijO0inQUalMvSEbyi
 3DgNcQh5tvjRzRNErAoee3J7D_N37kFDpWG0DPzN3bkrYC0BJt3PJ69BgETuDNUU06GgD1c4xHhU
 fWnijyGaImR4bRxk0F7irCrrVz9Ja8v8dMzSnF.foKXKVH2htLRZbR3uTwB1Zu3rzrUdGJ4T4Ffg
 KSxq8QeMG.NoCCcOya5b8Arxn9aoFq.KopHZlLqzZ9AbESHmauPuG4l3JOIHt462ezDWI6ArLTtW
 aS9A1mMMf61R89LTWvirbd22y_ZCX0k3UXJ9vReKQboPw2X5HKa1XAZwbyTfE4nIvSNrW50jZzvv
 LYukxqiHqGLlq7vBmcHnkOSLT2dAes_ve1wDOzRzrU1Psu3.vb3FP382O.jOhuSqKBrESzwU01ZG
 XW4dHJVTChDWtx02wL2Bydwz7.coysAI9qW6MmQdnvoWDEO_ACp7f0QnU.9mxoR7ynNrOMw_WaGh
 Hy6Fb5ZEw7A3LOip18f0nDvazr6oUPDEZCUznkf_Vx9t74Fx9Bplq1lGpsMvXVZdzg.10E.goSQe
 qewZBlyCst1nOkY5urCOk9zMrcSd8jHLGWe7bZoM64q9X2ZVQ1sutu_o4Fvcrv9GQMfuNEMtHoFt
 ouUznmxtPts331VfOeyBlVNDBUOBV_VPWdMNJb8PlWJlehIohaGvEnE5OMz4gg_3j.9GDrOQxqPg
 SQOsA.uOlowi.xFvE56sTb4IRSU9eXpPVLUqIQ.oTX8DWJY0Zh_fByBGqvDB.OMpa18URpgnT5v5
 7POeIqeoWsLUeRlK26jMOvalfyDLiTdiQmfIYjSLMG9TvT8mXXTwSN4KSXE5sAXqpWxOatL_8XVQ
 h0OGrX30rj3DPBMiRyJ6WRZfLhvlLzYApKAbrtnxfSf2JayxjgUo4Bo3NM9ibJHWh7N4ipbF5UwG
 2K9SN_Qu1vHDOGOoa2Mi9bn9qHM3jYm1UmU_Wc3mO7eAzWFgDbqntMSQ_V_nRii9jh3u428uVHZH
 aE6NOjlfjPoTm8dffEOwe_17gVFiVf3n2bpN_SO7ULCOH0GNgr99IxOuqh8bQw_nDPh5YiH5eckr
 IHmDHukfoOXHQZixAa7EDIa4fKzbja97YxBfe3sr6SdoiCT7v2r1fAuzkUFTmL7p1r2AzblIc633
 pVfBkN35fmjvIbbxN6GdDAao6lNNym9RQQ4iMWHXO_CbF7B_Z3ON0hnautFgL4O06X9yNOLY2DMM
 vIbPUl7bVvvE_AK2EPdtXsxVfIZzePlR56tYkAGxu0Yt53iHBO5dYPiRezFXkf9xyQLw81sUjIx2
 HMdAxCkra2BSIX5xK6J_E1kxPOlDeyVszuZOCr46bRn.eMsXItu2ui406_wUD7TrUosvWU79htPh
 OxypD8LdeuyaqT6ylzRiR7Up3l.ibC9d053GrXKphh1f2nOs1lw7qqS7LXkEhWsi_IcKeYpURBgA
 GthxLlU.WhcbUf858zziHcAlO1zKek6Ps7yK2FpeWt0n1BrKZS40AgUtdHOsJeo2nEk.yS585Dk_
 LTuzZExzE70nNV17GzLt6Q1hMZtZxZbyDmbz1ZXTI0LHS72dcuYEBlo3hXRCBsPRXnYKXco8q7.b
 fS0TI3a0vuhCwgRhFGFy.Mp9vgo7o1faqewban9fV1Ew1jdNGH288EZhw7N9A32L_6GO_nOw4axP
 kImc2W6aW3XkGdDVroqT92jbAkYce24n1GfgUUfcMja4dPPBYVtr3uONz6DDCq.Z7IAGJs3eADhY
 1H0GJGKmbZV7bq6uxxBHAqG0mIcHE8JNYij2RjWKspudbzDEUN4U4emRDxpLvN1YOHDQsoFKztMq
 9lqf2gsZoBBmwppl2SXcpNAlZD1DoYKqTopeCOW_KOpYHht3yUD_6jINvWuUA_GK1WYOIubO1dKH
 yXjrlsu7aV16P2ojA4aaHOwPAlBuMYDzC6.a_bLw-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 0f5db19c-0c5a-42b6-b06f-38acfec9d6a1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Sep 2025 16:27:56 +0000
Received: by hermes--production-ir2-74585cff4f-nk58f (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ff2816ec2364a67e46f15858e361aed4;
          Wed, 24 Sep 2025 16:27:54 +0000 (UTC)
Message-ID: <3f9e0aa5-1628-4ad7-8078-86a55b09b216@yahoo.com>
Date: Wed, 24 Sep 2025 18:27:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/3] net: tunnel: introduce noref xmit flows
 for tunnels
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, sd@queasysnail.net, antonio@openvpn.net,
 openvpn-devel@lists.sourceforge.net
References: <20250922110622.10368-1-mmietus97.ref@yahoo.com>
 <20250922110622.10368-1-mmietus97@yahoo.com>
 <20250923184856.6cce6530@kernel.org>
Content-Language: en-US
From: Marek Mietus <mmietus97@yahoo.com>
In-Reply-To: <20250923184856.6cce6530@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24485 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

W dniu 9/24/25 o 03:48, Jakub Kicinski pisze:
> On Mon, 22 Sep 2025 13:06:19 +0200 Marek Mietus wrote:
>> This patchset introduces new noref xmit helpers and incorporates
>> them in the OpenVPN driver. A similar improvement can also be
>> applied to other tunnel code in the future. The implementation
>> for OpenVPN is a good starting point as it doesn't use the
>> udp_tunnel_dst_lookup helper which adds some complexity.
> 
> You're basically refactoring an API, it's fairly unusual to leave both
> APIs in place upstream. Unless the number of callers is really huge,
> say >100, or complexity very high. Not sure how others feel but IMHO
> you should try to convert all the tunnels.
> 

I'm introducing an opt-in API, which is useful in some cases, but not
always as it optimizes flows that follow a specific pattern.

Since this API is opt-in, there is no need to over-complicate code
to integrate the new API. The current API is still retained and is not 
made redundant by the new API. Some tunnels may benefit from the new
API with only minor complications, and should be modified in separate
patchsets after this one.

>> There are already noref optimizations in both ipv4 and ip6 
>> (See __ip_queue_xmit, inet6_csk_xmit). This patchset allows for
>> similar optimizations in udp tunnels. Referencing the dst_entry
>> is now redundant, as the entire flow is protected under RCU, so
>> it is removed.
>>
>> With this patchset, I was able to observe a 4% decrease in the total
>> time for ovpn_udp_send_skb using perf.
> 
> Please provide more meaningful perf wins. Relative change of perf in
> one function doesn't tell use.. well.. anything.
>

Okay. Currently, I'm getting a consistent 2% increase in throughput on a VM,
using iperf. Is this what I should mention in the next cover-letter?
 
> Please do not remove the diff stat generated by git in the cover
> letter.
> 
> 

I'll make sure to include it in the next revision.



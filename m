Return-Path: <netdev+bounces-64964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD773838864
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 08:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72E81C2302B
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 07:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6B455C2B;
	Tue, 23 Jan 2024 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bernat.ch header.i=@bernat.ch header.b="sHjAzbm4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gKnF15S8"
X-Original-To: netdev@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3DE6121
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996700; cv=none; b=u5aIPZyQLE/Ksa1kVbYgnraMOqK9dMdxTg9qZ1EXRPHIDHFVBuOd/lze4NwmxM7hE3O2+8aTEvhOOdyfFi6g/zMuFZhyMcHaM/Cutmk9UeocdJxiLy608IxMrs7MenvIItUo1ZkYsrDMR5azQSgE3Xsrpz6hjMTFyxXbupkRoxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996700; c=relaxed/simple;
	bh=WMHnQvtGkpocLy/mNTm53nOmmYl5elVp80ZIIfJnaD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNp+59wtpqn1jAWOV44GrGYdqORMxtpV+pcnIAZ/ygalu1aqZn6J7DMAsnkrSSDIkKH6FPgWNOzOiSpeSEB2wxH3aUe7zS1m6R3GrsJSEsociA8kwwGRxEwRIyTa8iTgTNieudrdpp17l1JEap47IOQALc2DX9nS2cQkTJ0VD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bernat.ch; spf=pass smtp.mailfrom=bernat.ch; dkim=pass (2048-bit key) header.d=bernat.ch header.i=@bernat.ch header.b=sHjAzbm4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gKnF15S8; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bernat.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bernat.ch
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 96E2B5C0269;
	Tue, 23 Jan 2024 02:58:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 23 Jan 2024 02:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernat.ch; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1705996697;
	 x=1706083097; bh=8cK9/ZitGgBPxRAx5yYfSUqyjk/scaBlQzG72ZTju6Y=; b=
	sHjAzbm4j/e3KFAapD0X+d7BvkRdlY1SAhX1xy4nXp0hjux6cy5QHOw8zlJisZ6W
	RLO2BKTX2bmFUMmS1sjkgcvv/HamLyZDJZTOHdbr3hegKWVdinBGeCPKpBBa/Dqi
	qbKEhkg9b16o8xTFZN5TnLUgpbVwDvUiGVqXZ5uEq/9BzawjPUdfHeXj2fhstkFe
	gi8cqWefrxdkBCyE/yK/6wQ9U0r5ybJIzEJGyPmnpaCrfA8HCYMNYtfxkJJ2iyYE
	F+lJr99jtACvauicNc23XOqJsxymewt4OZLTBRUk4kJChSD160W4TVywYKdhcfSh
	vRLPEfWfCot7Vgbfm3jtkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705996697; x=
	1706083097; bh=8cK9/ZitGgBPxRAx5yYfSUqyjk/scaBlQzG72ZTju6Y=; b=g
	KnF15S8DZaYnHkB4NtSd6o8Iaiy2wLfX+9w1oiSiuhCrWZVe43c0yZKU9M0qzd6O
	5naOGmezwyw4uWPiT8DtFuWiqQrsgW5T34LM/yIYWhW1EwMdcB2W8OH8nExtpXDB
	00u6haYa0rsLoiNGqB3I3ajiswKaF/ZF4a2GLpFleISWh8kMibgqRXCSakFAAG5w
	denghMbOtev/7cvyp4NELgAl3ygft5bYEVLiCxnhbeoPfqgwgXteUsCrmP3b5i4D
	Rm+2/h65A+0CWJzSLBmRb1Uk0WmxAaxnZPJpSEq+s3ueMSI/IWViJavvcxBK97LJ
	eKZ3fSDC4PBnD547ut/mQ==
X-ME-Sender: <xms:mXGvZWwN6zv2V3nVXpqZkgZeNz8yucxTvl6CBBeYMVbDGBL1IONgwQ>
    <xme:mXGvZSTbqQBpadq5VbxnndXAJ1gLISFSMfMd3-qC5Z39qR_GTMQxHkMF5JJjr9D1f
    3R-oxbA9tylEZPisFc>
X-ME-Received: <xmr:mXGvZYX-xBcp7rR7DbmzGRvJjwgaJa69f1mI_2mqqGe0QzZ4tmf0rjn1ISsF-fmRbPcQPqY3KAnu5ODic2tGxxLsi-UA4CJIA1AdvsbX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepgghi
    nhgtvghnthcuuegvrhhnrghtuceovhhinhgtvghnthessggvrhhnrghtrdgthheqnecugg
    ftrfgrthhtvghrnhepheevkeeutdeiledtffeludehteegudffjefftdelffettdfgkeeu
    leffgfdukefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepvhhinhgtvghnthessggvrhhnrghtrdgthh
X-ME-Proxy: <xmx:mXGvZchIC1l886_ffzyZGBjqNtacZfPbYg9e0hAzRAoRGJbxQuYt_w>
    <xmx:mXGvZYBx1dHqbcSd3O8_RUrHRGHov6B9ZG6HEQO3yma4SgkQli7oSg>
    <xmx:mXGvZdLvwD66gQOKrp5CVgkVtOjf1DeuYV9MLkdABjigJpIUxvANVQ>
    <xmx:mXGvZbO91OiTVlJJOuN5xxG4jh_NLVJXqqzQsy8twriBlN1oOJeHoA>
Feedback-ID: id69944f0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 02:58:16 -0500 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by neo.luffy.cx (Postfix) with ESMTP id 2EEB51D8;
	Tue, 23 Jan 2024 08:58:15 +0100 (CET)
Message-ID: <1793b6c1-9dba-4794-ae0d-5eda4f6db663@bernat.ch>
Date: Tue, 23 Jan 2024 08:58:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] vxlan: add support for flowlab inherit
Content-Language: en-US, fr
To: David Ahern <dsahern@gmail.com>, Ido Schimmel <idosch@idosch.org>,
 Alce Lafranque <alce@lafranque.net>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org
References: <20240120124418.26117-1-alce@lafranque.net>
 <Za5eizfgzl5mwt50@shredder> <f24380fc-a346-4c81-ae78-e0828d40836e@gmail.com>
From: Vincent Bernat <vincent@bernat.ch>
Autocrypt: addr=vincent@bernat.ch;
 keydata= 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
In-Reply-To: <f24380fc-a346-4c81-ae78-e0828d40836e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-23 01:41, David Ahern wrote:
>> My personal
>> preference would be to add a new keyword for the new attribute:
>>
>> # ip link set dev vx0 type vxlan flowlabel_policy inherit
>> # ip link set dev vx0 type vxlan flowlabel_policy fixed flowlabel 10
>>
>> But let's see what David thinks.
>>
> 
> A new keyword for the new attribute seems like the most robust.
> 
> That said, inherit is already used in several ip commands for dscp, ttl
> and flowlabel for example; I do not see a separate keyword - e.g.,
> ip6tunnel.c.

The implementation for flowlabel was modeled along ttl. We did diverge 
for kernel, we can diverge for iproute2 as well. However, I am unsure if 
you say we should go for option A (new attribute) or option B (do like 
for dscp/ttl).


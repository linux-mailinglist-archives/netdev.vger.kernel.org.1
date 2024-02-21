Return-Path: <netdev+bounces-73595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A5385D4F2
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 10:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E6528CA44
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF67D3EA91;
	Wed, 21 Feb 2024 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="clKX9rfW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DNrCxDV+"
X-Original-To: netdev@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C943C47E
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509114; cv=none; b=YLUi8yD+XmGgAJkgeEmywTfGm8sfw3gRf6hRzqgJqHNU4YL2jG1PtiKx5f5ZnRRRFV1xG58DeRt2d9lINs5qfLXC3ZnFZTvB1P5tD+y5l+uT6+YH8IxTK85b4MyRVW8FP0xkql/Xztndb/YtSfVj/d75p+kmEFcVHLG/ckfbvWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509114; c=relaxed/simple;
	bh=sVB9yRR2rjerha4AzU7ATdIsm80JG2J0Q8DD/xUpAUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfU0Zt4Vt/oN07/PRd1E84NhIgILMugF/InpIVu0nrYxOrOF6d0V96M2G0ieGrsIWiTT2ZMo6CV3t/+vXb8LtFlKAJhrSXHz9cPH+32sImWc0FEvZfGvClGlsqSr/FdY5VYKb8995mLooMPGIC0IcARPUq663UB7BjkEaS2BQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=clKX9rfW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DNrCxDV+; arc=none smtp.client-ip=66.111.4.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailnew.nyi.internal (Postfix) with ESMTP id 5AFA5580561;
	Wed, 21 Feb 2024 04:51:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 21 Feb 2024 04:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1708509110;
	 x=1708512710; bh=1g3TDMOOP2w7CWJwvsRIO38BmYyrOzNJm1PsUVCOwc4=; b=
	clKX9rfWVzpo/IDeggYLmifkk1NINsR/5Atg+0NYbmkwSJVeZzNiicqk216CMFg2
	0R+BnlB4Mz/u2zd1zG2SsyBBY2gkhrgqqSptE8oWTr359+KfWuubds01aSfVYjD+
	86R3QIfbVnuHgQA6JvO063lcxFrEnZzEUvGJjX/LPIpR354Pf0fdoDxbY4dO3o7g
	rFMa5nexQU1y4kJgx5exnNaOwkUSVZBmr7JH0xG1zcmx5vsgSZPjgQNnC692roNk
	SsJD/uZxtHLdAFNcIB2J9H8UzZS0YeSH1oKi1TwKfZZHiHTL34NzyA7QqHMk1+gs
	exx/6FulcnbHRwfdlOfchw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708509110; x=
	1708512710; bh=1g3TDMOOP2w7CWJwvsRIO38BmYyrOzNJm1PsUVCOwc4=; b=D
	NrCxDV+nEcuEcKZ8kIctoJsB9P6W60USDX1RoXMRg0ksmErSs04MMHG4+lC1KhHU
	UI0oJN5zVdez9tvCyxXZauoFFdM6MWobTe+J5MW7JMbbChI+ekvNAiRUVp9J7C7C
	osgFT+2nnYxyceLtMaNpECohDDMj82/Q76Y/wzMVsJGjAH4yf37/zjDAIl8AHLwb
	RC25Msc5gw28Scz7VIHxqM41WW2ZpY0/BRsagwzAbGEwpzTYklb0ODXSuCeHcIr9
	0WMwrixnmtPNYarFPoXaZaYyJUxIFmG6DCiExxqpJfz61KeMV+ROQyb5z39cWQde
	ppgjZrPsHj38uqDJQntfQ==
X-ME-Sender: <xms:tcfVZYAG5O3hyxezufaaO-gRPRN0bgyi1gqie3o1M6Q2RWADlm8C4Q>
    <xme:tcfVZajg420qCarxt4qx9Ilqi6K5LEexyHl78dAGuc_SSkWc43kNGpt41wPLyl8Ow
    MvThw1rrcc3kaFykI8>
X-ME-Received: <xmr:tcfVZbnvHUhZMMwJd-dSYp8lg4S7r6kggLRwfcvAMRleWkta5zqS0OztCghtvMpfvdtoOIqVbATrzf2UuLr2iqn6p2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepsfhuvghn
    thhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrth
    htvghrnhepvedvjeefteejudefgfeigeelgeekvdetveeiledugfejudeihfeuleeigeel
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqh
    guvgesnhgrtggthidruggv
X-ME-Proxy: <xmx:tcfVZeyzjkutmKxPCWooIrFtrrUaQsce6KY88vHGDsZcpIIyfb9_Gw>
    <xmx:tcfVZdRnPCM5C3on11sntgzJDFX2cy6cMXwO9JeTCYZqvimVUaSh6Q>
    <xmx:tcfVZZZJV1YLGpwY4SQcL_ovJzhFd_01G4T5bQjTiXrLZcEic8w6mQ>
    <xmx:tsfVZWKht12KSb8A4UxQIRdmrqIs9UTl2VjHBC7hrQZ-iKWUklmN-Q>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 04:51:48 -0500 (EST)
Message-ID: <5615212b-736d-4a91-8951-ddb9bc90049b@naccy.de>
Date: Wed, 21 Feb 2024 10:51:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH iproute2 v8 1/3] ss: add support for BPF socket-local
 storage
Content-Language: en-US
To: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>, kernel-team@meta.com,
 Matthieu Baerts <matttbe@kernel.org>
References: <20240214084235.25618-1-qde@naccy.de>
 <20240214084235.25618-2-qde@naccy.de>
 <576ebc9e-4307-4e01-9b41-12aaac83b14a@gmail.com>
From: Quentin Deslandes <qde@naccy.de>
In-Reply-To: <576ebc9e-4307-4e01-9b41-12aaac83b14a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-02-18 18:39, David Ahern wrote:
> On 2/14/24 1:42 AM, Quentin Deslandes wrote:
>> +	if (info.type != BPF_MAP_TYPE_SK_STORAGE) {
>> +		fprintf(stderr, "ss: BPF map with ID %s has type '%s', expecting 'sk_storage'\n",
>> +			optarg, libbpf_bpf_map_type_str(info.type));
>> +		close(fd);
>> +		return -1;
>> +	}
> 
> ss.c: In function ‘bpf_map_opts_load_info’:
> ss.c:3448:33: warning: implicit declaration of function
> ‘libbpf_bpf_map_type_str’ [-Wimplicit-function-declaration]
>  3448 |                         optarg, libbpf_bpf_map_type_str(info.type));
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~
> ss.c:3447:68: warning: format ‘%s’ expects argument of type ‘char *’,
> but argument 4 has type ‘int’ [-Wformat=]
>  3447 |                 fprintf(stderr, "ss: BPF map with ID %s has type
> '%s', expecting 'sk_storage'\n",
>       |                                                                   ~^
>       |                                                                    |
>       |
>   char *
>       |                                                                   %d
>  3448 |                         optarg, libbpf_bpf_map_type_str(info.type));
>       |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                 |
>       |                                 int
>     CC       lnstat_util.o
>     LINK     lnstat
>     LINK     ss
> /usr/bin/ld: ss.o: in function `main':
> 
> 
> Ubuntu 22.04 has libbpf-0.5 installed. I suspect version hook is needed.
> e.g., something like this (but with the relevant version numbers):
> 
> #if (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)

After checking, all the libbpf symbols I use require at least libbpf-0.5, except
for this one which was introduced in libbpf-1.0. Hence, I will print the type ID
instead of the string. IMO printing the string representation of the type doesn't
add enough value to justify adding a version hook.

However, I see the minimum required version for libbpf is 0.1, but this
series requires 0.5. I would check the version in ss and #error if
the requirements are not met, but I'm not sure this is the right way to do it.
What do you think?

Regards,
Quentin Deslandes


Return-Path: <netdev+bounces-66477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CCD83F5DD
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 15:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2334E1F2318D
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 14:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151CB241EC;
	Sun, 28 Jan 2024 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bernat.ch header.i=@bernat.ch header.b="Br6NW31J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CN7FZ0F1"
X-Original-To: netdev@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48F32376A
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706452100; cv=none; b=j5nnPEsaulzmYrkBn2f4MuvXfYa9gocHX2UYOK4lHuIyj6PThizJ5YtzZOcHwXDAxuU0OZSCDJeEaiIQ9PtlMJKds4i6M+hUAg3HXqWv0z4XvqYugdRg52gnN6tpXSWFxMLy+V4WJfYbZZlBNGXlKi2P345Dz6Ae97JGiF33VDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706452100; c=relaxed/simple;
	bh=AQjoy8IF/GOuJyBAWAWb7RKLnZdCXmlRmug4jbZ+mKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/DJ4p+WsDqGwS6Aspv2zXK446yQbAqtW0/JGN+bDx09skZ4HTDi5IvKkQfIiy5hY20ujPfHy6JB4VEQqwBZg+No7JxhAdLVaG9ED4FXtb6UeE6WQQSy5gETe6agWb1SxNa8N4rQRGB7CE6Q4hxhmtpzLvwEr1NqhqeudCp2hi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bernat.ch; spf=pass smtp.mailfrom=bernat.ch; dkim=pass (2048-bit key) header.d=bernat.ch header.i=@bernat.ch header.b=Br6NW31J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CN7FZ0F1; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bernat.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bernat.ch
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 75B0D5C01EA;
	Sun, 28 Jan 2024 09:28:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sun, 28 Jan 2024 09:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernat.ch; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1706452096;
	 x=1706538496; bh=GAo5hLN0fOl+OsB59qxDya0f4oXw8z77ARBmp3vNYc8=; b=
	Br6NW31JBBmTKiMlglEvpPAeKp++52TmQ+r/IzRto/+3EDCrsvbo3Hph8+f86uO0
	7NG+02ynWv3VlUiJF5kR1rg/9D6zYb2guCUwZ2LbyF1ojxyAGfLb6SvufYZerKhm
	jb5pPlvX4tIgHBxYirbrKesETfWsObCTV7i+CeMbZIB3HqWrEA5x09HwMfKC8PPQ
	Z1LMwfRyoV0Ivl2qcK940QaFT9/nwRDkKbIzmjTeJwhVFMJq7DnN7oAlF+ico9pc
	tLC7DEnbkvKr+BV1EL0FDtACU2AFl2g52BRSACKdewz7MRB/uQ96B7UUeP4d4wvm
	TTB+bKvNRgM7uZUCpXJcXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706452096; x=
	1706538496; bh=GAo5hLN0fOl+OsB59qxDya0f4oXw8z77ARBmp3vNYc8=; b=C
	N7FZ0F19tWicI6pTV2XwajTOuYZBgBCwNrOfxEqDRxeBzZFa00cKQDFF2aTiz/B7
	k9jZ7NnSqRRy8DfcUIaEFXnYXnBt1tS0X1e/9eqfEDM0EEBkYZbortw4Ad0Sg1KB
	rWJ7lo9fG2XVIP8PHzifDUwYCLSlJZQm90fP4rORn37kY2/xo/qvQzGdExnCmGcy
	JYxRldez7ITUvZeH+dBOOqESwXNzuAEyPLUKbLKPLVe7wLVxb+k4q5IgLN5x3YFF
	do/3Angl/kohRSFAVM+djyOON8A0wo500ZCy/hATQ78STjfOJgWpKpgVwFYmJIT5
	zj7btMDN+AV4H397gZAOg==
X-ME-Sender: <xms:f2S2Zeyn7T0IDbpE_f4sGoMGgcw9vu6R6rVjyoN7UUHz8gDnOxlnjw>
    <xme:f2S2ZaSjlKCX9F0Sj5ISZWy1r9AScBrjKiAgl97-gnLRKwRwMrtr4tFxIYJ3bh-XS
    6wF-ZDhqpeSbsd990U>
X-ME-Received: <xmr:f2S2ZQVd3_RoMKQPd31qLAVr4e4Q_wGzWFVJ8NyZBiHsSVLKwNZCVBa-8O0187ei8LyLqGxuA7fEBMoLF_mOoOHkA9S2yB6Ia3VrFGFd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtvddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeggihhn
    tggvnhhtuceuvghrnhgrthcuoehvihhntggvnhhtsegsvghrnhgrthdrtghhqeenucggtf
    frrghtthgvrhhnpeehveekuedtieeltdffleduheetgeduffejffdtlefftedtgfekueel
    fffgudekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehvihhntggvnhhtsegsvghrnhgrthdrtghh
X-ME-Proxy: <xmx:f2S2ZUiFLEzktAydXi_j1yr3_lEb-mx_Vc11irZ8djU-rwPLZvLuPA>
    <xmx:f2S2ZQA0V_muJU5bj5BOnMkklzUAhfT0XnY52Kt0mwW3xg7RfKBUYQ>
    <xmx:f2S2ZVLAv_Ou9HqwDcYj-YL2LpuNlRORZvEceUqNGTBAxd7eoZ8KdA>
    <xmx:gGS2ZTMerSPMR6wEYpihjt7ILXN-mgwtXTJkfpsU-hfMKefoQtb4GA>
Feedback-ID: id69944f0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jan 2024 09:28:15 -0500 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by neo.luffy.cx (Postfix) with ESMTP id 086061D8;
	Sun, 28 Jan 2024 15:28:14 +0100 (CET)
Message-ID: <d03e0741-e90a-4def-81ae-e9382164e032@bernat.ch>
Date: Sun, 28 Jan 2024 15:28:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] vxlan: add support for flowlab inherit
Content-Language: en-US, fr
To: Ido Schimmel <idosch@idosch.org>, David Ahern <dsahern@gmail.com>
Cc: Alce Lafranque <alce@lafranque.net>, netdev@vger.kernel.org,
 stephen@networkplumber.org
References: <20240120124418.26117-1-alce@lafranque.net>
 <Za5eizfgzl5mwt50@shredder> <f24380fc-a346-4c81-ae78-e0828d40836e@gmail.com>
 <1793b6c1-9dba-4794-ae0d-5eda4f6db663@bernat.ch>
 <1fb36101-5a3c-4c81-8271-4002768fa0bd@gmail.com>
 <41582fa0-1330-42c5-b4eb-44f70713e77e@bernat.ch>
 <1e2ff78d-d130-46d4-b7ad-31a0f6796e1a@gmail.com>
 <e60e2cc1-02c0-452b-8bb1-b2fb741e7b43@bernat.ch>
 <fa8e2b04-5ddf-4121-be34-c57690f06c63@gmail.com> <ZbZJ-IS20fe8wmQv@shredder>
From: Vincent Bernat <vincent@bernat.ch>
Autocrypt: addr=vincent@bernat.ch;
 keydata= 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
In-Reply-To: <ZbZJ-IS20fe8wmQv@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-28 13:35, Ido Schimmel wrote:
> On Fri, Jan 26, 2024 at 10:17:36AM -0700, David Ahern wrote:
>> On 1/25/24 11:28 PM, Vincent Bernat wrote:
>>> Honestly, I have a hard time finding a real downside. The day we need to
>>> specify both a value and a policy, it will still be time to introduce a
>>> new keyword. For now, it seems better to be consistent with the other
>>> protocols and with the other keywords (ttl, for example) using the same
>>> approach.
>>
>> ok. let's move forward without the new keyword with the understanding it
>> is not perfect, but at least consistent across commands should a problem
>> arise. Consistency allows simpler workarounds.
> 
> I find it weird that the argument for the current approach is
> consistency when the commands are already inconsistent:
[...]

It's still more consistent than adding a keyword. But we are OK to add a 
keyword if needed. It seems there is no agreement yet on this. David, do 
you prefer a keyword?

> I would also try to avoid sending the new 'IFLA_VXLAN_LABEL_POLICY' attribute
> for existing use cases: When creating a VXLAN device with a fixed flow label or
> when simply modifying an already fixed flow label. I would expect kernels
> 6.5-6.7 to reject the new attribute as since kernel 6.5 the VXLAN driver
> enforces strict validation. However, it's not the case:
[...]

This should be solved if there is a new keyword. If we do not introduce 
a new keyword, this means querying the current state before setting the 
new state as we need to know what the previous policy was.

> Regarding the comment about the
> "inherit-during-the-day-fixed-during-the-night" policy, I'm familiar
> with at least one hardware implementation that supports a policy of
> "inherit flow label when IPv6, otherwise set flow label to X" and it
> indeed won't be possible to express it with the single keyword approach.

Good example (better than mine).


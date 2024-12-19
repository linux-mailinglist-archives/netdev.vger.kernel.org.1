Return-Path: <netdev+bounces-153302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4788E9F7902
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 124AF7A0387
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236E9221473;
	Thu, 19 Dec 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Lp38TNNG"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B48B221476
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734601991; cv=none; b=bgpwNh0Abu5gWQaf2cbwb0THxj7WbdPic6nVEDREXrYGZhePSpqDWzylDA/vMNLUZ2kk9/OripIbfphsd6SrWIXKjmNNM7cIFenKqAa1fvQy3p4kcy8Ux1BtTASwDPrzs2roczD0ITMCQJHBRCaiJy8TcrSvPuZ3BnrT7NY8ROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734601991; c=relaxed/simple;
	bh=MAVDONljpQjWWOIuoRSJKJpKB16oa0DRryazC0UqlxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWmNEdZeMPCipM6z/ldnpXVvuGauXWx8XLmdN2hV+GGuTgn07KeQFq+GHHhHpgJXNpaqMJ+c+xeI+20urJomxeb58MUOR8vtKORYtopvs1BeSFuBmKrUytKzLFU5vUkBjEClTXPkZVNZGLGYtTghYxOuUfPUAlmQPsQAafByqgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Lp38TNNG; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tODDO-007AK1-4I
	for netdev@vger.kernel.org; Thu, 19 Dec 2024 10:53:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=YXoD3/zrthIcXRRUeOPwThGIIT6anJeVtDQK6wLigRY=; b=Lp38TNNGZAhRZ9MCkKZvspDp16
	ppNUCKb+zHzUG38NT5WRZHcmILKMNZBg/JkDvETkwTEt8ckyxA7R1nypnRmLDIkEv7EX0trIsCm/W
	BzLBwdwViufHwI+SLBn5NIhA6Ecukh/yK2wxATe6U1G9MN2EZPQAOsrujnJTnDOm4oVlT6hXtzo3h
	xjDrd52YF52CNYCBIPGNcZFMeZwcnxfxbrq9R8toVhag7PlnAXGxMhsJKVIIBxZzMf6fSXevFl55w
	+54ucXyA6EUk0+K4p2vW/sxhyaFNKycNMTzDx11aBWjnmCiLPDjLafo6nDNL0AH0nGn8szMEfcyoI
	WajKnrVg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tODDN-00059U-PC; Thu, 19 Dec 2024 10:53:05 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tODD9-00AtyY-27; Thu, 19 Dec 2024 10:52:51 +0100
Message-ID: <35f67091-3a09-44da-b383-51e8d4558b4c@rbox.co>
Date: Thu, 19 Dec 2024 10:52:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/7] vsock/test: Adapt send_byte()/recv_byte()
 to handle MSG_ZEROCOPY
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org
References: <20241218-test-vsock-leaks-v3-0-f1a4dcef9228@rbox.co>
 <20241218-test-vsock-leaks-v3-4-f1a4dcef9228@rbox.co>
 <8f1536c6-480d-4973-8fa8-ad94e6cb15dd@rbox.co>
 <hpe54soa2ltn7givmtvrkv2exommhn377bruyrfilts27qot2a@a6ksxyhm7zoj>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <hpe54soa2ltn7givmtvrkv2exommhn377bruyrfilts27qot2a@a6ksxyhm7zoj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 10:29, Stefano Garzarella wrote:
> On Thu, Dec 19, 2024 at 10:19:56AM +0100, Michal Luczaj wrote:
>> On 12/18/24 15:32, Michal Luczaj wrote:
>>> For a zercopy send(), buffer (always byte 'A') needs to be preserved (thus
>>        ^^^^^^^
>>
>> And this is how I've learnt how checkpatch's spellcheck works.
>> Should I resend with this typo fixed?
> 
> I think it depends more on you than on me :-)
> 
> If you want to send a v4, I don't think there's any problem, just bring 
> all my R-b's with them, so the net maintainers will merge it directly. [...]

OK then; here it is:
https://lore.kernel.org/netdev/20241219-test-vsock-leaks-v4-0-a416e554d9d7@rbox.co/

Thanks,
Michal



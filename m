Return-Path: <netdev+bounces-152180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A20D59F300A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20AC7A1EA2
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EE0204578;
	Mon, 16 Dec 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="hgKRsPOm"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04958204563
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350636; cv=none; b=IPy8U4f+CPGPoQI6YY3Qz8Y2hyKpaZapXkR8xSKi4JLHmUk8650+XBJv8RIdJiFc9BPsS1Kv02FoOqSOvTSaSgCSNb9bTXTgn3cGKyaU4vFP87wvdta+GAgKBY2Aszz4RftBO7J+bxUBc001RYXuNQStTtLXNHQ/PG757BG4Efo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350636; c=relaxed/simple;
	bh=nrxnbN5PDzbUvYeuKcEbs8Br2ZyTI0SbeHnWHZaYSY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfSd5ctELWKCC0vLuOlz/mGbYJ0nYRAdJWlcbfrya8TLq7+ckE/iChQQA+3F8JDy/OAS+OSHxvmiCGco53p9s2a7jVxmCeNvsPKkTVrB/Li2LzAWZxd+dwEGzUWB5IwVAuQba7q0S7IWNJyFP8J0t4Gw+K4RirtDqQjY3odx5F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=hgKRsPOm; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tN9pH-00Flyd-Lp; Mon, 16 Dec 2024 13:03:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=TnGgdpx03WB4fRZN61EvjatXt6028532DMgEBOXB15Y=; b=hgKRsPOmBuV4B5Ci7AY7kWDQen
	BMuFveyx95I19g72ava+v9ypHmY7ejelvlsr9olHsYppOii/rV1tVzwqaPJJ8X+Cj2qBFuc6jV5dc
	uYkvJKL0lo+5BMWQaOJgm31LcwSrJiUtSX2nOsxYMyH6loo3bzlZVbHWfbFmBhLA+tlOM8eecn1eh
	bvanZsInWujIErphJtyjGXwqUQuYhd56JVFJ8OHy0WNP1eqXVtCxwaHodq8JEnkrEtAGdFdSeZV14
	ohcBYWhGoIoZyhiMwsNMSNT4kCSDocsMb7x5GJCY0oZosv1Rr8JLRmrjJh7P+qQdYl/wPql/QpFDd
	5PCk9SzQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tN9pH-00080b-97; Mon, 16 Dec 2024 13:03:51 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tN9p2-00BT0J-Uo; Mon, 16 Dec 2024 13:03:37 +0100
Message-ID: <dd08257d-6110-43ee-9949-2c879575cbef@rbox.co>
Date: Mon, 16 Dec 2024 13:03:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] vsock/test: Add test for MSG_ZEROCOPY
 completion memory leak
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org
References: <20241206-test-vsock-leaks-v1-0-c31e8c875797@rbox.co>
 <20241206-test-vsock-leaks-v1-4-c31e8c875797@rbox.co>
 <oipmjpvmvbksopq6ugfmad2bd6k6mkj34q3jef5fvz72f3xfow@ve7lrp5gx37c>
 <aecfafb8-f556-4d7e-941d-2975f3f30396@rbox.co>
 <z4b2cbflkvo6nqrcw4wx5usoisqkha4scszftfshceo5bkd3nj@34u53ajpaltf>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <z4b2cbflkvo6nqrcw4wx5usoisqkha4scszftfshceo5bkd3nj@34u53ajpaltf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/24 15:33, Stefano Garzarella wrote:
> On Thu, Dec 12, 2024 at 07:26:39PM +0100, Michal Luczaj wrote:
>> [...]
>> That said, I really think this test should be scrapped. I'm afraid it will
>> break sooner or later. And since kmemleak needs root anyway, perhaps it's
>> better to use failslab fault injection for this?
> 
> As you prefer!
> 
> I'd be for merging this new version, but I would ask you to put a
> comment above the function with your concerns about possible failures
> in the future and possibly how to implement it with more privileges.
> If they happen we always have time to remove the test or extend it to
> use more privileged things.

All right, here's v2: https://lore.kernel.org/netdev/20241216-test-vsock-leaks-v2-0-55e1405742fc@rbox.co/

>> [*] It's the only caller. Should @size be dropped from sock_omalloc()?
> 
> Oh, I see, more a question for net maintainer, but I'd agree with you.
> So I think you can try sending a patch to net-next for that.

I digged more and it seems this (i.e. sock_omalloc() only being called
with @size=0) was the case from the very beginning[*]. I understand it was
deliberate and just awaits for some other users of ancillary sbks.

[*] https://lore.kernel.org/netdev/20170803202945.70750-1-willemdebruijn.kernel@gmail.com/



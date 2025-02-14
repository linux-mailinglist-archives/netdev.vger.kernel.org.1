Return-Path: <netdev+bounces-166401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA44A35EC4
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B14F165F84
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 13:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E6C263F20;
	Fri, 14 Feb 2025 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Oq/dgSqc"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419AB2641C0
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538922; cv=none; b=aGoawlPQjdNT72i8Uw3w0JaWxJKCKUh5+Oq0aiHe+t0rrudC9PtcHKmpgtt3Kj4y3Sh1sIdsSxUEamSaeWR6KLpZjegz5ZwWqosfAuk744gYtyDMk7q/v15UoNtvKOfAw6MOaZ6GvQsCJPLdLFCXC15KjSxe96Cfl3Fe0RzKB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538922; c=relaxed/simple;
	bh=1ijryi+AYGJIbnyQDC8LItR2Zntdse4NN1r4Ev6UL18=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eM8F7ULmqkHNqGU2od5Muy47YX/h1NArgHb6L1ZGcqmImScmT4aBg5wkzUkLAlLlw6JG7kcyRyMMIG1LkQj1Px5o4YAJiEQAVc/uwwNohYImX7ON1f8i1XeqNPJTaGqp1JWbCDGR/+J/4NOQwOV1O/yQ+DJnN62oEaSVhCoH3Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Oq/dgSqc; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tivXI-005YwM-11; Fri, 14 Feb 2025 14:15:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=FyOa+DQ3Ccjw6qmkwa7QCGbg3gYexAbxrDcQa74dC8Q=; b=Oq/dgSqcFo8tvhiGclYm70/gAq
	q9H95pjTopxZcJuDs09x3160hlyWf9Q/Icc5FP1zrDJZrFS3tgfeB38D5QyhBztbojWiBd5usJfQH
	rVsWQ13yb6USIHj41LCTzGCVVfP+/Q0QWnCuuxDFBYWmu/jWUVXXL/HiwwWvWPDskBE8tGSKOknjk
	NANyykppxr8DtHelKVNzpLZrfBuDRd3yl4U8uHHf3wwE1gR2/IH67N7FPxcc8Uw8v7Xifc0N72xDQ
	3Ezsohqk20VNDU5+WRHTYHkzmcteC+sMY7fAaoifCoP3gRzEDNnCEARAaKjull8nV03s6hrWCBcZv
	Tk2xRcbw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tivXH-0002nV-2F; Fri, 14 Feb 2025 14:15:15 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tivXG-00FcKa-AX; Fri, 14 Feb 2025 14:15:14 +0100
Message-ID: <950e90d8-4e7a-4e3e-9a9d-2a5bfde8e541@rbox.co>
Date: Fri, 14 Feb 2025 14:15:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net v3 0/2] vsock: null-ptr-deref when SO_LINGER enabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com,
 Luigi Leonardi <leonardi@redhat.com>
References: <20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co>
 <20250212200253.4a34cdab@kernel.org>
 <04190424-8d8f-48c4-9d07-ce5c2f09d5a1@rbox.co>
 <20250213072437.111da6fc@kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <20250213072437.111da6fc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 16:24, Jakub Kicinski wrote:
> On Thu, 13 Feb 2025 11:15:43 +0100 Michal Luczaj wrote:
>> On 2/13/25 05:02, Jakub Kicinski wrote:
>>> On Mon, 10 Feb 2025 13:14:59 +0100 Michal Luczaj wrote:  
>>>> Fixes fcdd2242c023 ("vsock: Keep the binding until socket destruction").  
>>>
>>> I don't think it's a good idea to put Fixes tags into the cover letters.
>>> Not sure what purpose it'd serve.  
>>
>> I was trying to say it's a "follow up" to a very recent (at least in the
>> vsock context) patch-gone-wrong. But I did not intend to make this a tag;
>> it's not a "Fixes:" with a colon :)
>>
>> Anyway, if that puts too much detail into the cover letter, I'll refrain
>> from doing so.
> 
> Never too much detail :) But if it's informative and for humans I'd
> recommend weaving it into the explanation or adding some words around.
> Sorry for the nit picking.

It's ok, I think I get your point. Even simply using a reference[1] would
probably be less confusing for eyes and brains.


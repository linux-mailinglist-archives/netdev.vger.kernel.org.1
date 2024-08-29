Return-Path: <netdev+bounces-123344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910AA964954
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE2D4B2591C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2FD1B2524;
	Thu, 29 Aug 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JT04V75K"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CDF1B1D61
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943630; cv=none; b=GjGRjJgiUEvfnLNXd3E8Rzoz+Z+Nk7WrSBQH+4Ys3X3vh3gm9LYa8/dgrjls5o1pGthkA8m+PvJnZTKfpRCTnGU+XzkR0BMkNTe2v+I7EQLPo0aGSpLxmg/vmXhJpR/M5UjK8LtMYhLTY5uOISBB/hVA7Us3geYc1ij6JHC2RHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943630; c=relaxed/simple;
	bh=lYxTP2lsSLN47zFrEEVoq/xdgzWkYezXBhM3D7BX22Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pL80+VLz+yXH0h+BczXDD7Iiu6A3WxJBSoUPDzpzlGxpL0pynXbDGJrOjqskX8diqrl7HKRyCMxFeycyMEZq5Z/MkZ+P28UB7H6M9mVGI6kvd3loC5zPSZedTJObaf4Nj3lrV4knjM1IuQrKxjz1Hwlt6MuF2lRoCAvjqsLtNJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JT04V75K; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5e46e19-b045-4ac8-b871-32affe3202c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724943625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TGVotgaZ83HmpeGuFqvVop2QJz2MGRyfxLL76EaK03c=;
	b=JT04V75Kzlhxn4eo/2FduLTbxgWyuoPIWd58OSkBiJUudaUDOGFeMKNSuMZrqprnuQkTRn
	ZxAlMw1+n5Ggi54lx4BXlW0Pb5HJXKhuWzsOWSTQp1TEqILYRoZKexk78RfEAgG3pv6j/2
	PBLDTXumyqpYbViBwkGW9QDGqezpbQ0=
Date: Thu, 29 Aug 2024 16:00:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] net_tstamp: add SCM_TS_OPT_ID to provide OPT_ID in
 control message
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Vadim Fedorenko <vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
References: <20240829000355.1172094-1-vadfed@meta.com>
 <66d0783ca3dc4_3895fa2946a@willemb.c.googlers.com.notmuch>
 <dfe033f1-cc61-4be3-a59d-e6b623591cc6@linux.dev>
 <66d0856b4234a_38c94929436@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <66d0856b4234a_38c94929436@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/08/2024 15:27, Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
>> On 29/08/2024 14:31, Willem de Bruijn wrote:
>>> Vadim Fedorenko wrote:
>>>> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
>>>> timestamps
>>>
>>> +1 on the feature. Few minor points only.
>>>
>>> Not a hard requirement, but would be nice if there was a test,
>>> e.g., as a tools/testing/../txtimestamp.c extension.
>>
>> Sure, I'll add some tests in the next version.
>>
>>
>>>> and packets sent via socket. Unfortunately, there is no way
>>>> to reliably predict socket timestamp ID value in case of error returned
>>>> by sendmsg [1].
>>>
>>> Might be good to copy more context from the discussion to explain why
>>> reliable OPT_ID is infeasible. For UDP, it is as simple as lockless
>>> transmit. For RAW, things like MSG_MORE come into play.
>>
>> Ok, I'll add it, thanks!
>>
>>>> This patch adds new control message type to give user-space
>>>> software an opportunity to control the mapping between packets and
>>>> values by providing ID with each sendmsg. This works fine for UDP
>>>> sockets only, and explicit check is added to control message parser.
>>>> Also, there is no easy way to use 0 as provided ID, so this is value
>>>> treated as invalid.
>>>
>>> This is because the code branches on non-zero value in the cookie,
>>> else uses ts_key. Please make this explicit. Or perhaps better, add a
>>> bit in the cookie so that the full 32-bit space can be used.
>>
>> Adding a bit in the cookie is not enough, I have to add another flag to
>> inet_cork. And we are running out of space for tx flags,
>> inet_cork::tx_flags is u8 and we have only 1 bit left for SKBTX* enum.
>> Do you think it's OK to use this last bit for OPT_ID feature?
> 
> No, that space is particularly constrained in skb_shinfo.
> 
> Either a separate bit in inet_cork, or just keep as is.

Ok, got it. I'll add IPCORK_TS_OPT_ID flag then. Thanks!


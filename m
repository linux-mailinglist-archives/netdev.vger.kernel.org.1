Return-Path: <netdev+bounces-130817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0BC98BA1F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFA71C22982
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0141BBBD9;
	Tue,  1 Oct 2024 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FizTvXZE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1E41A2653
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779992; cv=none; b=PnPM+lP4P/gxoLWsTGchEeYs8QYn02glhp+pVMOmmSExaVXuhHq/2ahRe8XvcZ6RG1j7yWUmN/656B0jqBx5uVeK1D6um4/qu2xqE+BY/2oFuay6Gc564BRCS9g/f5PFN+oH/YaO4byRhXw3hBF+5j59KffaUnMQxbWgOMKCEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779992; c=relaxed/simple;
	bh=XuyIIsC0q2Rih/ZhD5fZ31RnR+EEe/FthAZjvjlGG6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+LdVksxbfdPYqzzDOWATTjHdblYLzajqOYVZuzTRnd741rnC+Z1+JpPKRnVc0XAcCaC4B+AL6so18F9wkTfNtPmXJieqfiKDCnDyrxVsaOU0lJAvHLgvCpoTQ30BLEgp8MzbuGtTL4paCJfO+W4vkOHl7JllWJxC+3cE72mWnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FizTvXZE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727779989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pQ1AlhU9UokTGuUARDQY2eHTDfm42za/gYP56k6yH4=;
	b=FizTvXZEsH8AP9OybEQQC9bC/SI+mc4bYwN1PcrBYcx+C/yF9DtGKvZ9V2yCtz3fXR4yHa
	PERM3RBPeA8Dghn2rFCTqp0r7pFymZHHq5mHpMva5RAGmC2Eoq6dQ96QBiOwS4OQvEyas5
	gq9l/23FuwrOh5krJnJjqHfeZp6rm0I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-fVNC13AsPCGOHkDR6zn_yg-1; Tue, 01 Oct 2024 06:53:08 -0400
X-MC-Unique: fVNC13AsPCGOHkDR6zn_yg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37cd91210e3so2311903f8f.0
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 03:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727779987; x=1728384787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pQ1AlhU9UokTGuUARDQY2eHTDfm42za/gYP56k6yH4=;
        b=a2qiEsyfaG6vcECCWiHDDwyn/FizPqwxnijV3kx194w/K9ZMshAU1BIeF3t+V7PIjL
         x8mVj+VUpY+dHuOMQpDM5SlAPF1zgrkbK9s0QuN182NfxVCGMr8Tl/6gi2dYjxTZw0jV
         NoRxivhd7oou+FGJI2jvOiYGNh3xaek0VGVw97kAq+lPpVaKHQx4tBFMAeiPEkM16Q9i
         Y5aibs9g2/ObYBvE2NMbAJI+dRQ4FIYP14Lu/tR+E3Cw9bbSFWkI8QSzAWhQHF6/8jY4
         zLFALsKlVFnsj9SHZ9/5SqqHXlRHndMa0K19gd+QJ39gYuT9QWY9UIdW91pwG0FvYXos
         NCbw==
X-Gm-Message-State: AOJu0YwhP6hFujDqQIlJYJXwcg54IXGhDkU/pNXjOXhu+Yv1pPg1Ult7
	bqQsNkCF+kWIDPh7fYxTXUR3nCJVJVgvkpQtiQHwmLuayftlEiqWytylEtvpDpXbN1NS9n3vSrO
	UA3n8eno62PoilPKmcfnJ8Am8qcPXA1sVcjzh78Iy7vwK0xBKxgJ7Dg==
X-Received: by 2002:adf:efc9:0:b0:37c:d569:467e with SMTP id ffacd0b85a97d-37cd5b10563mr8454559f8f.59.1727779987428;
        Tue, 01 Oct 2024 03:53:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe7VXlUFT1uvkGozmj7C17mw/rd7IWAi+X8MHmH71Qeo99+VxBECVGlI+0PEUHMu78OItrkA==
X-Received: by 2002:adf:efc9:0:b0:37c:d569:467e with SMTP id ffacd0b85a97d-37cd5b10563mr8454539f8f.59.1727779986977;
        Tue, 01 Oct 2024 03:53:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c? ([2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dec19bsm131519495e9.26.2024.10.01.03.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 03:53:06 -0700 (PDT)
Message-ID: <53c7fc83-7599-451f-91ff-309e55defd48@redhat.com>
Date: Tue, 1 Oct 2024 12:53:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] rxrpc: Fix a race between socket set up and I/O
 thread creation
To: Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, yuxuanzhe@outlook.com,
 Marc Dionne <marc.dionne@auristor.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <1210177.1727215681@warthog.procyon.org.uk>
 <20240925183327.GW4029621@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240925183327.GW4029621@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/25/24 20:33, Simon Horman wrote:
> On Tue, Sep 24, 2024 at 11:08:01PM +0100, David Howells wrote:
>> In rxrpc_open_socket(), it sets up the socket and then sets up the I/O
>> thread that will handle it.  This is a problem, however, as there's a gap
>> between the two phases in which a packet may come into rxrpc_encap_rcv()
>> from the UDP packet but we oops when trying to wake the not-yet created I/O
>> thread.
>>
>> As a quick fix, just make rxrpc_encap_rcv() discard the packet if there's
>> no I/O thread yet.
>>
>> A better, but more intrusive fix would perhaps be to rearrange things such
>> that the socket creation is done by the I/O thread.
>>
>> Fixes: a275da62e8c1 ("rxrpc: Create a per-local endpoint receive queue and I/O thread")
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> ...:wq
> 
>> diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
>> index 0300baa9afcd..5c0a5374d51a 100644
>> --- a/net/rxrpc/io_thread.c
>> +++ b/net/rxrpc/io_thread.c
>> @@ -27,8 +27,9 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
>>   {
>>   	struct sk_buff_head *rx_queue;
>>   	struct rxrpc_local *local = rcu_dereference_sk_user_data(udp_sk);
>> +	struct task_struct *io_thread = READ_ONCE(local->io_thread);
> 
> Hi David,
> 
> The line above dereferences local.
> But the line below assumes that it may be NULL.
> This seems inconsistent.

sk->sk_user_data is cleared just before io_thread by rxrpc_io_thread(), 
I think accessing a NULL 'local' here should be possible.

@David, could you please respin addressing the above?

Thanks!

Paolo



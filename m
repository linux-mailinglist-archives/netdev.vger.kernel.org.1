Return-Path: <netdev+bounces-190006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F62AB4DF1
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DBD3AF0F9
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548D1EA7CE;
	Tue, 13 May 2025 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gXVurHow"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE891CA84
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 08:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124502; cv=none; b=q0x14/4vO+R2pL6XhdutDpmJgg97BaNdutdzlRArEqijw9eHX6YjYVBREbSyCxK0JZFb1Y4S/vbwDjQdJxtcVji99hKmlQVVZne+3XAISC6/eGeZC9YYyTOJKbIGzy+Z0XFRtOVcytHITVgQW2xqundwacqv0NmCwg8JIHByppo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124502; c=relaxed/simple;
	bh=WoLV7aEvIrg79cK5ImIB6NjwxEgwx4wqkCMS6LcRQqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvTxYDq28zQlhfhLrFIxY/UWg/U1lFE3ZXOzUWbnkTsN4Gzt1sXOIDUxEoy3nM9JsnQ9JrXbM0ZMgQuq4FMAU8d8swErsamFkG/9IYLxaZBSKpzURj1nOU7X5CjykZw35M1EUcsOA3GnFn9qMca+TMQGh9YB4UASNv875K2xgtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gXVurHow; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747124499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iURsG8DOWSBnfO7pDGFzY5dYRrujw4Q7tfL87MT9Q9E=;
	b=gXVurHowMUKVr1p7n+YG2B4n7Fh2uV1oNjFG6w2wEh8w+K3AuwCnc10P3IUeyb/6SySxZm
	60pXULqrMGKqlj96N/0OsdWt207yUYdFH24w9Svv/HNz9JUMe92bDmebmFjhfRjATCNsva
	ECapaBGEWZgQ+KS8ovV/WKOohNiWr/I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-pOGhdU0jMSeHSYP9d9MuMQ-1; Tue, 13 May 2025 04:21:38 -0400
X-MC-Unique: pOGhdU0jMSeHSYP9d9MuMQ-1
X-Mimecast-MFC-AGG-ID: pOGhdU0jMSeHSYP9d9MuMQ_1747124497
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so25935725e9.0
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 01:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747124497; x=1747729297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iURsG8DOWSBnfO7pDGFzY5dYRrujw4Q7tfL87MT9Q9E=;
        b=eJpQcIWMvk3849+cLNugXk6YmU7dNf2pXNM0RQsN6nPk+5u455RQk0lkJeNcrfoCQw
         ZfCKkFtcz5nD27YmBp+4pB6u/ucbqs8P5IjCZakgWw/+UwC3PEIg37MFTrmWBi3m0377
         xFTuR8BEZsu+32o2aGpaMVhZEOQwz2f98mOi+3fLd0EPTFvcnNUfvk/DRB2zEb+9RXSj
         zrPbYEArY/ZMg3r1IfWsQQoU1WJEzMM/zIx8A9tiWOqNF1X9rhILnIQR3J1PqVhw0dus
         1VjWnXcm3kGw8t/nvkfRg5pi1VnDTm47x8YsozpgF36wSkVUuQNCViAO9hDzhzKLLA2f
         mCww==
X-Gm-Message-State: AOJu0Yz3YZBmXwSZLlh2XpGL+xNc0slAgMt0tQP7CllBHny15JaOgiem
	T+zr4xJmjNPHpZ/mTfvAzCtm681qIcB/6wF/UYSUSM1KMAZOdfPltut3KGRDwY0/PBLI1sJzGSI
	6Ntk6yBRoKgtcjCX6cpdegZPN0E83eCfGFzurjFpsiA0SC7pfGd94Jw==
X-Gm-Gg: ASbGnctlmAG1UkPKNyHGmLnwGXTyTdVnwHQAZHUA/P7GoS3AzxFmRXLxE7erxCjhSBl
	ehZ87hWNXO0dYlXSUzWCyhVq/Uj1H13WqKIyQWl1/kvWN8COse4ZettXvYc5VE1F+xOi/ysE4kh
	m/8gzlJo54vq4unopN0cjotP4vDtcZGQqFPUOrFPEnrMds5OT9wvSPdVihYYHtUoOteLo+wz/9W
	IyOQq7H2XIoituNORzFqwiXLfsE1wnwCR4D5j6Ur8MNwzz/QFmhPh6UAAzQOr/T4U5S99E50oVw
	dCrpF1qtVg902sqo3AI=
X-Received: by 2002:a05:600c:6488:b0:43c:fffc:786c with SMTP id 5b1f17b1804b1-442d6d6ace2mr156805145e9.19.1747124496862;
        Tue, 13 May 2025 01:21:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExtqPTznMxRvt+xcKdvrlMUNwSFT48o8nyZazJO52wFa4Ha8U4EsvqHoystjg4hF2RaFnMxQ==
X-Received: by 2002:a05:600c:6488:b0:43c:fffc:786c with SMTP id 5b1f17b1804b1-442d6d6ace2mr156804735e9.19.1747124496440;
        Tue, 13 May 2025 01:21:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67e2db2sm158725295e9.16.2025.05.13.01.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 01:21:36 -0700 (PDT)
Message-ID: <1a47ce02-fd42-4761-8697-f3f315011cc6@redhat.com>
Date: Tue, 13 May 2025 10:21:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/10] ovpn: ensure sk is still valid during
 cleanup
To: Jakub Kicinski <kuba@kernel.org>, Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Al Viro <viro@zeniv.linux.org.uk>,
 Qingfang Deng <dqfext@gmail.com>, Gert Doering <gert@greenie.muc.de>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-11-antonio@openvpn.net>
 <20250512183742.28fad543@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250512183742.28fad543@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/25 3:37 AM, Jakub Kicinski wrote:
> On Fri,  9 May 2025 16:26:20 +0200 Antonio Quartulli wrote:
>> In case of UDP peer timeout, an openvpn client (userspace)
>> performs the following actions:
>> 1. receives the peer deletion notification (reason=timeout)
>> 2. closes the socket
>>
>> Upon 1. we have the following:
>> - ovpn_peer_keepalive_work()
>>  - ovpn_socket_release()
>>   - synchronize_rcu()
>> At this point, 2. gets a chance to complete and ovpn_sock->sock->sk
>> becomes NULL. ovpn_socket_release() will then attempt dereferencing it,
>> resulting in the following crash log:
> 
> What runs where is a bit unclear to me. Specifically I'm not sure what
> runs the code under the "if (released)" branch of ovpn_socket_release()
> if the user closes the socket. Because you now return without a WARN().
> 
>> @@ -75,13 +76,14 @@ void ovpn_socket_release(struct ovpn_peer *peer)
>>  	if (!sock)
>>  		return;
>>  
>> -	/* sanity check: we should not end up here if the socket
>> -	 * was already closed
>> +	/* sock->sk may be released concurrently, therefore we
>> +	 * first attempt grabbing a reference.
>> +	 * if sock->sk is NULL it means it is already being
>> +	 * destroyed and we don't need any further cleanup
>>  	 */
>> -	if (!sock->sock->sk) {
>> -		DEBUG_NET_WARN_ON_ONCE(1);
>> +	sk = sock->sock->sk;
>> +	if (!sk || !refcount_inc_not_zero(&sk->sk_refcnt))
> 
> How is sk protected from getting reused here?
> refcount_inc_not_zero() still needs the underlying object to be allocated.
> I don't see any locking here, and code says this function may sleep so 
> it can't be called under RCU, either.

I agree this still looks racy. When the socket close runs, nobody else
should have access/reference to the 'struct socket'. I'm under the
impression that ovpn_socket should acquire references to the underlying
fd instead of keeping its own refcount.

Side note: the ovpn_socket refcount release/detach path looks wrong, at
least in case of an UDP socket, as ovpn_udp_socket_detach() calls
setup_udp_tunnel_sock() which in turns will try to _increment_ various
core counters, instead of decreasing them (i.e. udp_encap_enable should
be wrongly accounted after that call).

/P



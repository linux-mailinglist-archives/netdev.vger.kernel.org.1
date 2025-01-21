Return-Path: <netdev+bounces-160074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4F1A18052
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0523A4894
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B111F192A;
	Tue, 21 Jan 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="HFzEPaK+"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8F249641
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470890; cv=none; b=bpmKYIkRgD/KJGU/h6J0EdVyyYkfCyfanv8WgZ/RdJ+KkfOtU+C5qL0pzGq+iFu+76N0N2rnd4a4w3qufS3ZMNrKuBjUXwB7SEopisg8vbC2GYnW0fo21QTfaHuiuw18uI88gnWqlVqGCBZ9+51wNAgcvUpu7WFqatf++q6twOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470890; c=relaxed/simple;
	bh=JrTVr8ZoKr2icgdmzca1J/8KgygznWl5+YaM8dX8GVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgJoemU5+wRi5qdqhe7+6Ak9cpJmrteDAKJcEV5r9W75wdwBLIyu8Q6Ssj5iw4DTeiBnol/rJ76evpO8Mi/t+ToUIdM94WF6dD+hDdeWuQv766Hgi4Ga36tiXDOXZ7y5jGUCangoWMpESInu+V/pdWDuzW56hTXdOw5OPZAZLNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=HFzEPaK+; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1taFXs-000mnB-Lu; Tue, 21 Jan 2025 15:48:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=IlIUb7yym71LJ3ntXHTA4lvLopaCDuEReGBLIPION3E=; b=HFzEPaK+xMxsC8oBSiEaYIj1dX
	c5CTKzy4kV0RqFpWQ+a7X0z0sdZ5kOJX6qqaeIzYdbfCUU+I9VU/R+Zw24BS+MKPSiVtVpgQmRqbs
	yFkuraDR/gYNK/tN3CoB9vH9G8l/uwH/zFWLOVwgtoQkNfxyTa1dmaQZGkBN/V0Cvs2+MvYjORtHG
	Ov+QPSlSsHg6HLCp+kxzu8TvDcUfchueG9xnoiF0lFICYpTTfdvCC3HbpmZfaU5yFF47LPLJ6123Y
	+6ahrcKBkWpsgVuxN0mwMu0IhjljpNdna5Z1ZO9mQDzQm8XeSQKfaJAWkG5l0XW20zR0IWGCE7Dfm
	+XpyS+wQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1taFXr-0007gn-HS; Tue, 21 Jan 2025 15:48:00 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1taFXd-00AIoR-Vi; Tue, 21 Jan 2025 15:47:46 +0100
Message-ID: <c50c2bcb-2416-4d72-b80f-3882b811b273@rbox.co>
Date: Tue, 21 Jan 2025 15:47:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/5] vsock/test: Add test for UAF due to socket
 unbinding
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>,
 Andy King <acking@vmware.com>, netdev@vger.kernel.org
References: <20250117-vsock-transport-vs-autobind-v1-0-c802c803762d@rbox.co>
 <20250117-vsock-transport-vs-autobind-v1-4-c802c803762d@rbox.co>
 <34yqhvkemx27yoxwodfjdc7rwvuyr6sq2e2nlpyfhzvyscvccq@du25v6ljrebj>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <34yqhvkemx27yoxwodfjdc7rwvuyr6sq2e2nlpyfhzvyscvccq@du25v6ljrebj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/20/25 11:20, Stefano Garzarella wrote:
> On Fri, Jan 17, 2025 at 10:59:44PM +0100, Michal Luczaj wrote:
>> +#define MAX_PORT_RETRIES	24	/* net/vmw_vsock/af_vsock.c */
>> +#define VMADDR_CID_NONEXISTING	42
> 
> I would suggest a slightly bigger and weirder CID, this might actually
> exist, (e.g. 4242424242)

Ok. I'll try to avoid the whole VMADDR_CID_NONEXISTING. See below.

>> +/* Test attempts to trigger a transport release for an unbound socket. This can
>> + * lead to a reference count mishandling.
>> + */
>> +static void test_seqpacket_transport_uaf_client(const struct test_opts *opts)
>> +{
>> +	int sockets[MAX_PORT_RETRIES];
>> +	struct sockaddr_vm addr;
>> +	int s, i, alen;
>> +
>> +	s = vsock_bind(VMADDR_CID_LOCAL, VMADDR_PORT_ANY, SOCK_SEQPACKET);
> 
> In my suite this test failed because I have instances where I run it
> without vsock_loopback loaded.
> 
> 26 - connectible transport release use-after-free...bind: Cannot assign requested address
>
> Is it important to use VMADDR_CID_LOCAL or can we use VMADDR_CID_ANY?

To force the transport release on a live socket (via transport
reassignment) we need to switch between two transports (but it's okay if
the other transport turns out to be NULL). So, considering your setup(s),
is it reasonable to expect VMADDR_CID_ANY and VMADDR_CID_HOST bringing in
different transports (as in: different pointers)? Any other combination?

I've tried that in v2:
https://lore.kernel.org/netdev/20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co

>> +	/* Vulnerable system may crash now. */
>> +	bind(s, (struct sockaddr *)&addr, alen);
> 
> Should we check the return of this function or do we not care whether
> it fails or not?

We don't really care, but I guess it just looks bad. I'll fix that.

Thanks,
Michal



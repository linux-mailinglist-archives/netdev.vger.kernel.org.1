Return-Path: <netdev+bounces-249377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D567D17CB6
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91FA9307AB40
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F4389DF3;
	Tue, 13 Jan 2026 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkIKi9Os";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRBaq/+W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E04338759F
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297762; cv=none; b=YaaUm0O01h9mMwB1g+5YIynTRS38Ysk17+4LMpAVFY6lgE4OUpdHldnce8gV4bWEfk6FArOq/xzoPMF6pmcDXkrS6lnT0hP+OD66fYeRPojMDFzjKP/hiBBc9DZzOnr0+KgFbGHubWYgkiM1QBEXQsaNLKczWTc+hnHeQA68F+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297762; c=relaxed/simple;
	bh=YSOEmHQVpZ1XiFP6cpcAsOosEtV841EhtGG6BetY4b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOiwmZdR3KJfwIV5LO1S2aW2O0g4kBxptN3A/1xUufBDYNyTkHSTWJuXbLe4Dj663bAc/gOaoXnNxH0tuZMWgD95FLlE+U57R3aFCWX88B2Dq1NVr/1qBMcOulD3hlgGJhCIuxkcc/79xaAEZuO1paM2DOthOo2BV+sWiKFuwac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VkIKi9Os; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRBaq/+W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768297759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1GS0CRV+w7tRrF7+CCit+G3w4AP8whQo0obFYQAA7qo=;
	b=VkIKi9OsmvfgSWclN+3m3dr68AoPoa9u4fGAuwXFH1kuO4uyDTGUz7shGnHQ5G89dGF1p8
	Uzvjit9GIVdVCq40vsPdqCoOnBkmSw0b9MMO+y/20rDMRmNiwG6wfoVoF8kwpMGuad/Utf
	DEQhPCFZG/K7p8CVXttDi9+sYz6xv0c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-4GcNpdSIOO2MdBSBlnf9jA-1; Tue, 13 Jan 2026 04:49:17 -0500
X-MC-Unique: 4GcNpdSIOO2MdBSBlnf9jA-1
X-Mimecast-MFC-AGG-ID: 4GcNpdSIOO2MdBSBlnf9jA_1768297757
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4310062d97bso4970847f8f.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 01:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768297756; x=1768902556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1GS0CRV+w7tRrF7+CCit+G3w4AP8whQo0obFYQAA7qo=;
        b=KRBaq/+WSSclUXnfnWwsAflKS1j1rytI4I/jOwqT+MRwPaoXxpk8/OuxNzO/b7TB8q
         vClFZSGx+Dz6AcpB1oM2IdifiTvjN420wyXSlUyN1CjcfGQDDhJ6ika6Ug6bKp+PVEtH
         T2ilr+S5LS2fSCu/8v6dLEXDKPQ3MywovLmhnni9LkTH+VpexZLuIKv+D1kY3V6X/4w3
         BlLZt92tKTetSXbFjo8QyWvUtWpXH6RfWy9GL3oNlwrQ9C7+C91l87D/sFvnlAIL2YYi
         DxPgwqPIGT99qR6SutNHtL+9ausp19DYS/g0838hdxvtosnL9VOpF3myeQmf6Y8F5YzN
         JjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768297756; x=1768902556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GS0CRV+w7tRrF7+CCit+G3w4AP8whQo0obFYQAA7qo=;
        b=AFK7rv9euqgcq3VVX4i9Onpj3HND3ud2ES5bPurFhvQkPocelHQgr8KkGyTgnCqeKd
         pQIuDBHFX0WCEketBRh7LmZSryPtxWkh9sZKxsdcP2Or3lXSq4y9fymOqESjuUtiVmpR
         Y2BHZ9k0visQUBCQsnwZumte2wl26lN68sBMce1kMvqJVeqHgv4+2wubNhLxe+Y9Wao/
         lBfnEFTNnnNg2eiMbzysawxhB8c262GPDRWvPouFgyVbjr98wiSJdj9oDItw7JJ0DXWD
         jbuuwjOATBYIKsf3nrp+cVtmg/ZeFD9Sl2vjcSecrTn0RH6n8WFXiI7sFer1CMLut9Wc
         5IVA==
X-Forwarded-Encrypted: i=1; AJvYcCUi936p2/UPneRFJqTeSvP1VULt0uTX4ZGZaWdFJ8NtyG7ElAl0SHC9gRC8VjYhB6SvwDJI40E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlBPRZRZ5ySRdaPs/kWk4ycAS5pTbQuS7D3ZIMbYTJXfBvII9a
	hj4HDUb6o4rFryqm86OD+1Kc/arMExpoPaCXzVnzQE4CQVAYVhsN4GwssxirRm9yFQflv3Vc6GB
	wq/M5LSR9jA8JJ1bRnDs4uX5TjLHJUP8lfXb9lDE+3/TWixPXGxcOu2pIjA==
X-Gm-Gg: AY/fxX4M13e3KmT/Ky2pcEecEO4ZeV9s/ukWurOqS9HuaOH8zV9FWJaY6cwhvKysgxN
	hTt8F6pedawG0FgbHswqSlPeGlaKR26FjR3rzap87RR9emiCwesKKI5l6z/aMcSK0fq5swl6urK
	+dEwgr7jlDAHomIHuLURIuSSsZSJSDWEnARkDDJ3sqYp93gtRrbeCF4AQYKyI513v6NFfETatSh
	16uXjlBW5BT+AaqZfrAZHeShGV0S2G4PObntypzDu84IUYyHeJR5n2Pi5uwXDdeGSkkC6F4aRd9
	te3wQqbyEIYYIfL6Quy1k7lxw3OhdFAsfWmiyjHjqhu0gbqX3xKQwm53CdUXQKiD0Wra2pR65tZ
	dSADw8K+JCjn/UVBXtgubPgyZ6pqgFQtYtVo04XSTI1f8DGI70JALtmHUgLVlyw==
X-Received: by 2002:a05:600c:a08:b0:477:b0b8:4dd0 with SMTP id 5b1f17b1804b1-47d84b36b7emr268431045e9.17.1768297756555;
        Tue, 13 Jan 2026 01:49:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG59H6I4L3LW3VM2eO5vqd4A+F9Msyf0Cpn+5ysJCfFivWNRcqjGAWOBoxCzYxqNC1GJXlk3w==
X-Received: by 2002:a05:600c:a08:b0:477:b0b8:4dd0 with SMTP id 5b1f17b1804b1-47d84b36b7emr268430695e9.17.1768297756010;
        Tue, 13 Jan 2026 01:49:16 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm44230246f8f.11.2026.01.13.01.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:49:15 -0800 (PST)
Date: Tue, 13 Jan 2026 10:48:43 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 02/13] vsock: add netns to vsock core
Message-ID: <aWYTFBCoJrmnEPgg@sgarzare-redhat>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <20251223-vsock-vmtest-v13-2-9d6db8e7c80b@meta.com>
 <20260111013536-mutt-send-email-mst@kernel.org>
 <aWWFB2K5H5OXGWP8@devvm11784.nha0.facebook.com>
 <aWWXTx6SSNiV3a+v@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aWWXTx6SSNiV3a+v@devvm11784.nha0.facebook.com>

On Mon, Jan 12, 2026 at 04:52:31PM -0800, Bobby Eshleman wrote:
>On Mon, Jan 12, 2026 at 03:34:31PM -0800, Bobby Eshleman wrote:
>> On Sun, Jan 11, 2026 at 01:43:37AM -0500, Michael S. Tsirkin wrote:
>> > On Tue, Dec 23, 2025 at 04:28:36PM -0800, Bobby Eshleman wrote:
>> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
>> > >
>> > > Add netns logic to vsock core. Additionally, modify transport hook
>> > > prototypes to be used by later transport-specific patches (e.g.,
>> > > *_seqpacket_allow()).
>> > >
>> > > Namespaces are supported primarily by changing socket lookup functions
>> > > (e.g., vsock_find_connected_socket()) to take into account the socket
>> > > namespace and the namespace mode before considering a candidate socket a
>> > > "match".
>> > >
>> > > This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode to
>> > > report the mode and /proc/sys/net/vsock/child_ns_mode to set the mode
>> > > for new namespaces.
>> > >
>> > > Add netns functionality (initialization, passing to transports, procfs,
>> > > etc...) to the af_vsock socket layer. Later patches that add netns
>> > > support to transports depend on this patch.
>> > >
>> > > dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
>> > > modified to take a vsk in order to perform logic on namespace modes. In
>> > > future patches, the net will also be used for socket
>> > > lookups in these functions.
>> > >
>> > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> >
>> > ...
>> >
>> >
>> > >  static int __vsock_bind_connectible(struct vsock_sock *vsk,
>> > >  				    struct sockaddr_vm *addr)
>> > >  {
>> > > +	struct net *net = sock_net(sk_vsock(vsk));
>> > >  	static u32 port;
>> > >  	struct sockaddr_vm new_addr;
>> > >
>> >
>> >
>> > Hmm this static port gives me pause. So some port number info leaks
>> > between namespaces. I am not saying it's a big security issue
>> > and yet ... people expect isolation.
>>
>> Probably the easiest solution is making it per-ns, my quick rough draft
>> looks like this:
>>
>> diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>> index e2325e2d6ec5..b34d69a22fa8 100644
>> --- a/include/net/netns/vsock.h
>> +++ b/include/net/netns/vsock.h
>> @@ -11,6 +11,10 @@ enum vsock_net_mode {
>>
>>  struct netns_vsock {
>>  	struct ctl_table_header *sysctl_hdr;
>> +
>> +	/* protected by the vsock_table_lock in af_vsock.c */
>> +	u32 port;
>> +
>>  	enum vsock_net_mode mode;
>>  	enum vsock_net_mode child_ns_mode;
>>  };
>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>> index 9d614e4a4fa5..cd2a47140134 100644
>> --- a/net/vmw_vsock/af_vsock.c
>> +++ b/net/vmw_vsock/af_vsock.c
>> @@ -748,11 +748,10 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>>  				    struct sockaddr_vm *addr)
>>  {
>>  	struct net *net = sock_net(sk_vsock(vsk));
>> -	static u32 port;
>>  	struct sockaddr_vm new_addr;
>>
>> -	if (!port)
>> -		port = get_random_u32_above(LAST_RESERVED_PORT);
>> +	if (!net->vsock.port)
>> +		net->vsock.port = get_random_u32_above(LAST_RESERVED_PORT);
>>
>>  	vsock_addr_init(&new_addr, addr->svm_cid, addr->svm_port);
>>
>> @@ -761,11 +760,11 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>>  		unsigned int i;
>>
>>  		for (i = 0; i < MAX_PORT_RETRIES; i++) {
>> -			if (port == VMADDR_PORT_ANY ||
>> -			    port <= LAST_RESERVED_PORT)
>> -				port = LAST_RESERVED_PORT + 1;
>> +			if (net->vsock.port == VMADDR_PORT_ANY ||
>> +			    net->vsock.port <= LAST_RESERVED_PORT)
>> +				net->vsock.port = LAST_RESERVED_PORT + 1;
>>
>> -			new_addr.svm_port = port++;
>> +			new_addr.svm_port = net->vsock.port++;
>>
>>  			if (!__vsock_find_bound_socket_net(&new_addr, net)) {
>>  				found = true;
>>
>>
>>
>
>Another option being to follow inet's path and use
>siphash_4u32() the way that secure_ipv4_port_ephemeral() does...
>

Yeah, I was going to ask what inet does, also because I don't really 
like the code we have now (not your fault at all).

But maybe is too out of scope to resolve in this series, so I guess just 
moving what we have per-ns LGTM for now!

Stefano



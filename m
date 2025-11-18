Return-Path: <netdev+bounces-239501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B8961C68D89
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id AFF1E2B086
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402BD352922;
	Tue, 18 Nov 2025 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbXbVUvM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZN8PruE3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B9134C9AE
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461361; cv=none; b=PNP6CLJ10RmnSod7DkiZcCKjiW2HPcxTdFKQVq9f4s9woGnALAM4Qg8i++QM8nCl+rQWl2Vyql5A/WLAFuQYVwoGv7ul/PXZOAcx7QWew++1pnt+RQRCd7KANDpr4yoBfrzRCMC1hHW10wIlK0hGc4RfnEHSlC2Grxhh2SxnbrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461361; c=relaxed/simple;
	bh=DP2UqYoAhUQhjzVLwVf1Qc3K1rq3/0/jImzuikX3f1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDeNtSkRwaoVa0kvvXqK5HwIEiOGyH1V2zbpsBVqzeX3eP1ohk35G29UHeFU7fGD9k0d+tjZNNKFmhX2X9a0vpethqA4AC6NIm6Los/SuuVQplNPjsShyqCK9hqQ2GGmR4QpWOqwfhnyfZ1f00KE9w26pJgD1QoHuzwofDolGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbXbVUvM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZN8PruE3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763461356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WhrxnuIQ+DWK1cNZVwgN/Tu9b3I3RG0xWTJTU2uF+lc=;
	b=NbXbVUvM1qQDjY1haandtAfbRcAzW3zhCwNPZDqd8elx5wiJRwVNu0j7bsVh2CYSBLq7J2
	XpLsJQr7Lr0I6M0eABNKO3ZHS4ChtPKpncMDcTw73wS8OaorqL2pX9oHFlDWDzc4vjdBeT
	bQLeUX2PrAmyjuEOXEjpLo5ZmtfwG5c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-w_AWfXHDMzmkI2TLmkyA9g-1; Tue, 18 Nov 2025 05:22:34 -0500
X-MC-Unique: w_AWfXHDMzmkI2TLmkyA9g-1
X-Mimecast-MFC-AGG-ID: w_AWfXHDMzmkI2TLmkyA9g_1763461353
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b739a4cf54fso448782366b.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 02:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763461353; x=1764066153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WhrxnuIQ+DWK1cNZVwgN/Tu9b3I3RG0xWTJTU2uF+lc=;
        b=ZN8PruE3rdHFqElf9iN0OL/et5yxTHljvbCSfqNEVePsZ6kevuUWMraFEx78tr7E33
         t/8VxIssI/23+QchxiXVm3jGGiHwTqbG/MyvinBAhV2kYhGMDPcei4mV48RhUdQveegx
         e7aXr9W/RPI3UNRJPpnveTKuhpG33daW6/mUwDdMKVuzPPJ7N/BUuHNsFMQBM3uvMsEi
         qSP0bOY/ZO2hnfA+pglXj4ArNMXbCyg72TH43HMyMGM+xC7Fj3FZCPPuOhDseFmbh+MC
         MWa4RBuo/manUFGbvAjNWmT5aa3mFBNUjdSZr8g58DA+lmzppAGtvpuT/5g5Bes1Tnda
         aQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763461353; x=1764066153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WhrxnuIQ+DWK1cNZVwgN/Tu9b3I3RG0xWTJTU2uF+lc=;
        b=I3ux43CcEJcT83FXOugqgj6y8r765wWiEnAHpQkL/3j68ekBOjc4kOin6i8FrvBDFu
         Zo9Weud3/xXvc+wWFyeekyFcTls9WoOleH385xcKjbfn9O57C+IYhz2aweLq3w8wvSO+
         jzTRturQ7CUtBzOF44yAxGIM5B2siCOlCG5/de5ID9olew4UufHjQmc7zcFod0Z6T8FI
         lT8myf/YAkdey9xHXtsFSkQh0+KT9IKwp+nUzJMDPd0P8F325JMdK2oDaZfQtZ3599lx
         HTjNcDmwRqJXSOyF/17gO0exG7eGB19LgJjiTTGaF42vS7HNJ5XFdfdee/JoeCvEfzcm
         MNTw==
X-Forwarded-Encrypted: i=1; AJvYcCWNLo1GXoIm6HWp5l4d9Ab7HOfwL5j+pRzSs/jXdgCGRdT9xSCD9l/iq/JWHja0fuck57t7H/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH4pRzbOfLnL3VsDbLjD621U/7WLv40BJ4uw3iwf0BayxtakSb
	CyLn/QJvW5wlUsh56DGh0T5IBs0auNtWhtun3/2yTby8NjIAujlljg2YbDog//jogyXa7jALMRp
	kyFJpfAnsHnEDCTKA4oKrGDGkoXJCModNtVnUn/ynbiUDEtoJoepdFcAQ+Q==
X-Gm-Gg: ASbGncueLr0dH2ArUhf9OGtLmxFSA9d1pwoz8ogN0fKQwQu3Z64AsrOsKqtrDv4KWcm
	TJH9eR0x5fdGIGssTs2jQeK4+pgNFr6ST3D6wSxGoVS6fumKjclGVme79Dfbc56NfvslO3B9jVF
	TDwna37kUWnjj3x+pYjP5eEcTrO98YhRvvQfGotOaOLtbBwGxng6l74O2KZn+wCR3tpgCtOs4zV
	5XVXxotvunX9VABXoGBSptTwwmfmqM+wf4LP2cjUrKCt7jkijIvGRgeN+HVwq7KigKcrEIiH9nP
	B6SFvnaFSDGKt3jsOX0DtfVyYIVLfzgTXhfIqUiu/5y9NIi6EAkCxDk+3qqik1V7Siqtc2YaQDT
	Xo2LZGnA79SVGdTsuF9evQxgxCVHKRgO8ajULFKE2O1clkrcd
X-Received: by 2002:a17:907:9446:b0:b71:29f7:47ef with SMTP id a640c23a62f3a-b7367bd9eddmr1553213666b.61.1763461353305;
        Tue, 18 Nov 2025 02:22:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5wXBLs/IvjmY2IFBzvdXJdfIARJZCTsl5s37hgphmEAYMJcnafh7q0nxw3c1pVEGtYDAXPQ==
X-Received: by 2002:a17:907:9446:b0:b71:29f7:47ef with SMTP id a640c23a62f3a-b7367bd9eddmr1553210066b.61.1763461352763;
        Tue, 18 Nov 2025 02:22:32 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fa812a3sm1314518866b.8.2025.11.18.02.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:22:32 -0800 (PST)
Date: Tue, 18 Nov 2025 11:14:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: vsock broken after connect() returns EINTR (was Re: [PATCH net
 2/2] vsock/test: Add test for SO_LINGER null ptr deref)
Message-ID: <cosqkkilcmorj5kmivfn3qhd2ixmjnrx7b2gv6ueadvh344yrh@ppqrpwfaql7d>
References: <xafz4xrgpi5m3wedkbhfx6qoqbbpogryxycrvawwzerge3l4t3@d6r6jbnpiyhs>
 <f201fcb6-9db9-4751-b778-50c44c957ef2@rbox.co>
 <hkhwrfz4dzhaco4mb25st5zyfybimchac3zcqsgzmtim53sq5o@o4u6privahp3>
 <aa00af3b-2bb1-4c09-8222-edeec0520ae1@rbox.co>
 <cd7chdxitqx7pvusgt45p7s4s4cddyloqog2koases4ocvpayg@ryndsxdgm5ul>
 <7566fe52-23b7-46cc-95ef-63cbbd3071a1@rbox.co>
 <kiz4tjwsvauyupixpccqug5wt7tq7g3mld5yy5drpg5zxkmiap@3z625aedysx7>
 <d3a0a4e3-57bd-43f2-8907-af60c18d53ec@rbox.co>
 <js3gdbpaupbglmtowcycniidowz46fp23camtvsohac44eybzd@w5w5mfpyjawd>
 <70371863-fa71-48e0-a1e5-fee83e7ca37c@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <70371863-fa71-48e0-a1e5-fee83e7ca37c@rbox.co>

On Fri, Jul 25, 2025 at 11:06:52AM +0200, Michal Luczaj wrote:
>On 4/15/25 15:07, Stefano Garzarella wrote:
>> On Fri, Apr 11, 2025 at 04:43:35PM +0200, Michal Luczaj wrote:
>...
>>> Once connect() fails with EINTR (e.g. due to a signal delivery), retrying
>>> connect() (to the same listener) fails. That is what the code below was
>>> trying to show.
>>
>> mmm, something is going wrong in the vsock_connect().
>>
>> IIUC if we fails with EINTR, we are kind of resetting the socket.
>> Should we do the same we do in vsock_assign_transport() when we found
>> that we are changing transport?
>>
>> I mean calling release(), vsock_deassign_transport(). etc.
>> I'm worried about having pending packets in flight.
>>
>> BTW we need to investigate more, I agree.
>
>I took a look. Once I've added a condition to break the connect() loop
>(right after schedule_timeout(), on `sk_state == TCP_ESTABLISHED`), things
>got a bit clearer for me.

Great! and sorry for the delay!

>
>Because listener keeps child socket in the accept_queue _and_
>connected_table, every time we try to re-connect() our
>VIRTIO_VSOCK_OP_REQUEST is answered with VIRTIO_VSOCK_OP_RST, which kills
>the re-connect(). IOW:
>
>L = socket()
>listen(L)
>				S = socket()
>				connect(S, L)
>					S.sk_state = TCP_SYN_SENT
>					send VIRTIO_VSOCK_OP_REQUEST
>
>				connect() is interrupted
>					S.sk_state = TCP_CLOSE
>
>L receives REQUEST
>	C = socket()
>	C.sk_state = TCP_ESTABLISHED
>	add C to L.accept_queue
>	add C to connected_table
>	send VIRTIO_VSOCK_OP_RESPONSE
>
>				S receives RESPONSE
>					unexpected state:
>					S.sk_state != TCP_SYN_SENT
>					send VIRTIO_VSOCK_OP_RST
>
>C receives RST
>	virtio_transport_do_close()
>		C.sk_state = TCP_CLOSING
>
>				retry connect(S, L)
>					S.sk_state = TCP_SYN_SENT
>					send VIRTIO_VSOCK_OP_REQUEST
>
>C (not L!) receives REQUEST
>	send VIRTIO_VSOCK_OP_RST
>
>				S receives RST, connect() fails
>					S.sk_state = TCP_CLOSE
>					S.sk_err = ECONNRESET
>
>I was mistaken that flushing the accept queue, i.e. close(accept()), would
>be enough to drop C from connected_table and let the re-connect() succeed.
>In fact, for the removal to actually take place you need to wait a bit
>after the flushing close(). What's more, child's vsock_release() might
>throw a poorly timed OP_RST at a client -- affecting the re-connect().
>
>Now, one thing we can do about this is: nothing. Let the user space handle
>the client- and server-side consequences of client-side's signal delivery
>(or timeout).

Perhaps until we receive a specific request from a user, we could leave 
things as they are, because it really seems like a rare corner case to 
me.

>
>Another thing we can do is switch to a 3-way handshake. I think that would
>also eliminate the need for vsock_transport_cancel_pkt(), which was
>introduced in commit 380feae0def7 ("vsock: cancel packets when failing to
>connect").

Unfortunately, I think this is a problem. For now, each transport 
implements whatever it wants.

In the case of virtio-vsock, we have a specification, and making this 
change will require a change in the specification. In addition, we would 
still have to continue to support the old versions in some way, so I 
don't know if it just adds complexity.

>
>All the other options I was considering (based on the idea to send client
>-> server OP_SHUTDOWN on connect() interrupt) are racy. Even if we make
>server-side drop the half-open-broken child from accept_queue, user might
>race us with accept().
>
>L = socket()
>listen(L)
>				S = socket()
>				connect(S, L)
>					S.sk_state = TCP_SYN_SENT
>					send VIRTIO_VSOCK_OP_REQUEST
>
>				connect() is interrupted
>					S.sk_state = TCP_CLOSE
>					send VIRTIO_VSOCK_OP_SHUTDOWN|CHILD
>
>L receives REQUEST
>	C = socket()
>	C.sk_state = TCP_ESTABLISHED
>	add C to L.accept_queue
>	add C to connected_table
>	send VIRTIO_VSOCK_OP_RESPONSE
>
>				S receives RESPONSE
>					unexpected state:
>					S.sk_state != TCP_SYN_SENT
>					send VIRTIO_VSOCK_OP_RST
>
>C receives SHUTDOWN
>	if !flags.CHILD
>		send VIRTIO_VSOCK_OP_RST
>	virtio_transport_do_close()
>		C.sk_state = TCP_CLOSING
>	del C from connected_table
>	// if flags.CHILD
>	//	(schedule?) del C from L.accept_queue?
>	//	racy anyway
>
>L receives RST
>	nothing (as RST reply to client's RST won't be send)
>
>So that's all I could come up with. Please let me know what you think.

Thanks again for everything you're doing, much appreciated!

If you agree, I'd say let's leave things as they are for now.

Thanks,
Stefano



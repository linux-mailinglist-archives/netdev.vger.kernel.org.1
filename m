Return-Path: <netdev+bounces-182806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0931A89F3A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A9A17B03C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29C22973D3;
	Tue, 15 Apr 2025 13:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwkMCqtz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB732949F9
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723108; cv=none; b=h9Bo5IVlF12tavPv9FpqJR9E4FLq5/NFZcwUdgUbl7w3iw+NXkjNxlBVctt1CXqnjTept71MT1N7WWiYeHKcXHMcT0pvBlZWP+yGriJXA+kp6ppXl8OnmVtvQz0zt5yrr3NKUGEp/T+9NCMwTIa80cnIx1gf+yTCyuYOXDmA7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723108; c=relaxed/simple;
	bh=+2JnfeAYL8QYUi16XZR7BiEwpBTygOgiMGABmI7uDig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6Lnau0k+hJ38wxRGJ8E3AKS58b09p3cvwvNgG8nk1GtFYep5CL2+MknztEcDoh+htxiOrOISDv6GfW5TkRCNif7X0d7oMBnlUZVrdJG93xatYuJrH5G6dvbmeN/diKdhXh8RqDzVZIScI1CptcrDxPZ/K8oW0thJ5EmYN0kl9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwkMCqtz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744723106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=56Wl7aD/e2nusVltsAJ9dgSuFRtHQKEE2kXljhNlSkg=;
	b=bwkMCqtzBETlUZLeBz/Bjc/2Bsb0BoPmhnLTfZk9Je3ePK0jt4X2Gl54cw6mc0gkIC1wpN
	XzS8Nj0TnYEMsJi0NqhrWXiAdPV/zTJ1S1yOnMR1W8GgR+E4/vkwAexWKnEyH5Ruy4/Q7A
	uYEI8S0IyT5z2jxqqisrhW9T+3IJ9Cw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-8NmqbNFZNxeBxsghvT5Ulw-1; Tue, 15 Apr 2025 09:18:23 -0400
X-MC-Unique: 8NmqbNFZNxeBxsghvT5Ulw-1
X-Mimecast-MFC-AGG-ID: 8NmqbNFZNxeBxsghvT5Ulw_1744723102
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912d9848a7so3237128f8f.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 06:18:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744723102; x=1745327902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56Wl7aD/e2nusVltsAJ9dgSuFRtHQKEE2kXljhNlSkg=;
        b=ii0b05crGDg87fqW37nRsmwrVkeg1KC8VS7o1O82MtoNly8wKtvgVdcUyI+KBGCPcp
         +zzi0BuqIkNQ6ZmO6cmiaE7cqr1Cj8sJwjSIQn7vodljNU4KYk08ByjlNwuQYonK2T8G
         Ez2cguNAfBvkfX2fCqrtt+LgaDNnqXZGftvZYBHxV2lU+3aCs6rMhVqnszZS7Cr+EytS
         kEnG67rUk5m8jAPHdqxmvgULautYJgT/CkoZOt3tffUKNmlGQR3vcNU4bYNAeteHWjlt
         sEnXilYOw0nsFXAv+3qGjx0dQlT12H5PqvMIHo71v3lV0vYrcjsyseMaeSXR0LI0El5b
         CAMw==
X-Forwarded-Encrypted: i=1; AJvYcCUJqMB9HVhawOQYer1n7+7v74ow03sZvAmm8XgZH/V654+Mp2FP+PYuWltOxt5pYgrNWUwFcHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0dYetV27ObI6qYLd/i9V29MORwo+ZSOFZztxCRpupEL9Z2iW
	tlyGcKDRrbKs+VNavr3mm54lPa2kmccsHgKrrj9ob1YuO6whzSuG8q+Cot5VOP0X2c/ni4wj0MN
	0dHeyRIHy0VsDyRVJDWPtptKAsULF/VLIthN5W98oANwWTor9hLrdmQ==
X-Gm-Gg: ASbGncvM+MfHy/Lz799BDkoevgb/cNfSlucijYYF/ZvI2TLeiPkPlZvDWne4CCulVG6
	6Divi2pJSNu/jvjV0q/g1mnRqlTZXk+5KwbLOAEFZ9uyleV1FQP6cPtOkwZ16fVvsAAyiXDfVK3
	qpZjGgQxqK0R8rgHYDdpoEi+FOusQaZ/8SscsjyqnMhhn67Utq9PO8a1xdoJNBHeAWwYQ7h7Qn1
	0wTOQhlb0n0GxayE9p0pu0nCqwCCHwRw2cfqG07eDlAxCIunx0BBtNN5ye08xqP8u7TAMuWxZrQ
	bU1XYF4HXw7/ugkdaw==
X-Received: by 2002:a5d:59ad:0:b0:38d:fede:54f8 with SMTP id ffacd0b85a97d-39edc30d6ccmr2356124f8f.16.1744723101918;
        Tue, 15 Apr 2025 06:18:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwioPX2tvWeuXNcwluD612yA09xaQv88aBPnGiEZMhAjoAUBOAI3L4bBrGPmpi0pbUsZgqIA==
X-Received: by 2002:a5d:59ad:0:b0:38d:fede:54f8 with SMTP id ffacd0b85a97d-39edc30d6ccmr2356058f8f.16.1744723100693;
        Tue, 15 Apr 2025 06:18:20 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.149.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96bdb5sm14012396f8f.21.2025.04.15.06.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 06:18:20 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:18:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: bytes_unsent forever elevated (was Re: [PATCH net 2/2]
 vsock/test: Add test for SO_LINGER null ptr deref)
Message-ID: <wxdauup4s54jjgi55n6m2eylnn2r64rorvsouevo3sivbpmnfb@yf5lt6yk7ro7>
References: <vsghmgwurw3rxzw32najvwddolmrbroyryquzsoqt5jr3trzif@4rjr7kwlaowa>
 <df2d51fd-03e7-477f-8aea-938446f47864@rbox.co>
 <xafz4xrgpi5m3wedkbhfx6qoqbbpogryxycrvawwzerge3l4t3@d6r6jbnpiyhs>
 <f201fcb6-9db9-4751-b778-50c44c957ef2@rbox.co>
 <hkhwrfz4dzhaco4mb25st5zyfybimchac3zcqsgzmtim53sq5o@o4u6privahp3>
 <aa00af3b-2bb1-4c09-8222-edeec0520ae1@rbox.co>
 <cd7chdxitqx7pvusgt45p7s4s4cddyloqog2koases4ocvpayg@ryndsxdgm5ul>
 <7566fe52-23b7-46cc-95ef-63cbbd3071a1@rbox.co>
 <kiz4tjwsvauyupixpccqug5wt7tq7g3mld5yy5drpg5zxkmiap@3z625aedysx7>
 <e07fd95c-9a38-4eea-9638-133e38c2ec9b@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e07fd95c-9a38-4eea-9638-133e38c2ec9b@rbox.co>

On Fri, Apr 11, 2025 at 04:44:43PM +0200, Michal Luczaj wrote:
>On 4/11/25 15:21, Stefano Garzarella wrote:
>> On Fri, Apr 04, 2025 at 12:06:36AM +0200, Michal Luczaj wrote:
>>> On 4/1/25 12:32, Stefano Garzarella wrote:
>>>> On Tue, Mar 25, 2025 at 02:22:45PM +0100, Michal Luczaj wrote:
>>>>> ...
>>>>> Turns out there's a way to purge the loopback queue before worker processes
>>>>> it (I had no success with g2h). If you win that race, bytes_unsent stays
>>>>> elevated until kingdom come. Then you can close() the socket and watch as
>>>>> it lingers.
>>>>>
>>>>> connect(s)
>>>>>  lock_sock
>>>>>  while (sk_state != TCP_ESTABLISHED)
>>>>>    release_sock
>>>>>    schedule_timeout
>>>>>
>>>>> // virtio_transport_recv_connecting
>>>>> //   sk_state = TCP_ESTABLISHED
>>>>>
>>>>>                                       send(s, 'x')
>>>>>                                         lock_sock
>>>>>                                         virtio_transport_send_pkt_info
>>>>>                                           virtio_transport_get_credit
>>>>>                                    (!)      vvs->bytes_unsent += ret
>>>>>                                           vsock_loopback_send_pkt
>>>>>                                             virtio_vsock_skb_queue_tail
>>>>>                                         release_sock
>>>>>                                       kill()
>>>>>    lock_sock
>>>>>    if signal_pending
>>>>>      vsock_loopback_cancel_pkt
>>>>>        virtio_transport_purge_skbs (!)
>>>>>
>
>So is this something to worry about? The worst consequence I can think of
>is: linger with take place when it should not.

Yep, I see. My question is (I think I wrote this last week also), if the 
socket connected, even though we were interrupted, why do we close it?

Maybe we need to see what TCP does, but actually as you said, there may 
be a race with another thread that has already started using the socket 
after the successful connection.

So would it be better to avoid closing the socket if it is connected, 
even if it has been interrupted?

Thanks,
Stefano



Return-Path: <netdev+bounces-160556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3296A1A27D
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 12:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752DB16B235
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637FF20DD7F;
	Thu, 23 Jan 2025 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBysC/vv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE531C5F14
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737630165; cv=none; b=etwT3+wAZFj0Cn5Jh0UHddbsCD0uMCgKrxOCQowXAuXNoT2taQdGzy6R/iitlxWczMN/jG/irkhFVELnbmIyTjon9lE+NIRgm1ooNzCxbnk3bCzgM3JUUpn0MLNPGRw80HjQSotsaYIh3vf7gX2wi0TPeOjuf5mNy9KIPLgKg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737630165; c=relaxed/simple;
	bh=/CrwkM6sz8EQ7DFhmCxDvR35R1xgL/CrolRfxoB8HSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgP8W3oVP53ENfJ384vQzsb5qLK+0HtfxHj+oYlBDmV39by49ZwryYmB0D6o/TnswcIfoSB3N3U9ZDxsmNFNvJhslCfGK49ThaVuy+WESAo+VkEnUYI84Whf6B7JJgqe+12pvIjSrJkZwbIo5Gdbn0RIqsT0ui3cT7B1UwfknZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBysC/vv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737630162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v+HvkadESYr+6YZ6rJIaWxe2n6B1oB6eTw6RXzewGEk=;
	b=EBysC/vvlL0ACxe+XlmBdVVqvlKdbyiAzBJ6dIvXbyTdfMKiRoQIq3z7g+ULUu/aivSGli
	58ORL354TdNltvFOPIIkK6ZpT9wts100PjXb4YCQdda4IrXRzUo8qMhkT2xdAlNb+FvuRV
	/kUKaFGZny4lkGSOL0Xd4bjZT8fLz5Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-rkQVxV61OCyEyITzm7YS2Q-1; Thu, 23 Jan 2025 06:02:41 -0500
X-MC-Unique: rkQVxV61OCyEyITzm7YS2Q-1
X-Mimecast-MFC-AGG-ID: rkQVxV61OCyEyITzm7YS2Q
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4678b42cbfeso16248091cf.3
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 03:02:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737630161; x=1738234961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+HvkadESYr+6YZ6rJIaWxe2n6B1oB6eTw6RXzewGEk=;
        b=iH/7Atam7qB6xR9thnlWWMuvKF4NgFc6Eu3aP2i54RT+vJzkHZLfGVYM/Zjt54Zw5i
         4neIQmm6e0BXMDMuqixPNk69BcQ5hL8vMcOflIMUX3wwOlKLjPU2Vn8zZ32+NvAwVsM2
         iQWznpVaJCBZCOyWC46ilbpXbijblUPZ4wWZl3VpTkkmWZaNs5Z46cXrG6ZBmKNHBMIb
         ZCHWfl+fW5dLHotRYbxkktzipPmgf8JAilRqyL8MUvDtTKAGRqUJPEB/9hkJVUiUPFHi
         uViCCLCauIXTsjMeDICUed9VR4s06cvHLBn/E7yxDMCunScTkzxPPNqYmURa8Rir6bUB
         2oCg==
X-Forwarded-Encrypted: i=1; AJvYcCWDlbjxOj3b2TydB+4DEYnaiYlMt8CfmeyaPuKWYKh2p92hp9d52T38dWnUUWn6RnG3BO5Pm2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyWqqi7QBmO1JR2ALY3FNMJOltCi0ezdGK/MDDW9IlSWi32ca
	9K3t7ywu6toX0hpvLGkR/KwoVFHL2JJyyTt7OJwOEuPhpyFq5fwuXECKijparxe/gv6TLc0W710
	cTaNayZR8516xokVcs+deed95ZuL+dRh3P8/7BDdzD5lxhCRtspYm+w==
X-Gm-Gg: ASbGnct+1vdmMkJ7dy1HvqiTHqgGpT7v9PV6440PCVb2tWlNWj8L6CXT0jviu92aRVJ
	Xl+4nMPIdAK6h8lK2S9/oFr9cEkaf2dHnXjcHpDVylYcOv6v33bFS/xWq+/b/fdWUj6eIWLynVP
	5Q4uPxy6O7A5ElUrR9YbwQQms6kiGcpkJFQMYYUfCWKQlQqXxcmI1oXjyRBNwrAV6c845gp9eUW
	ih6/CU+590hJ3jPCEBw6GUtlfMQVO6jUXR0cNyRpr326nz3zrcN2ArW+WGHzuMNoDoOzuEb5w==
X-Received: by 2002:a05:622a:4c:b0:467:83f1:71d9 with SMTP id d75a77b69052e-46e1286bcc9mr358386761cf.0.1737630160793;
        Thu, 23 Jan 2025 03:02:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEUGOo95N96L61xTsUy34Z9+f6t8bmMxBiZJynEMpKPrd7zIV5A5PAboah2tdpaVZIp0UhLw==
X-Received: by 2002:a05:622a:4c:b0:467:83f1:71d9 with SMTP id d75a77b69052e-46e1286bcc9mr358386551cf.0.1737630160493;
        Thu, 23 Jan 2025 03:02:40 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e102ec2d9sm73508861cf.12.2025.01.23.03.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:02:40 -0800 (PST)
Date: Thu, 23 Jan 2025 12:02:36 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 3/6] vsock/test: Introduce vsock_bind()
Message-ID: <gkgrd5zpqow4jn2dzr4svh2xu2tfhzucqjv5wavnqrq3qa34uj@x3lv7qy27t2m>
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
 <20250121-vsock-transport-vs-autobind-v2-3-aad6069a4e8c@rbox.co>
 <xzvqojpgicztj3waxetzemx5kzmjy57yl5hv5t7y2sh4bda27l@wwvuhac6zkgg>
 <64fcd0af-a03b-47d5-960d-4326289023a5@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <64fcd0af-a03b-47d5-960d-4326289023a5@rbox.co>

On Wed, Jan 22, 2025 at 09:11:30PM +0100, Michal Luczaj wrote:
>On 1/22/25 17:01, Luigi Leonardi wrote:
>> On Tue, Jan 21, 2025 at 03:44:04PM +0100, Michal Luczaj wrote:
>>> Add a helper for socket()+bind(). Adapt callers.
>>>
>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> tools/testing/vsock/util.c       | 56 +++++++++++++++++-----------------------
>>> tools/testing/vsock/util.h       |  1 +
>>> tools/testing/vsock/vsock_test.c | 17 +-----------
>>> 3 files changed, 25 insertions(+), 49 deletions(-)
>>>
>>> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
>>> index 34e9dac0a105f8aeb8c9af379b080d5ce8cb2782..31ee1767c8b73c05cfd219c3d520a677df6e66a6 100644
>>> --- a/tools/testing/vsock/util.c
>>> +++ b/tools/testing/vsock/util.c
>>> @@ -96,33 +96,42 @@ void vsock_wait_remote_close(int fd)
>>> 	close(epollfd);
>>> }
>>>
>>> -/* Bind to <bind_port>, connect to <cid, port> and return the file descriptor. */
>>> -int vsock_bind_connect(unsigned int cid, unsigned int port, unsigned int bind_port, int type)
>>
>> If you need to send a v3, it would be nice to have a comment for
>> vsock_bind, as there used to be one.
>
>Comment for vsock_bind_connect() remains, see below. As for vsock_bind(),
>perhaps it's time to start using kernel-doc comments? 
This is a good idea! @Stefano WDYT?
Sticking to tests, IIRC someone mentioned (maybe Stefano?) about moving 
to selftests for vsock, but I don't think it's going to happen anytime 
soon.

>v3 isn't coming, it seems, but I'll comment the function later.
Thank you :)

Cheers,
Luigi



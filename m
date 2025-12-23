Return-Path: <netdev+bounces-245862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3172FCD96B4
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 14:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8641300B288
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 13:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C057C313E08;
	Tue, 23 Dec 2025 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUpOlarj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyTgG69S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310C9313281
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766496051; cv=none; b=QGKjitoDIgevrutQBIXXr+7Na1ouPGVnw+G4YwsslhUb18rkKFL+h6gES1W4sImZgqvEb2sQiSoMMCbMtrEd0XHeOSxoereLLX+ofhmqfjJjUn8bjuLngCSonyPqcXiORF0V071nPR83HUI0AcuFn+3YqvRdMrez6/rlvdKyQiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766496051; c=relaxed/simple;
	bh=6FEDJWDEXPwDHq5FjNeQDR7NvGRqzZXVeWMPQBaC+T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4+yJbWpXQf/CNo7NkHXR9rvvdQ2a1rABpquA7x9GXXr8ZaliaxPxg7brUQ5jbbCCvt6F7WDcxRnhYXiqrM2n7WjNlb9N8Pq5o0MovrcYyDgwj4PJ2hveOWStriZzAFfR9R62cx7Rgw7gZDvsbCnlUNEQPDdBDp3wz+uyPOqhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUpOlarj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LyTgG69S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766496049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BRe1EnOv1GyxckqNmcBvauEG3PWqIpBb6cBk/IR9fzc=;
	b=DUpOlarjvKtxYSG4oGZKGuvQtTt5TKl+J8tKd5/Vjf8ENAiMExODEUAJP+jVewEC5YIMDb
	0/9GavbE8/lrToj6My2rE+HHu9mLmV3ZXRw2IXjhgV5RZ2wmT46TyK9R/a1cE4mQCfLQJs
	aIVYYHMyFOKGzAhsLf61x9rlsJg0u5A=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-veyakkhLNTmA39OFiSwwyw-1; Tue, 23 Dec 2025 08:20:47 -0500
X-MC-Unique: veyakkhLNTmA39OFiSwwyw-1
X-Mimecast-MFC-AGG-ID: veyakkhLNTmA39OFiSwwyw_1766496046
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64da80b3699so1318716a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 05:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766496046; x=1767100846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRe1EnOv1GyxckqNmcBvauEG3PWqIpBb6cBk/IR9fzc=;
        b=LyTgG69SXP93yfrY91gMPSWg+ZPkre0EEwXRY4y5Kt7awgaVxcG+KOgPk/FwrFx7Jq
         mAZ79KrdEUjfmeu9FgCJI0NiIVx59TvamZOmG4NHl1AcAJBUG2dZQd0Q9hOAkD7jrDLz
         QBny5DBIZ/rjJ5NMbq2ESawjnIc8pBdQ1i7bDRWvN+smRHRRT1b7uri/PQjeTo+v/RcI
         wIooAwfoocbffEwf2E7U6m5iVkGGXJdEyrUk90mLIE+3m+u+mFxysw4JX9PaehwLd9WN
         UL6x1UfXPUXPrxZX/Aqsl0ZLSF82nH/dFA3Ne20oV54d2vPtfiKd1j50rBgVm5yi0zoO
         XBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766496046; x=1767100846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRe1EnOv1GyxckqNmcBvauEG3PWqIpBb6cBk/IR9fzc=;
        b=H3pF3n8Y2cz6Zn0nWLTQJtEdqLVujOg8BIJOdU8JK91O9eyS52g95I+n7gh5bljzUB
         pC3thbl/fk0Xr9uly55UyqTkl1vfY68OyKN7saDKRDBZgbx26ZacAPNMSQySotDRZDkq
         WuWwQ/6ofuwDDzBE/Fc2ey02/vL+hREbw9/8jXrHMmyJNQ1+pn3rkPj6ul5dJQktutaM
         9vsjZaJI86cPC5ZuMb4pyXfASjDi1GSb8Sc+gAsDHbf8IQr4VvlP/DZZ7L/LvXCA5z0p
         Qau7MJcXYFrsxEfJ/4xhdZylI/qKfkuQ7PF5YAbpbSXKsVSzAPIrQaKlwNorG0vtmc6X
         OlWw==
X-Forwarded-Encrypted: i=1; AJvYcCX2og7B5rP8jrPLgX8G2lTLYjWTXcaBm21mZWpFIZZRMAZy7KfSJfk1XdvakpgmtRvCY6IO1uA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6EF1fgnn/QMhKJOw6/Z7UiONTVRCYFCcpA5d1Etja+DbRFmXN
	fyGiHD8ZvP37o/1JYg7msCKiTnaC0ajmWBqMsi7FscESLvhrUqHoMchTaBx0gsx/SoPVBVbjBT7
	uJqvm0YKNIqhXqmb1IndNazeMXevtvThyJd22bqrL0zvBmgyTlMx9XtvD+A==
X-Gm-Gg: AY/fxX4zUkR8a80WsHxTSYCYi4VDFy973TLtAKme5UPSWMrIeAZnoAdncTb9vlMGboe
	abn8kNIFmpHTbqtHIvSRVDKTtyEzTeu17U6VXfCqJCQWb5JBeK6T362EAZ4ifwYQOvqcc/rA/vm
	0n+LgTi35waIW7uEUv3lHNfyh1Uec6EKs0tfdkGW38xJxvrlWuCmt3nYb91qXKnxGBBVuCcpwx+
	SeLO81CfqZGNq42RMzBLHTMe99XufrssH5NrspihucoKhZbgrD6uQ+abiwXtRFWOThYJS27mOIY
	/ZckhLAHf73OVMQlMq8mwVQDxbY+ery/th/LMTftfFBCgM8dy43vXOYy/4H24tUJ7uEyyELzIhy
	qwMUPanCvikl4yQ==
X-Received: by 2002:a05:6402:1ed5:b0:64b:7885:c985 with SMTP id 4fb4d7f45d1cf-64b8e93c197mr14856997a12.3.1766496046295;
        Tue, 23 Dec 2025 05:20:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIaPvpBqA5VZRBxV0Qq8GuLUjF3OOea4Sszi0hglkQxPEQuXCT2471wtxRSPlrlUlo7MvZvQ==
X-Received: by 2002:a05:6402:1ed5:b0:64b:7885:c985 with SMTP id 4fb4d7f45d1cf-64b8e93c197mr14856958a12.3.1766496045806;
        Tue, 23 Dec 2025 05:20:45 -0800 (PST)
Received: from sgarzare-redhat ([193.207.125.9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9105a9d8sm13549743a12.11.2025.12.23.05.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:20:44 -0800 (PST)
Date: Tue, 23 Dec 2025 14:20:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: Test setting SO_ZEROCOPY on
 accept()ed socket
Message-ID: <aUqWtwr0n2RO7IB-@sgarzare-redhat>
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-2-4654a75d0f58@rbox.co>
 <aUpualKwJbT9W1ia@sgarzare-redhat>
 <1c877a67-778e-424c-8c23-9e4d799fac2f@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1c877a67-778e-424c-8c23-9e4d799fac2f@rbox.co>

On Tue, Dec 23, 2025 at 12:10:25PM +0100, Michal Luczaj wrote:
>On 12/23/25 11:27, Stefano Garzarella wrote:
>> On Tue, Dec 23, 2025 at 10:15:29AM +0100, Michal Luczaj wrote:
>>> Make sure setsockopt(SOL_SOCKET, SO_ZEROCOPY) on an accept()ed socket is
>>> handled by vsock's implementation.
>>>
>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>> ---
>>> tools/testing/vsock/vsock_test.c | 33 +++++++++++++++++++++++++++++++++
>>> 1 file changed, 33 insertions(+)
>>>
>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>> index 9e1250790f33..8ec8f0844e22 100644
>>> --- a/tools/testing/vsock/vsock_test.c
>>> +++ b/tools/testing/vsock/vsock_test.c
>>> @@ -2192,6 +2192,34 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
>>> 	close(fd);
>>> }
>>>
>>> +static void test_stream_accepted_setsockopt_client(const struct test_opts *opts)
>>> +{
>>> +	int fd;
>>> +
>>> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>> +	if (fd < 0) {
>>> +		perror("connect");
>>> +		exit(EXIT_FAILURE);
>>> +	}
>>> +
>>> +	vsock_wait_remote_close(fd);
>>> +	close(fd);
>>> +}
>>> +
>>> +static void test_stream_accepted_setsockopt_server(const struct test_opts *opts)
>>> +{
>>> +	int fd;
>>> +
>>> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>>> +	if (fd < 0) {
>>> +		perror("accept");
>>> +		exit(EXIT_FAILURE);
>>> +	}
>>> +
>>> +	enable_so_zerocopy_check(fd);
>>
>> This test is passing on my env also without the patch applied.
>>
>> Is that expected?
>
>Oh, no, definitely not. It fails for me:
>36 - SOCK_STREAM accept()ed socket custom setsockopt()...36 - SOCK_STREAM
>accept()ed socket custom setsockopt()...setsockopt err: Operation not
>supported (95)
>setsockopt SO_ZEROCOPY val 1

aaa, right, the server is failing, sorry ;-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
>I have no idea what's going on :)
>

In my suite, I'm checking the client, and if the last test fails only on 
the server, I'm missing it. I'd fix my suite, and maybe also vsock_test 
adding another sync point.

Thanks,
Stefano



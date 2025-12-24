Return-Path: <netdev+bounces-245953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D32FBCDBC5C
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 10:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55FDB3009950
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 09:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003B2330B36;
	Wed, 24 Dec 2025 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bz9fe//q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OY0bHzso"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4087C330B21
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766567786; cv=none; b=Wi3Zkcm7qlobukFCs0AKR5ZnEh/GRs4OvsRVXXYz7Clokq7zUhqAFrksiOZgRgW5qSPWw2H85LgJMra5On+HMhOVML66xZHDHzmaSeYsS1fQ2s/dd7mvn9ogKIfwkbXVsX0LB0HQc835BI7Djsbv5IC8ZtzyPN2nD+fbQyWqv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766567786; c=relaxed/simple;
	bh=W5FPgoGpUmgPhjWL8T1Mrolt+NR9LunlkkjtHM6j/dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMzV7734zG/UDkqLHOJmrYxOhPJljbZ0xE4jwbNfOleN7WCM7B2b5RgSZDXVtmwxgh808y4wYyyDiVWIsr8KRYnl/x+hkLwBR3CYnEKgfilM2E2c6NsPDIGoV+Tv0pRYk1wWb+qr8BtaQKc9zrrAI2Gn1VlqnsIpFHXNOCs8X/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bz9fe//q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OY0bHzso; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766567781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TG9qFMYYZ4oH8GV5uabpqY3JSsJR+DkIvS2mHVZ4zRo=;
	b=bz9fe//qYTWbpmllI4vQrIzc2P+mKeHgcnDdJdGLvbp3gkJbCKCdmfqeZT9lsNV+dPTUDN
	uwCWHU0VndWzfokrzOJrRgjuL6odF9O8ZNHMzwB74e49Rzn/m2ZB1skimd/JzkaZAHXrgX
	Mt9yibscDzSKzxSVXdUOsPLZ2gBblT0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-zv-BgA5BMgSpACiLy3Q54w-1; Wed, 24 Dec 2025 04:16:19 -0500
X-MC-Unique: zv-BgA5BMgSpACiLy3Q54w-1
X-Mimecast-MFC-AGG-ID: zv-BgA5BMgSpACiLy3Q54w_1766567779
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b802843b0bbso237199366b.3
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 01:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766567778; x=1767172578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TG9qFMYYZ4oH8GV5uabpqY3JSsJR+DkIvS2mHVZ4zRo=;
        b=OY0bHzsoISnZV4y0jlNSHyBT3pdxUKDH18bjBQU0f9720/S8PMz5vFTWVWJK/gho/v
         Jqo8pr+G6Eryb9U/8LGV9rAnqcRTQEchpfOOyt0uDrg0SmB1x+vMUxE9ATJJQJvCFECZ
         zb1M3WxNVJJbHsM895UhbvlxQWfU1J9Hd4L7zFtdxoDF/+tcE3O1BX+wsP3bq+1nVNMI
         5AoOyZXUC6MvtH6KCCXi+KJG4MnysavsyvGV6rQkgvP+52CeIjXpKh+pra+TwLotyA2I
         OmkmUHZVZ8OMZJJJjrme8ZH+DwmbpdAFvv9SFIvjHs1ig5R+IJztMsfuQAQhwCEnT3cV
         ij+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766567778; x=1767172578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG9qFMYYZ4oH8GV5uabpqY3JSsJR+DkIvS2mHVZ4zRo=;
        b=kalw41yqj0i/ATJmrfKqE66jZERmFo2qRfIgPetPsjBc7jW9f7CgBQOtY6tMDuHNNJ
         p3Uzy9b6Wg38l+U7ERaQANiGgM9+IHGpiBxJCbjdPBtJDuihrej9Y2vzXGOzRM6Hier2
         og/WN2PiEZLCATLUt4v5nlGaJqGThfTfK5xKTbBUPhAqs+7iP14dfkZkLnqnI44K8Lkw
         K44wLthg1RWQd/q3mVGHfyNnPXY3SgTMK9JYmok4+U8GfbrwIuANBf3JTlV8Mswh0t94
         yibpjUv0Fq3pcVkYIjBW/oC7lfb7TWdRZSlABluPhHidHi/vwM5bG/o/ejilbdf3MNh7
         726g==
X-Forwarded-Encrypted: i=1; AJvYcCUuJdTW+0LX3CCDb3D8a9WsNZ7b77Gn3j4ThvoIu9xM1bcQWE4iZnqVR6fEFA14Rdv4Eu5vzZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhFR7OgwVaj08u2WsIk/Jt/xPog+mOATtj8i3c1qcD+Ypq8sF
	621VrAkbY9wCA2iEyDvGO68CQ5i3+BlGjU9it3L7icuyMdCL1sMP9By8dnc+XmZshf/4I557i+l
	6bUkWs6RvF7d37LJv3/3NeZpCRRf18dHF9U29XCKq+ud5NK5iQaflE2bLoA==
X-Gm-Gg: AY/fxX6/llI+/Me4p0/rxnHpbur15U3ReaXdK1G03agjEgr+aDjaLS4zToRvDXMcF/W
	3Pc7Bn8eMLn5dRN9hsJ+LuVpnR6ZUNwPbvF/r+wFcj9tWv4M8MrWj/wh6oJm0hYkToIlM5rsnBn
	zK2DCP4xvq/nlSMqt9UHL76P4W+t9Bn+T6TMB8+PlofqswF0ZGyKLvGRfTV7nCjAjrl/SsyACpo
	VKYc4mwY7gPPnbQmEM0HRZXF5bAY+KMa8UZ3PLDeOSzJAOtAuA9UX+0gtWENa9uxf93XStKAh5F
	0oXQ+VRgW997HWx71hO6AqcUeIDrFzqDqRuojIVjV0eagRI4QDjBLhO3KsYaDY74tqfTERjRGXK
	K8+z2UG6rhNWamjuJ
X-Received: by 2002:a17:907:7f1c:b0:b83:976:50f9 with SMTP id a640c23a62f3a-b83097652a7mr168592666b.61.1766567778468;
        Wed, 24 Dec 2025 01:16:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2zROeUVFL1dzpYZqyjYvkN4o8L5fjhHfHOKDDCOidKMgMKBQP5VHD8MGw0Ju06pc+b5i0KA==
X-Received: by 2002:a17:907:7f1c:b0:b83:976:50f9 with SMTP id a640c23a62f3a-b83097652a7mr168590266b.61.1766567777909;
        Wed, 24 Dec 2025 01:16:17 -0800 (PST)
Received: from sgarzare-redhat ([193.207.144.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0cc52sm1685076666b.52.2025.12.24.01.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 01:16:17 -0800 (PST)
Date: Wed, 24 Dec 2025 10:15:52 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vsock/test: Test setting SO_ZEROCOPY on
 accept()ed socket
Message-ID: <aUut_Avq3t_xk0Uh@sgarzare-redhat>
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-2-4654a75d0f58@rbox.co>
 <aUpualKwJbT9W1ia@sgarzare-redhat>
 <1c877a67-778e-424c-8c23-9e4d799fac2f@rbox.co>
 <aUqWtwr0n2RO7IB-@sgarzare-redhat>
 <aUrIDT-Tg5SpXhlO@sgarzare-redhat>
 <8b76f6f8-3f5c-4bea-8084-577712ec028b@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8b76f6f8-3f5c-4bea-8084-577712ec028b@rbox.co>

On Tue, Dec 23, 2025 at 09:38:07PM +0100, Michal Luczaj wrote:
>On 12/23/25 17:50, Stefano Garzarella wrote:
>> On Tue, Dec 23, 2025 at 02:20:33PM +0100, Stefano Garzarella wrote:
>>> On Tue, Dec 23, 2025 at 12:10:25PM +0100, Michal Luczaj wrote:
>>>> On 12/23/25 11:27, Stefano Garzarella wrote:
>>>>> On Tue, Dec 23, 2025 at 10:15:29AM +0100, Michal Luczaj wrote:
>>>>>> Make sure setsockopt(SOL_SOCKET, SO_ZEROCOPY) on an accept()ed socket is
>>>>>> handled by vsock's implementation.
>>>>>>
>>>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>>>> ---
>>>>>> tools/testing/vsock/vsock_test.c | 33 +++++++++++++++++++++++++++++++++
>>>>>> 1 file changed, 33 insertions(+)
>>>>>>
>>>>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>>>>> index 9e1250790f33..8ec8f0844e22 100644
>>>>>> --- a/tools/testing/vsock/vsock_test.c
>>>>>> +++ b/tools/testing/vsock/vsock_test.c
>>>>>> @@ -2192,6 +2192,34 @@ static void test_stream_nolinger_server(const struct test_opts *opts)
>>>>>> 	close(fd);
>>>>>> }
>>>>>>
>>>>>> +static void test_stream_accepted_setsockopt_client(const struct test_opts *opts)
>>>>>> +{
>>>>>> +	int fd;
>>>>>> +
>>>>>> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
>>>>>> +	if (fd < 0) {
>>>>>> +		perror("connect");
>>>>>> +		exit(EXIT_FAILURE);
>>>>>> +	}
>>>>>> +
>>>>>> +	vsock_wait_remote_close(fd);
>>
>> On a second look, why we need to wait the remote close?
>> can we just have a control message?
>
>I think we can. I've used vsock_wait_remote_close() simply as a sync
>primitive. It's one line of code less.
>
>> I'm not sure even on that, I mean why this peer can't close the
>> connection while the other is checking if it's able to set zerocopy?
>
>I was worried that without any sync, client-side close() may race
>server-side accept(), but I've just checked and it doesn't seem to cause
>any issues, at least for the virtio transports.

Okay, I see. Feel free to leave it, but if it's not really needed, I'd 
prefer to keep the tests as simple as possible.

>
>>>>>> +	close(fd);
>>>>>> +}
>>>>>> +
>>>>>> +static void test_stream_accepted_setsockopt_server(const struct test_opts *opts)
>>>>>> +{
>>>>>> +	int fd;
>>>>>> +
>>>>>> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
>>>>>> +	if (fd < 0) {
>>>>>> +		perror("accept");
>>>>>> +		exit(EXIT_FAILURE);
>>>>>> +	}
>>>>>> +
>>>>>> +	enable_so_zerocopy_check(fd);
>>>>>
>>>>> This test is passing on my env also without the patch applied.
>>>>>
>>>>> Is that expected?
>>>>
>>>> Oh, no, definitely not. It fails for me:
>>>> 36 - SOCK_STREAM accept()ed socket custom setsockopt()...36 - SOCK_STREAM
>>>> accept()ed socket custom setsockopt()...setsockopt err: Operation not
>>>> supported (95)
>>>> setsockopt SO_ZEROCOPY val 1
>>>
>>> aaa, right, the server is failing, sorry ;-)
>>>
>>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>
>>>> I have no idea what's going on :)
>>>>
>>>
>>> In my suite, I'm checking the client, and if the last test fails only
>>> on the server, I'm missing it. I'd fix my suite, and maybe also
>>> vsock_test adding another sync point.
>>
>> Added a full barrier here:
>> https://lore.kernel.org/netdev/20251223162210.43976-1-sgarzare@redhat.com
>
>Which reminds me of discussion in
>https://lore.kernel.org/netdev/151bf5fe-c9ca-4244-aa21-8d7b8ff2470f@rbox.co/

Oh, I forgot that we already discussed that.

My first attempt was exactly that, but then discovered that it didn't 
add too much except for the last one since for the others we have 2 full 
barriers back to back, so I preferred to move outside the loop. In that 
way we can also be sure the 2 `vsock_tests` are in sync with the amount 
of tests to run.

But yeah, also that one fix the issue.

>. Sorry for postponing, I've put it on my vsock-cleanups branch and kept
>adding more little fixes, and it was never the right time to post the series.
>

Nah, don't apologize, you're doing an amazing job!

Thanks,
Stefano



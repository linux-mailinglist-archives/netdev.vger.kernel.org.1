Return-Path: <netdev+bounces-187677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EB2AA8D3D
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 09:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441CD3B45BE
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 07:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924DA1D5CD1;
	Mon,  5 May 2025 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aFvdcU6H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD8176AC8
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431007; cv=none; b=BMQXJDuHvsH/68tzJc2zK282ojxgpkQzdas0b4p8Qjmyz4etPsNIMGRiOxlskK9RHDNAF2ytl4EyeFSukvPMU9hix+JNGpbDptCSSP+O/xa1g3J+kcIqVstos5Z3h/R/GH5NIVRrVpqZXuQNb5s+WXPlzv9viCYJijHQQIvjWjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431007; c=relaxed/simple;
	bh=/1L4VXQZnM4TVg9Q0XEcQOC1Z7dwzdgPChSwdWfL7fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNMm3vS4ZShkXOEO4j400VttZBjAtvBq/TK7g9UqUQuFFe9vW1jG6pxiuA46ovS7C6/qig8OcimVmiO2R7NdiwmiiiZg3dYOAwlvpNJRakE/+mKej6ECx0iEVvRkGWHn3U0UZRQFLMVSy62MBCwBXpnggrE2Qf0QSERJWmmFdw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aFvdcU6H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746431004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NYutuEk9tS5pMcj+KQxarlK855jenHaF07JshpvJP/c=;
	b=aFvdcU6HBJ5kwWqI80QeGa/nksKkq3du/L+rgPS8XllBA3KGzaJtIbs+16kvoTZHTRL6ly
	0PSdRYohTI0qQgRMITeHNHHCSS0iLiFErwyXmTaMIFxUzpOLSEJAWXab6ifNkc1KeSGbC6
	/jwLce1PS4uj83B+nsSCb8jaZYSovhw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-cSuaWo_OPiuOB4pyGi5O1A-1; Mon, 05 May 2025 03:43:23 -0400
X-MC-Unique: cSuaWo_OPiuOB4pyGi5O1A-1
X-Mimecast-MFC-AGG-ID: cSuaWo_OPiuOB4pyGi5O1A_1746431002
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30c4cbc324bso20505141fa.1
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 00:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746431002; x=1747035802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYutuEk9tS5pMcj+KQxarlK855jenHaF07JshpvJP/c=;
        b=m2/LuUQ0r+xPWSTLcJv1b+ziPRbUVbfTgXJuoSudNAOkt94gUo3cDFNfHSM8+MPuS9
         ZVp3oxJyHaOJwIegApc2MEMNOYRqOTCvzVYCUBrNOacAb7DUrLyJ20ehbIY/knJATFxY
         UrxGfQZGR8a2C9qneY1wKOXK2LIUUb8iaFzwt8G6ate5MjwjH5TZGYEvRDHyOBoI1dpL
         9YUI2k6piHKYbuFc6sE34BsJsFZdK/R+/N7GicJbt6DNDvE2ivXY1VOXc2z9jLSzEoPe
         Ubjn6CN6DtiOy6CiusvPRO4RxWJ0agWrnbh/BN3leVdcAij/Av9Zrlv2pU8aghIYmjg4
         SamQ==
X-Gm-Message-State: AOJu0YyBCBFV7MzWCopoz7Uwl9dGjV87zRc0aOlY5s8MFKL74o2+CtIv
	kKb7qtqv0TDwB2gkOPM/RA+wgemTB9v/tA41VCKhWCvDJQzI0/3+/Ofe04hFTsrlEUgJDz5ncyQ
	hV6jcGrEEjvf+0FaQrC5GS6u5qvKpFbGb7g55JL033UtUHPg8XDj3a8gkHs1/YoA99Zc=
X-Gm-Gg: ASbGncstB1WLmq20QfEwSOUWpOCf4GHdJEWUCdAStLIyJR1aLrSPiG3ofobaTkJV/YN
	a5BpK3QamHXnMTPa7I5XLshQi3OKdksgnpPWW7sMN+mQqyF2dNMbE2cus9vEjxMaTlHFdyU/c2+
	OHNY4QqfZCEPCNlpCruo9kl6WwPHhC/UZq2sYiV+lKm7RoYsNNLGJhXoGcM4S0RQe4at8a3GWxL
	ENHJYWGPmSvzyHWkS1sxx3amKYOzWEpYNQkw/4JlX8dX5emNAQvLivk2GgKJbRHKiUbQ/AWXJ0k
	x2/rZaFfSHWLWGKS6J2cSkIKU8rzBMNL5v8x+PEAKz4/7E7E+mcbouudq50=
X-Received: by 2002:a05:6512:a87:b0:549:38d2:f630 with SMTP id 2adb3069b0e04-54f9efd2c99mr1456238e87.24.1746431001781;
        Mon, 05 May 2025 00:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsEsHgZOcmzKyEYKe53zgGMeSaMF3WinuQkv4wSGTWsyP+GpxlPUt85uINmh0HuIcOZYrSLQ==
X-Received: by 2002:a05:600c:1e09:b0:43c:f895:cb4e with SMTP id 5b1f17b1804b1-441cb49494cmr15680615e9.17.1746430567130;
        Mon, 05 May 2025 00:36:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010:b099:aac6:4e70:6198? ([2a0d:3344:2706:e010:b099:aac6:4e70:6198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b391c42bsm162401715e9.39.2025.05.05.00.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 00:36:06 -0700 (PDT)
Message-ID: <8cdf120d-a0f0-4dcc-a8f9-cea967ce6e7b@redhat.com>
Date: Mon, 5 May 2025 09:36:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 4/9] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, io-uring@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250429032645.363766-1-almasrymina@google.com>
 <20250429032645.363766-5-almasrymina@google.com>
 <53433089-7beb-46cf-ae8a-6c58cd909e31@redhat.com>
 <CAHS8izMefrkHf9WXerrOY4Wo8U2KmxSVkgY+4JB+6iDuoCZ3WQ@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAHS8izMefrkHf9WXerrOY4Wo8U2KmxSVkgY+4JB+6iDuoCZ3WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/2/25 9:20 PM, Mina Almasry wrote:
> On Fri, May 2, 2025 at 4:47 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>> @@ -1078,7 +1092,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>>>                               zc = MSG_ZEROCOPY;
>>>               } else if (sock_flag(sk, SOCK_ZEROCOPY)) {
>>>                       skb = tcp_write_queue_tail(sk);
>>> -                     uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb));
>>> +                     uarg = msg_zerocopy_realloc(sk, size, skb_zcopy(skb),
>>> +                                                 sockc_valid && !!sockc.dmabuf_id);
>>
>> If sock_cmsg_send() failed and the user did not provide a dmabuf_id,
>> memory accounting will be incorrect.
> 
> Forgive me but I don't see it. sockc_valid will be false, so
> msg_zerocopy_realloc will do the normal MSG_ZEROCOPY accounting. Then
> below whech check sockc_valid in place of where we did the
> sock_cmsg_send before, and goto err. I assume the goto err should undo
> the memory accounting in the new code as in the old code. Can you
> elaborate on the bug you see?

Uhm, I think I misread the condition used for msg_zerocopy_realloc()
last argument.

Re-reading it now it the problem I see is that if sock_cmsg_send() fails
after correctly setting 'dmabuf_id', msg_zerocopy_realloc() will account
the dmabuf memory, which looks unexpected.

Somewhat related, I don't see any change to the msg_zerocopy/ubuf
complete/cleanup path(s): what will happen to the devmem ubuf memory at
uarg->complete() time? It looks like it will go unexpectedly through
mm_unaccount_pinned_pages()???

Thanks,

Paolo



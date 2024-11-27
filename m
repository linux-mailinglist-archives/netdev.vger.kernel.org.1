Return-Path: <netdev+bounces-147561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0759DA356
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 08:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39001B21671
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 07:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC2E156F54;
	Wed, 27 Nov 2024 07:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnYCtp/p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F4518D63C
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732693590; cv=none; b=qcxG/Tm8vpmolFAJtMCRLQJNZGvO6owpFrEk0fxqUZ75YpiuLI2XqqoADNYkLt5hWuQDRYst4VcwPOflGc1I8YRk28BIgN5lBKOMnoFCVtNUZGSkDl87PIGxaip0gUc078f3HqTCQBA+QoS49P13k9iu+lbaa8lW0a6qOrqMPrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732693590; c=relaxed/simple;
	bh=4/yXwKY6nG5+HhZPf7lYUj4gAUD18OtQWnuzyKtJZmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFdH/2AvnzNDGu6u8QP1/Msh44kKEzgNVt971FagVRvvFb5W9UEzuKoFgKxcgClR16PJwBoqXVDz5Go01zSzZv6sZ35I1ZxPrDlLhrTIorqhSe+f+M08MGP9KUSqcYEvFigs1/J264OiDzU0mGKZ+HMmMoNYSVhOoEbDZqr/MfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnYCtp/p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732693587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GK+3G3kO0VycIHGio9DvkBxIF2tO2AzV2JADeZzp4jw=;
	b=JnYCtp/pZmOmftyV0kB8eqeItPx1kSfhPDphkTGO3R36d9gUIaX9aGvp2YPJt5wgMGmWB3
	pJ/jT9HWATvcOOWcE90yOREv8b+xLpeQ5ASmgvHIPzJfC4szfXjEfWPyWKjG7cP/Df88I1
	yR7N93RmHeqNy9Faq/L0RZP2r35MPEU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-iQ4iLyDkMI650gwSy6RhCQ-1; Wed, 27 Nov 2024 02:46:25 -0500
X-MC-Unique: iQ4iLyDkMI650gwSy6RhCQ-1
X-Mimecast-MFC-AGG-ID: iQ4iLyDkMI650gwSy6RhCQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38242a78f3eso3360934f8f.0
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 23:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732693584; x=1733298384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GK+3G3kO0VycIHGio9DvkBxIF2tO2AzV2JADeZzp4jw=;
        b=fIK9kXTGtK4vTm5O55lrjt0RGnDoXOWVD5UgKhj2zsOMFNk9But3iXQScs/57/V6Oj
         bXa5bcNDowEyQxycHGePQUc45kU2xkO48J+S7PbleDe5Rv8NXGNqKdSxvk2FsXoBYGRE
         9YxlM7smZts+8kVQTpnju4EXpoi5nFho5PD5/fXUDGqCOc84xxcQ9rSKnzBoGZyd2kbG
         OwOC0K6aXcGsqPeJN7AaPjkT9tBjSaNj1rz+SBZrOsH1SynEDQTjzyAC38Nd0JofL/jS
         7CLPA47W1vu0wYkOw8hoSr+KAanW/DhZeDocu5TpFZADScgdDRyHme8ZUuCVZdVNukYe
         QNtw==
X-Gm-Message-State: AOJu0YyTiuLlCJzYlaqUDKN11BeSh91oFY+gVXf9W8Njpfty5hcN02fB
	LsTdDJJT58zuqYyNRUEQlcCZNwWVVHrnAo04UUYxwE6VAov+uKOi4QJIoPnrXIISz17aFEN96x0
	e33+ShgT51pRFot13ibrEhMt0eFQifsi7E0S/vVI6gxvfAWCYI6lsZw==
X-Gm-Gg: ASbGncvgLvB5rt2r0fDUfCNkcUdK5OFAgJBkWRg15yUT050C67RACinptpg66cwX6fp
	BPf9vcAVGLBBzOveHN+afXeRskg2bIfFExUvUj+LOWEkWPIoQE/XNeZM0kw4oBh6Qe5ruEeDrND
	6y+toB9D8anxst0oizdgya04sbqLkElDUrohCogu1VA7725Mpn5dAZzRImU78SmgR5vcaIcJmU1
	jhRkg94PDuQqtyEYTUoX8HgkSUE/CTGzaaPFXUj3xzQYvANQ/zW1EOyXpjjO1i9NIIu6Q+yf8Qd
	hgE=
X-Received: by 2002:a05:6000:1aca:b0:382:397f:3df5 with SMTP id ffacd0b85a97d-385c6edd4fcmr1334546f8f.38.1732693584520;
        Tue, 26 Nov 2024 23:46:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSgs8I9raBPC/ec0+MexPGRBtWsZQCpKG9JWoNGJiKxPWOnS5ouGX5aC+JU9uJwI0cwOtNTw==
X-Received: by 2002:a05:6000:1aca:b0:382:397f:3df5 with SMTP id ffacd0b85a97d-385c6edd4fcmr1334523f8f.38.1732693583986;
        Tue, 26 Nov 2024 23:46:23 -0800 (PST)
Received: from [192.168.88.24] (146-241-49-128.dyn.eolo.it. [146.241.49.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbedce3sm15470212f8f.97.2024.11.26.23.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 23:46:23 -0800 (PST)
Message-ID: <411eb4ba-3226-44f2-aabe-5d68df01f867@redhat.com>
Date: Wed, 27 Nov 2024 08:46:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] udp: call sock_def_readable() if socket is not
 SOCK_FASYNC
To: Eric Dumazet <edumazet@google.com>,
 Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc: netdev@vger.kernel.org, willemb@google.com
References: <20241126175402.1506-1-ffmancera@riseup.net>
 <CANn89iJ7NLR4vSqjSb9gpKxfZ2jPJS+jv_H1Qqs1Qz0DZZC=ug@mail.gmail.com>
 <CANn89i+651SOZDegASE2XQ7BViBdS=gdGPuNs=69SBS7SuKitg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89i+651SOZDegASE2XQ7BViBdS=gdGPuNs=69SBS7SuKitg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I'm sorry for the latency here.

On 11/26/24 19:41, Eric Dumazet wrote:
> On Tue, Nov 26, 2024 at 7:32 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Tue, Nov 26, 2024 at 6:56 PM Fernando Fernandez Mancera
>> <ffmancera@riseup.net> wrote:
>>>
>>> If a socket is not SOCK_FASYNC, sock_def_readable() needs to be called
>>> even if receive queue was not empty. Otherwise, if several threads are
>>> listening on the same socket with blocking recvfrom() calls they might
>>> hang waiting for data to be received.
>>>
>>
>> SOCK_FASYNC seems completely orthogonal to the issue.
>>
>> First sock_def_readable() should wakeup all threads, I wonder what is happening.
> 
> Oh well, __skb_wait_for_more_packets() is using
> prepare_to_wait_exclusive(), so in this case sock_def_readable() is
> waking only one thread.

Very likely whatever I'll add here will be of little use, still...

AFAICS prepare_to_wait_exclusive() is there since pre git times, so its
usage not be the cause of behaviors changes.

>> UDP can store incoming packets into sk->sk_receive_queue and
>> udp_sk(sk)->reader_queue
>>
>> Paolo, should __skb_wait_for_more_packets() for UDP socket look at both queues ?

That in case multiple threads are woken-up and thread-1 splices
sk_receive_queue into reader_queue before thread-2 has any chance of
checking the first, I guess?

With prepare_to_wait_exclusive, checking a single queue should be ok.

/P



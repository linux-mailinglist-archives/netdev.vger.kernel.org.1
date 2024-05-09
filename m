Return-Path: <netdev+bounces-94835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9EB8C0D44
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2122C28236B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6489014A4D0;
	Thu,  9 May 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCgvOjUs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97D13C9B6
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 09:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245968; cv=none; b=MkmXCS3zSGssQF/CVBoS7tQZw9oU+FUOTl5MnrculGw0OtQl4c7mrWzVecMqSr7Ea+a2u8s19qimg1b5fH04rw+sHn1c3JMLfnamxZTAFCBq1ZPzW+zIAO6Pz8ZkC5nZuCjR5U+sidXWYfn05VrTRRMabHdnvGhgQzNZEUcDuMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245968; c=relaxed/simple;
	bh=AUcqDkSoIxW0xMPVjkYLuzP9jW8b2edE2YkWIA5Q6hU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qo3DwPUKIF4kTB/qEXo5FSuxVJjNRNRD/TMbJY5Pzr+2OUSwvz5m95kSRXdMjKR66xK2s2FUVSqBrYYz7qKgV3vQig47aurOy7NVDfpJ3r+X7dyckvkRSN3UfnTykGfZiLpXMfd9E2N0t5TC/7WOrOdl2DGGQQJb3ZmLK2GNvhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCgvOjUs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715245965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AUcqDkSoIxW0xMPVjkYLuzP9jW8b2edE2YkWIA5Q6hU=;
	b=TCgvOjUslqLnBcg8P9lgvR3QjJKmPLyRu/BnKwBxL1nvyOQ2l5/6zAMkh/Mvw4bGx9q+aL
	O+ghKxAKqJfB5t+bMwWPAU1dm/hRNEWhYax8bSSBGoxsayqLsqusMo0m/QMOFRPAtWeg6E
	6iKL1CRGh8VIR3yn7a/BPm3kg0QKu7w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-VhXIme6vOreQ0rtUoLySWQ-1; Thu, 09 May 2024 05:12:44 -0400
X-MC-Unique: VhXIme6vOreQ0rtUoLySWQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34d92c4cdd9so96438f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 02:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715245963; x=1715850763;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUcqDkSoIxW0xMPVjkYLuzP9jW8b2edE2YkWIA5Q6hU=;
        b=E46rQT65/fSyPNjuuqWYTyAkVLtgvLJutQab8igvgIIPjP4QJIgkM0oDPhKcp5aD7V
         tYpjwHbWCB1GZ4bqFlKjKmpGndDyvTNCbliwjhDZDCek1Y69DNqJsj5Oj8F9uQsjM4sq
         qUDzQVcJohGkFdPQxJxwBWFgey3xC0UZmjlrRrwVA4+zjqBtMMVZ5EA+3QNMqvEB3mN6
         Gguqq0RozZaLkppXt9uaSvUVRHymHMFcKMs6DjZWnbDNnz2F/E1F9G/KGguaEXF4zvh/
         OnhY5s1XBlMOJfMVCXL5SDozrMdsYBCcTSpfyjLeD7URjFG1DeKaMcli8Ke2HJim/4xu
         QcSA==
X-Forwarded-Encrypted: i=1; AJvYcCVLjac82Z1zt9EfMBdiMW6XJ5oPmLDBSulqsjYSzr/KsSInijN1Qe0v/OZqfqgGNhLj2PN+WHFNOrv9EvQQPI4BIBuXRWSo
X-Gm-Message-State: AOJu0YzKRUQv4qbI/DV27rdIxUeMUZQqESuySPIWxGo2Pc8JeIw00glf
	5UwxIOFH2YSlr8WhLtwhJPhjw+aLBXRAJEHPcfMRyQ6yhPxpd6jGpbkoAD4TWtre+/rIr2PORaF
	wcgbTNTYWDPKb2k6msw+ktXRNyM4dqssPEMcbnPPuAQsfRgoDqmD3bg==
X-Received: by 2002:adf:ee4b:0:b0:34b:5cef:4af3 with SMTP id ffacd0b85a97d-34fcb3ab472mr3198966f8f.6.1715245963197;
        Thu, 09 May 2024 02:12:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUyQMcpToy2perJt5PsX1YIvcgQz7UiYd9V9PHRqkLiNc18nfvczuelwZqpw7c4PALT3h3/w==
X-Received: by 2002:adf:ee4b:0:b0:34b:5cef:4af3 with SMTP id ffacd0b85a97d-34fcb3ab472mr3198957f8f.6.1715245962816;
        Thu, 09 May 2024 02:12:42 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b68:1b10:ff61:41fd:2ae4:da3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacfdesm1150627f8f.73.2024.05.09.02.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 02:12:42 -0700 (PDT)
Message-ID: <8015f2f2fec7d5a5a7164e1480d0e0c18b925f61.camel@redhat.com>
Subject: Re: [PATCH v1 net] af_unix: Update unix_sk(sk)->oob_skb under
 sk_receive_queue lock.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, Billy
	Jheng Bing-Jhong
	 <billy@starlabs.sg>
Date: Thu, 09 May 2024 11:12:38 +0200
In-Reply-To: <20240507170018.83385-1-kuniyu@amazon.com>
References: <20240507170018.83385-1-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-07 at 10:00 -0700, Kuniyuki Iwashima wrote:
> Billy Jheng Bing-Jhong reported a race between __unix_gc() and
> queue_oob().
>=20
> __unix_gc() tries to garbage-collect close()d inflight sockets,
> and then if the socket has MSG_OOB in unix_sk(sk)->oob_skb, GC
> will drop the reference and set NULL to it locklessly.
>=20
> However, the peer socket still can send MSG_OOB message to the
> GC candidate and queue_oob() can update unix_sk(sk)->oob_skb
> concurrently, resulting in NULL pointer dereference. [0]
>=20
> To avoid the race, let's update unix_sk(sk)->oob_skb under the
> sk_receive_queue's lock.

I'm sorry to delay this fix but...

AFAICS every time AF_UNIX touches the ooo_skb, it's under the receiver
unix_state_lock. The only exception is __unix_gc. What about just
acquiring such lock there?=20

Otherwise there are other chunk touching the ooo_skb is touched where
this patch does not add the receive queue spin lock protection e.g. in
unix_stream_recv_urg(), making the code a bit inconsistent.

Thanks

Paolo



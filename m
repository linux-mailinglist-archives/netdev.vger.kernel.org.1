Return-Path: <netdev+bounces-146604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E189D4876
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708DE1F2232D
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9FC1C7610;
	Thu, 21 Nov 2024 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RV0/yHyE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA75117741
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176501; cv=none; b=TJR/6TiNICFJr+9IlvgnyHeP5mdxSzuDqJWMEv8JsO1aPFioPEbUlwUKD+uC4p4M2io2XQh37eg8eqkCED42ME5ZCDoENGJSmNxa/pDPcmX0X0oxeP3j1w2okHhp5MSJ5lY7FKCYkEH12gfseqKiLPMrqbkhfiZsMsDfq2znP3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176501; c=relaxed/simple;
	bh=tT7YBJNorA78NtW+h2g6Bp30Fo2ROMFtaucoSo7S5Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2ojC7HF4hl7XVXqm37fHpPgA9KysHWLb236UXHq2K0hKaUwe3Opz1ojfriefHJVAndgiOovpLkQdGnbusPqwpr+nbjtmJmdtCKFuRNzepXXAkRQEWtL0gHyB79qfLlsYjFynpqeFkJ40EyxIIEUefDHJ7YckAOgre9Hzoptuo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RV0/yHyE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732176499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OiLOQpixEQH0kTmOgak1nkUr3AduAJzONuvMstNuPig=;
	b=RV0/yHyElrVEQ3ll0M6XVQ2X3PjTJZQrYo6fPLQdoqXEGN6H89/bA58kfXpoHVu7F5uHac
	3eUXLTy+P4W7w37DRbFSlCTzklB9C1CB7j8qh1B873HUaQqDPlDPdZYC6W2I6arnHpQam9
	davK7aZChngc8MNVQoXK1ZKKb4GBYrY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-9NC3a5jIOgmD-_unsQKxew-1; Thu, 21 Nov 2024 03:08:17 -0500
X-MC-Unique: 9NC3a5jIOgmD-_unsQKxew-1
X-Mimecast-MFC-AGG-ID: 9NC3a5jIOgmD-_unsQKxew
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a1be34c68so45542266b.1
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 00:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732176496; x=1732781296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiLOQpixEQH0kTmOgak1nkUr3AduAJzONuvMstNuPig=;
        b=ehZCo61d7rVJ5n7t8rtryqQf48BYqLL/dFTziAIkXVRsWxk8Ah4/rRHnFE2Z3YUETT
         OWjuQQrM2fxhjHDxhwlB+w+VGC/FdlVamKzfs5Hnl8z6/h6ht6+rn1u3D+iiF6SG7q02
         F+1ZLh/axiHMmU6pF6TaVn1A6m54s18A6gISUn6EjuzeJUumUpwtYViVkel0LyHFeL6J
         t3nQq+OH2MBz84Yy0y/BB9csTP/H7WgP+a1qE8B1Qy8tkY2F7lDnp7kfNgZ4qXG/G7Cd
         O+Jzy4l04ILdcQ6S3hjOmRc/Rmh9+QDbEs4vx1w/5qvX+bnnqJDRLfIcdroWRqj1Igi4
         qxqw==
X-Forwarded-Encrypted: i=1; AJvYcCUCKXIbnMYZI6L+mHKLmVifLSWP5Re4S97OvTKa5eFgm4g4rfJLQ/wRd2U7rQqgWN5ZAhaDTlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywYMmnuDbjImPkCWnA4bbaqO9qbglj1GahNnOG7DjjPpGprvZC
	Ciz9gkDRsFt1w0k+cIc+l+AAHH6InrQcZXHNKxtOrfhjzUVvgXtm1fs8HMdR6pqj60KEYGb1vB0
	1MkjY90mpoFKY6mZcw9mtNVLZ5r5+/N69tQFatW/6tgZXKwmIZPdO2A==
X-Received: by 2002:a17:907:9281:b0:a9a:29a9:70bb with SMTP id a640c23a62f3a-aa4dd55f301mr584434166b.14.1732176496206;
        Thu, 21 Nov 2024 00:08:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLV8GtgiUmwTWOW4ibJlykXJcnoVzc7grG0b7K1GLmAjXqBnc3tKQZzmq3ICbt0FpI7LwCyw==
X-Received: by 2002:a17:907:9281:b0:a9a:29a9:70bb with SMTP id a640c23a62f3a-aa4dd55f301mr584429666b.14.1732176495606;
        Thu, 21 Nov 2024 00:08:15 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f41530e9sm50378566b.39.2024.11.21.00.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:08:15 -0800 (PST)
Date: Thu, 21 Nov 2024 09:08:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Michal Luczaj <mhal@rbox.co>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 0/4] bpf, vsock: Fix poll() and close()
Message-ID: <dpt2h73fnzgzufuvilmaw5lbs2nydc3572xqn4yoicateys6cb@reuefsarvhka>
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
 <673ed7b929dbe_157a2089e@john.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <673ed7b929dbe_157a2089e@john.notmuch>

On Wed, Nov 20, 2024 at 10:48:25PM -0800, John Fastabend wrote:
>Michal Luczaj wrote:
>> Two small fixes for vsock: poll() missing a queue check, and close() not
>> invoking sockmap cleanup.
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> Michal Luczaj (4):
>>       bpf, vsock: Fix poll() missing a queue
>>       selftest/bpf: Add test for af_vsock poll()
>>       bpf, vsock: Invoke proto::close on close()
>>       selftest/bpf: Add test for vsock removal from sockmap on close()
>>
>>  net/vmw_vsock/af_vsock.c                           | 70 ++++++++++++--------
>>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 77 ++++++++++++++++++++++
>>  2 files changed, 120 insertions(+), 27 deletions(-)
>> ---
>> base-commit: 6c4139b0f19b7397286897caee379f8321e78272
>> change-id: 20241118-vsock-bpf-poll-close-64f432e682ec
>>
>> Best regards,
>> --
>> Michal Luczaj <mhal@rbox.co>
>>
>
>LGTM, would be nice to get an ack from someone on the vsock side
>though.

Sorry, is at the top of my list but other urgent things have come up.

I will review it by today.

Stefano

>
>Acked-by: John Fastabend <john.fastabend@gmail.com>
>



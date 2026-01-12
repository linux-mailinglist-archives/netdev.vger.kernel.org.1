Return-Path: <netdev+bounces-249105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B56D142DC
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 17:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D96C3045F7F
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D34E36C0C5;
	Mon, 12 Jan 2026 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJ48rsk3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgZOeLUd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240734DB7D
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236561; cv=none; b=GdlPk4PqoH23Sy7AMI8sQoqYvu+W6unJ6ERQKoflEFz7AgnmYEbWrUMBnc1uAJgPQF/2JxZK8cSisxLlFX2NmDLjA7nw19Vy4GgluPF50Ne+OeyLc22I4QF3ZNvUlS1EsGKiFdg5jP0Kj8fpSzJybIYXKXqUXC8k5vDYe0U4LoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236561; c=relaxed/simple;
	bh=rSpDYYDAlrC2qkyCkQQP9wvtpup8H0/216lHMC+q/jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htINZNS+vFS6gdmffWKgY7TDk8kZnH6WLUnFvaoCZXsqFLWHkC62renHxyYDcDiTlx8v/qNtJgAOm0LXJm7Ons8hfPkDoKfL0mUPotIBiEzil6kP+/Q5Z5n6l1tAx90inRXEjIg5sr0et+eXlr9Tb9YoLpFJFdV/3xy4G3+Gnm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJ48rsk3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YgZOeLUd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768236556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7/pAFr0/aoSxJfBcAQjHBP8K9Jsu2l/1rwtc+O6U0sw=;
	b=NJ48rsk37dinjAX9SPmy9XpXWJ5EfXk6r4v5+LW9FMOzT7LAjQcdcCW6OmHE2lfdw2OkkL
	CJRBWolCnGK6STVD0jXAm2oziG/ItRvFclY2X8MtRxZFL0IQZ6f/fe/1ZaXu/2yAlVp6WR
	SI6QR3a0lw4oxhIEnM12rv8Bg+qEkJY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-ZwL9mdGGOhO-DbpOwglilQ-1; Mon, 12 Jan 2026 11:49:15 -0500
X-MC-Unique: ZwL9mdGGOhO-DbpOwglilQ-1
X-Mimecast-MFC-AGG-ID: ZwL9mdGGOhO-DbpOwglilQ_1768236554
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477771366cbso51431125e9.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 08:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768236551; x=1768841351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7/pAFr0/aoSxJfBcAQjHBP8K9Jsu2l/1rwtc+O6U0sw=;
        b=YgZOeLUdV3qfhMEqiDu8okLFTjc37c9d2amQ6hvc5TtmHWm3IiRKtiQK4IrQubkGut
         NwIlHPOFDekx8lrt6c1oi4Y1bKjlgKifpA/mvUGdWgwzyKVgFXMXspmdMFiJw7m963uy
         lApWF1okdig11IInab5cMoSAM0YJqi52Tw/cn6sSvdMFxGXkqm5QMNXWLQftVnyjrPgO
         olvE17ccMfcmuEaDXUY22A4gNp7SlPr0mCM0LyH56SzTJOC1LpH9LscZPKmtM0UXMssT
         cOK063RbiSTO7CI0HnyCki3HWLZ03EOH/cfmEIqkuUfmeV1s+6lEjHgLWthXUpPVvr8P
         w4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768236551; x=1768841351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/pAFr0/aoSxJfBcAQjHBP8K9Jsu2l/1rwtc+O6U0sw=;
        b=k4PspQ34gB2ASF5RteuQv46fJUKNWbMwGxZntQXZA0aapA5DPZK1SH44qzDUWA78Lt
         y3+BwuhJvLlj9QYp1k9LvGnhgiKfzk/RW06RZPWECVcEyPv0Rga1cwNF80KRGIfH3wQL
         k+R6ca93lft9S/ovugmd/rvGX3ghirl82yvPNMHACGdLPhyhba5upKeABLqyyncq5dRg
         bdCv9M0B1leketdWQQS1m+WQx4xW512Y3t2j1FH+r7cuLDn05Lx3u2YrcCsioWGEMwxH
         dp+E7k/wXGVyAKoyxL6S7PN4c//Y5Dicg9u/BsemG8JTHewDKk7jVErHaKaQujoARM/a
         4kzA==
X-Forwarded-Encrypted: i=1; AJvYcCVEx59GCT8zchQLo+H6nWFttJpgOZ5Vbo2eszH4GgPccgRxTlXqZsx3xFhLc5CuIOPwIwy5ajQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCKWCr3QzHC6POU7+EjKsrzbr09gFK6+kH2n9G5LkcuZmgCazV
	JboUNx6HsHWzq/Qzcse067Ckk6FH+DOVDPdjxWNPylJ006lLevVljoGJRhXX+f6rn0DiCmCrMrI
	XY6OImbp4/ZidjWhiqp91QIfCMzlIqidWSQQK7k5ooEnLllH2AkKCN34BAA==
X-Gm-Gg: AY/fxX5IjopSWEKs+gqS+6bdmzGNn3V3CDyGYksHeHDMWGuwPaYmXaUg1azEsjRBmAr
	wrUs+zH/jOEc7om9rPwrxNZZq/kK4BEby/7b2GF2J7SzX/9iyYgHYLN9/0oC6h5tFW2g9TUZXE2
	8B4JOMdAQZBzCpVJHtQNB6NC8k1s3fk2f0mOTEGYoD35Un1UqLOkj21D9Md1fYjAleqz0KVN4+Y
	iNyOyMRQmIjHpKoYWfpu4HFS4XmVar5eBF8hkOLPR/n/FcDDVK6Hw78N03nKZBLy4mHzDZ1gr6/
	t8Ig8zHeEXpKC+DMcyfBHAMpPdtnDtWtOKC7NsimK9wS3peM5QaEOkW2LqUQpeNCkL3F2p9K9sh
	waAhq2CDrFXNOp4zjLOsyaXpBo8BUgx6UBk2PMBY7C4YHkBw7ZQnajD8XdIYxzA==
X-Received: by 2002:a05:600c:1991:b0:477:55c9:c3ea with SMTP id 5b1f17b1804b1-47d84b40aa4mr239691945e9.35.1768236550747;
        Mon, 12 Jan 2026 08:49:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbfHpDO7Px43Be+w7n1YsI5iuj6cCFBAlIOAFZDgERsn4SYfumZjikc9aia43Emr8rvTaF4g==
X-Received: by 2002:a05:600c:1991:b0:477:55c9:c3ea with SMTP id 5b1f17b1804b1-47d84b40aa4mr239691475e9.35.1768236550199;
        Mon, 12 Jan 2026 08:49:10 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8718b1a6sm133003075e9.13.2026.01.12.08.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:49:09 -0800 (PST)
Date: Mon, 12 Jan 2026 17:48:56 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vsock/test: Add test for a linear and non-linear skb
 getting coalesced
Message-ID: <aWUk0axv-GZu7VD2@sgarzare-redhat>
References: <20260108-vsock-recv-coalescence-v1-0-26f97bb9a99b@rbox.co>
 <20260108-vsock-recv-coalescence-v1-2-26f97bb9a99b@rbox.co>
 <aWEqjjE1vb_t35lQ@sgarzare-redhat>
 <76ca0c9f-dcda-4a53-ac1f-c5c28d1ecf44@rbox.co>
 <aWT6EH8oWpw-ADtm@sgarzare-redhat>
 <080d7ae8-e184-4af8-bd72-765bb30b63a5@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <080d7ae8-e184-4af8-bd72-765bb30b63a5@rbox.co>

On Mon, Jan 12, 2026 at 04:52:02PM +0100, Michal Luczaj wrote:
>On 1/12/26 14:44, Stefano Garzarella wrote:
>> On Sun, Jan 11, 2026 at 11:59:54AM +0100, Michal Luczaj wrote:
>>>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>>>> index bbe3723babdc..21c8616100f1 100644
>>>>> --- a/tools/testing/vsock/vsock_test.c
>>>>> +++ b/tools/testing/vsock/vsock_test.c
>>>>> @@ -2403,6 +2403,11 @@ static struct test_case test_cases[] = {
>>>>> 		.run_client = test_stream_accepted_setsockopt_client,
>>>>> 		.run_server = test_stream_accepted_setsockopt_server,
>>>>> 	},
>>>>> +	{
>>>>> +		.name = "SOCK_STREAM MSG_ZEROCOPY coalescence corruption",
>>>>
>>>> This is essentially a regression test for virtio transport, so I'd add
>>>> virtio in the test name.
>>>
>>> Isn't virtio transport unaffected? It's about loopback transport (that
>>> shares common code with virtio transport).
>>
>> Why virtio transport is not affected?
>
>With the usual caveat that I may be completely missing something, aren't
>all virtio-transport's rx skbs linear? See virtio_vsock_alloc_linear_skb()
>in virtio_vsock_rx_fill().
>

True, but what about drivers/vhost/vsock.c ?

IIUC in vhost_vsock_handle_tx_kick() we call vhost_vsock_alloc_skb(), 
that calls virtio_vsock_alloc_skb() and pass that skb to 
virtio_transport_recv_pkt(). So, it's also affected right?

BTW in general we consider loopback as one of virtio devices since it 
really shares with them most of the code.

That said, now I'm thinking more about Fixes tag.
Before commit 6693731487a8 ("vsock/virtio: Allocate nonlinear SKBs for 
handling large transmit buffers") was that a real issue?

Thanks,
Stefano



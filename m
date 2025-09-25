Return-Path: <netdev+bounces-226451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE3BA0884
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5285A3B3BB9
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FC4301718;
	Thu, 25 Sep 2025 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnlmm1cS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38BF2E2EF1
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816217; cv=none; b=bJVYUOpVFsPKeJIBl41j5c9Ode3kBkXKPtZOPWHg1UXspleEP1f/4C6dKJwD0CaarTfbqdLyW9XZPi2jmYspqNowNju5tf9WfYI7THswSRqmbZMY2A6kXi/tYilmKaBdWM63dzDqWCUJhDEOG6qiBmCzoiSZUTZyNb2lea327RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816217; c=relaxed/simple;
	bh=HnJd+NrxTuygtcASib599tdU6VkNGVSgK79JCOZW6fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQsjX1mzCb6nLb4Jibo5NTXRdwAnJMA8njr8As3P9bSTFIs/Ns4dK39XhqJAuZSoY79An0LPjkBs5JcCRi2mx4WA06Gm30pSJGn6Py2LvlbfIFG3XRMXAlceOdZ2unidZg9hN3GztoYC+D3GFNWHnc7Wrr6am+vtT2CBQekBT10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnlmm1cS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758816214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAAu2rvXua1onNC9vVWcLt9JR4YNW3IhkSLkwQw3+yc=;
	b=gnlmm1cSQBqMqIBpnkIJgchJNvQpM293H2fW45i86W6I6RsK3Qgd71BJ4a3L8w4CFDxruc
	4ZnfPmgYwZGweQ5KPY1Qv+qj0uXkVtQQDycCEp2UjiR8krt7/BTNqFbcFIpmZoWGOAeGgW
	iT+Xe4kfyG4v3jhBCMV5JuwctMHPI78=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-JQRYqmNhNSSpl5WkSVX2QA-1; Thu, 25 Sep 2025 12:03:31 -0400
X-MC-Unique: JQRYqmNhNSSpl5WkSVX2QA-1
X-Mimecast-MFC-AGG-ID: JQRYqmNhNSSpl5WkSVX2QA_1758816210
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdfe971abso884180f8f.2
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 09:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758816210; x=1759421010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAAu2rvXua1onNC9vVWcLt9JR4YNW3IhkSLkwQw3+yc=;
        b=vB2XgPzz5n2Lm76HnizIKyO8/DE3SzDI3Ii0V4/kZMO6K9Mu7wROR+HOoVtjsBB0Io
         8XkTsqOTigRO406dhavp00bS0CIWCcQqB3j9C5JL5YbI/17yYrpqDRyeUBFONs0RJCQT
         Wva15qmkXmzZCl7MKq4kfrMU9fF+wu5qBD6ahZuaDr/27WVDFVLEwruvUXI2r9ZgMys5
         YqViwrCOmQfT57SkXNodcwYMSOyFHjv5YvMGZO2IKH+W5Qomjbod3QMbyVlbp7cpMeG+
         /UwranYUYK9p6i8lkw743vnw1RBLo2V0q3UT6O3+aLqgJdSfUPGZby4ms8KBl2BkooXF
         kjFQ==
X-Gm-Message-State: AOJu0YweiGqWYzzFgaAuSP1l+FW5KTCxnig1JriWtMASD4g339XT92UF
	jUqHPJdkRSCCDY6u53JxIGfylSbaZFpBxOtCj+K9dvZPmzg2Bwp75vGyIfa5FwUp4XudpM1azAP
	OmOW71COeZ3P/4gkh4zaw9Cmsz234/sHPI5lDC2B59f1srPScRwfhFho01A==
X-Gm-Gg: ASbGnctMBU0VdRZ4vKJ4GbD9dJgzpW6AL8CDqxlN9X3TJsK/Pb6LbhGYzlf7m1NuOMQ
	XkOcTydBtGlyiaceXyiyj4dzTIwfkc/uIS+xIrqDShMZNdeaYWRw3zcLCoZPmcPf1ui5xDqCMvH
	tv/IOdi8rgarZui5AOnEQjCNMNtOLE3/L4IVyWSdKSGVGDESVduNu4IvKYH34deZObtUHnFPOdr
	QGvVSZR2ipHvB0k5pm39Vde3BJ/3SQ2A0MBceUkIg9UE1uKcBfkJrpbEo20JhGHNwQOooccxDvq
	seW7r/cNfL/15a5+wg12+Tuv0gotnf+WDGCny3OtuSXxeswHV/KfVv6wKbZFB1cx26AhlsQ81A0
	hU/EIjYPvxSrM
X-Received: by 2002:a05:6000:1866:b0:3eb:6c82:bb27 with SMTP id ffacd0b85a97d-40e4accc83dmr3283220f8f.61.1758816210048;
        Thu, 25 Sep 2025 09:03:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEolKtk07hzt/nAdhndezZGEyI0DNBNdQSNglyCE4zJD/NsrvHDr7kmZq4QCjzgvNjUhL530Q==
X-Received: by 2002:a05:6000:1866:b0:3eb:6c82:bb27 with SMTP id ffacd0b85a97d-40e4accc83dmr3283173f8f.61.1758816209543;
        Thu, 25 Sep 2025 09:03:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a9ac55esm91746695e9.6.2025.09.25.09.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 09:03:28 -0700 (PDT)
Message-ID: <f89701ce-839e-4032-bb1d-40fb1b67cb70@redhat.com>
Date: Thu, 25 Sep 2025 18:03:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 06/15] quic: add stream management
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev,
 davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, linux-cifs@vger.kernel.org,
 Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>,
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Benjamin Coddington <bcodding@redhat.com>,
 Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1758234904.git.lucien.xin@gmail.com>
 <5d71a793a5f6e85160748ed30539b98d2629c5ac.1758234904.git.lucien.xin@gmail.com>
 <2ef635de-7282-4ffe-bdfc-eceafa73857e@redhat.com>
 <CADvbK_fE1KHbgtZV4zY1xXo94avimgxBcoakyoAYPOsb-U3rSw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CADvbK_fE1KHbgtZV4zY1xXo94avimgxBcoakyoAYPOsb-U3rSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/23/25 7:57 PM, Xin Long wrote:
> On Tue, Sep 23, 2025 at 9:39 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 9/19/25 12:34 AM, Xin Long wrote:
>>> +/* Create and register new streams for sending. */
>>> +static struct quic_stream *quic_stream_send_create(struct quic_stream_table *streams,
>>> +                                                s64 max_stream_id, u8 is_serv)
>>> +{
>>> +     struct quic_stream *stream;
>>> +     s64 stream_id;
>>> +
>>> +     stream_id = streams->send.next_bidi_stream_id;
>>> +     if (quic_stream_id_uni(max_stream_id))
>>> +             stream_id = streams->send.next_uni_stream_id;
>>> +
>>> +     /* rfc9000#section-2.1: A stream ID that is used out of order results in all streams
>>> +      * of that type with lower-numbered stream IDs also being opened.
>>> +      */
>>> +     while (stream_id <= max_stream_id) {
>>> +             stream = kzalloc(sizeof(*stream), GFP_KERNEL);
>>> +             if (!stream)
>>> +                     return NULL;
>>
>> How many streams and connections ID do you foresee per socket? Could
>> such number grow significantly (possibly under misuse/attack)? If so you
>> you likely use GFP_KERNEL_ACCOUNT here (and in conn_id allocation).
> connections ID: 8 (QUIC_CONN_ID_LIMIT) at most per socket.
> streams: 4096 (QUIC_MAX_STREAMS) at most per socket.

Will such limit fit a (very) busy server? I guess it's more a question
those who already run quic workload at scale...

> I can switch to GFP_KERNEL_ACCOUNT in quic_stream_send_create().
> 
> For quic_stream_recv_create(), it’s typically invoked in atomic context.
> Since there’s no predefined GFP_ATOMIC_ACCOUNT, I assume using
> (GFP_ATOMIC | __GFP_ACCOUNT) should be acceptable.

I see there are already a few other allocations using such flags, and I
could not find any explicit limitation/drawback for it. I hope it's not
just cargo cult programming :-P

/P



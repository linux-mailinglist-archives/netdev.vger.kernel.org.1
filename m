Return-Path: <netdev+bounces-236188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B32C6C39A97
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 09:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36E6034D0B3
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413753090C7;
	Thu,  6 Nov 2025 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjrLSDwG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUu5vUFQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2443090CC
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419129; cv=none; b=YKzg23JTb53qlmzD79D5IcXHD078cww0MJmn4i74b8O1r5G6wnho6otjstmnLf0G8oRpJBWPJUY0mMRVTymnwpVX689MtSaPe/zxW3ACfL01JIJK9pUoLHm31yFEytrXh8diN2W6TMhzJkA5+j/X6P14zWj9nFZvdYy5zUrvVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419129; c=relaxed/simple;
	bh=l2uWDhEaQy0Z5iNX0dnyrT6a21b6LKnpGMNZZDcdtwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdTYZurVDblxiUhuwk7pyMzwNF+BfmirlZGSG2RwbMGcLBKjBF/kMnqYBUXwQBKRFt/nx4mjnuy+oRBRrA32s+rbecA+iRuk2c5+LvDQCSIjDwJ6gofz8tVIbxTY66hwSIuP0F5KOLNYD68qYW3mOc9OFVJMZgR9E7qM3jK+iwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjrLSDwG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUu5vUFQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762419126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NanxbbpkNDlbUyOTW56q78Ac+UJfat3j75mYZLY0ZE=;
	b=NjrLSDwGdkwHgffhe4bGbq8ItYr4Jto4fVhQKSWqsjIvn6WKVImATve+qvDWPeOfAO4fXK
	dsVF8NMBjIQ+ZLA8SbxI+HPX87eIj+ycXEDwC/8qt61+3BSKWZNSIPX15nSD1+xGj3vnl7
	GnKTc1EFUYjUkG+TN31h8drC435jQx8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-h1HpDfD9M62K7C3SEbdc1w-1; Thu, 06 Nov 2025 03:52:04 -0500
X-MC-Unique: h1HpDfD9M62K7C3SEbdc1w-1
X-Mimecast-MFC-AGG-ID: h1HpDfD9M62K7C3SEbdc1w_1762419123
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477563e531cso6627425e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 00:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762419123; x=1763023923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NanxbbpkNDlbUyOTW56q78Ac+UJfat3j75mYZLY0ZE=;
        b=BUu5vUFQWT1Bi1J+hYsgo+Ss0WigHmXvgPxZh/KIj7Wugiyxbl6sgpsqdakBqhVlZU
         OB88Vq9linMFuw2YyRpVrml1xZ1gOJNTvGQBqgMz38qx2NtDsZ+Z9eS4vIG+yntBf248
         ne8pLmmakfh6+TqdiJZUGVMN9OLvqTuRLKQBXbDiysyqZPd6ZXJME6uAgPhv8ct3JJEL
         ASFW72hY8qUdSLGvsbt7lT3Ud8TRmD9eSjJz/gqjWPKWGVNZfO3Ib7Sml+nvXbb+1Kjj
         4Ad0DlEdGIOu+RHqD0D/f7+ZwffuGukLI3oOIfDeuByAnwV4AaeCaMJ+wEdZYUsO9sY+
         O5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419123; x=1763023923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NanxbbpkNDlbUyOTW56q78Ac+UJfat3j75mYZLY0ZE=;
        b=cqWFmuizx9IasSG8gNeZNDeR4vb9f/zgKpptL1K3GVxFt0kt1V29IRVUxZs6iNmKTW
         cBiTTpU3y+chfZY1SDpl2IcJ7HFaQ4qnOug004f2d2ALMwWkkR5qc48/xpFNqk6oykqA
         +fVqrOJON+dFix3lT/JVO2VSo15Ttd0WOLv1q0PLF1tUiLy6gDDv/6tQZdeRZAUzkk2A
         lRxPV2H41KcHEb0Ie+gwE32cVnCEzm9T+6TKQItj0XJgvZf5nCficGtxYHHhRwVj4van
         D4jiZDfz/58Je+fQwbDkovBd/VIMonULaEFLfMp2OO3HBGbP+zfaPqmo31VeZUuIzp89
         Pg8w==
X-Gm-Message-State: AOJu0Yz4uJxQrZavwQ9LgtcerDYnIoB9lz9xx/vleOhGw/OFpB59ykiE
	5Oe8S22O17lj3/BrcIN/61OsdpujhNAHlkQchElwx0ib/QwSW0PqEXJlgYzq5PF5pwOYdFl4r2O
	vaCRfNjwVj7TH0oqbSLpnvpNCYC+nRW+umFmn8PQuekXpSAVAw/K3cYGSHA==
X-Gm-Gg: ASbGncsl+a5g9k1+fjIulzdbZXmWOQDZjJQPeRX3MZK2cMLgHM+vxrYNIoji4F//etx
	xGHJEYV/iiwKyu16cfmoLRqRHmSLy8TwvEdTGP7Qw9he914xChih8hd3Qrqw1LdACxHtTyE+/Zg
	DVD59dKghiQK2zP/psrW+RuxN2g1yBU52hXcS2Zgyndwvxjz0oEu20f5QEwckET2ycJ+qpHbMqe
	VvQF0rg1+JyOCrXRSEnArNegnFxADgUiXc5lW3nLM3HQQScanpEUwRuoNjRydaf7vVtrcAN4/Nk
	hTldkZS+MxTBI2VMQOT+87BNXK5Q7b3APrC0/0spJOe9Gkl9nuJ3oG3HdBCza97C/TdB8OBSjXa
	2eQ==
X-Received: by 2002:a05:600c:3487:b0:471:115e:9605 with SMTP id 5b1f17b1804b1-4775ce3d8a1mr64704855e9.35.1762419123469;
        Thu, 06 Nov 2025 00:52:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPovKIk02f8ddjHUYyEZ+Oj38N6pOCkSx8ThIFm92RoMszw4bRUVHCaXxRkNiaePAEdRptZw==
X-Received: by 2002:a05:600c:3487:b0:471:115e:9605 with SMTP id 5b1f17b1804b1-4775ce3d8a1mr64704515e9.35.1762419123036;
        Thu, 06 Nov 2025 00:52:03 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb410ffcsm3542471f8f.15.2025.11.06.00.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 00:52:02 -0800 (PST)
Message-ID: <24cee5fb-1710-4d1e-a1af-793fb99fc9c7@redhat.com>
Date: Thu, 6 Nov 2025 09:51:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 06/15] quic: add stream management
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev,
 davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Stefan Metzmacher <metze@samba.org>,
 Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>,
 linux-cifs@vger.kernel.org, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@manguebit.com>,
 Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>,
 Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>,
 illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Daniel Stenberg <daniel@haxx.se>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <cover.1761748557.git.lucien.xin@gmail.com>
 <6b527b669fe05f9743e37d9f584f7cd492a7649b.1761748557.git.lucien.xin@gmail.com>
 <ad38f56b-5c53-408e-abcc-4b061c2097a3@redhat.com>
 <CADvbK_c2gUNyDNYfgVrQ+Cm9rL6P_n+s0LJsrAPz0VK9FDDxyg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CADvbK_c2gUNyDNYfgVrQ+Cm9rL6P_n+s0LJsrAPz0VK9FDDxyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/6/25 2:27 AM, Xin Long wrote:
> On Tue, Nov 4, 2025 at 6:05 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> On 10/29/25 3:35 PM, Xin Long wrote:
>> +/* Create and register new streams for sending. */
>>> +static struct quic_stream *quic_stream_send_create(struct quic_stream_table *streams,
>>> +                                                s64 max_stream_id, u8 is_serv)
>>> +{
>>> +     struct quic_stream *stream = NULL;
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
>>> +             stream = kzalloc(sizeof(*stream), GFP_KERNEL_ACCOUNT);
>>> +             if (!stream)
>>> +                     return NULL;
>>> +
>>> +             stream->id = stream_id;
>>> +             if (quic_stream_id_uni(stream_id)) {
>>> +                     stream->send.max_bytes = streams->send.max_stream_data_uni;
>>> +
>>> +                     if (streams->send.next_uni_stream_id < stream_id + QUIC_STREAM_ID_STEP)
>>> +                             streams->send.next_uni_stream_id = stream_id + QUIC_STREAM_ID_STEP;
>>
>> It's unclear to me the goal the above 2 statements. Dealing with id
>> wrap-arounds? If 'streams->send.next_uni_stream_id < stream_id +
>> QUIC_STREAM_ID_STEP' is not true the next quic_stream_send_create() will
>> reuse the same stream_id.
>>
>> I moving the above in a separate helper with some comments would help.
>>
> I will add a macro for this:
> 
> #define quic_stream_id_next_update(limits, type, id)    \
> do {                                                    \
>         if ((limits)->next_##type##_stream_id < (id) +
> QUIC_STREAM_ID_STEP)     \
>                 (limits)->next_##type##_stream_id = (id) +
> QUIC_STREAM_ID_STEP; \
>         (limits)->streams_##type++;
>          \
> } while (0)
> 
> So that we can use it to update both next_uni_stream_id and next_bidi_stream_id.

A function would be better tacking the next_id value as an argument.
More importantly please document the goal here which is still unclear to me.

>> The above 2 functions has a lot of code in common. I think you could
>> deduplicate it by:
>> - defining a named type for quic_stream_table.{send,recv}
>> - define a generic /() helper using an additonal
>> argument for the relevant table.{send,recv}
>> - replace the above 2 functions with a single invocation to such helper.
> This is a very smart idea!
> 
> It will dedup not only quic_stream_recv_create(), but also
> quic_stream_get_param() and quic_stream_set_param().
> 
> I will define a type named 'struct quic_stream_limits'.
> Note that, since we must pass 'bool send' to quic_stream_create() for
> setting the fields in a single 'stream' .
> 
>         if (quic_stream_id_uni(stream_id)) {
>                 if (send) {
>                         stream->send.max_bytes = limits->max_stream_data_uni;
>                 } else {
>                         stream->recv.max_bytes = limits->max_stream_data_uni;
>                         stream->recv.window = stream->recv.max_bytes;
>                 }
> 
> I'm planning not to pass additional argument of table.{send,recv},
> but do this in quic_stream_create():
>         struct quic_stream_limits *limits = &streams->send;
>         gfp_t gfp = GFP_KERNEL_ACCOUNT;
> 
>         if (!send) {
>                 limits = &streams->recv;
>                 gfp = GFP_ATOMIC | __GFP_ACCOUNT;
>         }
> 
>>
>> It looks like there are more de-dup opportunity below.
>>
> Yes, the difference is only the variable name _uni_ and _bidi_.
> I'm planning to de-dup them with macros like:
> 
> #define quic_stream_id_below_next(streams, type, id, send)        \
>     ((send) ? ((id) < (streams)->send.next_##type##_stream_id) :    \
>           ((id) < (streams)->recv.next_##type##_stream_id))
> 
> /* Check if a send or receive stream ID is already closed. */
> static bool quic_stream_id_closed(struct quic_stream_table *streams,
> s64 stream_id, bool send)
> {
>     if (quic_stream_id_uni(stream_id))
>         return quic_stream_id_below_next(streams, uni, stream_id, send);
>     return quic_stream_id_below_next(streams, bidi, stream_id, send);
> }
> 
> #define quic_stream_id_above_max(streams, type, id)            \
>     (((id) > (streams)->send.max_##type##_stream_id) ? true :    \
>         (quic_stream_id_to_streams((id) -
> (streams)->send.next_##type##_stream_id) +    \
>             (streams)->send.streams_##type >
> (streams)->send.max_streams_##type))

Uhmm... with "more de-dup opportunity below" I intended
quic_stream_get_param() and quic_stream_set_param(). I would refrain
from adding macros. I think the above idea ('struct quic_stream_limits')
would not need that?!?

/P



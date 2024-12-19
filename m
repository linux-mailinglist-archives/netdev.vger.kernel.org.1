Return-Path: <netdev+bounces-153403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5849F7D97
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7850C7A04A2
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43A4224B1E;
	Thu, 19 Dec 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="aEikJbut"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1474F41C64;
	Thu, 19 Dec 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734620712; cv=none; b=T6Vdx4jUnQuFkI9W5HRf4Ojaa63tJqQepEdmcH4aGBN4zjZwnzMSCuzv8ImW54MzZbVof6JQKZQ80giTWKvn5xgYAt63pATAKeMc4iWwMhxVfAFRrxcPnVU7CxGj2BdyZ3LET67Y+2Tovw1vO9+cAWkOZRsHztxl45ab1hd4Zms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734620712; c=relaxed/simple;
	bh=iwGKqwTTWXUxoDHoKQIjb/ql93uq4d++zxqRLk5SRrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMXWYruSb7OTxY8Y67ZaofSOPCYOMU8tA09mzDIpG+Ekyv7UpPqT9LWJ8uJcZbwoITXEaffoq2TAajrGzJa1pse45DdCGxryxPxuY9hCPVbYTzqVAZxRQjW0yxwwDjTLZtL5dVEfyJYZ+q4x4lxh/xFewXM+JrvLvP+9K/JvQZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=aEikJbut; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tOI5F-0084ke-0c; Thu, 19 Dec 2024 16:05:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=zifHlnhZp8kfHV1mHurt72vHOoVuTpoxDlZ+dstXlwc=; b=aEikJbutTfQMb9Xtj/ob5QpdtL
	tjMfv/GZGxC2nkhtXLYadl+7tbpQvH1SpzKLLEwQLpTuiOt8nE9J6teK9ZtM5+FhGIfOKDlOhKMCI
	nbartSzSqdDFGJblNOHTyhwINQgeROD6dO6qNrG/NfFcyc8zym1K3j9jVjSiTYzF+eaTQe2UXL1BH
	Al6ZsK9Vr/0zVw1ti7ZM7MBvUP8cx6OR+sYUUm/HvTQnuSNdGytm2VDLFV9FHf28GNMWF3OOcRhFc
	J+hiykUdmo6lb5n5aYt5QB3MDcgrvN/C0ULqsC2AajcJMA9kEwfUlrOs6zBdwdhjpB+6b4WqDM0Ax
	DwlMVddw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tOI5D-0004wn-QO; Thu, 19 Dec 2024 16:04:59 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tOI4x-00ELnH-DN; Thu, 19 Dec 2024 16:04:43 +0100
Message-ID: <cc04fe7a-aa49-47a7-8d54-7a0e7c5bfbdc@rbox.co>
Date: Thu, 19 Dec 2024 16:04:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Hyunwoo Kim <v4bel@theori.io>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, qwerty@theori.io
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
 <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
 <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX>
 <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>
 <f7a3rlgpc36wk75grqeg6ndqmlprvilznlsesyruqfb7m5vrp7@myil7ex4f62n>
 <Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX>
 <5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co>
 <Z2N44ka8+l83XqcG@v4bel-B760M-AORUS-ELITE-AX>
 <fezrztdzj5bz54ys6qialz4w3bjqqxmhx74t2tnklbif6ns5dn@mtcjqnqbx6n4>
 <722e8d32-fe5c-4522-be2b-5967fdbb6b30@rbox.co>
 <CAGxU2F5VMGg--iv8Nxvmo_tGhHf_4d_hO5WuibXLUcwVVNgQEg@mail.gmail.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <CAGxU2F5VMGg--iv8Nxvmo_tGhHf_4d_hO5WuibXLUcwVVNgQEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 15:48, Stefano Garzarella wrote:
> On Thu, 19 Dec 2024 at 15:36, Michal Luczaj <mhal@rbox.co> wrote:
>>
>> On 12/19/24 09:19, Stefano Garzarella wrote:
>>> ...
>>> I think the best thing though is to better understand how to handle
>>> deassign, rather than checking everywhere that it's not null, also
>>> because in some cases (like the one in virtio-vsock), it's also
>>> important that the transport is the same.
>>
>> My vote would be to apply your virtio_transport_recv_pkt() patch *and* make
>> it impossible-by-design to switch ->transport from non-NULL to NULL in
>> vsock_assign_transport().
> 
> I don't know if that's enough, in this case the problem is that some
> response packets are intended for a socket, where the transport has
> changed. So whether it's null or assigned but different, it's still a
> problem we have to handle.
> 
> So making it impossible for the transport to be null, but allowing it
> to be different (we can't prevent it from changing), doesn't solve the
> problem for us, it only shifts it.

Got it. I assumed this issue would be solved by `vsk->transport !=
&t->transport` in the critical place(s).

(Note that BPF doesn't care if transport has changed; BPF just expects to
have _a_ transport.)

>> If I'm not mistaken, that would require rewriting vsock_assign_transport()
>> so that a new transport is assigned only once fully initialized, otherwise
>> keep the old one (still unhurt and functional) and return error. Because
>> failing connect() should not change anything under the hood, right?
>>
> 
> Nope, connect should be able to change the transport.
> 
> Because a user can do an initial connect() that requires a specific
> transport, this one fails maybe because there's no peer with that cid.
> Then the user can redo the connect() to a different cid that requires
> a different transport.

But the initial connect() failing does not change anything under the hood
(transport should/could stay NULL). Then a successful re-connect assigns
the transport (NULL -> non-NULL). And it's all good because all I wanted to
avoid (because of BPF) was non-NULL -> NULL. Anyway, that's my possibly
shallow understanding :)



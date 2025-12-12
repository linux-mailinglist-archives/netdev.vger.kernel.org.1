Return-Path: <netdev+bounces-244485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE34CB8BAE
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 12:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36B2430421A5
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB86731E0F0;
	Fri, 12 Dec 2025 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgVVOF/2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922AC3191B9
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765539610; cv=none; b=u0uSFjhnFM81EsS9pH04cFPWaZ6078JfjOEilp1IwVxH2E7fMdV4hEXiAwdhVD9H4YQUFnfbKgHKmzbFUE0aUR8BH6HlxhdNPD+PWx2zFNalUN2lUvQ5kCMyBAbJpsh1/nJ+OA+cbjEjcazWDhpE972mkK0bPXnYhrH4yS2RM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765539610; c=relaxed/simple;
	bh=gNsOPmDAe2451KGz9hpylpCVm15a1m7Emxxu7hWfmhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eY9Cof/0U77pX2G0prx1jxPoMNZMK6DFZboE/r5Pu+1Rul+oECIagVRr1zAnT+NLmMnPcAi8zZUSSwXlP5S8wY0PwNssvs7TI8LGdQg69sTwXB/E250cVdRxbbd3xCSI2MEXh8UstHAM4OzxAn5LoGAVhfDMGyvKv1b1A2nGg5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgVVOF/2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779d47be12so10715515e9.2
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 03:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765539606; x=1766144406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lXEuhHp/TJS8bvwbNw0xDmmO/TWBfqgggwlo68iD50w=;
        b=fgVVOF/2XaAwUHdPmaz0XX9KdTJ8tJt5SjMgmGmaZxxMJNnZGmEdEyvl6MOAGPOFbv
         1TNUxHMl/26IrA4DKwora5XGj3Gf3hOO6XdiZTCBsoico/XGGw+0v5UxQAKuXzBcKQYl
         ssoeQAapkJcOBcKXltU5Uu3xf5Cjz13+rZakmRZlkfVTtiqfdr3xzm+nYy3v5uoD7d2t
         uKkwHz+JDYTBNT9x17Eq3TZmntitn1GQlP8ODs5EGho5F9sfvph5pM2xCsqihcJYZVHd
         UdXNlkpfow+cGEaIjVnC+7as1msrZ4LpVwLaKk4oyRcROuWMwyoODxb8XgoSJV8KZPCT
         nkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765539606; x=1766144406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXEuhHp/TJS8bvwbNw0xDmmO/TWBfqgggwlo68iD50w=;
        b=GeA296Wn2UhKy2CroENDz9ZigvzbDAuL4xrfTHGGiImn4ktAt3hkl5RLIRx6rc3q1k
         iFtH3sJYEx53EyRrDTvNfq8Esue7x/cMdrvhScQW2AnfbQ119A4wsP+Gwu6CyK26rWG9
         h7Xn/jcjb1K12glqxo6x8/UpUCJoYRw70EH+JXBLf4deELwZ2+/PR8WPNJ4A+5LGlhB5
         QlBChuzE+/niDR6BTttcrUbMlJc1DbFY34wK1SHvZHFCp60XN98tYTWFOtJhpIpkZ6vy
         dmeDst4UQzz8diIX+jv6LYujx7xROWr+eDac2RswCU1v73RraoDJ2lKmtU54ZCb8z7Uz
         fR0g==
X-Forwarded-Encrypted: i=1; AJvYcCV1SVLFPfnNLDVMxZbDKPl/Ln2e+/Weleb9PoMk4nwCIwyEHw9ZPX2/LumUHTK7mtsp4yGoS9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1q17VdEsbzc2KJiYrphHBAxcvojOUBa4H3qt5YloCnWxR3clQ
	V45C9rR350+N3/h9kac5wcK/SSVqF55O5L+UNJOz0BsYHHpoCbH95uDh
X-Gm-Gg: AY/fxX5RkN701RekX5g9+tjgDFkCbkvLh+8XnBmn0ZRofx+qUgwHBxaMNO5iShlSl5N
	dyCcdVNt5d+siR+0Ii1Z0xp+8LQx83BnWXGBCofWN9c4l1XmHSAw4eWBjmFM00/P0IScNudY3dC
	ehoNrMHqlI46AAHINmvLAGawbW15KOPMHAy9n/wGCgQP/C8nzvTIRE2tXjXAOPQMXW4WBWEg/dN
	BsJAnTJ1ioj1oRUfW8eJAnG2ZI9gP5UlI/602NL2jzaPZV29AsA7o7UQsbn29odY9jIelnmkJ+b
	tTMCWBukopqygX9iJSDWWweoA79xshcIt2/wuFxFPD7tQsp0K7sGvujC26uIN/eANwVvaCb/3fu
	H2fN2XS0JLrFdGg2yRjNfmVjn9cJmb2v4/cqF3krJy4O7oEHuuwApe/JRdd6PuibaBGgXS7iwVS
	qDK4759mfNgSnH8vzJZi93eyczOQhArkc3f/TvtR71fEyDNv1+affFosNgjyRaA1R39aZbseEEV
	qGmXWk=
X-Google-Smtp-Source: AGHT+IE3kaghFqaChtHnkXEcnlbvOdlUAWt+A8n6UrtZfPjq4lzmXLtYTWWXSNLEGevXzX336tSFOA==
X-Received: by 2002:a05:600c:1988:b0:477:af07:dd1c with SMTP id 5b1f17b1804b1-47a8f914ec2mr17252625e9.35.1765539605550;
        Fri, 12 Dec 2025 03:40:05 -0800 (PST)
Received: from [192.168.0.173] (108.228-30-62.static.virginmediabusiness.co.uk. [62.30.228.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f7676ffsm27866535e9.4.2025.12.12.03.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 03:40:04 -0800 (PST)
Message-ID: <deccf66c-dcd3-4187-9fb6-43ddf7d0a905@gmail.com>
Date: Fri, 12 Dec 2025 11:40:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] vsock/virtio: cap TX credit to local buffer size
Content-Language: en-GB
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
References: <20251211125104.375020-1-mlbnkm1@gmail.com>
 <20251211080251-mutt-send-email-mst@kernel.org>
 <zlhixzduyindq24osaedkt2xnukmatwhugfkqmaugvor6wlcol@56jsodxn4rhi>
 <CAMKc4jDpMsk1TtSN-GPLM1M_qp_jpoE1XL1g5qXRUiB-M0BPgQ@mail.gmail.com>
 <CAGxU2F7WOLs7bDJao-7Qd=GOqj_tOmS+EptviMphGqSrgsadqg@mail.gmail.com>
 <CAMKc4jDLdcGsL5_d+4CP6n-57s-R0vzrX2M7Ni=1GeCB1cxVYA@mail.gmail.com>
 <bwmol6raorw233ryb3dleh4meaui5vbe7no53boixckl3wgclz@s6grefw5dqen>
From: Melbin K Mathew <mlbnkm1@gmail.com>
In-Reply-To: <bwmol6raorw233ryb3dleh4meaui5vbe7no53boixckl3wgclz@s6grefw5dqen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/12/2025 10:40, Stefano Garzarella wrote:
> On Fri, Dec 12, 2025 at 09:56:28AM +0000, Melbin Mathew Antony wrote:
>> Hi Stefano, Michael,
>>
>> Thanks for the suggestions and guidance.
> 
> You're welcome, but please avoid top-posting in the future:
> https://www.kernel.org/doc/html/latest/process/submitting- 
> patches.html#use-trimmed-interleaved-replies-in-email-discussions
> 
Sure. Thanks
>>
>> I’ve drafted a 4-part series based on the recap. I’ve included the
>> four diffs below for discussion. Can wait for comments, iterate, and
>> then send the patch series in a few days.
>>
>> ---
>>
>> Patch 1/4 — vsock/virtio: make get_credit() s64-safe and clamp negatives
>>
>> virtio_transport_get_credit() was doing unsigned arithmetic; if the
>> peer shrinks its window, the subtraction can underflow and look like
>> “lots of credit”. This makes it compute “space” in s64 and clamp < 0
>> to 0.
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c
>> b/net/vmw_vsock/virtio_transport_common.c
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -494,16 +494,23 @@ 
>> EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 
>> credit)
>> {
>> + s64 bytes;
>>  u32 ret;
>>
>>  if (!credit)
>>  return 0;
>>
>>  spin_lock_bh(&vvs->tx_lock);
>> - ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>> - if (ret > credit)
>> - ret = credit;
>> + bytes = (s64)vvs->peer_buf_alloc -
> 
> Why not just calling virtio_transport_has_space()?
virtio_transport_has_space() takes struct vsock_sock *, while 
virtio_transport_get_credit() takes struct virtio_vsock_sock *, so I 
cannot directly call has_space() from get_credit() without changing 
signatures.

Would you be OK if I factor the common “space” calculation into a small 
helper that operates on struct virtio_vsock_sock * and is used by both 
paths? Something like:

/* Must be called with vvs->tx_lock held. Returns >= 0. */
static s64 virtio_transport_tx_space(struct virtio_vsock_sock *vvs)
{
	s64 bytes;

	bytes = (s64)vvs->peer_buf_alloc -
		((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
	if (bytes < 0)
		bytes = 0;

	return bytes;
}

Then:

get_credit() would do bytes = virtio_transport_tx_space(vvs); ret = 
min_t(u32, credit, (u32)bytes);

has_space() would use the same helper after obtaining vvs = vsk->trans;

Does that match what you had in mind, or would you prefer a different 
factoring?

> 
>> + ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
>> + if (bytes < 0)
>> + bytes = 0;
>> +
>> + ret = min_t(u32, credit, (u32)bytes);
>>  vvs->tx_cnt += ret;
>>  vvs->bytes_unsent += ret;
>>  spin_unlock_bh(&vvs->tx_lock);
>>
>>  return ret;
>> }
>>
>>
>> ---
>>
>> Patch 2/4 — vsock/virtio: cap TX window by local buffer (helper + use
>> everywhere in TX path)
>>
>> Cap the effective advertised window to min(peer_buf_alloc, buf_alloc)
>> and use it consistently in TX paths (get_credit, has_space,
>> seqpacket_enqueue).
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c
>> b/net/vmw_vsock/virtio_transport_common.c
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -491,6 +491,16 @@ void virtio_transport_consume_skb_sent(struct
>> sk_buff *skb, bool consume)
>> }
>> EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>> +/* Return the effective peer buffer size for TX credit computation.
>> + *
>> + * The peer advertises its receive buffer via peer_buf_alloc, but we 
>> cap it
>> + * to our local buf_alloc (derived from SO_VM_SOCKETS_BUFFER_SIZE and
>> + * already clamped to buffer_max_size).
>> + */
>> +static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
>> +{
>> + return min(vvs->peer_buf_alloc, vvs->buf_alloc);
>> +}
>>
>> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 
>> credit)
>> {
>>  s64 bytes;
>> @@ -502,7 +512,8 @@ u32 virtio_transport_get_credit(struct
>> virtio_vsock_sock *vvs, u32 credit)
>>  return 0;
>>
>>  spin_lock_bh(&vvs->tx_lock);
>> - bytes = (s64)vvs->peer_buf_alloc -
>> + bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
>>  ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
>>  if (bytes < 0)
>>  bytes = 0;
>> @@ -834,7 +845,7 @@ virtio_transport_seqpacket_enqueue(struct 
>> vsock_sock *vsk,
>>  spin_lock_bh(&vvs->tx_lock);
>>
>> - if (len > vvs->peer_buf_alloc) {
>> + if (len > virtio_transport_tx_buf_alloc(vvs)) {
>>  spin_unlock_bh(&vvs->tx_lock);
>>  return -EMSGSIZE;
>>  }
>> @@ -884,7 +895,8 @@ static s64 virtio_transport_has_space(struct
>> vsock_sock *vsk)
>>  struct virtio_vsock_sock *vvs = vsk->trans;
>>  s64 bytes;
>>
>> - bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>> + bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
>> + ((s64)vvs->tx_cnt - (s64)vvs->peer_fwd_cnt);
>>  if (bytes < 0)
>>  bytes = 0;
>>
>>  return bytes;
>> }
>>
>>
>> ---
>>
>> Patch 3/4 — vsock/test: fix seqpacket msg bounds test (set client buf 
>> too)
> 
> Please just include in the series the patch I sent to you.
> 
Thanks. I'll use your vsock_test.c patch as-is for 3/4
>>
>> After fixing TX credit bounds, the client can fill its TX window and
>> block before it wakes the server. Setting the buffer on the client
>> makes the test deterministic again.
>>
>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/ 
>> vsock_test.c
>> --- a/tools/testing/vsock/vsock_test.c
>> +++ b/tools/testing/vsock/vsock_test.c
>> @@ -353,6 +353,7 @@ static void test_stream_msg_peek_server(const
>> struct test_opts *opts)
>>
>> static void test_seqpacket_msg_bounds_client(const struct test_opts 
>> *opts)
>> {
>> + unsigned long long sock_buf_size;
>>  unsigned long curr_hash;
>>  size_t max_msg_size;
>>  int page_size;
>> @@ -366,6 +367,18 @@ static void
>> test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>>  exit(EXIT_FAILURE);
>>  }
>>
>> + sock_buf_size = SOCK_BUF_SIZE;
>> +
>> + setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>> +    sock_buf_size,
>> +    "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>> +
>> + setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_SIZE,
>> +    sock_buf_size,
>> +    "setsockopt(SO_VM_SOCKETS_BUFFER_SIZE)");
>> +
>>  /* Wait, until receiver sets buffer size. */
>>  control_expectln("SRVREADY");
>>
>>
>> ---
>>
>> Patch 4/4 — vsock/test: add stream TX credit bounds regression test
>>
>> This directly guards the original failure mode for stream sockets: if
>> the peer advertises a large window but the sender’s local policy is
>> small, the sender must stall quickly (hit EAGAIN in nonblocking mode)
>> rather than queueing megabytes.
> 
> Yeah, using nonblocking mode LGTM!
> 
>>
>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/ 
>> vsock_test.c
>> --- a/tools/testing/vsock/vsock_test.c
>> +++ b/tools/testing/vsock/vsock_test.c
>> @@ -349,6 +349,7 @@
>> #define SOCK_BUF_SIZE (2 * 1024 * 1024)
>> +#define SMALL_SOCK_BUF_SIZE (64 * 1024ULL)
>> #define MAX_MSG_PAGES 4
>>
>> /* Insert new test functions after test_stream_msg_peek_server, before
>>  * test_seqpacket_msg_bounds_client (around line 352) */
>>
>> +static void test_stream_tx_credit_bounds_client(const struct 
>> test_opts *opts)
>> +{
>> + ... /* full function as provided */
>> +}
>> +
>> +static void test_stream_tx_credit_bounds_server(const struct 
>> test_opts *opts)
>> +{
>> + ... /* full function as provided */
>> +}
>>
>> @@ -2224,6 +2305,10 @@
>>  .run_client = test_stream_msg_peek_client,
>>  .run_server = test_stream_msg_peek_server,
>>  },
>> + {
>> + .name = "SOCK_STREAM TX credit bounds",
>> + .run_client = test_stream_tx_credit_bounds_client,
>> + .run_server = test_stream_tx_credit_bounds_server,
>> + },
> 
> Please put it at the bottom. Tests are skipped by index, so we don't 
> want to change index of old tests.
> 
> Please fix your editor, those diffs are hard to read without tabs/spaces.
seems like some issue with my email client. Hope it is okay now
> 
> Thanks,
> Stefano
> 



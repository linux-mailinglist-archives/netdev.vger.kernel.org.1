Return-Path: <netdev+bounces-181868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4117EA86A9C
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 05:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F3B3ACC55
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 03:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E80F43AA4;
	Sat, 12 Apr 2025 03:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aUqNUXyM"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126B4315F
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 03:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744429668; cv=none; b=E/klP4zcmD/fOfh9k8evoAAkJ+Ok/jnF+MfnBjMzi8Oqq91YkDKqgKdo3TTd6ScPWSG3ZywqYa5zo6QtcYOqDfjPznuTjgf10HExP5Kh6r2rw2Y6ONF3mriNXw6o388yO+hb3hyAY5XRc4x+7vOnbQ6hjKtRW8x5Sgw/wffAHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744429668; c=relaxed/simple;
	bh=qIl/FAhG1F91mnfzo0noDBZX3oS8yKIAY87B071dLd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSBWVunTZHySYxR7jpEXHfjMr0yl8qZhhY28uFFNr+iEkQHdSX/PBOvoHQezR8AWNaEJFbJsrlYfVd0N48dRjtiKGbUO3EorBDi7v5amqFFhZbIvNphbyDjN1JK94b81WtjM1O21UPxP7stP8uPm6BT8nGLhsPZ8zNBM7/DzOus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aUqNUXyM; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <daa3f02a-c982-4a7a-afcd-41f5e9b2f79c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744429661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5QMA09X4rDgztgDYeoB6Z+4waCnXeyrYx4ysIw4hN8=;
	b=aUqNUXyMAo1TOIOe2nlOwt7RX75vgU0dXQxBrf6MyMc2twEwDAF4Endw78F9KRbtJVnKIs
	GjLqpv1+Cs2odL9Se72y3Bhw0Rgo6XibD7fGVPd2k8mezB17GtNEotj2gsKRg/DfJnTywo
	Q8fpxVBxvzqGXHW5sFXgbMgeCb7wg9Y=
Date: Fri, 11 Apr 2025 20:47:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: udp: Propagate ENOMEM up from
 bpf_iter_udp_batch
To: Jordan Rife <jordan@jrife.io>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250411173551.772577-1-jordan@jrife.io>
 <20250411173551.772577-3-jordan@jrife.io>
 <7ed28273-a716-4638-912d-f86f965e54bb@linux.dev>
 <CABi4-ojQVb=8SKGNubpy=bG4pg1o=tNaz9UspYDTbGTPZTu8gQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CABi4-ojQVb=8SKGNubpy=bG4pg1o=tNaz9UspYDTbGTPZTu8gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/11/25 4:31 PM, Jordan Rife wrote:
>> The resized == true case will have a similar issue. Meaning the next
>> bpf_iter_udp_batch() will end up skipping the remaining sk in that bucket, e.g.
>> the partial-bucket batch has been consumed, so cur_sk == end_sk but
>> st_bucket_done == false and bpf_iter_udp_resume() returns NULL. It is sort of a
>> regression from the current "offset" implementation for this case. Any thought
>> on how to make it better?
> 
> Are you referring to the case where the bucket grows in size so much
> between releasing and reacquiring the bucket's lock to where we still
> can't fit all sockets into our batch even after a
> bpf_iter_udp_realloc_batch()? If so, I think we touched on this a bit
> in [1]:

Right, and it is also the same as the kvmalloc failure case that this patch is 
handling. Let see if it can be done better without returning error in both cases.

> 1) Loop until iter->end_sk == batch_sks, possibly calling realloc a
> couple times. The unbounded loop is a bit worrying; I guess
> bpf_iter_udp_batch could "race" if the bucket size keeps growing here.
> 2) Loop some bounded number of times and return some ERR_PTR(x) if the
> loop can't keep up after a few tries so we don't break the invariant
> that the batch is always a full snapshot of a bucket.
> 3) Set some flag in the iterator state, e.g. iter->is_partial,
> indicating to the next call to bpf_iter_udp_realloc_batch() that the
> last batch was actually partial and that if it can't find any of the
> cookies from last time it should start over from the beginning of the
> bucket instead of advancing to the next bucket. This may repeat
> sockets we've already seen in the worst case, but still better than
> skipping them.

Probably something like (3) but I don't think it needs a new "is_partial". The 
existing "st_bucket_done" should do.

How about for the "st_bucket_done == false" case, it also stores the
cookie before advancing the cur_sk in bpf_iter_udp_seq_next().

not-compiled code:

static void *bpf_iter_udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
{
	if (iter->cur_sk < iter->end_sk) {
		u64 cookie;

		cookie = iter->st_bucket_done ?
			0 : __sock_gen_cookie(iter->batch[iter->cur_sk].sock);
		sock_put(iter->batch[iter->cur_sk].sock);
		iter->batch[iter->cur_sk++].cookie = cookie;
	}

	/* ... */
}

In bpf_iter_udp_resume(), if it cannot find the first sk from find_cookie to 
end_cookie, then it searches backward from find_cookie to 0. If nothing found, 
then it should start from the beginning of the resume_bucket. Would it work?




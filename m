Return-Path: <netdev+bounces-160113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 007D9A18473
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 19:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5907A4E57
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D761F542F;
	Tue, 21 Jan 2025 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="lZhE2ZM5"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD01F472D
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 18:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482814; cv=none; b=bIC+bDTgNy3TLdHzyorID9pCy+erH+lvrCjfFDqh+xJ47NgMCly61sEUIc0JR0o+ThlABVNEronpTz/vFkx3lrM2xeVlpeX0QdjOuW/bXfByf/K4M4JKpB4s9zC7SJdrDEMGPuQpzGpJfzL6y03ipXtkmvq9JVFKh9EeZ5Fgu1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482814; c=relaxed/simple;
	bh=yzMp9OHuDafOKBn9rcCV9TmT/23Cxa4L5N2agXVJ7RY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXJ6Ej6cSw42sGc9cgb6GUO9Md+6vKubGrIhaUqNAuBckZ5tn9Vx1vyu19VDMBrcldfK6jRSSE2Hrrc66CKBC3VsUDAqe8REgG+SdVIwo7iEqEclKOapToBR0ynzRuSejF3Oj4khl2f9Kt8pAe8+fF+jTb8LF+8g8EANa387Zt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=lZhE2ZM5; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1taIeA-001V5h-Sf; Tue, 21 Jan 2025 19:06:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=B0NkyGC4wYzCqVt2GL2dQ8Knz8FG3vRNUr8ob8BqF5k=; b=lZhE2ZM5ebUs7A8nmbHRIqXRl8
	MUCnJTfK17MbN21CUElCkz+PNZr31HSVtBnHd1eMmgeeSikqNLHxtf/3jU0zTXjlGBKVQmfENidkm
	9PX2cX02Cwhpt+nUurU1kGffhyKp1uR3yOaAHgPLf2hEcMWUlWLGwIhYIC34lrJH1g71frVxPG4ko
	PwefQEVtEe/Hsg9wcV025DbgJjKWY6KwaHMKzoyDUOMOFKsEcLJrvGeJEcjtCyKWPWslQlw3TprVT
	WpR6AFtLuPmZhYXl+ifjoto4O8sbMlJxi6mqs1FD5AfKJA6Nl6cfWV9os9vsBqklX4Mazlll4RrjA
	GQ3R5rpw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1taIe9-0006xt-CE; Tue, 21 Jan 2025 19:06:41 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1taIe0-006jVZ-TF; Tue, 21 Jan 2025 19:06:32 +0100
Message-ID: <2bdfe259-e182-4846-b501-a33096cc74f1@rbox.co>
Date: Tue, 21 Jan 2025 19:06:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] vsock/virtio: discard packets if the transport
 changes
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wongi Lee <qwerty@theori.io>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 virtualization@lists.linux.dev, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, bpf@vger.kernel.org, Jakub Kicinski
 <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hyunwoo Kim <v4bel@theori.io>, kvm@vger.kernel.org
References: <20250108180617.154053-1-sgarzare@redhat.com>
 <20250108180617.154053-2-sgarzare@redhat.com>
 <2b3062e3-bdaa-4c94-a3c0-2930595b9670@rbox.co>
 <blvbtr3c7uxtbspbfwrobfk7qdukz6nst2bnomoxbltst2yhkm@47k6evsdceeg>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <blvbtr3c7uxtbspbfwrobfk7qdukz6nst2bnomoxbltst2yhkm@47k6evsdceeg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/25 18:30, Luigi Leonardi wrote:
> On Thu, Jan 09, 2025 at 02:34:28PM +0100, Michal Luczaj wrote:
>> FWIW, I've tried simplifying Hyunwoo's repro to toy with some tests. 
>> Ended
>> up with
>>
>> ```
>>from threading import *
>>from socket import *
>>from signal import *
>>
>> def listener(tid):
>> 	while True:
>> 		s = socket(AF_VSOCK, SOCK_SEQPACKET)
>> 		s.bind((1, 1234))
>> 		s.listen()
>> 		pthread_kill(tid, SIGUSR1)
>>
>> signal(SIGUSR1, lambda *args: None)
>> Thread(target=listener, args=[get_ident()]).start()
>>
>> while True:
>> 	c = socket(AF_VSOCK, SOCK_SEQPACKET)
>> 	c.connect_ex((1, 1234))
>> 	c.connect_ex((42, 1234))
>> ```
>>
>> which gives me splats with or without this patch.
>>
>> That said, when I apply this patch, but drop the `sk->sk_state !=
>> TCP_LISTEN &&`: no more splats.
>>
> Hi Michal,
> 
> I think it would be nice to have this test in the vsock test suite.  
> WDYT? If you don't have any plans to port this to C, I can take care of 
> it :)

Sure, go ahead, but note that this is just a (probably suboptimal) Python
version of Hyunwoo's C repro[1].

[1]: https://lore.kernel.org/netdev/Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX/



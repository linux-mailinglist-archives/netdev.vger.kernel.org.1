Return-Path: <netdev+bounces-250935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 535F6D39C03
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 066A73006F68
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 01:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136581DF273;
	Mon, 19 Jan 2026 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzRZXCMK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AAC1A8F84
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787043; cv=none; b=kNricbRvZI3faxHkAgjSxO6iYiUUAmhgiiBglPwRZ5DJ8PGB9xJ8zYR3rAQGk4D3M0UmYlq/ikG1oU+Ks1s6QYuLMgA+xFKG911GAJiKl4MAqJMT3oaKl5CVY9eSkSQHvUjflBknNo1nhp6HHFUzKLr7GLQhAm4VWkqEZt+jQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787043; c=relaxed/simple;
	bh=Mix0Ftnx+BxVDygDOXrtQuC7sxcn6TtpX8USBjwJolU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXfRzeyvIemtjfoV0oeqdQG8JfX8C06Te0gNDNCvZyXO2Y87HhD3TGfmefMlYPTKGwDKWzCQJAUiHktsgZQgHhFa4g0JB62f55p6GvGGA6op1PG0FG/uZjGZAJllk13mubeEpkRjtrBEuc2Fp7ANbVoQkQpYSsmQEJXGr04qTp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzRZXCMK; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ae29ddaed9so2302595eec.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787041; x=1769391841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc0UZ+YA//A4FjfGDE4kvF/Ys5up+mdRLfJ0LnYTjqU=;
        b=TzRZXCMKE4JlLS1isNOv/Qb5qqgdaWc/HkxaS/rqhjtCW5+MDOssBNg7mz3cavg81k
         KibgoLarm/NMLYFd4xboIHfU+kisAWuzOpcJxAZH4jkh269NULz1KsgrQAEl0uBwhPp6
         hoh0iH4M5C7gimADw0DxwVDCSq8tUyxmUzDWbaL1gtdMDA8QEM71R5ecT9bYwo7CHnyE
         Hqp1nNKzCC2gemB2XdfKph6eKXHSKIE/6OBsvMRlp3uCa8lKg4DIyHrtrpUIlNLhRjBI
         SaG5jbqaq7fwltl95cbVJiWybLW25XRynvVz8ouy79FbWKvBebdcoP77RrUW0ozWFPbW
         BrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787041; x=1769391841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uc0UZ+YA//A4FjfGDE4kvF/Ys5up+mdRLfJ0LnYTjqU=;
        b=TgMbbpW8lq6dizAgJ5Tbsr2IA/+BqhaymOGhaYxp2MtiqLNqj1skynw+z85RfINc5/
         mrnD+vWokl2QfxunANhu0/VA74KQpjpvvlBJEpCehoo+UuJBxsKJ7DASL5T2/15tRDnP
         +lrvcYF1J1jqMcrCViUueI83QKe9tT7Yt+0VPAMx68raVfuaEIojzYuwg+hLe7g/3aMd
         QSWfix+I0UshU/i9eQFdV7zsyYEeSh+nAnsNqCwxqVq5RK1Nz00YP1qcSPgUgXgZf9ZQ
         WDh2P0HmBcembUnMubiwL352cfzmHraTGtobjseHFK675id+Dv8T5WVhGJ3E2eFQZuzZ
         kvnA==
X-Gm-Message-State: AOJu0YxHTXFGXOetudb1ynN149V3WrevdG+56RYXAwbiPN1TYQ6eP1Ci
	UCfOgBzDLOsL6NutrPwdYIpY61U4Iffn6MYKu1YrdhBtkK75bJ41A5Jzi3lT
X-Gm-Gg: AY/fxX4ulVE2OUKf610nXWh3HjlvF0kFONv1/Bq05FBnNk2EICEiU1WCXYtGE7G0OVF
	D6QYmUuTLGU0aW3PwxDWu5cnjc7RMRpIip4WUv/KYxhJnnxSi85bKgtHknn9NfR2+WqKBM9zTOZ
	Xlijpnygi9nV5HQJnGF5GOoL2WWk7D6ExkuW/RGWULLgXBlbDoyygYBOjKGzYNzsnTP5rDcuiTW
	aKjmkBJtlQYgVh6ZqRMKEWQFilbfqrrtLEpWglVm8VbGMSSLd+IiRtpGMjiDGeLUGaCiXbgv8+z
	vYVbMK6oo9bUypjbBOld+7CDf5dgUkt0I/NO3dzvbJalEMSc+zZrBa6wczb1UclgSyldf+GrYKY
	JS2Y0J9oh7lwky2eK7+/8SRR5x1o9i52bhuBxgddhNIoDKSH41gT27LRsOeTbIw0cw5XHC9q2Kq
	7I1/H59YA1UJS89NwV6p97PqHvA/8Ovx2Au2kyJBFN8s8OCOJEj5bnW7AbjAafyKSClnoHoeNKE
	b4OBQ==
X-Received: by 2002:a05:7300:30c8:b0:2b4:5618:be67 with SMTP id 5a478bee46e88-2b6b3498c2dmr9318945eec.5.1768787040352;
        Sun, 18 Jan 2026 17:44:00 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b351e38bsm10958149eec.14.2026.01.18.17.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:43:59 -0800 (PST)
Date: Sun, 18 Jan 2026 17:43:58 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 01/16] net: Add queue-create operation
Message-ID: <aW2MXiopZOUZLgSE@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-2-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> Add a ynl netdev family operation called queue-create that creates a
> new queue on a netdevice:
> 
>       name: queue-create
>       attribute-set: queue
>       flags: [admin-perm]
>       do:
>         request:
>           attributes:
>             - ifindex
>             - type
>             - lease
>         reply: &queue-create-op
>           attributes:
>             - id
> 
> This is a generic operation such that it can be extended for various
> use cases in future. Right now it is mandatory to specify ifindex,
> the queue type which is enforced to rx and a lease. The newly created
> queue id is returned to the caller.
> 
> A queue from a virtual device can have a lease which refers to another
> queue from a physical device. This is useful for memory providers
> and AF_XDP operations which take an ifindex and queue id to allow
> applications to bind against virtual devices in containers. The lease
> couples both queues together and allows to proxy the operations from
> a virtual device in a container to the physical device.
> 
> In future, the nested lease attribute can be lifted and made optional
> for other use-cases such as dynamic queue creation for physical
> netdevs. The lack of lease and the specification of the physical
> device as an ifindex will imply that we need a real queue to be
> allocated. Similarly, the queue type enforcement to rx can then be
> lifted as well to support tx.
> 
> An early implementation had only driver-specific integration [0], but
> in order for other virtual devices to reuse, it makes sense to have
> this as a generic API in core net.
> 
> For leasing queues, the virtual netdev must have real_num_rx_queue
> less than num_rx_queues at the time of calling queue-create. The
> queue-type must be rx as only rx queues are supported for leasing
> for now. We also enforce that the queue-create ifindex must point
> to a virtual device, and that the nested lease attribute's ifindex
> must point to a physical device. The nested lease attribute set
> contains a netns-id attribute which is currently only intended for
> dumping as part of the queue-get operation. Also, it is modeled as
> an s32 type similarly as done elsewhere in the stack.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> Link: https://bpfconf.ebpf.io/bpfconf2025/bpfconf2025_material/lsfmmbpf_2025_netkit_borkmann.pdf [0]

Acked-by: Stanislav Fomichev <sdf@fomichev.me>


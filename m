Return-Path: <netdev+bounces-173902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C67A5C2FF
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508263B11D4
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E6A1CD215;
	Tue, 11 Mar 2025 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J98mj2AM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E0B1C54AF
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701002; cv=none; b=pBrENF60A0HF5iex1i0My0i+bSW8MJaqb3bocTL/SnVaLWWTRdVb30/RfuCzFIcnHNt/s2iBKLig6L5y6BZVuS+gEySIG6yUxlAnHQ+g4x7TxgELM8OXxYpmBDx3GQw9XWImZW893uMwuAnTQf0FzZiNwBaBvmTtBGJ45hWQ/Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701002; c=relaxed/simple;
	bh=t8KdbrMWsBJoQO4Ni60EZLRVIhCtaTA8841O4/7xuss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMvkxZv5lvDLQ2UkAdPsDEGfK9f7nDSeL7nz9whb+8prOnS76NlnwpGm9ZhiKjyfHOO84WJMAr1sdVpKlJ6eNsrwwXeYN5Eg1iMD0T2wo09LXU1GgOXaDPvLFjB0qo+zCdLrUXZKa0gUPaqMunPs5DxFs2pVWeQXyl9ScMAYQZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J98mj2AM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741700997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mgsr7jgTCRZ8U9QpOqMiuWp1S1JgO2ELwRf3Vztw4nc=;
	b=J98mj2AMMdvba6FgmfOEPe6F1PfiJOahwUXOQeGpCLaMLKitmfsvXVTqDdf1qO9FjVYv+k
	aBqahH9m9CQFedZsL6j98RuWBCBDvuABt8yMxP6GPCyK1clVU4mw9oi0GoncF7MgPSYg/W
	H0eClo0QOKDW8wK74E5gIxg78TrnIP0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-8_YEy5Q2MM-HOWtNZN5BTQ-1; Tue, 11 Mar 2025 09:49:56 -0400
X-MC-Unique: 8_YEy5Q2MM-HOWtNZN5BTQ-1
X-Mimecast-MFC-AGG-ID: 8_YEy5Q2MM-HOWtNZN5BTQ_1741700995
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cfd9b833bso9014555e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 06:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700995; x=1742305795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgsr7jgTCRZ8U9QpOqMiuWp1S1JgO2ELwRf3Vztw4nc=;
        b=JE/VXkbBkD5027y6UaxdKSI813oN/r4KmDn7neq5JAvBgi6AnwEE2KGGFGpTP/+/2S
         dupSobITK+MO1GvMHrZLRrnTsaqCxHqxo8N0adbKP9/HtPQv4IwKOm0aBY6mlMH6O1zr
         x9JaHnN0Fp5L/uVe8StWAVuOg+WdEoMVdyY79Pk/77cefdfdJ2PRyfLA8Crrk3yvF72R
         kzzPyZiPQvLMXijUNMXwwKb/d/3aYOQBvuxVKiylLgZ9kWE1bGEKvj9xDi1J31z2AJ6S
         6cagyYekHVGXdj9ZqewbfEWSNDwFCW2c+M+7tXxLzkqZ2I+cMUdw6P0Rs2ynu/tgG3Kl
         Q0lQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0mkDYLvWuo5qAWN2tuzpeFzmTi/cX/xZUmzXs+GQS/USInhyozk2ii9PuA0Pcil6HpKrOwc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmQUgA7iWqoh582Ym4hBHs6sZ8YWM3rF+bYnb0K7Zpoq8ykS50
	/p3gSfWlnGC1BNxI5aUBUMbBTneUa1uGzmXT+k1fBDAlFa7iPR4U3YRzZVBI6SMEQ2y5J0sOIuw
	9KDriUgUyvcbw/NNICPE/sNCL9jC7fapvMl4NSP9ONo2mk/L53EP/Lw==
X-Gm-Gg: ASbGnctRZO/H/+6l8a7FFB59BtN+Ihl94yfcldkviJTSaisWfhBmhc2eggQneIHj06J
	IP+nt2CjObjGH2jihIxbolZd3ti+qabkq4ARjjNG4x7DeICaK8tg7GOkMcQo6tgy2uV6CAYcG6M
	21MRIPlVk4d4Ng4oCXt2lUHfoPxkwwZoygK7APdK477/WdT1hmziSkLqkWWsdwCPuc03gQafv6m
	xRAeXxYaqODM7JVV1mZaRyucUbJJN4Uu3GUnW1ea3OexHwLrChI0B2PB81AYV6HXCRbtnKIA+e3
	8Eh3mZJaF796A1envQ==
X-Received: by 2002:a05:600c:4810:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-43d01d0b53cmr46484105e9.3.1741700995549;
        Tue, 11 Mar 2025 06:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Hv1NOnvAcp4QoD/nLfHVoFJo/dM1I2YUVp0fFSStDz79xkmC33u8lgWGfzJ/p17KRXTCmw==
X-Received: by 2002:a05:600c:4810:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-43d01d0b53cmr46483615e9.3.1741700994925;
        Tue, 11 Mar 2025 06:49:54 -0700 (PDT)
Received: from leonardi-redhat ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d020b7e5asm30877635e9.22.2025.03.11.06.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 06:49:54 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:49:52 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Message-ID: <4pvmvfviu6jnljfigf4u7vjrktn3jub2sdw2c524vopgkjj7od@dmrjmx3pzgyq>
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <a96febaf-1d32-47d4-ad18-ce5d689b7bdb@rbox.co>
 <vhda4sdbp725w7mkhha72u2nt3xpgyv2i4dphdr6lw7745qpuu@7c3lrl4tbomv>
 <032764f5-e462-4f42-bfdc-8e31b25ada27@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <032764f5-e462-4f42-bfdc-8e31b25ada27@rbox.co>

Hi Michal,

On Fri, Mar 07, 2025 at 05:01:11PM +0100, Michal Luczaj wrote:
>On 3/7/25 15:35, Stefano Garzarella wrote:
>> On Fri, Mar 07, 2025 at 10:58:55AM +0100, Michal Luczaj wrote:
>>>> Signal delivered during connect() may result in a disconnect of an already
>>>> TCP_ESTABLISHED socket. Problem is that such established socket might have
>>>> been placed in a sockmap before the connection was closed. We end up with a
>>>> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>>>> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>>>> contract. As manifested by WARN_ON_ONCE.
>>>
>>> Note that Luigi is currently working on a (vsock test suit) test[1] for a
>>> related bug, which could be neatly adapted to test this bug as well.
>>> [1]: https://lore.kernel.org/netdev/20250306-test_vsock-v1-0-0320b5accf92@redhat.com/
>>
>> Can you work with Luigi to include the changes in that series?
>
>I was just going to wait for Luigi to finish his work (no rush, really) and
>then try to parametrize it.
>

Here[1] I pushed the v2 of the series, it addresses Stefano's comments.
I use b4 to send the patches, so one commit looks "strange". It is used 
by b4 and it contains the cover letter.

It would be nice to send both tests together, so whenever your patch is 
ready, feel free to open me a PR on github or send the series directly 
in the ML :)

Cheers,
Luigi

[1]https://github.com/luigix25/linux/tree/test_vsock_v2



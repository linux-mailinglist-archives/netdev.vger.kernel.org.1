Return-Path: <netdev+bounces-147761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9B39DB9B2
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 15:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A432819FE
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 14:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EFD1AF0A0;
	Thu, 28 Nov 2024 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPQUjaMe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BBC192D77
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804447; cv=none; b=hg4n1PpJwNFSq+NbICTNex1rumGEulrSTcgOGUAzjvTmhi3oOOLJgiyor9Boa5ODMy4rvPeFbNYZMhkAejTxXoXify15feVzEt6cEUJ4uXK+Was+EJCIUZqG0wMGO7aJRH++PqOGN4lpVkYdS2pLqKaZoETSQ4sGmOewUmlclOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804447; c=relaxed/simple;
	bh=gdLUI1umdb/rW5MV+Vie2SqmLyB0r5FRY7XWGNb7lEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WD0C1YLd/9XH31DbbWZjifSCS3ZQVP1J8GGZsnR3SJ4IvbJQXauKxeW8c6iV76hCNd17cfDlznWw9siLL32U2Dm0MRPY8fEOTUs3g/4wGiBUx9UwIMw5HGjSmzmuD6ft4/vkcEc8RUASThGjhvwPNJUVVFzmZNxnE6/uCp7r3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MPQUjaMe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732804444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xa1GFFWBjwObkzYkodtut89seCqzVlMLu2RNr+6Yzzo=;
	b=MPQUjaMeN/eotmGTo+WkhbAVxiAX4AVnUwEDTETaGUuI0kklhpRkQYzAwVkQF0qeTmgiJb
	pLWpf6vSZ55Dc31EDITv2hLJPmdT9tMPnlaOllOUJZxSmaVuSkLvp9TLR9KahMmOzyBuQw
	pydSk7VdIgDEniUdKdf84iK9l1g3rlE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-e6ccXJIAM-KpMXBYR4ziDg-1; Thu, 28 Nov 2024 09:34:03 -0500
X-MC-Unique: e6ccXJIAM-KpMXBYR4ziDg-1
X-Mimecast-MFC-AGG-ID: e6ccXJIAM-KpMXBYR4ziDg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4349d895ef8so8362555e9.0
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 06:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732804442; x=1733409242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xa1GFFWBjwObkzYkodtut89seCqzVlMLu2RNr+6Yzzo=;
        b=vz2t0TSs6g/XTDXWkkQbjv+EukXPgDNGrzsY9YY14OpttVs4O4aW1rbLA1Av1PEo30
         jDGzO45j2S0JmPvlD3dOd6xotD7hCljyv9HVGJj9O1mYUCFjWAwWIkjYz1wXGqeGl+RU
         PaYmuc8PDoPHd273F4SK7iXmCZlG90AhupeuzXzy3NHmtkt2wz538d89W9dUFrxUMlZK
         rFwrnFElIRD2ht4ComDDNJ1FEG0z61BhT1PNGp6hxJjVnjYYsCCBv4SoBDVObiachjuq
         bnkPmyF69Q1HA50e06RjgIfSbjGA0qSpPQ/epnapYckr6clRk8cOlXXOG1pHR6B8yADn
         Wp9g==
X-Forwarded-Encrypted: i=1; AJvYcCVjX0hYPCzrw63V9Vafx5PavIEhQ/nQXgsve7qriPoj+Cqevv+QRu67gO9Aakggo5eL7iieyj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHnlRflSr74jSQNJVtd23IMIL0EIm+EW5Ln0dEcXZMWmtfmmbM
	vf4WTfNtnVJSGYWx7BNggNToJPDeiGDevJqhBc4SO7FZTp2/jEwtY2KA6hsE5jNmNSFRCn3AWaM
	l/VgHt1baIEuEqYFX32ZLdzA25Hiq1qI9WQKUCR+vb+CQHrRqiD28gQ==
X-Gm-Gg: ASbGncu65+eT8bRD0xRj5fM/hJEnP2WZKaaesiVIYrX1/D0dGa+6aJXK4CPEdGVfa8t
	XIdYHx2ZzKdtHNaKITQNrv+WDSzQJ+8h22zgxQiK1Wini65fqo8Y8VkBGu1Yg6nDiN9r/X8pv2z
	XWyiB825Xnx2OkDyVo3duqBJy/Lzu9aJH+/h0CHDbrziPIofCzg+lEZ9cUcAq3+Yb7nuKRNyjQm
	pDTO+QycXZFIxoPl5hLmmd0YDDcRzV/hKq+zEKYrp98B4XNwQY+x6kaemockuQCcOP4k3yvOO82
X-Received: by 2002:a05:600c:458b:b0:42f:8229:a09e with SMTP id 5b1f17b1804b1-434a9df7b85mr69158555e9.29.1732804442043;
        Thu, 28 Nov 2024 06:34:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGSJwAZufVlwux6fyvnWoUoLuDNYE+JXwRvg7ZKjaI2N2OLZle9IsMIsJNi3GMwOw5YRJ3UQ==
X-Received: by 2002:a05:600c:458b:b0:42f:8229:a09e with SMTP id 5b1f17b1804b1-434a9df7b85mr69158355e9.29.1732804441715;
        Thu, 28 Nov 2024 06:34:01 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70cbfsm24154265e9.36.2024.11.28.06.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 06:34:00 -0800 (PST)
Message-ID: <d74075e2-8e82-4c7d-b876-398f4880d097@redhat.com>
Date: Thu, 28 Nov 2024 15:33:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v2 0/4] Netfilter fixes for net
To: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
 edumazet@google.com, fw@strlen.de
References: <20241128123840.49034-1-pablo@netfilter.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241128123840.49034-1-pablo@netfilter.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/24 13:38, Pablo Neira Ayuso wrote:
> v2: Amended missing Fixes: tag in patch #4.
> 
> -o-
> 
> Hi,
> 
> The following patchset contains Netfilter fixes for net:
> 
> 1) Fix esoteric UB due to uninitialized stack access in ip_vs_protocol_init(),
>    from Jinghao Jia.
> 
> 2) Fix iptables xt_LED slab-out-of-bounds, reported by syzbot,
>    patch from Dmitry Antipov.
> 
> 3) Remove WARN_ON_ONCE reachable from userspace to cap maximum cgroup
>    levels to 255, reported by syzbot.
> 
> 4) Fix nft_inner incorrect use of percpu area to store tunnel parser
>    context with softirqs, reported by syzbot.
> 
> Please, pull these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git nf-24-11-28
> 
> Thanks.

Oops... I completed the net PR a little earlier than this message, I was
testing it up 2 now, and I just sent it to Linus. Is there anything
above that can't wait until next week?

Thanks,

Paolo



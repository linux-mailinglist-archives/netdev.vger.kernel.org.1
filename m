Return-Path: <netdev+bounces-59819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448F581C1EE
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 00:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF87FB237A8
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 23:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E05579975;
	Thu, 21 Dec 2023 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnNxhZAx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88B17AE9A
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shakeelb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-db402e6f61dso1739084276.3
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 15:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703201026; x=1703805826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cU9mOyLPoF6ZxNM7jnDLVtHU9dKeo3lsrx7E6D/L6sI=;
        b=wnNxhZAx2RX0s8u6x7TtIydkNLm9qrU/5oV+9s1dYUn/reNnhbQcTmYo412fswQsde
         GTe9gBz4/PxwrYLPd7c8jYKNA+Gt64zuW02eb4Tc74FAARKDjPbtiXiS0Eco9wdbYbxj
         EjeRxMWB5ROkVOvQmNr7HbKbYZSReB20ppFx6qDbB44V0vHxVHylDsO3yT7JxT0H7kw4
         qBb8RTQucI51BXHWCUmLaFFdjRGJeHFZW9FVI8lhXA5W62Vt9XFzbCBwTF8QlMRMPBRi
         bqN8xg9zjgUyu6uTIm+EBxBtkou4FKqzNYDPOdDvXPwiD/ujdwsyGI0lQvUM7OX5vsuy
         LHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703201026; x=1703805826;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cU9mOyLPoF6ZxNM7jnDLVtHU9dKeo3lsrx7E6D/L6sI=;
        b=urmYi/ZUjIzMd1/I00Th3sVpEJBVnJjegGw8k+WGpU/Jzg7vzyMiOBmN9yVjW7Clr9
         c7PXXC6CflR0YJw655fEOrDynvv9Q7p287e9bzJ5Sd5meMvHUw4GYjyKW++Cn13JVqSu
         iHCCzl5n4UgC4TkDewE2xM6ZeepdntaGGve+hB/3hTBBJbpR2Aj/vdyjB/t6Y2Oq2cKB
         gtlN3kYbCuPcwqPD0ka8xgXRF+rhMKJ6/DoXUYYMAYWBn5sfy3MOAZGyTyQF11+W2sYU
         hdEFpWHh/iEMg1FI/bx96QhAIkjPizU6NH9gUaxK0wyKfkQ3sWbUpjo/wHG1j786mxCl
         lkOg==
X-Gm-Message-State: AOJu0Yy+pO9HGXi6qXUefhIXt2vm8GLNv+WucerfKl+OM3K/DCFXr0iN
	nfBOQmIigVN8NhtirW8jFQH0OMWHvxxq546IPp3G
X-Google-Smtp-Source: AGHT+IHWiT1s/e6el8Gbfa2jmdYfbMdaJTd+pS4T1tXJHPKsVM+5WAmrvhPrUoUOQ5Wk4tJyK70wKIQ5Qx+mgg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:bcc2:0:b0:db5:47c1:e82d with SMTP id
 l2-20020a25bcc2000000b00db547c1e82dmr189052ybm.6.1703201025720; Thu, 21 Dec
 2023 15:23:45 -0800 (PST)
Date: Thu, 21 Dec 2023 23:23:43 +0000
In-Reply-To: <20231220214505.2303297-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220214505.2303297-1-almasrymina@google.com> <20231220214505.2303297-3-almasrymina@google.com>
Message-ID: <20231221232343.qogdsoavt7z45dfc@google.com>
Subject: Re: [PATCH net-next v3 2/3] net: introduce abstraction for network memory
From: Shakeel Butt <shakeelb@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	David Howells <dhowells@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Dec 20, 2023 at 01:45:01PM -0800, Mina Almasry wrote:
> Add the netmem_ref type, an abstraction for network memory.
> 
> To add support for new memory types to the net stack, we must first
> abstract the current memory type. Currently parts of the net stack
> use struct page directly:
> 
> - page_pool
> - drivers
> - skb_frag_t
> 
> Originally the plan was to reuse struct page* for the new memory types,
> and to set the LSB on the page* to indicate it's not really a page.
> However, for compiler type checking we need to introduce a new type.
> 
> netmem_ref is introduced to abstract the underlying memory type. Currently
> it's a no-op abstraction that is always a struct page underneath. In
> parallel there is an undergoing effort to add support for devmem to the
> net stack:
> 
> https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@google.com/
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> v3:
> 
> - Modify struct netmem from a union of struct page + new types to an opaque
>   netmem_ref type.  I went with:
> 
>   +typedef void *__bitwise netmem_ref;
> 
>   rather than this that Jakub recommended:
> 
>   +typedef unsigned long __bitwise netmem_ref;
> 
>   Because with the latter the compiler issues warnings to cast NULL to
>   netmem_ref. I hope that's ok.
> 

Can you share what the warning was? You might just need __force
attribute. However you might need this __force a lot. I wonder if you
can just follow struct encoded_page example verbatim here.



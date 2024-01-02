Return-Path: <netdev+bounces-61023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3661582245E
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494871C22AA0
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D216168CC;
	Tue,  2 Jan 2024 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ink1npCd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3009168D6
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3ea8d0f9dso12365ad.1
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 13:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704232469; x=1704837269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naHyzOGLH6on2mA2NF2XfZpujt6bFyS08XuJbB6W+nU=;
        b=ink1npCdsmV0JlUEA2MKvBtYYazz+sQVmh39qcNpANr4XT4Mqn7Yaw+SbiHDbjkx5x
         UbneNWCtpzVWwzc/kEF8mw5msgcOHGNjsERxWyKfTix4u07GZPIB0NhVUjyYUpnU9M5T
         fseY+G+pURKXOVzR2osp80JfuaxfOHmkqT5EX3sMf1dIunG1qqMyM4l8FIl10ZZSnAwW
         nHePYRb3zvylbzflZ9E74oaNJ3y8jhUOVNGsjNg3Fbr0T31vmzIgVS02ngAxk2/DJWyq
         yjV6MdIpd/6XrLbRYdj/8uvxPaJZ194g6lveCxoygZ05WkXhFhD2XC0ssTHSJ9uF2uFY
         je8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232469; x=1704837269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naHyzOGLH6on2mA2NF2XfZpujt6bFyS08XuJbB6W+nU=;
        b=loASkfMe+Ln0eRISyKgjCztO/VDJgzZmXmbRYrJxNZQFeAS6xyshZ5Tnh9RYy4vJBf
         DntcwA0UMZy68yMjJdl2WGU+nXeDnfc7UB5SAMXTzjNsTWSQv8igzTlisx7Xv8e8qB7S
         KIk3TWlh9PJc7A4tsoXf9VC4dvZskMLeQ+Z2sUg8/zq7LmfKaxUw1m2zusrcLkPMvhTc
         tZymwDlo7vhMX/7jtz+fWL7yGmwlMBxg79ZcAUxqR9SwY5kce9SuwfbgwxhrE25ZW2aR
         2azquzxcNDBIzwbCj2LvZCMqZKVWXdkMqvillMzUXNQVhSm0p4lACf/0ztu1GKZoovUO
         cygw==
X-Gm-Message-State: AOJu0YyTddtlX3UN8yCkF6Pt8lsRuBtqP3RoC+HPHxlxckPA8nCO1B6f
	7y5E6XKo6hULyAKjnlK5UQ3EX23eHktGMu91vg517bo6f626
X-Google-Smtp-Source: AGHT+IHkQBhw77JEsp5z2FkDtZxVR/uFp5PLGzvREFfOFuN0eSkSHjU/8rnVNW/sqbY5wQ+2jwDOYqUcqXNyIYwEMbE=
X-Received: by 2002:a17:902:fac5:b0:1d3:ce75:a696 with SMTP id
 ld5-20020a170902fac500b001d3ce75a696mr863plb.5.1704232468929; Tue, 02 Jan
 2024 13:54:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102212716.810731-1-almasrymina@google.com> <20240102212716.810731-2-almasrymina@google.com>
In-Reply-To: <20240102212716.810731-2-almasrymina@google.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Tue, 2 Jan 2024 13:54:17 -0800
Message-ID: <CALvZod43P7r1Ak=Og2ssXN1Jg1A25AYKDTP4j+qJj1z4DxucRw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v4 1/2] net: introduce abstraction for
 network memory
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 1:27=E2=80=AFPM Mina Almasry <almasrymina@google.com=
> wrote:
>
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
> netmem_ref is introduced to abstract the underlying memory type. Currentl=
y
> it's a no-op abstraction that is always a struct page underneath. In
> parallel there is an undergoing effort to add support for devmem to the
> net stack:
>
> https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@googl=
e.com/
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>

I think you forgot to update the commit message to replace netmem_ref
with netmem. Also you can mention that you took the approach similar
to 'struct encoded_page'. Otherwise LGTM.

Reviewed-by: Shakeel Butt <shakeelb@google.com>


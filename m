Return-Path: <netdev+bounces-50863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B927F75BA
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 14:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4E81B214D5
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC49228E2C;
	Fri, 24 Nov 2023 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KHw3bi9v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25143171F
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:54:35 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-548f853fc9eso2609507a12.1
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1700834073; x=1701438873; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9eHy0dSzicYIzKgQVzxAaUPEW0o6COLRRR+CISGa0o=;
        b=KHw3bi9vyfIZ/IANzBSmrpqD7ybQmPQlbNd9bKzZ3EQdiR7G8ZKhhlmg5lAVXGEIVi
         n4H2ZZjvNTac8BYc+6eDodbvA/wbqazVwpLRYG9zeAF7LCGjrX6jKwfozqWjAhsVqjbC
         E7C+Q+eI4kzSf4AHa7/rWgnDUZYj2bOwd1HAmeVQ6xkEJ9DNymbKVZPKR6tug7Yd20G9
         Bbkop3m2ANY5Ybfpay/b0rD9PwkjSVQb/pKlmaLAk1BgOpKwwflSGACqXbLQwZb8ecmB
         1QWkvhP6gOK9Z3rQNQW7cd9LT+YMgzdgxaUNIxPK8bxS9kqLRzMf8LRrAfxdGLzcVx/A
         MW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700834073; x=1701438873;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9eHy0dSzicYIzKgQVzxAaUPEW0o6COLRRR+CISGa0o=;
        b=LEhe2pD3OB/qjDBcGyOaRcacvtcoIoTnvJZc2F7HQ+A2GRpam+po0Z1dCysH3kf4Ey
         cLCAnDC7UU9uMN9kiq2eL6zB1ITPrOCPJWQremKuH26igbcCC74AWGF4z6kqeV8Jy1Hr
         mgq2Pcm11C9F4HLDR2MYbVt6y2XQS4nzLmlGUJN+PO97SVxSn1zJaT01Tly5dUgP1U5S
         Q/yA9D4EnqDxRLNQmZuswWhTXRddwzBeNBgyD6hXm1upS2V92bi95foFsVne89GB5V/V
         73l8k9oR6lAUo1fuZ8yBeP847sQ6oG1vBW6wVdCYFeY8Ohgc0FckVEuLVMdLLsiiNDr8
         bqug==
X-Gm-Message-State: AOJu0YwfqTAGhgQVXC7OrSc39/oHNtYmUwgUw6FCYsVXlZym6eBtLfrF
	U9SHHjmFiiperR5xyw0NGqP+6w==
X-Google-Smtp-Source: AGHT+IECeVHyYjcvdwu9fK7q92eBt+GRWg3vMwoSJ12YV9YONcne+klrN3G9LlX5FElx0hXFwRCs7Q==
X-Received: by 2002:a17:906:4557:b0:a04:a111:4901 with SMTP id s23-20020a170906455700b00a04a1114901mr2449120ejq.18.1700834073619;
        Fri, 24 Nov 2023 05:54:33 -0800 (PST)
Received: from cloudflare.com (79.184.209.104.ipv4.supernova.orange.pl. [79.184.209.104])
        by smtp.gmail.com with ESMTPSA id bk25-20020a170906b0d900b00a0a2553ec99sm286978ejb.65.2023.11.24.05.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 05:54:32 -0800 (PST)
References: <20231122192452.335312-1-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: martin.lau@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf v2 0/2]  sockmap fix for KASAN_VMALLOC and af_unix
Date: Fri, 24 Nov 2023 14:53:52 +0100
In-reply-to: <20231122192452.335312-1-john.fastabend@gmail.com>
Message-ID: <87v89r2r54.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 22, 2023 at 11:24 AM -08, John Fastabend wrote:
> The af_unix tests in sockmap_listen causes a splat from KASAN_VMALLOC.
> Fix it here and include an extra test to catch case where both pairs
> of the af_unix socket are included in a BPF sockmap.
>
> Also it seems the test infra is not passing type through correctly when
> testing unix_inet_redir_to_connected. Unfortunately, the simple fix
> also caused some CI tests to fail so investigating that now.
>
> v2: drop changes to dgram side its fine per Jakub's point it graps a
>     reference on the peer socket from each sendmsg.
>
> John Fastabend (2):
>   bpf: sockmap, af_unix stream sockets need to hold ref for pair sock
>   bpf: sockmap, add af_unix test with both sockets in map
>
>  include/linux/skmsg.h                         |  1 +
>  include/net/af_unix.h                         |  1 +
>  net/core/skmsg.c                              |  2 +
>  net/unix/af_unix.c                            |  2 -
>  net/unix/unix_bpf.c                           |  5 +++
>  .../selftests/bpf/prog_tests/sockmap_listen.c | 39 ++++++++++++++++---
>  .../selftests/bpf/progs/test_sockmap_listen.c |  7 ++++
>  7 files changed, 49 insertions(+), 8 deletions(-)

Short of the nit pointed out by Yonghong Song:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>


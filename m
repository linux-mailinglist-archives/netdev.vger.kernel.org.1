Return-Path: <netdev+bounces-123472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C969C964F19
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A931F23B08
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C561BA86B;
	Thu, 29 Aug 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vyqjdfwa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D711B9B59
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724960312; cv=none; b=L3b0H7GQNxO0L/6KN2Y6iv/jzHxFIvh6xgx4XFigVUqLxY4RWzS5E26l5BMijxDVq7lTHq9V1VbQ6AvYDBS1XjbOYA37KmQGgmdqqroPhBmZ4pZXM2TNt+fQ9nma/M/NbqQ1eOgyficBXSvrAMbYt2yzBsOV8qfQ6AfV1SoIvyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724960312; c=relaxed/simple;
	bh=4ASADOnCoqNrKV+beHl14a4vrTkq7UjCX+g5PUIp7tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6BVz6wdU8wIC236YoDscVMA/YZqjOE6WmTtezlCNWdXrMA+CZ19eHYbSjYqVsJbyY4URRZecVyg+eo0yPuiNfzuoPFNxqA28ChVyZaTBxrATkiocOWHijuG3h45h4D7T4xSr5CyjlyNkG6S6/+HG5e6yD2eSJjn0CbZoeiCU9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vyqjdfwa; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-45029af1408so5251cf.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724960307; x=1725565107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZUAgIcTyrR43pe3gP0emMAssjHjCGemTU8nsF1ejxc=;
        b=VyqjdfwarXMeB4Y4INlQGUPhZkirtCNWsnj7M3szpM9Xkt7avb/e7YL2r2AdYlJkCS
         /Bpf7hR7X6IlL1U00gOg9VKWrTicKAP4a4yqJWgpfD21VBRGI411IWdBSUD/5Y7hsg9E
         wiVrzRVTIUriossLHYwrF3NOTBlUA3fP1JfXXgA9ryu2/FdUqqHMT8zgBxP1tTSWZWlL
         QCyKGDNZFHsNdIEwBTf7SgOpdzJpSQ9AKGvSvwmWIzeVHSp0cwe2o0wB9IAFaHfCkgXB
         wDw8hEMaWDSzGdgfIQ/2EvAJXL3hA9d/YHiz5Hi5yCNbiwnKJ3rLPdpN++PpwyVTZWmo
         hrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724960307; x=1725565107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZUAgIcTyrR43pe3gP0emMAssjHjCGemTU8nsF1ejxc=;
        b=bYqa/DO3djEuSG4FaxKNAl1meAv8F7/uo2U80dtqlDQzV7jE1TUndBduH+6A+pJ2+E
         ScXMp1FuXbs997KbPAWAa70ujQwD2sAVNeaLJZhUqsm9cVMnypmje1xiWDlRf5yogewj
         jqhJGzDqoZs7yQoWNCMJ+/EHNCTSej2ZQ1LFVzUpBOjKu4Cip4nuFjZ3zPxx6/OFwBnA
         Grf5so40XhKZFCO0yal84bN7p8mxbcKVp9skwo5e5MNTBcAyFsDsd8ut6ZMOtbofahH9
         mNNrWkcMCHdD6bccTmUffvEX1znBXIJwxKj4ZP88dqvKuIjdEyiNCHlMwAAjA8cJX71F
         5/1A==
X-Gm-Message-State: AOJu0YxU1TxKnUM2ZE6vA2bui26cV08Co5dq4eQbIL52NZqsQR+PYoei
	XlYXCDUOhb8aBqXWKTxPGxdsHQT4/wsfJXpLw3/LS+EDlBckynM5utPEPa8xoD+gUGre3VvcF1w
	WYswW8KIw0C6JzcHLY9+BoKOsdBQLRIrQgJhTc8ZL3/kk+bEx9Ees
X-Google-Smtp-Source: AGHT+IEckjBQSLEDMwf1jYHRwORJ2ZVKtBH36SKJpIYMP8NrCeogwJVm7Q7nebuPSmPKh9r8A+fJeiK+617lAC3ocsU=
X-Received: by 2002:a05:622a:281:b0:447:e59b:54eb with SMTP id
 d75a77b69052e-4568aacd777mr496041cf.26.1724960306474; Thu, 29 Aug 2024
 12:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829060126.2792671-1-almasrymina@google.com> <20240829060126.2792671-4-almasrymina@google.com>
In-Reply-To: <20240829060126.2792671-4-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 29 Aug 2024 12:38:13 -0700
Message-ID: <CAHS8izMCZbynEQQ3rPs2QaEbD51ew7VK0sMziBTayCi2yEZ_EA@mail.gmail.com>
Subject: Re: [PATCH net-next v23 03/13] netdev: support binding dma-buf to netdevice
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"

> +#include <linux/list.h>
>  #include <uapi/linux/netdev.h>
>
...

>
> +#include <linux/list.h>
>  #include <uapi/linux/netdev.h>
>

Darn, I went too overboard with sorting of includes. ynl-regen.sh
wants these in the reverse order, which is unsorted. I'll fix it in
the next iteration, and I added this check as well to my presubmits.

BTW I submitted 2 iterations already this week, Sunday and Wednesday.
This is easily fixable and I can resend before the end of the week,
but if I'm stressing NIPA too much with reposts of this large series I
can wait until next week. Sorry about that.

-- 
Thanks,
Mina


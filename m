Return-Path: <netdev+bounces-236063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AAAC38280
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67BCF4EBA2B
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9DD2F12A3;
	Wed,  5 Nov 2025 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jLavHGc9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D72F0C48
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380940; cv=none; b=KjzlSKJzwSq5H97yVUfxKDiFgVmGzHW+7wM52rMKoHDF60XHVwHRy2RoW1HeJz5i/lO5I/QQ6zBEJcLNJDAKW5k8AvPbtmMzm3FoZiIQKwS0Bh722EJR4ZITWSOvR+MKKXDVGUnv5QNXrDn/Y3Q+wVnrb7vacH4kzoCyMMUoOVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380940; c=relaxed/simple;
	bh=OdLOMgZW2KFI0N/w5SzMnELwpkeuWZuR5Xrnqu6OWos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lIhEelm6+d1ve9qTs+A6ahALyatuUoDKHiv2+piSHwqVTjRU3usHwzIhemQu3Jxe88wII6FoMVQ62KgFTFGcbpyYnjlTcQ8ysBFCoQGo/offNxbkqRay7/UpDZ0c1Ab6UAHxnRZbefahRAdWbMkSrxB/DFRpo9ip0modkVzjJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jLavHGc9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2959197b68eso24075ad.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 14:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762380936; x=1762985736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3lvSuLZZH1/RCKxfhUKoqbWv/FK7QWkV+OjY9CUFeE=;
        b=jLavHGc9AmMCnGBjpx4oxnqWBbwpHgQ9cFmM/FluprsBdi07PJF7uFwu8vBXcYODPX
         xwikDsH6USs7ZeRDbgRKLGegRXkiqV+haqj+zymAheZzeoh2A3KAmg7DsFrHk3/NuENO
         /alYfv/lFORi/aiWMUVkHZdoscvn05PLn55A4BG0oZOg3g4e0sd83sF1Wn47gLaRabwA
         ZhgcXFDWD9bLqER5aEZpG6D2EVBzSGVVuXaXL09C16+WbyeztA5IlfX0kJ0YxCre5gCK
         CbTry+6vDPYF2I9rDyGJV8A9X7NPXIKSscs5slg+04VARM38l6Dh3wTWR016I+r3stgA
         3Hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762380936; x=1762985736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3lvSuLZZH1/RCKxfhUKoqbWv/FK7QWkV+OjY9CUFeE=;
        b=iLYm0XrGg8iAW1HIN0QKJOQOdXm/qdhy9QTd7qPll3I3YtW0bBiii6v55aOvnNwcsP
         UBuVkeEh4SJ5Nrk+seqTqEiJmw88NEyGQMNvaEq1Y1o3ykkyU9hqgLVGcOtvKQykQR9U
         XQ/rfih6HpF9pVum7ThCf1QTJYc8S259/7FUa6hEZLhLcxBhztgBY6v4mUo7eM6amgn9
         fuGkpkw2pNzMBZyQYjF3ZK2qBUUJPfeGNtTcVQZ+A3tqDnpT4reMBG3qy+3uh0EeW3qD
         /OWdNEoqqsRrSTSHfM02pQ1RxtRmIpHCTkDu3+xOCALuuLLBV6qvF4CLogO61NFIQEdj
         kKvg==
X-Gm-Message-State: AOJu0YwTBrI5qdGYpJSxym7MW0A6P/NGawuTGOi7KurDpSSWSc6QjluS
	y4J+owUwO8vQnRVMlVUI3PEhA97m+gZYJBPcfrOzbKbWr6cR+pssyG77UreABhlpLdQZnrpOuVE
	T/o0yOqlsdXL5FaEPRfBSo4fVUtesyV8DwWwVjLIY
X-Gm-Gg: ASbGncvDD+GWE7O2onfi7XD1W3WsRh/Wa9XOq3Pu6GwlDHXVMx+h0QsyBRAmPqK32CL
	8vt4L+FpQlyBb4rEN9LFL7pWSg7EICk+R/GppA6ph4wal/Hg3m9MiImu0PshqZJ6ROVw+Ik0qk8
	awBxOUj87SEq3IwNaKON93tw5gqhiRJ+cTH4P+rtOkWIDQ1bmaLDWsly6llraISxyPTZEW3osF0
	TbVl22r9Wb5G2eELxH+SgUPcWBrBhCk83+3COqhUrF9bocreRLRMcbhYyFD7qDU6+wl0eycnkqG
	2tHfcQyb3fcMLEpRARsWsLqPGgc=
X-Google-Smtp-Source: AGHT+IFGwzwV2PdBnmzL8mXgRan2fERw/vTgCOurKJjFHayrcS30RBuqNtvLgGgDdlXer4FCuzFSjd5/uaLUw1FVlNs=
X-Received: by 2002:a17:902:d505:b0:266:b8a2:f5d8 with SMTP id
 d9443c01a7336-29655c7a119mr1520385ad.14.1762380936033; Wed, 05 Nov 2025
 14:15:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105200801.178381-1-almasrymina@google.com> <20251105200801.178381-2-almasrymina@google.com>
In-Reply-To: <20251105200801.178381-2-almasrymina@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Wed, 5 Nov 2025 14:15:23 -0800
X-Gm-Features: AWmQ_bljffcDvUJLZB0ZodJS92q8_Zm_EPbfpoxwapkprjEWq5txJjOAYuwgef4
Message-ID: <CAEAWyHc4zxC2wKjbO5C8TL6B8Exm6sYQTMxdOihh0PFjFMTkrg@mail.gmail.com>
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC page_pools
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, ziweixiao@google.com, 
	Vedant Mathur <vedantmathur@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 12:08=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> NCCL workloads with NCCL_P2P_PXN_LEVEL=3D2 or 1 are very slow with the
> current gve devmem tcp configuration.
>
> Root causing showed that this particular workload results in a very
> bursty pattern of devmem allocations and frees, exhausting the page_pool
> ring buffer. This results in sock_devmem_dontneed taking up to 5ms to
> free a batch of 128 netmems, as each free does not find an available
> entry in the pp->ring, and going all the way down to the (slow) gen_pool,
> and gve_alloc_buffer running into a burst of successive allocations
> which also don't find entries in the pp->ring (not dontneed'd yet,
> presumably), each allocation taking up to 100us, slowing down the napi
> poll loop.
>
> From there, the slowness of the napi poll loop results, I suspect,
> in the rx buffers not being processed in time, and packet drops
> detected by tcpdump. The total sum of all this badness results in this
> workload running at around 0.5 GB/s, when expected perf is around 12
> GB/s.
>
> This entire behavior can be avoided by increasing the pp->ring size to th=
e
> max allowed 16384. This makes the pp able to handle the bursty
> alloc/frees of this particular workload. AFACT there should be no
> negative side effect of arbitrarily increasing the pp->ring size in this
> manner for ZC configs - the memory is prealloced and pinned by the
> memory provider anyway.
>
> Tested by running AllToAll PXN=3D2 workload. Before:
>
> Avg bus bandwidth    : 0.434191
>
> After:
>
> Avg bus bandwidth    : 12.5494
>
> Note that there is more we can do to optimize this path, such as bulk
> netmem dontneeds, bulk netmem pp refills, and possibly taking a page
> from the iouring zcrx playbook and replacing the gen_pool with a simpler
> fixed-size array based allocator, but this seems sufficient to fix these
> critcal workloads.
>
> With thanks to Willem and Eric for helping root cause this,
>
> Cc: ziweixiao@google.com
> Fixes: 62d7f40503bc ("gve: support unreadable netmem")
> Reported-by: Vedant Mathur <vedantmathur@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/driv=
ers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> index 0e2b703c673a..f63ffdd3b3ba 100644
> --- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> @@ -8,6 +8,8 @@
>  #include "gve.h"
>  #include "gve_utils.h"
>
> +#include "net/netdev_queues.h"
> +
>  int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
>  {
>         return page_count(bs->page_info.page) - bs->page_info.pagecnt_bia=
s;
> @@ -263,6 +265,8 @@ struct page_pool *gve_rx_create_page_pool(struct gve_=
priv *priv,
>         if (priv->header_split_enabled) {
>                 pp.flags |=3D PP_FLAG_ALLOW_UNREADABLE_NETMEM;
>                 pp.queue_idx =3D rx->q_num;
> +               if  (netif_rxq_has_unreadable_mp(priv->dev, rx->q_num))
> +                       pp.pool_size =3D PAGE_POOL_MAX_RING_SIZE;
>         }

Would it make sense to also wrap setting of the
PP_FLAG_ALLOW_UNREADABLE_NETMEM under the
netif_rxq_has_unreadable_mp() helper?
>
>         return page_pool_create(&pp);
> --
> 2.51.2.1026.g39e6a42477-goog
>


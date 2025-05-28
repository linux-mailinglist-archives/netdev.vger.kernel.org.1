Return-Path: <netdev+bounces-193840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBA4AC5FF6
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 05:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC23717A319
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 03:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FC61E32BE;
	Wed, 28 May 2025 03:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tKWeyXcV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48E12CDBE
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 03:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748402302; cv=none; b=HQ2k9trG8bv1k5aDBE734MFzLvj4xGdC05ATblooDQ4O5e6gjkEJxmNG/3+y8GizkWBWk3MCENzGCxzj7/dJ186DpIMXNKeRIFEHlbbbPqFjIsLljxZlqvDdsb3OXz2d+WUUdgT4VxBWvK89iLCOfDwdBcB8yGiakZZ1CZMcyBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748402302; c=relaxed/simple;
	bh=p0o8H/ZWP5ajJApvc49pdLseFqRSuUwEFayifU1/9TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0efjtn04NlQbKOvaqaHAAOtvB6LjoIK99J5XiL1sMEEjlrlakh0iNDHoKWAEYEdQtViWtKI6jyOW0bV4iVQTjVPf0KqERhYordlfvegB2l9woOaX6W+HrcboT1T6tt3wUFYRQM67nKZZda8ZrT4LsjkSsPhuggDhby/AxEkQy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tKWeyXcV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2349068ebc7so134935ad.0
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 20:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748402299; x=1749007099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0o8H/ZWP5ajJApvc49pdLseFqRSuUwEFayifU1/9TM=;
        b=tKWeyXcV8oOs+KloJ7e/InmbmldtWw13daPs2ZPSgyoqOiBmiqh/D5edX0e11kji94
         V7fs3TEXa7t6jSFckZ772r/ck3dKbrwzwS1kgxHAzveHubzMbNEn3TPj0kJxhIg0Ukzc
         57EDiJNKcHDzMpMF8+bHyY4Q2mTYUPTarM4pzAsQGesgelmhzscUmYqnDE2PccGTKXJ3
         v3phCkZvMmMnMkRb5ifY1J/MQjANNpPTnnYGgG5pOt6pKfpD4TbRBVruCS18pvqzSecw
         51ePgPWk20yBx+pERMOLQ8aljbc3mtncN3bMlKXWa8acnsgPiGADIOdgIQkKK6nzn29f
         swYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748402299; x=1749007099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0o8H/ZWP5ajJApvc49pdLseFqRSuUwEFayifU1/9TM=;
        b=qiU/H3PCIAoKSBXBAabTqu3IzMMk6qdiP7JCDRImpA97Q2qabfTxNKqpb5HCLWyODi
         9BhlkMoKpcRP3MHhUl/18xm5IZ9wUmAZnJH1qZEDz1VeWrFHKq7x/ArHH4MSCIbaoies
         L0cwwkVJOGSYOdowjjXz5fGr8R58zz7Na1hqMCiotp5dChpBot7YXDYaSM4KpcV2sbex
         lhsm7KMGLu6TtYH1EfGzeFFl8mSOI5iKfl3w+6UgOqszSC6TR3hf4kuj/FrOrPPUTNn7
         r/E/ezngLzvinx++8OWhyKmgmrXjLqwQetNn2HDQdpnd7vNpv5jIxMzYQl3CzUzwJqSP
         7PaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXizWz2ZKZBj/2avl8mJ9rrMaxH574pT2wl4YJTe5U3WQ/eiTb6EfxUloKHR0zg/5l41ncuMD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbXeSJ3yHrcUHL6A/p1ZHl3Vs1DlaRi2zO0uo0eelK4gRFjLIi
	y3KPnAO9DeYBtul68dhlwdMUaLli5xhCjFayjBPuwGYil01oRt3dlD/ytHViAf/Lb+uTrX8eXlt
	4BaWdIEQb/psTQi/uM/7tZNHJJGP3MI4zM4vVmO/l
X-Gm-Gg: ASbGncs0lnFbYczyesW8S+mdp/Me0KdYGmGemWpz1C+c+/XBuH5fxQAjvVHonChqgvk
	yrajUQVjYtLpFqN3TY62OX3VnzDQz/zfYJIaxmzPpymJDAjV775hqh3E5ZwAfS9iXdKDbP++w2q
	zEPZzj4ueItfDDtMrrpwiH4rH8T2+ypghhYZezjMwjcJE8
X-Google-Smtp-Source: AGHT+IHyBASOmSpQ6jrt38akPkcyDz5ZPwdAwA+jYpxd9Nbay9v2Ysdq8wuVjVilze9WFqafdNaHLI6g1ELAifk2Rao=
X-Received: by 2002:a17:902:e845:b0:231:ddc9:7b82 with SMTP id
 d9443c01a7336-234cbe2892cmr1015255ad.13.1748402298919; Tue, 27 May 2025
 20:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523032609.16334-1-byungchul@sk.com> <20250523032609.16334-7-byungchul@sk.com>
In-Reply-To: <20250523032609.16334-7-byungchul@sk.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 27 May 2025 20:18:05 -0700
X-Gm-Features: AX0GCFs9-vI-xN4yFg2bdl4ceoAUrTj04uXSI8vFV9kuA2D-mWZq_A_MtCFBCAU
Message-ID: <CAHS8izO8fqvXV2_83MVLCxo5z7DepRVaPWS6rymqputuhcrk5A@mail.gmail.com>
Subject: Re: [PATCH 06/18] page_pool: rename page_pool_return_page() to page_pool_return_netmem()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 8:26=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> Now that page_pool_return_page() is for returning netmem, not struct
> page, rename it to page_pool_return_netmem() to reflect what it does.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina


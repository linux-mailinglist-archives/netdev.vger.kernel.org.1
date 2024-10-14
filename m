Return-Path: <netdev+bounces-135072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B38C99C1B6
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5000281E85
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871A149C42;
	Mon, 14 Oct 2024 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X90ynpFM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0458147C98
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 07:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891735; cv=none; b=LbWmX0xmtI7XXTSrBQcVeQy20iWu6S3bIZ7mDKgHeOwP+GMcp2CuC6mrlD2ZpixSw7Nn0dnv3/Wy0hXiRtcCWMg3fXHMUT/WShIjj3UX9dWL/cqWDDxn9zTHG8cbw3tNXVRtlaozSwLblKVSzxuOhffO/YBueTCTJ1NifyUWsS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891735; c=relaxed/simple;
	bh=Tr8ZUfI7WuIJqS+Kbyv89NZrMjAzQlMLbG0EsH6Gg/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ey8lepTFYIBDLF8+95RL71d9v7Yv4UlZDaxxYtcKkVnpj5zNPOK5ZkgSVXQpECtTlLv0KuMAvzC4vvV6D43S9wiV0kKzn+pZ0kLH8NxBvqakrQrBJJXcnHXdIuqRAPWTJ+G7RIUZ6Jhc9PRRFQyLfmF9DKTXHaaB8EyaA8BLiIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X90ynpFM; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so3406919f8f.2
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728891732; x=1729496532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr8ZUfI7WuIJqS+Kbyv89NZrMjAzQlMLbG0EsH6Gg/8=;
        b=X90ynpFM9KZZZCzmHuC+gXQZ3gPfsk+uu+miwK1ej6Af9ykeBDzB1yYHDgO/Ejfely
         JKnfEKu0bJW49cRShWk4Wc0FEa64Z5QBNPMD+vl+l9LfssG3Bn8N74LEWNClfhAWLKth
         dHzCxoCVa4QzvoA2IEKu1v/knUsUCJ82qgQA0GxkfdCrvkWG6Gc2Fa5iE1tQLfLFznLS
         QrzR0hQmwE3CS13Ct2Tb2/eSwp7eRsEv64DVtDHq0FNZ5rgd72vmNs380mwbK9JGF5eN
         IanCBhhnfzdyEftjR0l2fYio+IqEuLT2/85s07lZUs2xcqqv58YnNrcwgJnkYiCR6OoK
         2fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728891732; x=1729496532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr8ZUfI7WuIJqS+Kbyv89NZrMjAzQlMLbG0EsH6Gg/8=;
        b=K9D2wrgvKOhJK4Yc4sURb11On/OL/EIRuYQx8toaARsVISkpV817oMvgjCStLW6nvs
         H2ToSOs0VLN/hRHrhdR15gtdf7RcDkmR2x1KxryWdXd+l+owiCKb9b0TPUuQnqpGzIMf
         RSLykU75iyOXT3hpD4X8/sP7QMHReItkvlZ2mQ/FFpXqrg8dnXHYfdvzrRPUqS8nWdn2
         pqSiCvKil6PjccXkIHG+fPIpfFuIi4KqtMOL5vclEYI8ddLjDbu/I6r/NE2lk1kMyzlU
         cOuRPW9wC17b0f8afTH+0ZlibIaGVVmi584Iu9b4Qh0/4ENoFnMhSOuKJeSkr5aogvP9
         YzGg==
X-Forwarded-Encrypted: i=1; AJvYcCXIHW26jv79KGQHgdyAq6Hh0+IQdcl3Uu3wBW0f5BXKfvg+T6yuRiQFaQfBFiEauYp9pJf9CuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl62v9QsOll6n7wm6rlsXtq/Z7z9tKdOGMqMPaBFlKhD0hwxHn
	2f0qy+jEIy90jHzg+g1EnAlxS9c9LUaIqc3HcFT3Ed8UJJkbDGMY8hepAeDYjnjkENvuhqVA1mz
	H6TECdiu2rKiEtrhRHvO+eNnEO0BWA2iU0xHT
X-Google-Smtp-Source: AGHT+IFanHxngXEXoSruIGL7Lj9eBY0UNJQ4Ee/B1N1FU2RBHqVnBPNL966Bm6XUd1wbTeZ7KNEgYUSxxBXPLPfuRfM=
X-Received: by 2002:a05:6000:10cb:b0:37c:cdbf:2cc0 with SMTP id
 ffacd0b85a97d-37d601e9acfmr7383958f8f.53.1728891732017; Mon, 14 Oct 2024
 00:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013201704.49576-1-Julia.Lawall@inria.fr> <20241013201704.49576-3-Julia.Lawall@inria.fr>
In-Reply-To: <20241013201704.49576-3-Julia.Lawall@inria.fr>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Oct 2024 09:41:58 +0200
Message-ID: <CANn89iLQE6uFHpTXq-MGEX+Wnn-BtFnbpC-bUu=zHu0Pw2dKYA@mail.gmail.com>
Subject: Re: [PATCH 02/17] ipv4: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: "David S. Miller" <davem@davemloft.net>, kernel-janitors@vger.kernel.org, vbabka@suse.cz, 
	paulmck@kernel.org, David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 10:18=E2=80=AFPM Julia Lawall <Julia.Lawall@inria.f=
r> wrote:
>
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache=
_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
>
> The changes were made using Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Note that fn_alias_kmem is never destroyed, so commit 6c6c47b063b5
seems not relevant.

Reviewed-by: Eric Dumazet <edumazet@google.com>


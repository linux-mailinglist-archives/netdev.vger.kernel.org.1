Return-Path: <netdev+bounces-248458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CA4D08B33
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3F843008162
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87DE33985A;
	Fri,  9 Jan 2026 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W4TbCNnq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E560338F5E
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955807; cv=none; b=PhZDEAJMciGtLo1dFBkNUZZbrFeEj5GRPZz7ewRlLVQUov6jj1xmI+Xda692GF9YSZexvd95ieRwsa4Fivr6t4er8sJgAONH2reRqdGCKbU4DvCd+PGSpDq+lWWpmWfS4Hjo25onncibsoaJn8WQnPFEPWs7D13Ni8EUIvqcg0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955807; c=relaxed/simple;
	bh=kAgWQkJ5yk/MYNStM3WlVvA9Wp6f85XIjpLeHbfgAQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bhzYGDNO4fSWr3BrifQMpZ96KBZSS9qK3qJdYg0lQ4/0noqAlUvJz+qI3NXAebjcwX7uMnFuL5W1FKNZUfuei5s5UvjABK17RT5j6ryzcNMjvo3tbGWrLnUeoYGuKASFm9rQuPIEBwzD54UuswdrypWKHUUeltosYyLPa5J82Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=W4TbCNnq; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64baaa754c6so5609030a12.3
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 02:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767955805; x=1768560605; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFjE5UMao2j4JAz5MJyWxNKmH2Rqw+0e59JALKeR3L8=;
        b=W4TbCNnqczI3gPJ9E8NxAa+YGg8KnswYtUlHeDZ5f4N5PSSRucdhpNalwhEjPr1BAO
         aj5sK3smAtNOJfVuD6NelqyAb8vakAMvjm3WD+7LKbHX1LzBufbv33o1+IwV7HkdI+1N
         XFWURMz9V9GpZmQ53x3NiZxEYm5NeyX5NzOeBs4nA8nOGGQT2xWfATJlaRN2YmjXSKoT
         n8okcIx3yRF0YBecerFytC9+tqwkfJDye+aKKTHPKRxIdREp400e9v0IB4MsG2SGB9K9
         psE9jqiv5xGxAmxuxLrOIDiZ+9e1LyoBmTYZ7BT5/OFr8aw3a2ruh5rq2Q0ppk8AuXrv
         JiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767955805; x=1768560605;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFjE5UMao2j4JAz5MJyWxNKmH2Rqw+0e59JALKeR3L8=;
        b=Wkvwe/rB1RLLcyJfwOxU2yao5qJ16+gI5LcpBD8BXuhJBLU/cDYCs6jeajY/0KL/Of
         iIGXeWO6odTC/n3lDkg6h/1fKy/jznn5MJ+hboLbxDF1I95he3aGm3dONv+VbnE5Dzw9
         8lB4glPEKyO6NaTKL/EPNLgmi4yKO0zL600GviiIAd7Um+g6QQayhSTJH+ycIyemOS+d
         wYgn5VxW4/mHrRd6Zsat4HCCX4quW1GoNMKwNjDL5Vgsg7ZSIg7mUFq22casbyoub67U
         agglyynU4yguGirJRWa/eS29iga+PEqDZK1l7RR2BR9v9DXvEt91X05KP3M4lDVEgqYj
         XySQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlaR0ZwDYoAZ2fGR2+h+kuu8dtNWTdKjP74XXqQLgX0esy1XKS+94aL6vkOtguSd547xMk5Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS95fwJAscfslkDMN3juXSWH4ki7wyr1H1jK0Bjdkqytbialia
	DBrGVQuuJhuhXCAzkZLR7YCsqWDPHanuBjvECKnKEoz2NyVK12XiD2V+pb9znMEbChk=
X-Gm-Gg: AY/fxX6WGtRCHdSY8kwRrKEmYobgiqYnGW8V/Oc611hFWnKrcvyOVKfBx3Y2SXuMXsJ
	GZRAu80wc9GjuQIyeSkptB6GDfSXAdZOAYzqgomB5gnmh5b1thgkj7Qcrab34pBR+l5OIV9kne2
	4s2rnBILzXQsuICwZkWhDGouvuVREjg3jUQpuI5lnKvudqMQBYpZuk3n2NVP6/15d1vYX7e9EEU
	PxXSJcj8MtGMmzzdnamfU4UiyzX6O9sYS8Rt5Y8FINKhiMzTIFU8Gt3zusVi6XSpjP5hEKLD1Br
	/4qLdMPV8CFLccBy4TX6wAIi7/r7207znuI/cstbKJKvDet9zOW4CX+hQ+9oB21zi/+uyBiJhri
	S1TXGgI0DCvtvwOQQYhWqFuzC8kOcWPYXH9XtIp6Mwb//VD26nHceHg9mri3MGY7dRCjRxke+qc
	h9sz7rQakBKsP8Gg==
X-Google-Smtp-Source: AGHT+IGUBZ5NlUYwTuvlC5bBR6YFkuq3nVxVfFstEiBG6clv3mYeTvUryHJruIxzhpf6L7f9weVDYA==
X-Received: by 2002:a17:907:a08:b0:b74:984c:a3de with SMTP id a640c23a62f3a-b84452837c3mr901273566b.28.1767955804513;
        Fri, 09 Jan 2026 02:50:04 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507be65197sm10018048a12.19.2026.01.09.02.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 02:50:04 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org,  netdev@vger.kernel.org,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  Simon Horman <horms@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,
  Eduard Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,
  Yonghong Song <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,
  Hao Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,
  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v3 00/17] Decouple skb metadata tracking from
 MAC header offset
In-Reply-To: <20260108174903.59323f72@kernel.org> (Jakub Kicinski's message of
	"Thu, 8 Jan 2026 17:49:03 -0800")
References: <20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com>
	<20260108074741.00bd532f@kernel.org> <87ecnzj49h.fsf@cloudflare.com>
	<20260108174903.59323f72@kernel.org>
Date: Fri, 09 Jan 2026 11:50:03 +0100
Message-ID: <875x9bhxgk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 08, 2026 at 05:49 PM -08, Jakub Kicinski wrote:
> To reduce the one-off feeling of the mechanism it'd be great to shove
> this state into an skb extension for example. Then if we optimize it
> and possibly make it live inline in the frame all the other skb
> extensions will benefit too.

Back to the drawing board then.

Here's how I think we can marry it with skb extension:

1. Move metadata from headroom to skb_ext chunk on skb_metadata_set().

2. If TC BPF prog uses data_meta pseudo-pointer, copy metadata contents
   in and out of headroom in BPF prologue and epilogue.

3. If TC BPF prog uses bpf_dynptr_from_skb_meta(), access the skb_ext
   chunk directly.

If that sounds sane, then I'll get cracking on an RFC.

We will need the driver tweaks from this series for (1) to work, so I'm
thinking to split that out and resubmit.

I would also split out the BPF verifier prologue/epilogue processing
tweaks for (2) to work without kfuncs.

Let me know what you think.

Thanks,
-jkbs


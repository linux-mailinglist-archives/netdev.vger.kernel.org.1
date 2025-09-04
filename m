Return-Path: <netdev+bounces-220094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6122BB44733
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE471C25145
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D6927F01B;
	Thu,  4 Sep 2025 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZzptI6f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63969253F05
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017321; cv=none; b=eU9Iz4CL51rx9h/uGLdX0/Kw9tT8AkOXOkMsbUuB9l17b1h9yhyKcLqr5oGZvwC+Z4rWe2OYR7DxdCteiMfwpT1L+665guZpDl5PQEGTxiAqCGxqDhZYcFGMB5U6L174zv7xdVhGeEYwLcSQdn5osy0fD4MStaMTvCrLpiwsb5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017321; c=relaxed/simple;
	bh=0f2DsioJC0fVlKf43S/586871Ko6aetl5MjQf/S6JhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAzPoD1PRgJtqOpJ21gdYchoYA+M0lNeomVPKoXoMYfrjJrtdKJaI3D4fPqoAmDnSGJfLbfn8DZCn17wjfmW8v16dJsXsv2pYrn4diakt3I2WxQj5hrxuN/Jg+fSnxbnVBVJNCM3XRMwQTZUXNwGQNP8x1DVS82MBD78FcYiVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZzptI6f; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-244580523a0so15880295ad.1
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757017320; x=1757622120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f2DsioJC0fVlKf43S/586871Ko6aetl5MjQf/S6JhU=;
        b=MZzptI6f+wkrRV53k/HYgvYsGBMbnTfRzpgxMssnQOtG1Gwzw0CwVa3KdsVLnKhzyV
         H4Y+UtA/ZvQ8+yJl8wAFT9N9/S1AnNDFuZIOl8EKIlMW/19PtSwZimPsVMi6Mn/7J5X1
         kxPDUm73EzjTtKOJPuwnlRMBKQrFPnW0b/dWiIAIxMpSjWxWqDLngoJFnI5lYVV6Xgs1
         amrl5hDpLtPArRnyXAgoNl+EuLDkYOxVDfWg7kNRgeC2YN7xeluSrd8BTlq8vJnovzDG
         NJgmnj23jGiUAkHCMJoGkV9qfpsf+guBE4JUXAySbLD4+q7+TpK5nCgAFwBg/Gc3kUU2
         mglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757017320; x=1757622120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0f2DsioJC0fVlKf43S/586871Ko6aetl5MjQf/S6JhU=;
        b=LpmTqytRUprSrTd6/Zl1DpsFn7Sn4ZL6tJ8GPDCYKAfeF9l/SkvzeFmmPg9zJ6vZXr
         PLsM9+Vt85rZXZ+kQzhaowrMB7aqs7g8UcriVYZd2yX63VXuIIBjrCWCbHVSb+IM2hft
         67lMOVtFPXS/aO2n43FCNNz6baQ/GDiRrwZTjHqf/r1GucTUTVRin+dcd/ztq2RltAD4
         0tjkRHY2zvk/eTWc3WSDX88tlCHYnXKxT/qixIgTt+l7Xbll+PGK4Mjle58pzx77o/FZ
         /xxlYm0AlRjROQujTU4VINzSwcZVSXGfYjMa2rrdYASOhq39Qw3T0lQf1F2udG0KjIGA
         21IA==
X-Forwarded-Encrypted: i=1; AJvYcCXNrgyesA4Bxj6rdGayXUf0rgmTFCPDqWvgWxLJUz/v/76aV2ZA5z+n1HrXlC7I5ykvSdHI/No=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7TvARi0tKcrQ8zDLB2AA74Y4gOHxbZOdQ/LsV2KVBcKeNOklC
	Fs0tqYL6N6821cIcG+9c8ZtWFdDW2LoLUicwosbGu397UpopwiiejJ17GqZw3Xvh7JiFfs4H9aS
	S5wp32yA7SPSNaQ6GkSu3bTLkneu4vXexf2aPl8NK
X-Gm-Gg: ASbGncv4hk/VlkXeGv737n/mycDJ3JDsvln5EdNj4NqHmu1FJohiXS/jVkmAAMrXV9w
	ghtH7puMQLSyTIiqL6idl2A8AwdnwygqR6qxIh8Tvc+e88Bi1Y5OS3YEMHBXR7zG7cxDUfa4iH7
	9c0c1pkOvCtAM5UGSA0AHjVncKOqrCJCTeTcC4MVaID4w66rvtVIFYN1eShblPv0GSq51j2HucD
	srPNyuqZu94hJa4fbwesEsiKShTspF8cTdjeoZxLaGbdL4lo2ZI0UculyrYxEBHqxOh0Guh9ERh
	6/s=
X-Google-Smtp-Source: AGHT+IGCpw4BSt538n4Uw2GeGiMXguHm7w7MP4CxltxyWLimJdtsHYLf+rp0dqaFLLxBfB5jth41N3wmB6ZcBZqH9Wo=
X-Received: by 2002:a17:903:138a:b0:24c:a9c6:d193 with SMTP id
 d9443c01a7336-24ca9c6d532mr87039625ad.18.1757017319455; Thu, 04 Sep 2025
 13:21:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903190238.2511885-1-kuniyu@google.com> <20250903190238.2511885-5-kuniyu@google.com>
 <20250904063456.GB2144@cmpxchg.org>
In-Reply-To: <20250904063456.GB2144@cmpxchg.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 4 Sep 2025 13:21:47 -0700
X-Gm-Features: Ac12FXzgx7crniaX9bGO-zMhcDMCF63LfUg1yz3p5hFqcyJzW1tUCJKKbUqLic4
Message-ID: <CAAVpQUA+rVJKMXQFATfxT=uX3QaLrCtCG_wtiGF_kt-_KrMRBQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next/net 4/5] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
To: Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:35=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Sep 03, 2025 at 07:02:03PM +0000, Kuniyuki Iwashima wrote:
> > If all workloads were guaranteed to be controlled under memcg, the issu=
e
> > could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> >
> > In reality, this assumption does not always hold, and processes not
> > controlled by memcg lose the seatbelt and can consume memory up to
> > the global limit, becoming noisy neighbour.
>
> It's been repeatedly pointed out to you that this container
> configuration is not, and cannot be, supported. Processes not
> controlled by memcg have many avenues to become noisy neighbors in a
> multi-tenant system.
>
> So my NAK still applies. Please carry this forward in all future patch
> submissions even if your implementation changes.

I see.

I'm waiting for Shakeel's response as he agreed on decoupling
memcg and tcp_mem and suggested the bpf approach.


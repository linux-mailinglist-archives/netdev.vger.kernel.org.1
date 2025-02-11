Return-Path: <netdev+bounces-165280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F611A31679
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88AB188A619
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D982E26157D;
	Tue, 11 Feb 2025 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3D5aU1Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138CB265604
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739304822; cv=none; b=nKJkYhSbFkZ8ufVpw6XdBBFyk5NRRTO4dpy+cwbEUn2UCUEI1QbIQApi1a5XUV2XNpCo3VRi3/ddmam3EaWWlEajLV/aLT5zlGqLzNelb2LZEtFOStPTVAj6aCM760vXf4o4dWmYOhkFlmbp/vOJIIl/gSB0w7YY4KG/1MIzZas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739304822; c=relaxed/simple;
	bh=Uedl/hZfkHtMDkwJdqMeHKYIm4IvVtHdH3+Q69k2Tow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjJst8Yvz0w4pkOehLMTc9EKvAGOp+qXLRGRlBc7FUalHox3TguQWX1Ih8rrFQytvkjY53UYGUyVPPISgH2/9EYS3Te65xvYZylemWFipxmS5lI/9bwM6WriS/qz7+UL/Js7MTZ3BYwlen25E7rxf1t3BMaM3ytYSixtoEKqnak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l3D5aU1Q; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so8415530a12.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 12:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739304819; x=1739909619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uedl/hZfkHtMDkwJdqMeHKYIm4IvVtHdH3+Q69k2Tow=;
        b=l3D5aU1QXx/ZXypb64aEX+UXU/t9U9cNFuqOxxzU1+yCriZStGVcNnUGNm9On4nw1E
         eMQ53M0okZQkc2sqA8lQkmaQi/s+MiYjCUFlY4hTksaIELfvEqDQhXGpZ9CGTfSemkuq
         1VtYgUnrVQQH4yRI202mybJmKZNb2J03UP2a8vvFnT+u5ZqviZQW/l5gM3zLwXZ1B5+U
         wQIkpcABN4S2EyqFogEbvpdxei75rHQSjhStlKnxHWmnYpLLnZ5hymSUVJ7HAnVkWX69
         +p+GnBReQEK5exBTr5dW6g7W8E6iR7V8KJ4/g8B/zLNpmWAjlp+q5Y2TAhr7jox4nH8i
         0hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739304819; x=1739909619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uedl/hZfkHtMDkwJdqMeHKYIm4IvVtHdH3+Q69k2Tow=;
        b=lBc++63CjookW4GEBV5iF9oiieR5XeZ6phQ5dkmcP4yA2kjzI1mz/i296tw2IDNNPj
         btnYA2TCGbcBFsXpfJqXRF+/WDL6pm+F9zfOdLP5zPk0KxMTQ0bEnRGkjcMrd3V8TnNk
         PU5MR/dmMmf9K6qegDk12KMxSGKL3tWBuQ6oAz7qd3rCaDkVuJMicKoqd3aqckCd/Q+F
         YsNZJMA5zteAEskaHdh5ARICzMs3eWR/7EWJID4siGOE9I0qowz4xhyIKg13T2w5bIrD
         RAU/wkoBA1X2JESmUxI1C5bdTiU5cf3uyYdqRdKLE2I13k8QoH7o+0mumZfqQjePKNQ9
         NVaw==
X-Gm-Message-State: AOJu0YwVNzB+nuPws19PpXpa2vin9MxCoECH+D8Fq1CfFvoi6mCDFuok
	T8ihLBOUXfh02hu2+sHnEjh/wia/s3bc/iEBk15O1cglvJWUgU5+xbFNVQM9MG/Jawm9uAiXWjh
	EHM0Rvuf314YMzgN2YRBDDD16j35KMFBQ7Uoet2MzCZ8k17Bs2Q==
X-Gm-Gg: ASbGncvZmKnNrrK8ClsNG0rX1Cj/vIOL9vyBFuxS4Vho1PcRY0TrvnlgsHWzN088acU
	RXCq+IW1mISokR1e8KvAtFLmd2cnMDWQdjOMIxVD8i0At/Le4vE7e1hj3tyax8OUhPXqUxnmqSw
	==
X-Google-Smtp-Source: AGHT+IEJjb6tWYiNTW02ZcIr7ZLjIryfI5rXp59GccwGSkvO1uN7uR2Gd7ClCTi4dNVzeR38WeKhPmjhJH0oCLGcyng=
X-Received: by 2002:a05:6402:3512:b0:5d0:c801:560 with SMTP id
 4fb4d7f45d1cf-5deade0471emr397624a12.20.1739304819194; Tue, 11 Feb 2025
 12:13:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dbd18c8a1171549f8249ac5a8b30b1b5ec88a425.1739294057.git.pabeni@redhat.com>
In-Reply-To: <dbd18c8a1171549f8249ac5a8b30b1b5ec88a425.1739294057.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 11 Feb 2025 21:13:27 +0100
X-Gm-Features: AWEUYZmRZ6Vcg51b-l57bZLHCVjmqSKyA_l29GsGMmKFusjBqo7CzxC1if3DNvM
Message-ID: <CANn89iKVb1s4qz=L76E78zXQapc992C+zMLs9mjzxaQbff4tgg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: avoid unconditionally touching sk_tsflags
 on RX
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 6:17=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> After commit 5d4cc87414c5 ("net: reorganize "struct sock" fields"),
> the sk_tsflags field shares the same cacheline with sk_forward_alloc.
>
> The UDP protocol does not acquire the sock lock in the RX path;
> forward allocations are protected via the receive queue spinlock;
> additionally udp_recvmsg() calls sock_recv_cmsgs() unconditionally
> touching sk_tsflags on each packet reception.
>
> Due to the above, under high packet rate traffic, when the BH and the
> user-space process run on different CPUs, UDP packet reception
> experiences a cache miss while accessing sk_tsflags.
>
> The receive path doesn't strictly need to access the problematic field;
> change sock_set_timestamping() to maintain the relevant information
> in a newly allocated sk_flags bit, so that sock_recv_cmsgs() can
> take decisions accessing the latter field only.
>
> With this patch applied, on an AMD epic server with i40e NICs, I
> measured a 10% performance improvement for small packets UDP flood
> performance tests - possibly a larger delta could be observed with more
> recent H/W.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Thanks a lot Paolo

Reviewed-by: Eric Dumazet <edumazet@google.com>


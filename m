Return-Path: <netdev+bounces-78049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F60F873D84
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0E02836DB
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70CB13BAD4;
	Wed,  6 Mar 2024 17:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mSqbE/Tc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBD413BAC7
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709746106; cv=none; b=Y2Fd+7163RpvfbCruMgfQaKF79oJMtdFlz6GBZech2ECeQiCbfsKmmYELzSTZbOAhalmQfUzDkX2o/LHdboTTrORVVKFE4ZVA9AxqvOLZHttn8NVW/Hpcflb1+TcnmDwN9O+rJXl9wWToTaxtcDJN1Oaeh/arnTJTDZRGUm7jtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709746106; c=relaxed/simple;
	bh=Ghvs4v77iQQAei2ZZ6uDRzDVbGBXuG2zwoIeqAMdXAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7f4cy1FlpLRYy0Sv07/lRnqLYpqpO6qiENOiSMjVzJhkz1K9OmWEzJSFcfLpV/RFym6i4uNKZwYoxe9JktyN3EaI/7Sqws76dY/PrSXnVpLeS006t76g2Tj/G1rh76D/r1gZm7xNcAt45Q2Azv24UIE1MFN9CeXCCEYGEjpBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mSqbE/Tc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso15430a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 09:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709746103; x=1710350903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9KodEne8KoAKjyIJo45iuD1jcQ25Lud0hklaomu97I=;
        b=mSqbE/Tc3iKRKAOlNhS1KajldC+YZNhZoImFi6KIiNMJHIvV/YGRR0DvlEb1Mxesrg
         NgYlRYfF3cBq79uEttIC9NIDLCA/CwxoIhGePjQq5eoGsys2+Xix5KpLxX0LaG7NDMib
         /0RCD6BWgjcppnVN22iFbd30BYACPVgn6wvzlcj92zJYsU94/t/jrTx2C0oh+dtHJR2t
         hMyUpx5fkTKD1Hy2s60BYxRnNP2cFQu3kHY2rH22OpihRwbH0mi+EpNFGNGXdAAxT8kS
         l6KjWVKZ6T54l1xPlCBFewuagokys9TzPDrXtj6ayXuvXfIBxceD8I5+S0sZj27I1nzO
         yrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709746103; x=1710350903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9KodEne8KoAKjyIJo45iuD1jcQ25Lud0hklaomu97I=;
        b=bWABPKC3nNfqoGYwCHwwq+eDe+sf17v4k2xWSst9Q1Z/dO7W4rcYkj3u/mA52FonUL
         RDrPhYFAJUvCNgl5eeLXhj/SNx7Qaax0ca9enwhxfxKIk8yMy/+e/2gJEcKYaQlZiSk0
         iANiL8zBx1ucuizWPvvksTAIAXjzn5k1shQf0dWY2FZVsQVIBTQ6u3l2Eu0Zn09EpUyj
         VildwopeiQAW3so4JnYXQ0z+D4zwO6/rAsinD2wHNfDY4qTrZkUewv3Fgu2pNGvqhth3
         2D8MFiK9gFmK7CCC8/XYIdzkpIsuy0Pm9hn63/eHO2a2Y+UEgcsImMYZupUn10jKdZNm
         S3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz7D3ohK3AZ6n6M+YriB3R8oNMTXb60GXLDzypqFuYgwUt6lwv3jwxx1t3x6f2WRUoxnVwXy7jElHbhS6HatOzVXSc7zuh
X-Gm-Message-State: AOJu0Yx5oCgeY6OCUunzbKQYgsKDBVIbroRia1aYfZE5itrabF4zfFz6
	vvBtscP1fBxFrQ3/je7F9DfRaF8LkLVp1s6z8BO3VcULyNsobFkJOAWgQYbjznmogT2wqeyDoAC
	mDjk2nP+/tOau1WUbPXY5aN74lNVaSqmApWl4
X-Google-Smtp-Source: AGHT+IHnNtaMgf1oa5P9omQGhKnc6U5AuSPId+mAS/2wEyyxbq2B9XLRNBZ/kNpYHe8+c66dcpBJTdAzKzTpJdifaEU=
X-Received: by 2002:aa7:d5d0:0:b0:566:a44d:2a87 with SMTP id
 d16-20020aa7d5d0000000b00566a44d2a87mr27047eds.0.1709746103008; Wed, 06 Mar
 2024 09:28:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226022452.20558-1-adamli@os.amperecomputing.com>
 <CANn89iLbA4_YdQrF+9Rmv2uVSb1HLhu0qXqCm923FCut1E78FA@mail.gmail.com>
 <a8de785f-8cc3-4075-a5f2-259e20222dcb@os.amperecomputing.com>
 <CANn89iJAKEUu_Fdh0OC-+BJ+iVY0D2y0nAakGLxWZ8TywDu=BA@mail.gmail.com> <11588267-c76d-f0ac-bf98-1875e07b58cb@os.amperecomputing.com>
In-Reply-To: <11588267-c76d-f0ac-bf98-1875e07b58cb@os.amperecomputing.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Mar 2024 18:28:09 +0100
Message-ID: <CANn89i+SiQXeDCKp9yjTz6ReQKxfHn6vHLcWFbCjjW14BiyAbQ@mail.gmail.com>
Subject: Re: [PATCH] net: make SK_MEMORY_PCPU_RESERV tunable
To: "Lameter, Christopher" <cl@os.amperecomputing.com>
Cc: Adam Li <adamli@os.amperecomputing.com>, corbet@lwn.net, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	yangtiezhu@loongson.cn, atenart@kernel.org, kuniyu@amazon.com, 
	wuyun.abel@bytedance.com, leitao@debian.org, alexander@mihalicyn.com, 
	dhowells@redhat.com, paulmck@kernel.org, joel.granados@gmail.com, 
	urezki@gmail.com, joel@joelfernandes.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	patches@amperecomputing.com, shijie@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 6:01=E2=80=AFPM Lameter, Christopher
<cl@os.amperecomputing.com> wrote:
>
> On Wed, 28 Feb 2024, Eric Dumazet wrote:
>
> >> __sk_mem_raise_allocated() drops to 0.4%.
> >
> > I suspect some kind of flow/cpu steering issues then.
> > Also maybe SO_RESERVE_MEM would be better for this workload.
>
> This is via loopback. So there is a flow steering issue in the IP
> stack?

Asymmetric allocations / freeing, things that will usually have a high
cost for payload copy anyway.

Maybe a hierarchical tracking would avoid false sharings if some
arches pay a high price to them.

- One per-cpu reserve.    (X MB)

- One per-memory-domain reserve.  (number_of_cpu_in_this_domain * X MB)

- A global reserve, with an uncertainty of number_of_cpus * X MB

Basically reworking lib/percpu_counter.c for better NUMA awareness.


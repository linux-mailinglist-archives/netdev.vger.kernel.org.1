Return-Path: <netdev+bounces-177841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA847A72096
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C27418995BA
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 21:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6162620C1;
	Wed, 26 Mar 2025 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZktTUppg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB4261594
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 21:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023551; cv=none; b=bRRWeCjPxoe+OP7l0J58D3h7DcXeSlPSJmD1dYvQHSYIVuM6LPn3EsbyHW4odZy8RueQWlM/ZuUAI16CkpR5kPYT2FxGvvN+6OdmRl0vraUZgbuy13ORcN7BTCphELhIr5m7zzFboEc9U+iRna0DpffSq7HNPirvTWntpiRl1zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023551; c=relaxed/simple;
	bh=wILt1Dx7SqqYYMFsoZDTlu1Dup1yuJ36ZBnR/Tqvkdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twUklOCUzutoHPQHcQwz0yflO1Sz93kBDb6NamXS47UJVUdKw9DwrRQ5/BKYvAHANIfxpIygC90dvnNQny08xWs5A8XAKVYbo3AvawceOa4NnXGUdinvMskXYOxytO1BhQiNH3abhySADnaLq7iOs3hNOxwl8GXc/owUNqtOOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZktTUppg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2263428c8baso25855ad.1
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 14:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743023549; x=1743628349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wILt1Dx7SqqYYMFsoZDTlu1Dup1yuJ36ZBnR/Tqvkdo=;
        b=ZktTUppgu1u4DkC1fL38+k6B7wWrqyHQhLRN2cW0cKPx8lpW/gqD/zMN7aMEgrPrKQ
         naaVao2r7lrGTrRQQBOCzXJhK6yHM6hAnMLu8gcMaLEs9DllAI40kK7xeogUPKj7871m
         i2hIDNB1+2wEgT+Ft318gkn2mBlj1tlKQNU/zQH5UM9UvmXsaoLGFlbW/h2ozxdsI1aR
         UiLIbh8jqof7YRj5JL9TCNm1JTdAegMf6WqWsxtq0DMHhV5oPkUZacokrRL6aOuANfqi
         0Nz9drazjyHDyUAq9VXQtyIobWJPfVyEQ64Se7vGserGDuhRMUGNxgiRmxgbrr+DvdqC
         DAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743023549; x=1743628349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wILt1Dx7SqqYYMFsoZDTlu1Dup1yuJ36ZBnR/Tqvkdo=;
        b=k+27E3W91IFTb8l5lsMuc8X+0rkrem/yRPYF2XrXT2R6e8Z3xzaQzAiQG+VKFwUbST
         WO1MFFqRxBJzsCWiXHq40j0EVZgb9KLmS29XpzydtWyKDWTyG0gfQylXHsQ9mqw5lSyq
         Qr2Cc4lNgNuoMjKnMqK4qzwb/GJ6GYPS62lpDbccok+cJRqkyyErAtElVDxYWqtaFsyn
         nqTOAlCL//Se8qHydM47s4OVvwKxNpKYkLHT4+gEX2wxd0FMuek9nXFsz01P9hlCxDmh
         Dj15sF96AbQ6d2lqAkOsymB8cb7zN9sLF/95pUslCGT9yAoytn70TPb4HvR/eZGMviOk
         NyMw==
X-Forwarded-Encrypted: i=1; AJvYcCUzpO28EvErMBqnPLUWQHCvKuaGqdEnpcUNtGwhghj9WHCXur9PhasZRwzztqVue+gCzdm8080=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8IOEhKITKPUFd1Nax46kUdHVfqMLM7yo6OXQD4bH19DI+yEDD
	3mxiegU0Ep4RhSYZdiEOpKPe9Z13Xqzd1PA7C5yLmZ6U9h3xb0HlxiIyvnP98kPKvVHSEIZ2JoU
	PfGel7TnYxsrOrMMOmF9YnbLAPp+c/WTkMNBw
X-Gm-Gg: ASbGncvsksbyHAOa3NgFU2G7EKWJUpqN1quk2a5XMKbjJWVc77CvzlDHK3XilE8arKn
	U1TGKjtQnQhN7ElnM51QOqC9YP5g0vCEfcXMmXpQ11L/5TMwL2OwP/hMyqhemCOm7RSs+JvFluc
	UojJnuaCyEE7ouKAt8A+ZDA9zFrendOjjryNGca0nD3F1DHBZ9fxLTUZhKwg==
X-Google-Smtp-Source: AGHT+IE8YbUYOyBk2iT02WBhUz1uH/zOFsw82UH90TrWfp5jknmMRRiTpziebpLgUUFiqctweiyFKtb774Tec66qz8s=
X-Received: by 2002:a17:902:d68b:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-22806bdf5demr393815ad.14.1743023548671; Wed, 26 Mar 2025
 14:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320163523.3501305-1-skhawaja@google.com> <Z-Hdj_u0-IkYY4ob@mini-arch>
In-Reply-To: <Z-Hdj_u0-IkYY4ob@mini-arch>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 26 Mar 2025 14:12:17 -0700
X-Gm-Features: AQ5f1JppAFpZ4xeQ5ibeA7OvDS0yaE1Z4tmv_XORVspY7eMnH7N25J3B9_FOlzY
Message-ID: <CAAywjhTzmupd=ehmve=iDtK638=6_yKyi9WOM9L=tG2CM4n=oQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] Add xsk_rr an AF_XDP benchmark to measure latency
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 3:32=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 03/20, Samiullah Khawaja wrote:
> > Note: This is a benchmarking tool that is used for experiments in the
> > upcoming v4 of Napi threaded busypoll series. Not intended to be merged=
.
> >
> > xsk_rr is a benchmarking tool to measure latency using AF_XDP between
> > two nodes. The benchmark can be run with different arguments to simulat=
e
> > traffic:
>
> We might want to have something like this, but later, once we have NIPA
> runners for vendor NICs. The test would have to live in
> tools/testing/selftests/drivers/net/hw, have a python executor to run
I agree. I can send another version of this for that directory later.
> it on host/peer and expose the data in some ingestible/trackable format
> (so we can mark it red/green depending on the range on the dashboard).
>
> But I might be wrong, having flaky (most of them are) perf tests might no=
t
> be super valuable.


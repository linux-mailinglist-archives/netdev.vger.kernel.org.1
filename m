Return-Path: <netdev+bounces-171071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1F6A4B59D
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 01:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB61188E173
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 00:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CCF18EAD;
	Mon,  3 Mar 2025 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KETnD7z3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129D0800
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 00:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740961484; cv=none; b=RE0N+SLrEb62eCKHtsQe9FdVASmg4QPH8vgQXtSTdbTF8YjukFwPCSUEKg2eyakpuE66elnPxSX7phldpplPyose9luRoEtB6mgTWuHMchC9XbIKLVDzAe1+HCJn2OBziEs0MEw/Ynh2EhsGhq33Ur66wFct8U6KC3CqPfvgmD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740961484; c=relaxed/simple;
	bh=SjFrBjnHMv/rcErjORfpFQHX+M27X5WKtgCsvMgEpuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aL4++6xmlRjBpsrVIyg71H3MGcMNJUDSWRjiwVIVUHyT2iXIeZiyP2E0x8mKmYA/3KsjbrEmqXTkyHN9/v1inT2M4U6gNz3e3H/e11oryY1/SsVLp4l6UR/Xvh20EH/YFgtD7RrXj9iJhzOXFWrRsyS1WLsr/xCZfGDfY20mc/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KETnD7z3; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d3db37f4e6so39632545ab.3
        for <netdev@vger.kernel.org>; Sun, 02 Mar 2025 16:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740961482; x=1741566282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjFrBjnHMv/rcErjORfpFQHX+M27X5WKtgCsvMgEpuI=;
        b=KETnD7z3c1DPVjf7Yst5Sy7pL2/RidnWialmMiAg1GufZqZMG/zeD7sZu3sSl3BGts
         tgx/w6pw6RwivvIbLQ0lQjRwNTkul3s1CjYAirn8aGd//duN1VrAQZ9ujTMwkU9jJt2T
         FGWTJjyRTCvowg1CLNsQtv43XiMcwZiwCV+cXVi9ZwnmjHZ6s7w2NiLKfiyEPsWIS9x6
         RBwL8+52Q3vqH2uIjsARp+zE6RNKBJhubXmU0RIDARjk8Kzbo/9mPg7yrDWtkuHiJ4ju
         bNKAx5z0M6swQusmtxGxvFZuNN+4m4Ufnz7dNZo4Qio4z0ovrhzK2S8IuMHHWymSqBqW
         HMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740961482; x=1741566282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjFrBjnHMv/rcErjORfpFQHX+M27X5WKtgCsvMgEpuI=;
        b=BqvmulMpEuXOUXbeh5ouHkQ9ocS+7aZXgfHoj0slwKfFGNwLydVLPJLlZE9/l1v2Md
         Q4AwAvmEsihuA2tedcJEq0KV118ZiwTvSuUUxqVql0wNpJvcxJObpps88lFbhh8FaEJk
         DpGIbkpX22bahJ2VMSXE1q3ITsWQeeKLfCtEiMoR1OfoSRTnar+D418WpPRSGtqMdohD
         eVVQ7gxbw1GaSh64YkWPBRpMt1TskMb69oDmLvglJcwZFdi7/CSa5oxbAL7niFTAu/I2
         yFOkJXRGA82Twara9IreE8a3cy5itu33JrEy2ZLpiHbmVfEVJF/HSKwu2++a7C5kXO1W
         6ptQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoTih41qMC0HAfw6yekqvv9weR/xnnEYVx1AEj7O06wzeg3kPP9GUfPic63qfgM3kwOafIoCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTx23CUUGA7KnV8qrcvcS7luAdMX+ybTKVhjRG9FZgRKQKqkyp
	R+o+fV2Uy/bd3p/ulibL5x01la6nc4OwRdgPoVYh/mrpfz0jsic+IitKkiSPPUcSIN4sZlILkMm
	h+i/lUigXaq5kZy+2WnuLXy6NKXE=
X-Gm-Gg: ASbGncv5FhBD8Pp/1AWVex2iOSPV9xhfBodhwBVw3peG74uO5t/ASTDP0Gjom2TxhfS
	J3gotuHiqN2DPkPoA3pzXyZGpUbduGnvCt8J2zjkoNb5rnehNfQYvMXmH4zQAOO+FRj3q4faf0n
	RGiyIsDmNE8fZQHYcG0Cn/cgnP
X-Google-Smtp-Source: AGHT+IH6qSQ7HGxVx7g8FLA6m85jl/MNjDq5LJ4sgMqd31hhKqJKUGQdqqKlCYbuOPn9cIdusIBku/hz2QIIpGNQ0fw=
X-Received: by 2002:a05:6e02:184b:b0:3d3:d28e:eae9 with SMTP id
 e9e14a558f8ab-3d3e6e736f6mr108874485ab.7.1740961481915; Sun, 02 Mar 2025
 16:24:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250302124237.3913746-1-edumazet@google.com> <20250302124237.3913746-2-edumazet@google.com>
In-Reply-To: <20250302124237.3913746-2-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 3 Mar 2025 08:24:05 +0800
X-Gm-Features: AQ5f1JpjhrkZIF8DV8pNoHuZM9O4nAdScit1VUmXUIiNj8VN9MPtnhqmO5SVtGY
Message-ID: <CAL+tcoD0b2FX5Gzsw02rPjPqZHWeSO4FL7JGEhOXYBmg0C1JUg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] tcp: use RCU in __inet{6}_check_established()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 8:42=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> When __inet_hash_connect() has to try many 4-tuples before
> finding an available one, we see a high spinlock cost from
> __inet_check_established() and/or __inet6_check_established().
>
> This patch adds an RCU lookup to avoid the spinlock
> acquisition when the 4-tuple is found in the hash table.
>
> Note that there are still spin_lock_bh() calls in
> __inet_hash_connect() to protect inet_bind_hashbucket,
> this will be fixed later in this series.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Yesterday, I did a few tests on this single patch and managed to see a
~7% increase in performance on my virtual machine[1] :) Thanks!

Tested-by: Jason Xing <kerneljasonxing@gmail.com>

[1]: https://lore.kernel.org/all/CAL+tcoBAVmTk_JBX=3DOEBqZZuoSzZd8bjuw9rgwR=
LMd9fvZOSkA@mail.gmail.com/


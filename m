Return-Path: <netdev+bounces-73186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA93E85B4BD
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 09:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97739282B35
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55BF5C022;
	Tue, 20 Feb 2024 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zH1iL5/T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3767C5C8E5
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417067; cv=none; b=rn+ul5o8PFSey5B2RW56qT7uLAny1mxMfDqLB4yuQY1za9PUGoZqtLcILrZcc6J71hOTkINgEd9ULAzX5rMCYRM994kuF3/94MNyjbpKMjAvmVaREwSFvJY7ddO59SLOv5qx6B9yjlRruRudQEpSjK6VqJs7okjd7oErD0zfyWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417067; c=relaxed/simple;
	bh=Qd2bc9p3BETBeBMkON8EJ73T7BHaExPE2Gw630in5/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1tK4o4XQN9+GzdbvBklCqlYmrjzkua/5biTUJTQhw+2e1mEoC1Lwbk9p8bG5gKJGw/T8NUuESKv9i4bp6Q+pXzqQTs1Mb2gr4ClD4KxozFrkiEltJQphKZ7++P4+EFXxUxB6IwaMwKOcHMaXvtxCFj20I/QXM/IGGskcGsG9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zH1iL5/T; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-564d311513bso2080a12.0
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 00:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708417064; x=1709021864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd2bc9p3BETBeBMkON8EJ73T7BHaExPE2Gw630in5/M=;
        b=zH1iL5/TbJlKxpEXUFdfxrp2JjpkjWQizb4XIeeGXSMxdx4yiVDAilzdi+MlPM3wTY
         tPnq/fWiFAqdTlUN3tA/Zu6OYvap+2fxyp22biIaWV9XVhfnpjVmpXIStFTuUDMXydd3
         7YVmNrr8kiWEZAhigSeoONYKiD3Kh2tVlUGEHiaqTDNcbpRF9MHIGZRjvEySI2ynkqO3
         wspDkAEiKBBK2ZeVSobTS4JiVdonbBpAlk/VRzl6hgmGdPNEwbO5+u4WXxa+Fmg+xzse
         1Bzx7jZnUPJf7qP4kiXbCIyQW0KhYhKRaXchJie085NxUn8MiXpCq5Kj7ZkR4866Z+1z
         Qzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708417064; x=1709021864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qd2bc9p3BETBeBMkON8EJ73T7BHaExPE2Gw630in5/M=;
        b=NQ3dQTgcg/vthmrIyxaJ9bMUhTny0mspYQQ0qNZEUI8B94DMSCQe1w43IRTgiNVpBO
         r4kKIGwkn0G4T5s5nDJ425zYNCr6ywd0zTRpVpbWV0AYjYyTjrYj4dUebBxcNCokQQSL
         UJ4Po3/CjCj9rwTQX0+J6yfj5bmHSFp/ssLLpzD4Sr+Frd2hESZ8UGc2scccqF3MI34j
         E3R709qM/2yialrSx+R2e3uAMlrbHHGr4PWy9F4NtViJuXuhYiCUz2OJ28nfMr/Q9tFf
         1bhUTQl/8etZrWv4ANjDq70oDney/1z6qeiXVL3DpqgjTkwbQeymflLimAdZ3r3G8S22
         necg==
X-Forwarded-Encrypted: i=1; AJvYcCWJXgghS5K1sSnTKzZshgmwcOi7iaTfQc6+S+F7e2YZS9M/pJTsRkj7rKFzlRuzF7/kRxVYkz9CRHGl1IsVscyxnhY39AXK
X-Gm-Message-State: AOJu0YwCx1fRzSnOrpnGu+dBlmF8eF2j3aiGvggGUREoKgYRkNIFJk4P
	m2KDKAkBrSPbieSt/jq2k2EJLgK1hWd7jEZwxgryKcoaw0yXvbc8VfZIomMwk8cFh2n0AQ0IdSG
	6ip+SeNrKGIUvIT05q/bkiwxisg418TYo4CIa
X-Google-Smtp-Source: AGHT+IF7mcc0zAtM5wQsOXVRxbbUAtJ7J8aj1cbos7ooAnQRgO4HWzdE0dzG+o2uIegVOiiz9LNmx7IsZMeguCmVlis=
X-Received: by 2002:a50:9f8a:0:b0:562:deb:df00 with SMTP id
 c10-20020a509f8a000000b005620debdf00mr359956edf.4.1708417064290; Tue, 20 Feb
 2024 00:17:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220021804.9541-1-shijie@os.amperecomputing.com>
 <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com> <bea860f8-a196-4dff-a655-4da920e2ebfa@amperemail.onmicrosoft.com>
In-Reply-To: <bea860f8-a196-4dff-a655-4da920e2ebfa@amperemail.onmicrosoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Feb 2024 09:17:30 +0100
Message-ID: <CANn89i+1uMAL_025rNc3C1Ut-E5S8Nat6KhKEzcFeC1xxcFWaA@mail.gmail.com>
Subject: Re: [PATCH] net: skbuff: allocate the fclone in the current NUMA node
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, kuba@kernel.org, 
	patches@amperecomputing.com, davem@davemloft.net, horms@kernel.org, 
	ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, cl@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 7:26=E2=80=AFAM Shijie Huang
<shijie@amperemail.onmicrosoft.com> wrote:
>
>
> =E5=9C=A8 2024/2/20 13:32, Eric Dumazet =E5=86=99=E9=81=93:
> > On Tue, Feb 20, 2024 at 3:18=E2=80=AFAM Huang Shijie
> > <shijie@os.amperecomputing.com> wrote:
> >> The current code passes NUMA_NO_NODE to __alloc_skb(), we found
> >> it may creates fclone SKB in remote NUMA node.
> > This is intended (WAI)
>
> Okay. thanks a lot.
>
> It seems I should fix the issue in other code, not the networking.
>
> >
> > What about the NUMA policies of the current thread ?
>
> We use "numactl -m 0" for memcached, the NUMA policy should allocate
> fclone in
>
> node 0, but we can see many fclones were allocated in node 1.
>
> We have enough memory to allocate these fclones in node 0.
>
> >
> > Has NUMA_NO_NODE behavior changed recently?
> I guess not.
> >
> > What means : "it may creates" ? Please be more specific.
>
> When we use the memcached for testing in NUMA, there are maybe 20% ~ 30%
> fclones were allocated in
>
> remote NUMA node.

Interesting, how was it measured exactly ?
Are you using SLUB or SLAB ?

>
> After this patch, all the fclones are allocated correctly.

Note that skbs for TCP have three memory components (or more for large pack=
ets)

sk_buff
skb->head
page frags (see sk_page_frag_refill() for non zero copy payload)

The payload should be following NUMA policy of current thread, that is
really what matters.


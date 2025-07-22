Return-Path: <netdev+bounces-208988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C60FEB0DF1F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8491C24EA2
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 14:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1592EAD13;
	Tue, 22 Jul 2025 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEPDA2hh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228212EAD11
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195048; cv=none; b=RzJsW6wgHlc2JaFHCuZID6zubXm9Q+EHuX5Q+7a7EMV/WBDqS1Xla23lUN86lJYEEM83O1T/jWOCTrIzPJeVYin66HYeHXWs1nQSd5CJqtdQ9/gGDIJUR7QxcslnWU/c73ojwHng8ivZaTOaZFJjRF9LVWtGbZrCCUvXR7H8WEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195048; c=relaxed/simple;
	bh=ogGcW5syfHAy99iS0KaNWz31X1S4P+kdHYMMRHVaghw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUPOt89noI01P84hmHyhUcVwM4Vjv4JMTxbwlQtk+xvY453wa/SnpJy32Lz5PADxhG0JqQuOg6yV3iREOf7IKnvrvVSL2Z5olDGRM+WL8WJOlFfK2ZTy+fEG4TJ2CSNG1ZW7FAgdljVIGVmEW5hkPEYkqQs7NalcZ3MwJqHgKhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEPDA2hh; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ab81d016c8so77171951cf.1
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753195046; x=1753799846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogGcW5syfHAy99iS0KaNWz31X1S4P+kdHYMMRHVaghw=;
        b=uEPDA2hh3+hfZRP2i8+wlNDmQJKiJVvJGkS1Q8fFwdGAqNBgqwLo4AYVxCMOLziRCD
         Nt1fA8pJu9NoM6EmanaeMMeKbi7jb3gg83G134+43V4XSZeZ59LklXCElE76iUrv7cEL
         RRwv7KofUqSQZtWl6HD+s9REWcyRuuPll+/ILM3++QnJL7GKnuj/E+7HLyDDHbxtEHil
         Lft8B42T1ivBzeTFvOu9TkKJ2Kqa8U0ONSYZ+JA0S6Me/ZXaUVApGDvRXV0Ah472/pfP
         25biVFyMjnc0Df/67lujZlMaM74K3+V2mLgL8+HCwEYuW5sUuOr0YSzZV1L1Kq3U8IFk
         NfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195046; x=1753799846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogGcW5syfHAy99iS0KaNWz31X1S4P+kdHYMMRHVaghw=;
        b=lwH7QZ3r2uzPcrWi0B/KgGrJs2In3x4NJtMq3aTI17HP+RQ1FF/wA/nmcc5eazKQIK
         7rtmU0RS+TeA2ORVjsM4UdDi5KKK2N+d+F34Sk7hhsBVJHVXpmj+hkDcgXvmDcXrOh2u
         3uZ1/ihk/f7dpNOt28zUBjY4P+bMt3LSem/0a9T9YOzw1ZKnfFjxOVIGZ0JJxMUGt60y
         8chE8U+WsC3k9LkwMIL3sDJF9AcZE30llTPFVgcQi81Pqn7PdPFj8EA485SA1V2KpVRn
         HkcAD06BB/UhN82Ja70elsJ9FUmm/DfvrXH55BIEllQn3Zwhr/LsWzOrabEXkMoCmzNE
         ku7g==
X-Forwarded-Encrypted: i=1; AJvYcCUR4GHjxqCGGKTyNROpSf2TKIVrVkgO2V6kJub6C+3UX7qLcgZoOKqiT1NaM80QgrfONTMz3UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGi7b9bdMX8Adn5esm8nTRHktNh0EguB1sOQn96J6uceXbNMb
	LoqXivlfqbvCbtKcgr4nyA1XYcn73Wy4mbIZTJ5jmf5zNdUIA2DCwUDW0mwWhz5U65NWgGZNptr
	8WZ20sYVo80cxcTUx7dKeAv4nUdpB1jUCoJ6me8DV
X-Gm-Gg: ASbGncv61TAazqFKyCHDaW0t6rUaIscHK72aWmHMzIRA9dlkazUHHBkZxbuOo4I5tx4
	nvcfZhhH03LEv0laX91SAkbJ9y+66b2G/wVMZAqc+t04gVwYMFO6GiLZ5lSAnNTRHt6bOOCpxdk
	4q61QXzGxQTm9J2Oy7KMh8gP3/KJXU8xI++KI28Q7e8HZQlE7Pfxl/PmY0TVvYxXarx0TNvfsYz
	rs1tA==
X-Google-Smtp-Source: AGHT+IHh/lY3G2VVyGGsILbI95GYxwwe31jY4DMEtEPuVbiqIy2WoiqiCRLo4vbR/BymSRXtvDDARRkbJMlep7SRIZY=
X-Received: by 2002:a05:622a:5815:b0:4a7:6ddf:f7d6 with SMTP id
 d75a77b69052e-4ab93c7d56amr387332941cf.10.1753195045666; Tue, 22 Jul 2025
 07:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-5-kuniyu@google.com>
In-Reply-To: <20250721203624.3807041-5-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 07:37:14 -0700
X-Gm-Features: Ac12FXw_PVmGWG71LBM_RvH4ODSBv72aWxnT33PfI7UhVcDC69sZUBCPONqRMjA
Message-ID: <CANn89i+p45mE7MTEmf+_fYA_fKXnzMRXiDXNDdkrHVimcYMFRA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 04/13] net: Call trace_sock_exceed_buf_limit()
 for memcg failure with SK_MEM_RECV.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 1:36=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> Initially, trace_sock_exceed_buf_limit() was invoked when
> __sk_mem_raise_allocated() failed due to the memcg limit or the
> global limit.
>
> However, commit d6f19938eb031 ("net: expose sk wmem in
> sock_exceed_buf_limit tracepoint") somehow suppressed the event
> only when memcg failed to charge for SK_MEM_RECV, although the
> memcg failure for SK_MEM_SEND still triggers the event.
>
> Let's restore the event for SK_MEM_RECV.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


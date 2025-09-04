Return-Path: <netdev+bounces-220136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49BDB448C4
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 23:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1153AC551
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 21:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172AE2620D2;
	Thu,  4 Sep 2025 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="G9+uN+4d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781072550AF
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022386; cv=none; b=aEuKZLQbySto6lue/ueitj6rdxxuzM8C5eaRlAPSv6GCeZgwplcNrZecX6k/tYo2JQmUGXDlHSXkqvojYWVoS8t2e1FFlNg4f+BjeBlMhbopiIQtAXOUOLLb2AJ++NeCMDNxUCks9F8Vy+fdMTArVQVZWJFENrI+ILiAiVlEm5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022386; c=relaxed/simple;
	bh=UkcFu038SgzaQoqpHuqh7rm8Kk5hlryjIpk433T8ZFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkRyqnrtF1ir/tBmz14OSt32amYLP6FnOtx2kScI7n5GI8CfYW9N9mNCipHW/dO737fPFTMffHBSKrkDARKgjPxBrubwCZIHpDAmG4fKY4kLmPNpTEebR7vhKOOyjhiQ1GhtKOovYP+fAID5UGaeOa3lKm4UJuCHWYXhUD9nyss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=G9+uN+4d; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7722c8d2694so1419409b3a.3
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 14:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757022384; x=1757627184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58UCbBJx7XFHUgMt81Q1QMPCRrjbTg/IHTwhF1TE8Rw=;
        b=G9+uN+4dAw/RvS1MOeW/F4F4tj36xIFiPcmhTaBt3PyoUFo9/zX+nsuhxIX5+Qj/Wo
         QFuvjuOVX4BkRawQd+e5UpAHXLiVmf8CJcjk2oSYkXKux7CokX5z4Eph1LECDNaBSu0X
         UsS1fLwMnLhkYnSeCnS71Mqzh7lNhifSgi8aFneC9FiRc7v3goHjURgEGc0/0hkS/cZp
         7d+RQU5i4oyp/E6heYca3W9BEdwlV1dTkSV3RwLXTCvrLJlDT9mTCG/BUHKxbvsXUjl+
         bPa2fUIg+0+cyFEfXel65r0IGW4ToSqx1GSOUqaOJjGO5we71RskF6/p+rPatQ4ejuBQ
         cjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757022384; x=1757627184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58UCbBJx7XFHUgMt81Q1QMPCRrjbTg/IHTwhF1TE8Rw=;
        b=Q/uIfyUBLZUBxiMgrLXJuBCsi9TOX07YzoruNAmg9NJJKsEjXQPXavMxNdEPkthJiT
         TbtAopRFyJMAvUZ7UEUVx9cOlJjyyk2L1SqB97+CmzuxXTfKv9oK6t/mzDXcf9KwLabV
         dyTtyJuvjZCKSEG4Y36ms/q/cajIq+YvCvne/sxACUeTF3y94LO+Kt4Cq/6h2x8YewQv
         tgfxyZsYJRVGV/ArCE32DpqMIgOlFx5xelgSnTP2RZRFdP+POa9SwL/wSpRsqXXhrLqd
         1/6Gqq3/jyGydLOvTCWtIYT/JPppSjQxq7vLzd0vfZpTQsPjOUp7rvlYo9OfxTOTosfG
         qOng==
X-Gm-Message-State: AOJu0YxH4frCUQy+fnNDfbbRWhku18/mObAbIPrq52TjZ1LQUQltdmv1
	j44lKr+P3BXGQE5r2s7QFj8YGqpWEGyPltJQBnUg5YAXCsCUIcXmBQgPaai9/Zq0axYqUPA+b8E
	dTnQ6v3E+SBuv2PuWhJomsCpP4V9PhMo8bXGYyHlV
X-Gm-Gg: ASbGncufGb2MkP0o9YVYvCDEodcezzZfErYIJmOOS51Ke4sVIuJqJF11G7qdAw/2ZG3
	4eZRfbCrpMH4K8GSs/JSC1JD6+lg3x2azWmrK3h8wl2m2ju6jhBdnk5L7m5nyq/a9yImZJEYwbg
	98ObveafIM4y/KcrXsoacsDGSZkm0YtlfEJkNpw5ECd9jlh6WmTjMa5jjMnJw+6vOAApWDCZ+6W
	pl0GXQ=
X-Google-Smtp-Source: AGHT+IHSmBNyZQvwAPcR/toxhKoWlcaMb7YElYq5CeuEyUQYfTCgL75F0sbfJLNBWxvT0UehgGKBnvJC1dOhHKYC0XY=
X-Received: by 2002:a17:902:d552:b0:248:fbc1:daf6 with SMTP id
 d9443c01a7336-24944ad55a3mr260481835ad.43.1757022383625; Thu, 04 Sep 2025
 14:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901083027.183468-1-idosch@nvidia.com> <20250901083027.183468-2-idosch@nvidia.com>
In-Reply-To: <20250901083027.183468-2-idosch@nvidia.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Sep 2025 17:46:12 -0400
X-Gm-Features: Ac12FXyloQ_dak-O_Wva3QydnpbJf4zA16Hm_GfCIDXj33RkHuULUszNqR9cDOg
Message-ID: <CAHC9VhQb8D=2=FX_JaQghA1e==s5XfMyKvdg6=1eVxjimhmqdg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/8] ipv4: cipso: Simplify IP options handling in cipso_v4_error()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, horms@kernel.org, dsahern@kernel.org, 
	petrm@nvidia.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 4:32=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> When __ip_options_compile() is called with an skb, the IP options are
> parsed from the skb data into the provided IP option argument. This is
> in contrast to the case where the skb argument is NULL and the options
> are parsed from opt->__data.
>
> Given that cipso_v4_error() always passes an skb to
> __ip_options_compile(), there is no need to allocate an extra 40 bytes
> (maximum IP options size).
>
> Therefore, simplify the function by removing these extra bytes and make
> the function similar to ipv4_send_dest_unreach() which also calls both
> __ip_options_compile() and __icmp_send().
>
> This is a preparation for changing the arguments being passed to
> __icmp_send().
>
> No functional changes intended.
>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/cipso_ipv4.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com


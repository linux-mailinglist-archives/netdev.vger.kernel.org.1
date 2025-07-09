Return-Path: <netdev+bounces-205513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6ADAFF048
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 19:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C355655F7
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD0321D3E8;
	Wed,  9 Jul 2025 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rcVFM+wC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6745661
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 17:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083768; cv=none; b=OGovbDrpf3pbyfWCFEUKKysAcdzoqUcYtM/x+POlOSfymkamKCAVLsnrpUyVGpZQbXrfkP5QRQUmeugbWwyU6WCzQpqcHQV/XX8d3WvwivvA/2JTRqqO4G65qOtiPDRPSJS1oEZ5GCbJG8iQeIE+LMqMPExzwniFskyEpjrRBgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083768; c=relaxed/simple;
	bh=STNlbPAiB4q/DBvuSPt/+MWzpngKyccDrfDaNvbRMjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCedGCneg4finxsin/qXMw2Ogydm9cXtyO+nvLP+PL4mc46gDZY7zcwhkVoWi06TEvvQlY0ieaqAOjfMkySumksIqDkprykP1MwZhzivL2c7xfxWjdyp+lpadvonh+npt9v4TuYeOnO6IMsLzS66AKIK13B51KtWxqPDJbot5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rcVFM+wC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0c571f137so21868066b.0
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 10:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752083765; x=1752688565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oagKQ+BP01K1crKVc/kvbsId8U3lC5U+MMZWnLsc1hc=;
        b=rcVFM+wCG4eWdGYmZfCCr5gOehvhjVqSF1FM5GSDoNtwjl0mbGVe+PbbNBQGeRMZRH
         UWjbwIG7J5qyFBNGsB1hm0GPFRY9L3jQ55jomd6vLnOZlMviE/UcTVDJo0gNSHWp5fq5
         UjNEBI4qpBtQV5itZfBUSeqGVNHUbulVUInl22MyTdxy9r/O8xsoquNubXp7iuNG1TtO
         7yN5Mp9W6MEZkbF9rGKH9sd1mCJiv58DzqQY4KtDm384CBIU8fQlko/zGOAxP6+cqQAb
         HkbO7TczNWGl/n9UMqp1i+H0/vnYyZjmVIFieXrPoiq6eMq/JymdoaIB9Y1HGP8pqJxs
         L8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752083765; x=1752688565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oagKQ+BP01K1crKVc/kvbsId8U3lC5U+MMZWnLsc1hc=;
        b=UlsiX0l06QYLb/EjjJqrjOuFF8tIgm40pygnEqfygNH/9RyR84gqx38V/vo7N8O+tM
         7THgVNqWzm1mGh1kzc76d1sg3DsZWSWkiD0m4lvA/vFMmyM9PZ8fSP67xW/O/Yo0DUOv
         IDWjVC2S5l/5iTCozzdlZ/6hqAipa/fX4LtPo0AuhUuK8VWjSyP1gtejGrcREdLqUeu7
         Io2osxqfO16yh8gvifRWsA30lWq9IyOD3GwwYugWhrf0fZbauSdkKMwvjcsg/dqTo8er
         oFLsvQqRwhRqotaKU5yi38MVjPBHhsIU1+vTcMRyMbFmEWy0hQPoTns0x4F8VGXyH3ku
         3/xw==
X-Forwarded-Encrypted: i=1; AJvYcCWmt6jQxaU0X08vtO+T0gwnBVuFMjpv+p/sS0TV1O/wFtoJRF+ZU5Byhyy8OSs4AxWvaQxJ2P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXA6ZKHw2n0JGNT4DnY9jeF5E8y07nk68OcQ2KVB1ij5d18O7H
	42r8HO4tHDL+eIzTPOXVHs7DK5y88B4G16lgj1b+yKX/AcYt+JMamhWm5CalvKbr0EzqQX5u76v
	I0cVVaoXZVwlmTXQKgO+bupUHj/oxNrlIyhx5MfzZ
X-Gm-Gg: ASbGncts529s66stNp9ke59AUHNTlhgbOz0Im3rEj3pFzfIrfUILF7BUpTyKxF+ysz1
	rGFGkwJ16RD6Sta2wXqGFlKZ5noqb9K5VlJ2EcYiLvx6JMubonJHmR5FAzHf93+69J//YoScFSz
	SevYl8UGASgoFONRp9P9xp3eaY6Jjdj/9PIUHDM9t76w==
X-Google-Smtp-Source: AGHT+IEhAHHjFE7cFMtaQ4XMvepIFr07h8nKLbM19ILby1Y/HZb/QPoLdlT2vrsdTznbUU2mYufLc4qEIgp6FPSZVcw=
X-Received: by 2002:a17:907:7288:b0:ae3:5da3:1a23 with SMTP id
 a640c23a62f3a-ae6cf5c7dbemr375618766b.21.1752083764485; Wed, 09 Jul 2025
 10:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707210107.2742029-1-jeroendb@google.com> <20250708133132.GL452973@horms.kernel.org>
In-Reply-To: <20250708133132.GL452973@horms.kernel.org>
From: Joshua Washington <joshwash@google.com>
Date: Wed, 9 Jul 2025 10:55:51 -0700
X-Gm-Features: Ac12FXyLSoHfCVtMf4x2EjDw0kv14bJ1cdNkW2FGFXjfkkJov6PNDIdfhZKNnLA
Message-ID: <CALuQH+VAvfAX1Gs1tNDa7e_wvZj2yyu1ZGpiLLt2ywssSF4sNQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] gve: make IRQ handlers and page allocation
 NUMA aware
To: Simon Horman <horms@kernel.org>
Cc: Jeroen de Borst <jeroendb@google.com>, netdev@vger.kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Paolo Abeni <pabeni@redhat.com>, Bailey Forrest <bcf@google.com>
Content-Type: text/plain; charset="UTF-8"

Thanks for the feedback.

> > +             cur_cpu = cpumask_next(cur_cpu, node_mask);
> > +             /* Wrap once CPUs in the node have been exhausted, or when
> > +              * starting RX queue affinities. TX and RX queues of the same
> > +              * index share affinity.
> > +              */
> > +             if (cur_cpu >= nr_cpu_ids || (i + 1) == priv->tx_cfg.max_queues)
> > +                     cur_cpu = cpumask_first(node_mask);
>
> FWIIW, maybe this can be written more succinctly as follows.
> (Completely untested!)
>
>                 /* TX and RX queues of the same index share affinity. */
>                 if (i + 1 == priv->tx_cfg.max_queues)
>                         cur_cpu = cpumask_first(node_mask);
>                 else
>                         cur_cpu = cpumask_next_wrap(cur_cpu, node_mask);

I personally do not have a very strong opinion on this, so I'll update
it if more feedback comes which requires another patch revision.
Otherwise, I will leave it as-is, as the feedback does not seem to be
blocking.


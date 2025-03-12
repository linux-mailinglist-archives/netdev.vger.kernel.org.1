Return-Path: <netdev+bounces-174074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03537A5D52B
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 05:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC505189452C
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 04:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09871DBB38;
	Wed, 12 Mar 2025 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctsKdy/D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330A1CD215
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741755458; cv=none; b=GcI+SCV/N0xvHga0bZwNbAhktCaLGs0WAEfTeLt2GH1AINOrwQLBQRLRHf8snUpCpLbVoSf72BeL+JK8mM9ZaTt7b5ZPFt1idi+1KfTWLGnas/ym+nx85RHeX+TjFZQbQF9WkCJaH6k5a6is95iwWogdw/KpJ3zUvMsr+iijuEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741755458; c=relaxed/simple;
	bh=gKZ9bkQ9GnEPgrv2Cxvqzv+ZQ4ARoHdoKdw/H8KfwDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qa4HcerzC7VtPIwmCRhMgMBwsTaMZdqEL0mrUu751XVtpAkjrm45qqkslI2LtxyEIejuBJVs+GfUYO8mVTgQRMyZhKlG/xEBPwkZxSRBKFRZRKQJPoDEqX7/JsMl2LQMiUdp8y2AfHkYLAhtPAQb436xBKYKRPHiawDLxEmPMB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctsKdy/D; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47686580529so27370181cf.2
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 21:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741755455; x=1742360255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKZ9bkQ9GnEPgrv2Cxvqzv+ZQ4ARoHdoKdw/H8KfwDY=;
        b=ctsKdy/DWOEwgbsiWECXHBg5L1Tq9MBpbBU4Q3QLMiVxAN9Od4HPwpXIjpJMYdqa2T
         3lfMBg7D2hm1dyY5HYEElOnbSZIPZAQj/Ijz++4fizBaGX6KRT7N5w/bQ3859amruz36
         +sw8TI3pAUQsHOja/ZS69is8UAqW4VdO5tPn+JgzGYp7bo9hVEq/C71GSi8e0tX4b5VK
         Sn8ebo0sTLTt4fKavQPZ8MYbdJCvxbSDG0HufcGamGwiJ6O4cwCmLdBAShZn1J/vD+yd
         vl23OYtSZtzeE4aRd031ucgYttZkl7lE7J9esHDvT7V2Jmp6eLFgN6mptbm+IhSrL2c5
         FsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741755455; x=1742360255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKZ9bkQ9GnEPgrv2Cxvqzv+ZQ4ARoHdoKdw/H8KfwDY=;
        b=D1QPk4i7zkU0IcorWxiMTyWS7ONcjAdJ0nKlq4YsIIV3uN5ToonYecilXIATwOUGej
         pLfk25BmaoJXejQ6PhZtzmJEy7BZu9ta1ckyHQxBz9/rtoHhNXQo/rC1lvAwKhLqGgmC
         /FreM+GckoVqRzvtd5Gp94tWomoui7IhLSKAsAR7eGlmKMqjkTXskCNgiZYOnBGYhb7T
         Kjwdse/72pj/Ij7k0DAQ2UsxWaLN71iL19EG2GkT6B+4AuNXyvKZ+eKHKNsSXGIvRZhU
         IKAt3FKOCvjHXnKSb2WVJR5dyacZ+qMvbRrs9NxJ0AfKUaVsdA/q/WlFjwpUoJ20Tvcv
         IetQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMhTjgReP1Xr4W09h//LIGIT0R+QuN76FKU7BA3/gSNysKmueBOwGcPkzqxuIYYpTbK+8fSpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWXFpOSfiHkgzjJLLNU1qVxJLKSq+ZmHu/QUCMjdZM7yqK+f6M
	O4lY7A/PE6VKZOoHILDzKDNyWtOuKGotE/9dFHLPVuIjPtucKsiOe7BVZD6jE6u7l/keMB5/2AZ
	q/4F+tnEwxfAt848UtKGPGDCJy4zzYKdZbvFC
X-Gm-Gg: ASbGncuLH3etqgC4PMsLM+CY4h4ZHUFl//jXUiqVDTIF1oLdecQjqsn7qGS7pMgNFEF
	Y2KIVBubXNgQ45hevAXg/aWZMFmcavpTccTCD33IaboayOHb+piqmoU4oADKxFGVJkXQ6yaW0e/
	Am6t80QqtHsvk6ALTTw/Q3sh/G7Q==
X-Google-Smtp-Source: AGHT+IFxweTRrmyxD0z2rXDtguA8C4PbQGiHdjMhGYB/p9zTnHYNhw4HqtiRWGPvHWSJ+BUltYwvAME1i+Lvl+uSHyY=
X-Received: by 2002:ac8:7f52:0:b0:476:8825:99ba with SMTP id
 d75a77b69052e-47688259f29mr130462051cf.12.1741755455060; Tue, 11 Mar 2025
 21:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311085437.14703-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250311085437.14703-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Mar 2025 05:57:24 +0100
X-Gm-Features: AQ5f1JqyplD4RAYNNkjIn99u4w0CrvAAPBXcoao54iBAd_wBxygJhoFMLLEVJQo
Message-ID: <CANn89iJQ3D=Zad1UsqgL=GhfxF8TxiwHgWvT=xchm4scatgbWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] tcp: add some RTO MIN and DELACK MAX
 {bpf_}set/getsockopt supports
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	kuniyu@amazon.com, ncardwell@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 9:56=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Introduce bpf_sol_tcp_getsockopt() helper.
>
> Add bpf_getsockopt for RTO MIN and DELACK MAX.
>
> Add setsockopt/getsockopt for RTO MIN and DELACK MAX.
>
> Add corresponding selftests for bpf.
>
> v2
> Link: https://lore.kernel.org/all/20250309123004.85612-1-kerneljasonxing@=
gmail.com/
> 1. add bpf getsockopt common helper
> 2. target bpf-next net branch

Some of us are busy attending netdev conference.

Please split this series in two, one for pure TCP changes and one
other for BPF, and send it after the netdev conference ends.

It is not because BPF stuff is added that suddenly a series can escape
TCP maintainers attention.

Thank you


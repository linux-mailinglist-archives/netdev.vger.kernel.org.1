Return-Path: <netdev+bounces-227700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2A7BB59D9
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 01:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34E0D342868
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 23:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37322BE658;
	Thu,  2 Oct 2025 23:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mggcXN8i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0A728488F
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 23:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759448264; cv=none; b=qu+T35/5BaHQzSIZ3YsUMWYs90zhQlBQwlG3HRuKT61Xeay/5P9Fn76pqKQh2C5XY1wbRmO3gv3tSqG8vlffevqzqn5ypMdN1LaueRvP+5RlyuIIV7qunqzA/J2Li8rwx0dacIN8cGdnzfUV3CxCZEo3AePoDcNFxEwxu6AlGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759448264; c=relaxed/simple;
	bh=a4iHp1m1jUq01D2H8VN4n08fE9MhQ/vRj7/00NmGVWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn3QeWNpYV491aCKC449oEciMcyFiRxKJTkG/Sjx55xwDGbgoNHik7xwaNZSv8EWCvQ5BOZRa6+yRJYQhrPx7FPYPK1JQZFzcKqA5ah0X1+hCZYPRQIIFMKPKUnLMHmCwHqBNRwRNedJucwBlatLoDXoi0LoHsW3u9Qoukw+B0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mggcXN8i; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso13332975e9.3
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 16:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759448261; x=1760053061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYyRjvvcClZsqK4bgOK/mSlQ3JwKmg6n0DCRi23dNek=;
        b=mggcXN8iUgsoPa7cHGX0eI6ZYyaZrOdrl36ZDU8CpUOwQTkHTR77sfBGvFNbkMjY4q
         2a3bAzHnjZoi/ebYKwnvKTUaBfySnOsNQOGjNUX3nn/uOMsTGMyh+dD63CarqyqrLDgz
         zMoQipnZotf9ZmQOzWcW8J6L/NDLmFBtaU3WZqxBct8SduU/rHZYfvbpqSFZHKnnSO2p
         pNtaNkqGqzSaDiQhX797jDPiDsSUhWeWcriDsz9vkYTd9mpO9jbwG/LHrdD2WThdY/sk
         AlYJbvR8tEgIP+tSaLe+xDehWB1qraZGZPeWfkOMNBfWItfnpmamdwPHy/D6tfkEjSAY
         fV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759448261; x=1760053061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYyRjvvcClZsqK4bgOK/mSlQ3JwKmg6n0DCRi23dNek=;
        b=UB4Yaq8BeNng61kdntf8Ec8KRjSGCDlRP/aVV/e2tuvL/CuLt/60WY6eukNeXS4hSd
         lbd9qBE3ePmScz2+4be7y+/XYT7yMiTCTVUkAQ/V6h6ybji5fYrZtNbj+14bOPDldm3P
         ecH8KtR5V/UR0cWvu/IH3tei3X5ASCaejvOFD68kZwVhoqHe1oyVBwbrSD5DwZjhscNr
         /d3t5bVGqD4YdNZlSrLBgtD0Q6QwnfgYVL4Wu6OMe5MFW7N7wmZA4BrlpcK+o63v4p+C
         Q3KQE75JS4SohgqAORQokxQaEjivkOXiRrSTXLpJMtJAJi4TdEIYrooh/+sYuG2Cc50/
         umBg==
X-Forwarded-Encrypted: i=1; AJvYcCUuEZIH5NFVBoy5vi9VwbQNus5tc4Z+u0j1BFIqrLGzstZSBpBWUGz/6t8XbSPORf5IcKb0Mao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzKvDD+clSgMizjHCxhMrsjBs2paj1Cwn0UMeA+aE9bfqgNfaP
	N+AX7cqZ3E1R28nPj/7VEK3HrOctjdM4/jSgNhiuBoMJKPpzbcAPVNZa73oDiXjmC/R/F6a9zN5
	6R87vSp3/zfr55RG9c2WEOaG1JmAcFfU=
X-Gm-Gg: ASbGncsp1y5Ug66RR4gB8LoZ90sM8AqpK6LGcqHb/lwxT3LsOLburs3cGLEuPK5psu4
	ANTgiRoObA/dvc52gPI3VnPvgOXZQOjLtpx0SSaR9uzq9t51OaGzwDAUJFrSRdW0RR8HZ9YW/mK
	uChmPGjL/cNLUzEV5oj7lR/UQ06+hf6C/cwlqSusxvvkS63bRnAo6loghBhql/iixv4wNYn4Bzu
	DxGNJSifU6pj2F1C7ub3GxFFSPApgN0n+TXeiiS5rolBGwpQHPLelU+gIe5
X-Google-Smtp-Source: AGHT+IHb95C9UaqPZtGL0P5fKptKfIz8ZAhVPywIiTLzHIHUdC8qi4d7wOijDm27RI3QjHtP/ObVzgdzJG1YjW47LZY=
X-Received: by 2002:a05:6000:230c:b0:3ec:3d75:1330 with SMTP id
 ffacd0b85a97d-425671b037amr505734f8f.52.1759448261224; Thu, 02 Oct 2025
 16:37:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002225356.1505480-1-ameryhung@gmail.com> <20251002225356.1505480-7-ameryhung@gmail.com>
In-Reply-To: <20251002225356.1505480-7-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Oct 2025 16:37:30 -0700
X-Gm-Features: AS18NWBzOrTlE6SWnP9vH5g1d0_y8ZQPBBlzY0EtKr4sLtLnv87FvFw_6jM2fys
Message-ID: <CAADnVQ+X1Otu+hrBeCq6Zr9vAaH5vGU42s6jLdBiDiLQcwpj4Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 06/12] bpf: Change local_storage->lock and
 b->lock to rqspinlock
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 3:54=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
>         bpf_selem_free_list(&old_selem_free_list, false);
>         if (alloc_selem) {
>                 mem_uncharge(smap, owner, smap->elem_size);
> @@ -791,7 +812,7 @@ void bpf_local_storage_destroy(struct bpf_local_stora=
ge *local_storage)
>          * when unlinking elem from the local_storage->list and
>          * the map's bucket->list.
>          */
> -       raw_spin_lock_irqsave(&local_storage->lock, flags);
> +       while (raw_res_spin_lock_irqsave(&local_storage->lock, flags));

This pattern and other while(foo) doesn't make sense to me.
res_spin_lock will fail only on deadlock or timeout.
We should not spin, since retry will likely produce the same
result. So the above pattern just enters into infinite spin.

If it should never fail in practice then pr_warn_once and goto out
leaking memory. Better yet defer to irq_work and cleanup there.


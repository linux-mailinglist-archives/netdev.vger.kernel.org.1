Return-Path: <netdev+bounces-192874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96135AC174D
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 01:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A703B9204
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 23:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAF82C1781;
	Thu, 22 May 2025 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dN0xssO/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1152025A2AF
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955241; cv=none; b=KhOwZI5WdvQ2JRia52aTJTPMDocKVoIbyWYzCBLOaxD0Gv+f9k3v6wTFpXTGb649MrRDw7lIJ19BcSxmlMYftW7PXF7SjmWskdLHFT1x7iJh02ZvWN+kV81QrH/2qHPBAE+yTw1HCYYcZdKtQnddp0pqw9WoE8QQdljXGsN75b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955241; c=relaxed/simple;
	bh=9k3VME5bwvvpc/ullR/HlyYZhFldfmD97iNNOe9Kyvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nk+qV5LlvAEkVmD7wUQRQTxRyOisOAyXjxUCpEMuM/OlkVbfJnhZdh3VvtxcKDnvHpv1u3ae8lGUqQIOYB2Wq9X5UCB2eyTvcqmXfF9x0KIBDGzpGWwuVQreI8GTufZdlXlJevl2xebdDYPfQW4f6Q4vHTYJArkhhIYnCWKqCaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dN0xssO/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231f61dc510so85655ad.0
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 16:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747955239; x=1748560039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9k3VME5bwvvpc/ullR/HlyYZhFldfmD97iNNOe9Kyvw=;
        b=dN0xssO/yLKwBNBu/SpBp4hXBIjmC+ZgcbRmx2yK8CwMpMdU4rfSrAQm9lsNuLZw08
         GKKFiSQl+b8yjPCaSra2AaVJl6AK9JzKaN6v/H5VRAgtBDX0q0TFAmGaZaczBFoiP0Pw
         6P4RjCXA4luqZZrng/F8hBd/PsD5lCZ+EGoNlsD4r50kttqAz5RCwq56OpCbfJ6Nj8YZ
         r4O+pOQkE8Y3XeGaD508x1RSzObtL1aM8k5EZQIvzjS6dUhkV7vwHI95aRmo6823/svr
         u0OjCJw2x92eVpVA7QznywEvIJsGEspC1ptM16+eUdSnvIO+epRIL8ZaZ6tsIuNM6SyN
         UBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747955239; x=1748560039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9k3VME5bwvvpc/ullR/HlyYZhFldfmD97iNNOe9Kyvw=;
        b=qVos37zSCojh4pErXXP+2EteGENgNbOn/WBzmsx1Y/wclsSZBYgqRfrlbmlEbD3Cv0
         zbYHJrlrwICOv6EjcG8hHeNq8aSlHBM3K6uTSztkgNofAlVu7lrEIbZKN4m7a7SEqYKP
         Mjs2NlCQV8n1ro5fg7g/dsnEWMM2udNIsK+3XUTGbM8RE1dqWXjbwnC4FWodXmNctJeX
         vFj0YwZAeboIMImcpF4WrlCSDNU3kivk2bJhZb5zFOuo9paJqIPSRdfLDQPs31M8sg2K
         V1mEQDQ5owvdOUV0yyuuk+5vCoOUunAZb2a9cK0Jcp5Jtn9Autop7BUZn4YoH5pmMNqB
         6Rcw==
X-Forwarded-Encrypted: i=1; AJvYcCVsikpagOOmn1P6+k/TG/XYfdB7yNTVdY3uedW6Any37HDPpa27j7OCJonwmCXNjHG6yztG4fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzpC5HAcCKIejgixf/BiGaBJRUTtIlx9UwMHYiwTSTqyvkxngj
	nEC7RwebC2pWFvUBbq+hwUVYwTwcko+J9sxPcfAFwCIVOABem3Fnx/Ufh33uywhwMQVELg4rD0t
	MUNXJi27MchARfQgTvs8AUK3m00JbcoxgiR+qS0RT
X-Gm-Gg: ASbGncvjii15WmEtogYtB6975t+3g/kbLm6fX5gZdoQoCzp4sODKY41m8MBSgqxk+Qj
	ro44tsdqO1EpkhEgrSRzYOdlyR/JGMq2Wrv9XfDiFM9D25X3X0glo0152W07sQeIek7TavTLJ6X
	HcPZvZQDeSONWdUYwzwh349t0QPalnGmWW8gGqNoU8av1wYI5lzmP12M07ck3MZfF/cB+k9mHL4
	g==
X-Google-Smtp-Source: AGHT+IHU4w0zFDczr9krT/bEYfz6eUrChXM9C2DLD3YJztsZ4hg5mbDDQkqfKBOb6e0hru6SRzufp2/mwXiVYMr87dI=
X-Received: by 2002:a17:903:2f82:b0:21f:631c:7fc9 with SMTP id
 d9443c01a7336-233f2f5c39amr718885ad.0.1747955238967; Thu, 22 May 2025
 16:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com> <1747950086-1246773-2-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1747950086-1246773-2-git-send-email-tariqt@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 22 May 2025 16:07:05 -0700
X-Gm-Features: AX0GCFtg6n-BJbnwZ4ncUt-OvxE-HSzTGHOggSVSO4oEhmp8jL0GlZSc61OGYLI
Message-ID: <CAHS8izMANyVqznTjt_3qkcUdpbT96FK=m6Hc6AU4WGqhyq7zmQ@mail.gmail.com>
Subject: Re: [PATCH net-next V2 01/11] net: Kconfig NET_DEVMEM selects GENERIC_ALLOCATOR
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Richard Cochran <richardcochran@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 2:43=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com> wr=
ote:
>
> From: Saeed Mahameed <saeedm@nvidia.com>
>
> GENERIC_ALLOCATOR is a non-prompt kconfig, meaning users can't enable it
> selectively. All kconfig users of GENERIC_ALLOCATOR select it, except of
> NET_DEVMEM which only depends on it, there is no easy way to turn
> GENERIC_ALLOCATOR on unless we select other unnecessary configs that
> will select it.
>
> Instead of depending on it, select it when NET_DEVMEM is enabled.
>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>


--=20
Thanks,
Mina


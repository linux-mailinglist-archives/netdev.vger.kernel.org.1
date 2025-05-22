Return-Path: <netdev+bounces-192884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69E6AC17E7
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 01:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C273B1914
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 23:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909242C17B8;
	Thu, 22 May 2025 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8DT7Cwk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD82494EE
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747956291; cv=none; b=L3o43ti1WmqrbC6bEMXpeh3txcX+Bh/Ut97wmq6TGV7YviPQQ+shlmHvRF3JCnQ9tIMwCy7woaTMLwlee+lcgxz1UA4Ka4Gu3fDEq9nSSNx031l0EoKKftVZEzGsUE1nZqQMvYpKdiQ/6zvBsuZzkv9f7WfWZKs+utquJz0ey2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747956291; c=relaxed/simple;
	bh=VtTmEXuxauJ3B94DH+XF9n637EHj0gRGrWRBC9z/qsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrZvhuzdKrYr+yosRONhcr+NAukKdtAq7i7xyWAFR9F+f2zpOmav1Fku4H9wuQb0xgwObcQHa3e+Ym8TDqRvYJg9IKaodTNalj0L9v9n93HWCW98weIuPh507oBCiUKWHqTthTWG10F9VRolJ7TZl+ADrLCf6SDNQemBpbOPVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8DT7Cwk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-231ba6da557so44745ad.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 16:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747956289; x=1748561089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtTmEXuxauJ3B94DH+XF9n637EHj0gRGrWRBC9z/qsc=;
        b=R8DT7Cwky8b5fWqDANKkdFpT89nT7Ul0Au54CykoXx0tHPkwWi8FLxrcPmpJjZPm/Y
         mfuD068ImdI6xzzk0MZY/J4fbCCcVbEPNR7z7YAnRr6vB3hJUNMZ48N11eHkPcEw4iWE
         HfpbJ4PdQIaengo3a+0/yVEB65h6y3slD6KRQobGucJVS8AeWfEeCkZYhheQwQNzKdfO
         oJNpm05tRsZ4kcyGCm4jjWLFXSoQ4GBPAooo7koTds74GxihoEQ7S8P8tSW93MApMQvb
         CRO7fZMpccFqtJ0h2DUjXIFz9Ja1HV7DL5zNCVPhYoyq6TKS64e98wQljdrUQSie63G8
         mAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747956289; x=1748561089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtTmEXuxauJ3B94DH+XF9n637EHj0gRGrWRBC9z/qsc=;
        b=CpzwCfkWSm9B9CMPFJldxNAu/9CLRB3SPFHjOrGr7l076RxKqGE/mJkXquBekWI051
         TXV1+EWo5Y2zbUa8Anyl7ZvpNrmITruAJEpmFnaRE5CFoLhyIkhwsEN7GZ3j2dv9MRmB
         B4aAQpvMxXPaLOkH00MA8aLB/wz3XG5L82TKRpnD1JU0oeLK4qVSrISsPl2J4zwpiz2c
         4/fOA/yHKUYwYxvKDX8ephufKTtHk9pWo8wM5xFuBfTXoPZ8W3w6SbllrcRW/P4N+ncp
         LdfVEWrzUhauX4BuzfQ5l8Jc6V/RQExcFKqm2J90ZxDs4HNxrrcHPlGhzi+EE2/onKG9
         tmGg==
X-Forwarded-Encrypted: i=1; AJvYcCXi5pvA9IJ2DKucpKE8MeaZXXslsjAq3auYGGFPU3hasY8FSzHGitwfBHHnTeMqjeUJnnHgTmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU5QO1EPakb09/L+QzrhnKPrAMfAkXn5HQKZ9b6NC0u3CnZnlP
	0qdJrbUfEQe9ujb0WbFMsGm8lBklgFvoECKbDO4sqQfmv6ONkOActbk6JKjxJSdAEP324awb4fX
	BvyCo2IDkj3FmjRRpCIDzQM9zJzVQ1YxBzXAkMSy7SEcHCdL13ftX+5Rc
X-Gm-Gg: ASbGnctPOTeSNsBXET8lqBY5o68t1ST3ZZPQ9oIIehnQ2qzj8vgT8KKWC5WHFip017m
	bn2ghUu4SCGrhs3nCdhg13o1LGX/oCZ+FaxSpuNqcIpasS86Af7txocQgmJvBV/WFby5fHXBYcP
	qy9RMhPtPKvbaRrtL+vnvcEcUoxCgzfIOwHLo/PyCgbW0tcOVYLsfNDg8bLJXr+67vuW8wL2c5j
	Q==
X-Google-Smtp-Source: AGHT+IEajyNx7hV1BwdOTZbSU0n/gFRM/BXhlbIdxZrRO5FIvUh2DpmsX58Q/EetJ9zHiSgysM3tASbsdYoFqzmr4fw=
X-Received: by 2002:a17:903:17c4:b0:21f:465d:c588 with SMTP id
 d9443c01a7336-233f3081323mr584655ad.14.1747956288662; Thu, 22 May 2025
 16:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-7-git-send-email-tariqt@nvidia.com> <20250522153013.62ac43be@kernel.org>
 <aC-ugDzGHB_WqKew@x130>
In-Reply-To: <aC-ugDzGHB_WqKew@x130>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 22 May 2025 16:24:36 -0700
X-Gm-Features: AX0GCFs7hrA7hWZzLZD_-PN_wrJl-jW1GTwnaFT-Wn-3aE1B_J4p79S4m2U7qA0
Message-ID: <CAHS8izNPJjAwbVwDnVQwHmjTKfxSqbt-jEnNzcWzTfQNGr9Lag@mail.gmail.com>
Subject: Re: [PATCH net-next V2 06/11] net/mlx5e: SHAMPO: Separate pool for headers
To: Saeed Mahameed <saeed@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 4:09=E2=80=AFPM Saeed Mahameed <saeed@kernel.org> w=
rote:
>
> On 22 May 15:30, Jakub Kicinski wrote:
> >On Fri, 23 May 2025 00:41:21 +0300 Tariq Toukan wrote:
> >> Allocate a separate page pool for headers when SHAMPO is enabled.
> >> This will be useful for adding support to zc page pool, which has to b=
e
> >> different from the headers page pool.
> >
> >Could you explain why always allocate a separate pool?
>
> Better flow management, 0 conditional code on data path to alloc/return
> header buffers, since in mlx5 we already have separate paths to handle
> header, we don't have/need bnxt_separate_head_pool() and
> rxr->need_head_pool spread across the code..
>
> Since we alloc and return pages in bulks, it makes more sense to manage
> headers and data in separate pools if we are going to do it anyway for
> "undreadable_pools", and when there's no performance impact.
>

Are you allocating full pages for each incoming header (which is much
smaller than a page)? Or are you reusing the same PAGE_SIZE from the
page_pool to store multiple headers?

--=20
Thanks,
Mina


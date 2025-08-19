Return-Path: <netdev+bounces-215030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5868FB2CBBB
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 20:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8231C683112
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 18:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B98223F431;
	Tue, 19 Aug 2025 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CnIQ2yYD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764524728E
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627462; cv=none; b=iuiZY21bTfFKr2d6E1aGxfI4BjwK7okJAVZUmvpBbeG9uTr0JN7cDHo6922c0NW72fWQusaH/+1VVonOIoZV50axQBdwTdPhdzp+xMyYZTUtnps6h+kwbrk1S+DzipdE1SYxkZz6R5PeAYkP2vulc9mOGExSSWZBYWmhU9XWqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627462; c=relaxed/simple;
	bh=bJ7uytCfe6n4lP4pD6RUvDwxzLh0wCKPzYSr6NmIYEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EERv4g8NzDvCQUWkDJBvkm/g91Ig2pBfEckH90Mg6HMF4EMG2KrQa+wBqYCbAHKVZ0C6+TpeDrLRXXRv39p21hxjk4CLzIiVTvmEQtMf4DZnIQG2uJfxwhEdIz0NY4u3ul4eGI2Rcd4PIOw4k5b0IJW2/+b6z3+c2wg2FIscrCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CnIQ2yYD; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b0bd88ab8fso31681cf.0
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755627459; x=1756232259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJ7uytCfe6n4lP4pD6RUvDwxzLh0wCKPzYSr6NmIYEs=;
        b=CnIQ2yYDeQSHwsy244djpPgRg0If6DCfIMcboy7M0j6afd55Z5/MP3mAHpjNk0mGbj
         ynwrxGCEHZOcg7epZX139fYiUf2IshUpAuYzXSC2ki/O9WZnIZh14zPZtRzWy30ekFUC
         lhL+cx3T9J5QQaopBZmjnCaAriWPhNGYy5pjXEm7HRiwR9w3E7vxlxAsQbzzDSF4+fe2
         ZEv96qvG+YDKWK2hH56+FB8TQXDAQndiDtDq+/Yo/KZto92yD8+KLTbmAgb6yVYEpg8/
         UWCuNdDRAmv6ECOEC5ni9lzAiJiHzcqucDVLQLQw7crSaFoVFubxYHtfc2LlwENGa5Ji
         rfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755627459; x=1756232259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJ7uytCfe6n4lP4pD6RUvDwxzLh0wCKPzYSr6NmIYEs=;
        b=Qx8zIS+Wy0eqczYrWuXqGvkow/xjLDjNRAmxa9SOz6DljNJ9t3MaUMuEtd6XavELCf
         3FJYQLhOdQArkXkBo95iQgvvwbNZCoJudZwaB4qt69Vir0RoC8IokAqY5m1CB7rDCCu0
         +ynvpiL6CtQWQG/V766NviJgN/x+/SyK1VQutJOTQBJe5I8+1BMjnZi0MQ04ylr95ts9
         91kyj2zwPk25TAVMGUYo5pzgsIJkYW2cskUKwaS3xajoaVV9kWco098258c7T/wMtUx2
         AvMdIGiV0cFW6q+57nf8plOrNKHbkncbp8QiWCRkqm7DbPBhc2ttXOoO5iM4M13mlyaG
         N45A==
X-Forwarded-Encrypted: i=1; AJvYcCU7WTe1a5McWLbwpdgHMqNWb83Rn5QRvXT05p6QPfpnFmSs1NxnPm0ERPL3cKf4r8KTyyhdonE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGbN9txSz66wusGpJEaFy+SPsbGulqHovPqFc92WRzqJ/qm2PY
	j8gP0a+MCJ0w8uzJUWlHnO+vM0PlzF6M3/Q3bzSDBpTi4Pxt6bDvwfQGVaIRGNv/uhFNTQF0tSh
	3DSr0iLL5t43GzgtU8JEPymt186yisEz7LeKk8mzr
X-Gm-Gg: ASbGncuZJEOtRXtx4bDYOSwxTD9kM1d9F2F1moqVcbfLlRDxOx1AFpRreHO09XOgT59
	8rZIoVTipZu3ZKhViebvNrcmZk9Oda2M4KS2INb98dNs2VJuYZK+DpgQCjY8PXzET/6o61/wbY6
	1QVshY1Ikdww4/ZY+kmXft4gNuL31NDKTG9XJ/lstnw+i/okNlZ2PYDZLqiNRQ3v3G3hmL/Eo6v
	GB92madMXAZgA==
X-Google-Smtp-Source: AGHT+IEEiV9T0svVkXf/cLntozmS9J9eQwt5DbyG87V8nnZtWet7m1X4MTlauB3wUDcQeFpF+T8oHEDDQqIdTE836QI=
X-Received: by 2002:a05:622a:2c9:b0:4b1:22f0:8016 with SMTP id
 d75a77b69052e-4b291808f9fmr383391cf.2.1755627459033; Tue, 19 Aug 2025
 11:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819174030.1986278-1-edumazet@google.com>
In-Reply-To: <20250819174030.1986278-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 19 Aug 2025 14:17:22 -0400
X-Gm-Features: Ac12FXypFVX7SnYXO0ejjCRacbMC0XtDUclIsFoUMCaQml0msSXOdPpLnlKKTSo
Message-ID: <CADVnQympDuXMbZs=Y_f=N5zfVoMH=PeQA0PWF9e6epu-DosUrA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: set net.core.rmem_max and net.core.wmem_max
 to 4 MB
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 1:43=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> SO_RCVBUF and SO_SNDBUF have limited range today, unless
> distros or system admins change rmem_max and wmem_max.
>
> Even iproute2 uses 1 MB SO_RCVBUF which is capped by
> the kernel.
>
> Decouple [rw]mem_max and [rw]mem_default and increase
> [rw]mem_max to 4 MB.
>
> Before:
>
> $ sysctl net.core.rmem_default net.core.rmem_max net.core.wmem_default ne=
t.core.wmem_max
> net.core.rmem_default =3D 212992
> net.core.rmem_max =3D 212992
> net.core.wmem_default =3D 212992
> net.core.wmem_max =3D 212992
>
> After:
>
> $ sysctl net.core.rmem_default net.core.rmem_max net.core.wmem_default ne=
t.core.wmem_max
> net.core.rmem_default =3D 212992
> net.core.rmem_max =3D 4194304
> net.core.wmem_default =3D 212992
> net.core.wmem_max =3D 4194304
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Great! Thanks, Eric!

Reviewed-by: Neal Cardwell <ncardwell@google.com>

neal


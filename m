Return-Path: <netdev+bounces-128158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0479784FE
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A211C21C39
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587F23B782;
	Fri, 13 Sep 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sEtY0NeT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3F6208B0
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241870; cv=none; b=K+YYa5+Kr02iGpBqTFEVlWfUX9/Fn6TVwyFElIRYtxKvHTtzCcpiYeCafAPGO3CiXZ+bnD+F8x0NnCoQbFaHlTWvqhaS4wwHc4tFvQ3ql0+7qMHU20bOd2UHDlu6lnrCYgOGTSF5eITdCuS511t3nqRLZ2uji4xXY7yOObdQXZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241870; c=relaxed/simple;
	bh=8ixziJ+NoVh4KOQg8C8NgzofR7i3xJZLSc06BKDtxXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mbd74ban0GGRyhNCRbnTsJNb+mUzOcp7PxRxo6sIvKvjB7OkjfxyMQKRAmQQ+xE3pS3Ubxszxd4XrdvLdSzAaY1OdlVmBVjE5ppIW1XbOu2Y7Lwlb/QCB4i8bj+weW/AlllBPzwYT0tMBvZvrQVB6ORb47lF8m1xrRd9yA0Z1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sEtY0NeT; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d60e23b33so283503266b.0
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 08:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726241867; x=1726846667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ixziJ+NoVh4KOQg8C8NgzofR7i3xJZLSc06BKDtxXE=;
        b=sEtY0NeTFRRF0/RcRwDu45eVUcbz3bjNqVmz2rjiT+avVsEusmNo6bkt4fy+GF8aw9
         rPezas8OvrcZAwlq5yd7FzIT1E8puhG0yWxJU33qfvHCEW/u7nOoaTvz+bqW3dIE5A1X
         YxrASmZCe+7/io1+HuIqLtPKWdFFVtfuhCuQFC6hN4zr8BxmQL/CC73LLJF7Umeml5B7
         D9wai5DTnC+66bViMRa62HM/YNxEcf26j3mwzj+/IRs3yRYjukhn6/IMDkudU03RYi/4
         jaDmp7mbReG1Nn1KVOVPrW/3aUta4/mChqitfQUhGnTSG5DtKevkR4sbEOmZe1Uft2Kn
         mgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726241867; x=1726846667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ixziJ+NoVh4KOQg8C8NgzofR7i3xJZLSc06BKDtxXE=;
        b=qUsnfkGfR6S+O4IMHLjU8D3G5E+iPpWPJePypD+UEsZ/nu1fv8kzrOE4r0x8H+vQrH
         u22LzHcc3IcAGCarkwN9tDZDzCE7tH+MdGLO0zBBDSOYRjKGlqRWRr9hSnoC1/0OPm+9
         2ctWO1HqmCmR174eOSCaDRRV/eK020gq5o62jlWFRQtIXaIOTVnsMc+6XYRWvuiJuS+a
         8I8vqmoJUBqWFtV1QswetslS24RPpdEmM5ODZkuYGLC7sF8GCJPAnQWzm7Ss3KL1LDCK
         2QvI/QRk8Lc/7WwTKfJFnKqxtnjDdD3Mi1ryjVlU+b6IBkq4mDsAJP3GsmcEda9dQ/pw
         WJ0A==
X-Forwarded-Encrypted: i=1; AJvYcCXDMPgfLwRUw40CBYKP3LBhDpz+CcFKKuchpznXp3/sZChoVVwBZBQEiVsWuMxlySum2YYWfAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxefDDg+CYb6dSMx/qj7WhGEJRq28oB5XIUvLiJeHg3EKrm5SMJ
	sRyfnoiJGeg5lw5N3L1gDCJth0c6fWzyEoJFdg6Z2SC9Z0YqKVamZeIsf4a16hflxaElDM9ykAv
	yqVqZxcHy+4mjkEj2C19/jYGRwwroOwPcY4yu
X-Google-Smtp-Source: AGHT+IGb5+Ky2+5hGPg9TOJMT/1uVEafLvwFY32TQ483pUMrOKix9BbKOuCjTfYl0Y8ZspD31CnMtbkI1Ixvmdip3Nc=
X-Received: by 2002:a17:907:e2cf:b0:a8c:d6a3:d03a with SMTP id
 a640c23a62f3a-a902947d3f4mr643415066b.21.1726241866556; Fri, 13 Sep 2024
 08:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913145711.2284295-1-sean.anderson@linux.dev>
In-Reply-To: <20240913145711.2284295-1-sean.anderson@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Sep 2024 17:37:35 +0200
Message-ID: <CANn89i+BGju58H3u6-Z_tZApjaMC+LB5XEocPbuTWK9owHyM4Q@mail.gmail.com>
Subject: Re: [PATCH net v2] net: xilinx: axienet: Schedule NAPI in two steps
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Michal Simek <michal.simek@amd.com>, 
	linux-kernel@vger.kernel.org, Robert Hancock <robert.hancock@calian.com>, 
	Shannon Nelson <shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 4:57=E2=80=AFPM Sean Anderson <sean.anderson@linux.=
dev> wrote:
>
> As advised by Documentation/networking/napi.rst, masking IRQs after
> calling napi_schedule can be racy. Avoid this by only masking/scheduling
> if napi_schedule_prep returns true.
>
> Fixes: 9e2bc267e780 ("net: axienet: Use NAPI for TX completion path")
> Fixes: cc37610caaf8 ("net: axienet: implement NAPI and GRO receive")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>


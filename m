Return-Path: <netdev+bounces-174903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05DFA61311
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 14:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 489A07A1793
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9412D1FFC60;
	Fri, 14 Mar 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="UiAKAJ/r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77928DB3
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741960350; cv=none; b=fVoLtd6Dac2TvjaBW2iyrppDXwjKUIY2GHRlWQO2k5xXWxMr62rN7mfuogLd8zsUG8P1W2fnzDZ2SU28VTAS5QUxldlkqdZ9yF4PXfP0v1D4Q8Yfoj0a4oNRSuayMrKVyIWMSWlQm2r07H9ywDam4p5s0w72kHMnhw70fypv/qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741960350; c=relaxed/simple;
	bh=l6eRw8y1OmUmjOlCM4cZJphcNpxH4Gsq7pdQ03d5ry0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SV/8hIq+dIzr8d3kXVYDJzoNI0vNDgE04ZgBHsvhdJAOGT/VaqN5tXByzofb0yimbA3H4KWBt/UBmua+XonDeXuQ2S0OF1MQQXcVDtlqPV93lAaWYV6NTNxHo5tPvUMSKsamXyFXoQiVyR7OcDGbDHvuJndbp1xMajZY6yz/WD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=UiAKAJ/r; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5499da759e8so3515021e87.0
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1741960346; x=1742565146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zycopCDnnU2i+AkSw46WgSJrqCJCcusa0YK3FYhw6i4=;
        b=UiAKAJ/rNUakfpPKB5pgexS7OOXHIuUxYQTOuBgfaQp8cIhLvXptPPI2VI+HEZAsDo
         h50wbuOP8HYLAxAvN93rSMMsVSjU1XC7H7u51HmwdiOpU3wtGlq0di4k62P3EAo70ndG
         yhu4q/Y42gKD9noUiTMAufsV5KC44kNhJ46Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741960346; x=1742565146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zycopCDnnU2i+AkSw46WgSJrqCJCcusa0YK3FYhw6i4=;
        b=e5ITZTgYLG5Dy8lI6sBaU28T/aOD3k9SJdD7NvyJYhlYsFsGmBIAhrVbI94p8gLyre
         VbTvLSUbG690qSXcm0QW+APVf7uTn5qaYZ01xzycLk9+U2R+c9rhbemL0ZbU32cLbTpf
         cK6GxD3It3I7RKDJtPNDwIalNFgltcM5lml+I3Tw3eHvV5ZhBgEC4qtya35bAoZtlQtT
         qG7fFRJ3YxyEJF7eTh/Iif1Oxu8YHRBtW60gzJTaPMmY4E+da1//262sCb5VdB/yG/d5
         6mhZucMpxWHLvluG9EE3zMMRUmEU07Gm5000JpzS8gsCJwUjSXQfgCqQgu2XfpAKFZwB
         TPBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7os1M91ZVqVj10BLf3Xj1HatmPnDB/LAPSbM6uNlwXn9LM3fpOBnPnqr14f285BSfuS3TKzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuMRK1hNMIFi7qvWCPOofchinXd5CcMtRLGK+x3r3lF+rDeiWw
	PMButt8cJOOzO+XCcRoc2U72aannzVRfwVhCys7zQUkAIy8Vy95RtXBX/TtyctfQe8mnnHSa2VS
	td0hyZ0eF4CGu26knsZiYt/A0j8F+yWcTyXpmtQ==
X-Gm-Gg: ASbGncuwVxyTw+amejOKLI74hTTX6fFaBGSWWwtKh17yOOe/eO8W7WggioqQS4gByyR
	jnq1GSWEehc9jsv1tp4X/HWDX6CH+z8btwxQTPwYP9QJ4m1vM8jihnqtzFT2X4F1hX1IzIdj2qi
	HCVW22gTqQ6LGLiRUuzPJ8ekK/IC4=
X-Google-Smtp-Source: AGHT+IF9qRrJkTrrIobfvLSECzIZRaki1TnB6To26QFfRp9f28bu0YABV4vbDlhxwlNTG2VFpOb8agSVt6i2bJhSG7I=
X-Received: by 2002:a05:6512:1596:b0:549:965f:5960 with SMTP id
 2adb3069b0e04-549ba440077mr2663642e87.16.1741960345389; Fri, 14 Mar 2025
 06:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309121526.86670-1-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20250309121526.86670-1-aleksandr.mikhalitsyn@canonical.com>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 14 Mar 2025 14:52:14 +0100
X-Gm-Features: AQ5f1Jr2EEuusWFl1maY2c4eLIhTIDuLUbvGq7tTSg2w7PXhTO9cHpspBBibHY0
Message-ID: <CAJqdLrp+_nHnBCLoE8uUHCSOQsKhc+WFsN8kUVY08sR9aW5uiQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tools headers: Sync uapi/asm-generic/socket.h
 with the kernel sources
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: edumazet@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Willem de Bruijn <willemb@google.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Anna Emese Nyiri <annaemesenyiri@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am So., 9. M=C3=A4rz 2025 um 13:15 Uhr schrieb Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com>:
>
> This also fixes a wrong definitions for SCM_TS_OPT_ID & SO_RCVPRIORITY.
>
> Accidentally found while working on another patchset.
>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Jason Xing <kerneljasonxing@gmail.com>
> Cc: Anna Emese Nyiri <annaemesenyiri@gmail.com>

+cc Paolo Abeni <pabeni@redhat.com>
+cc Kuniyuki Iwashima <kuniyu@amazon.com>

> Fixes: a89568e9be75 ("selftests: txtimestamp: add SCM_TS_OPT_ID test")
> Fixes: e45469e594b2 ("sock: Introduce SO_RCVPRIORITY socket option")
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com=
>
> ---
>  tools/include/uapi/asm-generic/socket.h | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi=
/asm-generic/socket.h
> index ffff554a5230..aa5016ff3d91 100644
> --- a/tools/include/uapi/asm-generic/socket.h
> +++ b/tools/include/uapi/asm-generic/socket.h
> @@ -119,14 +119,31 @@
>
>  #define SO_DETACH_REUSEPORT_BPF 68
>
> +#define SO_PREFER_BUSY_POLL    69
> +#define SO_BUSY_POLL_BUDGET    70
> +
> +#define SO_NETNS_COOKIE                71
> +
> +#define SO_BUF_LOCK            72
> +
> +#define SO_RESERVE_MEM         73
> +
> +#define SO_TXREHASH            74
> +
>  #define SO_RCVMARK             75
>
>  #define SO_PASSPIDFD           76
>  #define SO_PEERPIDFD           77
>
> -#define SCM_TS_OPT_ID          78
> +#define SO_DEVMEM_LINEAR       78
> +#define SCM_DEVMEM_LINEAR      SO_DEVMEM_LINEAR
> +#define SO_DEVMEM_DMABUF       79
> +#define SCM_DEVMEM_DMABUF      SO_DEVMEM_DMABUF
> +#define SO_DEVMEM_DONTNEED     80
> +
> +#define SCM_TS_OPT_ID          81
>
> -#define SO_RCVPRIORITY         79
> +#define SO_RCVPRIORITY         82
>
>  #if !defined(__KERNEL__)
>
> --
> 2.43.0
>


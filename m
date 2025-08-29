Return-Path: <netdev+bounces-218329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A1DB3BFA6
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 17:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D9E1CC4646
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60B233CEBC;
	Fri, 29 Aug 2025 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xv4STqYZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E133CEAF
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481883; cv=none; b=JS9X7dhrCPp6xn51AG5anY6iqDaD5spaEIqp6g6EjVfDYF8Zu7Ldq0DZbg5LmZnfUN4mCqRL8YodiBOuYUR+gUdcU01O06yA138kinSZ2XVu2Hzv5ePnrAQxsNinOoqyK9nes1LfQoecybO5MtfuYaut5cL6Vd2CfM+QN/nbCpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481883; c=relaxed/simple;
	bh=dTqTTGZlJ4chGLvICslwE1y0ojIOPXnMp1K+HNp1epI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQ41tWd3ILGaOSrf+LOFWjL69S0wiuAGSVFO9vKX+KrG3Q2jY5CghGammFICTmCqabfz1Ql2S3UzelQ4AA/jzf16P0o6frjdgkXJLE9+GSoCYtpWMOD8VS1d/NkwPcpSa1ovWK8rH3JbQhsrvy48GxrafobmOsWmebAMz30Z3Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xv4STqYZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-248e07d2a0eso191085ad.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 08:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756481881; x=1757086681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBf7SqSAMiJDLG40aDWJGII9dJmHgmKSvxJ5vBdynMw=;
        b=Xv4STqYZhdgB2G8RbmGohMgF7TwqhITRuYaWBEUnTsPI1hoVf+EBtwrXOaOehaQ5en
         7JmNJq8tzCgL/2UfS0Fe9d4Lyq/1kURVMygcdRjF4Liyi8EOIZtTaKiODhX9WdhEhatj
         j5MYZqQUQ/40kTx9YZBH440BFBiB2MaaCjqCBIDYLgIeuwg/MlimUAYs8H9XhADG9XBO
         fPaWInbFERSbjQ9gKhrb2wneh1aFbEKdJRR/8NQfkSnf5eCgWe1UnnNyGOZnYQSey1Ev
         FMnruH+I7i2TjIZD5tyk0k0xzMKHO+wrl8dkdau1LcS/+U5Iz12StZ2g175iwN66Baqt
         h7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756481881; x=1757086681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RBf7SqSAMiJDLG40aDWJGII9dJmHgmKSvxJ5vBdynMw=;
        b=BFlYsQhe741S7Dexe+Jn5Qx3LuPegjiHX7RTQkqhtehMkx9BqzRPcA2oh0i6ABKxEk
         UigufrmLcz67S/PMjDScZWXBWG+xqRMvX515hInMlMdwOaANuVmKXEt7IVjxfMRtmdZG
         xNp+CQNaAbnl69ExRoWk7A6FlqD5ZRnR5QAA+cOKxons+9Vt6wqvjAVvGGEqHWE5AVT3
         v25n7y5pRBi6Bp9BTbYFRlfrj3UHbzM1TWqmwnu/zb45j+5gyUqR1v29DhrKqdvwlGvu
         wg/dNbYUo+0mrSWq2YPdEoUukGxOLjzmv70Vz6V5hTNwGSyX38u9j57kNc4bged6NMLU
         Xxuw==
X-Gm-Message-State: AOJu0Yyks/Rd2m/6EUpDnVZNxZOvRxViM1PNwsrNSOdX4YwvGHXqd7jq
	+SHF8WQsmqMsODB7gJcOltzsEZvXh+Yt5X90ckpcMG04goxyBAvTxR9w9uKacx6y2ke0TCXgdbT
	eMFCysIvwHGc27w6mj9diQet4VXaQau+x0TsaZtL4BqhDlH7Xu1C5P6n56l0=
X-Gm-Gg: ASbGncuPU8Uw9KVCXMu/OdCIPDM9Z5vJNZCFyVIg8M+M84juubYZ2Ko/ztewDOIDtJA
	a7PFfzzKM866mNSH+hb+PWLsCItQeoyQ1eyIp7IJLHx/Q4niDJRFsYKrI/aslUMtPJVy2m2b9F8
	nGjFpXTJD72I3AU91dNtLnGoXwQNGJDzqxpUr1sWAmBKSbculUnPXop1F4V2ppAAkgLTf9Pc2Fc
	TfbeQhBVt8zdJmQh0/UQJpQ7GDeTBjgvRReWSM+gAGkiK0=
X-Google-Smtp-Source: AGHT+IGHvmLAKAqp+h6+xnNpvp5enqs0Nws580nvnSfEmJmHq7YmiK6/BK/XP+hcXSHZelrbBA+KbrK4+ArPIvGDx3k=
X-Received: by 2002:a17:902:e84b:b0:231:d0ef:e8ff with SMTP id
 d9443c01a7336-2485ba39492mr21568965ad.8.1756481880357; Fri, 29 Aug 2025
 08:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829064857.51503-1-enjuk@amazon.com>
In-Reply-To: <20250829064857.51503-1-enjuk@amazon.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Fri, 29 Aug 2025 08:37:48 -0700
X-Gm-Features: Ac12FXz5DCE7rZjZ7YALpNhkeMz6vVHFgx151bfCTOA8incUou3mzWHzQxbS_ZE
Message-ID: <CAAywjhSDz3F1uieMEuaFAtE2AKYXcv+5FjcDv3d4+T5ddWhy6Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next] docs: remove obsolete description about
 threaded NAPI
To: Kohei Enju <enjuk@amazon.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 11:49=E2=80=AFPM Kohei Enju <enjuk@amazon.com> wrot=
e:
>
> Commit 2677010e7793 ("Add support to set NAPI threaded for individual
> NAPI") introduced threaded NAPI configuration per individual NAPI
> instance, however obsolete description that threaded NAPI is per device
> has remained.
>
> Remove the old description and clarify that only NAPI instances running
> in threaded mode spawn kernel threads by changing "Each NAPI instance"
> to "Each threaded NAPI instance".
>
> Cc: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> ---
>  Documentation/networking/napi.rst | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/networking/napi.rst b/Documentation/networking=
/napi.rst
> index a15754adb041..7dd60366f4ff 100644
> --- a/Documentation/networking/napi.rst
> +++ b/Documentation/networking/napi.rst
> @@ -433,9 +433,8 @@ Threaded NAPI
>
>  Threaded NAPI is an operating mode that uses dedicated kernel
>  threads rather than software IRQ context for NAPI processing.
> -The configuration is per netdevice and will affect all
> -NAPI instances of that device. Each NAPI instance will spawn a separate
> -thread (called ``napi/${ifc-name}-${napi-id}``).
> +Each threaded NAPI instance will spawn a separate thread
> +(called ``napi/${ifc-name}-${napi-id}``).
>
>  It is recommended to pin each kernel thread to a single CPU, the same
>  CPU as the CPU which services the interrupt. Note that the mapping
> --
> 2.48.1
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>


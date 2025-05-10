Return-Path: <netdev+bounces-189493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C23AB25BA
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 01:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7A14A1281
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 23:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52CF214A6E;
	Sat, 10 May 2025 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiYYlewg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D684202C2D;
	Sat, 10 May 2025 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746919620; cv=none; b=uuP5PORcV0iEL2pFdrA2C1RfICFftvODB8MAuWulMlheNo6U/laQt3Mt7NjqetycHPn06QQTlGn+ppL/D2Uq0y+5YILlYHobMSRlxU08A6LoF2ruO1Yeng35UGheuasmHd1H7kLD9DCmKVsDzgOEfN60DcYjVJ1qF0Sfa1afguA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746919620; c=relaxed/simple;
	bh=kaEnMsoebMYZFan0+P52W3nn7t1tc5c0G4/vp1+Ptek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEEBWlb1M97oWa4cTMSBu2uWJFDNPW4iJ513CxNdL87KPcC7+JV21Fj4mEJ9VTqMwuzHQmTrbCURmIlI8Lh7+96Gz05y3dTX7cCjl6JGxw+iK4Azlwkd2R8tXEKFWJ3Nmd0pOV0eIQ3tB9irb9BU1fGVucr34d1mAWOaHVzJDZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiYYlewg; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3da6fb115a6so29546655ab.1;
        Sat, 10 May 2025 16:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746919618; x=1747524418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMJfv12Za/kbJTvtY3Z4ACXKyYHr9oWqnBZEu6yWLaM=;
        b=AiYYlewgmMJsdazMvWNn7Kv/ggORxLm0fJzTlYEGEyQYbm8J+CMZkSI8vN1i8x+zuq
         LK6hZqWQMRpkqq59/koiLTKLoUuUBL5Yhg8tnEzE4LN9cXsP0472NuQi2nDqMUmfmmM8
         ZjMxpp19yvQLs3b45qxVNBCj5q0fUKt8COoeeXbY+JH4eUIz6Rd5JKymVIk8W7qLAZIF
         hj18vB06yjH1vpnyHSFPhQhRSulCInl++d4rFMTEfHrl3v8uvxdb4Mxte2QSiSkq/SrV
         GF9/aKjS61XYjtbic8FVYBYXMdvBZGpOv9wyG+u3DJvLNhcCRtk0w/Cha2hQ0zeQs46q
         Rfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746919618; x=1747524418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMJfv12Za/kbJTvtY3Z4ACXKyYHr9oWqnBZEu6yWLaM=;
        b=ZDcYQlA5/vylvf7KwiEucPbR6hKielZwsRru0/BB8n+UAJTpuV3lj3a9YqGBRmG+f4
         RPbakqJ/gq8gdbt0/848MnoI3PgExNPKUxA0p79MfsTYQY5+EGhXtKp2aZdYoVwZvSHh
         bmIL7YniWWMejj9zoW8b6nNlBXZaipwjDS+sFv5LYQ6gbd2dqq/AM5L02bjSTpRhqv7n
         Gbdc5rZ9MRagbyyXJF8hrxLJlGtYFNg+0zaMoSLnUPpegA8OA0l7/DOXwToV4LG1X8Lc
         RzuZc8HdEMqQNEWtEYtdaNRTdA0f9qHNODkUnXgu8tdh55mYtLaRRdpJIDgOM3jkxjfE
         X/nw==
X-Forwarded-Encrypted: i=1; AJvYcCUDiqCpkax1tCMxXbcQ0IEn/QOorKk24+7E8K3Zpc7kaqYjJHz0g8GgUVXW0GF4LhYrRXCLHRaw@vger.kernel.org, AJvYcCV+cngMDkDi/MaHsgEZR9HrPqHWUg8wqOCvY9DWulXtlwFj4SyMjJ7Rm3ceLofnUCNuDlEKE6E166A=@vger.kernel.org, AJvYcCWnsvzyUvrMrH/oWk8J7xbB+R5H/5QrAdMInIjJdQoPkGmpyjskLI6JrzxZFihD+5y3tOovh6qpKpMFzqRo@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4j89bvFomhW17746T8npXfVDMdT28cZnwkQVI2eDzsGnJztYz
	SG4jVKzpFhQ53u3TDjYy06QMFOTC3Clks5N8y/3r53sO1zymnuwEAjoAeNgq+2/yJsWuCqknOaf
	o+UjIijll9ceqvmFHEyl5MFR1zzhqFqqucnk=
X-Gm-Gg: ASbGncst0+CgVJK+vaeNQr1wnfr4+EvbwwZVryP7JP8SxSrxoOIJ4L+JBflNU/mm9u2
	KYQRW5Cq0Nt7JrbJHo7EU8arh3d+DKXM1SlbvErUi5JYumSKJcCCrvTVxwm/Jg8RQj3cfGhVl/B
	7IFD8JwDDN6/eu4nxUvWaqY788bM+gin70JA5rzM4USFc=
X-Google-Smtp-Source: AGHT+IErnj7tz3L5EUxwRu2gmyeBcMHWILvURtY3V5eVRb0i0sgKbh+mt+ZpZ7PTG4mJojoyWiHK20oHLWhd18z/gC8=
X-Received: by 2002:a05:6e02:349a:b0:3d3:d823:5402 with SMTP id
 e9e14a558f8ab-3da7e1e77a5mr116328195ab.7.1746919618204; Sat, 10 May 2025
 16:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510113046.76227-1-alperyasinak1@gmail.com>
In-Reply-To: <20250510113046.76227-1-alperyasinak1@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 11 May 2025 07:26:22 +0800
X-Gm-Features: AX0GCFsJqm1ILQLqSHIsS6yuJgFVYUzOP6mI7QdywbA97PexMERip8nOOKS3Eww
Message-ID: <CAL+tcoA8uYpDyHxq51rJMD2G0gQ_QXn=FRLvkJX-1x=Ro+Ronw@mail.gmail.com>
Subject: Re: [PATCH] documentation: networking: devlink: Fix a typo in devlink-trap.rst
To: alperak <alperyasinak1@gmail.com>
Cc: kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 10, 2025 at 7:31=E2=80=AFPM alperak <alperyasinak1@gmail.com> w=
rote:
>
> Fix a typo in the documentation: "errorrs" -> "errors".
>
> Signed-off-by: alperak <alperyasinak1@gmail.com>

Please show your full name in the above line. Samples can be seen in
the git log.

Thanks,
Jason

> ---
>  Documentation/networking/devlink/devlink-trap.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/networking/devlink/devlink-trap.rst b/Document=
ation/networking/devlink/devlink-trap.rst
> index 2c14dfe69b3a..5885e21e2212 100644
> --- a/Documentation/networking/devlink/devlink-trap.rst
> +++ b/Documentation/networking/devlink/devlink-trap.rst
> @@ -451,7 +451,7 @@ be added to the following table:
>     * - ``udp_parsing``
>       - ``drop``
>       - Traps packets dropped due to an error in the UDP header parsing.
> -       This packet trap could include checksum errorrs, an improper UDP
> +       This packet trap could include checksum errors, an improper UDP
>         length detected (smaller than 8 bytes) or detection of header
>         truncation.
>     * - ``tcp_parsing``
> --
> 2.43.0
>
>


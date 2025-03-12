Return-Path: <netdev+bounces-174319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7C2A5E463
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 20:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833C23AB3D3
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 19:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E791CF96;
	Wed, 12 Mar 2025 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMIzZ0er"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8D31CA9C;
	Wed, 12 Mar 2025 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807749; cv=none; b=tJjb6zGftYko7fpdrdUlLwvR4tq++SHa9UFlc90RRXUg1Fpf9jr2r1LpIbt8/GYIh62KJFGnY7xcgw+SB8gl8C7wK8A1sNb40o28TFuGiG/wAlbxDfGDZrdasblpS2peFVWU26SplAW8qDak7OqG6ps6TIopq8HC4Is+3ttqHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807749; c=relaxed/simple;
	bh=97MyUnf4G0K2qQitfbAmkaZlpFZoU9Tf2IHe3v5ki3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Km7bWM+3XxCG8OLGrM8df0r4HqvKoEUoLO1XWejMAXFt57qMbSmvVfxLPlL4e8S1XHrl0dGAtD5+Z/D09N1Uq3Rt2V+rY0MBxmF12Hmvk5TAMb2poQGmZwoTUbabuTdmCm/dYFXtjFxRqQ0Oj7o5ge/RMJuBMjKS9KRlpe+weUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMIzZ0er; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bf251025aso1887361fa.1;
        Wed, 12 Mar 2025 12:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741807746; x=1742412546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=km4gQZo+oXwkzxRGvUS3l9SE39cCYwYib4CEuEJkC2s=;
        b=dMIzZ0erGit1qYcB70bhQdy9dJMgpvEEN9ZfC94PRnXCzPEq+JxYpxAcmyB5KIL1se
         s0jbSdT4mYo8vMemsVRPXhlYnbbNRpuqvFS+78wzKG9vNbCMUZP51LVE3hVBhllhv38O
         iF1zLKomCDhQ8jOl8ub/trW3ATGq2CGz/Jdg/Iy54NUg7pkNjaYM394Tmac3sMlcwULP
         6nbFWKOSqkMzRlDfA/UNHsdR19bWEMhkCA4TpvFWeAo20FN/QQwy9VCdhT/r4s9Jy7A4
         9NhbMiXQhlHclnB2uUG4i2Zqxcthg5eXvmkDj3ZSV2qXuefCfuo/MOs0kHEVr3TnzBBf
         XdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741807746; x=1742412546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=km4gQZo+oXwkzxRGvUS3l9SE39cCYwYib4CEuEJkC2s=;
        b=eb9M0CY6CXs3OggdOrY5MsrSZ/U7d16aJrHifU6zKeilp7xGx2HQ1USJ++qn6PQnxW
         Kg6+tlT+F3L+46I3/GmVbEW59PgH0cXOobkCcfHZHEwq2T96XO8pRF+cizTgdBCk+yxi
         vjkkj4hzBg5+d5+bIuXKk0NEdtuw9oyj56kRc5igMMd6t8MF+P9NXSbJV4+Xo7gHvIjm
         or5QrpdEEBixoGwm4ljvElaSxQAvZWQhFXfgIWNTS99B+iCu/XoVCrBaLiTkOPyOzkjx
         EpkMxjCV44exCsBjmapnimzRqoIa8XYmc0y24Tr6muotQzVoCZQ6iDvNBvw5q+HwyuuO
         1SEA==
X-Forwarded-Encrypted: i=1; AJvYcCUEFuD8z9muxJM4jo7oM0+05sdtURJZGlRRqwTpBeiFThih/uNn5HTtTg0wknFw9tSzwPumHbSnNsdFJG457HA=@vger.kernel.org, AJvYcCUhK5r52xpFY+w86QoaPHwgJlUN9SWxJ/hpHZ5ccQ8QC+tMUcNbQPlMH4IS/sR+BzE71TdTd0M1@vger.kernel.org, AJvYcCX6P8U4DsKRfsfmoLq0+FWPhfRPdAWwWaWmVHVhjIGex7cRvuHNYtP2J/OyDKyUHDegIZd1KSJK4EUqgRQA@vger.kernel.org
X-Gm-Message-State: AOJu0YwVX9/jWK/k4hyEqVrXCZZmxJxk1Pp4JDF0Q4fcnZ80F830KrHe
	uoZBEy2JCR7gUQFLMhleeQrUbzn+Jt8PZxlpfIs8nd5qo8+MYoB1BUCO/LcnrfIcEnCr23LmiU4
	PyGfgSqmIPTrN0ifDeiRDjNeq8uY=
X-Gm-Gg: ASbGnct0bkWRmyZjg66T+2C6MPOcPqC5zhVT9i1jX9FQHlJP3+j7jwsNeAsxCmZc3Cu
	O6cXhlzas5MlwCjzgl7uQr4Tuw1Jrg1Lr/YN+P1PusBRZcr885sKn1zCQTgsRogm9gCK+wRiIlj
	1/idRETKqQgNtIjzfg6TzJNm5W
X-Google-Smtp-Source: AGHT+IGIkOL12r4z1P3Zq+2cd0MXCwnlDq8qjvrNkAl83fMtNenCSQQ1BWV0aXPDITES3CewWiYXaktSQFobgvsCy6U=
X-Received: by 2002:a2e:9d89:0:b0:30c:189d:a198 with SMTP id
 38308e7fff4ca-30c189da9a1mr39297261fa.20.1741807745670; Wed, 12 Mar 2025
 12:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312083847.7364-1-sy2239101@buaa.edu.cn>
In-Reply-To: <20250312083847.7364-1-sy2239101@buaa.edu.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 12 Mar 2025 15:28:53 -0400
X-Gm-Features: AQ5f1JpsTo-_-5Vf9iv0eQE6g7R9ZAycQp8CnpELd6t8bq3RI2UZjltPUjRoDcc
Message-ID: <CABBYNZKSUmXvtc+bJ0aSh7ehHkePBA2Vqs1XUVwaa7H3M7eeaQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HCI: Fix value of HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE
To: Si-Jie Bai <sy2239101@buaa.edu.cn>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, cuijianw@buaa.edu.cn, sunyv@buaa.edu.cn, 
	baijiaju@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Si-Jie,

On Wed, Mar 12, 2025 at 4:39=E2=80=AFAM Si-Jie Bai <sy2239101@buaa.edu.cn> =
wrote:
>
> HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE is actually 0x1a not 0x1e:
>
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 1, Part F
> page 371:
>
>   0x1A  Unsupported Remote Feature
>
> Signed-off-by: Si-Jie Bai <sy2239101@buaa.edu.cn>
> ---
>  include/net/bluetooth/hci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 0d51970d8..3ec915738 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -683,7 +683,7 @@ enum {
>  #define HCI_ERROR_REMOTE_POWER_OFF     0x15
>  #define HCI_ERROR_LOCAL_HOST_TERM      0x16
>  #define HCI_ERROR_PAIRING_NOT_ALLOWED  0x18
> -#define HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE   0x1e
> +#define HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE   0x1a
>  #define HCI_ERROR_INVALID_LL_PARAMS    0x1e
>  #define HCI_ERROR_UNSPECIFIED          0x1f
>  #define HCI_ERROR_ADVERTISING_TIMEOUT  0x3c
> --
> 2.25.1

I tooked the following one over this since it better explains the
issue and had the Fixes tag:

https://patchwork.kernel.org/project/bluetooth/patch/20250312190943.152482-=
1-arkadiusz.bokowy@gmail.com/

--=20
Luiz Augusto von Dentz


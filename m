Return-Path: <netdev+bounces-212469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B16B20BED
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD88B3E17A6
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 14:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023152459F0;
	Mon, 11 Aug 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H70KiUIy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6861322DFB6;
	Mon, 11 Aug 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922471; cv=none; b=lknDJLbKeVgN4Cj7C+ee5ZLlkJtUJcrWNABKyFk53u96eG5KcOu7A0AG52xcqfXhvw5GZVhVIZOxl/NcgmrkTJNT8L0GJyMkZ6Qz/xOCzA3ockukTGCkqpS/+hrjNtMEFIS1SE+1hGrsRQ+iqGMH/Su3GG8l+PzhozIRbOcIuDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922471; c=relaxed/simple;
	bh=JZKI1z9Zs3b0wFpfwA7/Hf1pD/mHxa2v5ntyniMlpc8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Vrp5c0jYV32pC39j9ajvZk4vkCcxUutPZeXjb13Ef0Omp7V1n9aIIOV4ORX/C67qRx2poEgbO5xCTgGAMHg6Lybw/+35PN+2tq9WXfcJB3cvCR7As9+bJHL2VGK0M5q9O+sGNuwnN4/Ypabx2q0M95O8h98xUhqcmJKGTvIk0gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H70KiUIy; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b07275e0a4so55412511cf.3;
        Mon, 11 Aug 2025 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754922469; x=1755527269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSOVcEel7/Hqn+9G4BFiL1VUA876/K+bDXR+oTbIsNM=;
        b=H70KiUIyJA2kWew7K7AHUaUXH7kyxFGY5kBmgWkIW+6Pjs3j4YXZg3CexSp4cuJJkX
         N97+K7GJ86cLIChUENzzTdwIoqc+tsChjWWCWY/NMr8+pqHktSi0jFnSFTQGHlTOd3M+
         bOzzXyxDijtJRqIjDLib34LQ4O1N5g8oR9fofS3f/KHXLMKxpjl7a46h4biebyQGm6pj
         1V81jRColeCyvPsFS6mlUldJ0Ys9ylHkf+CtFdgZ5l6ZWO9fLPfzvALwa0ylGVEGkTxG
         PQFaORYROiNOj0Ij+ov1MhR4TUp39QEHM/DO14HwrsIzKYtLMsEfL+exC9Ce9ZA76l+1
         HSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922469; x=1755527269;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HSOVcEel7/Hqn+9G4BFiL1VUA876/K+bDXR+oTbIsNM=;
        b=JQgi6zl4y1E10BW4CBm38eXuApssX3SfS4IrsyAU5X5drxrJecc/NW50oqYKUD63RY
         vP3gDS81OWUAiBvD5lX+Tg1tA/TQQG/tGFdfwP+LFpl3voCXIoWU3fAb385kxfcp9+uB
         rmxg3YupijaHNfV9+8MsOaFZINwHL8PwOuNmmDZCQoycEJILGtl6mO1ySlPCedYAO+LD
         OXJPxvI1CCNfrXeeHM279AOGB+fStPZrzRXm+73RCvkI0Bn53DPhhvDNgGQYFwKb3xg4
         iSA8LjkfIINvV6A1jb4PyH96oVaFs/oUXU5DBcOY3altkUJDpO1bbyxSUq52fBOP83na
         ae0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSyHioANI7Li5IgbZxHEbB7p3DxHpQKT2Q8qtWcoOUGFipbLZKagpujQK0QFZdndMTvUZ+eYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9MkLG/r5gH7PlnlkQ9+xib1mh+yhGDeui6x3g3Lopf/pLMzCu
	6Cm9jB0uIt35wo4riSr1DAhyyv7cMAqKH+MXNKcN0+kqyMy54VvQSUYhc2AZC40G
X-Gm-Gg: ASbGncvmUy097i6+nne4RhcqEPOIuUnFKfdw6yh++laZQpfPux7gN33tO7i0TY1QjY9
	e0y86RLWiguY8YMGw8duTZv5cuE+BVSXGQksESUalJD5p5227b6twxJf7sm4UBGfkCosohXtkJO
	k2ZjWytodCq7doBY9fz8QeiLrMuVD8f3mGgzJBAPvgDBeKoDsqndOvcA5ImN6IP/dRoJ+nHUExM
	7ChHVhuIQmQlonATKfjUfimsEZVXSpWW+IeDu1S6jVWud7JuT54zAWuk5zUpYpHWpNSHJ/qx4Zu
	Bk1FmozWoneuquSVFQ9Fmqm2fP6OfZGflgpPdQmQCiBtbgA4GvOaWIpdIhhszl3LAmtP+KQNLWr
	H5Ae1vpV8UZLKbzD/rlCyueKzChuUpi77jLFqscug2slE47n1UbsMHdla+Agi0bcDtVbjdaDfJX
	lX8PCa
X-Google-Smtp-Source: AGHT+IFGDN/mR99ptBAHsOk3DiwZ0TrX18mOLzZj+lTn48jLOlXPx+TlFqO7AhnaFORnWsnD9uwe8w==
X-Received: by 2002:a05:622a:1807:b0:4b0:7298:1ec4 with SMTP id d75a77b69052e-4b0aee35bcbmr196744261cf.51.1754922469132;
        Mon, 11 Aug 2025 07:27:49 -0700 (PDT)
Received: from localhost (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4af0e32d04asm123174241cf.0.2025.08.11.07.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:27:48 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:27:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TWlndWVsIEdhcmPDrWE=?= <miguelgarciaroman8@gmail.com>, 
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 skhan@linuxfoundation.org, 
 =?UTF-8?B?TWlndWVsIEdhcmPDrWE=?= <miguelgarciaroman8@gmail.com>
Message-ID: <6899fde3dbfd6_532b129461@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250811112207.97371-1-miguelgarciaroman8@gmail.com>
References: <20250811112207.97371-1-miguelgarciaroman8@gmail.com>
Subject: Re: [PATCH] net: tun: replace strcpy with strscpy for ifr_name
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

[PATCH net-next]

Miguel Garc=C3=ADa wrote:
> Replace the strcpy() calls that copy the device name into ifr->ifr_name=

> with strscpy() to avoid potential overflows and guarantee NUL terminati=
on.

NULL

> Destination is ifr->ifr_name (size IFNAMSIZ).
> =

> Tested in QEMU (BusyBox rootfs):
>  - Created TUN devices via TUNSETIFF helper
>  - Set addresses and brought links up
>  - Verified long interface names are safely truncated (IFNAMSIZ-1)
> =

> Signed-off-by: Miguel Garc=C3=ADa <miguelgarciaroman8@gmail.com>
> ---
>  drivers/net/tun.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index f8c5e2fd04df..e4c6c1118acb 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2800,13 +2800,13 @@ static int tun_set_iff(struct net *net, struct =
file *file, struct ifreq *ifr)
>  	if (netif_running(tun->dev))
>  		netif_tx_wake_all_queues(tun->dev);
>  =

> -	strcpy(ifr->ifr_name, tun->dev->name);
> +	strscpy(ifr->ifr_name, tun->dev->name, IFNAMSIZ);

Since both dst and src are arrays of IFNAMSIZ, can drop the third
argument. Then it is inferred from the field sizes, which is more
robust.

>  	return 0;
>  }
>  =

>  static void tun_get_iff(struct tun_struct *tun, struct ifreq *ifr)
>  {
> -	strcpy(ifr->ifr_name, tun->dev->name);
> +	strscpy(ifr->ifr_name, tun->dev->name, IFNAMSIZ);
>  =

>  	ifr->ifr_flags =3D tun_flags(tun);
>  =

> -- =

> 2.34.1
> =





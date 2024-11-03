Return-Path: <netdev+bounces-141261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8099BA3FE
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 05:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B9D281DC5
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 04:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B4212B169;
	Sun,  3 Nov 2024 04:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kowKDVgs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F181E5234;
	Sun,  3 Nov 2024 04:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730609871; cv=none; b=VindSGGcCgESuHa824mpyRtbeJ2zOCiH87demo2d7AhCYg1na+RKTHEHeOWlhjhQvY9d7P8nm92BaM2ThFvPHrCKBqQjfSc2NYxjmADq1y1rU4/BirYc9UDI84R+llxa3LgIOjbnfdNdZzn5hX+DVkctQZoL2mvPrIIhRFheFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730609871; c=relaxed/simple;
	bh=DamPCOQqvqHgBQMIRawC2apnMnfEYjKilQOyfGyyoWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6NEcLD4+1Uxw4A8IuYWLPtxwcBHjG06IfmNb5EmX8HZtZqUzQVFzyGp+GXbTSw0p6LrMQ/5r7GhCtKGkxAbbCmO8wEZ/bkvgKoEVZlfEE2fifFgShHhseoFIKt0QxfV/QazsOgQkAiOkNHbdy3wCmbsSU1WbyvlCWizbhB4Gjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kowKDVgs; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21116b187c4so19298935ad.3;
        Sat, 02 Nov 2024 21:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730609869; x=1731214669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9CSP3/mrH4IDIU1fu+rXtqZU/482FT2wNtvgPf2ZNos=;
        b=kowKDVgsdJMnd7KZmuYxLcRJrAcnC0jfeoYoGcqmyKzVxUTmr7DN+1jMERnauliQyR
         RDcGJaiU5OuS915XD5VME7QoRs84XZYecdboI/zbVU70yM4xEOsZqMDhHVlDL2Otp6ea
         4YV72mRYSpo9UkCnw+h+eclUbUC+cMS6SttsLNdULhQHN/6VVOC/NFcQCfwzYn8SDVbb
         bbKtOCCm/jGW8jjiuZvdE+3KPJVh3lfDNNwnt2Emja0EroMLVBJftABJsPtkaAdk3XgP
         5TlkvipAmBS1TQW7ecOPB+GQOqaPqkClM8Iw/T2EGnUZS7ir8li+iMrFeNCXjSPKwuq2
         bYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730609869; x=1731214669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CSP3/mrH4IDIU1fu+rXtqZU/482FT2wNtvgPf2ZNos=;
        b=LQnPFDKJhxgMS1v1OgKy0HGP+lpPNMKCi/uBXPddM8C0PxMneJpZy7hNhBZwTxovaY
         yr9iy89jrKNg0sEbvZoIipZTbdHCR+V1SdYmfPuxjVpROcGowoxM5h9/MtD92C4umdZ1
         2QY4m4MCwCIGsJQF2adU0PN0EBqY9RMnwsuYQbHZhw9X9FW/4Fo1GxleJPiFiGoytwf9
         bVwZNUCDqcQeTl/1QERRMuzMuD0ssr6G//t1E7ZvNba9RliHAXY6opkaaT9EzVjHdocr
         nLIcLVMuJJlBUebFc/lA51AsW4qoYybY1b4GUzy4hsOxrNX27dfDp1Zcdb2FSpukHe5m
         nYcA==
X-Forwarded-Encrypted: i=1; AJvYcCW/hzmY4FQ8TVrQQsZyYZvrlwMJpxbP3zrF/Cv+o8F+dudO13ycFAM4EzC04GE2VwwPiPwqnJ2z@vger.kernel.org, AJvYcCW32gXy1DUbljenyhU0UZb+HsQ4oLB+dGQydekepfenAjwOommnsLK4GNVZyMr7yMgrUSTHT0ApWuKyJYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGwxhbR5CGCGaqZmu0bRieGM6UPzV7xwwseK+D2pbNYP3veys
	P0JTFvVHZoDUXzXaQUHLgszllO6TmTzjzK3utWa9Ace0btAuAod5
X-Google-Smtp-Source: AGHT+IG7sUBdy/xx+Zu6ChxQOE1thGM06heQMRaC4nXJLe8VdWP928UxfwL9C3m8n/n/e9mWL9jnQQ==
X-Received: by 2002:a17:903:2344:b0:20c:94d1:2cb9 with SMTP id d9443c01a7336-2111af1cdf2mr115398945ad.9.1730609869080;
        Sat, 02 Nov 2024 21:57:49 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a63f2sm40915545ad.168.2024.11.02.21.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 21:57:48 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id BFB124207D11; Sun, 03 Nov 2024 11:57:43 +0700 (WIB)
Date: Sun, 3 Nov 2024 11:57:43 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Breno Leitao <leitao@debian.org>, Jonathan Corbet <corbet@lwn.net>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v5] net: Implement fault injection forcing skb
 reallocation
Message-ID: <ZycCx6CqjvsxPMqd@archie.me>
References: <20241101-skb_fault_injection_v5-v5-1-a99696f0a853@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3xLCjlLG7xYJ1hlU"
Content-Disposition: inline
In-Reply-To: <20241101-skb_fault_injection_v5-v5-1-a99696f0a853@debian.org>


--3xLCjlLG7xYJ1hlU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 03:09:33AM -0700, Breno Leitao wrote:
> diff --git a/Documentation/fault-injection/fault-injection.rst b/Document=
ation/fault-injection/fault-injection.rst
> index 8b8aeea71c685b358dfebb419ae74277e729298a..880237dca4ff78e7f11dac3cc=
a70969a18a70cc3 100644
> --- a/Documentation/fault-injection/fault-injection.rst
> +++ b/Documentation/fault-injection/fault-injection.rst
> @@ -45,6 +45,32 @@ Available fault injection capabilities
>    ALLOW_ERROR_INJECTION() macro, by setting debugfs entries
>    under /sys/kernel/debug/fail_function. No boot option supported.
> =20
> +- fail_skb_realloc
> +
> +  inject skb (socket buffer) reallocation events into the network path. =
The
> +  primary goal is to identify and prevent issues related to pointer
> +  mismanagement in the network subsystem.  By forcing skb reallocation at
> +  strategic points, this feature creates scenarios where existing pointe=
rs to
> +  skb headers become invalid.
> +
> +  When the fault is injected and the reallocation is triggered, cached p=
ointers
> +  to skb headers and data no longer reference valid memory locations. Th=
is
> +  deliberate invalidation helps expose code paths where proper pointer u=
pdating
> +  is neglected after a reallocation event.
> +
> +  By creating these controlled fault scenarios, the system can catch ins=
tances
> +  where stale pointers are used, potentially leading to memory corruptio=
n or
> +  system instability.
> +
> +  To select the interface to act on, write the network name to the follo=
wing file:
> +  `/sys/kernel/debug/fail_skb_realloc/devname`
"... write the network name to /sys/kernel/debug/fail_skb_realloc/devname."
> +  If this field is left empty (which is the default value), skb realloca=
tion
> +  will be forced on all network interfaces.
> +
> +  The effectiveness of this fault detection is enhanced when KASAN is
> +  enabled, as it helps identify invalid memory references and use-after-=
free
> +  (UAF) issues.
> +
>  - NVMe fault injection
> =20
>    inject NVMe status code and retry flag on devices permitted by setting
> @@ -216,6 +242,19 @@ configuration of fault-injection capabilities.
>  	use a negative errno, you better use 'printf' instead of 'echo', e.g.:
>  	$ printf %#x -12 > retval
> =20
> +- /sys/kernel/debug/fail_skb_realloc/devname:
> +
> +        Specifies the network interface on which to force SKB reallocati=
on.  If
> +        left empty, SKB reallocation will be applied to all network inte=
rfaces.
> +
> +        Example usage::
> +
> +          # Force skb reallocation on eth0
> +          echo "eth0" > /sys/kernel/debug/fail_skb_realloc/devname
> +
> +          # Clear the selection and force skb reallocation on all interf=
aces
> +          echo "" > /sys/kernel/debug/fail_skb_realloc/devname
> +

The rest of docs changes looks good.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--3xLCjlLG7xYJ1hlU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZycCxwAKCRD2uYlJVVFO
oytuAP9qvyjbHCEZRQ4ccAVBL/XWZcHGp0tvN1HoCBRK+jajfAEA2IsE40V85wK5
NMBD/mmUFBkzqHjPrRCfw9cMZPdN6Aw=
=+28l
-----END PGP SIGNATURE-----

--3xLCjlLG7xYJ1hlU--


Return-Path: <netdev+bounces-186400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55486A9EEEE
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB051A80D1E
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 11:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A6262FF9;
	Mon, 28 Apr 2025 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI0ek4yE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8651FFC45;
	Mon, 28 Apr 2025 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839237; cv=none; b=iT0RCjmIoA+k68qX0jmEAVrtCwmanOnNE2fQIdiQVr3e+PHp8qeruO+Lmh+WcOQKH64JPY4Juu15Wq8YqiWcXCxMBJ+Oj1hBz+YD3SIsMErXZ8u3lBYkelKjVRBCQgYpc+x9c6SPJnIwe31kZ99Clni648gkGxWP+0d0ala+rrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839237; c=relaxed/simple;
	bh=1MAE2vSA2ExeGztIwI2W5Euf1qO2TGGX1pDG/xYRq5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Opps29npTV0idvh5eZtFgJaK2y/DK0BZKX9IwknQj0tjAKg19goK/QndCZAVuS3NvoJKYz5kYn7D8MrlH2LKAPfnr5zMlgtBNNzDNO2VPdyTRn1SiWIt06BI9YfXRPNh0wPYVuUSShIS5Fmc7yFpplWn0FJtIZJhK2L5giWXTSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI0ek4yE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22c336fcdaaso53406475ad.3;
        Mon, 28 Apr 2025 04:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745839235; x=1746444035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zeoiKe2W1Yc48k3zPSEuqht0Q72/jv/tcMqw/BIER4c=;
        b=LI0ek4yEsEuvqsi9LPXeMurrr9T28GPxNd51CuJd1XtPqle3ODF1LWFlQHt5qxGEr6
         12XMoTVYYJX4kxQAhWiCCZesNKS3tAtKW2lpybCgh57jXvAkTDtC/LGPD3A7wZ8qZztE
         bH8lbzitHwOEUf5G1Arg5o+7IM7cZLh/3qaLet9nUQqJqLaCWlTbENL17VH/f5YJKw14
         CQD0nmjX1/hNES1g1lWdkbcQtspOChZt28hdc1ZUgHeIg7MwvZrLg8hLbBBVn6Rm0Zex
         +NaM3OxhLHEfEyZYsnDXKQtCD430vxcGdX9xniKJFBYe29meK9mCRaU4RpV6RTtmgP0p
         d9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745839235; x=1746444035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeoiKe2W1Yc48k3zPSEuqht0Q72/jv/tcMqw/BIER4c=;
        b=e9eaiugJQ7NSzGbL7yVNRONQWHgYDzRQv3Bj89Ld/HrdW8X2DMTQ6D7UIe1cs0Kjdg
         KxI2q6iNKGFErJFcj773j7D6FHhAQdbxNMXIrJ6QRqs20vKZyvkp2IKR4ZbOSmHOLda3
         fmfdWF0uJVkL9lOHNv94ookeH0lZxivBnktDvwGBHRsnZ7PgazhrD4auHus6+35zT/Qb
         gohgM2rdARuHX4TpqBb85xaBxoYioVWC5atCCznk9iCuFz8hmVvRZ0j0h8y2Xh8icmw+
         c+rb6yqwa+d/bd++pS78YmcWuZUnicyCIgqe71jXP/qwknZWXLs2O/UAgkRG7qPCrHSG
         Q+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAu2M1/KQxRK3zv8rI7qaHz07aNLwJwi7zdGdyjkB4bSLfQYim6b0y1CpuEAM7Jerc/J5yAvY9KYmZ3R83@vger.kernel.org, AJvYcCWnfggQ/ftEFgHsmLr7/GJkJTv3ry08E8u3N7NcaXgInX8X0Xti0ysJgCrlLFnjq1hthL9znodYtj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8zdGOG+w2ND++qOrAOzwuJxmJJ8OPhU1YcErY99+DqprFSJA
	YGivWAKAihMBJAzmV3RM/qG93Ztp2vhLhmxR999mP6VbuYzhSu6u
X-Gm-Gg: ASbGncu843+6qcbtyOJSfMzzks+uUGfOamaAib8KZCP3p8gUtXo3rpJpHagbqbXKecL
	349N0t857VINBE5jqqiWAnRKog1ZGnlPDv6ezlY0O+t9xu4SnwZKeVfmWtu/mHu0nNTLQf8AHoy
	DxK4nowqLktWYOj/2/rIobf8uy6VXLOtYQhcujpJ48a+0BobuwF2yN8gR4ZnwxM1K6ko4pDuImM
	ByG9dpsuecVAOVdvV8UxejO8rmatZmyFdxOmQwEYfi5N5RCQ4YXYwmtDzAvoEsB1iv+3FtRiq30
	+MRVDMWfTrjRp9GRH1BChqRcbCvu2VW9F+JMbGIv
X-Google-Smtp-Source: AGHT+IFGo7DVUABwaW2xSoYjag2d0XbhQQHIzS6EBrTnK+orzIMck6P4yW4cL4RcL+wb9o2csFNgUg==
X-Received: by 2002:a17:90b:2f4c:b0:2ee:dd9b:e402 with SMTP id 98e67ed59e1d1-309f7da68f2mr22025870a91.12.1745839234596;
        Mon, 28 Apr 2025 04:20:34 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50ea440sm80008005ad.123.2025.04.28.04.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 04:20:33 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id F23A941CA464; Mon, 28 Apr 2025 18:20:30 +0700 (WIB)
Date: Mon, 28 Apr 2025 18:20:30 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: rsworktech@outlook.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] docs: tproxy: fix code block style
Message-ID: <aA9kfiqQpbONuv6W@archie.me>
References: <20250427-tproxy-docs-fix-v1-1-988e94844ccb@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zdG46O1MrI4y82Oq"
Content-Disposition: inline
In-Reply-To: <20250427-tproxy-docs-fix-v1-1-988e94844ccb@outlook.com>


--zdG46O1MrI4y82Oq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 10:36:59PM +0800, Levi Zim via B4 Relay wrote:
>  Or the following rule to nft:
> =20
> -# nft add rule filter divert tcp dport 80 tproxy to :50080 meta mark set=
 1 accept
> +    # nft add rule filter divert tcp dport 80 tproxy to :50080 meta mark=
 set 1 accept

Use double-colon syntax instead to wrap the rule above in literal code block
like in other rules.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--zdG46O1MrI4y82Oq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaA9kdQAKCRD2uYlJVVFO
oy7iAQD/6Huyhp7ZIhbYOVeO5jcZVhkqnIyi9AuJZwfdpLSMsgEApUqTiO64fBoN
nwgDjHv7yQAAyInl9yKYLEB5nxdR0ww=
=ax8J
-----END PGP SIGNATURE-----

--zdG46O1MrI4y82Oq--


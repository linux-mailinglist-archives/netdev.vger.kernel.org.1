Return-Path: <netdev+bounces-231038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91872BF426F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 02:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B247464A26
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 00:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D41C1EDA1E;
	Tue, 21 Oct 2025 00:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R21UTIxD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC81E5206
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 00:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761006728; cv=none; b=sjOR76lskyQak0885RV8JFHmWndCYsYnn64sSOYCXFlYCMMCAdPkmwetduiWcoqYlAvBXqqoheYLxh8jeP11C5rd7/qJljPcTQvbx0ZJzwKyvc1YO/R3FtQ/cwVfEL+JhbXHBGKI0G1I6yBhOCfFdvxt0r+O6zWQNeLlwJEv4t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761006728; c=relaxed/simple;
	bh=+Stx3Yos3Zj4FpodRRmLagmV52djBLh7XEfBTjgyG68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2uKCOXlpuF3I9QpLz2n3Zul/9hxYFe/2y6L2LXyA4RzeOPLBT1a+QWcoRU7x4+Ggc/fT8GwYSmhlIbngBj1nqo/hjU6yaWKYjCg93I7vTmKOC2tXwl9Xgkler82Rxw4mpsrNbXTB76KcWca5cDG+RPRyQbAqIBqwHZhSdasgJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R21UTIxD; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b57bf560703so3479490a12.2
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761006726; x=1761611526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v/cpiZvdnPNi45E0SRBN32Ra3TMzhvL+cs3dmR0W4Tg=;
        b=R21UTIxDJYopFIaaGEXEOLgBYWWmCI1PcUR8eF/oplFCKbzIWEDN8E2ApPU2yrTMfK
         5MbYDQ34eCYgNtK3TIfUc9G79wP3QGJE2hkncymQJUzvGUji628rQTwE5j0akM3Xpo/f
         YlaJKYUSjjcv9NyEzOqLUyGo7YV9/BkdqUHes8aI7mUh18EjpKQag5edT66dmjFxkb0C
         9cutgdyoS52OvhbJwMeR+Y3GzmyIUJy4pGbL48J/RUy15MGCmdrpDu3OAcMau07LBINn
         v/tCBo3QWGqOeSsT2iNaQCjv7NP12BHRqIeDFxCfmGeRgVUT3iXwyih7fwCE7KWhDuEE
         l8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761006726; x=1761611526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/cpiZvdnPNi45E0SRBN32Ra3TMzhvL+cs3dmR0W4Tg=;
        b=G0U+6iODUDnpsRZY97MX23aoXuZkvbZuRty7tLZZZFt8KjyjOjfyxs02cyCLIMeTmw
         MNy6/9v32QCObvK7HNYT4KnguPuJjNGescFsIc6MAET3o2XwsyTRpoq1PD6G1Yps27tq
         +UxWaBN16cLmAdr83dcxKb9Ow6L81NiUItO5RSl7ro7fsdh8hgAJQiebwuOjdgNqXW/4
         t5BWvVz4ETLZ2dxqye9v9Ox3HsGB3cVHcQ5vgZZHYAD1PVGqVbS3T/b6MiG2h9vbuRuZ
         Sl7FB2qK4i4j/DwfNjf4Kufl/HS7SiW8kixRdfO6jcVZr6fOaGH1vIya8x7ro54Xxif3
         vb/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUurXwFTpucljkCmZf6pO/vb5C23DjhShfWRiF8t9rEpWV2RTKlS1T1PRlGZb5Z3hSLx9iihOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3l9KSXdrgsfU35TcBmMSODU3MEo62OZamovy9sJeB7wCNJYY
	HyvnZX5P4AFvak+biluU556GENy2xw4LNSD3oK7yhlb7Wj7BAX+shPNw
X-Gm-Gg: ASbGncvH5gq+NLZfiBD7DgSZ9hwjaztUwzh1fwxuFgoEBPLj/byMTj2T3p5T0whthKU
	jYY2lnihCtkRFhFiX+7NBd6muMk8wah81sv4rE5kZER6xu5xGNbG4D6Zf6bVpGdxJnVmdj7b1oK
	z2YpN051KKVt4ZLbjwKFK6OiVOofzuVngunWZG9cK+2HzfQMdCPaNjIbAzyLcX663CxhOnWvhOR
	k4Y46jftiX7W+lUWOrVl6540z/eDFYgPK2PUPV3C31LSs1EJC3/lKQU/37SVoBruPD1RWNRtEpL
	qU2QDtSdRykukFyp+4vcozNAHUEnJvu4FOXBXLaWCRWwN5ZuA558nBk/ZrgJQhJ2zFqWW2T06eO
	SkBge4uxwKjxpPivF6fA96sceMd3L+CXo8xDTzZOkxiGaNjh+V/yQPkxevJ+4rt8stWdwbWWV7u
	2F006r/5iTy3CZVA==
X-Google-Smtp-Source: AGHT+IEsUPJvzG8we/lPr0Ah4Byy7131lhTqUy6IYRR/KgOr9A5mhJJoZH9DBN/+obua52bJEsmONw==
X-Received: by 2002:a17:902:e944:b0:290:b14c:4f36 with SMTP id d9443c01a7336-290cba4edaemr170898085ad.31.1761006725838;
        Mon, 20 Oct 2025 17:32:05 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5971sm91702065ad.56.2025.10.20.17.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 17:32:04 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 2E36D412B0A6; Tue, 21 Oct 2025 07:32:02 +0700 (WIB)
Date: Tue, 21 Oct 2025 07:32:02 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: networking: ax25: update the mailing list
 info.
Message-ID: <aPbUghAytyXEZAra@archie.me>
References: <20251020052716.3136773-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GkTDwKgTYWZMUyjt"
Content-Disposition: inline
In-Reply-To: <20251020052716.3136773-1-rdunlap@infradead.org>


--GkTDwKgTYWZMUyjt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 10:27:16PM -0700, Randy Dunlap wrote:
> Update the mailing list subscription information for the linux-hams
> mailing list.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: linux-hams@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/networking/ax25.rst |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> --- linux-next-20251016.orig/Documentation/networking/ax25.rst
> +++ linux-next-20251016/Documentation/networking/ax25.rst
> @@ -11,6 +11,7 @@ found on https://linux-ax25.in-berlin.de
> =20
>  There is a mailing list for discussing Linux amateur radio matters
>  called linux-hams@vger.kernel.org. To subscribe to it, send a message to
> -majordomo@vger.kernel.org with the words "subscribe linux-hams" in the b=
ody
> -of the message, the subject field is ignored.  You don't need to be
> -subscribed to post but of course that means you might miss an answer.
> +linux-hams+subscribe@vger.kernel.org or use the web interface at
> +https://vger.kernel.org. The subject and body of the message are
> +ignored.  You don't need to be subscribed to post but of course that
> +means you might miss an answer.

vger mailing lists has been moved to subspace infrastructure though (and
so does subscribing information [1]).

[1]: https://subspace.kernel.org/subscribing.html

--=20
An old man doll... just what I always wanted! - Clara

--GkTDwKgTYWZMUyjt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPbUgQAKCRD2uYlJVVFO
oxZzAQDVOGnv/ATVv5w6QV/t85wZvi3c09MTXjDU04j04yxQpAEAkxwHtFWG0Kb9
I7AC36LLnSDWXI5ugl6JsU/TUeE3FgA=
=WAqV
-----END PGP SIGNATURE-----

--GkTDwKgTYWZMUyjt--


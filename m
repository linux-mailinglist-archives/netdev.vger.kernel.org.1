Return-Path: <netdev+bounces-80497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5703D87F536
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 03:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C40282728
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 02:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141A064CE6;
	Tue, 19 Mar 2024 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvbdDp5I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1C564CC9;
	Tue, 19 Mar 2024 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710813608; cv=none; b=j0jpAvrGCaBZgADsleYK7UEv4fgM1naH61Qjj+rJvSnGUgHyHTOT6sOHzu3rDKSJMnKgG/HeZdZuY0wximq/p9A5K1i50V+I+kV0H69pZBQSsgrWVi6qTtSACqvNYFA4da8QXIeLaa4nzQa3ZJ2brB0CXkwewTl7nALtFr531UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710813608; c=relaxed/simple;
	bh=ut8hDUkgxvNhNW661J8IdgqhNl1h0iYMv1pVArL5g6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aza3QqQNrReNLhMImQcsl34Ptvug2A6EG8f7iVAysAFSSTTzfbsmD9SA1YbvgIJxQ99yK6WU0s7Uv8uRkCZgg6UFb5QWsxyfybw5SukSqoyJDwoMlQ7+A0//KKUB/X3yhYdlieuBN7QlaENjT7Sn91pVJJNgtKQsONv6j+z2meY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvbdDp5I; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc29f1956cso29616815ad.0;
        Mon, 18 Mar 2024 19:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710813606; x=1711418406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLi9VGflMy5URAtqCMgtdK8z2MbS+1xX/KzoZuLs/PY=;
        b=AvbdDp5I0/3MEqJMKwvoE/Vwq1CszxH0+eHL/FcwGpwHrX5RV2U2x0b5+fPlBGjnWX
         Jd1OZa46VCaCYgy4Hd10omOqwjR7MnJqtBY92P06zmFwWNnp7dNXHl702zRMRsUNWNb0
         ls/zHfthtGXiW70C+zC8tX9WTRjRztEWeyvtXiBdNHaNAwHCq5iY4RPlMHRqdcyDXOeq
         NdsT5McFHyh6g0ntY6bh7Naw2UijZMD/bCNAtqdCaBzqFNKGXC1/YiucaEP2G+pU2a6P
         w0Djrfl2IcjOsN0EA8YGdGzPA6OatmwkBHUhDw45/kzARiL+boAsfc0NiGu1KqfkvdL4
         mTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710813606; x=1711418406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLi9VGflMy5URAtqCMgtdK8z2MbS+1xX/KzoZuLs/PY=;
        b=FSH+Up0/Wu5R/jzm0ZjjY3CZZUkhP4dtpvy6/bTQaqHgkZC4Xqy87sVbEYsT6uNaoU
         2VS1VKwCqZeKRIapH+POJvTDyywLyjvKi2x3CZEQwrTkGb0xVcSoCrvATwA13m5J6EbV
         KOVMK5HrJenw4ELH2svJbCFySB8WE6PZZLJdxcHNu9OopGuqexJ5AkKbZnZ0bBOGwHC7
         +L8QCQk80gjFOPp3xeRCjsTm4X69ZtMoAazPBsubq5EnhkUNk4MFmbhUA2s5ZTm7Fste
         NPmCgySJEavSnScRUue/1jTJfqc4SVqfMsz3yFu683a90BXl2Quwx1cpHvjGHwZZ2BVk
         BN8w==
X-Forwarded-Encrypted: i=1; AJvYcCU4yYLDHMEOpfS4prd2rBALasMUA6h8MdqaXcCHeA3zNLwYfgkJAQVG5HgY1JbYX74jtzjcEW5creaSHlSGdkq+xz1qG0oT
X-Gm-Message-State: AOJu0Yx30wcp2eMFQXhGDk2qy61OrMQDb/5+kOphTmWPcxmy+yqSjB3g
	hgsZ4eYHI7jxO7UjOkKJKgKN8J/iYNLf/6oR/gPY0eHBpyO+B1Aj
X-Google-Smtp-Source: AGHT+IFBWSKuC6nFXJdQcPu63+uwETUQA3Dg84vzszNjUUBIkjs0gG36ZTfUHohf+qWS1LKC1fZfSg==
X-Received: by 2002:a17:902:ce86:b0:1dc:90a7:660b with SMTP id f6-20020a170902ce8600b001dc90a7660bmr15220504plg.9.1710813603960;
        Mon, 18 Mar 2024 19:00:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id t20-20020a170902dcd400b001dc9893b03bsm10023762pll.272.2024.03.18.19.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 19:00:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E21E71846B4A8; Tue, 19 Mar 2024 08:59:59 +0700 (WIB)
Date: Tue, 19 Mar 2024 08:59:59 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Shannon Nelson <shannon.nelson@amd.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, brett.creeley@amd.com, drivers@pensando.io
Subject: Re: [PATCH net] ionic: update documentation for XDP support
Message-ID: <Zfjxn3tLlHGRHXMV@archie.me>
References: <20240318235331.71161-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="52lFMQkhUyWJFnWC"
Content-Disposition: inline
In-Reply-To: <20240318235331.71161-1-shannon.nelson@amd.com>


--52lFMQkhUyWJFnWC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 04:53:31PM -0700, Shannon Nelson wrote:
> +XDP
> +---
> +
> +Support for XDP includes the basics, plus Jumbo frames, Redirect
> +and ndo_xmit.  There is no current for zero-copy sockets or HW offload.
"... no current support ..."

--=20
An old man doll... just what I always wanted! - Clara

--52lFMQkhUyWJFnWC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZfjxmwAKCRD2uYlJVVFO
o4PqAQDoEhjydO6itzJXPw90XloyNeSOtC7SlnXdD6ptNYAl8wEAmq/lE9855UWZ
pahDt72ESMph6ZnVelSJ0Y61F/uZ6A0=
=omcS
-----END PGP SIGNATURE-----

--52lFMQkhUyWJFnWC--


Return-Path: <netdev+bounces-159970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2689CA1789B
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 08:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B313F1884844
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 07:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA0E1A2658;
	Tue, 21 Jan 2025 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X9gSalKm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEBD2E406
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737444834; cv=none; b=Sf2aI/w4g5stF8pKd3uqO/T7h2w2wVsz9kiQqkuTQb/Q4zzuLKmUvJBT8AG8I1kmnIndgQMT2vlC5j7b1hFbWRqaPzsPEI5mYgz/zpLnEiVP7ZTVH6nJmr/s5c9W68DrwMKpuHE889qwmV/jjJY5opACO/4sh+72RTa8/AC2cPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737444834; c=relaxed/simple;
	bh=Yzs26VqKbTrmIGdnXsTKb2hA8dYm5k2fTOCESIYRSJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/XbQygvTv15pQArNTh/b5rATqEWcl5l65j8LTOUyaf+Rr297Ij2AQJ6CPn0P+uTXrivM31/q+Jpe3F54ZzTyQuViq7Gk2UbRLt3HVCQJ5dw05dS7JeZxbQV+1kBs2riPDZEAbRxZ2maEuqLUR0pxlxk4HW3sAfilKgm6ux5QMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X9gSalKm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso9121317a12.2
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 23:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737444830; x=1738049630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yzs26VqKbTrmIGdnXsTKb2hA8dYm5k2fTOCESIYRSJQ=;
        b=X9gSalKmr07M1/wUuNSdBT5nFefPL5CBrIoQOL9NeWq+OdJZNxOYt4t5AsAReFoKOe
         lE6XSXyoO4isNzt5fmIGoeOu3YKUr+fr+WcAoM67XGplJrYOtYkNHBceRKRqNfVGXF3O
         hWLzpuvP8DUqvkz4ysAaJ/LZRGZUNjtsIKtRKxHEBK/iGqg964EzOii6ffyi08gBBzjb
         hc7xhj8nrkRjCN0CS35PaIcY+TCyOzCXVDFQRt5PH+dlnssVgXNzuQW7q1B9816GMwMt
         D6z7FJCKM+7ipMkvZ7sC8lUAa7YND3Sm0YgMFdHPwKgkoyC2j9lfsruVtZz7yB7Ro5f8
         7s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737444830; x=1738049630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yzs26VqKbTrmIGdnXsTKb2hA8dYm5k2fTOCESIYRSJQ=;
        b=ldcCU5ACh3qTNDiOBFZACPbrfmsaww115gxlRmscuwWqFyvfp3qqIJ0gzQ5PZ7nBCy
         4PSL+oYSrVkREnJ3/7IaagviX7JHqrwh60Tc4oS+dsIVEzqxuYMRrQg6Y2yHnp7EPPtI
         5C5d7qe8GlW5WqisTLGevrjuJb8gT+SjlQxm9n2zTrjWfD0BqGpzveIA0xJT2odx/L3A
         9XsdJ5qYRXP1UTpeCBin23BVxVxpgRC6OIWTShLHB7/wREIHj0LAj7asfCMPnLEZO1nd
         GR77cBiAVTGYqDOPePU1BItBnTCcLqkZGRigeJcMj9FDiKxiIkIVMFSlYu5e/WGXoOQm
         YtBA==
X-Forwarded-Encrypted: i=1; AJvYcCUar5i71uL3c36O6ISCGZYpRlVw6/O6hW8c1+Kc753+UlEagmXfdSuTl8Gd4e2ey8sfp9Fsba4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKAgBe8a51rNbB9CI4KHQtPqjPxDikbDQVLDOzF2xxi+Qon3lp
	3CoLgmqhs+WA5Th6E/uKP5KK2sBeOYYu9D9rZjzUTop0DPR3AdvWZs7Pxt6QxnA=
X-Gm-Gg: ASbGncucNgeed3sXMvH9mUxBOcjD7FQrRwO+A6bSd8eSHJCYwTpg9yFPMCZzOAeWhi/
	Xoimgg/VhNdFb5FEihu25ROrxwStrYOjqWOQOhmv0ME8uaiD7iwBFuvl5QN4eGZlF46DCOLrCMY
	vswwEjQvOwoPbyTyzaShXxjRPwmoDHdXI5gcD5o3W/S/55ovsK8wEkkJIeCchllJl/dsXSRC8fG
	yvF3KWYx00/Z6zDw0LDd6STb+GwwY7FmcTmTLrIxg+pH3V5P4N9EKhwV1JyADyTY1Ph8JZCkUM=
X-Google-Smtp-Source: AGHT+IE8IaZxkKmu64HBjKfnj9GgkEaEDLjA+fSFVfmw5FsiBqi3KoLB/CnrwQev1xRM05yMk5Ttiw==
X-Received: by 2002:a05:6402:5201:b0:5d1:2440:9ad3 with SMTP id 4fb4d7f45d1cf-5db7d633180mr15830571a12.30.1737444829308;
        Mon, 20 Jan 2025 23:33:49 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dbe6de509esm60852a12.70.2025.01.20.23.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 23:33:48 -0800 (PST)
Date: Tue, 21 Jan 2025 08:33:45 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, paul@crapouillou.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zijie98@gmail.com
Subject: Re: [PATCH] net: davicom: fix UAF in dm9000_drv_remove
Message-ID: <xttnvcmu3dep2genvce3r7spreliecx3dc3rynups25q6xilk6@tf4wxe6bdxia>
References: <20250120222557.833100-1-chenyuan0y@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ljgtlteej75idhb"
Content-Disposition: inline
In-Reply-To: <20250120222557.833100-1-chenyuan0y@gmail.com>


--7ljgtlteej75idhb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] net: davicom: fix UAF in dm9000_drv_remove
MIME-Version: 1.0

Hello,

On Mon, Jan 20, 2025 at 04:25:57PM -0600, Chenyuan Yang wrote:
> dm is netdev private data and it cannot be
> used after free_netdev() call. Using adpt after free_netdev()

What is adpt?

> can cause UAF bug. Fix it by moving free_netdev() at the end of the
> function.

"can cause"? Doesn't that trigger reliable?

How did you find that issue? Did this actually trigger for you, or is it
a static checker that found it? Please mention that in the commit log.
=20
> This is similar to the issue fixed in commit
> ad297cd2db8953e2202970e9504cab247b6c7cb4 ("net: qcom/emac: fix UAF in ema=
c_remove").

Please shorten the commit id, typically to 12 chars as you did in the
Fixes line below.

> Fixes: cf9e60aa69ae ("net: davicom: Fix regulator not turned off on drive=
r removal")
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>

Best regards
Uwe

--7ljgtlteej75idhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmePTdQACgkQj4D7WH0S
/k5lRggAh5bqOp3FEgchanxSd0qVBUDRc+bz2sYknhhwMikTZnNUp0kWgpZZXX2c
WAIe6XkmVtEEM+BLuSbRYfqwMZqXKVWWKGR4k06qFYEK03HFeSqS+dbzp5sSwRTa
rQNL9AymnRwIqtAr0ECC0g8Dsj9rUDYY8UUjZkHK0PMM3HEk/+A+m/7xc/suud5X
1Ms7fMpXE4EWVWeIGdZ1rUMqQfw0i0waEcNVUV6yOQJ9R6Z9n5Lzt1E4E0ruI1or
mI935sourepBCG0niig71TfrYBHxghIG2v3VlJkEa0Iab++Hp/g8yXYSAUDcNi93
N3dvccAjMEAjGDW8EzQ4Us4l8+Di0Q==
=oaD9
-----END PGP SIGNATURE-----

--7ljgtlteej75idhb--


Return-Path: <netdev+bounces-185695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3499A9B691
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE725189D0C1
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC09290BB6;
	Thu, 24 Apr 2025 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpleZ2Du"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF92900AB;
	Thu, 24 Apr 2025 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519990; cv=none; b=GcEDLSa7ZiSRn1tyeQj9SMZ5B0CMEla4xHrflLaE9z4hL5WZyX6VqHAM8gQlmVc/AZYKFQi4zzAK6wYaeIsoAfGxpt8kaY6cpv5MXvu+7DeGIz7WLctKFy6crDc2xgnrGZbrVzz078SWAvdByutxn2/qJb5KIBxCsyTsbMQN4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519990; c=relaxed/simple;
	bh=jC52bw6t16raUsES7KwHGPTQILUfPWGdxnKguMyCdY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7q3s2jhR3FxOlEIYfJagIhhR2jF00A4uJaQQ5yofODWon2FQIaEo6nyOHWIGsncWoA/TrzlR+dSj0s5hbKMxqGNeebUuhn6MZ43dYHeZCilJFtmyhF85B5XfSz3oaogDsGNSn+GDUmGrkixNUQKbEuu/6rB/tFWz23/pIVHvcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpleZ2Du; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so12435695e9.3;
        Thu, 24 Apr 2025 11:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745519987; x=1746124787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jC52bw6t16raUsES7KwHGPTQILUfPWGdxnKguMyCdY8=;
        b=DpleZ2DuTV9dW8eSaMH16j9QRxJucx2FHo/xOdGmtDrtHai6uuIajKdRbKWVnhsE5T
         GwC1n8AAy+MD4MSpx60LFQvyZDZR13SAUbRlP8VJaeP8lutCxcinT6kZXm/tkx2lnaB5
         nIJg+8jnDZNGClQcr2JZRIqtr/gTQTIkBXLfEx69v4TZIQJkFg86FVLkVz4FFNXJDyJW
         dZUoUajH+aevuU7NrkVbVmyb9DFQWMjgwsseLYPZBz8Hs0tOFi82M2tZ0Ez7Q6y7+rqN
         Sk2uTj/8uNtWlbYLq6TsJARRjzD5hsxrLWG8JoPVpz16MRRnRX6gSDIo9SuY62pikOgH
         s5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745519987; x=1746124787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jC52bw6t16raUsES7KwHGPTQILUfPWGdxnKguMyCdY8=;
        b=qy71XB8XR9rkM/XjxtANifZM+32QiUyZIXWEeJYpALALkfcpSa9EQWzY8Xg659+LWp
         9PhNhceQwPZxq5tE14vxnEjGRTydLBtDh6+0rfaXjyQ00/DvA/6sXrhTVdy5nPeTcqs8
         j8VPmYbw/iiN2eh4Nk79hRTv9v3mDOqbVNIQZyxkWPMfMI+UeSNhB37Da1zwdz+Ny4Mo
         7bUU+Uiddu32DYQ97Q9JOvMLdsWK6R7l4bGqwITlr4MPMHQBeLncdqoGrsGBcFR9Egin
         UtfyvLluTluVbCMVJf/NjbKTBQzgYQn07bFKXCPHzLj+8myVTed9iHLHEN2lLz15rhoF
         sIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWffOKpcuBwNdT4QBQ3jmaDUTQk0+kmhKVon0Qx1dhbXASETzb8L3KEiw+aGfPIB+5wYB0JQHW6@vger.kernel.org, AJvYcCXk8tvJ8CsVBkWXzlXNLCnxQILxo2f6qnp/g6cQTJ7E+o5PTkgRXEC4ToyUVKy++MRcA0BZzBxZbHcQUkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmkzrkQo1L9Gq1Te+Wn+xPUNCT8gaWk4Yn4Ss3h/iB0gAtDfvP
	S6Fal9tR5RIj5k3nhkdjelUT/PlktSFzg+raNSQuROM9FvKgISXf
X-Gm-Gg: ASbGnctXeQ46U2gKKrZW1KjrWvAvMAqVLQM7k7mJ0AnBJ4Tt9luquN12ldylCOZCiOE
	AI13EC+dxhZVLQ+CPdX4UZAP7wywRQ8Jdh34N/q3b+uyFZgW1vIhXlK1J/Cri/HRfDx4HTfS8t3
	O85hnKSLdUnIEfDEup5IzP6d/IcyQWQy3xcMPQqE55TwnI5/NwwJeKky4xcw3QSdFnnivPl0zp0
	JphhZyYdmKoS305B2xg/vYxOTmTxwzwYPe9ivcMfEVp+HxHU45c+sc+hYN3qRYPZzXwNX6EXWMV
	czeUWN7Tdau+GOh/HDnm581N60hNhadwxlmr7A97CDg6QGfpYntWTLkeuOAVnGZHgqOIDliLgdr
	j5Ceuer0199AMsu5i
X-Google-Smtp-Source: AGHT+IHMwFWIrBhjk8UxuLOzeFScC4TQFWpL2+Mff47w2LSyphzAh89JVRhQX3G0jfdSCa1w437IRg==
X-Received: by 2002:a05:600c:c8f:b0:43c:f597:d582 with SMTP id 5b1f17b1804b1-440a30e739amr5269115e9.1.1745519986788;
        Thu, 24 Apr 2025 11:39:46 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5c82fsm34693f8f.85.2025.04.24.11.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 11:39:46 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Corentin Labbe <clabbe.montjoie@gmail.com>, Yixun Lan <dlan@gentoo.org>,
 Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [RFC PATCH net-next] net: stmmac: sun8i: drop unneeded default syscon
 value
Date: Thu, 24 Apr 2025 20:39:44 +0200
Message-ID: <4974609.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20250423095222.1517507-1-andre.przywara@arm.com>
References: <20250423095222.1517507-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne sreda, 23. april 2025 ob 11:52:22 Srednjeevropski poletni =C4=8Das je A=
ndre Przywara napisal(a):
> For some odd reason we are very picky about the value of the EMAC clock
> register from the syscon block, insisting on a certain reset value and
> only doing read-modify-write operations on that register, even though we
> pretty much know the register layout.
> This already led to a basically redundant variant entry for the H6, which
> only differs by that value. We will have the same situation with the new
> A523 SoC, which again is compatible to the A64, but has a different syscon
> reset value.
>=20
> Drop any assumptions about that value, and set or clear the bits that we
> want to program, from scratch (starting with a value of 0). For the
> remove() implementation, we just turn on the POWERDOWN bit, and deselect
> the internal PHY, which mimics the existing code.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Thanks for doing that!

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej




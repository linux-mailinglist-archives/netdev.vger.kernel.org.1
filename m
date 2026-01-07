Return-Path: <netdev+bounces-247790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12980CFE72A
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 16:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1FA8300E17B
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE28735CBB3;
	Wed,  7 Jan 2026 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YziDo8/j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544430E0F4
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797960; cv=none; b=EIC5KEtPTXGOu+KbGfNj4/tsXJ9HKx9SD/OIPSWTCG8bNIgAPAxhKwkx8aEDgKd3ztK8UsefODByLD8NQJfJMXxiEPvOkacDgqzjlr8iO7tWs9mrpE264RK2uNgI6eGQ99iXibJHADpcbb7VGbziHyvvIyaMHo74jnJrb4j2jAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797960; c=relaxed/simple;
	bh=lZz8ZAu8vrs8Ru98ohAatnW1AHr7PhD4PTK1H1/KWrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=anpnnHIbO5LrduDhGWX72/IeW7wiOBbAFXGRzs5gxEhJ4Pve79FFLggtf95rGE2a8eeZ6ANCBBm7phIAKPYy15m1YW6ubY1mo/nuo12SM8Gh2s+fGqdUDcFE0hYaJVsNlxo/nthiIBDr+A/k7bAIqKpYROSmQskCgbW7cNECKv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YziDo8/j; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4327790c4e9so1057534f8f.2
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 06:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767797957; x=1768402757; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SV1cZScFIWK8ylac8dKg4D7bUheGaqaRyP9KVJQ7iTw=;
        b=YziDo8/jjXzxLszplOUg1Yx6muPbjxZOE7bZ4LgGXuDk12djjYrsTa/4ZKQv2OSYjo
         /twTzpNbYWievfgD0Wy4NGc6q/mDd1YTJ4ljI7aPky8IscuhbuY35FVMA5m7sNnfGvnY
         //zEpK9WlpsGVuIRrpA8YRrFKk2+dVeHA1ZfdB+s4vJygrojTPAwc3VQXyDwwOTuizuG
         D4k2ytcIy0nkM/8iah+f+CR5+V+7KLkKA9JNyFEKwbsqJO4NbNpj4iYxrS5RnZc6yjov
         Vkp/ppKjuvvo/xEQ3I5Tb2Ffmm46xG87x8hmdcQV0mBGBv7m+jV80sAF0RK4xv/pxSNH
         8Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767797957; x=1768402757;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SV1cZScFIWK8ylac8dKg4D7bUheGaqaRyP9KVJQ7iTw=;
        b=Hfb3pQvsNtekjOfBNtbQEO+edggMM0JzxPSnBQDAeuGsS5wGUSVnCRriA5GzMmQzNX
         WN1nh+NGBghfTyRCIjkqXXyuU0uCE3AWoP5nv6hJw/wA4VoQ4PqsnPPMUF8ZFi7C0Q69
         FORDtWMZh0Y+o7u6q+yT+Lzy53BnNSeucZ20LLSAImFTTEeCutS83wq58MWHrDYcx8/k
         l6gh8d1DDZwdleFh2nXiJ3arPjRvewCDfN3Xg5ImeFWNqtKn7/JY/f7Gl3uQvkCUQr6m
         g0miSEGRhPTqCrbaMqT7FMQrObDm1FKbOXObgOCbBVapYP6P5sHKJu9tglfQr50rgFh5
         +nkg==
X-Gm-Message-State: AOJu0YwW7Kknubzi3sS/rM7UXpJHLZF0dORS4cCh1eJgBHxYfvGx2Tb/
	QIKGFjwtytiFROa8DFoHpex879WDUvUk+urApLKV5ZGHK73iwPl+X4Fd
X-Gm-Gg: AY/fxX5KdBxR627xL62Z1aSjbUh75UVbQ6cMVDoYKOiqKVmiww3zmDtVs83gNgkOQd9
	llCLsJ9K6/Uk6aNXVqE5ihSOlzb/Lx7eLX6iq3vtC16Z0JssJ17MXqc3BgPbJuYaVBPmQdtWiap
	SG51PmFMcjrtGG6a0OXehW9xIUnoGe2ncf7ZvOk+jGbmJlzIeb9cRxRYreuFUtHDEB9p8PWE3vi
	3eRgMhHEDbMG9o96hJSWZxjcUltD4dXU9EDTXSku9xR0SrtBBGDRagOTkUpPENh+dhiKkzYK6Sd
	zxFt//CAP10IQJ/VwbloyS7tqMECm0IYf0v/CJLC1Od+tUoJAFcHrJuEw6TE+jK7BKWTHzv/DZx
	l/r9AeIyH1srY35VdlLpn4Hxf+40fBDDvX9ReQNos/IZOC7K6Ggg/7XVxeKmDF/lhExs4YOfNGJ
	177eX98TWIiwUWu/bej+4WSXVext7XLoQrXiX+JaSwyJ7A1/DeKhYG5x7UXHCPHh5q8Q8=
X-Google-Smtp-Source: AGHT+IG1YououSj/EXDwxzVarDQZ72uogU8BTCNy+0HLyFRU+zonnThKVMk8YKlAXuXT6L0Z4fcuMQ==
X-Received: by 2002:a5d:5d11:0:b0:432:c0e6:cfcd with SMTP id ffacd0b85a97d-432c3632bc5mr3400757f8f.22.1767797957100;
        Wed, 07 Jan 2026 06:59:17 -0800 (PST)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm10690182f8f.31.2026.01.07.06.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 06:59:16 -0800 (PST)
Message-ID: <297860d547bb93b794e7b1cee4eb7b93b9e05e9d.camel@gmail.com>
Subject: Re: [PATCH net-next] selftests: forwarding: update PTP tcpdump
 patterns
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Wed, 07 Jan 2026 15:59:17 +0100
In-Reply-To: <20260107145320.1837464-1-kuba@kernel.org>
References: <20260107145320.1837464-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jakub,

On Wed, 2026-01-07 at 06:53 -0800, Jakub Kicinski wrote:
> Recent version of tcpdump (tcpdump-4.99.6-1.fc43.x86_64) seems to have
> removed the spurious space after msg type in PTP info, e.g.:
>=20
> =C2=A0before:=C2=A0 PTPv2, majorSdoId: 0x0, msg type : sync msg, length: =
44
> =C2=A0after:=C2=A0=C2=A0 PTPv2, majorSdoId: 0x0, msg type: sync msg, leng=
th: 44
>=20
> Update our patterns to match both.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> CC: shuah@kernel.org
> CC: vladimir.oltean@nxp.com
> CC: alexander.sverdlin@gmail.com
> CC: linux-kselftest@vger.kernel.org
> ---
> =C2=A0.../net/forwarding/local_termination.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 18 +++++++++---------
> =C2=A01 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh =
b/tools/testing/selftests/net/forwarding/local_termination.sh
> index 892895659c7e..1f2bf6e81847 100755
> --- a/tools/testing/selftests/net/forwarding/local_termination.sh
> +++ b/tools/testing/selftests/net/forwarding/local_termination.sh
> @@ -306,39 +306,39 @@ run_test()
> =C2=A0
> =C2=A0	if [ $skip_ptp =3D false ]; then
> =C2=A0		check_rcv $rcv_if_name "1588v2 over L2 transport, Sync" \
> -			"ethertype PTP (0x88f7).* PTPv2.* msg type : sync msg" \
> +			"ethertype PTP (0x88f7).* PTPv2.* msg type *: sync msg" \
> =C2=A0			true "$test_name"
> =C2=A0
> =C2=A0		check_rcv $rcv_if_name "1588v2 over L2 transport, Follow-Up" \
> -			"ethertype PTP (0x88f7).* PTPv2.* msg type : follow up msg" \
> +			"ethertype PTP (0x88f7).* PTPv2.* msg type *: follow up msg" \
> =C2=A0			true "$test_name"
> =C2=A0
> =C2=A0		check_rcv $rcv_if_name "1588v2 over L2 transport, Peer Delay Requ=
est" \
> -			"ethertype PTP (0x88f7).* PTPv2.* msg type : peer delay req msg" \
> +			"ethertype PTP (0x88f7).* PTPv2.* msg type *: peer delay req msg" \
> =C2=A0			true "$test_name"
> =C2=A0
> =C2=A0		check_rcv $rcv_if_name "1588v2 over IPv4, Sync" \
> -			"ethertype IPv4 (0x0800).* PTPv2.* msg type : sync msg" \
> +			"ethertype IPv4 (0x0800).* PTPv2.* msg type *: sync msg" \
> =C2=A0			true "$test_name"
> =C2=A0
> =C2=A0		check_rcv $rcv_if_name "1588v2 over IPv4, Follow-Up" \
> -			"ethertype IPv4 (0x0800).* PTPv2.* msg type : follow up msg" \
> +			"ethertype IPv4 (0x0800).* PTPv2.* msg type *: follow up msg" \
> =C2=A0			true "$test_name"
> =C2=A0
> =C2=A0		check_rcv $rcv_if_name "1588v2 over IPv4, Peer Delay Request" \
> -			"ethertype IPv4 (0x0800).* PTPv2.* msg type : peer delay req msg" \
> +			"ethertype IPv4 (0x0800).* PTPv2.* msg type *: peer delay req msg" \
> =C2=A0			true "$test_name"
> =C2=A0
> =C2=A0		check_rcv $rcv_if_name "1588v2 over IPv6, Sync" \
> -			"ethertype IPv6 (0x86dd).* PTPv2.* msg type : sync msg" \
> +			"ethertype IPv6 (0x86dd).* PTPv2.* msg type *: sync msg" \
> =C2=A0			true "$test_name"
> =C2=A0
> =C2=A0		check_rcv $rcv_if_name "1588v2 over IPv6, Follow-Up" \
> -			"ethertype IPv6 (0x86dd).* PTPv2.* msg type : follow up msg" \
> +			"ethertype IPv6 (0x86dd).* PTPv2.* msg type *: follow up msg" \
> =C2=A0			true "$test_name"
> =C2=A0
> =C2=A0		check_rcv $rcv_if_name "1588v2 over IPv6, Peer Delay Request" \
> -			"ethertype IPv6 (0x86dd).* PTPv2.* msg type : peer delay req msg" \
> +			"ethertype IPv6 (0x86dd).* PTPv2.* msg type *: peer delay req msg" \
> =C2=A0			true "$test_name"
> =C2=A0	fi
> =C2=A0

--=20
Alexander Sverdlin.


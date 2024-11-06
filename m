Return-Path: <netdev+bounces-142237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 787749BDF39
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977BA1C21ACE
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 07:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C33E1AF0CF;
	Wed,  6 Nov 2024 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=falix.de header.i=@falix.de header.b="rLagMVJe"
X-Original-To: netdev@vger.kernel.org
Received: from mail.falix.de (mail.falix.de [37.120.163.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F238D10E5
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.163.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730877486; cv=none; b=GqkChLbGaTDdBWCSobdG7ezgcWHt7xbuHdHn0bO6yi+WGI19AutptaXvDG/a2gmSzGRyOwE5c1tP+k1uIUF6HfMJ0BUwseYxazXwKm7zFGNDLSb7F1zZRiob+kn9h5GyW3oQVTxHFKjjSnZNZXUDNA/LCPmfZ2FtGALRJC4pwXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730877486; c=relaxed/simple;
	bh=cCdsb0wTddsXLjFsuhpMlXU60N9dFrg6zPJdb0zBEbQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJ6hZhTlq/Oea8Le8Z0rZDdoPRY9W74u7ZcNfjXkUStVzzB4iu6v3ZeEOJkpTmMZwwYGl6i/Y1WNoeuPHWwvqLC3YHt1p7rcCxMpornBN88V6tdGAX2TwP5tEuMqKtKAJKggTcEuYErL+jHrBmwu6OFP5r33PmgtAa38Uv9GVUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=falix.de; spf=pass smtp.mailfrom=falix.de; dkim=pass (2048-bit key) header.d=falix.de header.i=@falix.de header.b=rLagMVJe; arc=none smtp.client-ip=37.120.163.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=falix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=falix.de
Received: from [192.168.221.20] (ppp-82-135-66-21.dynamic.mnet-online.de [82.135.66.21])
	by mail.falix.de (Postfix) with ESMTPSA id A7880611EA;
	Wed, 06 Nov 2024 08:17:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=falix.de;
	s=trustedmail; t=1730877476;
	bh=cCdsb0wTddsXLjFsuhpMlXU60N9dFrg6zPJdb0zBEbQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=rLagMVJemnxQYy7NkbMq+eR9qG+rFfq/5B2VMZpKB8wqZJZp4bpMoSFwXJY7XGVfV
	 mNFxnwRvQm/PC+0eEnTc3NhNoCW6CK0nER9IHYd1MEiZLJEAfHlDN/huuLW3eYeHJp
	 iM+9yjC+HFJ4eejRF0mgEJreJYo9szfCQ0dzDICMROCxqgsIfLjUiHHTZ7GgXFYK5J
	 7MRZqwmHbyO9PNWuru1FchD3oeyB1uLA6z2w1Z0yaq62ZRW9Zo9IWJqkuKbz+HkRf/
	 6va8qiP6FdA2SQkihY5vTgdQw+Yg+IiClgc6o3pLMamCsOOhgaGXyuHuECg8YyrCzk
	 BmUIQxX9reyGg==
Message-ID: <bc3fcce37ca80eb5972a56185fcb499872781700.camel@falix.de>
Subject: Re: r8169: regression in connection speed with kernels 6.2+
 (interrupt coalescing)
From: Felix Braun <f.braun@falix.de>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com
Cc: netdev@vger.kernel.org
Date: Wed, 06 Nov 2024 08:17:55 +0100
In-Reply-To: <e6f8e86d-62ee-4fc8-a92d-3fc6e963433c@gmail.com>
References: <ff6d9c69c2a09de5baf2f01f25e3faf487278dbb.camel@falix.de>
	 <c224bee7-7056-4c2a-a234-b8cb79900d40@gmail.com>
	 <a5bb19c7a363bef7e3a5f4abd69adb0c9fc666b5.camel@falix.de>
	 <324136cf-80f5-4d3d-8583-85b603794187@gmail.com>
	 <c1eb782d2fedbb0dbd2b249fac19faadf6c36857.camel@falix.de>
	 <e6f8e86d-62ee-4fc8-a92d-3fc6e963433c@gmail.com>
Organization: Vectrix -- Legal Dept.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


On 05.11.2024 22:28 +0100 Heiner Kallweit wrote:
> On 05.11.2024 20:57, Felix Braun wrote:
> >=20
> > Measuring the performance with iperf3 I still see a difference in throu=
ghput
by
> > a factor of 3:
> >=20
> > WITH napi_defer_hard_irqs=3D0
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > [=C2=A0 5] local 2001:a61:11c6:9501:982a:b19f:94fc:71d1 port 41716 conn=
ected to
> > 2001:a61:11c6:9501:97a8:b80a:4317:435e port 5201
> > [ ID] Interval=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Transfer=C2=A0=C2=A0=C2=A0=C2=A0 Bitrate=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Retr=C2=A0 Cwnd
> > [=C2=A0 5]=C2=A0=C2=A0 0.00-1.00=C2=A0=C2=A0 sec=C2=A0=C2=A0 112 MBytes=
=C2=A0=C2=A0 941 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 315 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 1.00-2.00=C2=A0=C2=A0 sec=C2=A0=C2=A0 110 MBytes=
=C2=A0=C2=A0 927 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 340 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 2.00-3.00=C2=A0=C2=A0 sec=C2=A0=C2=A0 111 MBytes=
=C2=A0=C2=A0 930 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 372 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 3.00-4.00=C2=A0=C2=A0 sec=C2=A0=C2=A0 111 MBytes=
=C2=A0=C2=A0 930 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 372 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 4.00-5.00=C2=A0=C2=A0 sec=C2=A0=C2=A0 110 MBytes=
=C2=A0=C2=A0 926 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 372 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 5.00-6.00=C2=A0=C2=A0 sec=C2=A0=C2=A0 111 MBytes=
=C2=A0=C2=A0 929 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 372 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 6.00-7.00=C2=A0=C2=A0 sec=C2=A0=C2=A0 110 MBytes=
=C2=A0=C2=A0 924 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 372 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 7.00-8.00=C2=A0=C2=A0 sec=C2=A0=C2=A0 111 MBytes=
=C2=A0=C2=A0 932 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 372 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 8.00-9.00=C2=A0=C2=A0 sec=C2=A0=C2=A0 110 MBytes=
=C2=A0=C2=A0 924 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 372 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 9.00-10.00=C2=A0 sec=C2=A0=C2=A0 111 MBytes=C2=
=A0=C2=A0 928 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 372 KBytes
> > - - - - - - - - - - - - - - - - - - - - - - - - -
> > [ ID] Interval=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Transfer=C2=A0=C2=A0=C2=A0=C2=A0 Bitrate=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Retr
> > [=C2=A0 5]=C2=A0=C2=A0 0.00-10.00=C2=A0 sec=C2=A0 1.08 GBytes=C2=A0=C2=
=A0 929 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sender
> > [=C2=A0 5]=C2=A0=C2=A0 0.00-10.00=C2=A0 sec=C2=A0 1.08 GBytes=C2=A0=C2=
=A0 928 Mbits/sec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
receiver
> >=20
> > WITH napi_defer_hard_irqs=3D1
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > Connecting to host leporello, port 5201
> > [=C2=A0 5] local 2001:a61:11c6:9501:982a:b19f:94fc:71d1 port 42338 conn=
ected to
> > 2001:a61:11c6:9501:97a8:b80a:4317:435e port 5201
> > [ ID] Interval=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Transfer=C2=A0=C2=A0=C2=A0=C2=A0 Bitrate=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Retr=C2=A0 Cwnd
> > [=C2=A0 5]=C2=A0=C2=A0 0.00-1.00=C2=A0=C2=A0 sec=C2=A0 37.0 MBytes=C2=
=A0=C2=A0 310 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 806 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 1.00-2.00=C2=A0=C2=A0 sec=C2=A0 35.0 MBytes=C2=
=A0=C2=A0 294 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 806 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 2.00-3.00=C2=A0=C2=A0 sec=C2=A0 35.1 MBytes=C2=
=A0=C2=A0 294 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 806 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 3.00-4.00=C2=A0=C2=A0 sec=C2=A0 35.0 MBytes=C2=
=A0=C2=A0 294 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 806 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 4.00-5.00=C2=A0=C2=A0 sec=C2=A0 35.2 MBytes=C2=
=A0=C2=A0 296 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 806 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 5.00-6.00=C2=A0=C2=A0 sec=C2=A0 35.0 MBytes=C2=
=A0=C2=A0 294 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 806 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 6.00-7.00=C2=A0=C2=A0 sec=C2=A0 34.9 MBytes=C2=
=A0=C2=A0 293 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 806 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 7.00-8.00=C2=A0=C2=A0 sec=C2=A0 34.9 MBytes=C2=
=A0=C2=A0 293 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 806 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 8.00-9.00=C2=A0=C2=A0 sec=C2=A0 35.0 MBytes=C2=
=A0=C2=A0 294 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 806 KBytes
> > [=C2=A0 5]=C2=A0=C2=A0 9.00-10.00=C2=A0 sec=C2=A0 35.2 MBytes=C2=A0=C2=
=A0 295 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 806 KBytes
> > - - - - - - - - - - - - - - - - - - - - - - - - -
> > [ ID] Interval=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Transfer=C2=A0=C2=A0=C2=A0=C2=A0 Bitrate=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Retr
> > [=C2=A0 5]=C2=A0=C2=A0 0.00-10.00=C2=A0 sec=C2=A0=C2=A0 352 MBytes=C2=
=A0=C2=A0 296 Mbits/sec=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sender
> > [=C2=A0 5]=C2=A0=C2=A0 0.00-10.02=C2=A0 sec=C2=A0=C2=A0 349 MBytes=C2=
=A0=C2=A0 292 Mbits/sec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
receiver
> >
>=20
> Could you please test also in the other direction (with option -R)?
>=20
WITH napi_defer_hard_irqs=3D0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Connecting to host leporello, port 5201
[  5] local 2001:a61:11db:401:95c6:dca7:5be7:e7f0 port 33400 connected to
2001:a61:11db:401:f969:3328:8a89:ebd2 port 5201
[  7] local 2001:a61:11db:401:95c6:dca7:5be7:e7f0 port 33414 connected to
2001:a61:11db:401:f969:3328:8a89:ebd2 port 5201
[ ID][Role] Interval           Transfer     Bitrate         Retr  Cwnd
[  5][TX-C]   0.00-1.00   sec   112 MBytes   939 Mbits/sec    0    409 KByt=
es
[  7][RX-C]   0.00-1.00   sec   107 MBytes   893 Mbits/sec
[  5][TX-C]   1.00-2.00   sec   110 MBytes   921 Mbits/sec    0    430 KByt=
es
[  7][RX-C]   1.00-2.00   sec   107 MBytes   896 Mbits/sec
[  5][TX-C]   2.00-3.00   sec   110 MBytes   925 Mbits/sec    0    430 KByt=
es
[  7][RX-C]   2.00-3.00   sec   106 MBytes   892 Mbits/sec
[  5][TX-C]   3.00-4.00   sec   110 MBytes   925 Mbits/sec    0    430 KByt=
es
[  7][RX-C]   3.00-4.00   sec   107 MBytes   898 Mbits/sec
[  5][TX-C]   4.00-5.00   sec   110 MBytes   925 Mbits/sec    0    430 KByt=
es
[  7][RX-C]   4.00-5.00   sec   106 MBytes   892 Mbits/sec
[  5][TX-C]   5.00-6.00   sec   110 MBytes   924 Mbits/sec    0    430 KByt=
es
[  7][RX-C]   5.00-6.00   sec   107 MBytes   895 Mbits/sec
[  5][TX-C]   6.00-7.00   sec   110 MBytes   926 Mbits/sec    0    430 KByt=
es
[  7][RX-C]   6.00-7.00   sec   106 MBytes   892 Mbits/sec
[  5][TX-C]   7.00-8.00   sec   110 MBytes   923 Mbits/sec    0    430 KByt=
es
[  7][RX-C]   7.00-8.00   sec   107 MBytes   894 Mbits/sec
[  5][TX-C]   8.00-9.00   sec   111 MBytes   930 Mbits/sec    0    430 KByt=
es
[  7][RX-C]   8.00-9.00   sec   107 MBytes   895 Mbits/sec
[  5][TX-C]   9.00-10.00  sec   111 MBytes   932 Mbits/sec    0    526 KByt=
es
[  7][RX-C]   9.00-10.00  sec   107 MBytes   895 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec  1.08 GBytes   928 Mbits/sec    0           =
=20
sender
[  5][TX-C]   0.00-10.00  sec  1.08 GBytes   925 Mbits/sec                =
=20
receiver
[  7][RX-C]   0.00-10.00  sec  1.04 GBytes   895 Mbits/sec    0           =
=20
sender
[  7][RX-C]   0.00-10.00  sec  1.04 GBytes   894 Mbits/sec                =
=20
receiver

WITH napi_defer_hard_irqs=3D1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
Connecting to host leporello, port 5201
[  5] local 2001:a61:11db:401:95c6:dca7:5be7:e7f0 port 50504 connected to
2001:a61:11db:401:f969:3328:8a89:ebd2 port 5201
[  7] local 2001:a61:11db:401:95c6:dca7:5be7:e7f0 port 50514 connected to
2001:a61:11db:401:f969:3328:8a89:ebd2 port 5201
[ ID][Role] Interval           Transfer     Bitrate         Retr  Cwnd
[  5][TX-C]   0.00-1.00   sec  36.8 MBytes   308 Mbits/sec    0    989 KByt=
es
[  7][RX-C]   0.00-1.00   sec  12.0 MBytes   101 Mbits/sec
[  5][TX-C]   1.00-2.00   sec  34.6 MBytes   290 Mbits/sec    0    989 KByt=
es
[  7][RX-C]   1.00-2.00   sec  12.6 MBytes   106 Mbits/sec
[  5][TX-C]   2.00-3.00   sec  33.1 MBytes   278 Mbits/sec    0    989 KByt=
es
[  7][RX-C]   2.00-3.00   sec  12.0 MBytes   101 Mbits/sec
[  5][TX-C]   3.00-4.00   sec  36.1 MBytes   303 Mbits/sec    0    989 KByt=
es
[  7][RX-C]   3.00-4.00   sec  12.5 MBytes   105 Mbits/sec
[  5][TX-C]   4.00-5.00   sec  34.6 MBytes   290 Mbits/sec    0    989 KByt=
es
[  7][RX-C]   4.00-5.00   sec  12.1 MBytes   102 Mbits/sec
[  5][TX-C]   5.00-6.00   sec  34.6 MBytes   290 Mbits/sec    0    989 KByt=
es
[  7][RX-C]   5.00-6.00   sec  12.1 MBytes   102 Mbits/sec
[  5][TX-C]   6.00-7.00   sec  34.6 MBytes   290 Mbits/sec    0    989 KByt=
es
[  7][RX-C]   6.00-7.00   sec  11.9 MBytes  99.6 Mbits/sec
[  5][TX-C]   7.00-8.00   sec  34.8 MBytes   292 Mbits/sec    0    989 KByt=
es
[  7][RX-C]   7.00-8.00   sec  12.0 MBytes   101 Mbits/sec
[  5][TX-C]   8.00-9.00   sec  34.6 MBytes   290 Mbits/sec    0    989 KByt=
es
[  7][RX-C]   8.00-9.00   sec  11.9 MBytes  99.6 Mbits/sec
[  5][TX-C]   9.00-10.00  sec  33.6 MBytes   282 Mbits/sec    0    989 KByt=
es
[  7][RX-C]   9.00-10.00  sec  12.0 MBytes   101 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec   348 MBytes   291 Mbits/sec    0           =
=20
sender
[  5][TX-C]   0.00-10.01  sec   345 MBytes   289 Mbits/sec                =
=20
receiver
[  7][RX-C]   0.00-10.00  sec   122 MBytes   103 Mbits/sec    0           =
=20
sender
[  7][RX-C]   0.00-10.01  sec   121 MBytes   102 Mbits/sec                =
=20
receiver

BTW the problematic machine is called leporello and it was the iperf _serve=
r_ in
all cases. The terminology in the iperf output is from the perspective of t=
he
client machine. So leporello's transmit performance suffers almost 9-fold w=
ith
interrupt coalescing (the drop I had been measuring with my GUI tests), whi=
le
its receive performance "only" drops 3-fold.

Regarding ASPM I've now tried all possible settings in my BIOS. I can still=
 not
make the warning go away. The above measurements are with ASPM disabled in =
my
BIOS.

Regards
Felix


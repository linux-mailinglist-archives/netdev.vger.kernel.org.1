Return-Path: <netdev+bounces-195564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EDDAD1315
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 17:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1558816896C
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E033516DEB3;
	Sun,  8 Jun 2025 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="qFBaxcwr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38F417A586
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749397791; cv=none; b=HY6a/JrR3lllcQAWE8apkp+OzTGJDH3GbVjBjDCqjaYsFMzWLyJCCZd+HPN0BdO3wYU+2Dw1ruaSbg33vVK6QbU+v9M4asA1mkALBP3TZgInKejWMsqCLWmp+QlGi/1K9Q3xwufIHxbgjHPSGqFPwKCUY+FcwrkWhM1U8FCSq2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749397791; c=relaxed/simple;
	bh=MKsTM1+C9QeCGD0Pjs9eZErUYlC1Pyuc2805DCEa5Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3woXKY4Ymxrhq2C/s1PcC2RRjm9DteaSeoCvXiBDc0Dz1A51bifBLXadcuYBjRkhcGumG5cDW7u0XlGoIqX79ihvqSZa0Ok/zmbi3LJKZ6d5vFe8xWEiT2x6pKCdbjZ3Fyg2+W0sWW0w530p0qUNxV4woHdG6HZYlVpkFmeLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=qFBaxcwr; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d20451c016so195534685a.1
        for <netdev@vger.kernel.org>; Sun, 08 Jun 2025 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749397789; x=1750002589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15SfyzB2KZkvwixg00o+49m0a1+RaFWhfwNSGqXDKgg=;
        b=qFBaxcwrGwx3aC4keLcL1yxTx9LInLVOMMYK5CmMizK9qjXY9C3o221FK2DC9cBFJa
         i0FJjBgYkCxNKBw4qQbWmAchJ61jl1pcxmPUUsX8+OTonLcqH7Ks1JbO1WhqS+rMjngn
         1Qhk0GRZP7Q6iIuPhV5yJjrDsGr4YqymemcP3H4k29FfwbPeOBXb3yt/TODOB3AOg8yN
         I8SROv+PIBKd1ereY3L7onL+lQTPsdITHJO1U83Xh03NzOm60f4o0wzJB48vj8QjCQee
         9gUeBu3fZTO9qNY7T0nZVgpdu6LlRskPWtMDKEfRk4YhzG3rSgakJSMbRDf6BlG+UJlk
         0S0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749397789; x=1750002589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15SfyzB2KZkvwixg00o+49m0a1+RaFWhfwNSGqXDKgg=;
        b=QE1aW4GYbO56fI/OkUMY16/VbbpnY5r7PLFrcDla9me8WUitPrZO5YBo3q82sAShwA
         Zp/gUIMud7fYspCVIcGfYoO6y0IeDm+E5xmTEVqtESAvBgt4YVicHX4s4/BxEXHo0E9+
         6dl6XisGMM3g2JADkCjoCbWtNGghAtO0EQRDNLkdR7A8bBRrmIuNzcxQfsL1Jpg0VTiM
         750zxfsb8H/EmIgnoNDXZ63s7N0JMrJ3CaBJ0AW2H6b4Eyg1Nh92wAQVK5SlbKmoIsW7
         EfVYs6/d+uzDj/AiUjQB9T1H5oaLqLrfoElKbwY/Q8uTHsD4p4fyJVk2cNwEjLXlxpPw
         nP0g==
X-Forwarded-Encrypted: i=1; AJvYcCWxsV8o3HvyYWIAdJ/MMj/8VLDBzSyMkw4o4A6wA0YG6Bdikwq04ZYeVjlfqJSntmlfSq8IyVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxuega+xz52DlqUEO62zBbtmMQNIImCXNgEf9eyvT1iqumOnqW
	UKaBmCL9A9oMR4ynzwTgPoS5RmBbhAGh8SIUIFJECx2DdwGhZ+zzfLptNvELe+mAAko=
X-Gm-Gg: ASbGncszz4wRVKPSg4FNVE8GFxrUOQ62tdLzi+J/+t0N03Ac/FmeLUDB9M8lyD5Vbgl
	w0XEkxkkZCY1UcBBT93zEuVRWVRv9C8STLuDvjUuZngChkEs7xoSuTMcR7aHGQTza4tVeC20y61
	EwwZ4JYBOyJUqmfQqSK9Z4sorWXN1o9JWYxmW0B8+97TF3tzpURA8EztaMDDGr/sr1wD9uD/+R7
	Xils+eBkBEnGM2u+h1UDLcdFOCTn4y4DGKXQHIgxPNToU+2CpTSg0mDjfBI9atbRGb/0aVAKjK2
	VFShgNR6r84fumGrWOMh7YJ5NZbFC2c1GscOa6x+Bh7ZFBN6DGleFh3QN5OwsIUx5K205lUuOBn
	lXhgRs0kkrE0RekmOmgxD4PdgQVdmSiQ1XMzi+Bg=
X-Google-Smtp-Source: AGHT+IFMItTRkpFBvAJi4PVEEUt3/gJfRAjUZYN3c1UYEfhEKFgqVle4xRdj02wbVxFz+gkYB1ZUlw==
X-Received: by 2002:a05:620a:9163:b0:7d3:8df7:af6e with SMTP id af79cd13be357-7d38df7ba37mr494433985a.32.1749397788793;
        Sun, 08 Jun 2025 08:49:48 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a61b5fesm425460185a.93.2025.06.08.08.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 08:49:48 -0700 (PDT)
Date: Sun, 8 Jun 2025 08:49:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: moyuanhao3676@163.com
Cc: edumazet@google.com, kuniyu@amazon.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] net: core: fix UNIX-STREAM alignment in
 /proc/net/protocols
Message-ID: <20250608084945.0342a4f1@hermes.local>
In-Reply-To: <20250608144652.27079-1-moyuanhao3676@163.com>
References: <20250608144652.27079-1-moyuanhao3676@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  8 Jun 2025 22:46:52 +0800
moyuanhao3676@163.com wrote:

> From: MoYuanhao <moyuanhao3676@163.com>
>=20
> Widen protocol name column from %-9s to %-11s to properly display
> UNIX-STREAM and keep table alignment.
>=20
> before modification=EF=BC=9A
> console:/ # cat /proc/net/protocols
> protocol  size sockets  memory press maxhdr  slab module     cl co di ac =
io in de sh ss gs se re sp bi br ha uh gp em
> PPPOL2TP   920      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> HIDP       808      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> BNEP       808      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> RFCOMM     840      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> KEY        864      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> PACKET    1536      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> PINGv6    1184      0      -1   NI       0   yes  kernel      y  y  y  n =
 n  y  n  n  y  y  y  y  n  y  y  y  y  y  n
> RAWv6     1184      0      -1   NI       0   yes  kernel      y  y  y  n =
 y  y  y  n  y  y  y  y  n  y  y  y  y  n  n
> UDPLITEv6 1344      0       0   NI       0   yes  kernel      y  y  y  n =
 y  y  y  n  y  y  y  y  n  n  n  y  y  y  n
> UDPv6     1344      0       0   NI       0   yes  kernel      y  y  y  n =
 y  y  y  n  y  y  y  y  n  n  n  y  y  y  n
> TCPv6     2352      0       0   no     320   yes  kernel      y  y  y  y =
 y  y  y  y  y  y  y  y  y  n  y  y  y  y  y
> PPTP       920      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> PPPOE      920      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> UNIX-STREAM 1024     29      -1   NI       0   yes  kernel      y  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  y  n  n
> UNIX      1024    193      -1   NI       0   yes  kernel      y  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> UDP-Lite  1152      0       0   NI       0   yes  kernel      y  y  y  n =
 y  y  y  n  y  y  y  y  y  n  n  y  y  y  n
> PING       976      0      -1   NI       0   yes  kernel      y  y  y  n =
 n  y  n  n  y  y  y  y  n  y  y  y  y  y  n
> RAW        984      0      -1   NI       0   yes  kernel      y  y  y  n =
 y  y  y  n  y  y  y  y  n  y  y  y  y  n  n
> UDP       1152      0       0   NI       0   yes  kernel      y  y  y  n =
 y  y  y  n  y  y  y  y  y  n  n  y  y  y  n
> TCP       2192      0       0   no     320   yes  kernel      y  y  y  y =
 y  y  y  y  y  y  y  y  y  n  y  y  y  y  y
> SCO        848      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> L2CAP      824      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> HCI        888      0      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> NETLINK   1104     18      -1   NI       0   no   kernel      n  n  n  n =
 n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
>=20
> after modification:
> console:/ # cat /proc/net/protocols
> protocol    size sockets  memory press maxhdr  slab module     cl co di a=
c io in de sh ss gs se re sp bi br ha uh gp em
> PPPOL2TP     920      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> HIDP         808      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> BNEP         808      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> RFCOMM       840      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> KEY          864      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> PACKET      1536      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> PINGv6      1184      0      -1   NI       0   yes  kernel      y  y  y  =
n  n  y  n  n  y  y  y  y  n  y  y  y  y  y  n
> RAWv6       1184      0      -1   NI       0   yes  kernel      y  y  y  =
n  y  y  y  n  y  y  y  y  n  y  y  y  y  n  n
> UDPLITEv6   1344      0       0   NI       0   yes  kernel      y  y  y  =
n  y  y  y  n  y  y  y  y  n  n  n  y  y  y  n
> UDPv6       1344      0       0   NI       0   yes  kernel      y  y  y  =
n  y  y  y  n  y  y  y  y  n  n  n  y  y  y  n
> TCPv6       2352      0       0   no     320   yes  kernel      y  y  y  =
y  y  y  y  y  y  y  y  y  y  n  y  y  y  y  y
> PPTP         920      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> PPPOE        920      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> UNIX-STREAM 1024     29      -1   NI       0   yes  kernel      y  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  y  n  n
> UNIX        1024    193      -1   NI       0   yes  kernel      y  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> UDP-Lite    1152      0       0   NI       0   yes  kernel      y  y  y  =
n  y  y  y  n  y  y  y  y  y  n  n  y  y  y  n
> PING         976      0      -1   NI       0   yes  kernel      y  y  y  =
n  n  y  n  n  y  y  y  y  n  y  y  y  y  y  n
> RAW          984      0      -1   NI       0   yes  kernel      y  y  y  =
n  y  y  y  n  y  y  y  y  n  y  y  y  y  n  n
> UDP         1152      0       0   NI       0   yes  kernel      y  y  y  =
n  y  y  y  n  y  y  y  y  y  n  n  y  y  y  n
> TCP         2192      0       0   no     320   yes  kernel      y  y  y  =
y  y  y  y  y  y  y  y  y  y  n  y  y  y  y  y
> SCO          848      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> L2CAP        824      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> HCI          888      0      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
> NETLINK     1104     18      -1   NI       0   no   kernel      n  n  n  =
n  n  n  n  n  n  n  n  n  n  n  n  n  n  n  n
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: MoYuanhao <moyuanhao3676@163.com>
> ---

This could break existing applications. Changing the format of /proc output
is an ABI change.


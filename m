Return-Path: <netdev+bounces-86856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBAF8A07CC
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 07:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279602838DF
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 05:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6341913C9D0;
	Thu, 11 Apr 2024 05:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="UVEA5coY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B815713C9B9
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813794; cv=none; b=E2KtXhMeXLRdyk1wob8T9ypK4YJjp81KiRdGtbZAEVHrSs72hTBhI0KZYU9u3ZfMpUHz0dMUXnHftXsPi48qEZ4n1oJ/YgDyLD0cIHrF97avaf0ee4T2SDoNg/1d6Ijo/gYPzy2HzibxP200Td7kO/rZJvaXzh5EN4+gjIkZPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813794; c=relaxed/simple;
	bh=9Pa5OXbNJf9HL7UJhH3JcFa5n8z2BXnqXldXUMG2phA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ti4czfckIipLfqa41dJ7BG9xAhlvtBBZ8Lk3ZU9Ox5T/bpNcrb70NuTxwByyZ2uICA1heKs8ANNQY5WUoVfJRtAaLbWPtxl5+Y4YqfmxfpVGtgpVkWZo42BDKx0XPSGKSeKBccKfX2I9SGDKiTDYmJYBDcrgzN2evRjc4gLqhdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=UVEA5coY; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78d61a716ddso314178385a.3
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 22:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712813790; x=1713418590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5O5BYI4OdHldRtjTHclfiNrTCLX6On9bTqWbaBCK7vA=;
        b=UVEA5coYYeRS8uJ/hQdFaOIXudpCoLobLBTccakXm0Jyi/CMcxJbV87hXhB+g288IO
         nO1t0+AtE6NoMd7ULm8mDKJPUBZXvqwSqAoQhKL49YJ9qNJ4iS8UYX90YNH8RmLsGeG9
         uiduuU9TNk/JEWgebJZFhmsYyXGobYyK7TynOxqkYXy0GmkTSIAzf4twCCQMTp7ewm1O
         bGTSinl2jts3Rpw1r3D+9y29/a/mqzNqcj3eq+vdswTpfffeJc109bJRVnY2QqD+F99H
         DGRDReEpKwQCihIaGfXHOjVN90Z7epVBaScEyer1BXHuG5fEAoTgpxjsASGC565C+eNb
         EVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712813790; x=1713418590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5O5BYI4OdHldRtjTHclfiNrTCLX6On9bTqWbaBCK7vA=;
        b=xUiy+so+jcVu7W1yeGmkAgRq7Rt2MhPDXTI9yh6FPHOi8CIUc25ea8n89uNTnh0h3M
         LjE5DObD5nzHteb3TeFdy+mFJAtAkIMNoWmpiE4UTV/q9RZ31iXzDw3Tiyosy1/UpUvm
         bAltC89dpCUn/9DcB23VSjtw2CwiBEx2D3BkBBxLOLMLTDocZbWmi6iWECTxqRywmg1c
         yUndRKLilE5vd9kx17kk4c3hU5w3XeyXsCJnAPmBvV1IuSFvZtU5Rkhmrfln7gnXJBsf
         9OilaIEl4zpmtoy4TIVXUpyXvKgi98FEy+pQPC7BwqayhC7yN/xosW3Wa3C/NNVTgPgE
         Ro6A==
X-Forwarded-Encrypted: i=1; AJvYcCVfK6F3vYVaW2LF0U02i3xumEZpfKmbdmPdm85GJydtGOWqbbZ/nPqNkjFkF0yE6zjiFVqacPoFCualA7ex6UfRrdNbU3fa
X-Gm-Message-State: AOJu0YyoOVwhHVjTL+vZ52lLlyYpK9m6JWpTRLx6YYwN1auBwpDI3Z+y
	LPlIc/Ix4sw1Hz3xcVSUaK814zScwf7l4nAtgwG252mzPyf9B3B3ruhyN7e1lRO3EbO/IZ15GnZ
	9+P5cF6REkptJjoavjclEZbzM4YLmfPGUjPfY2A==
X-Google-Smtp-Source: AGHT+IHXub++9CumsI9Ywnl2w4/5t7+EuZITPbvJVWOGFVEzJbCVmljtvqkv2l8ii4JKL3C+bb02heSSmwmSGs85R3Q=
X-Received: by 2002:a05:622a:130f:b0:436:5951:6005 with SMTP id
 v15-20020a05622a130f00b0043659516005mr1527116qtk.22.1712813790711; Wed, 10
 Apr 2024 22:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411051124.386817-1-yuri.benditovich@daynix.com> <20240411051124.386817-2-yuri.benditovich@daynix.com>
In-Reply-To: <20240411051124.386817-2-yuri.benditovich@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 11 Apr 2024 08:36:19 +0300
Message-ID: <CAOEp5OdiSW9ddv53JQHY57fCTwGc3eq-uWstSGcYFsMaW-FtOw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net: change maximum number of UDP segments to 128
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, yan@daynix.com, andrew@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've just fixed the 'Fixed:' line and extended the commit message.
We can continue the discussion in the previous email thread or move it here=
.

On Thu, Apr 11, 2024 at 8:11=E2=80=AFAM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> The commit fc8b2a619469
> ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
> adds check of potential number of UDP segments vs
> UDP_MAX_SEGMENTS in linux/virtio_net.h.
> After this change certification test of USO guest-to-guest
> transmit on Windows driver for virtio-net device fails,
> for example with packet size of ~64K and mss of 536 bytes.
> In general the USO should not be more restrictive than TSO.
> Indeed, in case of unreasonably small mss a lot of segments
> can cause queue overflow and packet loss on the destination.
> Limit of 128 segments is good for any practical purpose,
> with minimal meaningful mss of 536 the maximal UDP packet will
> be divided to ~120 segments.
> The number of segments for UDP packets is validated vs
> UDP_MAX_SEGMENTS also in udp.c (v4,v6), this does not affect
> quest-to-guest path but does affect packets sent to host, for
> example.
> It is important to mention that UDP_MAX_SEGMENTS is kernel-only
> define and not available to user mode socket applications.
> In order to request MSS smaller than MTU the applications
> just uses setsockopt with SOL_UDP and UDP_SEGMENT and there is
> no limitations on socket API level.
>
> Fixes: fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validati=
on")
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/linux/udp.h                  | 2 +-
>  tools/testing/selftests/net/udpgso.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/udp.h b/include/linux/udp.h
> index 3748e82b627b..7e75ccdf25fe 100644
> --- a/include/linux/udp.h
> +++ b/include/linux/udp.h
> @@ -108,7 +108,7 @@ struct udp_sock {
>  #define udp_assign_bit(nr, sk, val)            \
>         assign_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags, val)
>
> -#define UDP_MAX_SEGMENTS       (1 << 6UL)
> +#define UDP_MAX_SEGMENTS       (1 << 7UL)
>
>  #define udp_sk(ptr) container_of_const(ptr, struct udp_sock, inet.sk)
>
> diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftes=
ts/net/udpgso.c
> index 1d975bf52af3..85b3baa3f7f3 100644
> --- a/tools/testing/selftests/net/udpgso.c
> +++ b/tools/testing/selftests/net/udpgso.c
> @@ -34,7 +34,7 @@
>  #endif
>
>  #ifndef UDP_MAX_SEGMENTS
> -#define UDP_MAX_SEGMENTS       (1 << 6UL)
> +#define UDP_MAX_SEGMENTS       (1 << 7UL)
>  #endif
>
>  #define CONST_MTU_TEST 1500
> --
> 2.40.1
>


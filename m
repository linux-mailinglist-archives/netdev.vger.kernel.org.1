Return-Path: <netdev+bounces-68577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8239984746D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20FE81F2F2B9
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E67D14690E;
	Fri,  2 Feb 2024 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ew+4bmOU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3082146916
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890457; cv=none; b=ZsANDoMihCQuW/Fpk/9K4uDcxxY/ZEPf4pHjg/xknebX2Yu/f+0BQ+nE4FFa89Zt7wyqQC37DkVaINMeTa17ILFx9TVU21CBTZOLh0SpsYHK+tP72ecBbGnLFGmeqjakgsuIAlcnO5xkXRLPXtDgLhFJWnaewP9QFNp++qqcY4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890457; c=relaxed/simple;
	bh=Ri3/hQOGxa7fvdX6zXfOFaMYOWypSsO0kQTSZQ0812I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCVq5Pz+d0uH1kwsZGd3Rdnp7e2TVcU5SsOEzB1ihr3bjeX53exgWZPnO3xBRLWJXQKK3B4Nudo7y6eKUfOkL8+UP9vnEepAI+Fa5s18p47mCFByTmPmRhpC/QzQXTKHY46sLzBg4rnRHJonm8aJvVRH67iQz7+hoVS/9mQb6ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ew+4bmOU; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55fff7a874fso7979a12.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 08:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706890454; x=1707495254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6KbT4kBuivO+GxSvi+LQfZT8tk8UxIY20bJMtmOgR8=;
        b=Ew+4bmOU0+dtkH6cavqekcnL5mcUzN1QIhwR9IAlwk55q2CHxzSL6gOjv5nh66uHmc
         ZQ+/8wqs03GqR+M7oD3PZNrhrLsYOOJjkt+QLmf4dNimEVTFtYI0Am/dRa5Y6rGrQ9KS
         1R4soacIaWpiVk+AG4W3fX4YoK7Pc/Snd0puHKE4W878PF6mFz+gBUqz5gu5r8X0JhRY
         +5Y5GJV/0bqu/JGmgqSNPfuYXAQcyqWyoq9uPqPUOX9y1xpbMpkagIbCYTtu3+J+VXzb
         X1PJQC72DW+OGAJeCHV+b5RZXx2/vvbIhu4V3Rz9ZcYesaQBXJ9nWzv8Wr4jaAx0n3Z3
         vjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706890454; x=1707495254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6KbT4kBuivO+GxSvi+LQfZT8tk8UxIY20bJMtmOgR8=;
        b=fy8zm3o98UvpCCOE5W8bre3RsqVNgcAtAEbsRxO+fD5b+fAu/M2y5ibR3xCyd8NZzu
         SAOSU59aUkUSdrUyeTLNjAhcyUULnJSINbPMpnLYbOrJRGY0ivEVwqkfhekkECot03M6
         Rlk0hCZsaHbh9ohaALtq1B2buFwNISQBSQrpcBpq2h6H6uUW+NZQvRDhBTo9+DHCXqLE
         4X6dXReeOIHHwlSU+AZaUjrFE7t7PU1y+wypNYoLPMlLYi1U9QS/LT6oySx/DHUkLGOZ
         RkBHxAbM9Hv1tl4WxNycXNiTo1O9TfwuVoLY88eLAP5bUAtl8yD0BfBTH9PFlv879STa
         f84A==
X-Gm-Message-State: AOJu0YyIt4WzO0aFREqegDq8+P8CEhsyCnzAMkVt3bNxCmHXQTeT1Edn
	4llamBxroSaI4P/VtcLvixgt/S4AfNURXQZCxDt/DFVnSHU/hG7tfB4p2GmSNabt9/SnT7B3a2b
	Jn21qWSf6wsEeEFVh3/q3pn8u/NxsVEddpXDN
X-Google-Smtp-Source: AGHT+IGoWJsfhic7qRq3Vkd/uQY7ncJaEl4oQRFpZ6VVQ+6xH8r5zNwrHxEHwrY4VVtCqnRYr0wWw05OQfRx3tGtzzg=
X-Received: by 2002:a50:ccda:0:b0:55f:98d7:877c with SMTP id
 b26-20020a50ccda000000b0055f98d7877cmr30140edj.5.1706890452766; Fri, 02 Feb
 2024 08:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f011968fee563eeaaa82bf94e760e9f612eee356.1706889875.git.pabeni@redhat.com>
In-Reply-To: <f011968fee563eeaaa82bf94e760e9f612eee356.1706889875.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Feb 2024 17:13:59 +0100
Message-ID: <CANn89iJ8b-vXhH0Rc5isVTaxgSQ871mud+ttQnLOLtuCu14UXg@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: let big_tcp test cope with slow env
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Xin Long <lucien.xin@gmail.com>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:07=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> In very slow environments, most big TCP cases including
> segmentation and reassembly of big TCP packets have a good
> chance to fail: by default the TCP client uses write size
> well below 64K. If the host is low enough autocorking is
> unable to build real big TCP packets.
>
> Address the issue using much larger write operations.
>
> Note that is hard to observe the issue without an extremely
> slow and/or overloaded environment; reduce the TCP transfer
> time to allow for much easier/faster reproducibility.
>
> Fixes: 6bb382bcf742 ("selftests: add a selftest for big tcp")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  tools/testing/selftests/net/big_tcp.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/big_tcp.sh b/tools/testing/selft=
ests/net/big_tcp.sh
> index cde9a91c4797..2db9d15cd45f 100755
> --- a/tools/testing/selftests/net/big_tcp.sh
> +++ b/tools/testing/selftests/net/big_tcp.sh
> @@ -122,7 +122,9 @@ do_netperf() {
>         local netns=3D$1
>
>         [ "$NF" =3D "6" ] && serip=3D$SERVER_IP6
> -       ip net exec $netns netperf -$NF -t TCP_STREAM -H $serip 2>&1 >/de=
v/null
> +
> +       # use large write to be sure to generate big tcp packets
> +       ip net exec $netns netperf -$NF -t TCP_STREAM -l 1 -H $serip -- -=
m 262144 2>&1 >/dev/null
>  }

Interesting.

I think we set tcp_wmem[1] to 262144 in our hosts. I think netperf
default depends on tcp_wmem[1]

Reviewed-by: Eric Dumazet <edumazet@google.com>


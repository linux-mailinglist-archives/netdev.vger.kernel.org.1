Return-Path: <netdev+bounces-250897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BE3D3977F
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 16:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA0473002523
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 15:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819BC3346AC;
	Sun, 18 Jan 2026 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wDxtI9r0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32ED31B110
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768750736; cv=none; b=TFF7E/3O5b+nkD200oausBiEPc2kCCGmQXjIIXsB0qTjqYXSqqL32Iulg2DEhdlb3DuUYWdbkJboFvs/JfuRw3gJKZ/RV9wh2anfkNHz4qDJxa+ab9BW880GZa5AqvODGHi3FL/CHwI/wZY6WKVxUB0dGGzVUzekkfgV9OHwBkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768750736; c=relaxed/simple;
	bh=0Uej8siTetp2YLvKaTM5RSla4++mF7x4i2p8I4tQn1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqtXGld4iMPr6Dfvly8pMu+YEqqsayyN39WN5XcZ+gQrehqZgs2jRS6CqHLc1IbvP/kxERM1iiQMO3psLKn/Fnd9YULCs0VjUxlSq9LG9ori+YC6sLSYPytPrlm177eYCoD0Em0pTm+Imsr1jaBDYsdlvbSvRXMny31pJ6EBmlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wDxtI9r0; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c5349ba802so336341485a.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 07:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768750734; x=1769355534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekBEaeQvrWnA6L1SYJMBA93Tf+NpCQm7MMEmfh561wc=;
        b=wDxtI9r09ZWa/UuKS4mWFceyXYXcgWuTwpoigAZUS3e+0V5Fd/CKLJV1Bd3VRaaBSo
         mQ2seHmdOD6daVWfEvLqSb4UUd2OXxWcqZnu81Bmm4zibxgtbehY5FJkZl9zkfuvd7B7
         Iqjm4eYnw9UMlYV+vjNRNF60tmI8e5MzsAv9tcRW18poqu4v8GXTBjWam9Sg74GxKxws
         Y4+bYaOKSk+alOFcseBrigLXudzxEoPQtwtRy9TDihZr0B3aHDrj7FtFVAQFC/Dba2G1
         ZIEAWSYUggvcmykLKzH4GdEgu69x0tuMa8ikDNSl/gxzUVgc4Lf1DYVTpkPVuOdcAC7d
         TYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768750734; x=1769355534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ekBEaeQvrWnA6L1SYJMBA93Tf+NpCQm7MMEmfh561wc=;
        b=elEXNEQTfCUhZ1IfLRK9dMx/vbOloB9MGRVeClR+kmnt2hkjZVeREPk+54j5hJWdsv
         JyU295jtW8NsbP+6WffYfG0Cs7U+s/6msU6yMy+yhiq1MoHtny0qx0IF1FP0nloiTtUW
         qvoWWUiQkdgYf0q8ReVDQYY5IhZRnr5wtUsijJ/5UgzbF0dKElqWiPGRotX2VWBNNOHr
         s05yebIsfG+ViRpNIG18DCYNKbhbxTVHQE75fwDPcKYSgLMtZ7O9nWWUcVCAu7ZJ7Uzj
         7z/jQU09UY4uICMIhbpkxeMFpbRBz/luqysydizFv2FGkBD06DZ51U9Cce/HH3KpPfe1
         Ic3g==
X-Forwarded-Encrypted: i=1; AJvYcCVxmdY01/m5HNUV7Hi5uBbKxZ03tW2tojdEzi0duzo4QZTmWGPm/TC0+breiMe7t/C8AiuK6R8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX3TBjNZrTzsiYKCK2sF2WUQo24Y3uh8ai4OAVGvNGybbsackC
	nru2YPco/IbewqKLymO6AC8nCFEP3DUl0utQrfXPphsdJoRlfIebmH3qOGx0XI3hciT2J2asW9L
	arW944Dsa/cW23DtBr4KjaXwxytiEyZoNdOR2D+69
X-Gm-Gg: AY/fxX7Kuhq6W+h6pSqu47KeQAP9qR7k8mV4cI4tWsnoY0+nz394yAmI1GxgPhXiyLv
	e7yvs6e25P93O0ZQ+Wm+Y5ammV++9pZSeKvJbCPGePb2MZNtaaI18h4+M7M60QBpl5stsquy66+
	0zgRiuFE9h6Qs8iMJZChJC5vynuMb0NzzOCBhFZLPz7BUT4V3/JGuczajBMNwnioDgn0VoXWnXN
	w6cHahiCP0JUVlE4QGGSsWbUzcFZjPJMHvY3wwgm7Fp19vFxpT5SbIkK1sthxlpRKiMeX8C
X-Received: by 2002:ac8:5e49:0:b0:501:b1d8:6376 with SMTP id
 d75a77b69052e-502a175951dmr127639741cf.76.1768750733402; Sun, 18 Jan 2026
 07:38:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118151450.776858-1-ap420073@gmail.com>
In-Reply-To: <20260118151450.776858-1-ap420073@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 18 Jan 2026 16:38:42 +0100
X-Gm-Features: AZwV_QhyLegESAi2BlCRxeQq4zvDdpzfT7LWa_O9LTFy9T7y82e2tFRcvSAOWas
Message-ID: <CANn89i+Zd2W_u665D=MExotaHtnnyqu8Z+LgfbDy2trmtqcAkw@mail.gmail.com>
Subject: Re: [PATCH net] selftests: net: amt: wait longer for connection
 before sending packets
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 4:15=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> There is a sleep 2 in send_mcast4() to wait for the connection to be
> established between the gateway and the relay.
>
> However, some tests fail because packets are sometimes sent before the
> connection is fully established.
>
> So, increase the waiting time to make the tests more reliable.
>
> Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>  tools/testing/selftests/net/amt.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests=
/net/amt.sh
> index 3ef209cacb8e..fe2497d9caff 100755
> --- a/tools/testing/selftests/net/amt.sh
> +++ b/tools/testing/selftests/net/amt.sh
> @@ -246,7 +246,7 @@ test_ipv6_forward()
>
>  send_mcast4()
>  {
> -       sleep 2
> +       sleep 5

1) Have you considered using wait_local_port_listen instead ?

2) What about send_mcast6() ?

>         ip netns exec "${SOURCE}" bash -c \
>                 'printf "%s %128s" 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000=
' &
>  }
> --
> 2.43.0
>


Return-Path: <netdev+bounces-233092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8C9C0C256
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 08:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FA33B920D
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 07:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F162E06EF;
	Mon, 27 Oct 2025 07:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghA9J1FL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC622DFF1D
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550464; cv=none; b=CE1NUymx3LVAcT1WPzUx6GivrXlJEl684BUUPkt/e6NrreATGY0Syl786KKYx4K8pVY+Z/LVYPWIiRyPSnF7ETJqqnRQpsFTZfCMh+JLXLq3pcyt31eNJgqdy4USp7jYqgS10wUw8eY85J+BfVJTV05M/lvsLJj5UhfvQHxDinQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550464; c=relaxed/simple;
	bh=VLS73N+k0m8pm2jfMn0bQ+AxVZEGfiR67VwsmEn/FAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7jKpCAjpu6qkef3NEX+PEOizMaOUTMlyQZsLxuPv88UOYIgV2OV021HbxRcGfct3hJ6tKm5gEwEOX1rMiFGwZ4nJtftODOLfQnQq5jNC8jH5n4uRTQUTzcpHg9GCYTsShF9BbTJRwWaRJE6BLX8nNHFQLxgD+o2o6sTH6Ag27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghA9J1FL; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-945a5a42f1eso45555739f.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 00:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761550460; x=1762155260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLRKSCpsYmwhIoBpLKvnpHRYxz12yXBw9ZjyLu+9T0M=;
        b=ghA9J1FLNNV2Q+/50p63l9mAdqufw01gfa6NrKcnhX65vJ6vOZWFGmbozP5wRgZ+gD
         JUydxddDjlg3SbvjZAw63IVdsfJ5T/tNapREXvJu60WRK9Xg5UixiTWa8Ui5uxr/1nkj
         AmmY5gF1JeSSz4UfiXtUeAI6P4CIgsYk87O4Osxu6V+qBlaGGiqq5MTb9IwYnRoP90ll
         6YCce6+/k1+hbtTPEIRFjPWKV8+OcrVBb/8vCgSNWI8PnA+DUcWRo7lJ46JDIw0DBGXi
         pAdtnIYbV0reH1R9hklIZy7K8jRTI1GTwbDSjstUqO0lolhg9HesAG3g0+fXo4Sd5m5Z
         /zWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761550460; x=1762155260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLRKSCpsYmwhIoBpLKvnpHRYxz12yXBw9ZjyLu+9T0M=;
        b=mjs8Gx9Vw+1gH28jTMFJUH/Y8bOGO88PBGpIYni4NYZlh5j0yUWe9aBDY39rLJbiPt
         W2d94vcFImeWzIKEVLe/+ZO9Xbw+QPFYy7geHqqqexbcWdFCSQNykGteHaXQ5Xl0Cn2U
         G0OqgBfMfxh0q7VFf/7TVjaww0tTzdqrsmE2lnlfAg2qWgj0rM2/BjeCXQfnB05UYabH
         FuiH8AwwGC93ckrBpJEG/EIUwn/DkOmrI1kaOleO5k2/8iqmXjNudTwfyNqiOmprwk3u
         U9EDtlfXtJWEkfd3Vw9QXRqjjSvjfHgYMsTQUmSn71SLMiB4bANNmWAicWDDzK4k9c1A
         QiVw==
X-Forwarded-Encrypted: i=1; AJvYcCUmc+co2WQJ2zcyh6/ve1PGV/jpfHYtHHKrwvF6LvAvcSh4FhqrtUJdaMt9K9qXBlpVrMRYyr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwO5DLA6zUqrQCEonavwQZT/fL79XIO54Afgz1ikOMejiGoG3
	HzriAy7hCoDQe5pg6ZQuIRjfnRdi5t/42/dswJQng61eC5CwaRWvUZCGXvmEAry3ijO875vrYm0
	vgbBDrGt5+GcJkji4himGHGpg9U/g3HE=
X-Gm-Gg: ASbGncs28h5Syvq63OzjL9EpByL6Fwk/kGJ4Ibk8EYYAesk2hDJfXApUZPfw8QaclRB
	UQRDPxTlDBJaKbGyu2i1pQWbxwNdSpCRCow5ZTjIXwmIIgoHurobYYRhgpL8IEUInPoVICdbBit
	1m2yPS+BbXSxek7K7dqD/N3shf4fdTdgkADaSdOi6QlxqkBlylmTDxQIFJzbvLvBwS+2JB0065E
	Qh0lUI5Hq8zKyISIQHRuJ6wUxzOPixWxEfH+AURBNdFHcD9w3OlHjbqmyU=
X-Google-Smtp-Source: AGHT+IE4yTFQB/Sz1Hvmf1eohFHURvb676RfwgjWsjq1mbVjiRUKXUxdP/I+N8rdBuajxo0qe5dILr2G07V8SzV/+rY=
X-Received: by 2002:a05:6e02:1c0c:b0:430:b787:1c7a with SMTP id
 e9e14a558f8ab-430c52b43b0mr510390015ab.17.1761550460332; Mon, 27 Oct 2025
 00:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027053156.34368-1-ankitkhushwaha.linux@gmail.com>
In-Reply-To: <20251027053156.34368-1-ankitkhushwaha.linux@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 27 Oct 2025 15:33:43 +0800
X-Gm-Features: AWmQ_bmSUZhPR6p4SLQBN6A4GJHnkpFAQUKFPm5PcXL0KgaMnnMufzd-em_1cRE
Message-ID: <CAL+tcoANtVUp=tFD=JgR34_TvmrKVr7zz8gZMgoTKNDnjCzLTg@mail.gmail.com>
Subject: Re: [PATCH v2] selftest: net: fix variable sized type issue not at
 the end of a struct
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Jason Xing <kernelxing@tencent.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 1:32=E2=80=AFPM Ankit Khushwaha
<ankitkhushwaha.linux@gmail.com> wrote:
>
> Some network selftests defined variable-sized types variable at the middl=
e
> of struct causing -Wgnu-variable-sized-type-not-at-end warning.
>
> warning:
> timestamping.c:285:18: warning: field 'cm' with variable sized type
> 'struct cmsghdr' not at the end of a struct or class is a GNU
> extension [-Wgnu-variable-sized-type-not-at-end]
>   285 |                 struct cmsghdr cm;
>       |                                ^
>
> ipsec.c:835:5: warning: field 'u' with variable sized type 'union
> (unnamed union at ipsec.c:831:3)' not at the end of a struct or class
> is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
>   835 |                 } u;
>       |                   ^
>
> This patch move these field at the end of struct to fix these warnings.
>
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
> ---
> Changelog:
> v2: https://lore.kernel.org/linux-kselftest/20251027050856.30270-1-ankitk=
hushwaha.linux@gmail.com/
> - fixed typos in the commit msg.
>
> ---
>  tools/testing/selftests/net/ipsec.c        | 2 +-
>  tools/testing/selftests/net/timestamping.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftest=
s/net/ipsec.c
> index 0ccf484b1d9d..36083c8f884f 100644
> --- a/tools/testing/selftests/net/ipsec.c
> +++ b/tools/testing/selftests/net/ipsec.c
> @@ -828,12 +828,12 @@ static int xfrm_state_pack_algo(struct nlmsghdr *nh=
, size_t req_sz,
>                 struct xfrm_desc *desc)
>  {
>         struct {
> +               char buf[XFRM_ALGO_KEY_BUF_SIZE];
>                 union {
>                         struct xfrm_algo        alg;
>                         struct xfrm_algo_aead   aead;
>                         struct xfrm_algo_auth   auth;
>                 } u;
> -               char buf[XFRM_ALGO_KEY_BUF_SIZE];
>         } alg =3D {};
>         size_t alen, elen, clen, aelen;
>         unsigned short type;
> diff --git a/tools/testing/selftests/net/timestamping.c b/tools/testing/s=
elftests/net/timestamping.c
> index 044bc0e9ed81..ad2be2143698 100644
> --- a/tools/testing/selftests/net/timestamping.c
> +++ b/tools/testing/selftests/net/timestamping.c
> @@ -282,8 +282,8 @@ static void recvpacket(int sock, int recvmsg_flags,
>         struct iovec entry;
>         struct sockaddr_in from_addr;
>         struct {
> -               struct cmsghdr cm;
>                 char control[512];
> +               struct cmsghdr cm;
>         } control;
>         int res;

For the timestamping part:

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason


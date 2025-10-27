Return-Path: <netdev+bounces-233281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 314B2C0FCB2
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68FA3B9A70
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885793161BC;
	Mon, 27 Oct 2025 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nk/yeswB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED42FD68B
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587516; cv=none; b=U1Fn8mbQl3dLZs+a2Wd3RMWOAHvrIvQu7jMMiwoCse7lxDUJveRppDjVT3QyGXQvG4loADWwO6Z4Ka2en5XfRyXibJjWWBraP2/AgY46qgyM4Eh0+z5Ws2EqLF6VqVt9GB9+7wrwIYsoGEcm/IyonIwfU/QbBQ+QISdAPOwDKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587516; c=relaxed/simple;
	bh=Pg2jiCsm7MjJMHV2SEC6hKWPL2RUsUBkTbRD1RGwq2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCUtVf6w3/AwsM2MRwrhD4fYTjrtlqVffg1MmGtce+Boh36/VbBtRRx91KWK8raR8owm1lr5jTpAkD+8skTtqWpngVYc30Rm84F7qPZBf4EceGRjtQkjumL/H/9DIcC85XFBTWZ4WcjmBn97OBtz6dYX4qSTsLk1yL6dTTb0Gg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nk/yeswB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-290a3a4c7ecso56164395ad.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761587514; x=1762192314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVq9+t2z/NnSc3zlKxkYc+qBrK62MLq4an44lN9h9dA=;
        b=nk/yeswBmTnxXounw3aPhlzYPwWh7NEIoJkopv4vycNcJ/xmOt2LFGfqLawqJHx2pA
         nFk3T80AS6XP0eqfEqzVk57olfM4/D0y4nWT8Tp3WweiKQ6MfigATYY+MaAzZSllnPbV
         iBoTOtYEChULfv21ZaKMzovhjvOUkDdk0l4wIbBiSgjfg+6mQSUBBSva1uUJnb1Fwbzk
         OqbK11U4H8zNZS5NVbenUxZq/8EPKVe943J7qwOu6Byr4zSF1PQeYKcZfpSxZVm/JrlI
         F9f0lWK/nXWxZzNUNKTWEGT5sSgkY0sa1K/jVgSthilLBxYE16yhbcFuFwi0XCNG8gWJ
         zk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761587514; x=1762192314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVq9+t2z/NnSc3zlKxkYc+qBrK62MLq4an44lN9h9dA=;
        b=YJeOah/HMdl2dylcPPQyC6sdWxEjmNSPwiIx4LT8wP8qXmWK90rgGJHerOqkJ8izCS
         /eXgIR88dMU5rXskDmAh7+zugrL2WWugDdSdITj6O+KGCmHFbezq40EuSwK9aDb3Bid5
         iXehQFx9okhMiIlBGWkgXxVf54fDI1Q1u0uOS9ebtIn0088i9EEiLnj6ar4oIUNw9Qfd
         YoiopVs0v33J2SiGdJFX3NS2PZyNbNC7f/887VahugCqGNB6skAR6k+5R5T/UQs7ExT3
         Z2TEMz5Q8AByPZi5Wu+a/xYdlfKAaRBi+C9pyBJzQWKOQi+/+AI+HJvjzYmhC6EINuPu
         RBUA==
X-Forwarded-Encrypted: i=1; AJvYcCXfok5cSWGNRquXPcNhrO8droW4D/3kIt7sa+pEtZNipPUzDRws7kvmJhmsTCYa5EBbgdiY3dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBd/h0tsKiLS7JwHXlw9iQzIBtmX1T6pV/ewbCsf7bIgxFXhIU
	hhUt7JmrW211t5nWbabvV6wtg7KskskAZLSSWAk1sBVqkZa5l+ZD7hJBpdrVmH9WtFxEk+M6fI8
	QcKUcPkHsdLlcd98cyIhVXPpnsASOksDCGoTXpEY3
X-Gm-Gg: ASbGnculzBh6gmHmMC6THniCKvvg/+j68zpPSdzRMrKpIo9dLxd2zJFl2DVe2dLbhl5
	yHH2CwG4GEhRT19grO650fMf1ZvOg8KOGUGBc9fpJ3lA2jiS5XR8GOQcXhJYmRpAnU7R9axkFYj
	LcNqI2/DsNpwQqQ22cUiJQru7KL9TSXl62P+Uv6QeRqeknl9E3hp040H9ZfVPlFWXgyOF+9XOYF
	wfkQADI0bFfoc4KoaIZIvzrHDWG3SxXU24wVw316BbjNWe5xKgRKZSWpX0q5ZG/C5njLhWVVo8D
	lEOaU7iMVIM8s8w=
X-Google-Smtp-Source: AGHT+IEgeUScsspPK8q8p9oorihY8OHMO9eGLp+b80KlldnZRcxNn7o3fr7kcpHMvGThxV1x5hS5JU0hjK137hWgArI=
X-Received: by 2002:a17:902:f681:b0:290:7803:9e8 with SMTP id
 d9443c01a7336-294cb5002d3mr8474465ad.48.1761587513938; Mon, 27 Oct 2025
 10:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027101328.2312025-2-stefan.wiehler@nokia.com>
In-Reply-To: <20251027101328.2312025-2-stefan.wiehler@nokia.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 27 Oct 2025 10:51:42 -0700
X-Gm-Features: AWmQ_bn9wyih5qWJDlxLaH23hKlmKl93Y9fku_GJoCm-usUlu6PJrInmbaQTXSk
Message-ID: <CAAVpQUAHHVUBQZ=fgCUe8Mg9CD6d=CutyEsE4m82TGdt+VqpNQ@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: Prevent TOCTOU out-of-bounds write
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the patch.

On Mon, Oct 27, 2025 at 3:16=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> Make sure not to exceed bounds in case the address list has grown
> between buffer allocation (time-of-check) and write (time-of-use).

Could you elaborate a bit more context here like which path
we don't hold lock_sock() as Xin confirmed in this thread ?

https://lore.kernel.org/netdev/CADvbK_ddE0oUPXijkFJbWF6tFTq5TntpFMzDWH+uV_k=
c+KB7VA@mail.gmail.com/

Also, it would be better to post the two patches as a series

git send-email --annotate --cover-letter --thread --no-chain-reply-to \
--subject-prefix "PATCH v3 net" \
--to ...


>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
> V1 -> V2: Add changelog and credit
> ---
>  net/sctp/diag.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index 996c2018f0e6..4ee44e0111ae 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
> @@ -85,6 +85,9 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff=
 *skb,
>                 memcpy(info, &laddr->a, sizeof(laddr->a));
>                 memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr=
->a));
>                 info +=3D addrlen;
> +
> +               if (!--addrcnt)
> +                       break;
>         }
>
>         return 0;
> --
> 2.51.0
>


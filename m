Return-Path: <netdev+bounces-233115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F338FC0C9CC
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 10:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4C0188A686
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4AB2D5957;
	Mon, 27 Oct 2025 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqHJYXQa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D42E7BCB
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556569; cv=none; b=LIprupvp19zW3nfnQ0cSl4dUzUmSF0ATTB57VIgLVNygG8eA41o5mQD8ON3H7dkzWnsgR6vCjGjhmr2GM+/RdNiy28bWNJ2U6ejM/IWLPSFQ2/Q0wfC2ncM4WYIT6BKbHGezZcx4B9Z7Tff3S/0nzCSXiQJC94SCEN3BlQO1W84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556569; c=relaxed/simple;
	bh=oN9S/ByE6z4oE1dK1xupBGPnFsMKYjqe/Wd1H2/tmxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3cZt+GxIHhgJV+7TolFsfNEpShNMjmsHq1Ou9uaG+X3mwWt2MGD4UIQmKeRR3TvvNsdXScxrNHuIDeJFEMqiHgZ8bKm1Tggj8qPu88zMUIpDcwTf6vKVCZX9Zb51uo2ghmOWx7CskZiAKspacYMYuuwimQs/nHf9z2GHCKW4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqHJYXQa; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-89ec3d9c773so460354185a.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 02:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761556566; x=1762161366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9M7flweXiGej+Q06p6wHFNjm3oIgkIVuhJ5x8DaGW0s=;
        b=RqHJYXQa8BI0kdiRX5hfZ6cTTGLHHJnd8QRkhPsf1baR6dvrQqjYGn+LGLLouyE3R6
         a8cIYdCU1UVugipVqjn1cy6WfDBwxckNvOxCxGfirYr90y4YLWJWKZVSvYt0oLh9O6ep
         PyQJK7sBiJhyxDAZfq6r2V1XVvf6Qm8PMmj21WFpZaH1VQBJUWOAQJ8sxwWoF2PaVsPa
         DpU/nIoj035V1nlRYoXur9iwx/2IVsAXEfDgaOxEA+2/suiu8Sh+Mqbrufumb660jXT6
         4IPHASMImGwckrHpeKzfchWrBDiHCvlr1ZdlVwUrNVDiH9VVnfp/M+UiqZBBe91KsAi0
         DEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556566; x=1762161366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9M7flweXiGej+Q06p6wHFNjm3oIgkIVuhJ5x8DaGW0s=;
        b=h2oHkNvpD0yTH5w2+isqjRpk6Wxq/d9kBJrbZuRFYYpTHGxte9vmMs3EBacvqihisR
         snJfP/SVjFGfpRnnsWOSnLJSTQSp1XucmvXoyb1e8HuGVTYj38Sn86AplKqpQaoE5IdK
         KdW3PFT5esAQLTm0RIIh/XrGdCZbbyDynA65nFbkGedqzb8lPeBlUTDBVysHWauzMJHA
         683UFqE2wcn3GC5z9k4X+8YEMtLTzArhZ0Ez8t/OtzFN2rzJE2P1JYjC4FskTxVkCfBA
         osLEyb4WwNxYvpav3Z7pnQvNkAeV/yOdQf8qxCWQgN74RK4OJo+UUMf3fFAm4vhIdgUG
         vdqg==
X-Forwarded-Encrypted: i=1; AJvYcCV8j0kFemo0ZhYk88BN/uyb/QGMBLxpNFSLHV6iRAYwDWbgeDbABAXxwB3dAUjDtpkK2R34gLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaDbvTMZO/dId9UMwE2KzRTFsN+9lA4Cyu1PBuogOEYDf+kte+
	XIgs5WXhVVYt/vmHDpbhcO62DY+/DjQKbiY6QoH5kan48LrKHzQufkKDFoHG4jNLm7Afq24rcql
	Qu/DLxIqN0tUFUhB6Q3S600ZbYdEyCpI+kgAbJrOn
X-Gm-Gg: ASbGncsSVhs+Sv9NCPwgAtxdxoiSSbw9HcyKoREHkVQb6NxpiFD6WlgOt375hjgUeSn
	IlhNS33poQOkX0PmtC5Xi4DBBIKvh0ral8I3ZWoJX2tYzM/3apHJNf0eh+JqQmb9/Z9YtluhmQG
	y70Zs96xaFmPI04fX+sOvcRWNhdefn/07943UUlJzn1aYDHLufmF8muQjzaBc4J6B7U9gANC2d6
	PGqm/eqQhj7QINBXyTkYSVvzW6Lz5VioToe8ehONEXX9bKKVOw6wKtmEx9kDgz3SmstWIA=
X-Google-Smtp-Source: AGHT+IG0vxrk8P548hMiYXEr5yuQrLVzL4lCysrZOaHo4+AlkvkNAKs2QduZs+9ZwIJ4FPzozx2n/rIWJmZ0OVid1xI=
X-Received: by 2002:a05:620a:4005:b0:89e:6902:3e11 with SMTP id
 af79cd13be357-89e69024424mr914542685a.35.1761556565812; Mon, 27 Oct 2025
 02:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027084835.2257860-1-stefan.wiehler@nokia.com>
In-Reply-To: <20251027084835.2257860-1-stefan.wiehler@nokia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Oct 2025 02:15:54 -0700
X-Gm-Features: AWmQ_bmDUmU_tcEMhsKWxImXqueUJYr--H9ftZLY576HiZQiOI1zh4Y5ZwoSHbo
Message-ID: <CANn89iKSP6pCtn2vu8D=5-Y7LSxCtQA4s=qXjvHsMeOTstfbOQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: Prevent TOCTOU out-of-bounds write
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No changelog ?

Also no mention/credits of who diagnosed this issue ?

Please do not forget to give credits.


On Mon, Oct 27, 2025 at 1:49=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
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


Return-Path: <netdev+bounces-78730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93A187648A
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF5A281B25
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 12:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6A617BDC;
	Fri,  8 Mar 2024 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2hDUIKew"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC2817745
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902310; cv=none; b=uGddjmA4nrfgiOlHN9J5Ks2Gmtes3spTfadBRvHOoq24RI0B4KMP4vqrFi3Wzs/OTnJtFyZuXdAvIzxX8qJdMMkiPK9UQj4rKVQ+/RMOwuwN7AdIRKI178n2rBuv0+CFrI193fFSTVQxiSdDj35x4r7W5yzZhB78enLvx9VCHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902310; c=relaxed/simple;
	bh=LzJWnD345e/TSnWMXwsnCzIAp9EATcd2Az2CODBO2Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B83iSTvmiYbpGfrJm3nC1rniYSb7rOl4dFK/w9IcYpH+dvG547IH7X0ORsg/FZ+4Ng3exSBp6cl+Glvs4Q9AZWyeH/ldqJShaC8TR5exzMfSx7jl4/yYGbGF0nWQ6MNtYIvuoXXoXLNkhNiiPWdd+K33Bcn9MkkdOeyy+LtROb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2hDUIKew; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-568251882d7so15024a12.0
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 04:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709902307; x=1710507107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wFxcRKzixSphhwxyAsaZYfo58Ol0VCtNiJzKLN7/S0=;
        b=2hDUIKewzOt5U7URImpPeoMVhggbVjDS1Xd8vfls9FL5lDYODVhGev0UQb8KyQyIyE
         o/EC9FGU903LH/A5H02CQmEDOwn5PgpCLcNX2J9NNjr48ligbBH5BtzpxeKUexKq9Dgb
         A/KXFY1vP/gt2unlx6/+D2bVyh8wmvRVu++Dt9PVKr09wnzMG1dgmE3wbszCQcoAMjTX
         +aTsjniHwK/B6lot6h8zoXthmet25nz3OYVC6rIr1qwexUyY+PcjbJXmyh8D3mc5htTd
         5FrCUDsh4CiX9SaHUPdvL0SKuVmrRXoGs/Rlfmkt4XWxbgJOZDheuf08UA2RCBng988L
         793w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709902307; x=1710507107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wFxcRKzixSphhwxyAsaZYfo58Ol0VCtNiJzKLN7/S0=;
        b=lS2hY2k4C4G8zR6QTqJmqqI+Betl6gsuGVsQAb9T29IKWIcadAFj6uDcg7ozW83aQh
         rtDw5AYwtKhWOAwLFU0jefHcNw185e1GrZh7cwAtvDjN+LWpxCVe9KaYn2BXN43af4Hw
         2jhOZydZwDL1hBuFTeGBLdyZX9V+1ot93e4jEA8N9ZjTBI2XbXlm2HNZnC1u7jkVsyhE
         u0qpAQW7OhygjMDpmFnGlDsP6FrjYk4gfYfNtvgx+p8iNLAQ95TPfbAfimoNaGqOpT2L
         Sok2Ncz85TfMjTR/9WrA9fGikrenawGK5tx4gGLN5mrdVa5Dg6MUVBuhwJhe+4gyEiJ4
         RYaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2NglQQY2+a+jIWVw78YmIGGTesQrYVOGFvTlGb/fSAyLa8dQTCsm5e7Mh9/LaZf/5p5mmj2b+QMJLw2xr5HoY1PyI+0Nm
X-Gm-Message-State: AOJu0Yz8Wu+crwUEtwL5C+XCzYihiagAaokOeQgAYI2SsIto+PO2FoTR
	UrMpu9Yuz6h3DNwckNOlS7wMkW5hfdWHIWFVMBdiIpBAyjWRddbMiukHZ6WXQr5VLsb6lmpkc+M
	Zwffn4uBAfGNs4dAATTPC9FxWevhkir8aibN8
X-Google-Smtp-Source: AGHT+IEFIF41DVJKRfWSOGlQA5QraR0feuXtqNSe+bwfu8uemjBwZSGFloqujZg3mDGCaQoDzKpp08nVvDRu/6VHVe8=
X-Received: by 2002:a05:6402:349:b0:568:257a:482f with SMTP id
 r9-20020a056402034900b00568257a482fmr225008edw.3.1709902306583; Fri, 08 Mar
 2024 04:51:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308112504.29099-1-kerneljasonxing@gmail.com> <20240308112504.29099-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240308112504.29099-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Mar 2024 13:51:35 +0100
Message-ID: <CANn89iLtRYt6U+q_VHb_3Vj2ydmnwsSon4uwPX3+yTJDgoDenQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: annotate a data-race around sysctl_tcp_wmem[0]
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 12:25=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> When reading wmem[0], it could be changed concurrently without
> READ_ONCE() protection. So add one annotation here.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index c5b83875411a..e3904c006e63 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -975,7 +975,7 @@ int tcp_wmem_schedule(struct sock *sk, int copy)
>          * Use whatever is left in sk->sk_forward_alloc and tcp_wmem[0]
>          * to guarantee some progress.
>          */
> -       left =3D sock_net(sk)->ipv4.sysctl_tcp_wmem[0] - sk->sk_wmem_queu=
ed;
> +       left =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[0]) - sk->s=
k_wmem_queued;

SGTM, you could have split the long line...

Reviewed-by: Eric Dumazet <edumazet@google.com>


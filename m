Return-Path: <netdev+bounces-131837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC41F98FB37
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E52D1F21C54
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC891BFE01;
	Thu,  3 Oct 2024 23:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIbnLyaG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9134312C473
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 23:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999731; cv=none; b=u2aOtGm/Ci2KJ3JhzwEMU4iC5m9xlvooGhHRn5w0M4njErk875B81uDEPc5g/sjRrdv8S7j+wJIZLCCNOQaEPw2L+9VtcE5lQQAuziSWfiJtf0f281oWOduLxR/VuWy4N9SFX4Bh7p2tfRJ9AopUjyWLD2Gtwi1h8iVMY0vGwNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999731; c=relaxed/simple;
	bh=8a4Hhomq6ETEtlqLlgN2BfU6jWFvqIcSWEeRJQHfkO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZNJbE3LGyochlE4cMKGtGvE2f1DJIRpXHRAqg+XY6/moNBMtIClhifsp4ABSrPNtiF+E/b/Y4PDnm+KqFmy6+lUAHzE9qsdD1v3iaxEQEaS0LIVtO8vK2QfBBxPcyu30r23GSydNdrrtS3VgHBFbHIWGSK+2B187NY3mWCL0xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIbnLyaG; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4582b9bcac6so2252361cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 16:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727999728; x=1728604528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uK9qXPnaKOEnXOWTaRoR+RGEnIpc7VnuDkcKLte6EM=;
        b=eIbnLyaG0ol56ymVm9baIyQSeT543NYriIjxjSrToUGBoLXfS1QT9NPYdX3jciTF3c
         cfdB++ZY//gZyGV4Rxo4GRAajjHoOHVZ5Kzy5dCKQNazeBY16JjvaH55F15rCK3ifRSt
         Qb+90fXMrGw2uo5ZfcYrzAZGaqiSioYgamyq53rN2nvWSvb7WaFDYsqV5ZCg53qlUPD8
         QcDUzUDUPSObNAezGsucRWwy7Ga1vQE7jvXFTOlh0Ou1eU26vUhnKv4uZdcmZy5MANQc
         YDJHCWzMq7PRotRJ09Ihjy1dlSSQUnWbWRbSUR49iVoc5VLyc6xU1h6Om/OcShLjsOV8
         xI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999728; x=1728604528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uK9qXPnaKOEnXOWTaRoR+RGEnIpc7VnuDkcKLte6EM=;
        b=PgsJJTjSdL7T1aCVAN8XF9WvYC2W3Gl4N/nem5+DvNh0wnY0obCJiblj0yDPS2U235
         RvqLQx21FYc/KtkN3/4W5ei+s6eg+JyQGKPnlzp18mfmJN4zD916AUCKGeyuqHLZb8BA
         u5vcMrySKWgjCGQpa+oyoQukkc9/2SEf6BeWHQlS2CCgsy8oSox76yRut8PFPotzAZw7
         I0uJ33G7i4nGy4ijQV17hC5Hry6L+CbAZNTAh/mDd5QslHB4hkbJyryFn0dEMtM2U4Fh
         JPVbTleIpVJxsMbFLScKMTg7UuGgtS75amHc4NNDQuajLKbKTLm/0n208ImxRh+Y+UdQ
         yUWA==
X-Gm-Message-State: AOJu0YxP/Ayf4Dn73QOw1NzIEAtHPjPZ7CSLhwG6xqM34ISBDRDUwKrQ
	yqYOfOFUgdHPVNE2ah8I5xlLSRKo8Nw6bu6ZWrSYBjw6O/oOtUsoWI+cixvpPZ6sanVh0AxNa+J
	fp6ykET/LMLEW01qmTbPoFa0dIbBq
X-Google-Smtp-Source: AGHT+IGEY3DbZCwyB8l3z9RBUCW5GtnCV6suJf/asauXpFteTNocRp+nTwLIeN6UOzernNqa3sM7WgskAr0XvHuzymw=
X-Received: by 2002:a05:6214:5007:b0:6cb:6006:c98b with SMTP id
 6a1803df08f44-6cb9a2f5ba2mr8534866d6.5.1727999728296; Thu, 03 Oct 2024
 16:55:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1727999090-19845-1-git-send-email-guoxin0309@gmail.com>
In-Reply-To: <1727999090-19845-1-git-send-email-guoxin0309@gmail.com>
From: Xin Guo <guoxin0309@gmail.com>
Date: Fri, 4 Oct 2024 07:55:15 +0800
Message-ID: <CAMaK5_jYmVZ4qqOQAYPhHNzJxTEjHwqQe4eOkfR_KhHCRO-kgw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: remove unnecessary update for
 tp->write_seq in tcp_connect() Commit 783237e8daf13("net-tcp: Fast Open
 client - sending SYN-data") introduces tcp_connect_queue_skb() and it would
 overwrite tcp->write_seq, so it is no need to update tp->write_seq before
 invoking tcp_connect_queue_skb()
To: edumazet@google.com
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for this post, please ignore it,



On Fri, Oct 4, 2024 at 7:44=E2=80=AFAM xin.guo <guoxin0309@gmail.com> wrote=
:
>
> From: "xin.guo" <guoxin0309@gmail.com>
>
> Signed-off-by: xin.guo <guoxin0309@gmail.com>
> ---
>  net/ipv4/tcp_output.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 4fd746b..3265f34 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -4133,8 +4133,11 @@ int tcp_connect(struct sock *sk)
>         buff =3D tcp_stream_alloc_skb(sk, sk->sk_allocation, true);
>         if (unlikely(!buff))
>                 return -ENOBUFS;
> -
> -       tcp_init_nondata_skb(buff, tp->write_seq++, TCPHDR_SYN);
> +
> +        /*SYN eats a sequence byte, write_seq updated by
> +         *tcp_connect_queue_skb()
> +         */
> +       tcp_init_nondata_skb(buff, tp->write_seq, TCPHDR_SYN);
>         tcp_mstamp_refresh(tp);
>         tp->retrans_stamp =3D tcp_time_stamp_ts(tp);
>         tcp_connect_queue_skb(sk, buff);
> --
> 1.8.3.1
>


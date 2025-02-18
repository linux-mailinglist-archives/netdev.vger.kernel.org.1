Return-Path: <netdev+bounces-167344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8A3A39DE9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AFA3B56A8
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D592322B8B9;
	Tue, 18 Feb 2025 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MxNc6cMg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC438F91
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885773; cv=none; b=boChMIlRMztW6GMFkasjf+w3WeDtScDXxdl8429gCv/MqW2JvjEGVPYswd+Gsgrn6Cvk0GDC+eeP8hoWrjMCfMGlag6FxC8ZY6nU0O4hJnbxR74UlMeJgMjOS4lv8SFYL5k5wfdvcohGA/e6DqHuJWIFxKVHOGWi2N119l/x0wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885773; c=relaxed/simple;
	bh=1el1r1ku6nDEmYk1WaQqya0idTEm4g/kYnaOmrEaSns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oo4ZuuthD63QtoegMTal06VCDexSCEqJlAqHSWDf4lbNsqGSAwCFLbUkQqLYAaqmZToE1S2UVh+lMRzGvdv1ibmGVPDWLyTiLKWLSgvjtzgrrD2y2Bw7+5o5/jeiB8w+3i3/Pl8PxegAnA/1M4oYfdcVJos3numn0HTFQdkmneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MxNc6cMg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb81285d33so527107966b.0
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 05:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739885770; x=1740490570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OZcDt15QGW7oHl6wgsivz4nNFlZzuuT/h8x1d+aw7I=;
        b=MxNc6cMgeYuNqngBq0HfXorOV/5dvgC/ugWn8ciQv3DLCrcnS5OsdOTlY/y4Xibi87
         jq6M2wwnjTJewvut8vGCETrlb1ZGJLweTjUMQFPUs5MgLoL4s5H9tjukEufL9Czasmpa
         WAylT1DRFTzkqh2rJtdFxYAVhvG8jIhyKwOZCtAiSesXwDUr9+JxCUIWAUCGZfa2etaJ
         17vkyzS0MjWX5nvP8zI/mqD5oGBqsEa8C9MLHGAgzzFVvoZMqKT4UfwBHIkAPKNmR2+h
         6PE0FVFiUVwiRLsRetNfhDldZS5tViTsdXN0VGG5OnYSMjNMgaf/tRsJC55Jgb7GgpCA
         AxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739885770; x=1740490570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OZcDt15QGW7oHl6wgsivz4nNFlZzuuT/h8x1d+aw7I=;
        b=bqz7CC0WUByLKidWXgSS2r+AvoXLHouSAKfd6O3KXnMqkkMRDXT0jdRPs42tnjidvw
         tH2C/2G7SNnR+uLFG1TAQbgXaWSx882s+/PxvUTWsekdUwcjWZ+kFiBgY9hTozt2r334
         OkwKhgcHccGyah0HF0VV5Qgu/sdkjoLyxH4xQDUSvl/QXkb1vDZZBdwVyNrDWsR3JjuT
         TVqS3gTAhXpCMDID+sgAStxn5baePqVxudTXV4CDGJ4e56AjtKdTMc8bHedeG46EhSgh
         nc5NUsl6UqnfFHIFd8ElVyz/AqtA7GamUappw9H1asVlxf9owp31xJoNaKX70L0tO8wW
         gYow==
X-Forwarded-Encrypted: i=1; AJvYcCWmfsch2jxgjZzu5AWfpJ8xbGTcTmMKG+VlVbIVwfyg+MGiY/12YlRzsZZE9K7kxj9uNAhjEKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfulTZ2u0zHYmBaerjAZqgGoPrNBW9dbQrvbSo5qPY8HbdjyKh
	D884Fbq9H8zD91yqXh2rZNXJmeSOKgX7AGWB70w+CEpeQWq9VCxCerkpS6VeNQ/jV5EcF4WrZvA
	tGfW8ZkSFs5l5jxJBVNxsXAwPraBLtZUoXxy7
X-Gm-Gg: ASbGncu9TsMiH/zZWN3ZhJgWe/Dshz53Scmd3RxJ1hvOzB23b3KinLbagU5pI95lTWT
	g+HF62mR8o5mDQJMUU33kRJhqmkly7CHc49HHlzSAkr/+nxVsYNQxIZootwryqHMj1kYDd9TY
X-Google-Smtp-Source: AGHT+IGKadZ959xikteUpLo1xqvSnX/oHQ/2ndJ1UoV7NqvtX7mJ2Og8+iF4jhhUUhHozu8b3w04Kcq/C+xHLP8AV+w=
X-Received: by 2002:a17:906:2443:b0:abb:b533:3ecb with SMTP id
 a640c23a62f3a-abbb5334582mr301097766b.17.1739885768726; Tue, 18 Feb 2025
 05:36:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218105824.34511-1-wanghai38@huawei.com>
In-Reply-To: <20250218105824.34511-1-wanghai38@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Feb 2025 14:35:57 +0100
X-Gm-Features: AWEUYZkTkYp5qWAJLLVVtJo_9aJwB7ywvIiOdhHV2BtfOisw9oMUSGlN21yY0qE
Message-ID: <CANn89iKF+LC_isruAAd+nyxgytr4LPeFTe9=ey0j=Xy5URMvkg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix error ts_recent time during three-way handshake
To: Wang Hai <wanghai38@huawei.com>
Cc: ncardwell@google.com, kuniyu@amazon.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 12:00=E2=80=AFPM Wang Hai <wanghai38@huawei.com> wr=
ote:
>
> If two ack packets from a connection enter tcp_check_req at the same time
> through different cpu, it may happen that req->ts_recent is updated with
> with a more recent time and the skb with an older time creates a new sock=
,
> which will cause the tcp_validate_incoming check to fail.
>
> cpu1                                cpu2
> tcp_check_req
>                                     tcp_check_req
> req->ts_recent =3D tmp_opt.rcv_tsval =3D t1
>                                     req->ts_recent =3D tmp_opt.rcv_tsval =
=3D t2
>
> newsk->ts_recent =3D req->ts_recent =3D t2 // t1 < t2
> tcp_child_process
> tcp_rcv_state_process
> tcp_validate_incoming
> tcp_paws_check
> if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <=3D paws_win) // failed
>
> In tcp_check_req, restore ts_recent to this skb's to fix this bug.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  net/ipv4/tcp_minisocks.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index b089b08e9617..0208455f9eb8 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -878,6 +878,10 @@ struct sock *tcp_check_req(struct sock *sk, struct s=
k_buff *skb,
>         sock_rps_save_rxhash(child, skb);
>         tcp_synack_rtt_meas(child, req);
>         *req_stolen =3D !own_req;
> +       if (own_req && tcp_sk(child)->rx_opt.tstamp_ok &&
> +           unlikely(tcp_sk(child)->rx_opt.ts_recent !=3D tmp_opt.rcv_tsv=
al))
> +               tcp_sk(child)->rx_opt.ts_recent =3D tmp_opt.rcv_tsval;
> +
>         return inet_csk_complete_hashdance(sk, child, req, own_req);

Have you seen the comment at line 818 ?

/* TODO: We probably should defer ts_recent change once
 * we take ownership of @req.
 */

Plan was clear and explained. Why implement something else (and buggy) ?


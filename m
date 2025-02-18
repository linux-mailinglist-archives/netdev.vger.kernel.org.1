Return-Path: <netdev+bounces-167313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F82A39BB6
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC32F1778B9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69862405FE;
	Tue, 18 Feb 2025 12:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLIc7LAs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072AA24113A;
	Tue, 18 Feb 2025 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880161; cv=none; b=LI2lMXsrUKBqwAMWum2dOPFWeRhEUIJaLZ3xkEitn5Cm5XzxnVkmj6CsRN16gwvO11Sj0QvUL6lbyX9LEvhQZPvdjlYAOk2RfFNGSdlcTAsG1nzn5fv74Sg0+eQ0u2TpsJT2r0zq8d/h+5lQiuKxbIk2ejbJUqGZjFUyU9taXIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880161; c=relaxed/simple;
	bh=PdYabW9U3VgJQcFFjKmvrLTJRGwMYLOYYMyAs3nj3J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X5iiD1VVDBVagLLUuowhTa6pvbAxucWDfhzsOxvlxba/4e1vvFOBcmVMQnUBzgMYm/2elyc9O56iL9XUcuGXborrBMcVV7hSO77duQgOaTrFnXUWtN2B+ggXCGIV/ZJKioPzGtIHBRSQkUI/8IHFpd8L+MxOjGfV+11cLwExrDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLIc7LAs; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3ce87d31480so18178375ab.2;
        Tue, 18 Feb 2025 04:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739880159; x=1740484959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EH0/wvVygyFEunzi4kDEAj+hSoHIIO4r5B7j6dKdl8w=;
        b=lLIc7LAsruF02Mp/1u3sgJHvJ9HJRSRq1HTJI+NgNHW14h9FGsnyifd6axpTvW6nd7
         cUqqPZl3LjCMNFc2V1e+gZcfNHu84rfp1p4or36iQf50HU39aeSUGY8IMlHqTpyFmvqA
         Hdxrp2yw02VLfciwT+R0ifJsPfk8O9rE5MlI0McvMwd2IoIBnzUpjPfOmf7qRlEFTz3J
         q+KvrTui3NF9xD04EjW0OREVzmmHDIeK1uBhSOOLuyNjCFP27L94KIea/icieZkrCSlo
         1PFyLngUGXFlEQy64B/zb2nIYUqS1akPg0I2uqDXplRkac/60mUpuTZGq1kuittYeozD
         T9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739880159; x=1740484959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EH0/wvVygyFEunzi4kDEAj+hSoHIIO4r5B7j6dKdl8w=;
        b=SBdyDWHd/rDryE9i2K4LC9nhBGkdVU4X6S4izlT9LwXpegY/jEYXlTqChnAVmQTtF2
         A7f2G4mKhh72HQjZ5rvcbbabdlSFmVhkYlzbez5xXfpPzIyunVTLTrAR79V2WCEb0zTZ
         C9Fgv7doUBq6UXtWZxKQOMVbvUTzjN9G08n6OpZJZm8YGAz0lu73oueacMEiTrFKpRRr
         MuZTZt78wtl07xZI4nftRP/4e9Mr0n7pusEs9SoeOae1V/1yzTNxOjVUGkp/Ua+82uSs
         yG5HSO5je7bZGN2XVzmHo8CPov49gUw5JwtUSCvqeqdzmbhAFpMcOFI0QSUwUTMCsJMI
         qz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqRe4EkUdN7dSa1S4XuvxB9dOKxZ9Xy34LmfY/R2zfXoiXByHckuyqfGr79YJYL592drffaRGn@vger.kernel.org, AJvYcCXBNQmjT4TgRTDvK4BtABlnDT7yg9QoY2J4KEbAYl5myV/1iZtZStzi55FE0QeduPZ8zqYxIpBIU4V9x+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu933GKCT5+s7nAtJhvPbGU25ILf5uB0gWcH7C6335HhNyqKH3
	ePTun+is+vlvtrpAAXVEq1zrnCigk38bvYeCG3Js6eNOf5XPYt9xh22RuNE8UJ6r/upYKW0FWUV
	ooz3z+rgaeE838lxphhaj0l0sqz0=
X-Gm-Gg: ASbGncuseM/+EGLjnWn451G8jrVqDOAheIN8IEpubiS0OvsSTG0UWA+K8+L8AO8zNuO
	0YSWpKIch40vX5SuTu5X1uj3FGi4QN2f7tBHXXGQdkKGiNcJGlaVZNzHPtrRNoPeAIcIAMtQb
X-Google-Smtp-Source: AGHT+IHUeLoHQcKiL8lW+wrpD+fz/Nx/D5ztWpyjTnSRs4G8L5aql7pqkfBtz5ir+uTY7PTrFM6uizC11h31tS1rXoE=
X-Received: by 2002:a05:6e02:170b:b0:3d0:4e57:bbda with SMTP id
 e9e14a558f8ab-3d280763e58mr120853935ab.1.1739880158966; Tue, 18 Feb 2025
 04:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218105824.34511-1-wanghai38@huawei.com>
In-Reply-To: <20250218105824.34511-1-wanghai38@huawei.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 18 Feb 2025 20:02:02 +0800
X-Gm-Features: AWEUYZmYwJzlWpycVnHN_n7tw5SCCerfFcjjLinZ7I9wb-OgwxRNYHQ37V1fyoQ
Message-ID: <CAL+tcoCZQZWdTBNM5o2PEpzEnmgfZFFps1WuB9D75p2=Gkbf2Q@mail.gmail.com>
Subject: Re: [PATCH net] tcp: Fix error ts_recent time during three-way handshake
To: Wang Hai <wanghai38@huawei.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@amazon.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wang,

On Tue, Feb 18, 2025 at 7:02=E2=80=AFPM Wang Hai <wanghai38@huawei.com> wro=
te:
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

It's known that it's possible to receive two packets in two different
cpus like this case nearly at the same time. I'm curious if the socket
was running on the loopback?

Even if the above check that you commented in tcp_paws_check() fails,
how about the rest of the checks in tcp_validate_incoming()? In your
test, I doubt if really that check failed which finally caused the skb
from CPU2 to be discarded. Let me put it this way, is the paws_win
check the root cause? What is the drop reason for
tcp_validate_incoming()?

Thanks,
Jason

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
>
>  listen_overflow:
> --
> 2.17.1
>
>


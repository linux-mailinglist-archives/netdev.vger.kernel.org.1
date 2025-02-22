Return-Path: <netdev+bounces-168775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE58BA40957
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 16:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7971891A22
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEC718E76B;
	Sat, 22 Feb 2025 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbuKo6T5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A108F189913;
	Sat, 22 Feb 2025 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740236818; cv=none; b=MVePPcYBR/n1DlJY5ms5ZQKVmwzxZhyKMH6VsOTc0Q7plpCWOxAC0RnKK0GGv1DhBvDU4FFIuVBuCG/ePtZoCVSVq2pZzI37Mx8rknvBCvjX0R8MurBC01ZU7h0DlCZwl/AkbP+BvelX2vQFc6echkrWk5NSWPpbmoaIFY5ocks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740236818; c=relaxed/simple;
	bh=/79H6Qp0S0WUb6pL/fFShpv6CowCBkJWqN/s12nzPgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdGYYdRccY3wKWvfEepJ3SYeWOOBbq90r1kQnPKa2Rw1KTN1Dqk8X1Q4dVb9G36/HiGMYw00JXO8RpQtDsOukOlHAvAw4/ULGTujDIAWHjkCvGZ+nLggbMniJNWh2/SsJie+PXRkD+/muOL0jZ2VoTAzfacTOPcAX+PckDsPwz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbuKo6T5; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso26042815ab.1;
        Sat, 22 Feb 2025 07:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740236814; x=1740841614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzaLEgWYgQCmXuI1xyS57YzrmqSQoqnt6fkTxsBS96A=;
        b=IbuKo6T5kFCaAx/cyqNPx/44Yqqf53wV6ntu91iEGt3Ni+Mala2tK7CqRkJNove1Sq
         8zBNOW6wsyjhqcqcHXO5+DnC0uDxTSGrxOOktyiRFXKsb3wnzAi/4vWNHRPlxDd/PM0G
         feAO66HrgjTOw/9wZCjmBH4NWWTUMym19qpdGB5ANUL7HL5zYHltJ9rrmfOvze5L/2Wq
         1tRrROGOJYDF1M7t1JnkZ2yX7bj+5hz74HUCzDBc6OpS7tOr/cFLkHbD6hUh+sFW/XQ3
         c/1EOoP0NTgQ3NU/A6SsBvyFHcflF86P7iQQUT79FBG93IljBaYwUZTbv9733VDHJsO0
         Pi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740236814; x=1740841614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzaLEgWYgQCmXuI1xyS57YzrmqSQoqnt6fkTxsBS96A=;
        b=QVDZrfculSAGP6Yh2TXxdtgdNuvzqttsvaeJH+xLoJd/LyA7oPp2dVoxShYqzG6dMX
         UCcvqt7UDzqQ86ISilMNVntfSCdNDj2y4PQqyahluKP1ai9hPWR0hEttEBZS1LSQ2zwt
         TeG93YjApo7nufBsAxQ17eyrflpslYhjZCK5FtxIVTdkpotIbjyFKpXyx3mE/Q3Jaw7t
         nPB0SXcoE8MZbEOuYXX74s2kjKtM2SL0kZ0zR1TLSUCpkqO4tyLHekiV9BohzUA1z1eE
         xKd8zfx0UyxoCWpKE1kFAkWP+OJa3kWrFkPdV1dCFkQR8fgRtbhm8fKVCCnt9KPaRe0q
         6nvg==
X-Forwarded-Encrypted: i=1; AJvYcCUCk05SQi5VpeHeVB9Hl6DZyNCedc0j6Ms1MH2AdJV5L7JmPBsTZGwa3u5gD6VIKybecYVIIzF4/MzGbPc=@vger.kernel.org, AJvYcCW6naekB/UciRAXTcZ+yR1Y3VcmyuOvDqbEc0WWnMglUPnzcrpof5QhUwMleqZmF49p45wMJyh9@vger.kernel.org
X-Gm-Message-State: AOJu0YzS5B7ECAZqXsZVqzR1xzaOSTvMn7g9+lCv8tF+O1dDlnlGN1rZ
	jyYj5gheDcODKLVFc61cJyx56d+GRx4zeecrUWbydjU7TxsutfVL56RUNGu9Zv90lcCoWFCliiL
	1EptWPPta07sTMN0VXrUSP9dkQ5M=
X-Gm-Gg: ASbGnctjOmGeP1rpRlTG6PE2Zr9FqQoielIYPD0re3tp7e6H/TYcRly/Mqllk3TeWNp
	r59d75EdQs/7HqDwHPvjcXu8+1HMK1w6qx4BvpfdbWtvKUreavAFT0T8HPb2itxsPhIM2it30MR
	2YjrmWFgQ=
X-Google-Smtp-Source: AGHT+IFLnYoAxL5ZurXiyRihzGN0nKSqG5w+P7/jIk/1PSsNBVx4okJpV66xsMUP1ONBFEkl5CSYFyzI7u221Ie3dgU=
X-Received: by 2002:a05:6e02:13a4:b0:3d0:123e:fbdd with SMTP id
 e9e14a558f8ab-3d2cae8a7b4mr69278925ab.11.1740236814615; Sat, 22 Feb 2025
 07:06:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222103928.12104-1-wanghai38@huawei.com>
In-Reply-To: <20250222103928.12104-1-wanghai38@huawei.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 22 Feb 2025 23:06:18 +0800
X-Gm-Features: AWEUYZkLh9yfFXXGl3sGrD7z3YEPoiTi3Gp9SniMZjJucK5XDNNwlc7aoGx8Qzg
Message-ID: <CAL+tcoDBHtRt-Ep3QORj3DnDa0Aeha5ZhQi30QP_zZkm-SrzUw@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: Defer ts_recent changes until req is owned
To: Wang Hai <wanghai38@huawei.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@amazon.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, zhangchangzhong@huawei.com, liujian56@huawei.com, 
	yuehaibing@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 6:41=E2=80=AFPM Wang Hai <wanghai38@huawei.com> wro=
te:
>
> The same 5-tuple packet may be processed by different CPUSs, so two
> CPUs may receive different ack packets at the same time when the
> state is TCP_NEW_SYN_RECV.
>
> In that case, req->ts_recent in tcp_check_req may be changed concurrently=
,
> which will probably cause the newsk's ts_recent to be incorrectly large.
> So that tcp_validate_incoming will fail.
>
> cpu1                                    cpu2
> tcp_check_req
>                                         tcp_check_req
>  req->ts_recent =3D rcv_tsval =3D t1
>                                          req->ts_recent =3D rcv_tsval =3D=
 t2
>
>  syn_recv_sock
>   newsk->ts_recent =3D req->ts_recent =3D t2 // t1 < t2
> tcp_child_process
>  tcp_rcv_state_process
>   tcp_validate_incoming
>    tcp_paws_check
>     if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <=3D paws_win)
>         // t2 - t1 > paws_win, failed
>
> In tcp_check_req, Defer ts_recent changes to this skb's to fix this bug.

Honestly, from my perspective, the commit message doesn't actually
reflect what the real problem you've encountered is and what the
potential bad result could be. Your previous reply is good and
detailed, at least showing to the readers enough information to help
them revisit or analyze in the future.

>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Otherwise, it looks good to me. Thanks!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
> v1->v2: Modified the fix logic based on Eric's suggestion. Also modified =
the msg
>  net/ipv4/tcp_minisocks.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index b089b08e9617..53700206f498 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -815,12 +815,6 @@ struct sock *tcp_check_req(struct sock *sk, struct s=
k_buff *skb,
>
>         /* In sequence, PAWS is OK. */
>
> -       /* TODO: We probably should defer ts_recent change once
> -        * we take ownership of @req.
> -        */
> -       if (tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq, tcp_rsk(re=
q)->rcv_nxt))
> -               WRITE_ONCE(req->ts_recent, tmp_opt.rcv_tsval);
> -
>         if (TCP_SKB_CB(skb)->seq =3D=3D tcp_rsk(req)->rcv_isn) {
>                 /* Truncate SYN, it is out of window starting
>                    at tcp_rsk(req)->rcv_isn + 1. */
> @@ -869,6 +863,9 @@ struct sock *tcp_check_req(struct sock *sk, struct sk=
_buff *skb,
>         if (!child)
>                 goto listen_overflow;
>
> +       if (own_req && tmp_opt.saw_tstamp && !after(TCP_SKB_CB(skb)->seq,=
 tcp_rsk(req)->rcv_nxt))
> +               tcp_sk(child)->rx_opt.ts_recent =3D tmp_opt.rcv_tsval;
> +

nit: I would suggest using the following format if a re-spin is necessary:
+       if (own_req && tmp_opt.saw_tstamp &&
+           !after(TCP_SKB_CB(skb)->seq, tcp_rsk(req)->rcv_nxt))
+               tcp_sk(child)->rx_opt.ts_recent =3D tmp_opt.rcv_tsval;
+

Thanks,
Jason

>         if (own_req && rsk_drop_req(req)) {
>                 reqsk_queue_removed(&inet_csk(req->rsk_listener)->icsk_ac=
cept_queue, req);
>                 inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req)=
;
> --
> 2.17.1
>


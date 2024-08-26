Return-Path: <netdev+bounces-121905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB1A95F2E2
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5851F24DAA
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC4E185945;
	Mon, 26 Aug 2024 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vWdG3rZQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AA52C95
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678768; cv=none; b=BRrbqVB9rwNKC5UJ/fjxtU3MdfzGqAtyeBrVmXriITr/f2oEwTH3AbdvRnAx/lzKDK4ysQ6E8JeT5MXeb/71Te8Di8uHI5/Xf239ZubgB5etQUQAd92vZvvoZAThjqTCJAw3w1vp/nYaZoR563XoRyokThROXpnHQm4bHMGIiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678768; c=relaxed/simple;
	bh=QC0CVWyHvEoZVgHKieH98tTRsbfFRaT2YEMd/KVCGr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqvI4GnV2RLN3dR6LY/YBpe1t6SrZxaQ+phYvRplbwuD8dC8LU5dM1XWk/GMl9fWPpBU7F09TTs78PSjZDgMDWY49UaQBMYTjXStNUytNi0F8/Trx3JknYlDph2oB3+UQvXFnmDS+sbm0Mba0gGSvsteTZuI0SDf9NK3La8haFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vWdG3rZQ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44fee2bfd28so553951cf.1
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 06:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724678766; x=1725283566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGjQ22+6AABz8Tkg+PRh41V1vtpmKdf7DG/B6aseecc=;
        b=vWdG3rZQDUlT37EKCisyrIq2ASd44vMis9q9YGbOQzN/XItgDmq5ehutbz7hMQ718N
         YRIzvqBmpyqWjQPb6m5J/aNqYjn+zVQ4Fod1cJdTuDHannbA5tYkoKiChc/UTtPdvs+o
         Zuu9YOx4Gk4a2dNSW1TEarYRwteby3kiw9LCAsCZmtcsNdHtqYfv415tAfHuiHrxRlIV
         QTh5IEL53p9BIG/SYqFsxGSzRE0OfI1QFD6poJF/zMgcY2gBnhaXJNaC+qvXIrNehido
         2NXpQjLUFFRXVpLWDDFQwX5gd63L3XQGiiPy0qwNhjKP2VaalHvsRhn1APdr+CFPeoQr
         hgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724678766; x=1725283566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGjQ22+6AABz8Tkg+PRh41V1vtpmKdf7DG/B6aseecc=;
        b=bJmGnJEAirXFYELCeuYO4fJnaGsux6l6KspLENlsnlGECw2y+ONX9M8AwZkvZCZAsc
         NMG2dHhG2mcOTW+obomHH0/wGQyj3EPLedIpbnJ12ICJhrlWMQmFHFJv5M0eiCOPN+yU
         MTaWCg7Mn8Dve1AVrLC8VLHAovkU2sWx95zNDaVwr8TCYiw6UxUukhn0at3JDCRRhTqn
         JU7Q3N7Zego/U9sMKB8BBThT+wBA6+mEVH1kcE34VoqIy1LAkgSwb7v400l7WenaLaTu
         ckZSXY0lxqatNfC90YaDoygmPmK0aGL46keXQwc99y9eTbWXpY12ws3Ssn5XVw3Z5cfa
         OCNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbJEM5rLbuwJQMFpGZbsMah2hOk7YzH7vzefhfMsA71GrE5xU78IWoPPIExhsxA8zANSrjAaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94rA1O2GH7HJFEHusI0W/x+VpXQYQJYhIKN5Tn4gNPyFbtn+2
	KNvYa9ifzwaPAMmD/Tvq5rNTW6zBeHZcOuVVifMA0CUdRXTaMQiLX7K2HNxrPwTzgsBv3pwgyZV
	rO2hFbAc2942qFwKKOZ6EUTMAbCuCjf4DyP1J
X-Google-Smtp-Source: AGHT+IEkUrFA9QBtHpgKHzNIR9ua6SlJcrbIJrJu9+a1SAAcKKpj3P+uGbVJ3sXYRdombUgFs3YopROe46yhvcUrqIk=
X-Received: by 2002:a05:622a:284:b0:441:5e6c:426c with SMTP id
 d75a77b69052e-45643a7756cmr4526521cf.17.1724678765622; Mon, 26 Aug 2024
 06:26:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826092707.2661435-1-edumazet@google.com>
In-Reply-To: <20240826092707.2661435-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 26 Aug 2024 09:25:46 -0400
Message-ID: <CADVnQy=Z697P_gtkXMgPiASS6YwJ4PLDkqei3NvGJ5csKE8nhw@mail.gmail.com>
Subject: Re: [PATCH net] tcp_cubic: switch ca->last_time to usec resolution
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Mingrui Zhang <mrzhang97@gmail.com>, Lisong Xu <xu@unl.edu>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 5:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> bictcp_update() uses ca->last_time as a timestamp
> to decide of several heuristics.
>
> Historically this timestamp has been fed with jiffies,
> which has too coarse resolution, some distros are
> still using CONFIG_HZ_250=3Dy
>
> It is time to switch to usec resolution, now TCP stack
> already caches in tp->tcp_mstamp the high resolution time.
>
> Also remove the 'inline' qualifier, this helper is used
> once and compilers are smarts.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Link: https://lore.kernel.org/netdev/20240817163400.2616134-1-mrzhang97@g=
mail.com/T/#mb6a64c9e2309eb98eaeeeb4b085c4a2270b6789d
> Cc: Mingrui Zhang <mrzhang97@gmail.com>
> Cc: Lisong Xu <xu@unl.edu>
> ---
>  net/ipv4/tcp_cubic.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 5dbed91c6178257df8d2ccd1c8690a10bdbaf56a..3b1845103ee1866a316926a13=
0c212e6f5e78ef0 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -87,7 +87,7 @@ struct bictcp {
>         u32     cnt;            /* increase cwnd by 1 after ACKs */
>         u32     last_max_cwnd;  /* last maximum snd_cwnd */
>         u32     last_cwnd;      /* the last snd_cwnd */
> -       u32     last_time;      /* time when updated last_cwnd */
> +       u32     last_time;      /* time when updated last_cwnd (usec) */
>         u32     bic_origin_point;/* origin point of bic function */
>         u32     bic_K;          /* time to origin point
>                                    from the beginning of the current epoc=
h */
> @@ -211,26 +211,28 @@ static u32 cubic_root(u64 a)
>  /*
>   * Compute congestion window to use.
>   */
> -static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
> +static void bictcp_update(struct sock *sk, u32 cwnd, u32 acked)
>  {
> +       const struct tcp_sock *tp =3D tcp_sk(sk);
> +       struct bictcp *ca =3D inet_csk_ca(sk);
>         u32 delta, bic_target, max_cnt;
>         u64 offs, t;
>
>         ca->ack_cnt +=3D acked;   /* count the number of ACKed packets */
>
> -       if (ca->last_cwnd =3D=3D cwnd &&
> -           (s32)(tcp_jiffies32 - ca->last_time) <=3D HZ / 32)
> +       delta =3D tp->tcp_mstamp - ca->last_time;
> +       if (ca->last_cwnd =3D=3D cwnd && delta <=3D USEC_PER_SEC / 32)
>                 return;
>
> -       /* The CUBIC function can update ca->cnt at most once per jiffy.
> +       /* The CUBIC function can update ca->cnt at most once per ms.
>          * On all cwnd reduction events, ca->epoch_start is set to 0,
>          * which will force a recalculation of ca->cnt.
>          */
> -       if (ca->epoch_start && tcp_jiffies32 =3D=3D ca->last_time)
> +       if (ca->epoch_start && delta < USEC_PER_MSEC)
>                 goto tcp_friendliness;

AFAICT there is a problem here. It is switching this line of code to
use microsecond resolution without also changing the core CUBIC slope
(ca->cnt) calculation to also use microseconds.  AFAICT that means we
would be re-introducing the bug that was fixed in 2015 in
d6b1a8a92a1417f8859a6937d2e6ffe2dfab4e6d (see below). Basically, if
the CUBIC slope (ca->cnt) calculation uses jiffies, then we should
only run that code once per jiffy, to avoid getting the wrong answer
for the slope:

commit d6b1a8a92a1417f8859a6937d2e6ffe2dfab4e6d
Author: Neal Cardwell <ncardwell@google.com>
Date:   Wed Jan 28 20:01:39 2015 -0500

    tcp: fix timing issue in CUBIC slope calculation

    This patch fixes a bug in CUBIC that causes cwnd to increase slightly
    too slowly when multiple ACKs arrive in the same jiffy.

    If cwnd is supposed to increase at a rate of more than once per jiffy,
    then CUBIC was sometimes too slow. Because the bic_target is
    calculated for a future point in time, calculated with time in
    jiffies, the cwnd can increase over the course of the jiffy while the
    bic_target calculated as the proper CUBIC cwnd at time
    t=3Dtcp_time_stamp+rtt does not increase, because tcp_time_stamp only
    increases on jiffy tick boundaries.

    So since the cnt is set to:
            ca->cnt =3D cwnd / (bic_target - cwnd);
    as cwnd increases but bic_target does not increase due to jiffy
    granularity, the cnt becomes too large, causing cwnd to increase
    too slowly.

    For example:
    - suppose at the beginning of a jiffy, cwnd=3D40, bic_target=3D44
    - so CUBIC sets:
       ca->cnt =3D  cwnd / (bic_target - cwnd) =3D 40 / (44 - 40) =3D 40/4 =
=3D 10
    - suppose we get 10 acks, each for 1 segment, so tcp_cong_avoid_ai()
       increases cwnd to 41
    - so CUBIC sets:
       ca->cnt =3D  cwnd / (bic_target - cwnd) =3D 41 / (44 - 41) =3D 41 / =
3 =3D 13

    So now CUBIC will wait for 13 packets to be ACKed before increasing
    cwnd to 42, insted of 10 as it should.

    The fix is to avoid adjusting the slope (determined by ca->cnt)
    multiple times within a jiffy, and instead skip to compute the Reno
    cwnd, the "TCP friendliness" code path.

    Reported-by: Eyal Perry <eyalpe@mellanox.com>
    Signed-off-by: Neal Cardwell <ncardwell@google.com>
    Signed-off-by: Yuchung Cheng <ycheng@google.com>
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index ffc045da2fd5..4b276d1ed980 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -213,6 +213,13 @@ static inline void bictcp_update(struct bictcp
*ca, u32 cwnd, u32 acked)
            (s32)(tcp_time_stamp - ca->last_time) <=3D HZ / 32)
                return;

+       /* The CUBIC function can update ca->cnt at most once per jiffy.
+        * On all cwnd reduction events, ca->epoch_start is set to 0,
+        * which will force a recalculation of ca->cnt.
+        */
+       if (ca->epoch_start && tcp_time_stamp =3D=3D ca->last_time)
+               goto tcp_friendliness;
+
        ca->last_cwnd =3D cwnd;
        ca->last_time =3D tcp_time_stamp;

@@ -280,6 +287,7 @@ static inline void bictcp_update(struct bictcp
*ca, u32 cwnd, u32 acked)
        if (ca->last_max_cwnd =3D=3D 0 && ca->cnt > 20)
                ca->cnt =3D 20;   /* increase cwnd 5% per RTT */

+tcp_friendliness:
        /* TCP Friendly */
        if (tcp_friendliness) {
                u32 scale =3D beta_scale;
---

neal


Return-Path: <netdev+bounces-230750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A807DBEEAEB
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 19:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7AA64E3651
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 17:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881FE20F067;
	Sun, 19 Oct 2025 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0BPkeeK2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37871F7575
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760895822; cv=none; b=fNROj/P+iZ5ogAn1x3Eayb+7c9XI9N2JBPoINtUvf9tz/RwcuoL4ICODFvPDjpooux6QQGV8INlaaeRMIVeYLAiSSweIfX0D8S4VICCklb4IVd5cKO+PzzCVmA1Wl6+kxxzr5KWDVesJFekSNCNhbO2+rK7B3Jekw+mgaN7d28g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760895822; c=relaxed/simple;
	bh=NBxTjOq1rphtkq9ZGwMMLSzy8hPiIAv5nUCpEuG+srQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uH/4N+FyCVhV/DCcWzs+hECk7P8fKHdeTpRFSPGZlPDVz1Ow3983wWMXSb8f+Huzt+VGDLx6xt3epgyo7olVr25ddVU8/sJFANwtqkdLmBQcv+tqeGQPuQ0kE/HgGkq11yO3deGGpDRMhUqZWtH1KiYIBfWFDUTLwcetR+JhLQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0BPkeeK2; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-791fd6bffbaso62030806d6.3
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760895820; x=1761500620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uC2oktoAuA/UwIup+5BKUv+Ff5r+vqavOtTCSaxD56c=;
        b=0BPkeeK25oyp62dUj9ZKIbD/BlSl3HqyNZDikQPepW28DBYQSajV4qPAXztFpg2zrs
         0xobVOOSzHdM8aUMsgInFSPboyg/mZEQe+WL1B47lLFrQfRwLtt2t8s58B0XtKNEAfIv
         WsY5Ay/XPE8N5PNAwfpPHSiwa1g7pXnqlIX8lMVFfQgF9e1VYJIdH+zDCGA7c3IC0Zmj
         YNKWtDpY1NMtwfEjTARf6lcJJdT/qEUItlBTXmOMxavFZuCNSecVwOwS2veiEijRLutI
         3yTMx9JxSovcJTqsuXQ7Fc0BEIzRCfHn4Ucak1xVnGhAhPLLob0oimUz+u9/HA+4Tsox
         10cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760895820; x=1761500620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uC2oktoAuA/UwIup+5BKUv+Ff5r+vqavOtTCSaxD56c=;
        b=VZKpRkouyLbvzFxqarcmjsZF1AQGveFEzXxmfBw+sq8T+MkGuvlrauSgm8GHuPezn/
         QMOIRhYRFCGxcpTxMCuvAWgtoEWjXUmekOnVfXxzqbv57eLcf+P97+NXK4eF+p60dPrN
         a603g1cvJD23UcEhKrBj5teSPFSLfsA+u331Q3S3TSLMHHQMDcuFbFDgoucprpDI3MAL
         Qevd2pz5yOD1KS5E5IYbifrBawt4mc7t5DE85jSKWls5/q7cTYtw5J6Lx2TyffydsUZw
         gaIWDbm+pd8zNjVIqOOakO5aamg7ohAgRRF/sF9nVWxy4Y7hdaGtaWaOBIH6258zu+ie
         AP8A==
X-Forwarded-Encrypted: i=1; AJvYcCUiLR4BcheESol93iJFW0dOrhH5+Qm0ZeaGWNVctCXQwlwda7uel0F6RC3wim99rjSw4O0WLyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmW0CvESeN7wjcIbJUQ5r++R+WWKsJCRgdq7nNxZGlfrYy0Nr4
	Lu44iLc20xdahCx0TPSAxn5sCxQt30B+aAkL3xEPY3Pw0nFrtoxz85rngsXAE2K4JVJsjjuSOdr
	eOZ8bQ0k4SrTE3+VqUAv4QDuNv6OcEgjbHqLeDjIT
X-Gm-Gg: ASbGncu4fNpGaW1cY0xTV02LA2e9K/0j7rO4r7JGkaL3eOlB2rOT+1br8GkVa/oSLOD
	mKsuyx3p+lMCGgNg0f+jmKososs/40pvL1orc2l+IHu8tc6lHVAQeyctdLhe1pp1jKzFVUk0u4O
	WmB4tLpvnt6gyRIjeuwhMfVFQV9PxglayyJo+DetrfBLyFyQnYTO7QhnTIbJxshGgb+o1Dux6FW
	2S+Lfj3n81XhnPT6JiLqU1MIbH+3ljGo2ht/UH2J0uKV+Ay63w5mtSGX9Pf
X-Google-Smtp-Source: AGHT+IFsVI8ca5DhUITgYh4VP54SltgZVBPy9yV+UacuNN8tlTVmEdOFLjduDw/AeORei3lobDwst5nXoKGw8M1vKcQ=
X-Received: by 2002:a05:622a:1482:b0:4e8:99f5:e331 with SMTP id
 d75a77b69052e-4e89d3891a8mr126498661cf.60.1760895819282; Sun, 19 Oct 2025
 10:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019170016.138561-1-peng.yu@alibaba-inc.com>
In-Reply-To: <20251019170016.138561-1-peng.yu@alibaba-inc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 19 Oct 2025 10:43:28 -0700
X-Gm-Features: AS18NWAmmbau-vvPnXqP2Xed52k2q_aefTZRH7y6JzClnIDf5qiToP7YQGMZXQ4
Message-ID: <CANn89iLsDDQuuQF2i73_-HaHMUwd80Q_ePcoQRy_8GxY2N4eMQ@mail.gmail.com>
Subject: Re: [PATCH] net: set is_cwnd_limited when the small queue check fails
To: Peng Yu <yupeng0921@gmail.com>
Cc: ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peng Yu <peng.yu@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 10:00=E2=80=AFAM Peng Yu <yupeng0921@gmail.com> wro=
te:
>
> The limit of the small queue check is calculated from the pacing rate,
> the pacing rate is calculated from the cwnd. If the cwnd is small,
> the small queue check may fail.
> When the samll queue check fails, the tcp layer will send less
> packages, then the tcp_is_cwnd_limited would alreays return false,
> then the cwnd would have no chance to get updated.
> The cwnd has no chance to get updated, it keeps small, then the pacing
> rate keeps small, and the limit of the small queue check keeps small,
> then the small queue check would always fail.
> It is a kind of dead lock, when a tcp flow comes into this situation,
> it's throughput would be very small, obviously less then the correct
> throughput it should have.
> We set is_cwnd_limited to true when the small queue check fails, then
> the cwnd would have a chance to get updated, then we can break this
> deadlock.
>
> Below ss output shows this issue:
>
> skmem:(r0,rb131072,
> t7712, <------------------------------ wmem_alloc =3D 7712
> tb243712,f2128,w219056,o0,bl0,d0)
> ts sack cubic wscale:7,10 rto:224 rtt:23.364/0.019 ato:40 mss:1448
> pmtu:8500 rcvmss:536 advmss:8448
> cwnd:28 <------------------------------ cwnd=3D28
> bytes_sent:2166208 bytes_acked:2148832 bytes_received:37
> segs_out:1497 segs_in:751 data_segs_out:1496 data_segs_in:1
> send 13882554bps lastsnd:7 lastrcv:2992 lastack:7
> pacing_rate 27764216bps <--------------------- pacing_rate=3D27764216bps
> delivery_rate 5786688bps delivered:1485 busy:2991ms unacked:12
> rcv_space:57088 rcv_ssthresh:57088 notsent:188240
> minrtt:23.319 snd_wnd:57088
>
> limit=3D(27764216 / 8) / 1024 =3D 3389 < 7712
> So the samll queue check fails. When it happens, the throughput is
> obviously less than the normal situation.
>
> By setting the tcp_is_cwnd_limited to true when the small queue check
> failed, we can avoid this issue, the cwnd could increase to a reasonalbe
> size, in my test environment, it is about 4000. Then the small queue
> check won't fail.


>
> Signed-off-by: Peng Yu <peng.yu@alibaba-inc.com>
> ---
>  net/ipv4/tcp_output.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index b94efb3050d2..8c70acf3a060 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2985,8 +2985,10 @@ static bool tcp_write_xmit(struct sock *sk, unsign=
ed int mss_now, int nonagle,
>                     unlikely(tso_fragment(sk, skb, limit, mss_now, gfp)))
>                         break;
>
> -               if (tcp_small_queue_check(sk, skb, 0))
> +               if (tcp_small_queue_check(sk, skb, 0)) {
> +                       is_cwnd_limited =3D true;
>                         break;
> +               }
>
>                 /* Argh, we hit an empty skb(), presumably a thread
>                  * is sleeping in sendmsg()/sk_stream_wait_memory().
> --
> 2.47.3

Sorry this makes no sense to me.  CWND_LIMITED should not be hijacked.

Something else is preventing your flows to get to nominal speed,
because we have not seen anything like that.

It is probably a driver issue or a receive side issue : Instead of
trying to work around the issue, please root cause it.


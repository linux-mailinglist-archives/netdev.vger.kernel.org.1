Return-Path: <netdev+bounces-159490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53971A159D2
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 00:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEA13A6DE7
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E1C1D9A66;
	Fri, 17 Jan 2025 23:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8jddjW1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402F51D8DFE
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 23:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737155494; cv=none; b=OUOwz+mMNdZ73sqHUN+3dLnK9fGa/7ujd6cDcApQRUVrhXqX9AXitH+s8q7+WWjvz3j8jWaumz7cqEEK/GRDThgY7rqJNXV3/OJRC2wlnaBHHpMUb9OnfvtXd8IgPqs8oDM67sJ/LKiUaFlT2j5hZWep6D0hmEJwy7tTnAme8oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737155494; c=relaxed/simple;
	bh=3PRbDV0P1rgbpm0TN020zCThRm2mpSzTYK+C4h6HXTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AM5sOCszw+LZ41BzP5PonIbUrMYMjH0p8acZz4fynmC6vatmCZRZrQQ7i+arneICnD8ayRcdv9P4QDQKFOOMaiOqytUoDZFh8/Gfn5s6YOlli/YGGPbLE3BW3uJHFZDyh+MwZ9pfxXLaDraypRWwrAtBESwRd91ErlY6rFXfF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8jddjW1; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-467abce2ef9so76721cf.0
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 15:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737155492; x=1737760292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PRbDV0P1rgbpm0TN020zCThRm2mpSzTYK+C4h6HXTo=;
        b=m8jddjW1GX/9KNg9zKTh1GQncFBVl2N9fWIcbVZXPdIEl4Jdx312+DwH0bmuwaQpGt
         qJfhTifA2AV7rrjhLLokqOtgt3VLUFAAdMf7rAqdrzO+9knAIl1DGDYHiqTeoZ4di2I4
         0aRFpl84Lq1Owp9zx2W+U7FxnjPcyQNYRkqY7Y8EkEERDZG/BLVR50bKtFlYwHtXf3qg
         qCVW+xgZHDFh2THwuId8PfvwzwXi9yjwYdtFuR0Mv57jaUC0QEX8PUivjmjjOLP48yLx
         9J0Gy6Yr89aZOKpsnIXc3LA+IyTEFM0UWQByMPPM3QTUMSVdCdcSZn5QfEfPcMvNo44m
         VNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737155492; x=1737760292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PRbDV0P1rgbpm0TN020zCThRm2mpSzTYK+C4h6HXTo=;
        b=JAPrc2OZTBZ44if7ZojkmJa+0EUIYGwf9hOzgD+TDW7W03riivEXCLu3snGQ9+Yfns
         WwUm95beQhrUaNxIWw4kodTy6O2qPEvHh+8GRi85RZalCTi+iUYCXgOr3H7c0rJ4iYAz
         mNm0YdZFANz0edDsaRS22+7enu4LxVEjmQZLdIJVtuyeOqiFgNIF5hIFKDJYaZhdYdV+
         YcYrF6pUkqs338Cqv4YBQ+MyDcZK8QY7lVkhvkO04wdoN+p1WSBP3VSeApXJ1cuaArEs
         LleMPAxcPRnr+jHL6gtnO2mibUO6bNVojyJTEa4JxX52MnOKlJPBxh9c6HiiEY/V1Ii1
         dkPA==
X-Forwarded-Encrypted: i=1; AJvYcCW87VExO7sFoX2CeTdHQLLTZDZ7Zy3JPbGXSXnLXKqKjlxTjKbxKzJTP6PCjpYUnvdK4mMkDBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc7lyzNI7EJyC7cSVaM24QJzSnfxb4ks9ykKcmn5UeplYCjHI7
	TGT7R02b4LPGwjYP8dAkb0A8snpdJuvaq07YjkwFOHE2QoAYH/SYuHZBEx06X/tGzHZT4j/Kr4x
	NQyJ2du0j/G75BTATLlIKFukwdMZlJ80l35MV
X-Gm-Gg: ASbGncvBiD32K0oNp0twye+kK0/VT+tgL9vBmvFE4nVd5FOx6vpTwOWrRlkBktzQ8zk
	Vsvm23vJrObvD+FaB6d8XDm7eH2mlDvmkTsawY3bt65JjZ+bz6HM0Fe4ZSZNTsmJvS+7vXi/L1o
	sn2aMhXvmCeJazom4p/Q==
X-Google-Smtp-Source: AGHT+IGl+gKjkOP6569phnI1GdSd7E/S4/3Y0wN4rgNlSZLySKaeCXSniI49MdyHHVwE0AEL0WKH+0SAePjbIKtvGOk=
X-Received: by 2002:a05:622a:13cf:b0:466:861a:f633 with SMTP id
 d75a77b69052e-46e21081e0cmr366381cf.5.1737155491841; Fri, 17 Jan 2025
 15:11:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117213751.2404-1-ma.arghavani.ref@yahoo.com>
 <20250117213751.2404-1-ma.arghavani@yahoo.com> <CANn89i+g380KQq7C8GEJVxwNNZJE6gwq3JCCyGsn6M09+y8N7Q@mail.gmail.com>
In-Reply-To: <CANn89i+g380KQq7C8GEJVxwNNZJE6gwq3JCCyGsn6M09+y8N7Q@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 17 Jan 2025 18:11:15 -0500
X-Gm-Features: AbW1kvaTyGdBVg0B5EDQUucSk4rmsgfFkCNSkVJp4vloGZgCLNRNHSyxna3mO-Q
Message-ID: <CADVnQyn-T_3r2_M9M03qPvvyeRgX2GP543x89SeDrDmLWPJAcQ@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp_cubic: fix incorrect HyStart round start detection
To: Eric Dumazet <edumazet@google.com>
Cc: Mahdi Arghavani <ma.arghavani@yahoo.com>, netdev@vger.kernel.org, haibo.zhang@otago.ac.nz, 
	david.eyers@otago.ac.nz, abbas.arghavani@mdu.se, 
	Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 5:00=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Jan 17, 2025 at 10:38=E2=80=AFPM Mahdi Arghavani <ma.arghavani@ya=
hoo.com> wrote:
> >
> > I noticed that HyStart incorrectly marks the start of rounds,
> > leading to inaccurate measurements of ACK train lengths and
> > resetting the `ca->sample_cnt` variable. This inaccuracy can impact
> > HyStart's functionality in terminating exponential cwnd growth during
> > Slow-Start, potentially degrading TCP performance.
> >
> > The issue arises because the changes introduced in commit 4e1fddc98d25
> > ("tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-lim=
ited flows")
> > moved the caller of the `bictcp_hystart_reset` function inside the `hys=
tart_update` function.
> > This modification added an additional condition for triggering the call=
er,
> > requiring that (tcp_snd_cwnd(tp) >=3D hystart_low_window) must also
> > be satisfied before invoking `bictcp_hystart_reset`.
> >
> > This fix ensures that `bictcp_hystart_reset` is correctly called
> > at the start of a new round, regardless of the congestion window size.
> > This is achieved by moving the condition
> > (tcp_snd_cwnd(tp) >=3D hystart_low_window)
> > from before calling `bictcp_hystart_reset` to after it.
> >
> > I tested with a client and a server connected through two Linux softwar=
e routers.
> > In this setup, the minimum RTT was 150 ms, the bottleneck bandwidth was=
 50 Mbps,
> > and the bottleneck buffer size was 1 BDP, calculated as (50M / 1514 / 8=
) * 0.150 =3D 619 packets.
> > I conducted the test twice, transferring data from the server to the cl=
ient for 1.5 seconds.
> > Before the patch was applied, HYSTART-DELAY stopped the exponential gro=
wth of cwnd when
> > cwnd =3D 516, and the bottleneck link was not yet saturated (516 < 619)=
.
> > After the patch was applied, HYSTART-ACK-TRAIN stopped the exponential =
growth of cwnd when
> > cwnd =3D 632, and the bottleneck link was saturated (632 > 619).
> > In this test, applying the patch resulted in 300 KB more data delivered=
.
> >
> > Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train detecti=
ons for not-cwnd-limited flows")
> > Signed-off-by: Mahdi Arghavani <ma.arghavani@yahoo.com>
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> > Cc: Neal Cardwell <ncardwell@google.com>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Haibo Zhang <haibo.zhang@otago.ac.nz>
> > Cc: David Eyers <david.eyers@otago.ac.nz>
> > Cc: Abbas Arghavani <abbas.arghavani@mdu.se>
> > ---
>
> SGTM thanks.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

LGTM as well. Thanks for the fix!

Reviewed-by: Neal Cardwell <ncardwell@google.com>
Tested-by: Neal Cardwell <ncardwell@google.com>

neal


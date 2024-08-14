Return-Path: <netdev+bounces-118313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F87F9513AA
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 06:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97B11F2473D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 04:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4681C5FEE4;
	Wed, 14 Aug 2024 04:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5HmFz2g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162B54658;
	Wed, 14 Aug 2024 04:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723611429; cv=none; b=Amz4auhnCYfQVJzqwXz+BCiRY33w2CN63Yp/GmXVzZ0q083RwSj1/1sL5f3iBuegSRIrFBR89ClTmEHwmlAaAKNB6lcb5nUStfS/7aK8mBUQQcAUFXMp+AkLYI4du6ilbfYxBde9ysoqFUVKdVAM2+7nNPspBsdA31tYZHarKVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723611429; c=relaxed/simple;
	bh=SCdfDSyO6lTM0iu7Q3WDA421eKXR9rBvk4fK7yntrYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcgWPW0Y/bGByI6Bo33lc6o6sV/48rJmnyUIzg2REGP4yGapjFXrgpzE79JglC5zR8vNyIjBRw8tAXVmha0V07zu79JxoP0T+32KS+Xpc+dqkp2VBK4gODf9UQfw33cKr8FNVL9goDS8xfxChwffdHWmRVye9miTAoDgGgu5oNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5HmFz2g; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-81f85130660so18373539f.1;
        Tue, 13 Aug 2024 21:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723611427; x=1724216227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaFIKq7TlQwBKnc4GhoMp9KxIosQoIFje7G6dP1ot1I=;
        b=c5HmFz2gRSKuSGviLYGWw7CC/vIrgFZJPtqsF5hu1MSOV5QQ9MhZefrsmt3aa+kAOd
         Tk4sZISus6mOS4nqLa5PzIwl7Gq/ylx3VksD+/LM36gjpyevzNAaaZqf6vDc+tPJxL+7
         P1ZWn2MdYnOv1xtpCkuaYZJkFNL4pgrBSOp6b3WKIjfbN7C83U5+ukx1R/lytWDCzlNn
         3UKE57zX1Dp4LSEO6HahxRHoqmEOzXY8QKhjYfXZhcM6HMRJr/3QaP62THd27RfGzVu0
         lA9TqpeF8yrv5RwWDCOPZIFxm5o7rhdz1zCDBN+8cboHY7Rfv/VeSmgr3nHcUuRSmlqj
         UdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723611427; x=1724216227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PaFIKq7TlQwBKnc4GhoMp9KxIosQoIFje7G6dP1ot1I=;
        b=qyNsbWNEoHudi37n5zjhy4DLelN6WYT13fHc4TrBVoBOQDUvYPqK2NOLSdosvH50Jc
         yyVcx8X2xq8dHESbhfM3WYBSMNea18GZraztOzLcOB9xdyMbfHG8ts3IXpGxObyWA574
         bjcvPKnaoPyhuhyZjjvvMyfNFAzPYpbsg7IvBDMb3deMwpOwBfGb+FrtGcL8PWkVPAft
         DmJivpxlvK9VUlL/sYf9LgGLBG0oygRwXrUs5s9dcHUxQbsSHWPwGG26Gad2aO1yPo+P
         CB+u2PSOTxES5HGBndr4l0rbp3XiWlpxkNLUaUrIVvvG9JsjNA6tBITpBeHVSHmBAIi7
         bQhw==
X-Forwarded-Encrypted: i=1; AJvYcCWq5ml//Mlh94IbOhhBSzMXBsuaS8v1109UH9G7HP9kX+z6OUCgrZUl3DyP8Xar1dNFyX9hcLAV2Md2Fs14QT/S/vGXG1pSM4MY79e+oywvNllP3l18X9p8YAIvvddCvlpIvmaW
X-Gm-Message-State: AOJu0YwpL2Cd1XZoweunwoA1S8sgx58Lgu5gzd2Q4ydbPUn7x33zRN6q
	IRm6Lmdd5Wn2B+ggR+7h0kuvVpf0/qvSdBURgsGl+TNyNLmcJFUGPL4MNVxC7RhGc7x1gOI3ZS0
	Q+g4WZO9rc4mJANmGYxZRN2ojZ8yJWeNf
X-Google-Smtp-Source: AGHT+IH6g1aXBUmoLns4FZl/xY1CRR2zztOpBPzcTYLiH6u90DZ6EnPqCTQhpd1mnlsppmnabxNJYBRXfXvk9hg41d8=
X-Received: by 2002:a92:c546:0:b0:39b:35d8:dc37 with SMTP id
 e9e14a558f8ab-39d1457487amr7185905ab.13.1723611426641; Tue, 13 Aug 2024
 21:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801111611.84743-1-kuro@kuroa.me> <CANn89iKp=Mxu+kyB3cSB2sKevMJa6A3octSCJZM=oz4q+DC=bA@mail.gmail.com>
 <CAL+tcoAHBSDLTNobA1MJ2itLja1xnWwmejDioPBQJh83oma55Q@mail.gmail.com>
 <CAL+tcoDnFCWpFvkjs=7r2C2L_1Fb_8X2J9S0pDNV1KfJKsFo+Q@mail.gmail.com>
 <CANn89iLNnXEnaAY8xMQR6zeJPTd6ZxnJWo3vHE4d7oe9uXRMUg@mail.gmail.com> <CAKD1Yr2rqFdtCNmvacEvd_DR3nGVo8+7+sbGPU=g6Gr45T9TQQ@mail.gmail.com>
In-Reply-To: <CAKD1Yr2rqFdtCNmvacEvd_DR3nGVo8+7+sbGPU=g6Gr45T9TQQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 14 Aug 2024 12:56:29 +0800
Message-ID: <CAL+tcoBjoz3SLBJDDYmet4F6iBybkj3Up18ckTD8tsH0J1HO_g@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix forever orphan socket caused by tcp_abort
To: Lorenzo Colitti <lorenzo@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Xueming Feng <kuro@kuroa.me>, 
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 12:43=E2=80=AFPM Lorenzo Colitti <lorenzo@google.co=
m> wrote:
>
> On Mon, Aug 5, 2024 at 4:23=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> > > Each time we call inet_csk_destroy_sock(), we must make sure we've
> > > already set the state to TCP_CLOSE. Based on this, I think we can use
> > > this as an indicator to avoid calling twice to destroy the socket.
> >
> > I do not think this will work.
> >
> > With this patch, a listener socket will not get an error notification.
> >
> > Ideally we need tests for this seldom used feature.
>
> FWIW there is a fair amount of test coverage here:
>
> https://cs.android.com/android/platform/superproject/main/+/main:kernel/t=
ests/net/test/sock_diag_test.py
>
> though unfortunately they don't pass on unmodified kernels (I didn't
> look into why - maybe Maciej knows). I ran the tests on the "v2-ish
> patch" and they all passed except for a test that expects that
> SOCK_DESTROY on a FIN_WAIT1 socket does nothing. That seems OK because
> it's the thing your patch is trying to fix.
>
> Just to confirm - it's OK to send a RST on a connection that's already
> in FIN_WAIT1 state? Is that allowed by the RFC?

I think so. Please take a look at the following link which tells us
whether we should send an RST:

ABORT Call

    ESTABLISHED STATE
    FIN-WAIT-1 STATE
    FIN-WAIT-2 STATE
    CLOSE-WAIT STATE

      Send a reset segment:

        <SEQ=3DSND.NXT><CTL=3DRST>

      All queued SENDs and RECEIVEs should be given "connection reset"
      notification; all segments queued for transmission (except for the
      RST formed above) or retransmission should be flushed, delete the
      TCB, enter CLOSED state, and return.

https://www.ietf.org/rfc/rfc793.txt#:~:text=3DSpecification%0A%20%20%20%20%=
20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%=
20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%=
20%20%20%20%20%20%20%20ABORT%20Call-,ABORT%20Call,-CLOSED%20STATE%20(i

Thanks,
Jason


Return-Path: <netdev+bounces-188993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 780B4AAFCAD
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFA41BA0AF8
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9748626C387;
	Thu,  8 May 2025 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+ANReHk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1508526B951
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713818; cv=none; b=RIBqT4w8u3VBeGu/LYAox3riE3mTSpd9dgdKZk0fFrB7W3peZMxA7qc9gJnLAgucLfuNv+ze5Q8q3AcflWIvg/DBGvkC2jnQgqsiAuEIjVrduNYw+xiy8ynDQnPWm6ppzOfj7uWB+v5mQqc04AC0MGGGsLlmqw+hV+gMCJvV5OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713818; c=relaxed/simple;
	bh=DRMa6ZXfsFzsK8CmelZ/LH/nxafL6owWCyPlZ+Gf/0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saheZbekH377AmurMQ478O7evCNoJA4tOdUJI+CNA0votQNZNr9tdVOf1m0KA1foSDEg9kSKQQjBg5zdTBoKoBauff9p+CUY5AGkeGaXRUercD/snGEGl2ZyC+F/xucpriMYewv9EGU277DXFFBaah+MG6eV92c5ksOIegf2sj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+ANReHk; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d81ca1d436so8083445ab.2
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 07:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746713816; x=1747318616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxrINe+dKCYR7ske9GiKvtihxfkQnfkQF4jb4kQthtA=;
        b=T+ANReHk9deB8WyPK85lWw5w4sTbSDxHgA73qTibOOLqlQN/jXdlU/uDLYEsSmtD7G
         3/T2i4iKN1BYgVeXCmrddnVRfffU5Oi6Yow+iA+qfMwZ2lH1Kk87azm6PNfNB5nMAQev
         8iZJFfwsJtt1G/m5bFyt3ErAJVH0QT6U6frer+eETzpIF7qgQ9HxoGlh1ADEGbebzzA4
         LTyjOVkBY/i20H3SLXd4mCEGi7dDAh8iI0YGqiLUIARmnQNdHO+gudtPm+AXSY+OPxCO
         A901gxBLzfggA86BmUCD9TNS6hTIjEUWm76TX+019eIU0bTT949IFFyZMI1ohr71OGPv
         q3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746713816; x=1747318616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxrINe+dKCYR7ske9GiKvtihxfkQnfkQF4jb4kQthtA=;
        b=B3W1f6kgtFHvLMkVDK+O/ZGhQpLPDoo2mqNyljjALjKBAPrzAp1+c2p+EXwMHFbCLR
         JsAlBgg5XZoaN9L42RXM/VbraavzlHmQvGqB4iQVEtoFwfv/LEAD18K2GPUem0yyvtFS
         DMuH+DZY4yBlxhkZrfmO1zZYdBlHGaatnJYUQDLnJQHAI8m/JJBFHqXojpAqmImrrVMT
         extK/PkVMfLsT7plbR1TP8FKuTpSnH9qycq130SNUXyTa+8KqeU2cY1L1TrI0SQONZVY
         BhlEFvsZqjhmm732/WUaMNXU/cMog5kySjTs2Zp1zz7tY6/d/7k6G4TFI5oW+Od7AkuO
         4SPw==
X-Forwarded-Encrypted: i=1; AJvYcCWkVqb1JIXNDip6bpYbpcsyBFp2UFWxVYuMxKyqFmy+UCYJIP7kBUoyA0JQXHQZeOBvIkdZA3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHT28zytTiUaGA3sN62b1VRVgiIqJjDHgsRxU4S4vsSZQSOXyL
	NUTvUVwG5M4zEa/b5628x3sYXfL7+7HQCXr3e/bVfaHKbXVi4JivUcFTN3Jd71H3LL5o85Nya1R
	bl+NQyf7j9hAor6UCZ0arFJtCWaU=
X-Gm-Gg: ASbGnct9wzhLs5Tj6cttzwrqjEIWu13dla9sOq670az00A5VCxJvDRfSpJpAlOUSkuf
	ZDeJun9tFbEI4/7S+DCVA4f/GXrkwTVAsiLoKLQBqYqFE7Vr585qJr2/nHBJyN8mW1ObKsLK6PD
	PV404VtbYmth5rnbVOdJVK
X-Google-Smtp-Source: AGHT+IGrmOWgSe9l71yWvuYjU8jpdPBXknaS0To8ptak9Rrr9Vr+gtzt2anfn7hR6oedXJfs2ADhScpzAwwWsA79JAE=
X-Received: by 2002:a05:6e02:12ef:b0:3d9:6cb5:3be4 with SMTP id
 e9e14a558f8ab-3da7392c8d3mr84631925ab.15.1746713815999; Thu, 08 May 2025
 07:16:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508033328.12507-1-kerneljasonxing@gmail.com>
 <20250508033328.12507-5-kerneljasonxing@gmail.com> <20250508070700.m3bufh2q4v4llbfx@DEN-DL-M31836.microchip.com>
 <CAL+tcoCuvxfQUbzjSfk+7vPWLEqQgVK8muqkOQe+N6jQQwXfUw@mail.gmail.com>
 <20250508094156.kbegdd5vianotsrr@DEN-DL-M31836.microchip.com>
 <CAL+tcoBrB05QSTQjcCS7=W3GRTC5MeGoKv=inxtQHPvmYcmVyA@mail.gmail.com> <20250508124047.xyhrabkxsbhceujv@skbuf>
In-Reply-To: <20250508124047.xyhrabkxsbhceujv@skbuf>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 8 May 2025 22:16:19 +0800
X-Gm-Features: ATxdqUHTW_wHKCu6h5UnYiYBYEyS8_AYth_zQEjqWBotHa24eVPMHnpGl2Y6Vp0
Message-ID: <CAL+tcoBq_-COOvjk53oO1w=ReWQzMivAmQPF4F20vAF_Bd7sCg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 4/4] net: lan966x: generate software timestamp
 just before the doorbell
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>, irusskikh@marvell.com, 
	andrew+netdev@lunn.ch, bharat@chelsio.com, ayush.sawal@chelsio.com, 
	UNGLinuxDriver@microchip.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sgoutham@marvell.com, 
	willemb@google.com, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 8:40=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com> =
wrote:
>
> On Thu, May 08, 2025 at 08:22:39PM +0800, Jason Xing wrote:
> > Thanks for the kind reply.
> >
> > It looks like how to detect depends on how the bpf prog is written?
> > Mostly depends on how the writer handles this data part. Even though
> > we don't guarantee on how to ask users/admins to write/adjust their
> > bpf codes, it's not that convenient for them if this patch is applied,
> > to be frank. I'm not pushing you to accept this patch, just curious on
> > "how and why". Now I can guess why you're opposed to it....
>
> The BPF program is not user-generated, it is run in the context of the
> function you're moving.
>
> skb_tx_timestamp()
> -> skb_clone_tx_timestamp()
>    -> classify()
>       -> ptp_classify_raw()
>          -> bpf_prog_run(ptp_insns, skb)

Right, I'll drop this patch from the series then.

Thanks,
Jason


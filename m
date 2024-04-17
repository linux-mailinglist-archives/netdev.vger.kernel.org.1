Return-Path: <netdev+bounces-88688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0985E8A83E1
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 15:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BD51C21C61
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 13:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B222B13D265;
	Wed, 17 Apr 2024 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2WKLze0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4D13BAFB
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359502; cv=none; b=XHrayg8wT45y8mIThu5i1hLvpcn4H3X8IA1MkqGAJNnJhyEVy9MohrtbyLq2KVPpLHYUl3+h3nHnsftx7VEcpBpGbBKKCgNBFNvTEV5/lcUB+Dc8t2XrmPzQYM4FjiD61TrifaaQHvizLFwov3t5G1/ri/iltedi4fqmW53ydNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359502; c=relaxed/simple;
	bh=LYORuVqltCDSqq5LG+GR90BK8ZH+Tqmy7hq+uuME5Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1Le5WA+W67qP72ZZx9NGIwyz1jLCrA1xxdNHcMEThdCtBaN08eeaoTBxi/GTOMt797TFM1dlSY6MV1l+wS0rO7ML/7f3QJbd4tf/2Bf+kwQMn/l5KF8+yROPXOKsiamFv0TJodSHR5Z1fL6ci2iUNOH9D2d6GP+Mj5Fmn0wAsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u2WKLze0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so9189a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713359498; x=1713964298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYORuVqltCDSqq5LG+GR90BK8ZH+Tqmy7hq+uuME5Hc=;
        b=u2WKLze0KsX0YVOx0gg9XsSbKqAy9u04N6ERpw0W8+L1Ohuxp92uU7dCjpYRRnCteu
         /GZNQaWC49hWzX49LqeN9yCeT9xsyeRtfD2qmSpJin5NSnDogQsULhA3P3e16HqNDvDW
         TzyVP9wAY2Q+Ugg6LzFRPoERQnziNewDowtqoVb6aNF2YqHaSZELeTfKSLVRGemSPzZ6
         iJgEoOcI1VKNZy0hdduD4qwRsKaxyk7eYoghW5LB0/WMC5JXiOV52X86rpNm514JqsIu
         IF5h3Q0jZT0X1ob84Kd3fXolqZiXfXcRwEY5Z5bWAHmDO55BDt9zcMbENUuNvjeAotzI
         Bk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713359498; x=1713964298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYORuVqltCDSqq5LG+GR90BK8ZH+Tqmy7hq+uuME5Hc=;
        b=IqTzFJlt/OxvW/fjwX+6a0tO4JAPmrmYwdcxUdeIV89SkaDrXAgxW3+WwzhF4DGRx+
         QUid68GzE561Am14NBtrOkI2W7F+os2V+CIf17IY856Eoc3Qy0po4j75wAqx1iz4nI4Y
         jGeOjJrl+5k3Ie1lepCMsdcOGu0IqQlxKa9L+2hRN9x97hw/X5b0yHTsXYSufLO6vjZO
         X11+Y5d6dcjGuAi9+ecWOJNJxQNbOvdJlCIC2SzfdhbH2/s0Kf3YwTDe/USCMRqxguB/
         87jtdPmqw0MOGmfRCPBqums+qGVjHkRvabRig0lkasV2v7KRRAo1pzDrjVU4FfJTgBYk
         3huA==
X-Forwarded-Encrypted: i=1; AJvYcCXrBAiau6JWotvMyaZY2k1tcdaJ8uzrR0q4BbnlUP3nEw0etDpO45Pr8mTxezll5RI9K3U51G0P3Hx/OfcNHGI2xBxtRHo/
X-Gm-Message-State: AOJu0Yx5pCG7rg4y7rPMW/vgesqs6D0pvuUFBdnlRHLsRHowXAyhyhR5
	RNfxo4bgx7pzrHZGzFPSHl9IHQsbGRyUWmBTL+E8hkQNjelgnm0jQppR3kC102MjPpfdloYZ0XE
	SFrzb7qC9m1Lc3LZ3GEtPcxTHwiE7sNitoL3pJZxUxT9DVN/AxwnU
X-Google-Smtp-Source: AGHT+IGypSaqPmVW4Vt+ptnrzFfjZDefxB3JQBi1r8flFTPfvlkbsiJVAOcbLm1miOgRjzZRGxqzK0j1VbLpU+0lwUs=
X-Received: by 2002:a50:ee0c:0:b0:570:49c3:7d3e with SMTP id
 g12-20020a50ee0c000000b0057049c37d3emr152170eds.1.1713359497802; Wed, 17 Apr
 2024 06:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417124622.35333-1-lulie@linux.alibaba.com>
In-Reply-To: <20240417124622.35333-1-lulie@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 15:11:26 +0200
Message-ID: <CANn89iLWMhAOq0R7N3utrXdro_zTmp=9cs8a7_eviNcTK-_5+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add sacked flag in BPF_SOCK_OPS_RETRANS_CB
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, dsahern@kernel.org, 
	laoar.shao@gmail.com, xuanzhuo@linux.alibaba.com, fred.cc@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 2:46=E2=80=AFPM Philo Lu <lulie@linux.alibaba.com> =
wrote:
>
> Add TCP_SKB_CB(skb)->sacked as the 4th arg of sockops passed to bpf
> program. Then we can get the retransmission efficiency by counting skbs
> w/ and w/o TCPCB_EVER_RETRANS mark. And for this purpose, sacked
> updating is moved after the BPF_SOCK_OPS_RETRANS_CB hook.
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>

This might be a naive question, but how the bpf program know what is the me=
aning
of each bit ?

Are they exposed already, and how future changes in TCP stack could
break old bpf programs ?

#define TCPCB_SACKED_ACKED 0x01 /* SKB ACK'd by a SACK block */
#define TCPCB_SACKED_RETRANS 0x02 /* SKB retransmitted */
#define TCPCB_LOST 0x04 /* SKB is lost */
#define TCPCB_TAGBITS 0x07 /* All tag bits */
#define TCPCB_REPAIRED 0x10 /* SKB repaired (no skb_mstamp_ns) */
#define TCPCB_EVER_RETRANS 0x80 /* Ever retransmitted frame */
#define TCPCB_RETRANS (TCPCB_SACKED_RETRANS|TCPCB_EVER_RETRANS| \
TCPCB_REPAIRED)


Return-Path: <netdev+bounces-210838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00505B150C9
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 18:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E1B3BDBB3
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EBD2980B2;
	Tue, 29 Jul 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nc+heFU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37825153BD9
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804961; cv=none; b=WzBaxhRp+elNju2OHeLvSmydDpJQE/c22o/HZXjO9Uk9oDNlNmjaCN9cvjlYkyJU8bQk1ouGcw3sYC9Bf11mQGaDEiKy7WOfQUu2jQasm8RjIQb20ISJYReJsxDHI+W4haOAHFIcGLr3vsNhdGcz9MPCCUXegv2suZl+SZsUfzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804961; c=relaxed/simple;
	bh=ztVlmoHg/WR34918FmaRTygu0KaZzKfql6qzplA3G18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIyBHbtEY/8NoPWSi1NEn5AlhAM3tz13OgJGhthM/VEio5/GyJH1xaagfPZabhwC83gAyEitm21CNL5OTpb/JuU8/5FrMPVCHSdgac4KzFxRu5zwU/tEBEYNfqwbgfu8LA0o7p9fs7Idzc3kDnf2PVgP3Derwvaic6+BjzYvuMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nc+heFU; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73e65c09828so2658702a34.3
        for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753804959; x=1754409759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztVlmoHg/WR34918FmaRTygu0KaZzKfql6qzplA3G18=;
        b=2nc+heFUMcoNHRZGcohiLf1gnzy2ehJnLR1TWF5twwNx9zBu4sri7qf7oAQwCYzkvL
         AI4P5xKLjQPGIsjJhmgPhchjMS9djHkn/Wc4W2ppD9CbM+J1Rm4FuWl922YTbYjDuDBO
         mOsHmy0o9nmGCi3OGdNqXmbdQO3U+SjkDtYRPP7ctJ2zZIkuAAzu302u+/dYnv65DjKe
         1p+Qt6Z7Egwo4YUGQBPpu3CiIuwgPK6Y9/dOfH8xnNzu1nc3Zl4DgriZ0AAOBYVHHhiw
         5X8wpgw3c8ORvq76Z5Y/AFTSsjHaT9/K3kLFUpilVNRZQBIZV6DJqycmIktdBaXvogmb
         HXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753804959; x=1754409759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztVlmoHg/WR34918FmaRTygu0KaZzKfql6qzplA3G18=;
        b=FPC9aSNSd90XD1nqUpDPzUthLVd8RvnXEOOjTG1WrCMAAmDAAmdyHYHK8U2YTWIsnb
         I+JVQQS0JlcnLszGFdfojpPJPgsAjdJOTeB2m89G+b/7HwBGP1YPNcqD6GClkbOo69l4
         G2mbE/wwPhf11+JEfxZCshXezpnRclQEGdi5DF6Ir8xP2b7F21WMfcKQ7fvkY8ddtEYg
         mDW1J5IGZfpl3fdc6vMMimTPdPteuo3LsoZMVH+9p91pPhg2MpOwe3/FedQgk9eQOvvr
         j1MVsGeK0bSkATU8/U2Q05+G1zD5YaZhEoEoPwJB7ooYdWcWE3+PNADOPI5k+L9c+WYS
         wSxg==
X-Gm-Message-State: AOJu0Ywui3JyuuXpJnSD0d+zeJRNETEjJDhKRYqVeoqJ+pFzezGHVB3W
	Be7uT1JiOhizqAQsizG9vTX19qKniQWWmipBZJ+RSpteRi6YZRRy6SNQmQ9TexZjQJ10Nd6r7qD
	sZUNFU2CO79+4y05/QUVcGcWDyG+ADD2SXIY321f5
X-Gm-Gg: ASbGncvjHAEzTOeIGCPYt5jLsk5rvVZv0rlJvdkgpvELFmu+O692Nvs8ti/3WZheUr1
	P/IHH9jf9Iec7sA4UgFm4rFAviX1/lSSzwXD/eaIHyWffKIfzaPd/Hev4+dHV+yiXk0HVRh+uMj
	GdB/7pzTYjeTrrbR2xXjcnBqtFagg/kiX6LZBRlfNnO0PzD+fj2e4nYt+oEoarBjNPkPrVakYgE
	lkCoA==
X-Google-Smtp-Source: AGHT+IFtDaagUGc57GHBurJ0UGpZR3EwjNZqGule8Cnk2sgfeLM0OC6t6k4vR+xjhntyTC578HmcKgNJF9PLaUrfbsE=
X-Received: by 2002:a05:6830:6506:b0:73e:5def:537 with SMTP id
 46e09a7af769-74177cfee78mr255833a34.21.1753804958964; Tue, 29 Jul 2025
 09:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFQ-Uc_5nAo6ymVkCda5+_y+bT=GngFibankmfdL8_Mu-4cqfQ@mail.gmail.com>
In-Reply-To: <CAFQ-Uc_5nAo6ymVkCda5+_y+bT=GngFibankmfdL8_Mu-4cqfQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Jul 2025 09:02:27 -0700
X-Gm-Features: Ac12FXxuKmliLvuMm-O1HFYoHQCpE86vZdzri5w96Q7QVoJYt6RQh4GzE_NbA_0
Message-ID: <CANn89iJNKR8uBNrRCdqs-M6RspvgSK9+vxzfvXe3xUvDT538Lw@mail.gmail.com>
Subject: Re: [PATCH v2 net] net/sched: mqprio: fix stack out-of-bounds write
 in tc entry parsing
To: maher azz <maherazz04@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, jiri@resnulli.us, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	Simon Horman <horms@kernel.org>, Ferenc Fejes <fejes@inf.elte.hu>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 8:36=E2=80=AFAM maher azz <maherazz04@gmail.com> wr=
ote:
>
> From: Maher Azzouzi <maherazz04@gmail.com>
>
> TCA_MQPRIO_TC_ENTRY_INDEX is validated using
> NLA_POLICY_MAX(NLA_U32, TC_QOPT_MAX_QUEUE), which allows the value
> TC_QOPT_MAX_QUEUE (16). This leads to a 4-byte out-of-bounds stack write =
in
> the fp[] array, which only has room for 16 elements (0=E2=80=9315).
>
> Fix this by changing the policy to allow only up to TC_QOPT_MAX_QUEUE - 1=
.
>
> Fixes: f62af20bed2d ("net/sched: mqprio: allow per-TC user input of FP ad=
minStatus")
>
> Signed-off-by: Maher Azzouzi <maherazz04@gmail.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>


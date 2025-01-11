Return-Path: <netdev+bounces-157412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C6A0A402
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E022E18883D2
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E525E1AAE0B;
	Sat, 11 Jan 2025 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="n4taJA2g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D92B661
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 13:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736603895; cv=none; b=Q5vMS3FMk+BYcMv4eHRuLiNAWScWVoBTYNHoLVBAGCOpEVkRkGHgAsOQBir4z+t8JvtxKyK0ePGpx8lTmJwLDdkYzgn09OVatfg1WWfWGyt9Ktuw3AgKocRTiKF+sq9ClXh+UFNBlnFFl/XoR07q547M4s+3EUwW3ddrTyrEdL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736603895; c=relaxed/simple;
	bh=Pxj0JY+4TWkMrYHAnkz+04q3TquoKu1Fv9b1pHvWbxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AinVpGMtR5BIF+GBv2W3ePIkSGe9aUT8cn7lp5P5eXzYTO9JRz10yBErtpkApWWucGhwVQRmy74Zz5NT/GG0nDYgLcfIpM7HF8kfAXKhINPwKpd5tQDrZGgOJwixeHtA4rynMLzFpf+bDQiIasMVd8ztq3EfFnWNNYKddVrjPlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=n4taJA2g; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2efb17478adso4811087a91.1
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 05:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1736603893; x=1737208693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aT+omxfKwZcdzg4T27AOZbTirML1HsS2Rxlav83Gjg=;
        b=n4taJA2gsAi8QeDJd8g97W/2g6qYo3L6DEGN2rgQk4Fl4M2yKXJSf3uctxnCT213DG
         LbX8ueCMK3ViJajhXoFRT3TV8POxt4/hICd45jiDH6JrYHVjeyfCy89gMqZZERLXJvTl
         jxn71ODIvdU+GObZOfe3Mk5iZw2oWBuxxYu6SxziD89KgK4uwDIOadzxbZ536KwLL4/0
         DSI2mbj5Jb+Yw9YjaKN3mRypBIphjH6wbqrs1ZZpsYzKWidRD/zXnA70t1TjaFVYOxmJ
         oTfSe2QVwdOcqK7ULg0SDrB4mGn3Ojj4WH9saMch3vJrVgs4KfzksdaTa5z5PP85hkCo
         FtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736603893; x=1737208693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aT+omxfKwZcdzg4T27AOZbTirML1HsS2Rxlav83Gjg=;
        b=sST6Eu5neypzA3CHqzYARmFFzH/jSwAFok7z6aGAQQbLv1zhVyqk1L6pqt/r4MpeK/
         RWIpm44+EuUDO5QdB2PtP6iyczuYAWQ4Hh8aGJxq8ID/jdlsgyJIp2+CZux6VzZlbq/O
         Ljt9I+HhzhU9RJqe5zW9Xfc/VCdUTdCYBiiQUq6WcSilx3o49kS7ROv9NRRqiJ/RoWvH
         yQ0sXE8doYaxBHtRVoXfX/UJA7Am76VGveYam1GPlpwr7gZAId+5CuZF5L7Kq9CpPZ5A
         d5JTAbAp6p43/3F0K07Gyyr2tmcbrsAmItGjWtZ71p6sPXuPDs8kg+MlIu6/zxCZXw2q
         +3lA==
X-Gm-Message-State: AOJu0YyZSsdqltj758VuNeIta5L1+lkH44RCqezDZ7z38+IWHfHIFnml
	bjHZiiizMwgARhcs6K/v5nqzjTtDb9IcVREYiiKM6DTtujUHc4hpfE0HEZmR8aq2XVLJDCPg7sE
	d6pwZrHim3Ul8+vWhJ3e9zq0qFSfWGovAfWpaiXsqxCuvDII=
X-Gm-Gg: ASbGncs7D8l9wO9EXcSO199jNBpqD2J1GaivOGjFd/y/KU0exIIyZaYOsb8FgHryPJ2
	t9Hbtc0JJmcumpuE/Sz5BfD1wKk95ECowm1nU
X-Google-Smtp-Source: AGHT+IGvIG2MpPVN4dYt5DH0OHhiu9aLjEhBaiyn42V+1hGGQ9VTbPqGqhkr6Ca9IFEy1IwS0o+vjK2adjCSkxbvUCs=
X-Received: by 2002:a17:90b:51cb:b0:2ee:863e:9fff with SMTP id
 98e67ed59e1d1-2f548f2a4afmr22043662a91.10.1736603893147; Sat, 11 Jan 2025
 05:58:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111132626.54018-1-jhs@mojatatu.com>
In-Reply-To: <20250111132626.54018-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 11 Jan 2025 08:58:02 -0500
X-Gm-Features: AbW1kvYnD4KYstQwx8An7GyCongbn1vtT-buCmNZOPYwUhV9kelXEJe_QBRsxCQ
Message-ID: <CAM0EoMnhsZRRXs1woTRYCeWBEYrR_Ffs8yUfVjg8uoXvLmkvWg@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net: sched: fix ets qdisc OOB Indexing
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, petrm@mellanox.com, security@kernel.org, 
	g1042620637@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 11, 2025 at 8:26=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Haowei Yan <g1042620637@gmail.com> found that ets_class_from_arg() can
> index an Out-Of-Bound class in ets_class_from_arg() when passed clid of
> 0. The overflow may cause local privilege escalation.
>

> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index f80bc05d4c5a..c640f915411f 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c
> @@ -91,6 +91,8 @@ ets_class_from_arg(struct Qdisc *sch, unsigned long arg=
)
>  {
>         struct ets_sched *q =3D qdisc_priv(sch);
>
> +       if (arg =3D=3D 0 || arg >=3D TCQ_ETS_MAX_BANDS)
> +               return NULL;
>         return &q->classes[arg - 1];
>  }
>

Please ignore this - need to test more conditions. I will send v3

cheers,
jamal


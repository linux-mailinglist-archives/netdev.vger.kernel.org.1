Return-Path: <netdev+bounces-90326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DAB8ADBCF
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 04:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BC0B2148B
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 02:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B1117571;
	Tue, 23 Apr 2024 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0mDFRSl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41512B95;
	Tue, 23 Apr 2024 02:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713838520; cv=none; b=TGXw+aqbKn0nR/ustkYibTbfgoXltmWPBR/a+db0QxZJ7vNNqYBEoS9thWzd/7iSgCROFov6IGTwJ8manRb44io5Kx4sLKf/iHjHpau1slY7g/BjLdSHLpybQw7YrH640pcI+gmA2UJp8QO5lgm+FuRSWU1BP+qHvU0f/fxsO/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713838520; c=relaxed/simple;
	bh=GuYXJcFYNRLFxboJdCmbLjGSwgY45IyHwUaLxLSfj2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meTrLbT07aMvnaSl1HMClE0uhcW28tiE66vN+Y9OdbdI5A8G9W5P7he7vrDik/PZySG7IE+HuO2us4SAWkOu1EMH+o47qRcqB6PAeSUWDPe2m9u3Y9fLBRe4UkhXLiRuugWzOHGwItW6s3FHB8mDyBIo4iaMHGYi20qyT65sK3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0mDFRSl; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572229f196bso32506a12.0;
        Mon, 22 Apr 2024 19:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713838517; x=1714443317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3o8Gg1Q80DB5SQLoW+dy2JUtrw4tmu4mL6vo9DJdVo=;
        b=O0mDFRSl2Ci09r9PDKKPqDHznf5Vp+z6GZ8UqvqFN8oz6Fj86d06DSm725vw56vlZl
         CIr4KLbkc5iGQhUZhaX8y/nWNQLfQDeHslgmh7LYoqqyjk8e8qzb6V/d3ouzSt3+nAYI
         A/ty/cnJWDpyhPm5Bi/Jrc1fdaPPweHjzZPTYc9xEyTwbBM6pa2zwmVoeJ2oFOFeualq
         TGrQaGbsM67zeLGQ4vUtMIGV9PTKaQS67TOqDliYGLGD7o8n0khtHaLaQCJaEz2CYAlF
         LqdOZ5etGpL+0/uqlW0OlekDSbAKxdezzeyR84+REv3nWNm5M9vZPig4/eEc9ZfATHC/
         5bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713838517; x=1714443317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3o8Gg1Q80DB5SQLoW+dy2JUtrw4tmu4mL6vo9DJdVo=;
        b=ZPloCSi1SqvtjF0qzwZUYMn/dwsxjLA5+xQzVgrKTE4h0O35jzpmwGiD+y1zliL6za
         qJ+gw5AJzzV5XQI47Za+9GReF4maCJ2o8kXui1fvsm2n2j4w2XKZd8F93jQ7IhAcSI9u
         Nax7640x/NQFKNCAe4C961GCxjShkCdxCg1NHsfGnzjV64MOUt/jziRNwxhl+QUbrVPz
         F9S0PoiICyGRTghPOXlPvtYnVf5E9tXQIfLxXsKdiZKIZ1RVdioI2N02+3iPpEzYgczu
         Th/i9TQSmaqO0fH/YUxZ9RV5ztAzzXl2q9oB3W+VpZj4vlM/g5ZR6qfz4NRoDErRqqTx
         yYKA==
X-Forwarded-Encrypted: i=1; AJvYcCUDkkZ2LRSPBQIQ3eL8WeYkBlsail82ECj48UwOE9nfdOIf2xF+aZjw6YAeoOnzaPrM2sAt9q+Z68ZiGb2iPkZpsWj3nRNO2sWAKoewZ1f6St2MEk9s9JJ+fCIJxAlh3luwnRAA4yKb9yET
X-Gm-Message-State: AOJu0YxlCyvO/Mc89BmianTsa30TLbLbOfIzyiPMzEVMy5SYU5A/BDBr
	kGHnUwZ3DZ9iYGh91+l1QVPgDNGwENmqAJklXFr2muY3c8IrO21E7hRmRUmSkLBKrUW/mHwYbkp
	9htnKSRuKHIgeL7dQdVyuwtfmxWk=
X-Google-Smtp-Source: AGHT+IEd/Bc/4e7Z9aJEomVzHjZQOX75mT5jm5Rrv5h9ArpasEnG2N7f8PckvsdGtNymaWGo4SGqrgGWC8NxoqopVhk=
X-Received: by 2002:a17:906:f901:b0:a55:5620:675c with SMTP id
 lc1-20020a170906f90100b00a555620675cmr7438444ejb.34.1713838516875; Mon, 22
 Apr 2024 19:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
 <20240422030109.12891-2-kerneljasonxing@gmail.com> <20240422182755.GD42092@kernel.org>
In-Reply-To: <20240422182755.GD42092@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Apr 2024 10:14:40 +0800
Message-ID: <CAL+tcoBKF0Koy37eakaYaafKgoJjeMMwkLBdJXTc_86EQnjOSw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/7] net: introduce rstreason to detect why
 the RST is sent
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Tue, Apr 23, 2024 at 2:28=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Apr 22, 2024 at 11:01:03AM +0800, Jason Xing wrote:
>
> ...
>
> > diff --git a/include/net/rstreason.h b/include/net/rstreason.h
>
> ...
>
> > +/**
> > + * There are three parts in order:
> > + * 1) reset reason in MPTCP: only for MPTCP use
> > + * 2) skb drop reason: relying on drop reasons for such as passive res=
et
> > + * 3) independent reset reason: such as active reset reasons
> > + */
>
> Hi Jason,
>
> A minor nit from my side.
>
> '/**' denotes the beginning of a Kernel doc,
> but other than that, this comment is not a Kernel doc.
>
> FWIIW, I would suggest providing a proper Kernel doc for enum sk_rst_reas=
on.
> But another option would be to simply make this a normal comment,
> starting with "/* There are"

Thanks Simon. I'm trying to use the kdoc way to make it right :)

How about this one:
/**
 * enum sk_rst_reason - the reasons of socket reset
 *
 * The reason of skb drop, which is used in DCCP/TCP/MPTCP protocols.
 *
 * There are three parts in order:
 * 1) skb drop reasons: relying on drop reasons for such as passive
reset
 * 2) independent reset reasons: such as active reset reasons
 * 3) reset reasons in MPTCP: only for MPTCP use
 */
?

I chose to mimic what enum skb_drop_reason does in the
include/net/dropreason-core.h file.

> +enum sk_rst_reason {
> +       /**
> +        * Copy from include/uapi/linux/mptcp.h.
> +        * These reset fields will not be changed since they adhere to
> +        * RFC 8684. So do not touch them. I'm going to list each definit=
ion
> +        * of them respectively.
> +        */

Thanks to you, I found another similar point where I smell something
wrong as in the above code. I'm going to replace '/**' with '/*' since
it's only a comment, not a kdoc.

Thanks,
Jason


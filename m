Return-Path: <netdev+bounces-77088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABB6870266
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 14:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB381F207CF
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 13:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8DA3D3A8;
	Mon,  4 Mar 2024 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ysXUBrH0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F8938DEA
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558086; cv=none; b=JqD/ew2lLCMSdzje9FZzU8efLO+z14PSUkEKjSp75c2ZTOpY0QfZYMyPP0mGnEElYrDt1go+zZRPrfqAPe8Cff6H3ClbbVboc2M+tw94V9/efywIl97hJy39pozMhW776KEjPRdLps55LyEl1zkSRDs+9qHPACNTPrhfF/Htu7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558086; c=relaxed/simple;
	bh=WiS8qWyaaK3tJD7Uq1b5M/q+bvZezVTEB3S5cj8t7uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYxaDTMbyiB4Nn8wSzrQ942FkxAMvjL6amEFug8jcN/zLkA4kYpo6oMl+lp3t23EoELfqUejwBD8QRp4qDHHDrzvnT2Kt/QCU62sip7UGYrMv1fLtUs+wRZNfnT3EKZCTAeLTiSWePKB8KBTJTrf1DY3lMYeMnjaCDD0AYRp4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ysXUBrH0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso25561a12.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 05:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709558083; x=1710162883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiS8qWyaaK3tJD7Uq1b5M/q+bvZezVTEB3S5cj8t7uw=;
        b=ysXUBrH0JLb0qOJ4DrHCeN0hXaZH7qF4VaZxMD7gsR8fYHLRxqtQuzYTkD6N4WbRcj
         D3cftCgAUImr5XZcI5Qt5gkaoTwcPyS0KwbXcCyfSGedlM6Q42f2KTpVOWsj9Fr/uZc7
         RtgVn3BmyAgQUypWAn08S8z0Lo5NHPP5Gv9HunedhWcsFIrhmjDMUj25D4udAsCFRFJe
         XaQ4pyE75PrPIsv8TydsK9Xoe+xgL9O9DYEsMTAlldxYwngjBq8PlNgwDIwB52oqMYAT
         q2Q9kfAjMo9LWqlCaXPs+PWnlbnvTqNHWBaDep7WK5gLsgLycCzEn6f5SkTxAszR7b8i
         Jd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709558083; x=1710162883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiS8qWyaaK3tJD7Uq1b5M/q+bvZezVTEB3S5cj8t7uw=;
        b=sw+WY7zT4cVcDAl5q4tSSwtNGjc1dG1X8vop6ceLLOe45zLpcnfSH9vhiUVJ2GTCMT
         KkOMsrOamdRevWDWdYJzStv93IHYNQPvzQ/r//odLoH6VoAXeIrVNvfuthuNN71PSuTr
         3oQ1fBTwZ7GLYoStkDO6NYrJA0TFvdydhZb/H+yLYJzffZPYWezgRrcRfXFq0AnV5b89
         Z26bb/UZApbaXZax7CTybtK2hmjjSIIdngEp3tXKT4uVA5xY4UyUFmKwpaXCLyIVsMT8
         GJ/HcdHkH4DTiBh/6yKYAmrciL3wak8wdzkQtLkMZ4VGA+hZYdvlSdDcZ5nDjKCdqt7p
         s3vg==
X-Forwarded-Encrypted: i=1; AJvYcCX7b/UxxsUWnGw4qLcwSJB0y7PL0dSD9vIFMlfWz5bXBH3XXdbN5kvjAHYN4LpAH0V91wIw+ndI2pox44iVoSA7hafAgs1V
X-Gm-Message-State: AOJu0YyKtMIYVRgS59/RvtoY0dh3g4I6px+vbN6C1aNuvAVBsR5UQR6R
	tfckL3n989dwStudPaAR6oq5lbA1r1wRpPuLIy//f5xTGzQp24oioUpxhDjkJkxIFoYQ71Xokcc
	FoL5QmaC2529vQLa6ZZUZ0d4kjWYMuqDKVBrd
X-Google-Smtp-Source: AGHT+IE0blQSiGxF2suW+oA+PNDAjjTN0pKIjIC5BPfeNsYQwt9oZTn9u1J6WcEVOZLNg4Jxvqn7YpZMfXR1ypjVlIM=
X-Received: by 2002:aa7:db58:0:b0:566:e8fc:8f83 with SMTP id
 n24-20020aa7db58000000b00566e8fc8f83mr284665edt.7.1709558082832; Mon, 04 Mar
 2024 05:14:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301193740.3436871-1-edumazet@google.com> <20240301193740.3436871-3-edumazet@google.com>
 <f8711f5c4d6dfae9d7f4bf64fdde15feaee56494.camel@redhat.com>
 <CANn89i+19QU3AX=9u+x51P0xxPt6sNj-GHUh85NF0gsBChEgvg@mail.gmail.com> <55cebf59-d366-4d41-a946-94320295f5c1@gmail.com>
In-Reply-To: <55cebf59-d366-4d41-a946-94320295f5c1@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Mar 2024 14:14:28 +0100
Message-ID: <CANn89i+atJ0BjQyP4f53jjBEGRaLhdYL=XZoHhT0LnSDEO0SmA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] net: gro: change skb_gro_network_header()
To: Richard Gobert <richardbgobert@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:04=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
.com> wrote:

> Overall looks like a great gain for GRO, less code for handling frag0 :)
>
> Could you please share how to measure a <10% gain in pps in a stable
> manner? While perf top is stable for me when testing CPU-bound tasks,
> netperf pps measurements between 2 physical machines generate ~5-7%
> noise when I try to measure.

The pps are measured without "perf top" running.
"sar -n DEV 5 5" , or other non intrusive monitoring tool.

Quite often, noise comes from NUMA hosts, because the NIC has direct
attachment to one of them.


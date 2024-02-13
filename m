Return-Path: <netdev+bounces-71145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B586852717
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1852869BF
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD3A539E;
	Tue, 13 Feb 2024 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eltLaDLK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2766110F5
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707789014; cv=none; b=r6UdP4tUtIQAyjgeP5oMjfat8doWU0ua3bQQxTisIl5mvldZdf6jdJ5GQUYPmKdgc+NCbx3ya/zKOb+3+ZiwvjCJeYi6X4BWrDwA3/IW2xwrlcQqmh10iO2L4x9WHeSzV2rJCAIU6UkpJX8EVNleU3jy65VJFPrGpGHqC3AW6zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707789014; c=relaxed/simple;
	bh=nxlqgeWyNotzcFo/TD0GVT5//vdHbBMzL/YDInmg7sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCosUXsiCpXrzJH0l3AOYKt3J18iTEdbFp65PpFYU+t7K6hbxBa7gviOqo9HHUghK4Hrj8B3Lxo0rim2YCsVTJ4SN01An5BF5VizM1WiYBJJU0+G6NMDSCDZoXa0F0ycTCt/i0ty3n1dQB3jfVcnHHlhnUGpiG4uViZYHnSgZc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eltLaDLK; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d107ae5288so1740641fa.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 17:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707789011; x=1708393811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRVeRWlxdIBbTQTQvj17eZhaH5rdniY82hPs6RT5xUY=;
        b=eltLaDLKZ/G0egdbUMiwn1V+QsWGVfHMp2WV2HJI/gNu1axb7J2CV5+I6QggxWMQ62
         b72JWwjIbRuebch3yNsqPxmiIRr9tJFiQGJ/MK6UHL9tpZR6AJpFX6ynnbCNeyVV3Wdc
         xy763wqjgXDvnfB9i0PP99gNul2E+LbT9hQ9zGAk2QqKp5RFb8nTTLLvFaooLSu73F7a
         +3Hz+SQF62JA9cZdI80tJencxy2S5s4tfdqTxJfHQSTIV5+uM1BvFlbUrBOmJIMi4HHB
         ZEHIRlfk5D8OR9yDEKwJQhYw4r9EAg6sdm0pZShdJvYD1omYDEs1VLYEfQ2umePDxeNl
         dblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707789011; x=1708393811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRVeRWlxdIBbTQTQvj17eZhaH5rdniY82hPs6RT5xUY=;
        b=nWDZdkffrYIaDVpnWeTtqebh/TYVnik4WKzOeBVGhFBXGfiekj8qU2nOJHxEOrzjgd
         Py/YzAfQ9gRGiffT5LyLZyUnmCzt4PPGj7sYU++CPKzHUnul0iNYPwDWPxi6Pz9/Aphk
         JtX7MO5c0iMw4spKMRT8WoPMYHpDrRYk9JeKxl6Wozq0xs0m3c3TDuLmkmKvwVcgvpnz
         YERCJDOUA5qd6zyByiP2bMHMyZOXTVQyh2UqbLprAYJ3p773+RNkt3O99b337S6qKHyO
         5N6nNQx6qzgB2rBx6S+QpWXnfPlI4pxPE12om4pBqIFs/AFin9mileAl/pWelxlVRQNE
         BrpA==
X-Forwarded-Encrypted: i=1; AJvYcCVtXF4VeYSDakxXwiqQSyNo4d349shYkhJFJsHwfLHaRx4voobmaJTtT2VXp7YQ6DLmXgY0VJ5yb0LY+9w39ja7jq/yqOQo
X-Gm-Message-State: AOJu0YwAytgmgkO+4KjYHYCyeC7ZFXQzE/J1Sukh/fWebpg25H9ZpgHl
	WfRO9dEwq35i9x8XQLhL0DelSDLzDJ31VzznoLX65KOlMF23J1WYhaC2jcnP2tvIdW42UNTVpTx
	8weoh0W72gWFGKNNDLxKydbtxm28=
X-Google-Smtp-Source: AGHT+IGidSom8yiZu6ynMMJxB1GFW5BuJUa4d+6pmGFad14+x93++LPQ155ynrdAafgVmcXgEdUCxwvr2eZ9mH2FXfU=
X-Received: by 2002:a2e:a265:0:b0:2d0:e2c2:cd97 with SMTP id
 k5-20020a2ea265000000b002d0e2c2cd97mr5216015ljm.36.1707789010891; Mon, 12 Feb
 2024 17:50:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212052513.37914-1-kerneljasonxing@gmail.com>
 <20240212052513.37914-2-kerneljasonxing@gmail.com> <20240212172302.3f95e454@kernel.org>
In-Reply-To: <20240212172302.3f95e454@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 Feb 2024 09:49:34 +0800
Message-ID: <CAL+tcoCuefqSwOE+PpupVbOASoD1v9y+r4pODK7+RNVjcEe=vA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/5] tcp: add dropreasons definitions and
 prepare for cookie check
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 9:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 12 Feb 2024 13:25:09 +0800 Jason Xing wrote:
> > +     /** @SKB_DROP_REASON_INVALIDDST: look-up dst entry error */
> > +     SKB_DROP_REASON_INVALID_DST,
>
> The name is misspelled in kdoc.

Thanks for correcting the error. I'll update it soon :)

Thanks,
Jason

> --
> pw-bot: cr


Return-Path: <netdev+bounces-94781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3578C0A59
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 06:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7C21C21DA5
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D67B1482EA;
	Thu,  9 May 2024 04:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ruZqvsCK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C750213CFB7
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 04:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715227900; cv=none; b=fIha9HBXTILCehuecc/qWk3fN71+y/7j7zmKhUsJeagr47WTN51j3rzHVhhpsaQmJ8azumakdj4+G0ooKapwdWAXPk1AnKG7rlrpiqou08J9qpDYFnO5kWgfcW2oHkIPXlrIt1k7/n80no/VP2B2g1t8iiMrzVt9/uNhP8yAFzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715227900; c=relaxed/simple;
	bh=EuD5rGws0oPE0xiAPheoEoxDAQyOqvEFoxH7b515VT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuOpg740PtuUYxT55lmHm0o7qkUbquO1MaxkPojaT/7wqu7MJ/m1jXc8Xws1oLrETL1H88Zgu2rh1O316pXSACvdpmi+CrgwXWepDWcpl5t+uGaFMo865tQqqD5fHNvANyl3VgUjB8S1kFWWYteZ66+z9oP4rzTrtQb4IqJyRFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ruZqvsCK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so455427b3a.2
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 21:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715227898; x=1715832698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BquM86FdyvTwrPBmMgArwClBgJHZfCecZ2xsyzp4mrw=;
        b=ruZqvsCKtYkD71cVib3ALNpeZZ8cim29EZ+2akNN0Aty4Y7tMceiuhGvuZ5AenT4r4
         PsW7nSht5KsJahYja+PKkwPcdLSLCnlwMU2n+cF2j57aD/P5dvJ5VSX47CvUjimhtXmi
         znq/rCDZyj75mI9Vr7CDIHagU9J5iPhIpaYFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715227898; x=1715832698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BquM86FdyvTwrPBmMgArwClBgJHZfCecZ2xsyzp4mrw=;
        b=JET/oHqEzYR+1bjf/6RRwRYB2u5APAEfeIVTPgNT8GrbLq3uVeV01jLiDZ1D3s+q/8
         t6KB8cIUOjclIBSBa6bys4zw2HGkZWXr+dCEAKCfA80yS4oCarLsTDfYIVPSqompqzA1
         gfhGAhsKLb19lUD1vFZBcZ054fZlGtUtE+D/KZIWxaG6beKTfAK4OfzkQPXBkAwVKaG+
         JHj2uFis3OmYst1EvuBmTZAZhgn7jKL1/r98/qfYh/rxlareNiMfyy/ersPyR09bhDR+
         nD+aUfAYOHL+JN5j0YGjxpm0a6vsBGzIRZJ4bKa5wa0z6vmZnLV89Gc6+OctWgoKtEyP
         9Mxg==
X-Forwarded-Encrypted: i=1; AJvYcCW0tCOlqBJS5sCdXNgpDFUwdRgbjnT+2ij8irWmLSWtod29DPUQXEG2hI4W6J2Fy0LpANUfh1pGnL63EroZ+RT0NH46logl
X-Gm-Message-State: AOJu0YwX86yw9v2F9rFMl0cN4XhnlYQxqbJUhEIS/ANl+UeMq70xquUl
	YS8nASB78yKzMhYnimcmnTgY2KPT2/gUHxs39bGl8nXim2+z16F4Q9VRENuVn/w=
X-Google-Smtp-Source: AGHT+IEeW5kcZzuh3q3xss0tmlvWIeShGXPqLqYpMy8O9b5kYA5qoS5aLHM33knk0PbdcH07cxN0OA==
X-Received: by 2002:a05:6a00:2d88:b0:6f3:ee9a:f38b with SMTP id d2e1a72fcca58-6f49c206b5bmr6352615b3a.6.1715227898075;
        Wed, 08 May 2024 21:11:38 -0700 (PDT)
Received: from ubuntu (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a86a2csm367073b3a.78.2024.05.08.21.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 21:11:37 -0700 (PDT)
Date: Thu, 9 May 2024 04:11:34 +0000
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, saeedm@nvidia.com, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <ZjxM9i1yFDRQ2f/s@ubuntu>
References: <ZjUwT_1SA9tF952c@LQ3V64L9R2>
 <20240503145808.4872fbb2@kernel.org>
 <ZjV5BG8JFGRBoKaz@LQ3V64L9R2>
 <20240503173429.10402325@kernel.org>
 <ZjkbpLRyZ9h0U01_@LQ3V64L9R2>
 <8678e62c-f33b-469c-ac6c-68a060273754@gmail.com>
 <ZjwJmKa6orPm9NHF@LQ3V64L9R2>
 <20240508175638.7b391b7b@kernel.org>
 <ZjwtoH1K1o0F5k+N@ubuntu>
 <20240508190839.16ec4003@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508190839.16ec4003@kernel.org>

On Wed, May 08, 2024 at 07:08:39PM -0700, Jakub Kicinski wrote:
> On Thu, 9 May 2024 01:57:52 +0000 Joe Damato wrote:
> > If I'm following that right and understanding mlx5 (two things I am
> > unlikely to do simultaneously), that sounds to me like:
> > 
> > - mlx5e_get_queue_stats_rx and mlx5e_get_queue_stats_tx check if i <
> >   priv->channels.params.num_channels (instead of priv->stats_nch),
> 
> Yes, tho, not sure whether the "if i < ...num_channels" is even
> necessary, as core already checks against real_num_rx_queues.

OK, I'll omit the i < ... check in the v2, then.

> >   and when
> >   summing mlx5e_sq_stats in the latter function, it's up to
> >   priv->channels.params.mqprio.num_tc instead of priv->max_opened_tc.
> > 
> > - mlx5e_get_base_stats accumulates and outputs stats for everything from
> >   priv->channels.params.num_channels to priv->stats_nch, and
> 
> I'm not sure num_channels gets set to 0 when device is down so possibly
> from "0 if down else ...num_channels" to stats_nch.

Yea, it looks like priv->channels.params.num_channels is untouched on
ndo_stop, but:

mlx5e_close (ndo_close)
  mlx5e_close_locked
    mlx5e_close_channels
      priv->channels->num = 0;

and on open priv->channels->num is restored from 0 to
priv->channels.params.num_channels.

So, priv->channels->num to priv->stats_nch would be, I think, the inactive
queues. I'll give it a try locally real quick.

> >   priv->channels.params.mqprio.num_tc to priv->max_opened_tc... which
> >   should cover the inactive queues, I think.
> > 
> > Just writing that all out to avoid hacking up the wrong thing for the v2
> > and to reduce overall noise on the list :)


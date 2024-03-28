Return-Path: <netdev+bounces-82836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 772C388FE58
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E25D3B23965
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 11:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7D756441;
	Thu, 28 Mar 2024 11:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zT58PkwV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBBC5380D
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711626529; cv=none; b=vCUCNe1PzrZ9sJdYlM2OqOf2gDhkMZUysRZkuYhHAvvOWKHTda4msBXYD5Ooqu0apmZPz7Iroyd3qoWQrutIKSPKfrCC00pjEDfCWPkjYZMX5JhPBP5COlzScEZSFGu0Qujpmz68a1f9DyEGDmv50XDIp9Z9LRxlC1t1gXR3gk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711626529; c=relaxed/simple;
	bh=fFWAM7aDWzcp6y6UIHXrKDrn/vPVbGKoJkanz0+nyYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSlLB14m3r445j38HMLKw3cWwBzzx2yzXSRVd1QD4KQ26g2XdPbCTRlii+uZuNnudkJtTOPHo3PgQHVdNU/5p/PNxUgv9aX1wjlMJoGBT7HolLQ+xHSr9nG8sOxP2Y+qo1UkWYMkN89yT8zJHBErskdAXYtpSBcNwnQciBNwpqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zT58PkwV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so8959a12.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711626526; x=1712231326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFWAM7aDWzcp6y6UIHXrKDrn/vPVbGKoJkanz0+nyYQ=;
        b=zT58PkwVeSrMYBhH4mzVKjqm8Gb6w69p6+dY0xz+yT1FVK/lO/m08dfvta47MF4Qe3
         CyYv3c3UnxXaXSH6TRFCJQWXiSJODOtuFO9xF7L5JZNCBChCN/DTHiLwgWyfyOyFl+p2
         eeQlOHAffgbTcaSHmeimPj+i1GGUk1UxByFWPn7cuN0NpA+YFUF1Cra/90Ehd6XiSKXo
         pJCFgiCFl/46qDxEJgoJ6FWcENH7RbEIPSwyEudiGfMRbL7zLKJZXbeLc2oyS3+7ZBeT
         4jfWzTqA43gfv8lxyBm+dzgky404QjkInrzn7i3OSNe+4rHEB/+FG34pnipO1QGvLwdV
         zf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711626526; x=1712231326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFWAM7aDWzcp6y6UIHXrKDrn/vPVbGKoJkanz0+nyYQ=;
        b=BzWKMlkTDt44PCCVSObaw8alp0pWF97+i22TBgxqbZosE01xIwwmtPgx8cZm+fyX9O
         QS+RHMhRkVskZnxaRK2ZBZ7wyWIUQQHMQg3H7VDCA4m2rt+cmhgwIZhRhiSd5OL6fZBY
         bkors59xWsuc/I4XbtjledXzzrfT5XGa3R87+0AEfPXe1RoHKVGKvRjj5fm4qLrzPj00
         jNPrnY3M+DUTpgATunY+8Av1Ia0HhZSVNLX4BJoib8PFHTLoZduZRFAgv1E7892byS7y
         xHAeghFm15xJpp1rmh39NLYrCjcjEdhulwRyatlcZ8bJtNw5jj7tE1Fd5hhHiqfksSm5
         7VIw==
X-Forwarded-Encrypted: i=1; AJvYcCV8BqgYcK8OnhH7hAii4eCa4gagt9AXzH2uZ/G2NBCWEVCZqmszvvgagmanFf5pd3VQET+8uFpWtXKJVdX0srPX60EG3mHn
X-Gm-Message-State: AOJu0Yw2pJ9q69Yd1ww+c6dK+XjC62OpaSd9l79FinjBHwKFu3QgoNbg
	nTbWqxCcOE5IE2b0NQO2O8V2TcvcEX/lOqKZKV93OikCjBYyHFm2zzf1t0gNn8pOxnWD5ImMkJh
	hLSlzmDMU+lAE8w2GzH2JnWqqrqSEAlYrprwB
X-Google-Smtp-Source: AGHT+IGqnYw+sySY96g0LyDux434D9RXsTE6M9BXDodVM+OiDk90Z2Y6TxzJrWUA3XY3y1/BPiP9d/Yg/0jkzhK73kc=
X-Received: by 2002:aa7:d68c:0:b0:56c:cd5:6e42 with SMTP id
 d12-20020aa7d68c000000b0056c0cd56e42mr152766edr.6.1711626524891; Thu, 28 Mar
 2024 04:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327040213.3153864-1-kuba@kernel.org> <20240328113202.GH403975@kernel.org>
In-Reply-To: <20240328113202.GH403975@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Mar 2024 12:48:33 +0100
Message-ID: <CANn89iJMn+wVBv7uNWTRJ_kOC2=vMmEcGmM5K_nk74LKxUwm_w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: remove gfp_mask from napi_alloc_skb()
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	pabeni@redhat.com, Alexander Lobakin <aleksander.lobakin@intel.com>, alexs@kernel.org, 
	siyanteng@loongson.cn, jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, mcoquelin.stm32@gmail.com, 
	intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 12:32=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Tue, Mar 26, 2024 at 09:02:12PM -0700, Jakub Kicinski wrote:
> > __napi_alloc_skb() is napi_alloc_skb() with the added flexibility
> > of choosing gfp_mask. This is a NAPI function, so GFP_ATOMIC is
> > implied. The only practical choice the caller has is whether to
> > set __GFP_NOWARN. But that's a false choice, too, allocation failures
> > in atomic context will happen, and printing warnings in logs,
> > effectively for a packet drop, is both too much and very likely
> > non-actionable.
> >
> > This leads me to a conclusion that most uses of napi_alloc_skb()
> > are simply misguided, and should use __GFP_NOWARN in the first
> > place. We also have a "standard" way of reporting allocation
> > failures via the queue stat API (qstats::rx-alloc-fail).
> >
> > The direct motivation for this patch is that one of the drivers
> > used at Meta calls napi_alloc_skb() (so prior to this patch without
> > __GFP_NOWARN), and the resulting OOM warning is the top networking
> > warning in our fleet.
> >
> > Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>


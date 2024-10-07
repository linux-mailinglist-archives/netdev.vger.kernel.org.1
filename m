Return-Path: <netdev+bounces-132577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601889922B0
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 04:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9256C1C215D6
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 02:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A980101E2;
	Mon,  7 Oct 2024 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM/wgY9l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4134E552;
	Mon,  7 Oct 2024 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728266408; cv=none; b=kG2lAPbKg4nNaU1Ttsnlddgm1ZV4lwRSp8wFSpC4HHO9P7rtxKS5bfhWqLmT0UItjs0IK0AgCswNqXWjudGYw4wtZANfE0gTT4lCt36tLzKdy/5uBtrFEX8Yk5FdKydJPWfCKeH3ywtGIAjym6JgE5BTetqnErjmStDyyV2GG3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728266408; c=relaxed/simple;
	bh=65qubrec+mDZuXp//UxF6SzvKZwFUrc1FQX6C5BEG/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQ8gFFSvOw+/YumxonacUZTCSufJWlKauxejx+LHBzPZlo6SH/vTdLp9isvNMu7wBXDL2zYz0QLzOcV91qkCe/URASLFmUkPiy6eNMhzN7IDFt4J8qbTnGVnUa4vFM5JjA8uQHeW6zCuGc63TJklDJzza+JLKwXdH3jSQsLjvq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YM/wgY9l; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e25cc9c93a9so3467530276.2;
        Sun, 06 Oct 2024 19:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728266406; x=1728871206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EwGfneAZ324aGGH81nFq2hhubsqFt8xTlh2f32TVhg=;
        b=YM/wgY9ln917HswYqH0C97dTTfA8lzReSxXvwIvM0jXD05hmwWt6ysf9DTEU/07/MD
         Mv7kgL+i6Ze7lMUg1ZraagM2mHC+xaUXJF4yf/qz3H8Gvh3PWSslJvfjnoCaLZoNI8ut
         i1L8goyQQbRc/KZJm4NMk78bsiISLObEJSAoI7b//jDbAGSTc9/7X3mwXg8VfmPuyFs5
         m5yuDhVYp4cVnCeAGJnn+5YXcFs7Pn+LzY6OkkY+vVhCuM0umE4cKMVqdEbQwln4Le9B
         UGYjnKixxVe8CqptpzshgWToY2/An4A50hB4Pbq52C3Q9WLYZnk1GP1G7RcTTT/MFfAg
         p62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728266406; x=1728871206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EwGfneAZ324aGGH81nFq2hhubsqFt8xTlh2f32TVhg=;
        b=kdyH90e1CrevjxH3LE87W2OeROJYSiOPmc355jtPvsOBBhlAizQAzLDHRpvnqRi2fY
         YCwPAeXDcAlK1F40ZUzCa5T2NiR1XP19BEwj0F6qHE1Tx+leOLlI/Mw9g0tJMBziXv8b
         7c8MIGii2VOwePjPT7q/vHYUFtQpN6ZDybkgsxbkM3azzXSL2SRwlOh69LVIOiUZqPSj
         b5LiETYIkNoLCq+pCe29D4qncHw8NCcM5LIBNvjD7Uzw9WIJ81OnvYPqFkYBw5qWSh/d
         K9kQ+O4D6sjXyA+q08gcyqNFWAkqMG6jNOJQ2XDXJlZb7mVn7uxuaL3UhaN7pq22kCTy
         pGUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJA8haZgd7wwd6elF4m+WfDzbImhB5Jv1zXdacheOHmtLUs/s2nZjaBlUto2V870nlVG8UEvlmc1R6hNc=@vger.kernel.org, AJvYcCWtOmcAqInHFGlSEuiyezxFwEDAmBnuQNY41s0gK3HdTsW6NszHueSTYRImhsegeeIsScce67So@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3gmiunz193q18sdLS/Ku0mWtK26db90aRbAzxwrCMlEEIiKV2
	LzKD009EdeN8z6SS4jEiDpx+5dRV9UaBDaKhEM1Txvr4zMG1YqM/W5FjJyH2D/XFFg1qIlnnSUv
	f/omQG9r6sTScsLSy/1LVEUzxewI=
X-Google-Smtp-Source: AGHT+IE0O0/zT0CJZ/FCBGPTSYVMXJpezRS+PpbtbRvTb1oV+A1d5dMaSlZrNJDaY/44VO68q3p9QAPiy/DlA3FXYLQ=
X-Received: by 2002:a05:6902:1026:b0:e26:12fb:1d9a with SMTP id
 3f1490d57ef6-e28936dc433mr7043971276.15.1728266405798; Sun, 06 Oct 2024
 19:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
 <20241006065616.2563243-9-dongml2@chinatelecom.cn> <ZwJP+Jx5xHfWR2zN@debian>
In-Reply-To: <ZwJP+Jx5xHfWR2zN@debian>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 7 Oct 2024 10:00:00 +0800
Message-ID: <CADxym3bLt_SeAExqMHDobOR2cAwoNugS6v9Oht5bsZUrGj2juw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 08/12] net: vxlan: use kfree_skb_reason() in vxlan_xmit()
To: Guillaume Nault <gnault@redhat.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com, 
	horms@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com, 
	bpoirier@nvidia.com, b.galvani@gmail.com, razor@blackwall.org, 
	petrm@nvidia.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 4:53=E2=80=AFPM Guillaume Nault <gnault@redhat.com> =
wrote:
>
> On Sun, Oct 06, 2024 at 02:56:12PM +0800, Menglong Dong wrote:
> > +     /** @SKB_DROP_REASON_TUNNEL_TXINFO: packet without necessary meta=
tdata
> > +      * reached a device is in "eternal" mode.
>
> Maybe 'a device which is in "external" mode.' instead?

Yeah, there are some typos in this document. I'll
fix it in the next version.

Thanks!
Menglong Dong

>
> > +      */
> > +     SKB_DROP_REASON_TUNNEL_TXINFO,
> >       /**
> >        * @SKB_DROP_REASON_LOCAL_MAC: the source MAC address is equal to
> >        * the MAC address of the local netdev.
> > --
> > 2.39.5
> >
>


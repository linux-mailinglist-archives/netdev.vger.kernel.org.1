Return-Path: <netdev+bounces-218931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159B3B3F074
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF19F4E08A9
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEFB2797A9;
	Mon,  1 Sep 2025 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMZijCla"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8827B67F;
	Mon,  1 Sep 2025 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761811; cv=none; b=OUmYX8wItZ9TSe7DPTTFfb2I39oRmKV64HGZ08oJAlSILgiyyS7UhxGu1cPVbXhV9ZcfM6dkZSDXGX471egA7qs1vtXNtouOx7TqODEjUmYQYY8dVfdfOB70AjP7yiRABKT7MhQzYgspNEnF4Sc2KWRstrQsCcQgWNuWl7TMCxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761811; c=relaxed/simple;
	bh=Os24PJ0d7qPrSddtCWXZnXisL/SsayYfPR2o4JGlc98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4YTBCDyx+z/lGDXPQvC/4dp27vXjPvQ4mRKuHDi6HALku16NITnqY9dbb/nnPzJxOVWQUVMt+D8uPQnPKZAKl1pI9G0Le13tiE+AKVhEydHjn0UGw++aynR2oPa0AepBWRJ95B4Cuq6At6AMKL+bJhdYw/Um5QhCttbsv4WClI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMZijCla; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d603acc23so37566227b3.1;
        Mon, 01 Sep 2025 14:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756761809; x=1757366609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJLLBPl4VNz9yAYMPwZYHGVjZjeqC7uH2RLSi9W+zqQ=;
        b=IMZijClarc/SuTfeG7A2MFNQlHohyi2X6tnvJX0kWx2AOMjcXWtl15K/gfDS/SZJis
         uf8MH2JpH5Kzn8niSCeIveSwh9K/Os45Wqso/RikR3YSbTH2q2BNO9/KuD+wiBSJQAdZ
         C4ZYM7LEu9sXfyZ1QC9mvw/KmxfG706YnOhPD8DWOKusVQ+hgpzeyVH3MZby1sIH5q6n
         bBaiq3D8BwxSIUMnMlAKVt5XQPa0w7fJGXydxBf+6jULYSusMJFSdpDCRqpz1BkhaQuA
         OyticT19fS5jjv9JHmRpAEyf+JTSpCbW5GBA9mial6rbKyHWmWYQi2CppA9aoJRDxPei
         6X7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756761809; x=1757366609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJLLBPl4VNz9yAYMPwZYHGVjZjeqC7uH2RLSi9W+zqQ=;
        b=UdsVtmOx8qpzcRTsx2+cabgxeXqlmqk7b4FJy+9DP0uziD2u51uxtJnogYPmkWV+B0
         JQjbtNSDUtLy67Ic+zTqlxpN4fSSAVs3zGdwA8DPrANyfkdulvvHOp24Nxb7gLR5r0fF
         1hUQob/XaroSsWUZYj6zcSSdmp9ZyzFkyObPvMw5T5SVn4LUdH8PDDbEVVwyB3T/fFTD
         scycXsiCOErwY5GbEEJG1X0kdTkdVCYn6i+vFGIA7bfHQJUQ3ms9UQ1gOwHqwQDKF6zp
         uptnGJhv1idKdtRRbT3EIJgq46S90fDsoFOxioJ/WUUWRUC+N8MwDoSWtLqjfZgERvoX
         2rNg==
X-Forwarded-Encrypted: i=1; AJvYcCUZGOpo3l9YFaYPLb+ojiehECf7Hw1+svYYvDdJ1XOTsGxHEq8mFjN5bE1GHreaHV/Yb7ITrayF2uXBlRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZi0dhaUYu4ARik55d2alfQ9efQEoXSxmqZPcnY3/oF6B8ezec
	C/AY9d3hWyfiCscNh6YA3mux6Vmxx65GhD0td9sNEwm3paFTaea2WgRCviSGcQbsJxghgeuOQiA
	boRw6Ifn6/KJlT8P0p2H7SBvnTSCvIsA=
X-Gm-Gg: ASbGncuaolObCXiI8rihXgqKtxW/opPztUN54ZnKzjFhpWAs8zAh8HimTwB0OEuVEyZ
	A0dngYeIVYXsV0Am6CCX5kE3gTfU74+ZHoGWw7PuCnNuLxXBh550GJzScqWSD3Mary237yZNhU7
	FnUPXMh+95bZ8uCTAxyJpmnO6dGFsSeTfh9Y4tK7CcUXE5cZz4Xl+GzT9EXCClatWBwsge2tcv+
	p87Ip03XyMfaVttrh1bd158o3g5AGNR49HwUYhX6VQtzTBncSeZz0lylkBPhQsZerU+ETx70lDA
	PoAx
X-Google-Smtp-Source: AGHT+IGE3rFBxr6OKIOB2HLWAalK6Kt/+EH2b8jbuWp5gvaPnEycszMCV8RSO4eFfu21sPRJVd0deskvi9VDjDcxTjA=
X-Received: by 2002:a05:690c:f86:b0:71b:fa04:d16e with SMTP id
 00721157ae682-7227639926fmr122112687b3.16.1756761808624; Mon, 01 Sep 2025
 14:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830214217.74801-1-rosenp@gmail.com> <20250901152352.GG15473@horms.kernel.org>
In-Reply-To: <20250901152352.GG15473@horms.kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 1 Sep 2025 14:23:17 -0700
X-Gm-Features: Ac12FXwOFef9oCXnPcyLPO_JM9qTHhy_twnZqkHsAra85qD1YiOIWo0geE_sIcU
Message-ID: <CAKxU2N__+EEAryXsYr0f1i6B4q4fBmJTVVFYROtg0LZxjMe8fw@mail.gmail.com>
Subject: Re: [PATCH] net: thunder_bgx: use OF loop instead of fwnode
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 8:23=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Sat, Aug 30, 2025 at 02:42:17PM -0700, Rosen Penev wrote:
> > The loop ends up converting fwnode to device_node anyway.
> >
> > While at it, handle return value of of_get_mac_address in case of NVMEM=
.
>
> I think that this part should be a separate patch.
> Possibly targeted at net with a Fixes tag.
I'll split up.
>
> >
> > Simplify while loop iteration.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> ...
>
> > @@ -1514,14 +1510,13 @@ static int bgx_init_of_phy(struct bgx *bgx)
> >       /* We are bailing out, try not to leak device reference counts
> >        * for phy devices we may have already found.
> >        */
> > -     while (lmac) {
> > +     while (lmac--) {
> >               if (bgx->lmac[lmac].phydev) {
> >                       put_device(&bgx->lmac[lmac].phydev->mdio.dev);
> >                       bgx->lmac[lmac].phydev =3D NULL;
> >               }
> > -             lmac--;
> >       }
>
> The update to this look looks correct to me, even without the rest of
> the patch separate. If so, I'm wondering if it should also be a separate
> patch. Again, possibly for net with a Fixes tag.
Maybe not. This can get called while lmac is 0, which is a u8. lmac--
like this will underflow. I'll send it as a separate patch from the
upcoming series targeted at next.
>
> > -     of_node_put(node);
> > +     of_node_put(child);
> >       return -EPROBE_DEFER;
> >  }
>
> ...


Return-Path: <netdev+bounces-212393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F34FB1FD76
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 03:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805C2172B04
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 01:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED8519D8A7;
	Mon, 11 Aug 2025 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHRQrSN7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C042B644;
	Mon, 11 Aug 2025 01:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754874886; cv=none; b=HZL9YbMv3qXDHi5Vrb3oYnc7iMtRE/sP1xdQ77pJ4mogJAP1JvoQDhvLMiqfGQwzdNZtthqeQP83dWGSMQPDSAxKVAp3uzcT5E5+/G/G6N0v3QzM7MMpMwzmuELZXutpe8v+IXOpMuAjRvhndXqgujlF1tAPLxauduzQ0h0YZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754874886; c=relaxed/simple;
	bh=haSJCd+IdlzQcFqiqdItJx7Nsc35kTUdFZTsLIANMuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7Gw7sDmH/dcoTirTvBSWr1w9PW5ciIW/3Tcv8AOhHKN2NhTnRYZR5cNBQ4Bkaf/6o+y2Z4rllWA5zcSEoYLd6bNXAOw2e8QYw9r6UMNUBeSw+f93gHERs3WZ71LBiqWnnNDVI/OTcuwt3mKnblw8o8qfj0PjFcSx24Bl87rE+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHRQrSN7; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e8e22a585bdso2625054276.0;
        Sun, 10 Aug 2025 18:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754874884; x=1755479684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvJRKH4qS1GiP3tkxhIFNg68DK66emrLSgEQyFAYzqc=;
        b=XHRQrSN7udvKeZxkqnsLnSbflM5t394Pvk69QF4jNMXLaGiumsak8cCC6VmomeCVp9
         8H0jkArnm6OlhXZTERXhlxjvYi7KVH8ml/LElJ+/XQdNGjYXUd3fx/6dR/3ctbTJ9BSF
         D9xGmmJ+4gGqoOVY9vUiI6xX2L9omr4XYP0RPX/JSG8sjAGJLjMMVyjC/4H1RQCpYfjn
         Ebs+sOU497F9YVDfMApo70ebubAaEzY14PbnZ+aKPye/LXW26cbwpnX4LkINU43AAGX4
         H4sF0DReSoe7ciXaorSD76q5Yxk5nGJehBWlnb9/HUqJuj32Fa5YhfqMf8w3spmP5fZY
         6nOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754874884; x=1755479684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvJRKH4qS1GiP3tkxhIFNg68DK66emrLSgEQyFAYzqc=;
        b=rt6b2JLUQG+RNlRDvTSwsprvehh31URhPvxQ0FjvIXHbProqdX27+Wk/vxL61yX8j1
         oZXOqbbpQmIKYh+wt8eWi1pUXTPz9xCowv7M8iZcQLR4ysY1CRll5UhJXb6BPI7Tl+3u
         hME33/OhCUs6vd6eE65x9xDbls7J7c8quesfzjKKIx+CgnVGQ0+xsdSQtCdqgpzlqU0y
         fB9DQNtutoRWNWdieCv9vJWK+sblPF8RvjgLGLffH/8f+erhmLwbm8NZQi3TZ/qzvRkx
         FMmXbhROjjzShKcnGGrFLdEXpeSW+kHS6wAozL2Y9Tzu2w6yEnjoQ2K973dRkwX7pW31
         afqg==
X-Forwarded-Encrypted: i=1; AJvYcCWWEiTUZj2tcxMf3PWrZyx6GVMCy2vNckddXXWD7oNWUX6Irhx9qbHGAlztHTNuLC6wspn3QIxi@vger.kernel.org, AJvYcCXYd+Gz4CsZGMLNz96L58O3Ssn4yYb6BGVfD2v2laCg4g2GM/NoiD/wn9DWkbR38+eU3Riz/Yfbs71Qgfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWaytAelcsu4OFQLFk/tGqagZcgz4aQqoitvD1h0lpmQW3WrQX
	1ie44QdVY4ccfOSa6Zd6J3fZbExKk9JkHHHCesK3OzUZ7+mI7NYjIn/U84X0Chgyh2wv65A92Vx
	NZh7uj1gcgXnAGw5NRZCcfGrxblLccnE=
X-Gm-Gg: ASbGncsm4T/rVIEpkg4nXW0om+Rbuu2ky9F+lLD7fEfTTG7U5F+e41VchxHuRqzKy5l
	LNchDj/IHm5eLq3YTHFs0fiorrCXW5nTNULa11x3Clw+wIdPthQ7znypUkmfZiuM6GRQyhgZaiZ
	5YksUL/4ZD8ChIZ5ALIwe9NX4hQMuM1xp9adATYmumzFLEdRoIZ7tclW1jxPeA96TA96kT9NQKW
	PV0/fGJG9faSUTznA==
X-Google-Smtp-Source: AGHT+IFsfa7gs8pDW2GfCMzECOYFwxJPdqo0JlTskW+jNKtIQMDm2TnY7K/R574tPpDpvGSqC6y7pnwDo2vyOqAilwA=
X-Received: by 2002:a05:690c:498b:b0:71a:35e1:e1d5 with SMTP id
 00721157ae682-71bf0d372a9mr145633547b3.17.1754874884032; Sun, 10 Aug 2025
 18:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807055634.113753-1-dongml2@chinatelecom.cn>
 <aJhNP_xQyENLSF6d@shredder> <8358d907-0edc-4ff0-a520-9cec3c84a49a@kernel.org>
In-Reply-To: <8358d907-0edc-4ff0-a520-9cec3c84a49a@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 11 Aug 2025 09:14:33 +0800
X-Gm-Features: Ac12FXzTjLlh7HwQSzcxs3HoTM1Iqm_deaoXHzhObCkORsFTyx-cPnmIZGjfabA
Message-ID: <CADxym3Y_XmmmCM3Mc46P8vmXE2vZ1+co6g7Z1VEpuT8WHt6+UA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: vrf: don't down the interface when add slave
To: David Ahern <dsahern@kernel.org>
Cc: Ido Schimmel <idosch@idosch.org>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	sdf@fomichev.me, kuniyu@google.com, ahmed.zaki@intel.com, 
	aleksander.lobakin@intel.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 8:03=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 8/10/25 1:41 AM, Ido Schimmel wrote:
> > On Thu, Aug 07, 2025 at 01:56:34PM +0800, Menglong Dong wrote:
> >> For now, cycle_netdev() will be called to flush the neighbor cache whe=
n
> >> add slave by downing and upping the slave netdev. When the slave has
> >> vlan devices, the data transmission can interrupted.
> >
> > OK, but can you provide more details on the production use case for
> > enslaving the real device to a VRF during runtime? Usually this kind of
> > configuration is performed before data transmission begins. I suspect
> > this is why nobody complained about this behavior despite being present
> > in the VRF driver since its initial submission almost a decade ago.
> >
> > I'm asking because the potential for regressions from this patch seems
> > quite high to me. For example, before this patch nexthop objects using
> > the enslaved device would get flushed, but now they persist. This can
> > impact offload of nexthop objects and it's possible I'm missing more
> > potential regressions.
> >
>
> +1
>
> Thanks for staying on top of this, Ido. I have been very distracted the
> past few months.
>
> The design choices when the VRF code was first written was either
> 1) require the devices to be added to a VRF while down, or
> 2) cycle the device while adding it to the VRF.
>
> I preferred 2 as the simplest choice for users, and so that is the way
> the feature went in.

I see.  The use case is that we want to use VRF for a living
environment and without breaking the traffic on the VLAN. It
seems that it's not a normal use case and we are using it in the
wrong way.

Thanks for Ido's and David's reply ;)

Menglong Dong


Return-Path: <netdev+bounces-132462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88533991C72
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 05:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DF51C21465
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 03:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF46167296;
	Sun,  6 Oct 2024 03:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWGkyC0k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31F614A0A4;
	Sun,  6 Oct 2024 03:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728186749; cv=none; b=nEIBWfRF6l08TTv07tVrD53fyR9yLnpRWodxDXApH9l3USfA2bdjj3nnACHF5zh1ty8zazRvDJP0qwCTNhxN1bGaePFPqB0Ko1+qbsLjqOakpBYgUNB4Ze37SS6kiI0szJ3dMs/Sjsi7yDHhpM+ecY0jRHUsd0xMfLLKd6ixgLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728186749; c=relaxed/simple;
	bh=Sdf4B0fQnfhiczqDk1Z1658VAly5KLb3L5E2stnWwMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIJpggZeQK8swdj8pzFTmfym5Xka52B5UmeLOVTlDiljq7vGPaZwvT5m0vEr9CH3zEk8eL+eQh0aL9S9ipg5dfDxhkHmJl4G0oyy8EIH5lwhGUL5wboH53RAzXdf7dbHH/ybmviCSTb5FgYfipKW58YJirUA76TD8D8BDnJxyt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWGkyC0k; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e260850140fso3288905276.2;
        Sat, 05 Oct 2024 20:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728186743; x=1728791543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2X8P3Igf6+UoYWh3tEarzn1VhB1zwWP/QEAtvvm9Uo=;
        b=NWGkyC0kdTCjYGpKuur6HgL4XpYH9MABdWKlL6HVyOSZNYu9MS56WK5n26PEuGuoPc
         xc+5qmB6FnHIgvyKmjiNjbK41g4sBjJMYAymzsYHds9mwAJWh8tSr3r7DBVXxJ515l0T
         h7n7MP6qUsOBsKQzdMZR/BZAyWDq5YiGj3yFrT8cmzfvyHy6Oxqk0wutON8OeJCTQdJx
         vEx3BOV2Mf+V2crboQ/Bplhcrllgne0CfnouTF1E02F8x7PI/LdBo8XyvDytnjbjLfzr
         2HX0LiGhqeRypDfooz+dnERwqIWDFSAzZMlpDEFSh8aIlaMiuju/Di/NEo/aUyAQ/2yR
         CkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728186743; x=1728791543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2X8P3Igf6+UoYWh3tEarzn1VhB1zwWP/QEAtvvm9Uo=;
        b=UUy+cCbJOr9hEAnU0FiF2s2Qj6nc3lNOISS/ijheZjQ5NiccxxPVilWIhbFFGEdIxZ
         kWPCGPgIcXOV3RQ7fee5Ue2mXD7NHGjc9J4PpzC3j3s7kX4xs63lMKjQjUeRowSJkTdP
         x/6N2z55Sep7mAq1VzcR3iqvEW/YVmPdHgqvfxz14gL1GsxCFuAk5LpbQSZWikRJueB8
         BZaHN3x9Ty2RPktTK+wFg7ob8vcQ6viZgyDHCOZIPvoLGXzCDnckPjYOVHOsEN/DTVKz
         ycPZztDf5lzvD7RfeeumS31z5B4fu8mpo2gKFzTcGW2bQWsKn/l4EQ7tJlDgCznPRQaE
         B8uw==
X-Forwarded-Encrypted: i=1; AJvYcCV3nOmKuTyLiUxJQdzlZoPlbEBL5b2q7tpToDN2BCNuEbeTY1NtEL+TbMR4JgU1w6nosn+j4YpA@vger.kernel.org, AJvYcCWxUhwYwXVIXCsrrZrD9loVcCy1ZJ7mlTli2TtFxB/50Q5rPhrad8Q+KX9LtnlsyFOqUH6B6bl/IGkEAqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0M0GX6j0mkyWoC4aDmTHVSmreCzLNOimk6ZvyGkz+v/tCvaWy
	SDw9O0Exft22HM5tUfSgzRiZmie8CKddIxwg6lwLzHW1MG50em/64/5bABYY0Bh+bbqah6yewBE
	mJhyzBeU4oD6sfmJ6dH8TNt5Yrvo=
X-Google-Smtp-Source: AGHT+IGAThCbeC2x7qXL+YM8000ZpKtMUCHEREjE93ktr5BIxPccUKTJh+fQj5wbUfnLP9vf6JVwx2Cny+3Pd74A5lg=
X-Received: by 2002:a05:6902:1002:b0:e26:2c21:d0f8 with SMTP id
 3f1490d57ef6-e28936c6705mr6253519276.6.1728186742862; Sat, 05 Oct 2024
 20:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-9-dongml2@chinatelecom.cn> <20241004094547.44ba5dc2@kernel.org>
In-Reply-To: <20241004094547.44ba5dc2@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 6 Oct 2024 11:52:16 +0800
Message-ID: <CADxym3Z3nujYSs29HOYTvZ2rvoqBgqDkiA-N3VcHBvLQ+9w0Rw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 08/12] net: vxlan: use kfree_skb_reason() in vxlan_xmit()
To: Jakub Kicinski <kuba@kernel.org>
Cc: idosch@nvidia.com, aleksander.lobakin@intel.com, horms@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com, 
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 12:45=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue,  1 Oct 2024 15:32:21 +0800 Menglong Dong wrote:
> > +     /** @SKB_DROP_REASON_TUNNEL_TXINFO: tx info for tunnel is missed =
*/
>
> Doc is not great, how about:
>
> [...]: packet without necessary metatdata reached a device is in
> "eternal" mode
>

Yeah, looks better~

> ?


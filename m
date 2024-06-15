Return-Path: <netdev+bounces-103787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE829097F0
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 13:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136941C20DD6
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 11:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2714D3A8D2;
	Sat, 15 Jun 2024 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rl3cxoa7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC772E634
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718450960; cv=none; b=ZWanU5hcg6z0IJITkfVt3PAslOpDaSQuUaFeLv2nM3sZePYFdcB/DcX/rE4X4srF5Vfw8cia3XRX9DL2a13IfCWqKlghVVWfs6MSBCe0LcVIMokgsA75Fvnq/wlvHNhBUPBPDO9xkhOt4+mQDT4J5Z6Z3UMoIMs3aiEltXU9O5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718450960; c=relaxed/simple;
	bh=teQk5Op85ZEISXMGxTDW9M2Kl0/8JtwtVCnqbF1qCWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qu3p2qqISobTB4HSRUf69vhLdB3oPLnBmXpD0c5TQvCl1/U9YyaE32XWRsFfC0ScHHSP4xNLZ2u3duBSsCAW4EZZaGTWWGi8edb0AWXUrpqpM8t1vZebXENnn2dofw0DoAz6wBwIALJX/fzZtEiRxccu06D9qjhMWkkGoIGpQ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rl3cxoa7; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-443580f290dso30011cf.1
        for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 04:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718450957; x=1719055757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/07zgTJKmJjPDlWX+RgVWXATsRw89BuI4IvNwvbRq7I=;
        b=rl3cxoa7xEDZw3HNnKan9tG5BS0XiG+hCcgz52xFxrFZIJ2QLLp8y1ZuUWS+6qodqq
         MXyANTXuSEI15FsldhdgcJX3gN612j4+eZvI2bm9zKoTNTQ5KlpysHlbTR55RM3bg4aQ
         z6m5WFkC0fYrbreuJCptSA9UHBcqm2psfrkCfcqD96/cubJ/N7xQQj27nWImsaEZNGQv
         nVfzf+ocSN4Mx7SFf5LBNBEvdwUqU8v92WM4+PbQCzeqsFYFcyZex/fA8EuG6lXy/VL2
         2g9ulMgbS6uLGYKACyBHQ7BntMdJlgnY9padgFvmyBHE6nXYDDpF6blIrOKlzBUXyqwO
         uJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718450957; x=1719055757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/07zgTJKmJjPDlWX+RgVWXATsRw89BuI4IvNwvbRq7I=;
        b=O7NpW60E6buESPUu36mOfBQiGjUoWU0I4ueE1DfiLvD8tubLlC5RCEUZhW+lfySg2k
         NhO7mdn+U/dcHug5ZTC17IEcSanhYGldwFAFCy17z3WZZp0ZzH1qXx0EvJ5+WTs8U0qE
         zCdJ1HZCrFrHeualmlUDK/tXPqEJAVGEnCgCwnjvnZkd3VAC23puicAHfKlq2vTGBSAB
         JXdymjfLbV9V0hci+9keVppbOytDtBRFeaitHFY9sO60TshtPNHK2/qqKMrBq9Govbyq
         7JIzHcpBnUpIb+PuI/31B1c0B/lVc+in6EcUxVNIzMTcSmuCNZzsqLAcLG9OCq8LXUJK
         B4QQ==
X-Gm-Message-State: AOJu0Yxp0SFMC77lzmvy88x2ao08aV60xdC6BOFp+FbgVSCA4JCxBb9K
	/y9iehvjyilYlo5NxXdVnE/sS7x2hU7MWouJf4N1nlcnB6TVMeui4T9qAgMPacj1htKfy7gbXBe
	ZddGb1pASJjMN6Wc15mzbDoHYyQk19Jz9nunK
X-Google-Smtp-Source: AGHT+IFim5KalF06ANvAsCArcQw8j+Bi3RmUZVIH17d10lxbvllCANPEW0yR1IW6vhNa3fsYRJsK092oJ3m2eDYVGWY=
X-Received: by 2002:a05:622a:1a0e:b0:43f:f689:2eb4 with SMTP id
 d75a77b69052e-44350a92498mr1290831cf.21.1718450957351; Sat, 15 Jun 2024
 04:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613141215.2122412-1-maze@google.com> <20240614190312.3dd8a941@kernel.org>
In-Reply-To: <20240614190312.3dd8a941@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Sat, 15 Jun 2024 13:29:02 +0200
Message-ID: <CANP3RGeBQCQhji0xWZXrzA7kbdgNWeD+GtNfsWFtZCvHAT0VVA@mail.gmail.com>
Subject: Re: [PATCH net] neighbour: add RTNL_FLAG_DUMP_SPLIT_NLM_DONE to RTM_GETNEIGH
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 4:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 13 Jun 2024 07:12:15 -0700 Maciej =C5=BBenczykowski wrote:
> > Fixes: 3e41af90767d ("rtnetlink: use xarray iterator to implement rtnl_=
dump_ifinfo()")
> > Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dum=
p_ifaddr()")
>
> Did you just copy / paste those from the fix I pointed at?

I did, since this was caught in rc and never went into any 6.9 or earlier L=
TS,
I didn't put much thought into the fixes tag, thinking it didn't matter.

> I really think it should be:
>
> Fixes: 7e4975f7e7fb ("neighbour: fix neigh_dump_info() return value")

reverting the above does indeed fix things.  I'm resending.

I'll figure out what fixes the other one and resend too.

>
> Please double check that, correct, and resend. Same story for the other
> patch.

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google


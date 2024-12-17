Return-Path: <netdev+bounces-152538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6875A9F484C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F413116B76D
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A681DDA09;
	Tue, 17 Dec 2024 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gaRd+jJU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871E91DBB35
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734429843; cv=none; b=ld8pK7WdxyhijQWTWhN1Oidtl2HK5ELiC0nqJrX37wqGhQXsRo9GnzAsf4oT8X7Uvovprl9nFrp6uCKU3jpa1CqIGdtOI3WN7HWxX8Hr6qYdHLI2wQ5685SB13yClq3qAaIme6S7boT+cJBbhrpkCBA4teiwUIvK44LZGo8VNFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734429843; c=relaxed/simple;
	bh=SiOI+a1yrPefvnCTYRy1HAhiE8ystwgJCaxun3SS034=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCWAfn8BBJK4JzQUvVgEbep67S2yCdrGD75i+OjROPu3g9ojHDTzie/YIsJYuTgNP/F3b+gEupNqUfekIkXi62F1N/qdx5GVaBP3b8FBiRXo2nTbmj5SAEJL6Y5WffX8XM4gWM55iUhxs1yxrz5QB2GzW7EM2k12uPlBzGLL9oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gaRd+jJU; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a818cd5dcbso65ab.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 02:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734429840; x=1735034640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiOI+a1yrPefvnCTYRy1HAhiE8ystwgJCaxun3SS034=;
        b=gaRd+jJUpBZn4XZUZXkng5CFmz1zIcNmujuIKQK+ni0MR5ND2PANTHI66iGWQnJNRc
         vKlMqmpbmJs9fa/hUO0v179AUPKjZsyc4tpiVZv2cbVjWyxY1zzGbIy7Z3tAKniZPjj2
         7WuAYo4sGvws8xu8BYVnggLeZYite8axq1MTr/aU73+f+etc+N60un65W2p1xVSD5/si
         SgKrlOxMcrOkTzTrbXHgOu/QRhOTO3Ghf0WoCeWVtOJVujqZmYYGc0YJTHLmVkV873VT
         +0jut/Xc1Mr5qIi9sYLnGdbEEsSa5xnQFTOleMadp+h42Ng3MGDfog3CoU77rN/qPeCo
         cpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734429840; x=1735034640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiOI+a1yrPefvnCTYRy1HAhiE8ystwgJCaxun3SS034=;
        b=suLUDgLAlPYiwriq+Sbtr+mv7W0UaFBQmz2ME/9SfkH5exeQ3YiRnM8oRu6AD+Xf/+
         Sf9srC8oXQD/gAR8uInlfACMITx/vussilegbdG2PXAKg18V2X0edI937DU3LmDGi8+0
         /DjLcvzZfioSgrFyRBW/VAedn8arshOIszkrOGLPb5coXwnogY/NA1zi9qfqG8bMJU5a
         cbxuIoTxdj+aaJanpVhG9LuBfqW4pOfi+Gdy0gvD/5uJTIoEyhEV707VehMeEuYT/IIB
         iRHwp3WDwK+buh54bhOe5wpdTalmP+APYk08558BYl/kCqBpcD/A8lJQr1Lczo9Kg+m5
         cMsw==
X-Forwarded-Encrypted: i=1; AJvYcCVwj8kCkMh3uyYk8Zw6gmZvDR0EiGiYDc8dcAuF9b7kRB01ogKN7QMG5oF46wIcK5FIBTfwcpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygz+0QhPk3rH68K2qrVpOLG0T45badmUQgfAuGcJxc6YYg5Xj7
	PUAEjL2FU8RFVGQpFkPFIp+YqRqZGiqgU32zAwKC/0oNdKN9xakebQOMCErVUxgw3bFj3AqMT/S
	lnWrT72d/YcMAem+wE7DKG6LFNfRBupt9layl
X-Gm-Gg: ASbGncse0TEa7ttvHcRF7ivsDxI9w3H1tofbdW+rTIbCh6lCKpQvWoNRzEg0CIuDaN9
	YxO7BQCRG3bSxqZo3erxmDdS3PyGk7zX8ULpxxzpo12lC/pgNLDJj1Pw1q7cogj/BeS/J
X-Google-Smtp-Source: AGHT+IH+ubBPmVKVFDGnhrE/uD5pLkyCTnb2tNx0uDqwEt5UqhkXy8jdRQpJBcCAYQqw7tqbntRVJyWTdGegZ140feM=
X-Received: by 2002:a05:6e02:1d8c:b0:3a7:d682:36f6 with SMTP id
 e9e14a558f8ab-3bcc30676d8mr18695ab.0.1734429839719; Tue, 17 Dec 2024 02:03:59
 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217063124.3766605-1-yuyanghuang@google.com> <CANn89iJsO=FppY=qx6Mo5CUP6v5QgeR-c4StSGmCoQ3kcZ-bEg@mail.gmail.com>
In-Reply-To: <CANn89iJsO=FppY=qx6Mo5CUP6v5QgeR-c4StSGmCoQ3kcZ-bEg@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Tue, 17 Dec 2024 19:03:23 +0900
X-Gm-Features: AbW1kvbGjpbsadZXS72JPHHuaeFf_VB8tWS3luuvRqV7jt0tRN9VVVea22Iew0g
Message-ID: <CADXeF1Fq+AimSZSf480D3Hgimzgk2eUCjs0XHNAq5jPkEPjwsA@mail.gmail.com>
Subject: Re: [PATCH net-next] netlink: support dumping IPv4 multicast addresses
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org, 
	jimictw@google.com, prohr@google.com, liuhangbin@gmail.com, 
	nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, 
	=?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric

Thanks for the suggestion.

>Have you tested your patch with LOCKDEP enabled ?

>CONFIG_PROVE_LOCKING=3Dy

>I think this should splat, considering your use of for_each_pmc_rtnl()
>in a section where rtnl is not held.

>Please make sure to use RCU variant only in the dump operation.

After turn on CONFIG_PROVE_LOCKING=3Dy, I can see the error like follows:

net/ipv4/devinet.c:1876 suspicious rcu_dereference_protected() usage!

I will fix it properly in the next patch version.

Thanks,
Yuyang



On Tue, Dec 17, 2024 at 4:07=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Dec 17, 2024 at 7:31=E2=80=AFAM Yuyang Huang <yuyanghuang@google.=
com> wrote:
> >
> > Extended RTM_GETMULTICAST to support dumping joined IPv4 multicast
> > addresses, in addition to the existing IPv6 functionality. This allows
> > userspace applications to retrieve both IPv4 and IPv6 multicast
> > addresses through similar netlink command and then monitor future
> > changes by registering to RTNLGRP_IPV4_MCADDR and RTNLGRP_IPV6_MCADDR.
>
> Hi Yuyang
>
> Have you tested your patch with LOCKDEP enabled ?
>
> CONFIG_PROVE_LOCKING=3Dy
>
> I think this should splat, considering your use of for_each_pmc_rtnl()
> in a section where rtnl is not held.
>
> Please make sure to use RCU variant only in the dump operation.


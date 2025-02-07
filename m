Return-Path: <netdev+bounces-164157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E7A2CC80
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A27E1886C81
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676021A316C;
	Fri,  7 Feb 2025 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WaxJRb8v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C331A262A
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956282; cv=none; b=QJXzASTl6EMa4D7zNktT18RBfBXpL3T1O4En9zhDPXdGsyZ8jlC0uzlpPF6qMivlvBp5jJ4J7ZoSUzWfrxunz02uT7yuUk1KnNYcvEF74GvVzajsy3P2NdhfcdhCJNMeLAPGmOmUz1ZKYFmg8jKHpofkPXsd2L8MBli2/wnuYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956282; c=relaxed/simple;
	bh=vxU+tYVnh6kMXN1kCB92NtopAdH3cQ9eveg0cFzyLtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtzvGV6HefclKvn65ssLtKmLAMeDSt7JTVYynpnHOJ2zyt/saJr522y1rZA3RAFlxdKD+psUcmF4NdM998uLAUnLCZNhqS18Ng6115wcCneG6LE3g+ATHihI/CPwZvb/tfrcWHb4rizMnyo4zY7SBdMR/W2KcsuuNrej1scS53k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WaxJRb8v; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 33D3A3F87A
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 19:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738956278;
	bh=vxU+tYVnh6kMXN1kCB92NtopAdH3cQ9eveg0cFzyLtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=WaxJRb8vOGSQ3WsD6VIO9G1iAjcqbgCpt2h2KQr3TjTpaoBWu2Wj56ywDNu85itEh
	 7ImC3fZ4wWOsTujVEgipdzjoP0f4IKfpwhaenncDSIx040fkJ4/l4c5gtliC4NQ+OT
	 2/+Q36nbd8U5cwTOy35QlqQK7QEf/x20bzIjXmfC/WpsvorVL/Vdxq6Ej6wofb3+bF
	 0f4Pe1Th18jA8g7lyiFDNIPIGCSpsgyjdVdQQlXhBB+WP5lc06+VSJI3vr/H8fKELz
	 U+FqGuqLTwMn7E7KzvUaUjGG99vv4+TBhlwJ4G0izDmNm48mUlEJfotv/eSFHdelW2
	 IwRSL8PUIZ3wg==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d9fb24f87bso2838791a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 11:24:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738956276; x=1739561076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxU+tYVnh6kMXN1kCB92NtopAdH3cQ9eveg0cFzyLtc=;
        b=xBUyC/d3QwSZEzLjRjJOrjQ7IsKLM+1x+u4t/4IzK+fHWE4jFvPb8T6QjIfaTXctta
         gmlBGIO9dR9OtcgQqvH0yIaH6zSqQqdcfkvUMYKJFXp+9YqSAeTxAMGc35e31RZt/UCO
         10/UelGdCShS6fC9R/yS74dRDshbm++ehOgpgo3bypRf5npI6DajqsAEL/4zGVNMRpoK
         3tk/u5v8YGMEETGIjz8o0jmnwqMdUvz6Qhz0NmxMqS0aHIYQR6C+LEdoHc93DP0jg73W
         vZ9mVnM0Nu1s1mD1xZ0jUAQnawd39Oo0dWNoLGfAIfEwOIXbQL75xt9xkiqQ5JkmFSdv
         5rXw==
X-Forwarded-Encrypted: i=1; AJvYcCUxBurEZzD0MIo/dr5tKbT/ZMUxVsHmeFr/yXM5eo+mOMO2MJVmoyKW3v9psNJHUo2Sifcq9u8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwsuH1Xpvf/l19EQ8k3Ly5M1VGlHDbovP5R1VWhWgge1N+xDqQ
	9djvx5MAwXetrzxs0P6+codEzhV5dUuub9uQLLAzvirRaoRO3fPmAqAwylhEK6RleK3kInCx9SW
	n0PUKK+3dOVhwK5gveqbqlSoSmMbuUBLOw7o2tHA5wYzN2WU84pxYEQYG+zG4YJVW4Ezkffbdy5
	t7zQZF6wHV+GFtyoaRxy0geKxVIUfztGcNAYlNJb/DQxT2
X-Gm-Gg: ASbGnctxasg4iKkcULjfh4dohkjUol1y6ieRiUH2BA+8BnjChAufTWU/gUTTV7d89qD
	I2G3zH/97Ql9ftIqlSrR/ydoc41KpuqNPsqLae1cm6KQk7I2Fbi4OFLYu0hKG
X-Received: by 2002:a17:906:6a29:b0:aa6:a572:49fd with SMTP id a640c23a62f3a-ab789ca2972mr420380866b.54.1738956276682;
        Fri, 07 Feb 2025 11:24:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW39V6vxQtVQ8dceJH6mGloMgI0XHnyBDpBS0JjWTn/3cHP5RLfgBQFsUPSHSqaPzI8YS3WFgZCGADlt7dVJo=
X-Received: by 2002:a17:906:6a29:b0:aa6:a572:49fd with SMTP id
 a640c23a62f3a-ab789ca2972mr420379566b.54.1738956276318; Fri, 07 Feb 2025
 11:24:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHTA-uaH9w2LqQdxY4b=7q9WQsuA6ntg=QRKrsf=mPfNBmM5pw@mail.gmail.com>
 <20250207155456.GA3665725@ziepe.ca> <CAHTA-uasZ+ZkdzaSzz-QH=brD3PDb+wGfvE-k377SW7BCEi6hg@mail.gmail.com>
 <20250207190152.GA3665794@ziepe.ca>
In-Reply-To: <20250207190152.GA3665794@ziepe.ca>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Fri, 7 Feb 2025 13:24:24 -0600
X-Gm-Features: AWEUYZlr2pi0PkFPhk6g8C39Y1EN3TzUeAopLgpyoqvD13zRSg5s6jJmYOdIuQ4
Message-ID: <CAHTA-uZMZ6qQZf_n55gNaTjQQ0j8nXdt1Yi_+8+-YUNhxcrs_A@mail.gmail.com>
Subject: Re: modprobe mlx5_core on OCI bare-metal instance causes
 unrecoverable hang and I/O error
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	andrew+netdev@lunn.ch, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Talat Batheesh <talatb@nvidia.com>, 
	Feras Daoud <ferasda@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

*facepalm*

Thanks, I can't believe that wasn't my first thought as soon as I
learned these instances were using iSCSI. That's almost certainly what
is happening on this OCI instance, since the host adapter for its
iSCSI transport is a ConnectX card.

The fact that I was able to see similar behavior once on a machine
booted from a local disk (in the A100 test I mentioned) is still
confusing though. I'll update this thread if I can figure out a
reliable way to reproduce that behavior.


On Fri, Feb 7, 2025 at 1:01=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Fri, Feb 07, 2025 at 10:02:46AM -0600, Mitchell Augustin wrote:
> > > Is it using iscsi/srp/nfs/etc for any filesystems?
> >
> > Yes, dev sda is using iSCSI:
>
> If you remove the driver that is providing transport for your
> filesystem the system will hang like you showed.
>
> It can be done, but the process sequencing the load/unload has to be
> entirely contained to a tmpfs so it doesn't become blocked on IO that
> cannot complete.
>
> Jason



--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering


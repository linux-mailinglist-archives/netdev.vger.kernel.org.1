Return-Path: <netdev+bounces-119753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACFE956D6B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCE61C2389C
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF1516C683;
	Mon, 19 Aug 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jySK18sj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79A615F336;
	Mon, 19 Aug 2024 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078131; cv=none; b=fLzWIvCXQhtkzKq7jL3yuFxAxNEdwJK+FnmdfZTWA9ypHVX7nha2jYXi+3buMaLBi/KF1GtQOZHW7EIuZKXNwPeigIK+fKGyXln2UziLDba9zc3vwZXZesbcJ60NaroCqQ+s1coOPpS/9Mrrjtej4gm2gjEXqQzWZubhgawPOw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078131; c=relaxed/simple;
	bh=3AkAPvoBMlH9T0QqGV7Vz1juOc/YlsIVTFY5T19v/mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjG5NMcJ0l4Sf89X9uvJy9ntACa3SYMaIQ88AsTiHT8UmqBW2iYj1E1sjA8+oUjY2cWR/AwVqY4HiXvD1K7xUOhQyTjysyAcb1f5WKQJxFNnZbV4NPuUqLc7sQKH70cDETxxQ+Ao2fzizhor2uxhiqX0bd5TU6pHT66lqvUtBW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jySK18sj; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a83562f9be9so381046166b.0;
        Mon, 19 Aug 2024 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724078128; x=1724682928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jTUooqt+eY78HohIStaM/57XK4P3t1SVjvktkPox5Ug=;
        b=jySK18sjPxfXCDluKxx5euu33tTFNqujN+TkNbgjoLSZtCzwkxQvhk42ujwRYa0Jao
         s9ikqYBvqTgMw+/nY1b147dWs0fbPDKDEIoAJ2CdBW4ywiZi2SbhvajkZPYEPTlXBygm
         LswG2F+KJPkKzDTodksTflJVHHXZlvVX4y/95GzSIMmVIuSGeCFlZLjhvuuDTnrPHcpc
         mXWJPqVsWSKKbL9YN/vgeMZ8F1IaCu1hu4zVC32tb9/oAvVnmXuuGH/HnU1GE/rnIowY
         BR4ck824wA6NkFexVtvVdmf88/X+nr1+pjfbVAc013n03CCEL63SyjmE2y3Nt4RW0Eke
         cS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724078128; x=1724682928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTUooqt+eY78HohIStaM/57XK4P3t1SVjvktkPox5Ug=;
        b=CuvxBWSAkpfp9ANl+B2auaqKc/Prmn5Ab5DLUs/7u0PwdU6lerHGJJBCRiSvmRd89W
         x4bLPKCpXSNoMvmhQj5WiIvOtLCVBp5s/zR9r2DjAZIUvpeDohbC1X2QFCPOE39DsOKh
         m6+GT4C4Z5It8FepP9N0YytRYGRCtX2Ls2jN0larnzaiNIkOSk7cfIuRONTLWrckE2Cw
         tGcPPyz0gLAGrvL1QSRLxthVjV8dus0QjbmnPURXRss69aQuF4m/QamwtlM5eXXMHC9r
         LwEzKjHzR9c6NX6geNc91ED0g8DPwW5Z4LjXVz4LDST12slCI1L2VxqSCKaWxvBYe2HE
         roiA==
X-Forwarded-Encrypted: i=1; AJvYcCW/o6AOD8ANlxKFbSzuoePKOOZGtjbgFVqdxYd9CtyyWinvO9Bjvse6QEvWRdW7+NsQoPJOl0Bw5v9AIRrcUby0qOcq5J4QSX4QbCNZe75c3K6IMTaieNb8ObFlZIWB5uGdmFew
X-Gm-Message-State: AOJu0YwUaPV+yyn7guB3ebCjZ9WKAW3FdcfBdImXazAQ6/5ZY3oJXOv1
	ybxq7Ws12BG4bXiSuiNNCxDeqP6G8f18tuy2Nj4f41P/K3R1jlgW
X-Google-Smtp-Source: AGHT+IFK9alpT6hYq+n3YKi2nRz40t6HVvkBabJGL4Kb1JH3th6i+jOBlQUX8x+whMmO1JtuhV1GFw==
X-Received: by 2002:a17:906:f599:b0:a7d:a21d:ffb8 with SMTP id a640c23a62f3a-a8392a4758amr528552866b.64.1724078127601;
        Mon, 19 Aug 2024 07:35:27 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839356efsm642281466b.135.2024.08.19.07.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 07:35:27 -0700 (PDT)
Date: Mon, 19 Aug 2024 17:35:24 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pieter <vtpieter@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: add KSZ8
 change_tag_protocol support
Message-ID: <20240819143524.wjuevpejxgqh3hws@skbuf>
References: <20240819101238.1570176-1-vtpieter@gmail.com>
 <20240819101238.1570176-2-vtpieter@gmail.com>
 <20240819104112.gi2egnjbf3b67scu@skbuf>
 <CAHvy4ApydUb273oJRLLyfBKTNU1YHMBp261uRXJnLO05Hd0XKQ@mail.gmail.com>
 <90009327-df9d-4ed7-ac6c-be87065421ba@lunn.ch>
 <CAHvy4Aq0-9+Z9oCSSb=18GHduAfciAzritGb6yhNy1xvO8gNkg@mail.gmail.com>
 <9e5cc632-3058-46b2-8920-30c521eb1bbd@lunn.ch>
 <CAHvy4Aq=as=K48NZHt3Ek8Yg_AzyFdsmTe92b8SFobzUBM9JNA@mail.gmail.com>
 <20240819140536.f33prrex2n3ifi7i@skbuf>
 <CAHvy4AqRbsjvU4mtRXHuu6dvPCgGfvZUUiDc3OPbk_PtdNBpPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHvy4AqRbsjvU4mtRXHuu6dvPCgGfvZUUiDc3OPbk_PtdNBpPg@mail.gmail.com>

On Mon, Aug 19, 2024 at 04:20:31PM +0200, Pieter wrote:
> Hi Vladimir,
> 
> > On Mon, Aug 19, 2024 at 03:43:42PM +0200, Pieter wrote:
> > > Right so I'm managing it but I don't care from which port the packets
> > > originate, so I could disable the tagging in my case.
> > >
> > > My problem is that with tagging enabled, I cannot use the DSA conduit
> > > interface as a regular one to open sockets etc.
> >
> > Open the socket on the bridge interface then?
> 
> Assuming this works,

You don't have to "assume" it works. You can test and verify that it works.
We have a selftest for receiving all kinds of packets on standalone and
bridged interfaces.
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/tools/testing/selftests/net/forwarding/local_termination.sh

> how to tell all user space programs to use br0 instead of eth0?

Question does not compute, sorry. Is this answer what you're looking for?
"Just like you tell them to use eth0, just that instead of eth0 you type br0".
Or just like Andrew says. You don't explicitly bind IP sockets to
interfaces, you let the routing layer pick the interface based on the
routing table and the IP addresses on each interface. Ergo, for IP
sockets you just need to put your IP address on the bridge interface.

> Both interfaces are up and I can't do `ifdown eth0` without losing
> all connectivity. I'm using busybox's ifup BTW and it says:
> $ ifup br0
> ifup: ignoring unknown interface br0

busybox ifupdown reads the /etc/network/interfaces, it's saying that
interface isn't there. Which it really isn't, maybe? I haven't really
used busybox ifupdown and I don't know what it can do with bridges.

The basic command to bring a network interface up is "ip link set dev $NAME up".
This has no state/configuration file and just constructs netlink
messages to pass through the rtnetlink socket to the kernel.


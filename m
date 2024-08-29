Return-Path: <netdev+bounces-123405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC24C964B99
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17041C23329
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33B41B0117;
	Thu, 29 Aug 2024 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFrp9awt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAF938F9C
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948617; cv=none; b=d3QP9wNrS/8deSMPjVdlmk9HVnPOLnBtfHw3LQui07YPsJ3YmkPxtLeuM5KhiKjRI6SPoIa+s77awWggr29PKu4ubgqkvKPdi8590/4Uh/dn40wq9bg1a8W61PLB7mHdWXHBR28cVngiKyQmlw2qMWCEwnK4Td/s1poFxOYbpPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948617; c=relaxed/simple;
	bh=gHPJKGcIlun/9Pp/lr+BLHcACB0gOURuQHktaiAXVKk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BS2OfgM9DaS8GZf1TYmWuaUQFY5ZGUKKwvi46UHHIHszKmfThKNHWKYhWCPZFqu1byit+46Xc5JJwjqg4RRHWAUb2/tXhApL0h4Y/Vf7Wb9vQRuqGXgqbb5sSxy0umPtlvDJxdy8QIjZHyresAEwUinOouS7rdwuWXcWnsmlLUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFrp9awt; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1dcba8142so151525685a.0
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724948614; x=1725553414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHPJKGcIlun/9Pp/lr+BLHcACB0gOURuQHktaiAXVKk=;
        b=JFrp9awtLnOw/LINr55y446Mpi0VrwRX/8CNgi8VqeUAdHJX1VhE7hTLFrzOXnSqs4
         HhZzeAPeT5E/hSPhlrjigZWVIhS4gzOvN6fmbuoB+y8vlfwcSG1nlts7yva1GuvCgr0b
         68JL5+8usH/nJY1wsJo+G76PF5wCZ6kSwMf/IUhR5s1iIWHT4i8zA1A7ZM+Kk+Vt4WTV
         zvYEA3ueUcnuQiZpuuBkHi3bMAtGXCx/Z+rKPcwU+t0q5z6Td2//w7OaC0gMGskjaEhZ
         fXAamjXRY1PTlQq4503fsMPIDQPZ1xIBF0L/3bzbc29iCC0NgbI5gqy0U41GlX6IOfSx
         pVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724948614; x=1725553414;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gHPJKGcIlun/9Pp/lr+BLHcACB0gOURuQHktaiAXVKk=;
        b=dYKm6jwt5xzrONcxCCXc/W5RoHtIN3i1g8SK4CwVbkbA0OqYtPzVqFu/tVNBFgntMv
         YbryRTdfcQo9B3ov8OF1B9o9o9paz+Qu1eN3WBBVAGyd53YuLIpYxD45O/j/Kber0xf1
         61Imkhw+OUnupuAee9epwoiTaZ+H+Mh9znOnXz31lrQ44szgf5NJGc7bOilNB8tpX7YC
         Ug3Xg1YlyWTEVEclJ0iA6+frY1Ll4RzOFYhinJGoUsTMRD39EIyFBQkICHOqCZ0KCJK9
         Fu93JrOEnhVULvzcf5w/Y65XH5jx+IEgNmxeOMOt2u8qsS9xCvl+LVnM0RD/xBQwR49p
         HwzA==
X-Forwarded-Encrypted: i=1; AJvYcCWdhk2lGmdRenOjATWtpbzaomth58JfLZCoXUXRfN+SgM+f0KU6PkCpjHSXbmfpM6/MeEPiptA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9k3SOchfJ2AXdrFKEMIHggCeVD7IHoZMDrRt988NTfDdtnM9V
	keJKZ+pZ3GmPOIKW/op/JGpusjynxlq4zost1Mw+PaIbVQaFovpj
X-Google-Smtp-Source: AGHT+IFj4TRIp3RAXYvu95JSEV7qkvv6l4ehJv4UP3yQAC/43ziE9GlRFzhpZQWj7xRqntat19fZSw==
X-Received: by 2002:a05:620a:258c:b0:79e:f745:5445 with SMTP id af79cd13be357-7a80857489bmr290799985a.31.1724948614391;
        Thu, 29 Aug 2024 09:23:34 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d4287dsm63784585a.75.2024.08.29.09.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 09:23:33 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:23:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66d0a0816d6ce_39197c29476@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoD6s0rrCAvMeMDE3-QVemPy21Onh4mHC+9PE-DDLkdj-Q@mail.gmail.com>
References: <20240828160145.68805-1-kerneljasonxing@gmail.com>
 <66d082422d85_3895fa29427@willemb.c.googlers.com.notmuch>
 <CAL+tcoD6s0rrCAvMeMDE3-QVemPy21Onh4mHC+9PE-DDLkdj-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] timestamp: control
 SOF_TIMESTAMPING_RX_SOFTWARE feature per socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Thu, Aug 29, 2024 at 10:14=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Prior to this series, when one socket is set SOF_TIMESTAMPING_RX_SO=
FTWARE
> > > which measn the whole system turns on this button, other sockets th=
at only
> > > have SOF_TIMESTAMPING_SOFTWARE will be affected and then print the =
rx
> > > timestamp information even without SOF_TIMESTAMPING_RX_SOFTWARE fla=
g.
> > > In such a case, the rxtimestamp.c selftest surely fails, please see=

> > > testcase 6.
> > >
> > > In a normal case, if we only set SOF_TIMESTAMPING_SOFTWARE flag, we=

> > > can't get the rx timestamp because there is no path leading to turn=
 on
> > > netstamp_needed_key button in net_enable_timestamp(). That is to sa=
y, if
> > > the user only sets SOF_TIMESTAMPING_SOFTWARE, we don't expect we ar=
e
> > > able to fetch the timestamp from the skb.
> >
> > I already happened to stumble upon a counterexample.
> >
> > The below code requests software timestamps, but does not set the
> > generate flag. I suspect because they assume a PTP daemon (sfptpd)
> > running that has already enabled that.
> =

> To be honest, I took a quick search through the whole onload program
> and then suspected the use of timestamp looks really weird.
> =

> 1. I searched the SOF_TIMESTAMPING_RX_SOFTWARE flag and found there is
> no other related place that actually uses it.
> 2. please also see the tx_timestamping.c file[1]. The author similarly
> only turns on SOF_TIMESTAMPING_SOFTWARE report flag without turning on
> any useful generation flag we are familiar with, like
> SOF_TIMESTAMPING_TX_SOFTWARE, SOF_TIMESTAMPING_TX_SCHED,
> SOF_TIMESTAMPING_TX_ACK.
> =

> [1]: https://github.com/Xilinx-CNS/onload/blob/master/src/tests/onload/=
hwtimestamping/tx_timestamping.c#L247
> =

> >
> > https://github.com/Xilinx-CNS/onload/blob/master/src/tests/onload/hwt=
imestamping/rx_timestamping.c
> >
> > I suspect that there will be more of such examples in practice. In
> > which case we should scuttle this. Please do a search online for
> > SOF_TIMESTAMPING_SOFTWARE to scan for this pattern.
> =

> I feel that only the buggy program or some program particularly takes
> advantage of the global netstamp_needed_key...

My point is that I just happen to stumble on one open source example
of this behavior.

That is a strong indication that other applications may make the same
implicit assumption. Both open source, and the probably many more non
public users.

Rule #1 is to not break users.

Given that we even have proof that we would break users, we cannot
make this change, sorry.

A safer alternative is to define a new timestamp option flag that
opt-in enables this filter-if-SOF_TIMESTAMPING_RX_SOFTWARE is not
set behavior.


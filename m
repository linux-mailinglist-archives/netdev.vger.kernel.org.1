Return-Path: <netdev+bounces-111765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491A39327DA
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0465528106C
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DFD19AD89;
	Tue, 16 Jul 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x.com header.i=@x.com header.b="nzCD99uN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69DD4D8A3
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 13:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721138211; cv=none; b=EHYKtgkmduBhVeccYwkuNNaEZ8m/OYsKgmMTlBBo5mBH/eTZXwEmswLqF3n8pnuTqSbeT9O7Rg4TEVp2pJV8ZLBBpqOE+cJ8xbJP5qe0yeyqncR5KIK+2zvSL+rZOiJRg/+jNEYbnqr3X6PMdFcBQRaFm7ClXdVNH9xVF2ADasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721138211; c=relaxed/simple;
	bh=KfnE6P/RQNRiyGrsF5lOdZZtHM21PQJc/SBPSowjDac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoDNwZiMdt76SD1Nad2/0tNFgRWGBMY5t0up8gPYrEld6Jj9OxzLhuCdw/ywKUKI8ZaUHqheGW+ptOt2hs7DYy91QIvFWB5ZvPLKjpxfo0mI8Sdx5joYDOt3rHdf7jlFwZg3KGLa2rmlOSUsDnSDOtRGhK7d5SBmMSjsV+lmgt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=x.com; spf=pass smtp.mailfrom=x.com; dkim=pass (2048-bit key) header.d=x.com header.i=@x.com header.b=nzCD99uN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=x.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77d9217e6fso636836366b.2
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x.com; s=google; t=1721138208; x=1721743008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKSK0EfNWiNfPmNxlaLQLUrIusknKg3qMRwvkqo3IhM=;
        b=nzCD99uNVauMW2U137zgYWpjtd7dFyFnCV4Ajk0ckDd4eHwT41gRS9LAzYIDOeGUKg
         Hsq4/NfW8Mmj2oExxoAtubJdtySOXmRZhCUW1zbrufmfs6UqKxUw+mEg+pSEgr/usbYg
         K6T8eR1N38/STAGtlsHCEaI7pCLhyJBI9O3V+HAhw0DnU5910y88TuQrKslIqEMzIbIe
         0wvS5DTNjD1FDbi/xiSGtOJ/Zx3cxRn3Gy/TIdjApodTwRv2uTmbHBQ88S/X/+5HgDpC
         6zg7GlMZ0RyBBwBA+8cim5TcLX6zxiqu2usPrhHTcBbE7OXyFbnxOKXUHd2MSfz7lRFK
         1Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721138208; x=1721743008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKSK0EfNWiNfPmNxlaLQLUrIusknKg3qMRwvkqo3IhM=;
        b=fdyWOwvmeM0ty1i0WWmMn+XUOA9NDE+eEjKIqWVmQl+jQvdS0+lO84l9UORLcugOuW
         PtDolHoaXSNlUZmi5B43HtQBPtnr1tn02CQMHSCnlqU4Ko8dap32tCn8/hPBkX435uDn
         Sj4+oToZO1SW9T8ugd+Phto3rTbbCoZefA/FuIuysRWTiWg00sBuBfSGfkuDQG6gSnCg
         BhMggYsXx6EFxakIp/1D1apAUTyII6YlRZcy3+qr15WRJAMWS8stbuvZmuj+zOCG1vbf
         Dc6Igy6K/k/noWkyfRP9Eomnz74HRXAGIcHSoyiei5oaJ62Cyx8lJRxEL0B48QdT996z
         /yMw==
X-Gm-Message-State: AOJu0Yw1RgvDaOytD0pzApNs9e3LuhwaKxVuLoHCcUJyk72m+UB94gBV
	hA2JWy312wQQDREUC4St8uy8DG8PnfwdH5TVzK8/cuBpGoxxjZScHSQHl8yIIA0OMqJQdfSe2g2
	EUxEbuBGEggyyopV7V3tjGR0yU+KQoftqcmoWrA==
X-Google-Smtp-Source: AGHT+IHJsPwNxVI4JtpQgNjGDW90M+bww6CWreuXQh/zXF8eDM46g0hS4tl0mXlSz17Q4fJyw3hA3F/IGFSiYAH01Qc=
X-Received: by 2002:a17:906:6d46:b0:a77:cd4f:e4ee with SMTP id
 a640c23a62f3a-a79eaa844fcmr134777866b.69.1721138207996; Tue, 16 Jul 2024
 06:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHXsExy+zm+twpC9Qrs9myBre+5s_ApGzOYU45Pt=sw-FyOn1w@mail.gmail.com>
 <Zo_bsLPrRHHiVMPd@shredder.mtl.com> <CAHXsExy8LKzocBdBzss_vjOpc_TQmyzM87KC192HpmuhMcqasg@mail.gmail.com>
 <CAHXsExwuSyn7eVMqiOcatU5C3WHsdHEnLJcVh-jf2LjmzW2Edg@mail.gmail.com> <ZpPIaNsT3lzEPi4r@shredder.mtl.com>
In-Reply-To: <ZpPIaNsT3lzEPi4r@shredder.mtl.com>
From: Jason Zhou <jasonzhou@x.com>
Date: Tue, 16 Jul 2024 09:56:37 -0400
Message-ID: <CAHXsExw+e+wC+_MarAoDjch2rr5exosMCo4OZKPrhpSeqSm=Vw@mail.gmail.com>
Subject: Re: PROBLEM: Issue with setting veth MAC address being unreliable.
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org, Benjamin Mahler <bmahler@x.com>, Jun Wang <junwang@x.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it, thank you so much for the help!

On Sun, Jul 14, 2024 at 8:45=E2=80=AFAM Ido Schimmel <idosch@idosch.org> wr=
ote:
>
> On Fri, Jul 12, 2024 at 05:02:13PM -0400, Jason Zhou wrote:
> > Hi all,
> >
> > We have performed our own testing with the MacAddressPolicy set to
> > none rather than persistent on CentOS 9, and it fixed the problem we
> > were seeing with the MAC address mismatches before and after us trying
> > to manually set it.
> > So we're pretty confident that the cause is what Ido stated, and that
> > we were racing against udev as we did not set a MAC address when
> > creating our veth device pair, making udev think it should give out a
> > new MAC address.
> > We will release a patch on Apache Mesos to mitigate this potential
> > race condition on systems with systemd version > 242.
> > Thank you so much for the help!
> >
> > For documenting this issue, I believe that this race condition would
> > also be present for the peer veth interface?
>
> Yes, but when creating the veth pair you can set the addresses of both
> devices:
>
> # ip link add name bla1 address 00:11:22:33:44:55 type veth peer name bla=
2 address 00:aa:bb:cc:dd:ee
> # ip link show dev bla1
> 11: bla1@bla2: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOW=
N mode DEFAULT group default qlen 1000
>     link/ether 00:11:22:33:44:55 brd ff:ff:ff:ff:ff:ff
> # ip link show dev bla2
> 10: bla2@bla1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state DOW=
N mode DEFAULT group default qlen 1000
>     link/ether 00:aa:bb:cc:dd:ee brd ff:ff:ff:ff:ff:ff
>
> > We create the peer along with veth and move the peer to another
> > namespace, but udev would be notified of its creation, so it will try
> > to also overwrite the peer's MAC address.
>
> The peer can be created in the desired namespace with the desired
> address:
>
> # ip netns add ns1
> # ip link add name bla1 address 00:11:22:33:44:55 type veth peer name bla=
2 address 00:aa:bb:cc:dd:ee netns ns1
> # ip link show dev bla1
> 10: bla1@if8: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode D=
EFAULT group default qlen 1000
>     link/ether 00:11:22:33:44:55 brd ff:ff:ff:ff:ff:ff link-netns ns1
> bash-5.2# ip -n ns1 link show dev bla2
> 8: bla2@if10: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode D=
EFAULT group default qlen 1000
>     link/ether 00:aa:bb:cc:dd:ee brd ff:ff:ff:ff:ff:ff link-netnsid 0
>
> > However this is not an issue for the loopback interface that comes
> > with every namespace creation, as they will not be affected by
> > NetworkManager and hence udev will not try to modify them.
> > Please correct me if I'm wrong!
>
> AFAICT udev ignores the loopback devices because they have a type of
> ARPHRD_LOOPBACK, unlike the veth devices that have a type of
> ARPHRD_ETHER.


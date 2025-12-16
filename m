Return-Path: <netdev+bounces-244923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A0CC2CFE
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 13:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 661D7301B826
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 12:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3103034D39C;
	Tue, 16 Dec 2025 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kma4nztI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPYD01gm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7733734C991
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886408; cv=none; b=i39MFhkQcVfMIfhxKF5SRMoZnU7XeNSSRcP1eesxGpMEeRoRsP4bnl+/AmHtL6J2teVm+2xHBiEjLN+rNADJTJcWK8prRl/m1uBqAc7EtDfGigoHI1adAvH1djG9SiEOWs/IZdh0OKrjGSN8ocymsrd+Ec5JzMZCHX+GEk6dzUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886408; c=relaxed/simple;
	bh=RXYeLW2XkvvCnEbbRD0mciJ2uRel61TJ/NONGFAsFp0=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHvISNh2+y0K+/QlhcZ0r8OtIrOK3TaTbWtuulDPqw3OwYgMR1ZmcBZ4OrTRAbuWOI+nhzpJYDIofI0SFRyBGr9w7MGLkZ5blZW1H0n+l7KdPTZtvGqJAMuJvxdoOon4Zvu3D3ZGk1cfZaI1+DskhwFIkeLG8EshC6j62hXTsRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kma4nztI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TPYD01gm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765886402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXYeLW2XkvvCnEbbRD0mciJ2uRel61TJ/NONGFAsFp0=;
	b=Kma4nztII6/oHW3x0BsuusJb7FrEXMoPyOFt6WIJpI7Ft93/eUkHEpfVS0vHK/0O27A+sq
	52oh+/NpDsqjH1XUXTfNtkrAKOv3c6BfI1TfbHzoRLzNOnlY76rD17nOuWHdePbdV5+SBH
	ZINMjdXH4EkPcQImKJOXH2Tr5y6VLrY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-uwNgMn61P-Kuj3UQoAiY_Q-1; Tue, 16 Dec 2025 07:00:00 -0500
X-MC-Unique: uwNgMn61P-Kuj3UQoAiY_Q-1
X-Mimecast-MFC-AGG-ID: uwNgMn61P-Kuj3UQoAiY_Q_1765886399
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b79f6dcde96so1005758466b.2
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 04:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765886399; x=1766491199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXYeLW2XkvvCnEbbRD0mciJ2uRel61TJ/NONGFAsFp0=;
        b=TPYD01gm33EarBKCBBnmvE76KQ9Hi+BGW0g6b19LOQX6BaCkaV+1jCENeI0OIA3klu
         ioudNcGhkpU6OSzMO4XEb88o6WctXLPhKFfgVfwGwpgwT6V9XH1iMUHpR4Bq5wtZkzSZ
         OWnX9ncGqZf0G+6dJvKCttE7GtbIJ0DZ2rYMjuazp6k4YBrHRv0YhcAKoLZ0FQSeTH48
         zpIgd+YEFXmNjj16GJW76FsO3l1W+sVWNxTZ38btoETQy4mkgGU3yyTZ3m0flwp4/gxK
         L7lykp8gRNpJbH8/NdcEVRJaDeHM6BamWOpNnthak+eMiT8vcScCadb5+QOur6YLLaD3
         Uysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765886399; x=1766491199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXYeLW2XkvvCnEbbRD0mciJ2uRel61TJ/NONGFAsFp0=;
        b=cBroQPSvov/AG26wx/OdSBvS2cT2il5LbjabIaMvMa6fPp2//9WtjYReTM/kNljGgG
         nNrUA0Lr+OuQJ+ZL4qN7ru36LEskDZZpdLLHqOqUdlPBG3zwMQe9lQR+7QXl3kfX8+r1
         pvuWbkJTmVCZCScVkYKHvgdbtIHIGInEQWEeT7wx4Qw/wV7dA03oFm3lP6tWF38FQpeo
         k/Q8HcuXza9Ko/lgggj8cF2wo+DnRbpkvckzL6fk2EFc0Erompu/zhgHzkcbW9XiNnz+
         ZP4wdXOC8ahb+q5uXGGRf1P/IqmPjME+FeUJMgx82XKiY23uw0pvZf+D8T6jb7BUF57n
         QDyA==
X-Forwarded-Encrypted: i=1; AJvYcCXYNYV5pPSnP0JwYrQwDZ28n4ccTdbMv8gQB7Gx+J+HrPsNvud1rr/R6dDSh0OGYR+18XBBtqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7bXtkxLqvDvknvEx/8npe94/MveXdoLjUS96HuhTGGuxDZM5U
	1PEjN173qO8HsyYk5dT0AxUJS+G30SpXRb7ADPn9LyslYkutIjKTQbUFWuubHcxpSTPk/UNAiQU
	FgviHlXivlMH8Yisl0ZQdnihZk12Kk1dY3d1da+sXSiklW/jNBOs2zefmAMTWXs0CuqnbLIJDMq
	fPXBHKpIA4Gz5Rgj0YJ2mlwp0XZwgtzGnT
X-Gm-Gg: AY/fxX5rCCwSY17gh90dMJzS6qCZF8sxcDfn3JOIbHgPE6ITWYnP2l9WxtYX2GSPF2Y
	IshA7R5LCfUbbytiECy0l3GboM9qxIWCUsRUWN5BzJuvCOkPhmPuIlJEmFBmp5k9Q7Rn+QmPrmW
	3iKR4WHHjVsdj+t2FtD8mryGiA+p2/KX1lx9sBSg+j1phirm2QzK86Y5B4P/PIu9H9mR99
X-Received: by 2002:a17:907:7296:b0:b79:ecb0:db74 with SMTP id a640c23a62f3a-b7d23d11086mr1315644066b.59.1765886399406;
        Tue, 16 Dec 2025 03:59:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEPKy1Hw/u0C7BzYtJuy83NwNy1BeV3TwcUncJkKLgQxEHkFGCD3kgPt0u+a+yZMBB9+s+C+7ah7s6rCxO5p8=
X-Received: by 2002:a17:907:7296:b0:b79:ecb0:db74 with SMTP id
 a640c23a62f3a-b7d23d11086mr1315640766b.59.1765886398975; Tue, 16 Dec 2025
 03:59:58 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Dec 2025 11:59:58 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Dec 2025 11:59:58 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20251211115006.228876-1-toke@redhat.com> <f7t5xa7anvk.fsf@redhat.com>
 <CAKDHXDHsdfRfaDyfzoTymsPkm=mPdFtJOA=GHb6HGx6TjvYA7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKDHXDHsdfRfaDyfzoTymsPkm=mPdFtJOA=GHb6HGx6TjvYA7w@mail.gmail.com>
Date: Tue, 16 Dec 2025 11:59:58 +0000
X-Gm-Features: AQt7F2oESsHo2hZgAlHuocZrz0XEUSt0irAWdNZP-YQ3iOXqnP75EaSgWFxNfNM
Message-ID: <CAG=2xmM_AyOmvDbuAi7CmgGDhtYkDDe_kmFG_iAc11JqnbHhuA@mail.gmail.com>
Subject: Re: [PATCH v2] net: openvswitch: Avoid needlessly taking the RTNL on
 vport destroy
To: Vladimir Shebordaev <vladimir.shebordaev@gmail.com>
Cc: Aaron Conole <aconole@redhat.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Alexei Starovoitov <ast@kernel.org>, Jesse Gross <jesse@nicira.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, dev@openvswitch.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 04:31:14AM +0300, Vladimir Shebordaev wrote:
> Perhaps, ovs_netdev_tunnel_destroy() is also worth to be modified this wa=
y.
> It is invoked as a vport destructor in similar code paths and even has a
> nice comment about its double duty.
>

In this case OVS owns the underlying tunnel device so it's less likely
that someone will delete it by other means. Still, I think you're
right and we could spare one RTNL lock in such case.

We can fix this in an independent patch so that Fixes points to the
right commit.

Thanks.
Adri=C3=A1n

> --
> Regards,
> Vladimir
>
>
> On Mon, Dec 15, 2025 at 4:16=E2=80=AFPM Aaron Conole <aconole@redhat.com>=
 wrote:
>
> > Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
> >
> > > The openvswitch teardown code will immediately call
> > > ovs_netdev_detach_dev() in response to a NETDEV_UNREGISTER notificati=
on.
> > > It will then start the dp_notify_work workqueue, which will later end=
 up
> > > calling the vport destroy() callback. This callback takes the RTNL to=
 do
> > > another ovs_netdev_detach_port(), which in this case is unnecessary.
> > > This causes extra pressure on the RTNL, in some cases leading to
> > > "unregister_netdevice: waiting for XX to become free" warnings on
> > > teardown.
> > >
> > > We can straight-forwardly avoid the extra RTNL lock acquisition by
> > > checking the device flags before taking the lock, and skip the lockin=
g
> > > altogether if the IFF_OVS_DATAPATH flag has already been unset.
> > >
> > > Fixes: b07c26511e94 ("openvswitch: fix vport-netdev unregister")
> > > Tested-by: Adrian Moreno <amorenoz@redhat.com>
> > > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > ---
> >
> > LGTM,
> >
> > Acked-by: Aaron Conole <aconole@redhat.com>
> >
> >
> >



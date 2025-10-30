Return-Path: <netdev+bounces-234429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD1BC2094D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C00B34F2DD
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0681726A1B5;
	Thu, 30 Oct 2025 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FW1r1LY5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722CE25A34B
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834495; cv=none; b=bHrpk8vUqP133BTAL/nli0fpMZMn7/+C+Y5v1NfOKbw53w3CCrtGxPxDFY4NTRNG8ww3Mle3/7Agxq5NWu8CRGrSAu1RJTBrNjuEXUuWWWzgDaILdugPSR9IPBra8THrYcB3UcqP/0aUaZgsOvow0DW+JwxZkd+RIAJDtkuTk2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834495; c=relaxed/simple;
	bh=XofufYTIvVz0xFJFDMwmm6sP18q7o2xd40JtSUXhtAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GK7CWuK1cmxRlOVFtmJr4gEZGp6h+Tnf6PyTkumuDcl5AIXIBEemvkLZzhZfGV9xphjS/ObKDs2R980/bfY/aayDC/EjF5TEfBy3WNDVTP6H9f9hvV2OHHxwqJ2x0Pj/nB+O6I/4Scac9iIAYvEnZ8buRGoudSI8DTxaGpyJyx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FW1r1LY5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a4c202a30aso1275097b3a.2
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 07:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761834493; x=1762439293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuCA5wWQIDpUIW6qlKdvaKlw1rWMEkNLw7LaZvFkQQE=;
        b=FW1r1LY5MXOhfTBolumPD7ILbPaooLDt/Aiwoni7dB8VechTrX4GStZhFvQeCAyiBC
         VTI5QIzXr+rRsb1pFgg788Vqt1EeLm3Vgh5CG0wP26Zhvwv0no54RaRA/rnsM9LWHCDh
         Bz5PFu5nzhvmUpdSGS4TCJ9VfXAuvqFuOHO2ItydtTlD4DR/R/ig9c+cpePuaTblfVVe
         PCbGzJKAuIjxFpfGFA/86c+uDt4/DEbZU9OmLfw9iw6sGJ43xiXdXhPfHeCkXF9DMelH
         9FXmAnBFlf+xDdmpGlAQXr30iChx9Hda+KcmiyJ0GgDYX2JvgidiNIABR8ac6rilqccE
         j6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761834493; x=1762439293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuCA5wWQIDpUIW6qlKdvaKlw1rWMEkNLw7LaZvFkQQE=;
        b=MRM6DpKS3dfX5oqAkuUSMMTrxvPM3FTBF8e2xyce/Yr6HTMWJSEjqQ2WG3LBQcQRdZ
         DgZ/4/Ke44scvxxvrzgUPVTO5oOvPcvUQWkq7gsiJIxc5xffoch16U5wWBufRJMKnuJT
         AlqKAj1aV4waW4oq79kmeOG0kCd3nYuqYWYBP8lz2W0nPHklgg8LEWOt3LiARBNybcG9
         ar/+Jmk+KCfzAXoAbG1Kx59x/P+zaXyKVcqPclS88NS5xoiZmjoQWxFaYJNjGffWcFWH
         KGRKLhjN79XyRHhx9LOkdhISK5IRqyg3oUVsWBGar6J2klCuRqHQcp2JfmdYybgI4QHC
         fXOQ==
X-Gm-Message-State: AOJu0YzTRRudow317EWnq+tK/dMj7fOId72y+pQmoR4pIn7CK1uwbXtO
	53DXKWhHvUsPdtP42Mx2MAyMIoOofMxdwqk1u212hRqaeiEGBPRyuxhAuvhFmZB8rlN3HXOHvTa
	YKW0IWoh/kQq0rtivL3btm1dZ5sBJ1IQ=
X-Gm-Gg: ASbGncsuEvhkKcviFRgscPrt9nLYp3Lzm0FOqTSVRz9cR33k9HYURTaBZeUXXY+JOAu
	X6SxymZAU8z7nWPsRxfVpx7lTcTj5DvWdcZDUHPTl4jzIRXv32L93srml/CQ7L3kLu9BgLNLdzL
	11Kdp306u64HF+yRaRFriN6yGrZHymaZ1v41gNoGVKRLvAdhxWjbd61cstTPPb8x0X8CnPbJAp0
	el2yGiCHXuTuzm+M4TwXmZg2S2KGpCtkHAjyWQOrC332/7RjmOSmk4BNtVrDBxJ25fIP8o79NuW
	qn0qbs+3lqNWWIJd2QwpVCEgmNfj
X-Google-Smtp-Source: AGHT+IGSYvw5mArOho8Chrlid2Yf9zFIgqFqjnuZ41Vc14qeGP9OaC3SkBO5TkyH/r8UCkIM4dvPWepO1U0aCamvif4=
X-Received: by 2002:a05:6a00:181b:b0:7a3:455e:3fa5 with SMTP id
 d2e1a72fcca58-7a621813833mr5006811b3a.0.1761834493501; Thu, 30 Oct 2025
 07:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761748557.git.lucien.xin@gmail.com> <91ff36185099cd97626a7a8782d756cf3e963c82.1761748557.git.lucien.xin@gmail.com>
 <67b38b36-b6fa-4cab-b14f-8ba271f02065@samba.org> <CADvbK_f4rN-7bvvwWDVm-B+h6QiSwQbK7EKsWh5kTuHJjuGjTA@mail.gmail.com>
 <b9300291-e828-47fa-b4d1-66934636bd7b@samba.org> <CADvbK_f=E11=dszeJos98RvBY5POXujgT0dFo-LG6QQuGW20Kg@mail.gmail.com>
 <0b65e74c-71bb-494d-9b05-0ee20f27e840@samba.org>
In-Reply-To: <0b65e74c-71bb-494d-9b05-0ee20f27e840@samba.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 30 Oct 2025 10:28:01 -0400
X-Gm-Features: AWmQ_blojTdIYKtFmYVhDD9RZMLgIE9kL3y8nlMJgL7u2g9jepaBDc3oSEs4qws
Message-ID: <CADvbK_cPEnNfcUXaHm3Aub0dkerqnwG4NB_EJ_eQZTc80c28_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v4 02/15] net: build socket infrastructure for
 QUIC protocol
To: Stefan Metzmacher <metze@samba.org>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Moritz Buhl <mbuhl@openbsd.org>, 
	Tyler Fanelli <tfanelli@redhat.com>, Pengtao He <hepengtao@xiaomi.com>, 
	Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Benjamin Coddington <bcodding@redhat.com>, Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe" <alibuda@linux.alibaba.com>, 
	Jason Baron <jbaron@akamai.com>, illiliti <illiliti@protonmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Daniel Stenberg <daniel@haxx.se>, Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:17=E2=80=AFAM Stefan Metzmacher <metze@samba.org=
> wrote:
>
> Am 30.10.25 um 15:13 schrieb Xin Long:
> > On Thu, Oct 30, 2025 at 7:29=E2=80=AFAM Stefan Metzmacher <metze@samba.=
org> wrote:
> >>
> >> Am 29.10.25 um 20:57 schrieb Xin Long:
> >>> On Wed, Oct 29, 2025 at 12:22=E2=80=AFPM Stefan Metzmacher <metze@sam=
ba.org> wrote:
> >>>>
> >>>> Hi Xin,
> >>>>
> >>>>> This patch lays the groundwork for QUIC socket support in the kerne=
l.
> >>>>> It defines the core structures and protocol hooks needed to create
> >>>>> QUIC sockets, without implementing any protocol behavior at this st=
age.
> >>>>>
> >>>>> Basic integration is included to allow building the module via
> >>>>> CONFIG_IP_QUIC=3Dm.
> >>>>>
> >>>>> This provides the scaffolding necessary for adding actual QUIC sock=
et
> >>>>> behavior in follow-up patches.
> >>>>>
> >>>>> Signed-off-by: Pengtao He <hepengtao@xiaomi.com>
> >>>>> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> >>>>
> >>>> ...
> >>>>
> >>>>> +module_init(quic_init);
> >>>>> +module_exit(quic_exit);
> >>>>> +
> >>>>> +MODULE_ALIAS("net-pf-" __stringify(PF_INET) "-proto-261");
> >>>>> +MODULE_ALIAS("net-pf-" __stringify(PF_INET6) "-proto-261");
> >>>>
> >>>> Shouldn't this use MODULE_ALIAS_NET_PF_PROTO(PF_INET, IPPROTO_QUIC)
> >>>> instead?
> >>>>
> >>> Hi, Stefan,
> >>>
> >>> If we switch to using MODULE_ALIAS_NET_PF_PROTO(), we still need to
> >>> keep using the numeric value 261:
> >>>
> >>>     MODULE_ALIAS_NET_PF_PROTO(PF_INET, 261);
> >>>     MODULE_ALIAS_NET_PF_PROTO(PF_INET6, 261);
> >>>
> >>> IPPROTO_QUIC is defined as an enum, not a macro. Since
> >>> MODULE_ALIAS_NET_PF_PROTO() relies on __stringify(proto), it can=E2=
=80=99t
> >>> stringify enum values correctly, and it would generate:
> >>>
> >>>     alias:          net-pf-10-proto-IPPROTO_QUIC
> >>>     alias:          net-pf-2-proto-IPPROTO_QUIC
> >>
> >> Yes, now I remember...
> >>
> >> Maybe we can use something like this:
> >>
> >> -  IPPROTO_QUIC =3D 261,          /* A UDP-Based Multiplexed and Secur=
e Transport */
> >> +#define __IPPROTO_QUIC 261     /* A UDP-Based Multiplexed and Secure =
Transport */
> >> +  IPPROTO_QUIC =3D __IPPROTO_QUIC,
> >>
> >> and then
> >>
> >> MODULE_ALIAS_NET_PF_PROTO(PF_INET, __IPPROTO_QUIC)
> >>
> >> In order to make things clearer.
> >>
> >> What do you think?
> >>
> > That might be a good idea to make things clearer later on.
> >
> > But for now, I=E2=80=99d prefer not to add something special just for Q=
UIC in
> > include/uapi/linux/in.h.  We can revisit it later together with SCTP,
> > L2TP, and SMC to keep things consistent.
>
> Ok, maybe this would do it for now?
>
> MODULE_ALIAS_NET_PF_PROTO(PF_INET, 261); /* IPPROTO_QUIC =3D=3D 261 */
>
Yep, fine by me. :-)

> I'll do the same for IPPROTO_SMBDIRECT...
>
> metze


Return-Path: <netdev+bounces-149131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207509E4641
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 22:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEC616566A
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F21019007D;
	Wed,  4 Dec 2024 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yourpreston.com header.i=@yourpreston.com header.b="gdcb+PUw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA218C345
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733346311; cv=none; b=C2xQlG0TVmYGPOOebH4bBYjjnHXLiq6Tq24zsViUI/TYx11UFOLRXzKs6HxQFzzwuPo0QgiKxTgkwus9VFn7j9eoMXkLq9eIR0OdqdlH7q1MRTGPDqW0XI21ojzqzP0iJA9fUZI7hPP8E195RXB5v+wFOiJ8l+Mcr1CbEyCB/Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733346311; c=relaxed/simple;
	bh=HPP95/V3ZgiBzsuRrCJ27jnNYObM+Jwaft4QXccC/z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9ZNvoJYIN4GLx6MCfh/IkdI4B7jdaDyPZnDuUfGyXAROMWS9jvGE18oOM5qdKSCMGUlWNLCgm5N2EdqzOeF9rBiy8iq9+GYapAiQ09I0EGAmsZJtNQXW/YlWZ2kXmapBllgJcCdwqZs+vRd+oOmUs86Ylr3eTKEnLnAVeqhIQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yourpreston.com; spf=pass smtp.mailfrom=yourpreston.com; dkim=pass (2048-bit key) header.d=yourpreston.com header.i=@yourpreston.com header.b=gdcb+PUw; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yourpreston.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yourpreston.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e3983426f80so287961276.1
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 13:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yourpreston.com; s=google; t=1733346308; x=1733951108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPP95/V3ZgiBzsuRrCJ27jnNYObM+Jwaft4QXccC/z8=;
        b=gdcb+PUwc+MEXTS2i0Qz/1XAbpXlGJCVWST1hefTCoATmoy0gwAVvbbgZdq71n1A1A
         4vjS8Vby7yJHRzNYPaFpLzEu+q94XzJ/77X6mfNpjql491HPe+NQOIK1kEQVKAL0iB16
         gtnUMz7898HlMXOqvF2EBU99SpRp5gb/bi9FUA2aSFWBEvEC/mD7pGHKwYCHyEt6Imsv
         KXswj/555DorhJyQKScUiSOfjj2m6HBfj9Qpq3gb/CBPV1d4ybd46hzfZ+Zu2kGiyp4x
         ovjdaeyS7B0Jf3c71QcRdJ8A+L1rKRYOx+O39OnkdxjHvX4Q3wCEHYZhJM+VFXK/TzG5
         hw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733346308; x=1733951108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPP95/V3ZgiBzsuRrCJ27jnNYObM+Jwaft4QXccC/z8=;
        b=PwT+JWyz3STBSssmFa3umRXTsILpxzXemMMxIEOHvFuCabu+eBgaFygsywmmEMmVVJ
         JBZ9x9ikpnBOD7hsloIxjAidvRcmaAHE6Z889Yjc8K41TN6lAwKI0C1rNHDfuR4gtJ19
         0Ka73W1jUyxivGP4mvHamuUDlLuF/F1s+INNiBA7xS4SZEcwFTwnGsWDJyjO0deyBhu7
         vL3dOW9hMgE/tQN15bBzXpCWcGjM+GDiw6Tam9Mfj3R21zUk8WBzGRWQ5huqlLIhgIIQ
         itG+hqV8ddmDXFK3wbJb4felskgtdIDkDLmmVlKbNeobCP+p6QS/rBWn2+fPLuhOLiQD
         /5OA==
X-Gm-Message-State: AOJu0YxAe1FGVJftBNR99ujHkhoOgpVTDhpB5ii68V/i1+9tmapN64Fr
	qRdfyxWA+mP+raXY11RpoeIlWTSgemk1VwtYdeI+hOcjWm8KLe6OpAf9aepkcu5ISxI/IR8MI1n
	DChjYgCjhkDigeB6lQxrB9BW+o+1uTy2QzxclNTXvTS4HAVYO
X-Gm-Gg: ASbGncuAaZXK1/daYu/QakEh8cfapkh76l6IRJthy8dZkLpBbEWEjKW15FJah/eDPuC
	FdZRDEKMGt/nwh1ELTLR1+fW2SVylRySbPUawqko3/SSBATTukA3UgIZaMDI0sQ==
X-Google-Smtp-Source: AGHT+IGlk1ZpGnFl7WAP3x8Zv1q10Uv0TSuwr0MS3/ol7YnQqLyxXbrm4Z2zN5zVz4xPQZyGGLtOQiKKotZcSMFjKeQ=
X-Received: by 2002:a05:690c:6012:b0:6ef:96f9:2f48 with SMTP id
 00721157ae682-6efad3591b2mr98678207b3.37.1733346308149; Wed, 04 Dec 2024
 13:05:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBfiem067qtdVbMeq2bGrn-5bKZsy_M8N-4GkE0BO6Uh7jX1A@mail.gmail.com>
 <3e6af55f-3270-604b-c134-456200188f94@katalix.com>
In-Reply-To: <3e6af55f-3270-604b-c134-456200188f94@katalix.com>
From: Preston <preston@yourpreston.com>
Date: Wed, 4 Dec 2024 16:04:57 -0500
Message-ID: <CABBfie=3+NBmjpVHn8Ji7VakEo9-JMKDH3ut5d1nXnDneC0tPw@mail.gmail.com>
Subject: Re: ethernet over l2tp with vlan
To: James Chapman <jchapman@katalix.com>
Cc: netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

l2tpeth0 is not attached to anything, it's created by the `ip l2tp`
commands. But since it's encapsulating and setting a new destination
IP address, packets are referred to the route table.

On Wed, Dec 4, 2024 at 6:48=E2=80=AFAM James Chapman <jchapman@katalix.com>=
 wrote:
>
> On 03/12/2024 16:14, Preston wrote:
> > Hello folks, please let me know if there=E2=80=99s a more appropriate p=
lace to
> > ask this but I believe I=E2=80=99ve found something that isn=E2=80=99t =
supported in
> > iproute2 and would like to ask your thoughts.
>
> Thanks for reaching out.
>
> > I am trying to encapsulate vlan tagged ethernet traffic inside of an
> > l2tp tunnel.This is something that is actively used in controllerless
> > wifi aggregation in large networks alongside Ethernet over GRE. There
> > are draft RFCs that cover it as well. The iproute2 documentation I=E2=
=80=99ve
> > found on this makes it seem that it should work but isn=E2=80=99t expli=
cit.
> >
> > Using a freshly compiled iproute2 (on Rocky 8) I am able to make this
> > work with GRE without issue. L2tp on the other hand seems to quietly
> > drop the vlan header. I=E2=80=99ve tried doing the same with a bridge t=
ype
> > setup and still see the same behavior. I've been unsuccessful in
> > debugging it further, I don=E2=80=99t think the debug flags in iproute2=
's
> > ipl2tp.c are functional and I suppose the issue might instead be in
> > the kernel module which isn=E2=80=99t something I=E2=80=99ve tried debu=
gging before.
> > Is this a bug? Since plain ethernet over l2tp works I assumed vlan
> > support as well.
> >
> >
> > # Not Working L2TP:
> > [root@iperf1 ~]# ip l2tp add tunnel tunnel_id 1 peer_tunnel_id 1 encap
> > udp local 2.2.2.2 remote 1.1.1.1 udp_sport 1701 udp_dport 1701
> > [root@iperf1 ~]# ip l2tp add session tunnel_id 1 session_id 1 peer_sess=
ion_id 1
> > [root@iperf1 ~]# ip link add link l2tpeth0 name l2tpeth0.1319 type vlan=
 id 1319
> > [root@iperf1 ~]# ip link set l2tpeth0 up
> > [root@iperf1 ~]# ip link set l2tpeth0.1319 up
> > Results: (captured at physical interface, change wireshark decoding
> > l2tp value 0 if checking yourself)
> > VLAN header dropped
> > Wireshark screenshot: https://i.ibb.co/stMsRG0/l2tpwireshark.png
>
> This should work.
>
> In your test network, how is the virtual interface l2tpeth0 connected to
> the physical interface which you are using to capture packets?
>
> >
> >
> > # Working GRE:
> > [root@iperf1 ~]# ip link add name gre1 type gretap remote 1.1.1.1
> > [root@iperf1 ~]# ip link add name gre1.120 link gre1 type vlan proto
> > 802.1q id 120
> > [root@iperf1 ~]# ip link set gre1 up
> > [root@iperf1 ~]# ip link set gre1.120 up
> > Results:
> > VLAN header present
> > Wireshark screenshot: https://i.ibb.co/6rJWjg9/grewireshark.png
> >
> >
> > -------------------------------------------------------
> > ~Preston Taylor
> >
>


--=20
-------------------------------------------------------
~Preston Taylor


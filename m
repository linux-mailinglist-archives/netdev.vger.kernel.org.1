Return-Path: <netdev+bounces-241616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4C6C86D9B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 20:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D763B3B47
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB79B2528FD;
	Tue, 25 Nov 2025 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idWHkSoK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BEF14A60F
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764100144; cv=none; b=BsKZdpfSjCgNO1utSGiwm//yr7OOUF4Rbb7eMeZAACNUbOIxCZqrXOf/vLc4IgZTr9tcOf9I68AajmdbiSytQ4gQiw06F5IZ4nVj17Z5Ia+A5uL0IbHUg7hdbNdHIef4KFaYuso9XenX/iSrjLL8Ttjmui1Gip2RfMW0jHsyX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764100144; c=relaxed/simple;
	bh=8/8WviDR3rBrPnZQvPWbiLIGHoiE98GcL2ax/kd7oZU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=vBhZolDGTD4yeZz66NtnWRU3kXSEkL6c89qA8kwPI9wVCF/rmXWbMJBvDez39Poi7gxJR3uaoNem1isLWBkKmaBtkSfFfs0BsgmaXsib81qOpKH52rqQE02iZgTvcuM8Ky08mVRGe52cLwu8HL93WoDlk7ASuq4Vbb2eATO+lrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idWHkSoK; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63fc6d9fde5so5113221d50.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 11:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764100142; x=1764704942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZ+EpPyNrsjZ2UV6kbrjxv5BqviVgaVeEt2je+cwub0=;
        b=idWHkSoKHgDYV5ixGJb2aBhxdHUCxIild72VS1QV/9dPi4S4KzsS8b2wdKeROkfsnA
         iWHSL4GCl9TbvTxTMOYDy4lQdo3xelBMJSb9N7RdVC/KxUMgYe3oMxXOm/lx7tasdxDo
         8stZAGDp9u5sEmOjoAlObYocEBKaYrfwbjDLD2BzB/quvAhOmGClwUtOdF93oB96ovDf
         vnjiRiY6ua65pNXYWDNaUk8d7GWvzsK4CJyIcvOo+N623UUDOQjgnmuhuNzgn/2YTdes
         lcJJnvn1YV2ffXa/MNRgbcVN+1KKh0gUzu47XQiXyp+N0I3iIZZ289rEgSIYbQ3BS/mU
         twjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764100142; x=1764704942;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BZ+EpPyNrsjZ2UV6kbrjxv5BqviVgaVeEt2je+cwub0=;
        b=tdoqb5sZrbYFUYkiARXb3CfZUXkDem7yRkFM9Euk7m/sueVSveYd5A6fRrJ2traRLe
         1oUPxxJ6kThDo2Ht56hEdKvDDCr5tOh3XIDhE6dPeY94g4+yC3cX5UFQrQHYjKPoPWGa
         VDytjwzt0DyKTg8KMaO9ZEiRxkttej5WyBdrbs+YkF44/j6Rw2EVs6p2bQ2Cqh8JVBKB
         llxCo30+UGbAJDr2J3VzaqiCSWyEJ1aZ6tOyOe+n/MRTSMowQtpqXnzOXng/OKJCv+Zh
         Fkm/ahUSZAQaCNxf2F8BpBIKm9YC7VIUWJvAgw6ITaDGHyUFPq01MSweDQzKkEk3Yvje
         gcOw==
X-Forwarded-Encrypted: i=1; AJvYcCWCeT4stVDEwbnRRNVt/0iWpUPmYfYFIVe01BRh5sF5z/gB1ZKE+D5IM/tjX8NIWLxHF8Xc4Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5rgIdGpGOyrLK9nkkokpnrNgLWPmrckS/oRKzaY9QB8tpX4nz
	jCaimRwwWjoJOivXhUVxznHzHY9dRfOQ7aeLzrrOiXLcSUvEB1n8CDi5
X-Gm-Gg: ASbGncvAdtmY2SkbBlxTYxLX259/vpuvAlzkjv3RUgMKS9g6/6E/+vaezkhriy9ZsMz
	sqgaRnzAQSfKqC+ooeeEw4IESM5VovyVgCUh7lxFCjcdL/ZOH9Rv5jqyXzITaTMWdaGtFjX5ESe
	vZem/7+MDs4MEKFx8fQfr4ESKlQ6OpxHBxyR2MSZfMXt/nduSWX94nBpr0ej58U0soo3QphxBX3
	nouRixPfGvsnXF+F36tSOGu8e1ZzOUMBknVhgNL3tN7mbgmMul2ZLnKELp/jUokWx06qBOBO1S0
	skxLKC6XiXnmuy0bCHMCH0RfDB9n6uMyjY9guRpfZXtAqGdQ7S92qRtEwCprm6QOl1TkbmEOS7H
	qy5s54Ox9rItE16fPWjcZBQK34r00mA1qF7bBnoKUAdbPmOx0yIEaaah/RkL2JXXZkWUj0bsIdu
	qEdCqkjsstAUZvFNI/VONJsbde3q+Zm+x2LhTMW+IFeqBR0tMEH9jz5htW0u2IH9RGzWE=
X-Google-Smtp-Source: AGHT+IGowV8yXwhYSYdo5iMFbg8FdBgVP4G7gtzUYUPUudk34KC8hLdwGZRVOWEMBpROoMuOHY1bdQ==
X-Received: by 2002:a05:690e:1697:b0:63e:2269:42eb with SMTP id 956f58d0204a3-64329347f45mr2764804d50.45.1764100142015;
        Tue, 25 Nov 2025 11:49:02 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78a7995a14esm59307277b3.52.2025.11.25.11.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 11:49:01 -0800 (PST)
Date: Tue, 25 Nov 2025 14:49:00 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Neal Cardwell <ncardwell@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.39fa9d8834471@gmail.com>
In-Reply-To: <CADVnQym7Whnbc9xf_dew-ey1fGFBY1dSf6RJ=9qLNP=u+NYOEw@mail.gmail.com>
References: <20251124071831.4cbbf412@kernel.org>
 <willemdebruijn.kernel.1fe4306a89d08@gmail.com>
 <CADVnQym7Whnbc9xf_dew-ey1fGFBY1dSf6RJ=9qLNP=u+NYOEw@mail.gmail.com>
Subject: Re: [TEST] tcp_zerocopy_maxfrags.pkt fails
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Neal Cardwell wrote:
> On Mon, Nov 24, 2025 at 11:33=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jakub Kicinski wrote:
> > > Hi Willem!
> > >
> > > I migrated netdev CI to our own infra now, and the slightly faster,=

> > > Fedora-based system is failing tcp_zerocopy_maxfrags.pkt:
> > >
> > > # tcp_zerocopy_maxfrags.pkt:56: error handling packet: incorrect ou=
tbound data payload
> > > # script packet:  1.000237 P. 36:37(1) ack 1
> > > # actual packet:  1.000235 P. 36:37(1) ack 1 win 1050
> > > # not ok 1 ipv4
> > > # tcp_zerocopy_maxfrags.pkt:56: error handling packet: incorrect ou=
tbound data payload
> > > # script packet:  1.000209 P. 36:37(1) ack 1
> > > # actual packet:  1.000208 P. 36:37(1) ack 1 win 1050
> > > # not ok 2 ipv6
> > > # # Totals: pass:0 fail:2 xfail:0 xpass:0 skip:0 error:0
> > >
> > > https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill/results/=
399942/13-tcp-zerocopy-maxfrags-pkt/stdout
> > >
> > > This happens on both debug and non-debug kernel (tho on the former
> > > the failure is masked due to MACHINE_SLOW).
> >
> > That's an odd error.
> >
> > The test send an msg_iov of 18 1 byte fragments. And verifies that
> > only 17 fit in one packet, followed by a single 1 byte packet. The
> > test does not explicitly initialize payload, but trusts packetdrill
> > to handle that. Relevant snippet below.
> >
> > Packetdrill complains about payload contents. That error is only
> > generated by the below check in run_packet.c. Pretty straightforward.=

> >
> > Packetdrill agrees that the packet is one byte long. The win argument=

> > is optional on outgoing packets, not relevant to the failure.
> >
> > So somehow the data in that frag got overwritten in the short window
> > between when it was injected into the kernel and when it was observed=
?
> > Seems so unlikely.
> >
> > Sorry, I'm a bit at a loss at least initially as to the cause.
> =

> I agree this is odd. It looks like either a very concerning kernel
> bug, or very concerning packetdrill bug. :-)
> =

> Could someone please run the test with tcpump in the background to
> capture the full packet contents, to verify that indeed the packet has
> the wrong contents?
> =

> This would help make sure that this is a kernel bug and not a
> packetdrill bug. :-)

I'm not able to reproduce this on my own machine with the latest nn.
But could reproduce it on the netdev machine.

I assume all payload is supposed to be zeroed. And indeed the packet
seen has a non-zero single byte of payload: 0x60.

Is there any chance that this happens on some kernel with
unsubmitted patches, but not on netdev-nn/main on this machine either?

----

tcp_zerocopy_maxfrags.pkt:56: error handling packet: incorrect
outbound data payload
script packet:  1.000169 P. 36:37(1) ack 1
actual packet:  1.000167 P. 36:37(1) ack 1 win 1050

14:42:01.330694 tun0  Out IP6 fd3d:a0b:17d6::1.webcache >
fd3d:fa7b:d17d::1.50901: Flags [P.], seq 19:36, ack 1, win 1050,
length 17: HTTP
        0x0000:  6000 842c 0025 0640 fd3d 0a0b 17d6 0000
        0x0010:  0000 0000 0000 0001 fd3d fa7b d17d 0000
        0x0020:  0000 0000 0000 0001 1f90 c6d5 f7fe 05e9
        0x0030:  0000 0001 5018 041a e883 0000 0000 0000
        0x0040:  0000 0000 0000 0000 0000 0000 00
14:42:01.330723 tun0  In  IP6 fd3d:fa7b:d17d::1.50901 >
fd3d:a0b:17d6::1.webcache: Flags [.], ack 36, win 257, length 0
        0x0000:  6000 0000 0014 06ff fd3d fa7b d17d 0000
        0x0010:  0000 0000 0000 0001 fd3d 0a0b 17d6 0000
        0x0020:  0000 0000 0000 0001 c6d5 1f90 0000 0001
        0x0030:  f7fe 05fa 5010 0101 e21b 0000
14:42:01.330727 tun0  Out IP6 fd3d:a0b:17d6::1.webcache >
fd3d:fa7b:d17d::1.50901: Flags [P.], seq 36:37, ack 1, win 1050,
length 1: HTTP
        0x0000:  6000 842c 0015 0640 fd3d 0a0b 17d6 0000
        0x0010:  0000 0000 0000 0001 fd3d fa7b d17d 0000
        0x0020:  0000 0000 0000 0001 1f90 c6d5 f7fe 05fa
        0x0030:  0000 0001 5018 041a e873 0000 60






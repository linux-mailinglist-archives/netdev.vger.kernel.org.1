Return-Path: <netdev+bounces-227548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F3BBB2A34
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 08:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E82F19C321E
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 06:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6BA288C9D;
	Thu,  2 Oct 2025 06:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTfJ1Ep8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A797263B
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759387305; cv=none; b=NieU3940BR9GXd5WsiKRFQlcbCNRwdLnu7nzUrQL4yWjo8RkNLpFNr2QnS+kAwn9VzGGy9UskqbjvY0IdOXZUy3LfZKP61WlltkNZaLWa/Wk0l9ROH+2Olzkb4lxgiTmkfH+gaRyG5RwLmNS57ib/lDUHchxI1eNc40GONhyalA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759387305; c=relaxed/simple;
	bh=VUXUphGUUWqou5aaq4XfiZb9dsE4kKbQ2+2wpdwOM8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AErB2+qXjbYCHG5H8llFDWVr83/3Yq32s91Jhg+D5IVBtiwMK4RuuB1eO/ec6yam2SH43zBFjzI7kOJMatWyj8tlC/ILMC9XryDadxddMDZJt0VrMZHLodO/f9vk6V5hvd2X4TbDfwzq6IJ38Ya5uw2CQiA+r2Dx3Y8dp762joQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTfJ1Ep8; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4da72b541f8so7350041cf.1
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 23:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759387303; x=1759992103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2DUgbJikXrEOV8M55fv6hQUu21OkhwEGcUgtuD381w=;
        b=DTfJ1Ep8QzOVR10ZPRnshCQAcdd0y4G1eh65Vp6JEZesv/GcjBAljTDZeoTSkKlU5h
         m1AuQt4dTT0IRmFYO9JrgBJoBbrywjUpTWsE/qp4L9HyFNxe8mBX4dbd27vcnFKrdnr4
         d9+zSa6P8veYxrZuuisjcJPTuBBwV/xja0f4Dn7S0kVE9VfQzMBwjXZCGLekN+c1kpSp
         09kRf5nAsQraVSlEfoJDPt60HNLDSVFI/Gm3yIquNptMxVxlWUCRLjs8X4Y4PWO98kzK
         zWtw149OucAS3n3dA2tjOVllhf4+jDk4/obsi6VMRKFrLlCPe4dXNmcFj8Wo0Y61/tQB
         bZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759387303; x=1759992103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2DUgbJikXrEOV8M55fv6hQUu21OkhwEGcUgtuD381w=;
        b=pwUYGObcjX0xs3d2/AntshhEXo62QrxHE2HvfGyjFmSAle+xLUbGQsdkTyImew4F6R
         bDwfSdaJlLZ1g6JEsaQVca0iyzKyBO8XIWMuG8FE1dRTRN36sYH6M6xQI3y+5CGgMoPF
         /Th2NaUpjsYZUnAjd0WH6RI/oBSZiWB1Smn9EvMc3zpJqYUvDDpb18CWBrd4PrRGdHJK
         u3EtPlPSX4my1MiYsx+nCsvUBvguu6JaQdH6jWaZmR2y7o/l1tLHLTcbwQKdjPBvpTTZ
         PKQedahamGXu8mCUdwI03tK4NAuDWxlQi68qPPqMJiTL811gkEGBE6qRXimJig/6qK4m
         q69g==
X-Forwarded-Encrypted: i=1; AJvYcCV2U8tRbPLmIc/qSFBckuLP5fEnL4IPVe3nUb3XmHBPeY6yTYF1jUAC1wkKde2iVXhVwJj18C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpsAfBynp/14ryewOI7+p6maj4LF+ICNrkJG6yLIc8DIu0ReQI
	tun/jqSc00rf8nCQ3AfJo0SZts0kLPI+ZhElQgXO9Zfhj5WzSbY/65+7Q4vAXuBA7ZnVox+L3SM
	n7ZvkspC2Q49LdU/mUIKDOy+tNCm8dFc59rp4lQl/
X-Gm-Gg: ASbGncvSRYfu1BHbywL6SeSpFh7Tq2ay/L7dgG4un02L94qrn3/Gh7iM+nDipTt6Hxg
	oStVD9A7A/Uw6Qt5uqBLxya4u0xX8gvre5JvbRjvIWec7vlih9U7PbFo6jY9XuJKvAje32COHc4
	CLKgN5NUyfQrpPH2XEB0zrL8iLmv+tU4/KWx+HxZMnIQeGqxfxZCHf2rv/mhGFE1NtLy7S1+Mfi
	2Ar1qSET0ITs1LhCVmceNlrkiF4mcna1u8k0ptPUMOpYmJA
X-Google-Smtp-Source: AGHT+IEO8RvO6Wo/N0jb/UTNus7k/WzY3pqBh7wvsxvtKacpNIUcX1TdeQDKJimIXTKFJTJ5BV4rbtvBuQpJSNpE7Ac=
X-Received: by 2002:a05:622a:65c1:b0:4e4:f4cf:23b9 with SMTP id
 d75a77b69052e-4e4f4cf27c5mr40251961cf.73.1759387302738; Wed, 01 Oct 2025
 23:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001022426.2592750-1-kuba@kernel.org> <CAAVpQUCZNhW7zvFrL-kmfkks=u0RtOBW+a-R3BxtqHjt0aud7w@mail.gmail.com>
In-Reply-To: <CAAVpQUCZNhW7zvFrL-kmfkks=u0RtOBW+a-R3BxtqHjt0aud7w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Oct 2025 23:41:31 -0700
X-Gm-Features: AS18NWCsy2SQBlC5crbUKj8M0mr0Lxtf5qv98RsZi8F6uPy28od0qPZxdZ7lWCc
Message-ID: <CANn89i+9vHQEx4NFSdPGNn-LtM+rxaizcuh=0BtP3EYVQr73KQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: psp: don't assume reply skbs will have a socket
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	ncardwell@google.com, daniel.zahka@gmail.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 11:28=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Tue, Sep 30, 2025 at 7:24=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > Rx path may be passing around unreferenced sockets, which means
> > that skb_set_owner_edemux() may not set skb->sk and PSP will crash:
> >
> >   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017=
]
> >   RIP: 0010:psp_reply_set_decrypted (./include/net/psp/functions.h:132 =
net/psp/psp_sock.c:287)
> >     tcp_v6_send_response.constprop.0 (net/ipv6/tcp_ipv6.c:979)
> >     tcp_v6_send_reset (net/ipv6/tcp_ipv6.c:1140 (discriminator 1))
> >     tcp_v6_do_rcv (net/ipv6/tcp_ipv6.c:1683)
> >     tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1912)
> >
> > Fixes: 659a2899a57d ("tcp: add datapath logic for PSP with inline key e=
xchange")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>


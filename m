Return-Path: <netdev+bounces-221277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 188EDB4FFEB
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035631C24E66
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B04C21323C;
	Tue,  9 Sep 2025 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K77XlKGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B1218A921
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429246; cv=none; b=J5coJRrpzrTmVDbfTSdBSYynMtdLeyeXL3y+juDL1BT50Fbxz5yJlAZIIk97fiuMBf1yFD2ql7OjMvDO/HWskyZVRq248wfs7XyMzEwXK0bK9wxq4pIRxtgASfmGbjYV/7qSu2UzPuvahvfuxrwSZ3CVaIZhwcX+6fJCtqiYF4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429246; c=relaxed/simple;
	bh=na0qcNvQJYZarjhYVsaDNm+DNueOfC1mq9L1wdwqIWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iND67NiDnpOdLuM+v1hnGObm72XT6fkHcDfx501zqVcAgt8kKEk//9sp+EnS6geIu1wV5M2RnqZsKRPwv2q5nuB3WLI1fRXzxOIUHikc/X+tZVE2lRJC0E4+zLH3whz2l5CPwDYpguI695IXBZdMNFqwc7wTnSQGaL/BJl2P6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K77XlKGr; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b38d47fa9dso50269891cf.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757429243; x=1758034043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIPTmtHCDrJgBeBgHlzsCibUN0YnxA4RCxNX1u5+HrA=;
        b=K77XlKGrJ9+ZRVxgSYlht55aLZoGcK0RmfEgbd5sF7KEg4DbwaUq8QmD3uBFel6gkQ
         AYwM8czCzwGvtM5+ZBY8JSOBDHX1Lo6n8NN6/2wXj4JdkFaNZPE24sSP9+XxBltFPwDv
         SSUbItY/QfF8CxcG27azsk6kOJyYj/e64KeBX+fh37BB6GMRlbAlVqc/o/84Erryngs6
         p+gQpRzvfpwQnemp+Xv8Gg4CFwtF9221peX/yALyP5RkVX3cBjcSLb7AmHju6PpnVnkc
         FA76j8wz7l884NOmDjEjK97jlPRnbDcEvtNso0XOzKBtU/covLzibeMCqu9j5jeiMRzB
         SykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757429243; x=1758034043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIPTmtHCDrJgBeBgHlzsCibUN0YnxA4RCxNX1u5+HrA=;
        b=lhw9GgF4wSTwU6C7Y50hodJEe/w/0ZYWVoCf/eDhMNlP9yGTFhTjfZFNd+qGC779fk
         kjYP++70E2uLIYW7P9y6xSLKVIFEVl8qxLPhtu7lEMug+IrZt06wUUta2Frmd34CINnd
         L7Au0kfV57cJvEmZYGFWCy2LKQvuk2Z2O8MluqIIq/pxlACMiAhLhpcEiX8U/66a9cO4
         JXLbnpqlsjn9/zHRZKugOUz/uVsh78oVL6u3pwTUS9mCEV+FV3EwpAdp7OQ9w66wUzrt
         EqDoTBIJ0VtNO+MSeuEgFUkuZN40kTysGUkCc1c+c+8Cl4Oc4USyPCApQTttrkm9EetD
         3xhg==
X-Forwarded-Encrypted: i=1; AJvYcCU01S21V69e0vkvK51l9J1y7Nf8HBuQlLCkZsiA27G6Vh6Sat8c/AZziWpD41PFArqsClJ+jx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0SQ+sSPljZDsDf5pDBIqWRaQg1x0lAMZPQR+ii8jzgEWUsk1m
	Ienqp0MjiOBGd/9nu7dS4eGa8gpAI9yDIGVkNa0UizvXicsgsq2YACeWWDPEKPldGM/GDyE0TPk
	oXzqGIlLxL5ZsKVBbPPcmNgwNVruuyV5S+8syCY94
X-Gm-Gg: ASbGncvGHlP2CrwiWg8X894fk2l66j4X3HQ4kSX+2ol+IM27OLFClC/aoy/Sixt709d
	F0J9TO3a4HWvuXoJBF1nCEltmX9e/nYib2KKRPJs8qtqtM9HNvPIlymDSUSc86pQ+PtIWtQ0yOA
	5lgpu1YL47I2lqC0gqS0kdflfj81xG2quTMgu6iqUuut2xOUYFX2aLaMhgqlol7aFE1Q92ARmI8
	cZjehbSK0IaVPO8AQZjfExxiNlFgi9YGIhZD9iIV7Re4vJcXsQhp4D9E8g=
X-Google-Smtp-Source: AGHT+IHNkl4F/jlHneGYF/DVcUMGaWB8Yx5qk0wUjgE1GPGbrefbzEWPV3RJqRwpMoeMSkvolvqz8buuDcIXFrAO/fU=
X-Received: by 2002:a05:622a:28a:b0:4b5:e600:3d4f with SMTP id
 d75a77b69052e-4b5f844d163mr132837011cf.41.1757429242916; Tue, 09 Sep 2025
 07:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909132243.1327024-1-edumazet@google.com> <20250909132936.GA1460@redhat.com>
 <CANn89iLyxMYTw6fPzUeVcwLh=4=iPjHZOAjg5BVKeA7Tq06wPg@mail.gmail.com>
 <CANn89iKdKMZLT+ArMbFAc8=X+Pp2XaVH7H88zSjAZw=_MvbWLQ@mail.gmail.com> <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
In-Reply-To: <63c99735-80ba-421f-8ad4-0c0ec8ebc3ea@kernel.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Sep 2025 07:47:09 -0700
X-Gm-Features: Ac12FXzNtkWC68OEJylvLMh65_Zd3JlyhYqvJ9DDcC2NpONUi_gkcjAG5cZuFt8
Message-ID: <CANn89iJiBuJ=sHbfKjR-bJe6p12UrJ_DkOgysmAQuwCbNEy8BA@mail.gmail.com>
Subject: Re: [PATCH] nbd: restrict sockets to TCP and UDP
To: Jens Axboe <axboe@kernel.dk>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, 
	syzbot+e1cd6bd8493060bd701d@syzkaller.appspotmail.com, 
	Mike Christie <mchristi@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
	linux-block@vger.kernel.org, nbd@other.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 7:37=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/9/25 8:35 AM, Eric Dumazet wrote:
> > On Tue, Sep 9, 2025 at 7:04=E2=80=AFAM Eric Dumazet <edumazet@google.co=
m> wrote:
> >>
> >> On Tue, Sep 9, 2025 at 6:32=E2=80=AFAM Richard W.M. Jones <rjones@redh=
at.com> wrote:
> >>>
> >>> On Tue, Sep 09, 2025 at 01:22:43PM +0000, Eric Dumazet wrote:
> >>>> Recently, syzbot started to abuse NBD with all kinds of sockets.
> >>>>
> >>>> Commit cf1b2326b734 ("nbd: verify socket is supported during setup")
> >>>> made sure the socket supported a shutdown() method.
> >>>>
> >>>> Explicitely accept TCP and UNIX stream sockets.
> >>>
> >>> I'm not clear what the actual problem is, but I will say that libnbd =
&
> >>> nbdkit (which are another NBD client & server, interoperable with the
> >>> kernel) we support and use NBD over vsock[1].  And we could support
> >>> NBD over pretty much any stream socket (Infiniband?) [2].
> >>>
> >>> [1] https://libguestfs.org/nbd_aio_connect_vsock.3.html
> >>>     https://libguestfs.org/nbdkit-service.1.html#AF_VSOCK
> >>> [2] https://libguestfs.org/nbd_connect_socket.3.html
> >>>
> >>> TCP and Unix domain sockets are by far the most widely used, but I
> >>> don't think it's fair to exclude other socket types.
> >>
> >> If we have known and supported socket types, please send a patch to ad=
d them.
> >>
> >> I asked the question last week and got nothing about vsock or other ty=
pes.
> >>
> >> https://lore.kernel.org/netdev/CANn89iLNFHBMTF2Pb6hHERYpuih9eQZb6A12+n=
dzBcQs_kZoBA@mail.gmail.com/
> >>
> >> For sure, we do not want datagram sockets, RAW, netlink, and many othe=
rs.
> >
> > BTW vsock will probably fire lockdep warnings, I see GFP_KERNEL being u=
sed
> > in net/vmw_vsock/virtio_transport.c
> >
> > So you will have to fix this.
>
> Rather than play whack-a-mole with this, would it make sense to mark as
> socket as "writeback/reclaim" safe and base the nbd decision on that rath=
er
> than attempt to maintain some allow/deny list of sockets?

Even if a socket type was writeback/reclaim safe, probably NBD would not su=
pport
arbitrary socket type, like netlink, af_packet, or af_netrom.

An allow list seems safer to me, with commits with a clear owner.

If future syzbot reports are triggered, the bisection will point to
these commits.


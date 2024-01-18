Return-Path: <netdev+bounces-64092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3828310FF
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 02:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B09DF288109
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 01:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C793FFF;
	Thu, 18 Jan 2024 01:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkX01emz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D12907
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542147; cv=none; b=tNM8E1JiKjEHwgEFEfPupwSnbwCyVNzO9+vdQAj/U74pMJsrX3SDmVvYgBsn7K33ODKpMIxLp7NgafstaDIxCKgFURqZ9IkB3INsLerwULCFy7VYm+KQm5QhQj02pgp8gVFZEr6VXs08ysGb7n+g6VqcuJJQFQRIxuwgTTe1FwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542147; c=relaxed/simple;
	bh=yW8PNFOnkVQWOSGIm9wzUCrhvd0vMfpHWXY865zBmqE=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=MQG20NcJecwyByXig88F4oepqWxxt1iK8nBcjZ5gfkKNYIQaGrNfK7Enif+bpYCmEdnxCmhntivTizA7Ew4rD4yE80YOuV0+3NwQZ3uzmzAXbLb7+WNRgeir0uS3ZQ4R7p5HLRfVTyXGlufxp+KZHeG3xdFtfGRWBQkBdRQFRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkX01emz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705542144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMo12tc0Hfa9sWx6nN14v1LNWUOZbOTlwvZ2d6w+lFo=;
	b=TkX01emzkCPeElXrNIFnAqi+LayZXYIZbQqBXcGO5pQTAuaSuMpjbQCXvGOmusbPwZKFj1
	E+ZdUkyBJ98kdIP6eIg4M5kaLbb5n4b8WDJp3Lb+cpewFB7Tf10a0bC51DIBCxi+cD5Qfq
	AWsqxTmbdUO5AxeCOqWfo1HGoo5Xmug=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-8v3jZAj9PRefOCjf4OkRnQ-1; Wed, 17 Jan 2024 20:42:18 -0500
X-MC-Unique: 8v3jZAj9PRefOCjf4OkRnQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e74860cb0so28671645e9.3
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 17:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705542137; x=1706146937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMo12tc0Hfa9sWx6nN14v1LNWUOZbOTlwvZ2d6w+lFo=;
        b=Jt9vKv+mFu79Ws9WyPvmqT0I1GWHLQa2ypzYV3iRouDNWzl4QF5fY4zwCtcwlRnyr+
         GJAEGsSQMIFkvtAuP0EV44D0IZzLB5qSCZiY0fSJDwm3gDco+IqtcDBOA+qJIlDEIky8
         XUOqkNfc0N33Cv5FvFoUA2JloVssoUuRw4CoTDKg+VCHQWIG3AOHDnhRoZEckeFpf7CJ
         DS5JnFRRMdqTH6pTzqrsyIjGZtBoXycfzsTDKslmKrxcJQu994zchI0V+Ie4wg/jl1y4
         fJrNYPHjog7Gsx773ecNKifiReNXjYb+YHsNBDr1+t0LgBq4h4do7fNus3rN1VqboHsk
         55Bw==
X-Gm-Message-State: AOJu0YwSEgKFKDBkrN1HliQDKvpx3BQHmEhjexlOjxd6lG8dppTCYlpM
	YlQOPjTU39ZqukMIksuwUzpQLaGVfFCWD4SZyFon0ryhW9rwvBekkG4wDxhndKa/Lc8Cmxn0Oll
	B02aD2SYZkliKdadm2gBhSsHuZOum05r5Y/uJcNFP3UFKnK6aTcNIHgt3MB72v8hFjePAGJ0Wl7
	qy+AK46NSwz9H+G6KwNXbs/vBS10Os
X-Received: by 2002:a05:600c:2312:b0:40e:577b:d744 with SMTP id 18-20020a05600c231200b0040e577bd744mr40321wmo.146.1705542136985;
        Wed, 17 Jan 2024 17:42:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYzwAAj0t3pbSUZ1I7GrVGRViOSkcsIVvwF8AZZbdbIMNoK3K/hU0Qm1MEpb6wMLER4XB55QIE76abcoVIPqs=
X-Received: by 2002:a05:600c:2312:b0:40e:577b:d744 with SMTP id
 18-20020a05600c231200b0040e577bd744mr40312wmo.146.1705542136647; Wed, 17 Jan
 2024 17:42:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK-6q+jsZ13Cs9iuk_WjFeYFCEnnj-dJ9QYkWaw4fh6Gi=JtHA@mail.gmail.com>
 <20240112131554.10352-1-n.zhandarovich@fintech.ru> <CAK-6q+gcs2djQfKRsuGpD7WERmbLhzjkHEm80MRe+2UE3bteKw@mail.gmail.com>
In-Reply-To: <CAK-6q+gcs2djQfKRsuGpD7WERmbLhzjkHEm80MRe+2UE3bteKw@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 17 Jan 2024 20:42:05 -0500
Message-ID: <CAK-6q+hRbsFkQec3O8FnT-G9Mx07rdhEMfmTE2Q0SDN0kKN-8g@mail.gmail.com>
Subject: Re: [PATCH RESEND] mac802154: Fix uninit-value access in ieee802154_hdr_push_sechdr
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Zhang Shurong <zhang_shurong@foxmail.com>, alex.aring@gmail.com, 
	stefan@datenfreihafen.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	harperchen1110@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 14, 2024 at 10:32=E2=80=AFPM Alexander Aring <aahringo@redhat.c=
om> wrote:
>
> Hi,
>
> On Fri, Jan 12, 2024 at 8:16=E2=80=AFAM Nikita Zhandarovich
> <n.zhandarovich@fintech.ru> wrote:
> >
> > >> > >
> > >> > > BUG: KMSAN: uninit-value in ieee802154_hdr_push_sechdr net/ieee8=
02154=3D
> > > /header_ops.c:54 [inline]
> > >> > > BUG: KMSAN: uninit-value in ieee802154_hdr_push+0x971/0xb90 net/=
ieee8=3D
> > > 02154/header_ops.c:108
> > >> > >  ieee802154_hdr_push_sechdr net/ieee802154/header_ops.c:54 [inli=
ne]
> > >> > >  ieee802154_hdr_push+0x971/0xb90 net/ieee802154/header_ops.c:108
> > >> > >  ieee802154_header_create+0x9c0/0xc00 net/mac802154/iface.c:396
> > >> > >  wpan_dev_hard_header include/net/cfg802154.h:494 [inline]
> > >> > >  dgram_sendmsg+0xd1d/0x1500 net/ieee802154/socket.c:677
> > >> > >  ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
> > >> > >  sock_sendmsg_nosec net/socket.c:725 [inline]
> > >> > >  sock_sendmsg net/socket.c:748 [inline]
> > >> > >  ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2494
> > >> > >  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2548
> > >> > >  __sys_sendmsg+0x225/0x3c0 net/socket.c:2577
> > >> > >  __compat_sys_sendmsg net/compat.c:346 [inline]
> > >> > >  __do_compat_sys_sendmsg net/compat.c:353 [inline]
> > >> > >  __se_compat_sys_sendmsg net/compat.c:350 [inline]
> > >> > >
> > >> > > We found hdr->key_id_mode is uninitialized in mac802154_set_head=
er_se=3D
> > > curity()
> > >> > > which indicates hdr.fc.security_enabled should be 0. However, it=
 is s=3D
> > > et to be cb->secen before.
> > >> > > Later, ieee802154_hdr_push_sechdr is invoked, causing KMSAN comp=
lains=3D
> > >  uninit-value issue.
> > >> >
> > >> > I am not too deeply involved in the security header but for me it =
feels
> > >> > like your patch does the opposite of what's needed. We should mayb=
e
> > >> > initialize hdr->key_id_mode based on the value in cb->secen, no? (=
maybe
> > >> > Alexander will have a better understanding than I have).
> > >>
> > >> I can't help yet with a better answer why syzkaller reports it but i=
t
> > >> will break things as we using skb->cb to pass additional parameters
> > >> through header_ops->create()... in this case it is some sockopts of
> > >> af802154, I guess.
> > >>
> > >
> > > Maybe we just need to init some "more" defaults in [0]
> > >
> > > - Alex
> > >
> > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree=3D
> > > /net/ieee802154/socket.c?h=3D3Dv6.7-rc5#n474
> >
> > Hello,
> >
> > I was looking into the same issue (now present in syzbot [1]) and since=
 it has a
> > C-repro, the error is easy to recreate. Apparently, despite cb->secen (=
and
> > hdr.fc.security_enabled accordingly) being equal 1, mac802154_set_heade=
r_security()
> > finishes with 0 in:
> >
> >         if (!params.enabled ||
> >             (cb->secen_override && !cb->secen) ||
> >             !params.out_level)
> >             return 0;
> >
> > Not presuming to understand the issue fully but if we do end up leaving
> > mac802154_set_header_security() early, should we init hdr->key_id_mode
> > with IEEE802154_SCF_KEY_IMPLICIT before returning with 0?
> > I imagine that reseting hdr.fc.security_enabled to 0 ourselves in this
> > case is a wrong way to go too.
> >
>
> I think here are two problems:
>
> 1.
> When (in any way) secen path is hit then we should make sure some
> other security parameters are set, if not return with an error. This
> needs to be done somewhere in the 802.15.4 socket code. [0]
>

This would require that we init them with some invalid value defaults
but I think because we are using bit fields, we need to change the
whole struct to make some invalid number range available.
I am happy to init those values to some value at [0] to at least get
rid of the uninit value warning. We can change it so that it fails at
send() afterwards, I think it should fail in some later path of the
implementation that ends in a kernel log message.

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/ieee802154/socket.c#n474



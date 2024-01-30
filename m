Return-Path: <netdev+bounces-66950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A20841996
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 03:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48471F23A76
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D1C364DA;
	Tue, 30 Jan 2024 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVKMemRU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7911C37179
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583059; cv=none; b=NutErg14nmHmE+7+gSKWzxCzTsuNusC01Vg5aDLBjSZwpvEYq7nOxASDsPxi74Flq00zu1NKY01W8JSbVVDyVbkyDNE9SxNtEDrnPZslqIaRpSyXKCTjNTvhT+sk7OTLUTxXobQ/giWpwVcN194sJC+0bSDw/WKq4EIQ2ksxrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583059; c=relaxed/simple;
	bh=7/4OOmT0P01j47RMj7+gCYaiskBPgI0I+DKiyvwAdv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRB4N3u0s1tCMr6sjcTCwT2DinxEuNNr+P4xPU727027Q8UkMuH+sKeUgGhhnwjeR8bzRn7F6gw49vS1DwBt0wEsQXvdtt3/MX+L3QTVNauNJ8kjMYooG7Vcj6Jixgn7XVIG4d9ovG8ISerU1mcY/kPKUzyq//g9yhBuriB+NcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVKMemRU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706583056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCU7cgSJXt8eqbIH0viYPN7vEYcJ8K/tx6HHt1Qm1ig=;
	b=TVKMemRUzNprPYtG6pIhGlUoiWX9YULfvzt3/SV0uoUyvVFQ7WJmJYaR4GkwqVmG8Z7suZ
	Hgh4mCzEnI5vRFVVaVuhVQT47shZdY2NDsJt3pCTJXBwScSce7UvR8sfLWxNWOJnBNRckL
	8ATnnbT/qkPiGnfzz5FuFdN0slWKidY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-sqnMEKA9PGa4CmLVAo9Csg-1; Mon, 29 Jan 2024 21:50:54 -0500
X-MC-Unique: sqnMEKA9PGa4CmLVAo9Csg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6dde04e1c67so2224641b3a.0
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 18:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706583053; x=1707187853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCU7cgSJXt8eqbIH0viYPN7vEYcJ8K/tx6HHt1Qm1ig=;
        b=KlWUg2e7yInNQQ7KBcoNekBaeE/LOlD7icIoKuyUliBjQzA0NVi65z4iklc918R1gd
         7HVRAxsnEWdCPh+J1l8eBXYSauKx20W11Zyj8GZvQ0XWcMSINhlEvgsKK1AAVosMDntA
         7kohbiTxKkelPzQq4uSwa+y9LPda+B53PmzmbTL9lLt6lyrFdbnDr0j4iDgWse8hEE15
         xCfKVstu/EtQ9TNb2sY8gaDqaXAE3fsH7JlDSVwhGOfXWIt8ZPT1597BXhxv/jSL0FsX
         h3SgntrLzYs+9PbSzF8pS9oe8Cyoywnpc0Rh17s/xekRexRsgAwLwyvT6TU0ipHtD8yy
         nXEQ==
X-Gm-Message-State: AOJu0Yzn1JUFeAKr8717U6mI1qUaerLNYH6jZ+hIFFXxK2z/QAjT1zHb
	+dJdyj49GZBj/HqnUqaJfwOTiPrApUA8sCwk9mH1xesQcqtvC8ZYC6f+xCTjHoPIeXZeOellqTH
	Ec8CxbhK6KR5hfkBLBIyTOmTRnwgFVrr7+VXEl2PNgohzyNXkXFo8WnvPUR8RYicOYXDdut+0dI
	m3bemqCK2AyVpoQpmMFxD3NQVMipt/
X-Received: by 2002:a05:6a00:be4:b0:6db:7073:f845 with SMTP id x36-20020a056a000be400b006db7073f845mr3665891pfu.18.1706583053108;
        Mon, 29 Jan 2024 18:50:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm5Itgw8YJiSPgIZ0ocMlecuXm83mHLHvX+aoPWUkQQ+32MJb0boVV1sfx4sU6lrRD47v7bJs7prWQkWvVf4w=
X-Received: by 2002:a05:6a00:be4:b0:6db:7073:f845 with SMTP id
 x36-20020a056a000be400b006db7073f845mr3665879pfu.18.1706583052830; Mon, 29
 Jan 2024 18:50:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706089075-16084-1-git-send-email-wangyunjian@huawei.com>
 <CACGkMEu5PaBgh37X4KysoF9YB8qy6jM5W4G6sm+8fjrnK36KXA@mail.gmail.com>
 <ad74a361d5084c62a89f7aa276273649@huawei.com> <CACGkMEvvdfBhNXPSxEgpPGAaTrNZr83nyw35bvuZoHLf+k85Yg@mail.gmail.com>
 <0141ea1c5b834503837df5db6aa5c92a@huawei.com>
In-Reply-To: <0141ea1c5b834503837df5db6aa5c92a@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jan 2024 10:50:41 +0800
Message-ID: <CACGkMEsyvgnezk2DXX-Z7Wt9zHV9o=w_wcN8z+dyoZ9LB1qqjA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tun: AF_XDP Rx zero-copy support
To: wangyunjian <wangyunjian@huawei.com>
Cc: "mst@redhat.com" <mst@redhat.com>, 
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"davem@davemloft.net" <davem@davemloft.net>, 
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, xudingke <xudingke@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 7:40=E2=80=AFPM wangyunjian <wangyunjian@huawei.com=
> wrote:
>
> > -----Original Message-----
> > From: Jason Wang [mailto:jasowang@redhat.com]
> > Sent: Monday, January 29, 2024 11:03 AM
> > To: wangyunjian <wangyunjian@huawei.com>
> > Cc: mst@redhat.com; willemdebruijn.kernel@gmail.com; kuba@kernel.org;
> > davem@davemloft.net; magnus.karlsson@intel.com; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> > virtualization@lists.linux.dev; xudingke <xudingke@huawei.com>
> > Subject: Re: [PATCH net-next 2/2] tun: AF_XDP Rx zero-copy support
> >
> > On Thu, Jan 25, 2024 at 8:54=E2=80=AFPM wangyunjian <wangyunjian@huawei=
.com>
> > wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Jason Wang [mailto:jasowang@redhat.com]
> > > > Sent: Thursday, January 25, 2024 12:49 PM
> > > > To: wangyunjian <wangyunjian@huawei.com>
> > > > Cc: mst@redhat.com; willemdebruijn.kernel@gmail.com;
> > > > kuba@kernel.org; davem@davemloft.net; magnus.karlsson@intel.com;
> > > > netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > > kvm@vger.kernel.org; virtualization@lists.linux.dev; xudingke
> > > > <xudingke@huawei.com>
> > > > Subject: Re: [PATCH net-next 2/2] tun: AF_XDP Rx zero-copy support
> > > >
> > > > On Wed, Jan 24, 2024 at 5:38=E2=80=AFPM Yunjian Wang
> > > > <wangyunjian@huawei.com>
> > > > wrote:
> > > > >
> > > > > Now the zero-copy feature of AF_XDP socket is supported by some
> > > > > drivers, which can reduce CPU utilization on the xdp program.
> > > > > This patch set allows tun to support AF_XDP Rx zero-copy feature.
> > > > >
> > > > > This patch tries to address this by:
> > > > > - Use peek_len to consume a xsk->desc and get xsk->desc length.
> > > > > - When the tun support AF_XDP Rx zero-copy, the vq's array maybe =
empty.
> > > > > So add a check for empty vq's array in vhost_net_buf_produce().
> > > > > - add XDP_SETUP_XSK_POOL and ndo_xsk_wakeup callback support
> > > > > - add tun_put_user_desc function to copy the Rx data to VM
> > > >
> > > > Code explains themselves, let's explain why you need to do this.
> > > >
> > > > 1) why you want to use peek_len
> > > > 2) for "vq's array", what does it mean?
> > > > 3) from the view of TUN/TAP tun_put_user_desc() is the TX path, so =
I
> > > > guess you meant TX zerocopy instead of RX (as I don't see codes for
> > > > RX?)
> > >
> > > OK, I agree and use TX zerocopy instead of RX zerocopy. I meant RX
> > > zerocopy from the view of vhost-net.
> >
> > Ok.
> >
> > >
> > > >
> > > > A big question is how could you handle GSO packets from
> > userspace/guests?
> > >
> > > Now by disabling VM's TSO and csum feature.
> >
> > Btw, how could you do that?
>
> By set network backend-specific options:
> <driver name=3D'vhost'>
>         <host csum=3D'off' gso=3D'off' tso4=3D'off' tso6=3D'off' ecn=3D'o=
ff' ufo=3D'off' mrg_rxbuf=3D'off'/>
>     <guest csum=3D'off' tso4=3D'off' tso6=3D'off' ecn=3D'off' ufo=3D'off'=
/>
> </driver>

This is the mgmt work, but the problem is what happens if GSO is not
disabled in the guest, or is there a way to:

1) forcing the guest GSO to be off
2) a graceful fallback

Thanks

>
> Thanks
>
> >
> > Thanks
> >
>



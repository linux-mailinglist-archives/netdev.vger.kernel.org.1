Return-Path: <netdev+bounces-66561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D05DC83FC74
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 04:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322FB283237
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 03:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79DFBEB;
	Mon, 29 Jan 2024 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKdahftW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A655F9EF
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 03:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706497421; cv=none; b=eWJL1DVvAgHMq1sNuMu7ZTb0HAvZVObIDPolZ0e4xx49EfIXsmDDtb6xvKiasH6/d8p+7SrN9pCoVv4M2NqwosTdinqz2Poh1kmAlTRrrkVTgsPffAdhfxNkwxFRffIR/hFm6jTmAmpZ/Tpu+nx07dlibAcRc8WUNy6/DeH/HMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706497421; c=relaxed/simple;
	bh=hUZuM/7erQxDJnYlhTtks20R14zFZ05CUreg11QXzOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHOAKAtTMKQyNYe+WN/qg0Lp5IIsof8DvboWMKOR+Hu561ObO8e/g43TopJCnzBWU6vYDU0W2uJLoW2Y1nEc28hVwmPEdHU1Ubw9oVY7eIFI3n5ySu36UiqJNMSsQsqvZjYf/2haZWT548WL0EJg6xUJr1E2VPoG5S6HwGqiM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKdahftW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706497418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUZuM/7erQxDJnYlhTtks20R14zFZ05CUreg11QXzOM=;
	b=SKdahftWMz6S8G2jjeC0hwuSIPDbHeRpvGvjPltdTHrxQnRfhZ/ZPVlc8B/IIrsUmoDaEV
	1j+sqLDxn1XCObJB0hYkpfXEw78l0G+s4wxDOCQrTruH/PQYI4IO0A9P+IPzBPV0FWluPJ
	rx7cbJdQHbyBnIOI2KL9oNQkGyh10Rc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-kjHcFFE6NduR1gN_9dXw6Q-1; Sun, 28 Jan 2024 22:03:37 -0500
X-MC-Unique: kjHcFFE6NduR1gN_9dXw6Q-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bd3bdcd87fso3296326b6e.3
        for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 19:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706497416; x=1707102216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUZuM/7erQxDJnYlhTtks20R14zFZ05CUreg11QXzOM=;
        b=emTrSZfyeZhLqrVm88A5d1yQRUfYlq7v+xWYByniJoHKkaYAh3GAvPL6Ta85IykSNR
         ojU5UunPDleClaf3CT3kfVjwTUfaMN/sy2E66j8/6k+6nlNeGJ9f4dMq4uHjOMnUDiOC
         oVMjKx7Q9UWn43l/XnFn9icPUBops4XGwWlS6TZkJSAdyZcg+Jspm4LN1HbNch86GSpd
         ovMDdNBy0DZuyXq2b+UCpkEsKPgymBOkvK61E0WkRHRM46fWNYFLAm+X8VArdKhRmwMs
         w98eaksLnTc8rPTQE5qJ8C9UHN04u4Xa9j/+ktwd54V5ZA1iSqjjIM5o7SJcrnAl+tZL
         bYXA==
X-Gm-Message-State: AOJu0YyeS1kFrP06EfWRJF1RwSt4Hl4EPvn5WgSqpL/8kxGy6uL0pVXb
	KHDjvrYPPm/6X+6LZLYEHfEQAxXhy8tQXoMugE8d1LhreWyfrBSxwf0TzqhmvBYaC38HowXr1gP
	PMBljmBIwaMmiQqY1ZBG/eSnfqWf2wOWrGNEuCpRUwvDl0oNR0DQKaHiJvErLo+jQQkRWgYSicT
	eVu8vMIbUzYZC3f3gjdmWTtAu5AuEG
X-Received: by 2002:a05:6359:459c:b0:176:5615:3ddd with SMTP id no28-20020a056359459c00b0017656153dddmr2935238rwb.2.1706497416342;
        Sun, 28 Jan 2024 19:03:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExhe3d4J+MGa7KOuc8jGw9K+dIEFQ7P5yFxc1K+TjoyzSuH0sJglvew2lRBzpwv6DzyOQIWq5hroZ6m+ZM7Dw=
X-Received: by 2002:a05:6359:459c:b0:176:5615:3ddd with SMTP id
 no28-20020a056359459c00b0017656153dddmr2935224rwb.2.1706497416041; Sun, 28
 Jan 2024 19:03:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706089075-16084-1-git-send-email-wangyunjian@huawei.com>
 <CACGkMEu5PaBgh37X4KysoF9YB8qy6jM5W4G6sm+8fjrnK36KXA@mail.gmail.com> <ad74a361d5084c62a89f7aa276273649@huawei.com>
In-Reply-To: <ad74a361d5084c62a89f7aa276273649@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jan 2024 11:03:24 +0800
Message-ID: <CACGkMEvvdfBhNXPSxEgpPGAaTrNZr83nyw35bvuZoHLf+k85Yg@mail.gmail.com>
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

On Thu, Jan 25, 2024 at 8:54=E2=80=AFPM wangyunjian <wangyunjian@huawei.com=
> wrote:
>
>
>
> > -----Original Message-----
> > From: Jason Wang [mailto:jasowang@redhat.com]
> > Sent: Thursday, January 25, 2024 12:49 PM
> > To: wangyunjian <wangyunjian@huawei.com>
> > Cc: mst@redhat.com; willemdebruijn.kernel@gmail.com; kuba@kernel.org;
> > davem@davemloft.net; magnus.karlsson@intel.com; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org; kvm@vger.kernel.org;
> > virtualization@lists.linux.dev; xudingke <xudingke@huawei.com>
> > Subject: Re: [PATCH net-next 2/2] tun: AF_XDP Rx zero-copy support
> >
> > On Wed, Jan 24, 2024 at 5:38=E2=80=AFPM Yunjian Wang <wangyunjian@huawe=
i.com>
> > wrote:
> > >
> > > Now the zero-copy feature of AF_XDP socket is supported by some
> > > drivers, which can reduce CPU utilization on the xdp program.
> > > This patch set allows tun to support AF_XDP Rx zero-copy feature.
> > >
> > > This patch tries to address this by:
> > > - Use peek_len to consume a xsk->desc and get xsk->desc length.
> > > - When the tun support AF_XDP Rx zero-copy, the vq's array maybe empt=
y.
> > > So add a check for empty vq's array in vhost_net_buf_produce().
> > > - add XDP_SETUP_XSK_POOL and ndo_xsk_wakeup callback support
> > > - add tun_put_user_desc function to copy the Rx data to VM
> >
> > Code explains themselves, let's explain why you need to do this.
> >
> > 1) why you want to use peek_len
> > 2) for "vq's array", what does it mean?
> > 3) from the view of TUN/TAP tun_put_user_desc() is the TX path, so I gu=
ess you
> > meant TX zerocopy instead of RX (as I don't see codes for
> > RX?)
>
> OK, I agree and use TX zerocopy instead of RX zerocopy. I meant RX zeroco=
py
> from the view of vhost-net.

Ok.

>
> >
> > A big question is how could you handle GSO packets from userspace/guest=
s?
>
> Now by disabling VM's TSO and csum feature.

Btw, how could you do that?

Thanks



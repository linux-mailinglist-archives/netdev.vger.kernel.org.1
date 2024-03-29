Return-Path: <netdev+bounces-83168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F3F891233
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 04:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C5A2B212D2
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 03:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B6B38FB6;
	Fri, 29 Mar 2024 03:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyGiD1Wy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0953538DEC
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 03:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711684568; cv=none; b=PcQFXgTBInslOCf5KZwTwIs0Lqg99+Y/77yrqGqurRURWlP2JGApfyOEesyH60sPSDWj7/DuaNIM8Hize69AzKJ7kzvxjCM6nh5mshJuUSWKO0IHvSb8j8m7yOE47sIHW+bm2NfzzlLRLhK4/vf+GBn295I71+tTU3L30kLM36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711684568; c=relaxed/simple;
	bh=LJdVzIjhdB6S/DcfelzDKPP9Yk+5ga0skvUpr5ygfQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbpbBVPcdX/xdC2bsZcGlm4ZuEnlCHKUfYlVaMhHpejtEE9Kc1XTfAe6XoKXV9ZXcLCq5P6ms8pYJw5RxkKEa5XBbZYLH8eTUPgb+djNJXtlxgexJXqiTQLexNTOZGjLY/Ctnzwtgayhq5djXp5/EAUTtmFoVtLKxeMc4tmyItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyGiD1Wy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711684566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJdVzIjhdB6S/DcfelzDKPP9Yk+5ga0skvUpr5ygfQM=;
	b=gyGiD1Wyt+1Jhi83kuzdCNeLA3KxmqJ6x+wJBZW3eahEfRuahfIEzaDFnCPrGqTeCp71QT
	3VCLYRE5BmjaoJKw4pS0ME+helrX6ZlWXWrNCV5f8mjBN0eb7XcmbBzcOnOb3AefSR0We9
	O6fy+fdU3Tulx1KyCcX2S3WgouojH6M=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-MHL6bNGoPgyxXACHnpZSzA-1; Thu, 28 Mar 2024 23:56:03 -0400
X-MC-Unique: MHL6bNGoPgyxXACHnpZSzA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5dbddee3694so958633a12.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 20:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711684563; x=1712289363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJdVzIjhdB6S/DcfelzDKPP9Yk+5ga0skvUpr5ygfQM=;
        b=wDdmWBbae5tb61dKd8MH5oIZuGbZJR87cFyakZDYP+G80zCjLAnzx7S+6eq5I/RbOX
         Fa3r97xlNYqd0XC/fdVjgO+O74zvw64XkwrWBvWk0WlmJSorj1KNSBz3VAydaVnTvMFh
         eXn/i+wVpJlgUbFQ2OiMsaBDN/bE/waSSw61M+cDbuhN3CYLQHvjiK4cGelRqq6+P/No
         tAgw9al2+2o2920k24RijSwfQ81AxsrIlex4RoydDLmnKgmch9cujBU2Tg26R3kYpi6b
         sr8UU+0cZXJM6Afy0WZkwpeIwmxtQ0z0dOemiiJ4B/Xhf5Rd+Oml1921Hw2aWA3tMPGS
         TmAw==
X-Forwarded-Encrypted: i=1; AJvYcCU5SVjygx724Zokg3eHv98iUIB58C57g5sGIoYSUBdTZG5xSSJoUNwlxSP9MTpTROwhrnYvVI4bsuOWiGWeV9mZ3dqgIyHG
X-Gm-Message-State: AOJu0YzIeaXgm8APYL6Ffd72UzCvM3NK2fbUZ7/a7vF6kJl2KC4AJvvx
	OOZ0fISCO0OdLGUbaFdnfBvoFFn0pZuAAwcDfSO7EOtoFils9cIPH/2UhQNHQ+ywzqYEXB2aCX6
	byU5+qHYUswmIKvvCqNKDXoYsMXD8kMvtVBtxbE+bz6aktPdGRpjyG131YAchr7sCj0VzFvwK6m
	wxykEj54MVVJFG7Bjqg14iDVV9NKoK
X-Received: by 2002:a17:90a:d515:b0:2a0:8d17:948d with SMTP id t21-20020a17090ad51500b002a08d17948dmr1838134pju.1.1711684562672;
        Thu, 28 Mar 2024 20:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5WpbyriUxjePwEjGO5X6q+YKYhB1eZJaJgrj4rVieoGSzVLIkn+ALnR8ZipwbzdgGvrRXqkbuUUu/vp0RL8A=
X-Received: by 2002:a17:90a:d515:b0:2a0:8d17:948d with SMTP id
 t21-20020a17090ad51500b002a08d17948dmr1838120pju.1.1711684562345; Thu, 28 Mar
 2024 20:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320101912.28210-1-w_angrong@163.com> <20240321025920-mutt-send-email-mst@kernel.org>
 <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
In-Reply-To: <CACGkMEuHRf0ZfBiAYxyNHB3pxuzz=QCWt5VyHPLz-+-+LM=+bg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Mar 2024 11:55:50 +0800
Message-ID: <CACGkMEuM9bdvgH7_v6F=HT-x10+0tCzG56iuU05guwqNN1+qKQ@mail.gmail.com>
Subject: Re: [PATCH v3] vhost/vdpa: Add MSI translation tables to iommu for
 software-managed MSI
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wang Rong <w_angrong@163.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 5:08=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Mar 21, 2024 at 3:00=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Wed, Mar 20, 2024 at 06:19:12PM +0800, Wang Rong wrote:
> > > From: Rong Wang <w_angrong@163.com>
> > >
> > > Once enable iommu domain for one device, the MSI
> > > translation tables have to be there for software-managed MSI.
> > > Otherwise, platform with software-managed MSI without an
> > > irq bypass function, can not get a correct memory write event
> > > from pcie, will not get irqs.
> > > The solution is to obtain the MSI phy base address from
> > > iommu reserved region, and set it to iommu MSI cookie,
> > > then translation tables will be created while request irq.
> > >
> > > Change log
> > > ----------
> > >
> > > v1->v2:
> > > - add resv iotlb to avoid overlap mapping.
> > > v2->v3:
> > > - there is no need to export the iommu symbol anymore.
> > >
> > > Signed-off-by: Rong Wang <w_angrong@163.com>
> >
> > There's in interest to keep extending vhost iotlb -
> > we should just switch over to iommufd which supports
> > this already.
>
> IOMMUFD is good but VFIO supports this before IOMMUFD. This patch
> makes vDPA run without a backporting of full IOMMUFD in the production
> environment. I think it's worth.
>
> If you worry about the extension, we can just use the vhost iotlb
> existing facility to do this.
>
> Thanks

Btw, Wang Rong,

It looks that Cindy does have the bandwidth in working for IOMMUFD support.

Do you have the will to do that?

Thanks



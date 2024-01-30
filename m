Return-Path: <netdev+bounces-66976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E0D841A6C
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 04:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F77283F35
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 03:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4487A376FC;
	Tue, 30 Jan 2024 03:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J5ChalmO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0341C374F6
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584827; cv=none; b=cstk7H+HCw1jYiB5OJKnXT5Im78g20hcRE/Waeq23Mwkjijdxz1O1HRMJPENgaUm0zVUDGWeotzAyxhsu10JTxghyA6QAoSS8BCMIt5LVau01LRoMbGs/qxS2ODToILi5Ie1M/LTQ4Ug0j/AW7ghP9+uVSrFFwXJXQtODWEX1GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584827; c=relaxed/simple;
	bh=d9WP4hd/Fgxj42lnIKM1zOhi36+ZV09aVbpyPYfs59I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvuT2rnhVcPqe2M4Fq2HIKRrHqS2sKG0qpy94uOtZUvzzCs+c6wdsBNoRtGYnC3TY1xIOQlAM9Q16Z8UZTtj/82sDb5xAl0OrE7OdlXInrFepEP/41WZav4F3oVR2vek943WB4jxya+SoUKc88Fcw1GLUxSeorHY6FpnGmwaSu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J5ChalmO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706584824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d9WP4hd/Fgxj42lnIKM1zOhi36+ZV09aVbpyPYfs59I=;
	b=J5ChalmOheO/JWEFdCKNhtk5aQsMsRPGxeL6E5Gfz1lgokBKUAC24/V7F+r5bWoxFJ9CCU
	s/pbIzhzYR4edV8N0nELTXO2kBFP0sR8qGDx1VDinxFGA9BQerDUzhf/iL47HGWkWG55TB
	Im+i2pUFDR+vTKxX/btRKLcKSYIWj5Y=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-MmVMx3W2P4CKzCQ6wIwKbQ-1; Mon, 29 Jan 2024 22:20:22 -0500
X-MC-Unique: MmVMx3W2P4CKzCQ6wIwKbQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bddadbc2bbso5016583b6e.1
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 19:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706584822; x=1707189622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9WP4hd/Fgxj42lnIKM1zOhi36+ZV09aVbpyPYfs59I=;
        b=KNtCoSaYWFl9A7kSBUdiqBSWyZUKx3ALpjY6u0DZiu8t6p3TzSTl3Y3jPT/3PKDSsJ
         BwVxKLHdc+IealY8oW6LmVvplEUzalNGr3K6gHSKmperGjRIV3CkwCSwVooFX37M6l+B
         yYeWHiJnPeuIPRrgk7SvieoReKd4SJc/GWaxQm1fZNm84wfLNwFQxo81HVJpSLayvmNk
         1fhGFo+3bBALHuWtEbiDxmxvbgZ7PT7fNw7hw4VaaV2LaRIiJx8a8Kxhex4v5+YAu4RX
         nVLqnqd8XYhco20E/8T/k83ESiQcBBuz401qQ4r4uc8HW4WlOcN+ncsP18pKUzoqsS0t
         5sLA==
X-Gm-Message-State: AOJu0YwYATvU2orwmYVY5c+3yAyZsO3DV0PGnjl/sXaD490iW8ccZHVx
	X9LMXwmIvDsPQjeQJKYPYI98eaUVQZy6hR8M+dY7YngcswGHz1surH5ywWZ2sWLSe7Pdj+3bxY3
	V7ywh6it1nbP7P57SM9BC4XBL+Y1ESWAOYzDN5wrIhqgmidN382JUhH7v6zS0XC3N2YvTKMMWgk
	BBFxmqtK+S9aYZsyF54IZOWKNl4cL8
X-Received: by 2002:a05:6808:1154:b0:3bd:c08d:91f6 with SMTP id u20-20020a056808115400b003bdc08d91f6mr8998035oiu.29.1706584822075;
        Mon, 29 Jan 2024 19:20:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuZW0m1kap/LxF2wEFM1hvLV2SMn42n3fITC1r2n7f5Wmal4bhgCfEoA8SCfS1utE4NY7HHhgI/uSaJBfNbvo=
X-Received: by 2002:a05:6808:1154:b0:3bd:c08d:91f6 with SMTP id
 u20-20020a056808115400b003bdc08d91f6mr8998027oiu.29.1706584821857; Mon, 29
 Jan 2024 19:20:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226073103.116153-1-xuanzhuo@linux.alibaba.com> <1705384540.169184-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1705384540.169184-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jan 2024 11:20:10 +0800
Message-ID: <CACGkMEsOs5L6eU==Vym_AkomvhhkHN0O_G9SaPFThAtH9XVyJQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/6] virtio-net: support device stats
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, Zhu Yanjun <yanjun.zhu@linux.dev>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 1:56=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Tue, 26 Dec 2023 15:30:57 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com=
> wrote:
> > As the spec:
> >
> > https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bb=
bd243291ab0064f82
> >
> > The virtio net supports to get device stats.
>
> Hi Jason,
>
> Any comments for this?
>
> Thanks
>

I see comments from both Simon and Michael, let's try to address them
and I will review v2.

Does this sound good to you?

Thanks



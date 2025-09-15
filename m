Return-Path: <netdev+bounces-223099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B08DB57F5B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 16:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665641612FD
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF37130BF78;
	Mon, 15 Sep 2025 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POB65N2W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF7015D1
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947578; cv=none; b=jb4TnsB2USQSY+z4T9jl2Q802Afw0zcTog+pAHSGwZXfMjDdcE4j4kThz+vYFd0td8N4+a3w7iP29zkElQlu2lFuspIvlziyvQBlObDq8pTZRplLpU7aMfLZw5z1r0YDvy1YAdPkx2T4Uj+oqquP4LOo91pV7CNYboBhJ0dsNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947578; c=relaxed/simple;
	bh=g2Pnb04/njOJX6OP/WYZ5RrANes435aK4i1BTsy1kfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uAQQEbSAsSZLFReKS4wI0iIvQIl4Xl8KneW83opY4ngUzrHbcIF0qpIq5WJqkMBuBijDkPCoshoHyAQpmqngx0O71+4hBb2O0NqHXn8tz8gILL6rRcjhP+AXWXJ93ZYdvABoahQZN7vfcva5KyO8JkM/o1ukt9jkin6dgIF+dCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POB65N2W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757947576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g2Pnb04/njOJX6OP/WYZ5RrANes435aK4i1BTsy1kfE=;
	b=POB65N2W1RniHGMR+285ebPL6Ouch8j4wZhGL3l/FQaGa7M9xT92x9LvGvReMGjyDPayni
	F+qqAxjPL3FrZy4FJMxMEReXzEFetv25y1Abuog5stSYkpsJWuy6Pxl4yZ+cUJxYI7Rk8I
	3b62XpHDewKgnpcqOCBOJEu6zq5Zk9A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-hAAL9-WnMkemcrZUKKz3RQ-1; Mon, 15 Sep 2025 10:46:13 -0400
X-MC-Unique: hAAL9-WnMkemcrZUKKz3RQ-1
X-Mimecast-MFC-AGG-ID: hAAL9-WnMkemcrZUKKz3RQ_1757947572
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-afcb7338319so352347066b.0
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 07:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757947572; x=1758552372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2Pnb04/njOJX6OP/WYZ5RrANes435aK4i1BTsy1kfE=;
        b=pqL6GYLPSBWlXASBsWPNluROE5z9bSDxrpnt4E5owltnKZqiR8GC9eVzYNwv3p6Dnq
         eW3w2HBXKO0moj+Ph7BFgeNpz0CNTXHBq5+LdAv/nz2qEl7CvwXEzf51pjT5aC7q3M/T
         fwf0lH5bkFs9DvgUG/+BfTLGTbVa5LR/rid//GwxID+ml3EMAcBCrBqn+BRWrHgdXXMy
         mwxi1+yahqZep43gHiMLOraJ1bEeGzZHWYbITVXpz6z5xNmYW/U1XNIx0+YAtrSN57Zl
         CeZIadiY5yZqHxfXfIYXn5cEZj8zSG3f/zXmQ1ujOIXFlCeqXUXwEBB0StuoXulFHgF0
         eyJA==
X-Forwarded-Encrypted: i=1; AJvYcCWI5ms4s3mpyBdxSEgxV92O+6C2T71IvftDV9mN4IoYz7eg9BljJ5UzgFpcr+nXBi1SG/1QFrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx5DxzU0tuS85doSB241ukCU0qSIyRk1nU+r8xwirk+bo644Xu
	pJq1bStWSPWLwz+K9Kksgqx8F3mdPGJ7Bg3KEfqrdEGVM4fYAZeLrOzzCPLfhHnD41B0lJPfTYk
	WvI1XHZN7IhQYxvQrJHJmAXlDQidi5Wq3luVEdclUZWsuYGMyUyqaXeB8MgorxvCZJ4AQJrIJDc
	9MxF1/FzKn/IYIgSN9yb3TnkZIFbO8hMai
X-Gm-Gg: ASbGncvCOnt8pM4FBCOPsWrszPK2WDtLRivl4+KRxBBkuYrBBlHXgy1Qo5tOm3CWHbw
	nd6I6eR3ZUE/q6O4xPa5AdizeVmoB/+NRtDVWDgLO5J8tkRvWc4E8EyYuz9niN0jKc4EqsMol7/
	8QabUUWriS/RrGW7Ia1PrDtA==
X-Received: by 2002:a17:907:3e03:b0:b10:ecc6:5da3 with SMTP id a640c23a62f3a-b10ecc6640dmr347176766b.63.1757947571752;
        Mon, 15 Sep 2025 07:46:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERqnM4TDFaglXTZ1TiljWgRnJ/XQu6e2iToInrsLSac1TYz5imtwKAo2yzppRLZeL61hsUVinU28MLjkJY0qE=
X-Received: by 2002:a17:907:3e03:b0:b10:ecc6:5da3 with SMTP id
 a640c23a62f3a-b10ecc6640dmr347172866b.63.1757947571319; Mon, 15 Sep 2025
 07:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
 <CAPpAL=zn7ZQ_bVBML5no3ifkBNgd2d-uhx5n0RUTn-DXWyPxKQ@mail.gmail.com>
 <glf2hbcffix64oogovguhq2dh7icym7hq4qkxw46h74myq6mcf@d7szmoq3gx7q> <jserzzjxf75gwxeul35kvvexscs7yruhlddwhmw6h433shfdhf@jsesmjef3x76>
In-Reply-To: <jserzzjxf75gwxeul35kvvexscs7yruhlddwhmw6h433shfdhf@jsesmjef3x76>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 15 Sep 2025 22:45:34 +0800
X-Gm-Features: AS18NWCPqkI_mOz0DI25Cy8SLU0CdLKom07g_re2BVpx_B9ko5kxeK11-LxKKX4
Message-ID: <CAPpAL=z2YXWDV7HVeSzZbTAUNrb1h4R3s1kmWSyjXp_r7iar8g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/7] net: ethtool: add dedicated GRXRINGS
 driver callbacks
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, 
	Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 6:58=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Mon, Sep 15, 2025 at 03:55:53AM -0700, Breno Leitao wrote:
> > On Mon, Sep 15, 2025 at 06:50:15PM +0800, Lei Yang wrote:
> > > This series of patches introduced a kernel panic bug. The tests are
> > > based on the linux-next commit [1]. I tried it a few times and found
> > > that if I didn't apply the current patch, the issue wouldn't be
> > > triggered. After applying the current patch, the probability of
> > > triggering the issue was 3/3.
> > >
> > > Reproduced steps:
> > > 1. git clone https://git.kernel.org/pub/scm/linux/kernel/git/next/lin=
ux-next.git
> > > 2. applied this series of patches
> > > 3. compile and install
> > > 4. reboot server(A kernel panic occurs at this step)
> >
> > Thanks for the report. Let me try to reproduce it on my side.

Hi Breno
> >
> > Is this a physical machine, or, are you using a VM with the virtio chan=
ge?

Yes, I test it with a physical machine. I didn't used VM=EF=BC=8C just inst=
all
rpm which compiled based on this series patches, then hit kernel pahic
at server rebooting.
>
> Also, I've just sent v3 earlier today, let me know if you have chance to
> test it as well, given it fixes the issue raised by Jakub in [1]
>
> Link: https://lore.kernel.org/all/20250914125949.17ea0ade@kernel.org/ [1]

I already submitted a job to test v3, the test will be completed
tomorrow and I will update the results promptly.

Best Regards
Lei
>



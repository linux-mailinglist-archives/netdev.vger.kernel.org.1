Return-Path: <netdev+bounces-170612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C33A494E0
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A192171368
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A81257AE4;
	Fri, 28 Feb 2025 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BavGDj5/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08EB257428
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734791; cv=none; b=q0JcN/Dm/RF4KMti0YsatsOxXaMo4MRxU1ccYdGa/QtfPAgClN6SCmQqFg6Kfedi6MONIPQbrjKZB5asf/3ixe/gLO2oXcreFWKsit66qMXbGo4flRfJDKY1iQE8uMWbl4G3wHDSy5cOUsIpl12NE7kxpDrsdMb75kgEb1ywQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734791; c=relaxed/simple;
	bh=qyXnd1QeVCFR0UPHxNUE8dIZREv7JdUyyVgv52l4qOU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iy7sGB2wdlTEPZEQRGQUCKKHBdInMUy7MOZCLOng5EnY0x59TBEGoINAcrosOLFLxLyouMmNi9TWtlfQAz3ykDJS+bcd3woW4GPg5vE4BoIldelI/4wqBMC9wARM5aE27Wwqn81qJ0KX7k94y74FnZ/dtCpUHvYjVrjdybzFkpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BavGDj5/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740734788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyXnd1QeVCFR0UPHxNUE8dIZREv7JdUyyVgv52l4qOU=;
	b=BavGDj5/i86PhS/FOnIADA2YgCqonFhRr4ReaM5Qqxn36Fa99XWaTHVyrQXLuEmE9R/OeB
	0kkRVY4KHIuPXA8gVrop7tJc5CGjzOp9KRxbTDX92ukd5oA7vJmZDVW4h+YT8tqi3xvbTE
	4TiRlEJjLL70pb9Yv103EWIUvoC7mRs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-iK4tGHs3NV6gyyUOYNyQ7A-1; Fri, 28 Feb 2025 04:26:27 -0500
X-MC-Unique: iK4tGHs3NV6gyyUOYNyQ7A-1
X-Mimecast-MFC-AGG-ID: iK4tGHs3NV6gyyUOYNyQ7A_1740734786
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43935e09897so13787445e9.1
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 01:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740734786; x=1741339586;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qyXnd1QeVCFR0UPHxNUE8dIZREv7JdUyyVgv52l4qOU=;
        b=bY8t+Or3oKnU3bO4EXilPEfRoYBk6gmUXpoP4q6qf9FNVJNxTFJbVTyEGegF87R4Vb
         ypJpZC5SJMyVSrkE1S7iVuKTaxJe6XTJ8YkKx1n0VcBbnu6RvU1FQJDdnCWavPc2cA5J
         hU+FvVqSvUtQWDFMmQvmMir169NO+/OxTCykNyXAKVTnxCSA/MprAyMHD3RiOZiTZhtn
         FAMtuCJZEwg9P1zlCNUdIu/k2Jpax1NwuKbXu3uaeMBwkG6RCk74+pVMuAwff9z0YzOw
         bAbBbzL43D+I+HHFxhSUmqJBNMWD7U4ulWaEZhQcbRc9IOliGpqpXbgXtfPjW4+IuUd7
         furA==
X-Forwarded-Encrypted: i=1; AJvYcCWonz+V9AV7ANzeO7i/mf+0sJKoXM+OfxbzBZNlN+kvE0JImioDF9exbkNxD2bBj1xpa8nV7KI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+zZCwvnbWYWotZQGc2b1T7lGUsCYRCU9Jmt4ULwD1uYGJUBw
	FNvkndSmC6JSkqwXouKCG5tNKsBRmSwSwtvSWI9bIpQ+JB7MB64vXeQwDT/yI2AgwMOoxyELQHR
	BLznBumSfq7Id18QVsU7cicwxxekp0u4fd9dTXdc/+rLKs2040ntMww==
X-Gm-Gg: ASbGncvfJURAxeuhK7D6/aNMLu2LVlHQbqCdeiSIuh9cAgU/+qxG7tSBjLG34wFt/yv
	gt+3mWQQCEo2XXj1SG1la3qfPWAbnZwQKll4R5WA8lY34N6OyCYdFIoKIigawzfe+cMlJ328LbE
	vg1+peSqAaCDdVhGkpeX80FIVJY1KOqgaV6wmqcnr1MdG52/PlJryT4Kw8vPUEGIAtFMpjPNABJ
	10r3fVJz2OcNSHh8k6y4VbuFP+gMLXYHPiDBmwcXWXA2MdTWwnkgFLD1MbpOLQxy1maHLny/CDi
	gGWh4bHCO9kSEAcdtXVqeViK3rCt0h89/7x5HOI/sFP4bsVbx7TXUrolCNYEqiIOUw==
X-Received: by 2002:a05:600c:1c85:b0:439:89d1:30ec with SMTP id 5b1f17b1804b1-43ba6747587mr20161705e9.29.1740734785952;
        Fri, 28 Feb 2025 01:26:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrk8HCJDFMTsz7xCP+NNdsyxhZ1X9lB/qPY5M9JGAe9E6mxJhigejXtxTR6plCVUKRLft8mw==
X-Received: by 2002:a05:600c:1c85:b0:439:89d1:30ec with SMTP id 5b1f17b1804b1-43ba6747587mr20161455e9.29.1740734785589;
        Fri, 28 Feb 2025 01:26:25 -0800 (PST)
Received: from ?IPv6:2001:16b8:3d09:ac00:a782:635e:5e55:166d? ([2001:16b8:3d09:ac00:a782:635e:5e55:166d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27b27bsm49277385e9.31.2025.02.28.01.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:26:25 -0800 (PST)
Message-ID: <a7720a091ea02a6bbaa88c7311d7a642f9c7fdff.camel@redhat.com>
Subject: Re: [PATCH net-next v4 1/4] stmmac: loongson: Pass correct arg to
 PCI function
From: Philipp Stanner <pstanner@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>,  Huacai Chen
 <chenhuacai@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Yinggang Gu
 <guyinggang@loongson.cn>,  Feiyang Chen <chenfeiyang@loongson.cn>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Qing Zhang <zhangqing@loongson.cn>,
 netdev@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,  Henry Chen
 <chenx97@aosc.io>
Date: Fri, 28 Feb 2025 10:26:24 +0100
In-Reply-To: <20250227183545.0848dd61@kernel.org>
References: <20250226085208.97891-1-phasta@kernel.org>
	 <20250226085208.97891-2-phasta@kernel.org>
	 <20250227183545.0848dd61@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-27 at 18:35 -0800, Jakub Kicinski wrote:
> On Wed, 26 Feb 2025 09:52:05 +0100 Philipp Stanner wrote:
> > pcim_iomap_regions() should receive the driver's name as its third
> > parameter, not the PCI device's name.
> >=20
> > Define the driver name with a macro and use it at the appropriate
> > places, including pcim_iomap_regions().
> >=20
> > Cc: stable@vger.kernel.org=C2=A0# v5.14+
> > Fixes: 30bba69d7db4 ("stmmac: pci: Add dwmac support for Loongson")
>=20
> Since you sent this as a fix (which.. yea.. I guess.. why not..)
> I'll apply it to the fixes tree. But then the other patches have=20
> to wait and be reposted next Thu. The fixes are merged with net-next
> every Thu, but since this series was tagged as net-next I missed
> it in today's cross merge :(
>=20

Oh OK, I see =E2=80=93 I'm not very familiar with the net subsystem process=
. So
far I always had it like this: fire everything into Linus's master and
Greg & Sasha then pick those with Fixes tags into the stable trees
automatically :)

Anyways, I interpret your message so that this series is done and I
don't have to do anything about it anymore. Correct me if I'm wrong.


Thanks
P.



Return-Path: <netdev+bounces-82498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AAF88E6B4
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E187A2C936A
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FE712F5A4;
	Wed, 27 Mar 2024 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pk6hLqmE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C194E12DDAF
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545614; cv=none; b=koFRReVUYFU6Npk6QAyptViPBH8WEEVaN+3nMNYy+6oFRkxibT2/MuQP+7D2Okh5mBu9JF9mnMqyI6aBZZdiOlXgB6Ls2KQ2zw89pJTe+aeD9GDpqGRm8i92q6NXHmKp8pbK+mmU3LMRyPnnEe7IpcrBecJ/OVFGwl53LncMcVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545614; c=relaxed/simple;
	bh=UROGM+XkFg3yupHbF5hlIV7Mxhlimzst06c0vUXjobM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tiCcLelk+lLuJLvsl4ZYDJuVfitujOrSYFoPwUcejIXhNPuo7rp/HMJFa9TsTrdAR1wdip1fioPQb/PGt9oVm8goZmT+zQOFjQuhpOUPjhS2mJlDnMcj1xp0ojxBFPnu6I4iIdOHXqxOt3G3bYboORHntepaC5tTTdBanFNwDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pk6hLqmE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711545611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UROGM+XkFg3yupHbF5hlIV7Mxhlimzst06c0vUXjobM=;
	b=Pk6hLqmEfjkq/mlbGK41cjnwZ3RwsOcNcUc2kl6VM68LM5eQAXvS4tJJWzJ+vHweunerff
	Qg6ifsj9vksf/B/U3OKh9e5RDv0MnItYA9v4JuLU/KHaNroynuUsH4vimlQeCnJllmvvYI
	BoK6cDTzNH5A0GCYow9FYsPWBErerFM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-RwdqlDrDN-e0GgpB2EU7YA-1; Wed, 27 Mar 2024 09:20:10 -0400
X-MC-Unique: RwdqlDrDN-e0GgpB2EU7YA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d6fd7087eeso908211fa.1
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 06:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545609; x=1712150409;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UROGM+XkFg3yupHbF5hlIV7Mxhlimzst06c0vUXjobM=;
        b=a8HbbEgPW+AA8uaSNMxHJ85kjNw82XXxW9p4dyAecTwR6SfAGl4MAAiX0aPvLfKQs0
         Izx3p8xKWCA9ld8kdrX12Okj3PibJd02Y4DBq1Jlqh5cUj/ifvQetymM4jTDXHcUqDeN
         ejae4YKZSsg77vY/MuxPQwwtM7o13lOTWm8UjaNB/7AH7zkYrtH0En5Lbo4G1D30kE05
         lwGpNG+iUDcn4xHMH8qQmqIS0bkwxp/WmCl9a/kC08pts5UM5AZLmv2pVBzn87orcWzQ
         ge+tAe90podTwJUzzeoHnKt3G2lvO57xJx7XRXlpR+YXjwdxaj8sghlu0zTc2LXd2Z6k
         98Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXiCPLA0kMWu+rnAkT+x1VFJC0ZgdMkZ1dq7M/+tIpmgZlHaECc6neXdSA58yUvUbGkFPmIV3Zw5feTOUPmNbZcK0478Zee
X-Gm-Message-State: AOJu0YwcszgL7/qiFT9mXQJnu7k+jEaFRdlB9d4GJZnqUNArNcLCTqYT
	gAqzeVgn5KmW+ZDIibBZvxOcs3PQivYeqKGlbKscAx4XgWa5s/0nOHsKoXvTHhRBDgQq+OYZZXe
	UCe3yfYZMtJ2Qj04sQqFg22MC+rv3N0qbVRZ0fMMBQJ1RF57tYCUwOA==
X-Received: by 2002:a2e:83d6:0:b0:2d6:b9a3:159c with SMTP id s22-20020a2e83d6000000b002d6b9a3159cmr30828ljh.1.1711545608761;
        Wed, 27 Mar 2024 06:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlMKDcBuGA2kcjRl2CPFWsG9+4QM4h+MpzipOdEkLChpkdvwnbHANzywbkrUs3HWVtarLZiQ==
X-Received: by 2002:a2e:83d6:0:b0:2d6:b9a3:159c with SMTP id s22-20020a2e83d6000000b002d6b9a3159cmr30805ljh.1.1711545608142;
        Wed, 27 Mar 2024 06:20:08 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d13-20020a05600c34cd00b004148a65f12asm2152280wmq.1.2024.03.27.06.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 06:20:07 -0700 (PDT)
Message-ID: <4cf0d7710a74095a14bedc68ba73612943683db4.camel@redhat.com>
Subject: Re: [PATCH 0/2] PCI: Add and use pcim_iomap_region()
From: Philipp Stanner <pstanner@redhat.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>,  Realtek linux nic maintainers
 <nic_swsd@realtek.com>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Miller
 <davem@davemloft.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>
Date: Wed, 27 Mar 2024 14:20:06 +0100
In-Reply-To: <982b02cb-a095-4131-84a7-24817ac68857@gmail.com>
References: <982b02cb-a095-4131-84a7-24817ac68857@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-27 at 12:52 +0100, Heiner Kallweit wrote:
> Several drivers use the following sequence for a single BAR:
> rc =3D pcim_iomap_regions(pdev, BIT(bar), name);
> if (rc)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error;
> addr =3D pcim_iomap_table(pdev)[bar];
>=20
> Let's create a simpler (from implementation and usage perspective)
> pcim_iomap_region() for this use case.

I like that idea =E2=80=93 in fact, I liked it so much that I wrote that
myself, although it didn't make it vor v6.9 ^^

You can look at the code here [1]

Since my series cleans up the PCI devres API as much as possible, I'd
argue that prefering it would be better.

But maybe you could do a review, since you're now also familiar with
the code?

Greetings,
P.

[1] https://lore.kernel.org/all/20240301112959.21947-1-pstanner@redhat.com/


>=20
> Note: The check for !pci_resource_len() is included in
> pcim_iomap(), so we don't have to duplicate it.
>=20
> Make r8169 the first user of the new function.
>=20
> I'd prefer to handle this via the PCI tree.
>=20
> Heiner Kallweit (2):
> =C2=A0 PCI: Add pcim_iomap_region
> =C2=A0 r8169: use new function pcim_iomap_region()
>=20
> =C2=A0drivers/net/ethernet/realtek/r8169_main.c |=C2=A0 8 +++----
> =C2=A0drivers/pci/devres.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 28
> +++++++++++++++++++++++
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 ++
> =C2=A03 files changed, 33 insertions(+), 5 deletions(-)
>=20



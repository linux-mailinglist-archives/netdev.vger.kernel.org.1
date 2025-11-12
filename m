Return-Path: <netdev+bounces-237934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29748C51BDA
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 11:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336433A9DBF
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CA3303A23;
	Wed, 12 Nov 2025 10:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djVxInjL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/xEfp7Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827782777E0
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943714; cv=none; b=lFSNqWr3+a6PIraLwjuzJDsp1ciK0ZYzgWykd1XXOHWRIEdTRLAeomi8fWM2ABqLuagHDyvCrRMJ5+vTUVR67j5FIHx4CD7jIx7uDpW8Jxjdn0nMtm+HqdpRi2vwV22Hz48DW0wPj0WzFUfpRRMi9UI82QPBUfrp2BjZiyP8b5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943714; c=relaxed/simple;
	bh=E+tvlKSlf/4Wz9KSvYrxWC/QgGC9Mmj94VvKntU4n/A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MsIWCHxxRUnH7QiRho4VChg+kBkkJiJcejlKwtEBfeEA39CtrxmMixM+OOoMPbHVTPcJ2tz2tuUf1zN6ouzKxJ9RnBS53sr2dzz4uW2ewWH52SqVq6DcRt2hUknxk56IzljCOGXy5wOrW+hyG42UlQTSfx4AhdDuSEgd0LWa/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djVxInjL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/xEfp7Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762943711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+tvlKSlf/4Wz9KSvYrxWC/QgGC9Mmj94VvKntU4n/A=;
	b=djVxInjLuLu9rPixoAOJG3jcdCyUpkESYda4kSVX+m5f7FB2FM69sLZ51a6bZAJN5gPTYo
	DuyOeF8mYB5A1buDhgq64TZM21lGzORUKgofE9zieK6orpUtF6cM7GqPwKut0D41k/gkas
	HgOvn5IZGjB0A6shTbovZsR7SCLTtx8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-8EeHDCxBOtePY0sgHbodbw-1; Wed, 12 Nov 2025 05:35:10 -0500
X-MC-Unique: 8EeHDCxBOtePY0sgHbodbw-1
X-Mimecast-MFC-AGG-ID: 8EeHDCxBOtePY0sgHbodbw_1762943709
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b733a653a8cso24588666b.3
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 02:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762943709; x=1763548509; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E+tvlKSlf/4Wz9KSvYrxWC/QgGC9Mmj94VvKntU4n/A=;
        b=O/xEfp7YWmTmvHPNePKBPS7LOLgpU6Rh/qjwQolnaee3YDJcfoNHYlc6hLUklp/WQm
         0cDIiAV5Tg8D6Kgk5Rvdz1/B0rxC9x7xim1rvQ6giiIAZxM7/tYTc5NbyFlClqu4q8Ns
         D0AelqmdOAZQRFfxLYfgndSoJdfUrd/vlgnypx58P3WqFkz4OdYn6ZFUWxRXp9GYrQtb
         RciT85XY9v7bTFkaWoI2GCj3AEL7Oo0orIKqtF5YI3DZDyK8xR8HAdl7SrsnacjTm9ir
         mu88aBxtMmysQSaqE10yFZdNCWrb45I8Bd/Vq0A2JI/Pv8YKnLt8yobxlNa1+568bDG8
         NxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943709; x=1763548509;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+tvlKSlf/4Wz9KSvYrxWC/QgGC9Mmj94VvKntU4n/A=;
        b=T6ymiziUtg5+iO2cd2NHs216y71wz4hB1QBzH7j4GSPrQB7T4/RGcn97Z/2BHK6I7q
         /vnYXEQIohLqno6yRVOFVkB6ea4agy36iVIGl4c6JmntG9QfZC3IMXWLPttjVDuMSgXL
         Y4fnAx9LQxCYYt+c70Z+NPVJDQ8cXRCKyyavwdJ0Q2wExM/BjQNraBd7pJd6y2eJ9GRw
         9ZhVix0Q7UWCXX4CP8GmYIPl2CyUF05iuF29tC+F+Ax7lFB8YnYsChCf1RoxFjYRHDm8
         BYpxHrErebFyK2yFJIe3pPjgrVv0uBKVSht3Io/p0fMwkf0c24MxBwfaL22I3iRSt/wz
         vTlA==
X-Forwarded-Encrypted: i=1; AJvYcCUWcGBkLsnUMx82I8veZs97ZYzHRVvncHGlS2k2dJZzrouKSOXGy76F2niV7EFDE7i8WQhIqeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwudaiHBaRYC96z0h31CMQLUO4eF7fPOTXuIB2Kmdyal7qc2+Qt
	ZgzyclqjwI0QRo/uPBrDcQ8ykSj4QaoR3qiu6qWEkont3AMf2w/qHJIN1M6Jfwjyk2w7FrZLt8E
	zsfPLwlfOm/asvLdT2n7C8QQPRQhirLVAkWHdpWFkoRVqVev7xwVAg8+vCg==
X-Gm-Gg: ASbGncuRv/Lk/6wojEWCIbcP0EBEnd83ouccL0rFryruNrjdqOBQtboT5Yc/EWp+pR+
	oFN5OqH7O8Q9+ys0+EhyH2DcI0RhmVtcSz6w3nqiUG352jilYSOFHL+bRBig+R1+cuECgQfeF8o
	vujDcyYNYDgLYUYPoTtZrx9pL3EkMWpU6OjlWSsM1gxa7hGHZUbK4lsyZOoxXDuB3jPisPcPe03
	keczuwyBuiSPA5cyaJw1dA3ZGgaJF0yA67qfDj7xZtznPwYwg0vgUJKu4+bUOE01YLoJT/wtDSI
	NXWLlNdCJl8966kdptMJI9xuGidEwS/+/uxgQkAxuBurDb+1V9Ejhl9dCwzQS60avfE/cMf+LTN
	As9IxYsylJM7Kitea4QS1NMY=
X-Received: by 2002:a17:907:c1c:b0:b49:5103:c0b4 with SMTP id a640c23a62f3a-b7331ace073mr291846966b.56.1762943709058;
        Wed, 12 Nov 2025 02:35:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0/W7QILhc20zuI/PbypJ8sMQLsdF6TH22S7u7UG3VgCM2TlPgQLQWKEl5Bf/jjsWA11F+4Q==
X-Received: by 2002:a17:907:c1c:b0:b49:5103:c0b4 with SMTP id a640c23a62f3a-b7331ace073mr291842966b.56.1762943708631;
        Wed, 12 Nov 2025 02:35:08 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64179499189sm8607152a12.8.2025.11.12.02.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 02:35:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2C7A2329674; Wed, 12 Nov 2025 11:29:54 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, William Tu
 <witu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Nimrod Oren
 <noren@nvidia.com>, Alex Lazar <alazar@nvidia.com>
Subject: Re: [PATCH net-next 6/6] net/mlx5e: Support XDP target xmit with
 dummy program
In-Reply-To: <1762939749-1165658-7-git-send-email-tariqt@nvidia.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
 <1762939749-1165658-7-git-send-email-tariqt@nvidia.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 12 Nov 2025 11:29:54 +0100
Message-ID: <877bvvlf19.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tariq Toukan <tariqt@nvidia.com> writes:

> Save per-channel resources in default.
>
> As no better API exist, make the XDP-redirect-target SQ available by
> loading a dummy XDP program.

This is a user-visible change, though, no? I.e., after this patch
xdp_redirect mlx5 devices will no longer work as an xdp_redirect target
out of the box?

We have userspace code listing the driver support in various places
(e.g., here in xdp-tools:
https://github.com/xdp-project/xdp-tools/commit/1dad1d6e0ccb086b8a31496931f21a165b42b700);
I'm sure there will be other places. Since such code would up until now
assume that mlx5 just works, this will end up being a regression in such
cases, no?

-Toke



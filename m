Return-Path: <netdev+bounces-156987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB18A088FE
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 08:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE50188ACAE
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 07:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95D3206F09;
	Fri, 10 Jan 2025 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjGjv8dF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123A82066D7
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494635; cv=none; b=jthCcqf16/Q29Q4q46vyhhEuB/89Js857yCEmMOch63BhhtFC9ngXqw7qznAPhyPB9H1vM4tCnnyngE1bqI/yt9TtlBpj32zSKGDi0lfUNsMhDWnsmTnAnWl/w+a/PeiYLuRzbxR8WlqibzDvdU8lHP/p1NTybanxdzPgTQXIlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494635; c=relaxed/simple;
	bh=lKkX0jSDmzCgHP0q2ZI55ieL6iTIROIb0PrZYeN893Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7BfO6VICWIydnPrOM7aj9OZwdxsqDQLiCDGONnWQgIdMTeNNmm09ZCXnmvs8k1IsyoorKPSabbnZQmA6i2xu2rEIcsNPyEUH0+H36kN5DFgZt8EXp3GOMhvbujS3lQMVf0bKdh5eXa0TzK0AuNYi1gMlL2vnlTqG8rj77L106I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjGjv8dF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736494633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKkX0jSDmzCgHP0q2ZI55ieL6iTIROIb0PrZYeN893Q=;
	b=LjGjv8dFt7nl6O2CtwsqoRBmVtHEqXzlCk40E8vmw5rnz0x/98UPI5NryoRI29qtobEjjW
	LN+xko2if9MmBiHiEurZa0FnABo7FbRGO2l+Qo4SH/ItuwXrzzSBYsVphNKlDB1dOslLZY
	AIdi7Q80oGfmdzhRwhvFKNwGg3wESdI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-1ctFm5HpOSCybaHFOwDoPw-1; Fri, 10 Jan 2025 02:37:11 -0500
X-MC-Unique: 1ctFm5HpOSCybaHFOwDoPw-1
X-Mimecast-MFC-AGG-ID: 1ctFm5HpOSCybaHFOwDoPw
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa68fd5393cso156387766b.0
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 23:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736494630; x=1737099430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKkX0jSDmzCgHP0q2ZI55ieL6iTIROIb0PrZYeN893Q=;
        b=DqLQxK4FsNbFlp9tW8ZBBuOr+bCOxKyYLMkZ8F3yGKArIMsvEQAylQgf7I32ZT+emB
         GDDq7DJI/ZBbZYPgtCjnBf8dMwNGUa2WmQaBF8g3cAgtkw/Z4btZFKo/lwtKW4Acobkq
         Xfg+gvf34uXE8u+FW+GRtQ4S5q4TQ3Z1H6QqxVcLxthg2+NCMGpn+XXGi9ajJBfAaFbV
         O5mBzGAURkzMRHYUBCLQslhcm4EUbFjc+E6Ov9586VX0r+A5igRFQyNJMWkI2SfhAvIe
         10yn1KGjjJSpsEmvoYY6qdH9Hr1zW0Zl4qgr3l+lZBQkn4qDCqtKL8ZmvK+sWgghECeN
         RyVA==
X-Forwarded-Encrypted: i=1; AJvYcCWsUUil/FWEdTQj+9scO/vNrR0Y8e/5//MlKmw1oNgksUhnjWk7kXtvsco4EHbt6dNO61M0VsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwroDF15RU1+pJKz1e/8rsoYKcn+RhV66C6QCOs8POvDJjY0F7V
	tG7DL3ako/0t5otKPC7AV8ltnsQ8CPQk/kCw10sM7DXfBt1mLMrTeNT/JWoydwWJY54pDWpwp1a
	GJmxgLZW3VVWoFfmBET0jlSn4pd3agTURdqksnwZA8up+Ds1mmNRAjxR9KDHDfsBkdXkNqWP1pl
	72aclNKDC371qutYb3qa69uD1ItjA+
X-Gm-Gg: ASbGncvhNwGSw2S/eph2yk2wg0NSUVRndZKDbvUnHpgaJKIMLWM8yw+qyGdMOb5d98i
	wNVPDZER21Y9DAO4WbFCGVenZMqxKKWy7nrQwWfo=
X-Received: by 2002:a17:907:3d91:b0:aa6:7ff9:d248 with SMTP id a640c23a62f3a-ab2c3c452c8mr540919966b.8.1736494630063;
        Thu, 09 Jan 2025 23:37:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFM+E3EJ9VIADqft4XZeqnSe1+lGGIJwDA4N/xijHGbaNmJmQVeQUzAlHVdy720k+fmj7KB/3fUzKLdRp4U0YE=
X-Received: by 2002:a17:907:3d91:b0:aa6:7ff9:d248 with SMTP id
 a640c23a62f3a-ab2c3c452c8mr540917566b.8.1736494629743; Thu, 09 Jan 2025
 23:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com> <677fd829b7a84_362bc129431@willemb.c.googlers.com.notmuch>
In-Reply-To: <677fd829b7a84_362bc129431@willemb.c.googlers.com.notmuch>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 10 Jan 2025 15:36:32 +0800
X-Gm-Features: AbW1kvYh6DcaW0cgKJgVFtgsup_78mHRUFkOPq--rB-NQ70GCEus3ijRcbVoJWE
Message-ID: <CAPpAL=zta_HNWcWsbL=0ymRfd_ZKx1nZ=F+Jo4kLXaUnqFnLDA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] tun: Introduce virtio-net hashing feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested this series of patches v6 with virtio-net regression tests,
everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Jan 9, 2025 at 10:07=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Akihiko Odaki wrote:
> > This series depends on: "[PATCH v2 0/3] tun: Unify vnet implementation
> > and fill full vnet header"
> > https://lore.kernel.org/r/20250109-tun-v2-0-388d7d5a287a@daynix.com
>
> As mentioned elsewhere: let's first handle that patch series and
> return to this series only when that is complete.
>



Return-Path: <netdev+bounces-180074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3009AA7F73F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8733ACF21
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F419263F2B;
	Tue,  8 Apr 2025 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hu+C8uR8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB6725F97B
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099535; cv=none; b=IDlpamD3RAU8CN7V+navdHIOMh12SjzfltaU6JePvW3457wTQ/lhCL1nDynSoCfKIq6hMG39/NE4dQL10xo9XIOqtEJ5Uo7PTAnXgJaN1l8eyYwaf5kQhDh7LvaEMWar1tCAhyOzwjEQ/xM2R9CUGP6+vU71mShqZOgAng+/k+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099535; c=relaxed/simple;
	bh=kl49m4jY94i6JweyNHtuHdyGKHC41ju8aE47HU8+Wx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUIIQ7+/nyXDt/aKicpu1O5tDfmTRMt8sfcNMtiZQYxdr2V8aYfKxJyiH5CICLI/OzMNG3Ulgah7ebprSlaj1Tn57HVRo7waYQWeKegsSSV5BEYFPPKtsCyaGdf5N0Ef7xH+hZ6zAJptr26c3jqo2/62AsjUefHTmlUIDrmsQIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hu+C8uR8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744099532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJWmN0ibsu4tQTyghfK7yZm3Bp44GAS3lqX86jPaL5U=;
	b=hu+C8uR8JGuDO57NYpHKHCLHmztHMGF+q/8jzqhtRJoixXd9OCXAqgxRLedFEPvBlGcYPe
	pu1NgKrSkc4Pt+XpbY756nrv1n3LUxPy/bEs5URXIAVdo3x0XpLjpLWhg0nIJR6PXbAPUB
	FtDeDyFn6lWx62SiodYA/EJLgLgOed0=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-OrOCIKfXMHGC-hhVGGOB7g-1; Tue, 08 Apr 2025 04:05:30 -0400
X-MC-Unique: OrOCIKfXMHGC-hhVGGOB7g-1
X-Mimecast-MFC-AGG-ID: OrOCIKfXMHGC-hhVGGOB7g_1744099529
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-227ea16b03dso75297565ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 01:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744099529; x=1744704329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJWmN0ibsu4tQTyghfK7yZm3Bp44GAS3lqX86jPaL5U=;
        b=pT0A3p2w58OrNDb0G7P8BOJq4E5Daiif89bRA1tdEJRBsmVmuZnskqHsQ5ni04TZn4
         5CbSPexTIke1Ucj1vPhY3+KDrwEGgHqJQ/3CRg8Ip5TH/kWQLqIakwk+o6c/PvXiF6A8
         QWJgR7TgKe8LLAJ6KMJmx6Nk2bmEDDZXDjMIKeFjxvprZ7C4nsZneMnEZaMYsbZjottJ
         cinw+5nH9vkyQXNPvQJGWWfWuNnndafRrocRTjwHBfcmU+81sWGE1Pjoz7EM0xGw9MZq
         X1q7/TlHkaomNjtFSlQpl1c/qtK8DH9yBcM6EfL9LblwQtoE4iK7aep8CgYPj1vMFoTi
         tYkA==
X-Forwarded-Encrypted: i=1; AJvYcCVsN0qfSpKUbBwyY12zyOQjb9rsc8XoevZ+TzApUROBGB6VQJPbDmBjLkht62YMsPNVRAEBZmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVJz0eReTY2KB1wbK9TrjbCzWS08FbWEF1ohQSZEvXBy6Hy5Al
	YuOj2Br+X8/aPb87q9RPTefgAZ2RMjQhKbEarAYPG91ELAyHZ5EgN2Ly3wmOjAtB2J0SEG+a7Eo
	qmaVscplIda3TCv1hW20NXzqyqt5OswRAT76zTQdAOJU4f2zYt2WmtzvNattXB6xSR9txdjSoz4
	I/HxCny0/J+5NJbfrwwMoidQtzL9AC
X-Gm-Gg: ASbGncstyyVFm+Pbgh1KXjz5GjXp7AlXSKNLXd6df+qYj7CCkhOdeFuappSEMa5OI69
	9EtHygIh8HASDk6iNu/AJR7w7FLX2ubCdH09KIGqnGApiJBLU7wtF21myQ2Opg846Rr2zp5NCZF
	RQkD9HAKAyKrWJ2XdT6c+2+GicxQXs
X-Received: by 2002:a17:902:ef46:b0:224:1acc:14db with SMTP id d9443c01a7336-22a8a065a92mr216812255ad.29.1744099528583;
        Tue, 08 Apr 2025 01:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxt6JXSAKwtzMhURmlwXUeHTpsebb4IGewHFs0bIb9p2YTTOJJynYQGNzCWOOkQfdVElwjfxkR47pQbpLQyHc=
X-Received: by 2002:a17:902:ef46:b0:224:1acc:14db with SMTP id
 d9443c01a7336-22a8a065a92mr216812095ad.29.1744099528326; Tue, 08 Apr 2025
 01:05:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407-airoha-hw-rx-ratelimit-v1-1-917d092d56fd@kernel.org>
In-Reply-To: <20250407-airoha-hw-rx-ratelimit-v1-1-917d092d56fd@kernel.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Tue, 8 Apr 2025 10:05:17 +0200
X-Gm-Features: ATxdqUEwnkKiKF8g-PFRZFZFOa_vl1d4t-NasxHHhEMxF0J2LDMD5D2Hq6aL9t8
Message-ID: <CAKa-r6tNa+Ltxb61g6E3h66pxW0XTDb76T6Wc2XMJCu8xuAvPg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: airoha: Add matchall filter offload support
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello Lorenzo, thanks for this patch!

On Mon, Apr 7, 2025 at 10:04=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> Introduce tc matchall filter offload support in airoha_eth driver.
> Matchall hw filter is used to implement hw rate policing via tc action
> police:
>
> $tc qdisc add dev eth0 handle ffff: ingress
> $tc filter add dev eth0 parent ffff: matchall action police \
>  rate 100mbit burst 1000k drop
>
> Curennet implementation supports just drop/accept as exceed/notexceed
> actions. Moreover, rate and burst are the only supported configuration
> parameters.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

[...]

> +
> +       if (act->police.peakrate_bytes_ps || act->police.avrate ||
> +           act->police.overhead) {
> +               NL_SET_ERR_MSG_MOD(f->common.extack,
> +                                  "peakrate/avrate/overhead not supporte=
d");
> +               return -EOPNOTSUPP;
> +       }

I think the driver should also validate the so-called "mtu policing"
parameter. E.g, configuring it in the hardware if it has non-zero
value in act->police, or alternatively reject offloading of police
rules where act->police.mtu is non-zero (like done in the hunk above).
WDYT?
--=20
davide



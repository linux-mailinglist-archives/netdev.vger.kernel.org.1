Return-Path: <netdev+bounces-169704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371F8A4552A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F723A573C
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 05:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C540267B68;
	Wed, 26 Feb 2025 05:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfAREa7N"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71B2676CD
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549569; cv=none; b=nyyEig5fSFv1diCs6U63cnjIiPcK94TiITUjCRaPSHC8IQcnh4GEWQXIQUodcxv01McGWCTfXdI1T02BaC9ECTg/6dPOD1YF4fCS8a70R7BzFWh3vVBCHLMDY8scuUvlh/bb00ZhEz6QNAKz07yYGcojVlatATPsgDzeQKLRzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549569; c=relaxed/simple;
	bh=m7gnNaSnVIQnhwXaGmMm7ApeqEyKQEEPJJKfMSkYWew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kg/J8qxl8it/u4zZ9bvedS7G5z38CREQJtilVrlzkNv44TE7WFxkisYu7W6EyKlbvpH/7NWeNSowev22G4FUzJnO2HgX5Y/gyN3EdzZePZl1QZSumYN2mFxKiDtKJLgDeXdtB716lDd/h85nZHwXblzlx5UUkgi/oKonD8Z1Bd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfAREa7N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740549566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7gnNaSnVIQnhwXaGmMm7ApeqEyKQEEPJJKfMSkYWew=;
	b=PfAREa7NjUAVOjJaRDNGG9uKIUR9M2DzXN5lsVlMkn9lOsJXJmfzrVJGDxQSeO0DTnxDvM
	3rcdE0k7jhAunAEupe23L1YvdBq5L8+2kF6n3HqQDD2BuZh6MezaoA2zIMcXeHu6SgUQFP
	qXwN6eqA8feelBQktZYdcEo72GuYBmg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-w-EK7TIbMP6fhL2vK_bglQ-1; Wed, 26 Feb 2025 00:59:25 -0500
X-MC-Unique: w-EK7TIbMP6fhL2vK_bglQ-1
X-Mimecast-MFC-AGG-ID: w-EK7TIbMP6fhL2vK_bglQ_1740549564
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc1cb0c2cbso21025568a91.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 21:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740549564; x=1741154364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7gnNaSnVIQnhwXaGmMm7ApeqEyKQEEPJJKfMSkYWew=;
        b=hdNmTPdHzxd9vDYbCcz8M3MbRq2K73e0ZJCrEEUWIYLboAm/rdbm3bfb94WSrdlKeS
         lFjmbIZPU9AuqIlUw9zc7cWQU3h5T6VmMXiZm/j1zg8+tOQzLdHR9L1NFB2miJFXjJBd
         90b1Whcaof8mRVkkBVAwPcsRvAcJDlfT7KUVHPpPKULgVn80Jxbl52C99aWFJyVaAsfg
         Oo3nJ0pHwDmQWoUV5D8Z4Oo4T30dUBJ/8AAKGTNL4pdl2/1dkSHzC+tbgNmWSvKGi5zg
         Z6MhzJKNkbG8YSLg+7Jn1SD5KoiQGtzdQgdwqK1Rp6sLo2QH0Lvhp6xfrhCUNNMl77fA
         ogqQ==
X-Gm-Message-State: AOJu0YwDZMX81zwOpPlZvouZYZi4m2U3Z4L7/eJ5FOZg7kQTgtnHDTpe
	u1n7xhKlUrQDzc4HN/cTzNz/8/Wtt0b4rbLWklzfAHML2sZeiPD1YeGnizoQ7Pbply4Uf5jF25+
	Fdgc2lZM+UfnkuAQ2ABo0EDdftyOzVjIY0YQ79xANUeeFvAtlI9HqQzQxdBi2h19biWwCFRbbEq
	HhbPbYcUVPEqzAOmBY0ls4micfbbkb
X-Gm-Gg: ASbGncvvPz2XDwITRg0/R8hrIaF6sGs/LyFGRou5SGqptt6V4Q9/fk/7vLxlccjInrB
	uSbUBxJUucTMDdHZTWxZtYsrg//rixhCPZJehNb/zzIdGmJdKnZICAQo209KS+6EQiERjuOzw+w
	==
X-Received: by 2002:a17:90b:2803:b0:2f4:4003:f3ea with SMTP id 98e67ed59e1d1-2fe692c8403mr10781890a91.33.1740549563994;
        Tue, 25 Feb 2025 21:59:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjfukw25/3dRjwBrKqTgNYjNEca8F88lv26UtFCag9qeKPB/TQL+bJT6mEpFZEyRdR+HxO/f/07hSLXK/EZbY=
X-Received: by 2002:a17:90b:2803:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-2fe692c8403mr10781849a91.33.1740549563668; Tue, 25 Feb 2025
 21:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de> <20250224152909.3911544-3-marcus.wichelmann@hetzner-cloud.de>
In-Reply-To: <20250224152909.3911544-3-marcus.wichelmann@hetzner-cloud.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 13:59:10 +0800
X-Gm-Features: AWEUYZn3sINGV0LaU89f2SQBC-EkP65HckbvJbjb0aMWfaIJ_G6VZpbaC4mxxbg
Message-ID: <CACGkMEt72ZwDQUUDPUrxiEJQLTWBQ25pP0wCO-FrZ2tZDj7itA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] net: tun: enable transfer of XDP metadata
 to skb
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:29=E2=80=AFPM Marcus Wichelmann
<marcus.wichelmann@hetzner-cloud.de> wrote:
>
> When the XDP metadata area was used, it is expected that the same
> metadata can also be accessed from TC, as can be read in the description
> of the bpf_xdp_adjust_meta helper function. In the tun driver, this was
> not yet implemented.
>
> To make this work, the skb that is being built on XDP_PASS should know
> of the current size of the metadata area. This is ensured by adding
> calls to skb_metadata_set. For the tun_xdp_one code path, an additional
> check is necessary to handle the case where the externally initialized
> xdp_buff has no metadata support (xdp->data_meta =3D=3D xdp->data + 1).
>
> More information about this feature can be found in the commit message
> of commit de8f3a83b0a0 ("bpf: add meta pointer for direct access").
>
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



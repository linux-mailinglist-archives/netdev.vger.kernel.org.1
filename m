Return-Path: <netdev+bounces-247293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2EBCF6755
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 03:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 940E0302D38B
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 02:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520D3258EC2;
	Tue,  6 Jan 2026 02:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQBgRXrS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4say1wM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5E9241103
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665843; cv=none; b=mp4CUyRzHQ0igWMB/bGSQFkTlJY7GD4hV8gMubz+R2QeFLi7iOQdkuBq5IagZl/0pd6dPAC1dOgafti8o6tVqlqZbRJkJGNWhI8bMyfofr/jk5Wrh8mT9WtyuCjxPGH9WSpSP/1SWJHQVghgjtwLNJcWR3WtpO34/yJMrsa4t5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665843; c=relaxed/simple;
	bh=1YgllTBL+1iViT1gzw0aL6fOdOScWmVAQGM9pEnlsmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jh5PNRq5eUVfdlhsA8aSsncCWwWdIN3X9yWDHexMHAP3F8CG2RqwKuDkieX2MM+JVN56PcFUqog1kD3gCVVrBskewttOyJcQONjK+n/ZPUN8unRTABJRC62SraxeyfoaCn6ybTWTsJMW0QumXCbVLgJzAF5YPLk+cPNJcSf5e64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQBgRXrS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4say1wM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767665840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppqIeQWJ2ZsPz/DX4aNgRg6SKOktRzCkfGgYgisHCjQ=;
	b=AQBgRXrSWtYEPUAZY0A/J32vTTm4yHuHba6GJbX1RwiYM2rN4NeL36TXcxN00YKt728Z1O
	JedCOicb8K+jfhTRjLvmsfsXHvbeouSKCtyUE/NI+mocyYlzocBkI5r4FCPj74b/7G7lqQ
	PQUYBMP2mqAnt7KXyqW5+fF5abWLu5k=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-LFeEuNBhPzqJ4Ds4rVxUmw-1; Mon, 05 Jan 2026 21:17:19 -0500
X-MC-Unique: LFeEuNBhPzqJ4Ds4rVxUmw-1
X-Mimecast-MFC-AGG-ID: LFeEuNBhPzqJ4Ds4rVxUmw_1767665838
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b73586b1195so45625566b.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 18:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767665838; x=1768270638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppqIeQWJ2ZsPz/DX4aNgRg6SKOktRzCkfGgYgisHCjQ=;
        b=i4say1wM97rv+YvlAEA/Fg+eWLVQZBE0xFK0XbhxrjgS893Yr5LqtvOG+800zXWbup
         ExnB6hkj85coXts5QqffJ991deGzMZoQvsDPtPz0S379kJH9rgM5qSVGq4jMp5LsOa5q
         HQ8ad7XCBIKze210AODOIm5LfZVj2Zv2tW5j2rU1NHkMKaImc/4aEXmaOhtt6Qs0jfMe
         KsEmsHYvhSmCsx2ZXvbE9zvUX4YDmPUaxSleJsjLJBhglgJHbOwX+bcEFojRT5FQFqIN
         ukaZmt7HIOS8uD4st6SB4F+zi9eGWoNBMyv/K/QvpKfo/TYmUxloZen7G80k1gmv2Ob8
         B18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767665838; x=1768270638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ppqIeQWJ2ZsPz/DX4aNgRg6SKOktRzCkfGgYgisHCjQ=;
        b=hru7c/457BdHitDa/20J6NOOTnLqcU/gDil4qOwTOw2f1ZW/mEnU8EMB1l9kdjMj97
         0vwY45OuECyglEnJb5+JBL6K+TFKoCKKB/gqoHbx0oNtffgevSsAePd6PYQpFlU2Z4ka
         7Hj/BTqBfXKpt7yy2c3ge6GTr/5tqhco5Xau3nsl760enNDJllCVizKx8Ir/oRtFXCrd
         D3pTdb1NJBlLQ6EsI5GQRAlGzKEvSTZ/sRJaGCtkDU4JC+nhNGccj5qSX9S6wuqfC4d7
         0jRlt+PVp5ifjOHQkPkhxByywSSc/y3ADi5tiEVhyNEVsrjGgEEG0SyVCcTs39eolnyP
         DNqA==
X-Forwarded-Encrypted: i=1; AJvYcCUWOC+ZUm9iYTal7h5rkc6h7orc57vwrwIF5y4dl54NjSWdZStVOfwE6OO4/ZqnwFpWfYSxwy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysGUIMggDsDRgblsoMyEZSPcN6i2rLFTvU9mXWbsmc2bVmtyCF
	GhxDfkqLk7gZd+7j7OMi4iFFpV+MIoHyVbImTZS0sRI+eBXbYhixsWJcENftKWi8HdVnfrVhtoM
	vm7UKbL2OwjheqiDVf+uTir8LxRRjaCnOzWbt4RG2AzzDOtd0kS+mWpWjqnxdl43jtcqydLejUL
	TGFmifWIm39dYPT4fiE9rqYlZQiJ8aJf7e
X-Gm-Gg: AY/fxX6Ho1Tg0pi1rdCGOZPRXRNOwKT1kqbQZuK1trB6VOFqxJrxwJ95w/PGNR/bfRT
	c0lJoaxjPKwNAZx5iGBcOumrCz8AsiWl8rh4iEV4ztpJpB36Yz9QttwgJpC1Onf0nGsv2MfA1Th
	6cby0sjpFFfNBdW+T5AMhU/Tw0EFf8AAZLBf8QijOXDloTGE2Jqf2KOUZHgsBB49buPVA=
X-Received: by 2002:a17:907:6ea8:b0:b75:7b39:90c9 with SMTP id a640c23a62f3a-b8426c0d8c5mr182759966b.51.1767665837951;
        Mon, 05 Jan 2026 18:17:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZpG50fCpayB+gpP3wEA88rQP0JbYq5H+7aAiS8pjjgd05jGSbAaPR1ublGR+/mSAXJKa8nFxkktRJ13qufE8=
X-Received: by 2002:a17:907:6ea8:b0:b75:7b39:90c9 with SMTP id
 a640c23a62f3a-b8426c0d8c5mr182758366b.51.1767665837572; Mon, 05 Jan 2026
 18:17:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767597114.git.xudu@redhat.com> <20260105175705.598c8b0c@kernel.org>
In-Reply-To: <20260105175705.598c8b0c@kernel.org>
From: Xu Du <xudu@redhat.com>
Date: Tue, 6 Jan 2026 10:17:05 +0800
X-Gm-Features: AQt7F2qI23fgsuMf0a99Sv12MnkBvt4O2xUWTuNqwoXecH1KIcNn7bGOiu2261E
Message-ID: <CAA92Kx=UXmsxL-2VUs6M7sVzZr9-Dj7Pz5NLU0st1KOGP-4b2A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/8] selftest: Extend tun/virtio coverage for
 GSO over UDP tunnel
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

I'm sorry for the trouble. I actually resent the patch before
receiving your email.
I will carefully review the maintainer-netdev documentation you
provided and ensure that I adopt better practices moving forward.
Thank you for your guidance.


On Tue, Jan 6, 2026 at 9:57=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  6 Jan 2026 09:35:13 +0800 Xu Du wrote:
> > v3 -> v4:
> >  - Rebase onto the latest net-next tree to resolve merge conflicts.
>
> I just told you not to repost in less than 24h.
> As a punishment if there's a v5 please wait until the next week
> with posting it.
>


--=20


Regards,

Xu


--

Xu Du

Quality Engineer, RHEL Network QE

Raycom, Beijing, China



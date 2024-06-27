Return-Path: <netdev+bounces-107187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FD191A3EE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 12:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4583D1C208D4
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 10:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F8513C67B;
	Thu, 27 Jun 2024 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcYKbuyF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395113C80E
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484498; cv=none; b=YMR+1K0OxypHi2vJaHkIjTFgrAWrrZ+7xuJlj/y7i3ypsV0fJwMmehSoyVSGxz76yCp0Yruz6436aeTWF9/HiW3szVA8C4fRTeOQ0Qjg8n2jh5+SnPef3rl8goKxb7txeKSh6jHPme6sS0N1wIyBjuaghPVXiRaXeo2UvjNiOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484498; c=relaxed/simple;
	bh=nkRh0VuwC5+vOYwfh7aLNn8PNVsNjydReOPPlHDdRCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVrhDGOJOldmyup3HHZpzZuorJ/lM6rEAv8y1ECCKHK8wwVCI3MHV9VIGOb0hm0SfTt8jU9sg22tztak8ESP8QSc0ICDRxrmMI+xF/b2zSadr3ul5zBe6ykOmlA5BH4JUZInPLyHbeV/JELpfWC+oHztguUoAP4z+irXGFcODV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcYKbuyF; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-701f0cb8486so179631a34.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 03:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719484496; x=1720089296; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TtogEVVAEI/WaU+dgBodJtGOd202z0mh+IHIpF2M0PQ=;
        b=CcYKbuyFrMyr4kgH/mlKaopDJeGllDoeMnnzl65UyzVbezlcTIUmLJWE/bzlkbgib2
         8TLGkfNhq9JKA9BtviGh5ivNDo+LpQ9eN8jvnRfFH0IsEvNqdBYEINttVt4LUdGrDgEM
         jCmZtbGKyyVqonSre1uwFPe1j68xREtqmJ544JvBSgOtdQn9m+ERN/vlj/+FGT3bKsMA
         qbvbldopnp74bmLOdkQS5nMYcp6U7qrMuLxFG8D8aP36VoPu5/sf6RR3vApHXErqHBem
         a6UlTM7JQH99OOOhRtOOWmusCpBlduvMxPcDyXsaRCslrJqARpNs1R6hHVxJBdLEtyu/
         qWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484496; x=1720089296;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtogEVVAEI/WaU+dgBodJtGOd202z0mh+IHIpF2M0PQ=;
        b=WwoE8Gf5v63lDovNrbUpWE5YXYj5xrlu4GWMVI28hz6vGu13e5DWxZoA+LBlZSgW+R
         mpGY4m8xxqVvYX3wD2a26pudNPGs/lFJivzVWVZ0Z+WhAL8ii+nGG9ykcYJ4PaA6QO2a
         EiHZ3EoVLuOZcHWMjCOOB8ubXzPLpP2xlh3Xvu+0iXxMZAJzVYQ3CIjGvuSTPHPIiVJn
         vQLWvUa3riyQHgsuFoN/Ff7plck25SzvXCjdObAdnJ9MNoxQUFKB/vkneDtORBmE9B+d
         TdFekXk89YZp+71dKVzp32f6z6xRTlx6LR3qno7wEz+MdlVx2EhQoEjB+CJpuCC7zmH9
         n/9w==
X-Forwarded-Encrypted: i=1; AJvYcCXLWhVGDHUgMw0kqECVW6WCT01Owlke4wO8qkS+FhgujvTt2FL5AtbXvNQ3JYFI0CJnxsmXapX0Hxo/hM91J4u0Pf/bBAYy
X-Gm-Message-State: AOJu0YynDs1g1sNFQ9urFCD3D/6sigwGNd+A3KDtmFDbGc6HgHXO0pWW
	NkRwTZYS/CTWmDEKO5rcyzp7jW2G1IiISFtBYPHhFYdWZXBtbPCYeQ1Ikcc3qxnD6Y4IkA7KtEy
	kAIud/VwBM98tP/IhkINtE4sDUis=
X-Google-Smtp-Source: AGHT+IEZQvg5wwL5DgYb40J1nQ8oC+aLOsvDz/KwbO25DrN/m7NtRnpWPTFzwiV1wm+hXuzhMtZceonIK1rysdPlGB0=
X-Received: by 2002:a05:6870:e256:b0:24f:e866:8f6b with SMTP id
 586e51a60fabf-25d735eb639mr603780fac.28.1719484495884; Thu, 27 Jun 2024
 03:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626201133.2572487-1-kuba@kernel.org>
In-Reply-To: <20240626201133.2572487-1-kuba@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 27 Jun 2024 11:34:44 +0100
Message-ID: <CAD4GDZyN5h=R+FAODf2bDY0aZPgcOXAaV3E_j8RT4w4Lb-eM7A@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp_metrics: add netlink protocol spec in YAML
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Jun 2024 at 21:11, Jakub Kicinski <kuba@kernel.org> wrote:
>
> +operations:
> +  list:
> +    -
> +      name: unspec
> +      doc: unused
> +      value: 0

Is this needed? It shows up in generated docs as:

unspec
  unused
    value: 0

The spec works with it removed.


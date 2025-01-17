Return-Path: <netdev+bounces-159295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CFBA14FCD
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5C91667D2
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E8920012A;
	Fri, 17 Jan 2025 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrYtg9ZO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72A71FF1B6
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118735; cv=none; b=AUF/b/KL41K3PZQablZtYU0sV10xOr6rARP0tgdR+l0GtD3dllej3KNPao28GX4krI8J5fvgroNNIDaz7UCKehvgirp1+4RF469U5y7jILy39ZiBuo7m0c4rpjXuJZzrQrTFk/L4x88sD9yXjspA0wSoAXIo+ozAG7lSV0qic78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118735; c=relaxed/simple;
	bh=LUZN6UQM4fLoP0BmXx1jU/m3Jz1LnC0DxZ30eVflpy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l6h2pUirl01GfP8HxL5AUGn6tg3PTjyifYA+Fx2qUScGRi2Oc7HGiH20FBvFgPxpO5iOMDlFA9i06HIIv4RDasnHknysvGO7tLRk71xD+oN+BKCPkYAvQ25NT1b/o5gQEuTFt/01wYdnD6wVi0o11GsMV0mtVrhQHODaSrEizNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrYtg9ZO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737118732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUZN6UQM4fLoP0BmXx1jU/m3Jz1LnC0DxZ30eVflpy8=;
	b=hrYtg9ZONP/2iZHgEdHrB4vl2CX+IZc3MQ1QGNacNoOZ9JZT7Cb+xCK+4jh3bEIHyxMO20
	Y4MoCk9nSCupkdVnBRHDn+YoRg3E4Sc3liHbEWwDbpMjnz3Oalwhr0njnVpCRrmKfaHV4h
	jChJ1062LmDMv2mY0bzpz9DMX0XfH6M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-eYsOnMhmOWylho_nfBaZmA-1; Fri, 17 Jan 2025 07:58:51 -0500
X-MC-Unique: eYsOnMhmOWylho_nfBaZmA-1
X-Mimecast-MFC-AGG-ID: eYsOnMhmOWylho_nfBaZmA
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ab367e406b3so182061966b.0
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 04:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118730; x=1737723530;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUZN6UQM4fLoP0BmXx1jU/m3Jz1LnC0DxZ30eVflpy8=;
        b=DYOtmrFnqcvGs0nDoceJ1qWSzPwvDQ3Jds6Aez3kCoSjADw3jnnNQINyPGzOH+PqGw
         NBa0KgCP6IbC6aNIgVky1eUCePEYQ+FmjM2xhgAUiEpUkcqY+SkCbvUFiN2dobmR+Okt
         mCzoH7m9Ws4mihO0+zy3nyY/eRIF624/qklzxiFuRv1n02V2BzTRMA8nGIErMbJqETso
         EFvGXoBgazmagqAtHPaxBMIFN0BNtmj0v9W35dotNmH5ryM2BIV/TeJSP7CEMIh7ytLK
         ObKXjRMZsAzHElDBgGQ6nwCAW6Eakzs59Zo7crNAGv4S4cf189kfBujeb97L55FYSwOz
         ydKA==
X-Forwarded-Encrypted: i=1; AJvYcCVpeSfnsd3HJ4WC7+q7HQAT+XWwNG1ZdySJLoEYj7NcP8pGGJOVmsVGduKhD6yEL7EFD0bGS7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxsJxGGez4yp4RSeeyfOJERfFHCkbtgwgvLKyWDAdmkX1Vqki0
	NXwTtjb4F/yjQ67JuRHPNW0u/PozrfnXNjAGjgFUhofsB9w4vAaJZmhHrrnuvU5RfInXQ59y0hX
	EZ3rvpRRmdsstYG0Vx9uqOQkp7uMwe/Vr3LAkE8HqHBC65H7YmBl+SA==
X-Gm-Gg: ASbGnctW3XIbgre8BCZqJcX4hXcrEz7d+Usa4ifK1Q/5/4bHObWBhuvuQ11VFhlETzo
	aMjxpsyhfXVrupYqfQ/IronfR7zEqOujTM2tqmza5um0eyuJ4yANBgW7XLl4TUKMcPpvFuqiAYW
	OXeWaaRbyYG+MgWMPSk7CRLPNp96gkQHrmMTYbTQ72sPqUHDLZzzlYP6e5AIX+k/JPGmDJjeP2t
	Dt9NIXzAl9Nzx1rAtoaziebdaNG5u63gV/msyajo5BRz8dZ5aWm6BZUBwLN1k12zuNfoGpj289j
	36FfzA==
X-Received: by 2002:a17:907:7eaa:b0:ab3:398c:c989 with SMTP id a640c23a62f3a-ab38ada1546mr328705766b.0.1737118729747;
        Fri, 17 Jan 2025 04:58:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLmD1GTGTSt675IQTRpthCfqVA1AbcSDMJl9EZkTXmZm66OBCCVwcEUSSLmPrXc8rBhS/6Cw==
X-Received: by 2002:a17:907:7eaa:b0:ab3:398c:c989 with SMTP id a640c23a62f3a-ab38ada1546mr328703366b.0.1737118729365;
        Fri, 17 Jan 2025 04:58:49 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384fceb0dsm164970866b.185.2025.01.17.04.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:58:49 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1C46D17E7877; Fri, 17 Jan 2025 13:58:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 8/8] xdp: remove xdp_alloc_skb_bulk()
In-Reply-To: <20250115151901.2063909-9-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-9-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:58:48 +0100
Message-ID: <87y0z9mwaf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> The only user was veth, which now uses napi_skb_cache_get_bulk().
> It's now preferred over a direct allocation and is exported as
> well, so remove this one.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>



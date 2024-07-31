Return-Path: <netdev+bounces-114632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D12369434A5
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 19:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A931F22B45
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AD11B3725;
	Wed, 31 Jul 2024 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ4Yh1Yq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0311B5AA;
	Wed, 31 Jul 2024 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445347; cv=none; b=Kp1JxSX5H9cEt59i54A1oD/xr9qw9rvFbhjpT6dff4sxmBnmWVh6PiMihuz0u3fRUFqF+nDqM0j7Yp2q3miaDEpXADXw0DAbXkj0vhZ6w3VUjZtyEC3r/10fJKSnOnz0pe7kxuOhWbDDvkUW4NmMTglvyfaJObzPtonDOQ4U/l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445347; c=relaxed/simple;
	bh=UcuAkjox5f+Y5LAxI8d5DF4qEAr+TdeGJw7UaZE65XY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lpi+KZBxZ2gv2nZK8hwRybaHV7oIQjApv0TUUtRCjGBajU3K29DoX3Ux79PXy2pxiv7g/wPJ/AQPyPpyM269pOXMxeNR6X+9W6+lW36wbd8wkD5uSaW/O37o+w3xH5EjCpBbcj74eyWI3z8IbXzVp9g936+h4fJVrmIYCQAciEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJ4Yh1Yq; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc5239faebso40987315ad.1;
        Wed, 31 Jul 2024 10:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722445345; x=1723050145; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jAoEvkuZG4+kzD+YT87MDOQ0qmMyoRLhyfAymy4pQbE=;
        b=AJ4Yh1Yqua5+VOZ7w9QvmfEa4mY5j3pT4n6SWYcTk1PWCRGH3dVPq5VAcvkZ4g+UVr
         xT1CuXeJrkkXDmEuf/T5Kvty83+0krJLDxQTIsfQ6tixiN7l0ItbldKoLVEnYyywcxNd
         4RMbf2+sf/2nZJex9ttm0Ahu3ztuedUQRF8kCIuskhxO6zUZ4bhdYmuJxZCK1eGSFU3U
         kwhV7w425i3zJsVsCxU+EcjzBYEJ3fICxCPe4ehtbAK9YfJ+w5uY4A7YvEtmPo1dT0tO
         fShScfAUmrlCd0PQ8t59NhqQyKtZge2wyJzvfGXsaibDLhYO/6eBFoTnrZnlFLrSQsHQ
         ClhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445345; x=1723050145;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jAoEvkuZG4+kzD+YT87MDOQ0qmMyoRLhyfAymy4pQbE=;
        b=H0oJz3tbkAIjXAu3xQcqYwCgrL70nlHt3rFOnsC6NnPszRhrxqv59RZHCvmMbiButB
         nOPnrLu+wtiUPO1PM/h5TGwguOdBdD3b65JPSaH/XKJAcpvvh6OSi16ZjsCCh3ynBEY0
         99phNWXWmHBBpjOjWos9hX+Did9B6S9Xy8cYbgP8XCFZ15yKsaAR7DQczKnajwic7CY1
         ifhN2korKgLMFTxgiwkgbXNTmtMVszwgBVH7B6XiAhVZM1H8CUMmIdcLKy63i1NwGAW+
         7JsuTPEqlhvgDgm+y8PbQuE6fK6zNS5snPY53c1X/D/Q2sCPoqL479YWf0aOvbQpRpTQ
         eqTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk7W13IoMXvELJP4TNhlSDQQyxrWLDpFq7sUU+tzqikcWN4djfMbrjrI8cz4uRvag50IBb7kCub7ndwg/YdN+JbyOW0PEgx9/ntyeh4AyrlqLoDUCwkbyQb1ZxIZZKB8SblGGE
X-Gm-Message-State: AOJu0Yw//wYI19BTL7sMpv+QaDK0yXzXcTMrlm9XNMTqhqlP+/qsrXC2
	PGw9D4DBMNE97sbcU28GSgTHmLVaocHO/GdUhT7rpNvnFAhFVj+P
X-Google-Smtp-Source: AGHT+IFFcLqqePg2bMWIlPkd2w8X8QZRPbGJVHmNSPx/OuNAr2StIs7w4ehoZagQk/owfIyCWBZT1A==
X-Received: by 2002:a17:903:32c5:b0:1f9:f906:9088 with SMTP id d9443c01a7336-1ff0481d1d2mr127728445ad.22.1722445344251;
        Wed, 31 Jul 2024 10:02:24 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7f1cb56sm122592975ad.201.2024.07.31.10.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 10:02:23 -0700 (PDT)
Message-ID: <17ae2088c08d34a17db8eeb1fa2821d686198a5b.camel@gmail.com>
Subject: Re: [RFC v11 08/14] mm: page_frag: some minor refactoring before
 adding new API
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton
	 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Wed, 31 Jul 2024 10:02:22 -0700
In-Reply-To: <e532356e-3153-4132-9d20-940bc3b84ef3@huawei.com>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
	 <20240719093338.55117-9-linyunsheng@huawei.com>
	 <dbf876b000158aed8380d6ac3a3f6e8dd40ace7b.camel@gmail.com>
	 <fdc778be-907a-49bd-bf10-086f45716181@huawei.com>
	 <CAKgT0UeQ9gwYo7qttak0UgXC9+kunO2gedm_yjtPiMk4VJp9yQ@mail.gmail.com>
	 <5a0e12c1-0e98-426a-ab4d-50de2b09f36f@huawei.com>
	 <af06fc13-ae3f-41ca-9723-af1c8d9d051d@huawei.com>
	 <ad691cb4a744cbdc7da283c5c068331801482b36.camel@gmail.com>
	 <e532356e-3153-4132-9d20-940bc3b84ef3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-31 at 20:35 +0800, Yunsheng Lin wrote:
> On 2024/7/30 23:12, Alexander H Duyck wrote:
>=20
> ...
>=20
> > >         }
> > >=20
> > >         nc->pagecnt_bias--;
> > >         nc->remaining =3D remaining - fragsz;
> > >=20
> > >         return encoded_page_address(encoded_va) +
> > >                 (page_frag_cache_page_size(encoded_va) - remaining);
> >=20
> > Parenthesis here shouldn't be needed, addition and subtractions
> > operations can happen in any order with the result coming out the same.
>=20
> I am playing safe to avoid overflow here, as I am not sure if the allocat=
or
> will give us the last page. For example, '0xfffffffffffff000 + 0x1000' wi=
ll
> have a overflow.

So what if it does though? When you subtract remaining it will
underflow and go back to the correct value shouldn't it?


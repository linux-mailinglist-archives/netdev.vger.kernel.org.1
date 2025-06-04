Return-Path: <netdev+bounces-195127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A32DACE28D
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 18:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD26C178C9E
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 16:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970121EFF93;
	Wed,  4 Jun 2025 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bj4rCBMa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C60C1EB5DB
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749056152; cv=none; b=T9QOX9UOTfCqtcti/zpa+kEMCy+GZrPg3FiU8d73km0saOCtzxCpzsuRkz0hcwdgYt6ph5A52wjKY9aqiX74T/2WE+jFQmyT464sbbVL4YFAADHfnKwQF4YxDO4XDoGtVWa4vvg/J3sL0iVH7UFtcTtdOh7Yey7bTyoCT4QN1YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749056152; c=relaxed/simple;
	bh=8Sw6ZrIatdp9zV8VYnA2N077NI0xfChsEjWe7K4eQws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l1vQm42ndwNyXz9oU8Bc4U5Qx0d36BCL/3UW7QJk8x4gr318mEepwUuh5HHm8u0OnLV/+XS5PlX7Rk8HUctP6NjtDbq8Icxz8Dv4hsls44cTm7h+EDp9lnYXH/TEOUYWREDGHbiun9X0ON3AOfVepY7/hD8XRInZ8rQgdP++kQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bj4rCBMa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749056150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Sw6ZrIatdp9zV8VYnA2N077NI0xfChsEjWe7K4eQws=;
	b=bj4rCBMahxrglJlQwhFjCbyHi7++XPXL15t3/hPuGy4AuNiDw7QafJ1izFDKdxAp3znrhD
	K4r+txjXX5xmrkBy5rWaxSeREy9tbsJY2cVoMjE3stnXnYAtPUwI0tdoz1oXK5LSew8OzE
	rOoq63oNzPfp1G57N/2ibKFz6PgAcCQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-OEPXhbg5OW2vLPNPP3xD1Q-1; Wed, 04 Jun 2025 12:55:49 -0400
X-MC-Unique: OEPXhbg5OW2vLPNPP3xD1Q-1
X-Mimecast-MFC-AGG-ID: OEPXhbg5OW2vLPNPP3xD1Q_1749056148
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ad88ede92e2so2136266b.3
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 09:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749056148; x=1749660948;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Sw6ZrIatdp9zV8VYnA2N077NI0xfChsEjWe7K4eQws=;
        b=Y+qsFihDI/9t6WQCoqW4ASTIUyqIDWOzPMb1VkQ5lBVn24Jtn4PlXe62l7ANZA4QEU
         OA6ghGOvRH1d3yX84k68Z/KPkmYnHauIBTu7ndvgYv5GRoXQiau1qYO+vWfyDwyWDVyK
         GFO1fsp+fr+7TXlKwkliMbnNOOy26YbZT0CLxNiWYf7qFKG1Q44ZAQLSt5iem1Xjy4vn
         JCb2PrSV63Xgg4am53kiLeX1kRqKrU9ooVBo92+mv1WQjmpl+Axfcpv+JC4v3Kx2M0ay
         woyugIULHlp4Uw5kVLdi5pHS5hIEZW8pBPA4rmmUDlBaBw/XazXQH+iYQIKDdDhNc1q+
         Rfjw==
X-Forwarded-Encrypted: i=1; AJvYcCXnxaX6bqcweZkROqMzja5FUxro/oTudYOaw/fJSuc5xJozJYFcukQVy81yFKOq0lRTIUrtMBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw8Dpg+WKX633sOoGLScka2nHOyvrnLzs+Rw1N3kQXR2yjCXLS
	aVc8Z85Rmrie0CX7lEYqT+VdocbWjmdJA8rvoM+Ng5AsZe9NDADlOGl7CZr6nQtP23ikBNYNzA3
	elO2sP11S//l+GuAAxcfU1cUr/XoVZkZnK/ipUDA6HnCdOuCSoYl41jtu+w==
X-Gm-Gg: ASbGncuInFM8pSu1YDTERgRrHNiS3udclIaPPoHt1lzzZFO/3UUiqA2Fb0gquaPlNNx
	CF//7lHv0E6shAFdUz5+/tAW02VqzJ7t4zx0Fcz45+IZxFvvrsO8tRYYGRIqhkvU2VAP61/oRQr
	A5y+mfy1JHcEJenm4h6p+djGLoadhVXWDCpHZ0xPE/SW37uVw5UBbtFlBGM5SiCislZewmCQ4KX
	AmMZHr35GAzaIvEbcSBbGUDxaOvyV2BopDveMjjxj/MDo0hTn80QMzNNVhHHYfa/1QhUykooyGf
	jGP65bKLhBHEURSpK4ZPil6b4SC0jlqiNvww
X-Received: by 2002:a17:907:6e9e:b0:ad2:4fb7:6cd7 with SMTP id a640c23a62f3a-addf8c99908mr343450266b.2.1749056147776;
        Wed, 04 Jun 2025 09:55:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYPG/Bjmaa00gr70znOgvLxuMNOHBq9tzeMq8cTFVTOyJdUQkjk6QowoSWQ/jATpsw4qluaQ==
X-Received: by 2002:a17:907:6e9e:b0:ad2:4fb7:6cd7 with SMTP id a640c23a62f3a-addf8c99908mr343446666b.2.1749056147365;
        Wed, 04 Jun 2025 09:55:47 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5dd043a9sm1117788866b.89.2025.06.04.09.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 09:55:46 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EA8FF1AA9162; Wed, 04 Jun 2025 18:55:45 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Subject: Re: [RFC v4 12/18] netmem: use _Generic to cover const casting for
 page_to_netmem()
In-Reply-To: <20250604025246.61616-13-byungchul@sk.com>
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-13-byungchul@sk.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Jun 2025 18:55:45 +0200
Message-ID: <87plfjv432.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Byungchul Park <byungchul@sk.com> writes:

> The current page_to_netmem() doesn't cover const casting resulting in
> trying to cast const struct page * to const netmem_ref fails.
>
> To cover the case, change page_to_netmem() to use macro and _Generic.
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>



Return-Path: <netdev+bounces-177913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1692A72DEF
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 11:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9FD07A1E8A
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33C720E6FB;
	Thu, 27 Mar 2025 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fSr5pCHD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E013C8EA
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743072092; cv=none; b=Udkmutr0+77FJoTVbEYomJixU9Dscm/lf+7TzafCMXoiNBvQSkTkWho5J379JtJ8LLjumEEBOU7iab9IT59N09sziyzNzi0xcGbIfdc/eEnfx0ABotkIGUmY+uLyTn+eBakB1dMWM435XZ6Hr+PCyYdw2ziZLulNiEQBuY++yNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743072092; c=relaxed/simple;
	bh=Iet3qpPdzxkBEABdbpC5NXSdqY79tSPMAsiZ8ZDVkeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LhYZ0GcdTsNAAjIyZT+2jibYLKYe7Q+1JAgzn/S+AmwUnb/H0kQ7a9tX2ltHhhNRc8/mu7h0Di3PdeD2iTelfCMSj9vOk0a9uQrkl6YtrY4kxLYTurPi9EU86dAvVkQeF/JzEFjp+5sb9mRwJaUUDkzCJi5tCyNjUbioHvt8N10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fSr5pCHD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743072089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iet3qpPdzxkBEABdbpC5NXSdqY79tSPMAsiZ8ZDVkeQ=;
	b=fSr5pCHD0k8ypBLj65AjFRDuzYBH9SZ52O8ihdjk9Kiq0z74Jm2tx+zuXb9d0NC0GeG7LM
	Z/eIQ993SzKaIKFdYKU+x1xd1j5b6RVkrgCcJv4CMrpYxp9jPabbEMDognjSVbbNtHFIag
	VmwY2/OR75BnmGevKxRk927Mgxx4Ozk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-aJpsYCQJNACupKDy_x-1Ag-1; Thu, 27 Mar 2025 06:41:22 -0400
X-MC-Unique: aJpsYCQJNACupKDy_x-1Ag-1
X-Mimecast-MFC-AGG-ID: aJpsYCQJNACupKDy_x-1Ag_1743072081
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac297c79dabso67584266b.0
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 03:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743072081; x=1743676881;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iet3qpPdzxkBEABdbpC5NXSdqY79tSPMAsiZ8ZDVkeQ=;
        b=A5FwguzjWiSOid/D6TUlXx6XN/mLTdHPCo1fLk9s3eWNoFbuToPEVsYbV4RFvhpif/
         xZySOj9j1FGJscEtXIjDbTXEdilw5oWQDKgumr/udukJhf4hbOXAkXP+EmqHPoVp6gnx
         uStXzLP7JMZfMtSkadQA2pcavQiCK/9CqGYxovHygyswOl7v2XwCurXKCHXEP3VFwyfe
         Wz9a3nfktzWy0PM6iK9iiWhq+wGYPQeCF1Mm/WgAV/Qv77O+O7ZsxtjXzgFWG7iuPn9l
         AE/6Pl/UlHDjiYd+odSm9eiUOINnFxRC9X+1xeqrRCMyCmtLpL7b2P+0k6AdMbXs2wNN
         jjCw==
X-Forwarded-Encrypted: i=1; AJvYcCUIWD2cypqufV9CwSkwCYaAvGt8K0x3T+QuFJFwU8n3ux1LGjDo6uzDPKXZ7O3cExeE9lWB1cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQH0YrjD9PJLFFQCTIc2yH3/OBZ5Mc7z9Pt/+9dpudQrXzD9gs
	bMbepo8tTIfcoy6JGr+VVDx/7pIhZ22+YGBCpVAB0bHoCxRjufPKU/jIs4D90QK0XL7viCHBDXj
	6jzrbCGeS83BuNgxBmeIApK5J31bu3sVop4CWIPYnqwxHHOa3AtOoWw==
X-Gm-Gg: ASbGncuGp/IQYqRwfOkFipzlLOh7FNgTww8QT4kRp1pD8v0JGOTL5XZFPyLN5b+AGZC
	p3xXcI2RPCisehsSHAzc/P7v9JaITfBRgOuMWkJzB9wNG0Qt2A6VeKriBPp3oPyGPyDGNILZMX/
	DD+BLk4TsRka4x9Tzgr74KHez1VaLy9nPIclYsLXXf/IBfY1SRWZvjgmx9/dl9DvfxJLONg0du7
	Uam1bUn0llSE7BBlpBsrimQCHpPicceywiaA25sK0417uHEtDghyV89Ed55Ap84v+IEAuykj6oy
	HhqqwVjExDsrbe5sO7dxKXlyHDT7yMcOPEzS8gsq
X-Received: by 2002:a17:907:d1b:b0:ac6:dd5c:bdfc with SMTP id a640c23a62f3a-ac6fb1491f3mr255920766b.50.1743072081178;
        Thu, 27 Mar 2025 03:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzn7n9aEz228Lpji8/Xps05eQurCOzah0ion2rj/D4w6OPRVLt3vlFZzhD4TG3XktdbJKjaQ==
X-Received: by 2002:a17:907:d1b:b0:ac6:dd5c:bdfc with SMTP id a640c23a62f3a-ac6fb1491f3mr255917366b.50.1743072080694;
        Thu, 27 Mar 2025 03:41:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8e50edsm1203699466b.52.2025.03.27.03.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 03:41:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0C6A318FCBF7; Thu, 27 Mar 2025 11:41:19 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v3 0/3] Fix late DMA unmap crash for page pool
In-Reply-To: <20250326074940.0a224403@kernel.org>
References: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
 <20250326044855.433a0ed1@kernel.org> <874izgq8yy.fsf@toke.dk>
 <20250326074940.0a224403@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 27 Mar 2025 11:41:19 +0100
Message-ID: <87semypxgw.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 26 Mar 2025 13:20:37 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > maybe rebase/repost after Linus pull net-next, in case something
>> > conflicts on the MM side=20=20
>>=20
>> As in, you want to wait until after the merge window? Sure, can do.
>
> I think we can try in this merge window, just after our first big PR
> which will hopefully come out today.

Alright, cool. That seems to have been merged this morning, so I'll
rebase and send a v4.

-Toke



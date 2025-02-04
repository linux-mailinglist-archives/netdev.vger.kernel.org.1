Return-Path: <netdev+bounces-162591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5265A274BA
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD98F1882B5B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5968E2080D2;
	Tue,  4 Feb 2025 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCd9bLiA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82354211711
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680324; cv=none; b=NG2sGSRjeoF9UygvBXCTjMENXX3oFIn7PeI1nDOuiAdAMSjPwRJGez+shb70t7RX81Y+QDs6mERnR93GiFiQjtjXmg7XOOpm+epfEomrTIVr5vReZKyKeUVuesIPlsqe+RUJyQ5H47uJJuD5un8+2z/Ptjjt6uu8x7t+xz2Ck/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680324; c=relaxed/simple;
	bh=NELlwFE23vxiG7B6LkAibKbzjXDrQIolqdpuUYFhoac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYoHCV5xaVF/iJRs3ropjKVPokrIFOxLDjDIuR39o6dqhzlZYVZhMIfrfsoAraKxgFIv+FYAU6YXB02iiaOZhaM5W6gPOJ8ETu8mxUuKpN1tGI5/Gz3iyysV+1BJE34COyDUopAcNGfPASmcTOPRYirIAPJXDsnU2STHKWngsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NCd9bLiA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738680321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0EPibgRijPfDQIoEpxgbaf5rNAipxPa2T60y01hC8j0=;
	b=NCd9bLiAj92SZeEWf7b3D5FPbdmahJC5mvju/Hk/NsoerjvieLPlyY3eQ/ysG2mM7HIjFe
	xTqOZKQqtfy0gnxi5Xq1+2IQ0l616TiBwjeBdhJc15poQ+CUzNi89UZUo9htIVzwphhf8H
	8mVJ/rWPvfRmq2qJy2AiBtfRzpTyNT0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-vqnp7wAwMe64NDxlIB1P8g-1; Tue, 04 Feb 2025 09:45:20 -0500
X-MC-Unique: vqnp7wAwMe64NDxlIB1P8g-1
X-Mimecast-MFC-AGG-ID: vqnp7wAwMe64NDxlIB1P8g
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d895f91a7dso95552236d6.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 06:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738680319; x=1739285119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EPibgRijPfDQIoEpxgbaf5rNAipxPa2T60y01hC8j0=;
        b=fnITM5BM1oAnJLjWv9U5dVkTjX6mza8D2dsTYVDicqXMrzHOaJ68cSUL+LqAJJh3DH
         rLTErRRGIJwU+7mcJNOAiPKz6x98oS8O/TjCfd9wPUm/AMH75kG3nZufz1+aVzbg/MvR
         9QRT7aafdvc2xRd/fW96fI3bqarU8G3stt30D4NVZ7srDFrMfSiLtXSSSbSmAX01mG+T
         VyZRdTlqxkec3qReVrvJYi44ic5qAjJTZ6khF0+JbbWgnCSDpVU/3Dwp9WwVZ2bHrxc2
         4Tfhnb5mZU2RtPwHRlKjOJemVVOK7tJWv+5jly/h/OEsm2AXyPItbCYeZm2i3+huARM4
         rXpg==
X-Forwarded-Encrypted: i=1; AJvYcCVZo1fO9o2lqSyMWd+dD2txExzrXFme6xLOD/5ukUlrGnnLLtRvs1MsL0+77BUcFNpdNAnHpMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPsTZJAzzPTg1EZOlTQV9ogoAf2MCP7PvWmgc0e1ztNjJakxqs
	Mxt/Q/7HU8KejzlRZ4Psl4PjaOnOx6rSihe9V5ibGkp1L84mUh0xsd9mAQgI4l/rT3ZR/vzeyHb
	cqRSDyECnoHIz0zxnF8vbvL9TF1p9onoQnFlDwS2+ngJH8cZw0khxVQ==
X-Gm-Gg: ASbGncsKynSzd0TU7KqdkFtjiIZHALI3d2dc0A2irMIcbW/fD6MRnbkqvk4uwmvzpFn
	ijXPq96qVlzPzSNYHgZdtzjhVvgu+GO63cAWDQys+8NbDo4d1223DF6HUJNX/3NWzjsTs5W0cT8
	th/jOLYlhbwZr7i8AfCtt0/bXHlNEKxobjx2v/G+YaKR7iei902Jj+8VS6Vo1EVN0WnpijLiv4E
	OW40Iyji/HGmaHNkNgPKyBkIlAs3gwwSGRcY4GL5wTE7fkwG4c+A92N39L4+41Yf67s8GTFcGIG
	ib/mfvAx
X-Received: by 2002:a0c:aa16:0:b0:6e2:4ad7:24c8 with SMTP id 6a1803df08f44-6e24ad72dbdmr266049596d6.2.1738680319595;
        Tue, 04 Feb 2025 06:45:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAC1GLjJTuMWD6nrli7aFlMPGp9HuUpHk4A60eyLzqXWw/ZK3+uk+tjlfkqnObvGwWXQIvDQ==
X-Received: by 2002:a0c:aa16:0:b0:6e2:4ad7:24c8 with SMTP id 6a1803df08f44-6e24ad72dbdmr266047856d6.2.1738680318120;
        Tue, 04 Feb 2025 06:45:18 -0800 (PST)
Received: from leonardi-redhat ([176.206.32.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254834208sm62809916d6.56.2025.02.04.06.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 06:45:17 -0800 (PST)
Date: Tue, 4 Feb 2025 15:45:14 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
Subject: Re: [PATCH net 0/2] vsock: null-ptr-deref when SO_LINGER enabled
Message-ID: <zrlts5w7rpqpco5skkvm7nltszirgoqmgcrsxxhpt2622yh4vu@jvc474fuw3sb>
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>

On Tue, Feb 04, 2025 at 01:29:51AM +0100, Michal Luczaj wrote:
>syzbot pointed out that a recent patching of a use-after-free introduced a
>null-ptr-deref. This series fixes the problem and adds a test.
>
>Fixes fcdd2242c023 ("vsock: Keep the binding until socket destruction").
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>Michal Luczaj (2):
>      vsock: Orphan socket after transport release
>      vsock/test: Add test for SO_LINGER null ptr deref
>
> net/vmw_vsock/af_vsock.c         |  3 ++-
> tools/testing/vsock/vsock_test.c | 41 ++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 43 insertions(+), 1 deletion(-)
>---
>base-commit: 0e6dc66b5c5fa186a9f96c66421af74212ebcf66
>change-id: 20250203-vsock-linger-nullderef-cbe4402ad306
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>

I ran the vsock test suite and the reproducer with and without the fix 
in place.

Thanks,
Luigi

Tested-by: Luigi Leonardi <leonardi@redhat.com>



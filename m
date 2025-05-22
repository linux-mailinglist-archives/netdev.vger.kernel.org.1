Return-Path: <netdev+bounces-192504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5684AC01F4
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 03:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA803A9ABB
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 01:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF4B51C5A;
	Thu, 22 May 2025 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hftQtei+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898C618EAB
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 01:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879007; cv=none; b=rBgfs3Cbm+KwMIN5HSgMQRWrwGlw7XlXCPRhuSOqS47sU4TQNA/qp16iQLI3OUdUizkJtEhjEdrEv4ZGmLLq8U7zSTLHJGaSSnAPhc8e1CgtzENyEzMRHlpA3MMpfh3mhf1I26tnwh8m0fSyNdsgJmZ1EpeqxXOFXihIMK0GL2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879007; c=relaxed/simple;
	bh=7iSzTdPviqOcWkq96vAkT5Q8IGZGjCWuUoYvMaw+Q0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UC7/mAKCI66vFZPKsWKm4P1kpBX5tV6jG3uwzHzQl9bfVTKMTmLmTJvtot2bbw6/rQ2I6J7dxWRvearVugiV/xkn0pTkY6JcSuK7/4jUHxMOw22HCG47jzYQPFFKyqql7wQR6eU68JNTycyptYXMOzQbCLd/W3tdKRhEPhMdGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hftQtei+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747879004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7iSzTdPviqOcWkq96vAkT5Q8IGZGjCWuUoYvMaw+Q0k=;
	b=hftQtei+r3R6wcRmxU+QdpP5RCSQZ9c0XzynZNCah5kAzKPlY1dgf+cCo6Mc4jBZ+zyw3a
	9C0d5KMflL9dGBLnYqW2Tx7ovJIKdWflt/VT8LatcLlRENNy0+hwklW0TrkuD+68ZJPvxE
	/TlOCuEhG2NBKWdOYUmacuOoKYjoSkc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-8dF1dsM2OLOmF5w3mAPKTw-1; Wed, 21 May 2025 21:56:42 -0400
X-MC-Unique: 8dF1dsM2OLOmF5w3mAPKTw-1
X-Mimecast-MFC-AGG-ID: 8dF1dsM2OLOmF5w3mAPKTw_1747879001
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-30e2bd11716so7491089a91.3
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 18:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747879001; x=1748483801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iSzTdPviqOcWkq96vAkT5Q8IGZGjCWuUoYvMaw+Q0k=;
        b=Q8IEOEmU5uiuotfMdR/psXYYijryKEdzOVy3hOOQblBrokOWa3d9d5/NCw+B4GwDXC
         sOStI6cLTP34YcXy/140LRVO+mXssyWHwqsqS//VgKt8pkIE6rxuX7VBRlDZYqjqtAg0
         Bzud5YShKNEHbxA01Ys/sJirtjy5vx1IGKZ0GE3FfOzUjhg0rT8DRTqxGPw9B3LtozQD
         QZq9Uvcky/PMnRQG3ZWtSo75dsWza1a7u/mF31cxRNksGu1CBSMPR932MMx/hcI1L6xt
         bIB7jYiuGgCX+U3t2Uv4jU6l3P447errgd6EkIukrQT3kGc/ZqB7ja9GBCp+C7s1U8Dd
         x5pw==
X-Forwarded-Encrypted: i=1; AJvYcCV/WoLlBXqs2napzipBjoFq2Yd3mGo8b8hisxJNFVDfvUPrWRHdzgwKC5k7+OInmGR/I3IHD+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1PmxLt+DoPS7mJdOa+qw1EHEMfNjqjynJmStCZegC4qARzUL0
	r4Gx0vSPMV8c42F09H7JXxt4Id6h4t/DPUg6p9QP4kBN0Jba3iBtK+PuLDl7j44kE+8/oXrd6mO
	OmrLZO6w/wf8tNWGgN10lzSGq+eVycI5ETMZLsVrmcH89+52v74DNwXRp0Loaq0jrFAylTuU4RL
	JL2vag+3NAgmirwprR+xaYItJdykm4fb7G
X-Gm-Gg: ASbGncuziMNzWkE2kbYcSNu6NRRGrVhYuK5K/QKGSsN0nT+Jc4GNfwOYx5BMDNbaLZz
	HD1MJ7H6zm6A8aGqL+T5Ndu6iMt1HVXygmhZf+V2oDbW7cZgx33AaW532Dd//I1e5iJkLsw==
X-Received: by 2002:a17:90b:1dc2:b0:2ee:693e:ed7a with SMTP id 98e67ed59e1d1-30e832357d7mr31898034a91.35.1747879000937;
        Wed, 21 May 2025 18:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+xjHR9j7Y1MuLT3juCqIfw7gluusaJrm5KctW8lhc+p1jVk5iqE7FgYDOPZA8CjL3zWh1fSepQECqqgncZH4=
X-Received: by 2002:a17:90b:1dc2:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-30e832357d7mr31898002a91.35.1747879000576; Wed, 21 May 2025
 18:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521092236.661410-1-lvivier@redhat.com> <20250521092236.661410-3-lvivier@redhat.com>
In-Reply-To: <20250521092236.661410-3-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 22 May 2025 09:56:29 +0800
X-Gm-Features: AX0GCFvVy4NeycSeo3DY5ADF1z6T0vmZbNBP-oJLc1oMWpnWxkEApN9hMXdB-50
Message-ID: <CACGkMEvknJzUf84GFLF2c9KGZ7r+6rNCYO4jyW4eb3+60oBPFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virtio_net: Cleanup '2+MAX_SKB_FRAGS'
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 5:22=E2=80=AFPM Laurent Vivier <lvivier@redhat.com>=
 wrote:
>
> Improve consistency by using everywhere it is needed
> 'MAX_SKB_FRAGS + 2' rather than '2+MAX_SKB_FRAGS' or
> '2 + MAX_SKB_FRAGS'.
>
> No functional change.
>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



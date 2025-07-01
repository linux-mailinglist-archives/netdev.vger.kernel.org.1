Return-Path: <netdev+bounces-202734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97335AEEC67
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 04:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5627D3AEB99
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 02:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374591C07D9;
	Tue,  1 Jul 2025 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRWedzt9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8B1C3C1F
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336435; cv=none; b=E+mI2CVid9PNtd2uPPlG03lzEOeyhc0ryEeCEOCf1lAlQNq6rIC/Dybdp4Z7QZH38OvuxEp6QxZBmPRO7YI2WW3SLSckKNdYm7A5gr73VFhg/IrPMxZraAZ39EJhNVRl4klXBO4BahSUlOC79vx02Lv7A4J9gZw61ZS8wD2cGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336435; c=relaxed/simple;
	bh=WRkNpi1+u755d+RTOomAEvo4QL0439YSaBkjP0jh4c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GabU73YeTvlQyUHogEp/Jg6FZ0NAHIqLBGn2y/UPT8eERhLqSXR4n1otzgRQxR3yxDO4xt2rYcCXTGZPjEqOOID33rOQucqha9bByx4vHbk0jy/k+FEZ9uIf0fdx+TadZjRdXqWtDtqO3ww6Atn1ntiJb7U/w6v4JdAU9g14Rf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRWedzt9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751336431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRkNpi1+u755d+RTOomAEvo4QL0439YSaBkjP0jh4c0=;
	b=SRWedzt9gehIEouxCaxiQeByhPPiP45tPrAQcJ+wjqEfWU4t8qiUbtzq7TrMdfN1mStl9q
	fQbmB1mGbTmdvFiv3OTQcTLfo8kj8NeNiM4jcg9c9Jc7fJnU3LzSJzavcLWLsig5soB7TH
	WYpqmqoakvpowM10fG8YF75qJpLOuBg=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-r40i-sL9M_qbFxeQ-HBnAA-1; Mon, 30 Jun 2025 22:20:21 -0400
X-MC-Unique: r40i-sL9M_qbFxeQ-HBnAA-1
X-Mimecast-MFC-AGG-ID: r40i-sL9M_qbFxeQ-HBnAA_1751336421
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-87ecd699753so38687241.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 19:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751336421; x=1751941221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRkNpi1+u755d+RTOomAEvo4QL0439YSaBkjP0jh4c0=;
        b=mshL/ydVp4DGsnlkkgA4drBf9UQTA3MGg36fyDM6L+wif6gSaM6wHZpcSb3W3C9B27
         ZnAQvY3huUpv4tvW6QOnr1eBj6BaX79ybgiW1KhYIJmi+ZJd6eTmMBeurm/5EK+Dld0K
         xe358Uy7zQlDAeSmr/+ROjoYk9ItydT4hePHPC1KguMp2Q9RSrL1gYL3ShZuLF/Tx0jw
         geaFslY79qGgBJsY8i/pmw6w0uCDYtbi9+M6BeWEsHK2IaY9V8SvhzTDvD3NeLeeFlU8
         EGfFJoscwEz2mIt6Ib+rrHWcsle5WOWQm5frhCXjWowfwjPF/4vWwB1R/sFJ/zjpLsY6
         03IA==
X-Gm-Message-State: AOJu0YyRYTMqMBCe/whDiQsKOgslPVH15PEJ7pHwXKTEm+x+VWwkm5G4
	ert8bezlDImfNZdWUP+YrWddKkvZXkrDjUZV+5O2X2s6+IlM6/cW8k6BiL64ZOPru8mog3wTj4n
	dXRJ9unsV1stIjJLwlDBzngP0BPtLTxACtgquEpJmcNTiTWnnYT9u7dqtSoSDdLEdqLUjpDXVEh
	/6G7GdwnjoOHDJkYGQr/touSMF7BJxZ9ei
X-Gm-Gg: ASbGnctS5OfakO6yw59uE9DoPidNsk7YmA1R/UXPBIJilaCn+4wb486jUAQHmO3kXL/
	QG3M+Ncm2XJ9lXaFi8J3W4gr9PwHLnNLWokGxvxHHsov3bLoeksEuuh25oHzGzgNUulUtrKsHmO
	y+
X-Received: by 2002:a05:6102:2c05:b0:4e5:abd3:626e with SMTP id ada2fe7eead31-4ee4f9e6313mr10405275137.24.1751336421322;
        Mon, 30 Jun 2025 19:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcgqA4GY5HeNzIXNDy3m2/0QUTCkMPWazV2oM4SlXLsY44Iog87PMmTUv3dD5hme1ectzbCFF6OxMHcOYRnvk=
X-Received: by 2002:a05:6102:2c05:b0:4e5:abd3:626e with SMTP id
 ada2fe7eead31-4ee4f9e6313mr10405270137.24.1751336420966; Mon, 30 Jun 2025
 19:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630144212.48471-1-minhquangbui99@gmail.com> <20250630144212.48471-4-minhquangbui99@gmail.com>
In-Reply-To: <20250630144212.48471-4-minhquangbui99@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Jul 2025 10:20:08 +0800
X-Gm-Features: Ac12FXzTGbPc8d1stXK-UyjLYhm6Mh_lf0LlWolyX6yBYCOFZ2SRlUxOM8CEHbs
Message-ID: <CACGkMEt9za5v2tWDBOs_1d8nCk20CC4XyadszKB7ezKRz=sBmg@mail.gmail.com>
Subject: Re: [PATCH net v2 3/3] virtio-net: use the check_mergeable_len helper
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 10:43=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> Replace the current repeated code to check received length in mergeable
> mode with the new check_mergeable_len helper.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



Return-Path: <netdev+bounces-198884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F2AADE242
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 06:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CFC179A4B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EAD1AA1F4;
	Wed, 18 Jun 2025 04:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYJjWd7M"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAAA23A9
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750220178; cv=none; b=a5FneNp3MBR07whl16BXq1Gx7bS6AUt+/iIzX2da+BNVe8rqtuGlEXjTh3Mej+Gnnc+i4JtqTm9olHqia3eXJeMKA2kYBr9WQdWgoWZCtaxVdLP0gWUY5038XX/N+QM/3LcIiB+sdIQ4VkzZeOAacfjU6tT6ZT+dhUVLfUds9hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750220178; c=relaxed/simple;
	bh=NvMAnuj+b/L8C+EVKKBkjDbyiLL3TBm5VXI9MPWY8xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=phlp6vhjY6vE3OtipHdwIUzQeBYbo8CLO/Us8stWYJq5BdkmP8aI5OK+TAECWjX4NgRV94Xz0u9n2+kTdiHmtTR1rfKPnw11neRQCldBlwZV70tflwGtmmG5pGuHoGWC252OhR/+rLiKVbR/9JaUTJdcfZ3Y/f4rlMXzlLKIj74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYJjWd7M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750220175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPhl54UBp/1tMXuMq1w90kfqiaAqvsYWfOq8BDY5+ig=;
	b=MYJjWd7Mqq8tq1IbZ1galFlLvB6n8cONqijts61QHVVqqrXciOZDwM4nrRGoOfCbULd5KD
	3BMBnFABfxxpaAeFG1TQE/4H9pya0lr55wEZ7bVLO4LpV0C3gVHHg84MBfIzLFcOWlNTE7
	dqi94eyJSdVwwc6UhQCbJpXylO+wAVc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-YmCXellaPj6trxXBTpoY7g-1; Wed, 18 Jun 2025 00:16:13 -0400
X-MC-Unique: YmCXellaPj6trxXBTpoY7g-1
X-Mimecast-MFC-AGG-ID: YmCXellaPj6trxXBTpoY7g_1750220172
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b115fb801bcso7090823a12.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750220172; x=1750824972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPhl54UBp/1tMXuMq1w90kfqiaAqvsYWfOq8BDY5+ig=;
        b=wn5cS5hKN6tojkqblE6qMLtdCBvblZAftK3OItg9RQaF3KhV3IDRaDGoFU+HnRoWvR
         LF0z4+vqtHhf84L/j1Tpj1JYpI4y/BC8PRl1Mzn7rvoE3OzMNiAJwzgj0SQ4V/VK6Ksu
         tmwTQRSmUyVBEq+hdbWV06u5/rHn/dE83QK1ioU4hrG/8rnsRLZSaAgi6uXoZDkNG3C1
         gjBxxqZ0l2Q372viXLyeRqpGr2tRPs2OZFm/2Y432/dKNVHWav0Y84BwTxUNdwTH2OzI
         BZNT5QJg39h8UfIbkk117m8i73uE7I61ZUTFuy7V7R3xklVdN6fy/UBlk36/2WB6nPR/
         bntg==
X-Gm-Message-State: AOJu0YxXRH/k8JVQCl0TGcMWfkJGlDTfcD7tZRqf0NBGjZFUNc545Uoj
	t6vBjWyzL8IehwbpJLA1Cy8LQ09HJC4qtVLfpoJWMN4brvxwwYmBkH2dtiQgGOSJ3aLEI05u//e
	7UwvC9uI6Cd8oGsFLqJTLKBmXT0W0uLy2tIJu3tpfd11ZK0vlCvGaAAMqTPVvKHMpWshddf0fs7
	06AeYAcaBe6dsq0EClh7LL46sf61wiqJAW
X-Gm-Gg: ASbGnctsU74VxbCUvSazURfikVZ4saZYjyhoFDWDdUcOvKR8xmjXthRt0TvkMeBzHJy
	VR3raEkIM70aYk3XibXbkdPrcMDdpn5WI4IodBDKJsVs1fNTMSEh/v93FT3JaxsxFuJE/j0lL/h
	qOdA==
X-Received: by 2002:a17:90b:5285:b0:311:ff18:b83e with SMTP id 98e67ed59e1d1-313f1c0b04fmr25672909a91.9.1750220171858;
        Tue, 17 Jun 2025 21:16:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZihOywbneNsVZkzU78elM4cXm9nLxLRC0P6UnRLZRvr84QRkCdaHTs5itJcoorkPD78b4HTTQvXPrMlytxJY=
X-Received: by 2002:a17:90b:5285:b0:311:ff18:b83e with SMTP id
 98e67ed59e1d1-313f1c0b04fmr25672880a91.9.1750220171416; Tue, 17 Jun 2025
 21:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750176076.git.pabeni@redhat.com> <1e9154a001fda22f358ebc0cbf4edaf9e05d9417.1750176076.git.pabeni@redhat.com>
In-Reply-To: <1e9154a001fda22f358ebc0cbf4edaf9e05d9417.1750176076.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Jun 2025 12:15:59 +0800
X-Gm-Features: AX0GCFsBkZijufV12sviuvs_FaGazDodsKMKE-0c9w-4yJjwYNVcueInPZJxsWs
Message-ID: <CACGkMEsM4R1tt0pH18KmhR1OOz1SFhxKpFWd2q-cTZtzQKwMhw@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 8/8] vhost/net: enable gso over UDP tunnel support.
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 12:13=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> Vhost net need to know the exact virtio net hdr size to be able
> to copy such header correctly. Teach it about the newly defined
> UDP tunnel-related option and update the hdr size computation
> accordingly.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
>   - rebased

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



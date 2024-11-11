Return-Path: <netdev+bounces-143621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCBB9C361D
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241EF1F231AD
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 01:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C6D5588F;
	Mon, 11 Nov 2024 01:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wd3KrFZA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E01F94A
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288709; cv=none; b=I15CqzyeXIFGjqpllOJAdpBHqaReTSmPmyTvRSOuVxBRSBhTkCyfj7Fzp6dmBlUCYu2pip0nMRHYRnndrxm2Y/wfYDBefwho4m7K9NycCi/aFcznWE5kyqExhVKXnjNXqx7+88IhVEK3EFyuwPbV2tjoxHRw9iB1UjBUbese6w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288709; c=relaxed/simple;
	bh=8RjtmP7zVZrflkjuPVjKxGfngY1SABY3DdXeQA3BEpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+putoK8iF081VHHcDsrFkbrG9JnrNl7QtVxiTbackRDRXpFwu44Uj0Ro/74PPCjel550RrM4QJOjcEUgk+mn1Krl3j/eKO0lk8DtWy7KKtVG1q/GCdNw5zvuA0eWfS86Jbp0wGQ0jQQC+7ta3QhFunk2jFG8L4hS/WUNNSoIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wd3KrFZA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731288706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8RjtmP7zVZrflkjuPVjKxGfngY1SABY3DdXeQA3BEpE=;
	b=Wd3KrFZA17kblj0bGv2Wrp1H7WPrw5nHjzOof1I8BnAyeIk4XOLORbE/yTALUh/o7ZscKP
	D1ShCd4BoogWp1qsQzon9QrllsSaW/MCSJwjX2c01vqy+El6lNDTJ6kv/PRqMZUeDDfX6K
	2lO0PM3zPJxgAkojSFviBzJTixDkicA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-sC4csUdLPA-5okSV0dTB3Q-1; Sun, 10 Nov 2024 20:31:45 -0500
X-MC-Unique: sC4csUdLPA-5okSV0dTB3Q-1
X-Mimecast-MFC-AGG-ID: sC4csUdLPA-5okSV0dTB3Q
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e9b5535940so1794080a91.1
        for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 17:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731288704; x=1731893504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RjtmP7zVZrflkjuPVjKxGfngY1SABY3DdXeQA3BEpE=;
        b=KB2cnwRKUNxnrh8zpwmRxv34VFdjw5QokhiQ601sx34nHfNAGcUCltDdjntiY+3grc
         +v6oUib5pEcPmD82PVliFbFthEywUj8t5z7NJPB52YZICEHomg4UaXeNUuIWO0lWp2uV
         1JF/ig5tg8Z0CFGdNxdGhZREI9Ximwbb8eQKtdGFeaO3lKDtglxh81WCH2M1v1o/GyFU
         W+ARfKs8EvvjLJnPQR8XIURWEHstZhKH09/2OTqkz4emVr9cn8/uN4RDLjMBJ2ld+m0l
         u4qbfTaKMjhud9y0pPYEQh4ndNVgwOsOolsUUCNb9rVmUoe08XRvcG3GO26EgimNGpqa
         TCQg==
X-Gm-Message-State: AOJu0YznLVvQ8iK0Nj90KUkob9xG/YPJGJlZnqpduikaNiGBpE7mzG0q
	esnVSp2e13xtkuSVqSF5dpzVs/Gk5K4pydWsJ9jnmOGwmJYVyKyc0L63n+IVTxweSH2+t1cS4tE
	re8ZrX0TWbYpnYjkyiH0J96JdY1VafSoDr6GJSW+MQ12bKTEcrgf3sRq5ZHf77XsfPa7sOK+D5p
	fewZHT36c0qLon1TMshuMYFTPPsheO
X-Received: by 2002:a17:90b:4b88:b0:2e0:f035:8027 with SMTP id 98e67ed59e1d1-2e9b1ec3ad9mr15212837a91.2.1731288704296;
        Sun, 10 Nov 2024 17:31:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ45A0a7VJ+rtoKCuZ3Xjxf3vbO+kpA+QpYKgLnefQ2pNNeyLQuJUHLmrx4bENZUF5kjBfviP3ZWmPxNU8h7c=
X-Received: by 2002:a17:90b:4b88:b0:2e0:f035:8027 with SMTP id
 98e67ed59e1d1-2e9b1ec3ad9mr15212803a91.2.1731288703869; Sun, 10 Nov 2024
 17:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com> <20241107085504.63131-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241107085504.63131-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:31:32 +0800
Message-ID: <CACGkMEtj=D7OPL8hAxJumhVL8AwLS51tm42t0qCxzGhMa+psMg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/13] virtio_ring: split: record extras for
 indirect buffers
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 4:55=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> The subsequent commit needs to know whether every indirect buffer is
> premapped or not. So we need to introduce an extra struct for every
> indirect buffer to record this info.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



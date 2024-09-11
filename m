Return-Path: <netdev+bounces-127218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26373974928
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 06:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2E521F25EBE
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 04:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AF14C62E;
	Wed, 11 Sep 2024 04:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAQeC71X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4022066
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 04:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726029253; cv=none; b=clegVdG/0VYKXub0B9nfd3eMjBPNUImcN4F3tmpuBcLRasdILOBgMGS4vEbJwoIoJuig7tq5vRAPtO//P6bdeEiGf7AepRhBStR4l7W8y0d7gtB7e2hH8iXDSf17nohgFVhzcw7nStPWNqPBsz5GoKg07yjl0H5QEpkzdYEP9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726029253; c=relaxed/simple;
	bh=/OZicAYz176JQr9OQFJz/BIIOhUeJ4QDnFOvAXc7I8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8xeS9HiB90ABPjQ+qKiUv7huwZgm5J/JSJNS8RBQSxsY4GRVAy7gygXL+LH6P7WbO49xUb5k7vmL4V+ZOm+CpvsaM3yeeNtyzED+B9Uvnoxy3zmaF4Lx/wYsEmDafhc731Ulvt3hWj6UKmZWAo+p1Zdshu2TBA/Hy2++pw3nLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KAQeC71X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726029250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OZicAYz176JQr9OQFJz/BIIOhUeJ4QDnFOvAXc7I8g=;
	b=KAQeC71XnSCFvL/j75J1UracQTYHK1rlqWh9InUWqIIhffgQgssrJwf0kvOCRrqaxKjQy2
	CXVzylT6cWtFLDJCAzCXjZLDpROd4Dw+7KX5RaHsgFddH90zqAXBmb9ja3+rKSFTahIY4y
	8b2Trx57fZFf1F2vZhK4VH3BMcy4jnE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-elNhYHAvPpGe_2N927gF_w-1; Wed, 11 Sep 2024 00:34:09 -0400
X-MC-Unique: elNhYHAvPpGe_2N927gF_w-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d882c11ce4so6522554a91.2
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 21:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726029248; x=1726634048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OZicAYz176JQr9OQFJz/BIIOhUeJ4QDnFOvAXc7I8g=;
        b=L3upfnXGp1SM+8WoX3XZzNsg9PeByegvC7RTq87ka4NT+wBBNgRW2n+Do1yNXPp7iB
         rd0zO9Y4W6Yle1BYOQsDlYiBv6CXqXEtjSjNLp7WAX+megEZEysIr9P5jr9L/lQhl0CN
         9s4tuX4XlDgeS5Q1HHhLERTlPXJbiu5k/yK2xqeK9LYYibNgqLn4dp6Q52fsS4R0fxt+
         wxK+N8j+Jlw3mdfn8IMnNNTSxJ1Jq7qUN0AXTE7uT5Uo7t2J+TscBBlOxUw4gTFtpiYA
         GatOnx/PUQPhdPNlQpcMEN8N3sIRksFP7aRCgS770aDqaAc6D4SulnzU5Ek7eeU0Tx1a
         3oYA==
X-Gm-Message-State: AOJu0Ywvp3HtZ82k12zo9KV9b9beyhu2T6eMg6kMF1TAWUIPePMCkk9h
	YjBK4jxC82y26gffI/Lx1zPi1eI5PDrFoOyxGmzF094MZycX8KNCNGzqFwSih3PNR8kf1ZpLHAG
	0MyQauhqElpWv8tTsyjBe9z/JMXicDoDWaAtW3c74kj6nbVbXd4rZCqVbKpmZD3v/Eb5Zy+z8IA
	UwhukwTFPH5G/0vbs36wFtVAKtMwkh
X-Received: by 2002:a17:90a:bc9:b0:2d3:ba42:775c with SMTP id 98e67ed59e1d1-2dad4de1446mr20491872a91.1.1726029247892;
        Tue, 10 Sep 2024 21:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK4dNpS061+8UBWJdfO4IW4pNByqIXVWRmPrQOcYihie9tMK3d9z/PWSXQpp8WDx1xdXMfMmMHr5f0E7S37Jk=
X-Received: by 2002:a17:90a:bc9:b0:2d3:ba42:775c with SMTP id
 98e67ed59e1d1-2dad4de1446mr20491852a91.1.1726029247513; Tue, 10 Sep 2024
 21:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820073330.9161-1-xuanzhuo@linux.alibaba.com> <20240820073330.9161-14-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240820073330.9161-14-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 Sep 2024 12:33:56 +0800
Message-ID: <CACGkMEs44Xa2ZUbAr9Db2a1M6Q_EO=DeRnDdiTNg368mGu_zdg@mail.gmail.com>
Subject: Re: [PATCH net-next 13/13] virtio_net: xdp_features add NETDEV_XDP_ACT_XSK_ZEROCOPY
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:33=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, we supported AF_XDP(xsk). Add NETDEV_XDP_ACT_XSK_ZEROCOPY to

Should be "support".

> xdp_features.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Other than this.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



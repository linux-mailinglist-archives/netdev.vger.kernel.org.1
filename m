Return-Path: <netdev+bounces-109771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55A2929E0B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124BF1C21C0B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2D315BA;
	Mon,  8 Jul 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QQG0abAP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0409DA29
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426228; cv=none; b=EiwX373MEE8g6ixocpZtgdBqUb6D84AD2YRPU6DRYsrOIIfJi7guX7DkOBaW/Fbu/+3toxVV7e6GD8T9OX3E4Hsu7UgePoqcoI7oJlRZFHZx/snH+Yw4UfgJe/LYhbJSbJ4Nl11phQHTPf4e7RzzdKcco9gtYRuI2NQ+eqmZe5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426228; c=relaxed/simple;
	bh=yz3AnmlzZclWxsGCy4pIv9K/D6Ob1yWFKZV/+u2QXhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExQb5loqW3/OQqF5JUlcxkYa/sQZ071tH8ICX3wWDbcLDdMAAymDNDnyVhs4fAJo6J5LjTCLdt0hU6mx5GlYcERbx5zjyM4qAq7R5PuBdLtDJO5erv8PZVW3zKkYh8G74aHQcnhWA/0NO8KPawkkOU2ivzmMbpEi52XV90Uzcuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQG0abAP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720426226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yz3AnmlzZclWxsGCy4pIv9K/D6Ob1yWFKZV/+u2QXhk=;
	b=QQG0abAP1kheL195q/iBNr5dbuS62ghWKsYoadI9r50Yuo/gtEjzXcNnbrYL1fdkX36vfb
	1r0rW+sKZZJ1Dmc/QA7rnZwFxMNJ2ov6TnetYIbADQ72u0ecPwpp8NOsQ1h23eZsxVI+5y
	oi54qe1NwxnkNhEBpOCSUSeEk1Qrh40=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-Lo5XKb4pM1G1KY2I1QeRlg-1; Mon, 08 Jul 2024 04:10:24 -0400
X-MC-Unique: Lo5XKb4pM1G1KY2I1QeRlg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c9ad83844fso3194878a91.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 01:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720426223; x=1721031023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yz3AnmlzZclWxsGCy4pIv9K/D6Ob1yWFKZV/+u2QXhk=;
        b=gw4u4oEBs5eWq1OzIsz5lW5ZpADbRkmj6I0IBPApADY+DKa7nRXU/ICtOtxcy+Eods
         JXbutII0zqtWCYmFaXg+f5FRdiQ1MtsngYy9P8Yh+lucpQmBUjYoCFJ9QpnGKIrRmXpe
         8mMB9Hfnpl911OfUSj1Awz55I+6e8v5rxyu49POvcP59pdHcewG2gB1ou3d27PlSWIGM
         B3oUFYkDyWPsGaQ8CpDYAf5LZFgFUq8q4U4ZNxcvskwC00kgnI9G8oF15DnCbax6LuwJ
         9dCskLKfKv8AqrU90Q99ctvQiM/3JdFmB7xa69R+SwEMZypyInNPHZt4DLn1qxTlsyb2
         DYAA==
X-Gm-Message-State: AOJu0YxVh08dL8OV2oENEKikTHKilV97d4P6Bk8lCE4tZt70UhCbpvpi
	zcij8Kx1VWqdaecrUL2S0UbjNUNG4aHGVYTYNG6t8FsMl+RRGbHr2DTlynmPloUA23EaUNAY0xG
	uRHU42f0xg3mbEQ+/wiuMGvye8RILPArWYo6kECToiOeXdf/YFUe/mHvudDnLdUTfcWzgWWgvi7
	MrrITz+76bBtla+t2EH0SI8FF6lUJh
X-Received: by 2002:a17:90b:23d6:b0:2c9:a151:490e with SMTP id 98e67ed59e1d1-2c9a15153dbmr8352851a91.18.1720426223152;
        Mon, 08 Jul 2024 01:10:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj3jzysrr8JPHGiFGX+E23ysYUxoH7WdqJzqCtsY1jBZGjVa2BZrehl9IuU0V6yjZwl3A3Ox61aacTd6khZXQ=
X-Received: by 2002:a17:90b:23d6:b0:2c9:a151:490e with SMTP id
 98e67ed59e1d1-2c9a15153dbmr8352833a91.18.1720426222760; Mon, 08 Jul 2024
 01:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com> <20240705073734.93905-11-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240705073734.93905-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 16:10:11 +0800
Message-ID: <CACGkMEsorUJC0fN=QWbb=K+_ShJcyqSGYRPV=omSJRe=SQfU5A@mail.gmail.com>
Subject: Re: [PATCH net-next v7 10/10] virtio_net: xsk: rx: support recv merge mode
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

On Fri, Jul 5, 2024 at 3:37=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> Support AF-XDP for merge mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



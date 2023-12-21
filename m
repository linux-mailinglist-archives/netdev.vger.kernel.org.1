Return-Path: <netdev+bounces-59785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E2681C057
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232221F26FF1
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059FF7765F;
	Thu, 21 Dec 2023 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NYnt3IW5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08557764E
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3fde109f2so11535ad.1
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 13:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703194807; x=1703799607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB0ZY+nBxKTPkORzoQ6ZJO9teY19uCFlT+Q333mOXAc=;
        b=NYnt3IW5hHRkfD8SaAK3BwwkgI2mbklrFuDHqiUyR9iTBK47S4nfVjo9F4hMiaBeZ3
         oM80PLh6pvkTDe/KqWfm/H+XpjaS9DhVJx2WGQ70uHfIqlG7Y4N+4wEhpr4rPpRm5Twj
         wZTMagxZ+YtIwGQXqXFMH3HP0AY97SHFYWsQUi7nISit4c/HXnwZV7LmM4G80Sg6BIQi
         zpNHCuk6+p4Xa7GBxNOJqVADfNx5Z6TGi4Nk+U5JzDtU2Xt20juzaSBnxCUsQLpHB5en
         EomjeeWV7tQ5hSDqdi+8k5BoXWXFJ4R1E7U7dsPK2XB/l9MWA6nmQrRCyCZpV4nEWyAc
         Uweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703194807; x=1703799607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UB0ZY+nBxKTPkORzoQ6ZJO9teY19uCFlT+Q333mOXAc=;
        b=B5kH0pRRjZQDFMjWRuZrodK+ybZKbq12Jf7kJpiAg9MWvCWcBzKrKP5dZBE1PAp7DW
         Md+t/Eiy6Tmq85SAYtKVmcFC9i7dgxaDn6BD+R7HKtU9zv8+JLHqCGmXfdtCltP5+MRm
         1lEAnwtS90RBaCrU8lpMEMmBQZpTT1WQCoV6shrrx1oyDD3n8Bi06Q1guEGnvNeZL0T2
         FibndDUpSw5okddU9frD4f+N6UiiQdHe3HEYZiNijUIKLghKoxkCJVkZ7btfmtGkEcIQ
         mLb5/oDoiWcas2GMulhGwtI6KpAyYevSMJuhUsPWr+ytJvbKpvUDgxSMYyLKPCL5GUWs
         zgJA==
X-Gm-Message-State: AOJu0YzXETBCJZf6mpZXbGZXjA1mZyuXMJRjcTjQAe4Glac5D9lhZbl7
	DH1PQTgJv7Zdng9zeufspkppvg4EwWpr3Ycjuvwd2wdGMiAc
X-Google-Smtp-Source: AGHT+IF80tZmsHPhE6wyckD/RAEBLEIynH1gwHeElMtN5TBkrj7syIFvBO/ajk9EvH4/NsPHbKo1N7hcl3mhL8zriwA=
X-Received: by 2002:a17:902:e84b:b0:1d3:a238:77ad with SMTP id
 t11-20020a170902e84b00b001d3a23877admr40283plg.18.1703194806799; Thu, 21 Dec
 2023 13:40:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220214505.2303297-1-almasrymina@google.com> <20231220214505.2303297-2-almasrymina@google.com>
In-Reply-To: <20231220214505.2303297-2-almasrymina@google.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 21 Dec 2023 13:39:55 -0800
Message-ID: <CALvZod6bwWBuRZ8BCjUiyec2wR6hBSwrdcEzEM6d+9UdmCQBGA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] vsock/virtio: use skb_frag_*() helpers
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	David Howells <dhowells@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:45=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> Minor fix for virtio: code wanting to access the fields inside an skb
> frag should use the skb_frag_*() helpers, instead of accessing the
> fields directly. This allows for extensions where the underlying
> memory is not a page.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>


Return-Path: <netdev+bounces-86406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4F989EA64
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA3B1C22334
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 06:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401E029CE3;
	Wed, 10 Apr 2024 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8FG5FY8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A882030A
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729374; cv=none; b=nsfUQMxMrvEaUP4yUSJbL3G6QN3DC+Z7uPGho9I6510vPDyHtyHvEu/KYXww8wvQkalM7F7+x7asVbpXYIDshrtY4DjhDIy6jzYtkHleW4rqnB3n3RYaYlUQPUc0K1aIady2W9r5dhbMtmKkuznFlqrb3EGiS5sw6DPIMBOYMHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729374; c=relaxed/simple;
	bh=TgEnH+juOE9q3+l0Iy/5OigfN5ANC+3jzENCinlc60M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hl0reU6ey5zWKA3gKTFfu2haOjY7vS6uv3tFWpbFCuCxyTzYC4GdwYVZIg8Ay4DQ89uSgvtk4p2oGvl1GLWcngvZgbXm4cqsKi9Jh/ESyaWfsa2c0iv4Jn8aLDlXpOF/M/G7X2N589yYQtklMKB//xI4iJVUVOZjUqWB9wkU0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8FG5FY8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712729371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgEnH+juOE9q3+l0Iy/5OigfN5ANC+3jzENCinlc60M=;
	b=J8FG5FY89TQS2x3QZOfSECo2JtHO3uzAk81JzlxR/1GRTfDbIlXXMU4jOZxdE9pIefsU+5
	sAmC0qiHq06XPdUPReKx+hA5RgQtXieHsSKiVrn86Y0tVkFiYYws4dwBswmZkp7StwU+Yq
	8KUQ59t/Zri3Aovq06NlElxMVih+RQU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-WrUAM9ajOj-p0QtDSqZlmw-1; Wed, 10 Apr 2024 02:09:29 -0400
X-MC-Unique: WrUAM9ajOj-p0QtDSqZlmw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ecfa420e9cso3022241b3a.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 23:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712729368; x=1713334168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgEnH+juOE9q3+l0Iy/5OigfN5ANC+3jzENCinlc60M=;
        b=vlayGk44xxomnLWyctFlWqFc34O6qfD0yG07c5+BFboV1kcxHWHZXOMFW89JywDqFJ
         aBfSUjmAEZHSeYgSmwthXXU55ZektQ0VrpvofU6JUhl6G1Br+xK2vSAyjoXa/QcJRfy8
         Fq1j+iuhZY3S+wkbFNNEN0NQbQsWHqGD4ABwcuJ83+JM5KtF71XLEQCjL0k0dBBRwgdp
         9lXGsiKbFCstGGiCT1A+VK11/EYEt8EaIn9C4zua/CQR7PgLOadM8VvKOvNhcPKASwPo
         HrA8tcUrPMWIYlL2SSSUAOs/a2j+EjwzJrx+cDKI0Q2/U3cMwgpxZtksby0y7/VIDux6
         3OeA==
X-Gm-Message-State: AOJu0YywBKz+NMh3Velb828lGEfUahQOqBxXbY+sHc5MSTG/rOzWVBiO
	dGClXt4HnglfzV25A/JvT1li2SGmACVbbJLFzGZe1d5+wq6htsL8tnsZC/LQX9K0HKHKXWVPSIY
	mB0ErndDDZtWWz44tl7iamzIImbFDlTw87xecHcTNL+hU1NM6BG6S+0nYAK9rAe2v+FSC/vTvg/
	Bs43hrZK78jkQtuTnnJgcmr56CK1Fm
X-Received: by 2002:a05:6a21:186:b0:1a7:912c:4a60 with SMTP id le6-20020a056a21018600b001a7912c4a60mr2157261pzb.4.1712729368478;
        Tue, 09 Apr 2024 23:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU6Br+y7ZLlNLo4KSKT8o6SK3mGKJFVCb2xmJ2+EI/QnRnzH+iDld5ZX3v968qQ7jPjyAIw5rA42aTXkGCrl8=
X-Received: by 2002:a05:6a21:186:b0:1a7:912c:4a60 with SMTP id
 le6-20020a056a21018600b001a7912c4a60mr2157239pzb.4.1712729368160; Tue, 09 Apr
 2024 23:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com> <20240318110602.37166-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240318110602.37166-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Apr 2024 14:09:16 +0800
Message-ID: <CACGkMEv=u19rOf_84rp3GP=FwxJ-5XAChyHwR_s_iao0xUma_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v5 3/9] virtio_net: remove "_queue" from ethtool -S
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 7:06=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The key size of ethtool -S is controlled by this macro.
>
> ETH_GSTRING_LEN 32
>
> That includes the \0 at the end. So the max length of the key name must
> is 31. But the length of the prefix "rx_queue_0_" is 11. If the queue
> num is larger than 10, the length of the prefix is 12. So the
> key name max is 19. That is too short. We will introduce some keys
> such as "gso_packets_coalesced". So we should change the prefix
> to "rx0_".
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



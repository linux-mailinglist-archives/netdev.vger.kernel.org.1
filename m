Return-Path: <netdev+bounces-143626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 707769C3629
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 02:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277EC1F22EC2
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 01:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04A625777;
	Mon, 11 Nov 2024 01:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOn1gRcp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38718E2A
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288968; cv=none; b=YE/TEEqIVARObsqisiiyLI4uXkdbBWfkvhS47cTc18ce/JiOAl0CvYQz2X4whrEdq/yEttZuJ6UX718aF3ZqfiMXB/Ca21Fn/ByoL5ytcgHvjbzc91DJklBuwKV8p8SfE7HkxFNnjwv6El+0Ph9Lza61HjZNvgtcD6HjHRIomm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288968; c=relaxed/simple;
	bh=XdGLyjxBtq7skX/bK0TG/Xfwr3W5VTrng1jSu08x37Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHIFk45BiPVdKZbAixhJhcU004Amyw+2ZaDi9Bmgx3mVNRVageboka4UQ1J1CkUNwgow3paCu/n6PkJDSvI8s8puSWahGlIEbc48x+p5Uw+tdibQ5blT+cQyfTZ/zWeiMVvTWELmx2SAY2iFMIxuhINPQtN+66hpjRVhJh4lC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOn1gRcp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731288966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/dbATLxL2+itDhzJeEzYBm61TCf+9wmLBdg3lhJg1U=;
	b=SOn1gRcpMwA/BIIhJFwxbxbu/dGsXG/aJMzOnBl3UmLcH7tVxS8UCcpHMuO2YMrJbsjX4x
	kHW+VFG4HfDlCPO5rgn3z02IBieO6sX7BTo/7aUm9yN9m6za4DoT/UbijBLXVwkFI/Xkkw
	86p5JCtHrT5SWwe4NGCtI+OiEtvYHHU=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-EAUoiU7cMd-87bdJmidogw-1; Sun, 10 Nov 2024 20:36:04 -0500
X-MC-Unique: EAUoiU7cMd-87bdJmidogw-1
X-Mimecast-MFC-AGG-ID: EAUoiU7cMd-87bdJmidogw
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7edcfbf0a25so2701871a12.1
        for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 17:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731288964; x=1731893764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/dbATLxL2+itDhzJeEzYBm61TCf+9wmLBdg3lhJg1U=;
        b=CRoK6Q+i9nqbBi1Pyx+jvaNHfBbzSATrRdn0x0A27mxgE8NqRXD4jcV7/HjDjJzlaR
         Lva3Sw5W+lmcgR0ewONJUZGXt6RPGhIAJiiXmo7Gy/sUNQ9RFyB1Y+vfrP83nb/I8BuV
         +0zPrMW5Pqr7GQTLMhuT55VHQ+cENWfRkJkhjhYuGXC6Uma0fMRLCwgx7tXUWBSm2bVf
         BArDBQtGWNgNiUG0Vy7LloTaOzAp7ep2EnxG4nzd1FXNsYBuTyowJ6Vinm6Sv6LZXN9s
         meOIGoZf8WXv/AnHqtHUWimBfiAz4GtzhT8VlihHAIJCwkoz60prAoGj9jNCrCasznNI
         4lAg==
X-Gm-Message-State: AOJu0YxqNyOPrTGE8TjhrtrXEQFhzJ+WWj6nlC7ljZieMmg5HQWFxmHx
	b7PlCExB3YmHEortGD4wpU1lGC455wx9VsbkYkha8oGwkloO4k8usuv703yUc16nFSVst5nujQx
	R/FxVl7+UFmJgf9jDMred6HpkFDPrvsf3ySk+oePqS6VfbPF04/fjs/qeHHOwT0vNYvJiMIDQs1
	NPlqqWwIc1t1aD+MEQP5x6MfwkPhU4
X-Received: by 2002:a17:90b:2744:b0:2e2:af88:2b9f with SMTP id 98e67ed59e1d1-2e9b172005emr16972816a91.16.1731288963662;
        Sun, 10 Nov 2024 17:36:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0I8ydXA+f/porptghF/VJNNnyFOwaz2qko4ky8Boj/2OSboEeDKrdt8AhMzcp4lG0pNeDvvUUDBSXToarMbI=
X-Received: by 2002:a17:90b:2744:b0:2e2:af88:2b9f with SMTP id
 98e67ed59e1d1-2e9b172005emr16972792a91.16.1731288963254; Sun, 10 Nov 2024
 17:36:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com> <20241107085504.63131-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241107085504.63131-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:35:51 +0800
Message-ID: <CACGkMEvzJiTTxibwrbGgdfb9Vq1xtYvEcvR9Y2L9UdOCiy77ug@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/13] virtio-net: rq submits premapped per-buffer
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
> virtio-net rq submits premapped per-buffer by setting sg page to NULL;
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4b27ded8fc16..862beacef5d7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -539,6 +539,12 @@ static struct sk_buff *ptr_to_skb(void *ptr)
>         return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_FLA=
G);
>  }
>
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> +{
> +       sg_dma_address(sg) =3D addr;
> +       sg_dma_len(sg) =3D len;
> +}
> +

In the future, we need to consider hiding those in the core.

Anyhow

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



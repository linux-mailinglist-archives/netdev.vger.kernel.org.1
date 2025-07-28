Return-Path: <netdev+bounces-210688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09368B14494
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 01:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE28188227D
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 23:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D483922D9F7;
	Mon, 28 Jul 2025 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jl2wtYr9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4450C1A76DE
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753744252; cv=none; b=HOBcdFc09G27sX37izpGiKH50VT+2uOUfn0EKB8GtLC8PeZnMQryXpxF398aZ/2Zp++4XWre2oaEo1yHxRyHoiN2XmjKINuopnAc3vNFHcnbp3Lx5nkJcgJDRy9wyie/fRU+4h6EPhEDQKXduSgoEpw2fMW5U1FvmSo8JnhFRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753744252; c=relaxed/simple;
	bh=JkQC++szIDL17RBaPLqfs4n9nKI3KChHh1pd2JECjA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOOPYi1sA60VUKGXTvylrkQf3HcDcuhg16xR0A0oTyeqbA30ev+EdG+VmpOB0nDTTjTk3t/TQLdJDrdETOEN8QBy+a8kImSRSGM+bGiIBo6E0Tei7Eob8e9hZLpcjuJKBWwJMCpl0464tcMVb0ebKLV6mEUq7XvYLh/RNRwoYCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jl2wtYr9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-24070ef9e2eso3905ad.0
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 16:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753744250; x=1754349050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saK3JpUVHI1zm/PfhVqcJ3p3um2uiond2nTBek3vesc=;
        b=jl2wtYr9iK98JBhw86qs6ydYx4VmIa6mjE7xRlRNTskhiZCZuRTmLh+cZU8HQkMAx3
         qdO6j1H2NjvNVT1BZupl3790pOgErhjfjXvT1/YrHxm4U1V6dUo31pa+9WgvjrdwsL2Z
         3HvkWOLfm9/tisLuMNObP1t2uJ2KEP781cfkyKuNx89gWTLEnjujSc8xWZ7s91i8Fmca
         PS00xiNfLRSFiL1qrl4qaZUTMkcXhkH/Fj+LTZ2/F9bjmD3gYmKDWjoGxaSsxbnwv18j
         Oq2C377j1iAXPKWBd+xrHsBZAWhTnqB3gj4TQJTlY5rE01AT41O+1jPl6UbtReRCoSoT
         KVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753744250; x=1754349050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saK3JpUVHI1zm/PfhVqcJ3p3um2uiond2nTBek3vesc=;
        b=ORmAga/QFGxgIhk9bFHduZHhSzlcL/DvPQipaRIyCUei1SOSCd+wVRWyBUFv+wh4cE
         N1QUkFoTb8LFvKjcSZlHWeavYXzDjbmDL+dwNPlaUN70xB/qS9hpN1e/eUhH1euL1p1d
         pwJi6wDEgTq+UiZXuk5+n2V5REBbgx+bsJxuwwgksv99x98vPu/iq0nZTEpLz6K/SfbG
         9BbLTG4Ji7Xi2Gg9oc4lVhlFNkZ3BU0mCcVNDV1zWTxwidP3w1Mv55yslCF+47hr9yLa
         HLYAGQdWqvykP7UkZC/c+M4uiBd/Bpgc6ktSCMpBk/vnMQ7BTz3zYhfma6nCIOC0IU+g
         yyzg==
X-Forwarded-Encrypted: i=1; AJvYcCUiyyd7ARMbKcVrhHoTmUVg9rJZDCDIcppwcg2t30HtotbPnRxMdW8nuNwflIryfVyy1up4yCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YycIQnH9lVOlBWPtG1F2lZWLhvIPs9MCKbaoiCIqgMdX0KeRt8m
	6zSvShU7ZXo73Jvd9RCpiu1DS+m+Ato/C0sfhrgx7yUAszx1sSQZrMXV8bfLXKsfAavkCy5b1+m
	siD1snjAbKNC4XxX0/txkrDk4hV5Kc0lNkYe9Syli
X-Gm-Gg: ASbGncvIqPT0Tu31QfkVn5jRXhr5ZQOFJD1x3MoVujWkmwjVWVa7EOBM6d0In867481
	uLh8pu7mVTLIqU+S/b5uC4Pr+2ODzKao3HjZ6jKUVzXubczT+gUoJmvf+zp+7dwdr4lCuz35LuX
	1TdO/zMQvSbrrRr/0ozc2SP6KsNRZnGZ/XtRytq6f2HjIvrIWgBdG2vabaavWnR9UV1DRFLvtMd
	WLusHwDkSqNJXhzTr+Xz1gwYNsNmTL685bFUw==
X-Google-Smtp-Source: AGHT+IE4BgFkkLYDe0dgOUAbDam8OVQ31t4lZcApgCrAVnXv2ZE50Ru+UCIsnrkHUWBPVHn79eoi6oprthw8lCpIqD8=
X-Received: by 2002:a17:902:f705:b0:240:4464:d486 with SMTP id
 d9443c01a7336-2406e89d40dmr644855ad.13.1753744250248; Mon, 28 Jul 2025
 16:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753694913.git.asml.silence@gmail.com> <4db7b749277d4c0723f448cb143dab66959d618c.1753694914.git.asml.silence@gmail.com>
In-Reply-To: <4db7b749277d4c0723f448cb143dab66959d618c.1753694914.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 28 Jul 2025 16:10:36 -0700
X-Gm-Features: Ac12FXyFdY4nfPw1vGXeVgRg7trTeRhJyIC9GcNBuGsjuhfrII6pBdM-1j2-MPg
Message-ID: <CAHS8izOZEpe1mDTFFM-LatqwJjXUV_f+ajrVK2S_=oBbpVXUZA@mail.gmail.com>
Subject: Re: [RFC v1 17/22] netdev: add support for setting rx-buf-len per queue
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, io-uring@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 4:03=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Zero-copy APIs increase the cost of buffer management. They also extend
> this cost to user space applications which may be used to dealing with
> much larger buffers. Allow setting rx-buf-len per queue, devices with
> HW-GRO support can commonly fill buffers up to 32k (or rather 64k - 1
> but that's not a power of 2..)
>
> The implementation adds a new option to the netdev netlink, rather
> than ethtool. The NIC-wide setting lives in ethtool ringparams so
> one could argue that we should be extending the ethtool API.
> OTOH netdev API is where we already have queue-get, and it's how
> zero-copy applications bind memory providers.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  Documentation/netlink/specs/netdev.yaml | 15 ++++
>  include/net/netdev_queues.h             |  5 ++
>  include/net/netlink.h                   | 19 +++++
>  include/uapi/linux/netdev.h             |  2 +
>  net/core/netdev-genl-gen.c              | 15 ++++
>  net/core/netdev-genl-gen.h              |  1 +
>  net/core/netdev-genl.c                  | 92 +++++++++++++++++++++++++
>  net/core/netdev_config.c                | 16 +++++
>  tools/include/uapi/linux/netdev.h       |  2 +
>  9 files changed, 167 insertions(+)
>
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
> index c0ef6d0d7786..5dd1eb5909cd 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -324,6 +324,10 @@ attribute-sets:
>          doc: XSK information for this queue, if any.
>          type: nest
>          nested-attributes: xsk-info
> +      -
> +        name: rx-buf-len
> +        doc: Per-queue configuration of ETHTOOL_A_RINGS_RX_BUF_LEN.
> +        type: u32
>    -
>      name: qstats
>      doc: |
> @@ -755,6 +759,17 @@ operations:
>          reply:
>            attributes:
>              - id
> +    -
> +      name: queue-set
> +      doc: Set per-queue configurable options.
> +      attribute-set: queue
> +      do:
> +        request:
> +          attributes:
> +            - ifindex
> +            - type
> +            - id
> +            - rx-buf-len
>
>  kernel-family:
>    headers: [ "net/netdev_netlink.h"]
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index f75313fc78ba..cfd2d59861e1 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -38,6 +38,7 @@ struct netdev_config {
>
>  /* Same semantics as fields in struct netdev_config */
>  struct netdev_queue_config {
> +       u32     rx_buf_len;
>  };
>
>  /* See the netdev.yaml spec for definition of each statistic */
> @@ -140,6 +141,8 @@ void netdev_stat_queue_sum(struct net_device *netdev,
>  /**
>   * struct netdev_queue_mgmt_ops - netdev ops for queue management
>   *
> + * @supported_ring_params: ring params supported per queue (ETHTOOL_RING=
_USE_*).
> + *

I don't see this used anywhere.

But more generally, I'm a bit concerned about protecting drivers that
don't support configuring one particular queue config. I think likely
supported_ring_params needs to be moved earlier to the patch which
adds per queue netdev_configs to the queue API, and probably as part
of that patch core needs to make sure it's never asking a driver that
doesn't support changing a netdev_queue_config to do so?

Some thought may be given to moving the entire configuration story
outside of queue_mem_alloc/free queue_start/stop altogether to new
ndos where core can easily check if the ndo is supported otherwise
per-queue config is not supported. Otherwise core needs to be careful
never to attempt a config that is not supported?

--=20
Thanks,
Mina


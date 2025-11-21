Return-Path: <netdev+bounces-240675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 465FDC778E2
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 07:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A2344E7A6A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 06:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F98330EF62;
	Fri, 21 Nov 2025 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dB8FXIm1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzVotcWN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045552E6CD9
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706008; cv=none; b=HY+qjbyuV6/Ii8dLaDhBKQLZTCUiXE3RO0/zn240bLO/2J4taSqmZKPju5COASUs9Lg4RDMloSsqOrXiGT3YpudZsx7NQKV6zYLOQGWNUqalF0ipErgHf/lrSPEiNPPSiy5JNa8rfnRLD4mBIN6FzQJSkc+YJSlnw7Y+S4EpChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706008; c=relaxed/simple;
	bh=+sXfroQ9+Yeauo6qtLKIrEOaBpAUSForDBLtkR69j+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axwDZjpubD3UisPQtceF642DFPDrNfEBl+o3sZX2SxzDOjnQlQLiODNZSc4Rg3XK+E32tJvwQT7id05Q7gNrHb/ktqlKtUEVrl+ayt9ehlqF8vNXScNJddMo8A90aYOw5r5iWNodfCBYQJwpjyzPYDVUsb702OTwMMXJIyS+a2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dB8FXIm1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZzVotcWN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763706003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ggRX1ZqBKGYN1jsO4rritRA352gi7SUTeQqpV7JnIS4=;
	b=dB8FXIm1FUc4WrD1PlL1ZLIiSP2wqYevpy0YDFAuHdwgK4ZttTNKZDRsgTfHrbloqlAfM1
	RW7YlJKbvC1hL3587WWyOHNlmiHRiRQ/xWml6sn4fHVGctQjj9lB4ARXy5N3Sv2/tzIrW+
	MYJ/paFZyo8dCVjxk1ItBU9zF02dw1w=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-gwVsxQEpMcedmtdUyLrn9A-1; Fri, 21 Nov 2025 01:20:01 -0500
X-MC-Unique: gwVsxQEpMcedmtdUyLrn9A-1
X-Mimecast-MFC-AGG-ID: gwVsxQEpMcedmtdUyLrn9A_1763706000
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29806c42760so73405025ad.2
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 22:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763706000; x=1764310800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggRX1ZqBKGYN1jsO4rritRA352gi7SUTeQqpV7JnIS4=;
        b=ZzVotcWNAFIY4wjUHcCDrcmEIFmDnqb6ncnyhk6MxdOM1LD4j8gMTMAg/h/zWUH16v
         AHAu5olHl7VHuJZwv8CqyYjRbmdp/qZHOaI7WPYoVp1/xzTIKrI1tgwRqYnFW4PgcAqU
         QfLipFMCX7dlF7+wyJASakwFOjBnZgNM/xGAAbD+s523wTCiyzn5t4Kt/zm1rxB9x4Ja
         hc/kGKfwHDtIG3Vvj2vVQNyiHuDZpIhfH7OUmL+tkAFqTh8+axsPRnb/ET2MKMvQElUd
         jBKdV6EYmFViVEw7bOtVu026NTZTAiQVav+ZmMNlxHtDBYxazLGrqTBMJrBF4tDIw5XA
         jIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763706000; x=1764310800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ggRX1ZqBKGYN1jsO4rritRA352gi7SUTeQqpV7JnIS4=;
        b=OhWLSdQzo82J8BYp1ulr3dnZwhNZNyIkAFa0EqbuO+47iI3p9FNJgN8pRNQiiHagCg
         9cyVw7DZ0ino4jnzFqQLM7+2VrbhOlBy10hIOJSHAVqlSpab+631ue62yDP8qR4L7d2e
         7KPglg68s0ZzaIxa7Km6WdECx5Dmbyd05fytRdqLVxI/O8WOAVK+O2AZJ+1lMYupUa3t
         9kp0LrEGTkZ8wvuqPcPXGPZHRMUarc8OSdjjFnIB65eZHpUpVFMdr3ibyxSQY5Xc0haA
         eF0732qxs+lAyPpUnyHv5ir6piUAqKirzaKR9LKEnZ63lnqtp9kJKglS5Nk2gXJn2vMV
         j7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWVI7Q82pOeiBJvHiogWWaaeh3ZsnTO/D68nmdvkIedZq0rGHMIDTQcCAhczq4Stul5Pn/ucOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfH72+Tlo5NG8gf9azYFXX5JuFU5JtaaGPUfmYsWy2hLRkj5Mq
	MWigblNLiAySFiC9gFIcgAhxFHpifz5gJa0P5iRY+x6TlcrmwzO/7a81vymRC+3HN4j5ea+AB6w
	VQTiPqUr2F25M3/gaFxIiEneroAd2ch5R3iLjfAUf2WCzfALewZ7Ibg4W3I4EuZGS/H2dj8efen
	DTqnkA3Kk6kE5dMixixpVLJFNQLeoF0+PC
X-Gm-Gg: ASbGncvdKCaDll48G1lgFRBi0ea2TCEgBDhuDcOCbdvDquI52Ee36nGKNrgmWLpClCW
	hxuSAYkwEPrHmfWClWOOsys+e9ufrD5ClZa39mrv7R2JnG77f5BjBezqVhBFv6Y7If5a6iEy/hC
	xMr5oWC3Vit2OMb0rDg6MOlMWemjbs6iz9pvniEgsUnwZ1KNGWpd7LFcI7d4bMc2BqyQ==
X-Received: by 2002:a17:902:d2c8:b0:295:8da5:c634 with SMTP id d9443c01a7336-29b6be7891fmr14962925ad.9.1763706000105;
        Thu, 20 Nov 2025 22:20:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUmADglGq6E7uEJIg62yJdZRoNMyJghNrkeN6DUBkf5vF0UyhiAgyRbE/RfDCtL+AZds6YfvoKcPhuQ6RYwco=
X-Received: by 2002:a17:902:d2c8:b0:295:8da5:c634 with SMTP id
 d9443c01a7336-29b6be7891fmr14962735ad.9.1763705999682; Thu, 20 Nov 2025
 22:19:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
In-Reply-To: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 21 Nov 2025 14:19:48 +0800
X-Gm-Features: AWmQ_blptZAZY5T5Gzybc2BRw6WU6w0JP6uqFpewdXiABFkFXapZqQDd1Zn3LSk
Message-ID: <CACGkMEuboys8sCJFUTGxHUeouPFnVqVLGQBefvmxYDe4ooLfLg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/8] tun/tap & vhost-net: netdev queue flow
 control to avoid ptr_ring tail drop
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, jon@nutanix.com, 
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 11:30=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> This patch series deals with tun/tap and vhost-net which drop incoming
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this
> patch series, the associated netdev queue is stopped before this happens.
> This allows the connected qdisc to function correctly as reported by [1]
> and improves application-layer performance, see our paper [2]. Meanwhile
> the theoretical performance differs only slightly:
>
> +--------------------------------+-----------+----------+
> | pktgen benchmarks to Debian VM | Stock     | Patched  |
> | i5 6300HQ, 20M packets         |           |          |
> +-----------------+--------------+-----------+----------+
> | TAP             | Transmitted  | 195 Kpps  | 183 Kpps |
> |                 +--------------+-----------+----------+
> |                 | Lost         | 1615 Kpps | 0 pps    |
> +-----------------+--------------+-----------+----------+
> | TAP+vhost_net   | Transmitted  | 589 Kpps  | 588 Kpps |
> |                 +--------------+-----------+----------+
> |                 | Lost         | 1164 Kpps | 0 pps    |
> +-----------------+--------------+-----------+----------+

PPS drops somehow for TAP, any reason for that?

Btw, I had some questions:

1) most of the patches in this series would introduce non-trivial
impact on the performance, we probably need to benchmark each or split
the series. What's more we need to run TCP benchmark
(throughput/latency) as well as pktgen see the real impact

2) I see this:

        if (unlikely(tun_ring_produce(&tfile->tx_ring, queue, skb))) {
                drop_reason =3D SKB_DROP_REASON_FULL_RING;
                goto drop;
        }

So there could still be packet drop? Or is this related to the XDP path?

3) The LLTX change would have performance implications, but the
benmark doesn't cover the case where multiple transmission is done in
parallel

4) After the LLTX change, it seems we've lost the synchronization with
the XDP_TX and XDP_REDIRECT path?

5) The series introduces various ptr_ring helpers with lots of
ordering stuff which is complicated, I wonder if we first have a
simple patch to implement the zero packet loss

>
> This patch series includes tun/tap, and vhost-net because they share
> logic. Adjusting only one of them would break the others. Therefore, the
> patch series is structured as follows:
> 1+2: new ptr_ring helpers for 3
> 3: tun/tap: tun/tap: add synchronized ring produce/consume with queue
> management
> 4+5+6: tun/tap: ptr_ring wrappers and other helpers to be called by
> vhost-net
> 7: tun/tap & vhost-net: only now use the previous implemented functions t=
o
> not break git bisect
> 8: tun/tap: drop get ring exports (not used anymore)
>
> Possible future work:
> - Introduction of Byte Queue Limits as suggested by Stephen Hemminger

This seems to be not easy. The tx completion depends on the userspace behav=
iour.

> - Adaption of the netdev queue flow control for ipvtap & macvtap
>
> [1] Link: https://unix.stackexchange.com/questions/762935/traffic-shaping=
-ineffective-on-tun-device
> [2] Link: https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Pu=
blications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
>

Thanks



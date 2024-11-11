Return-Path: <netdev+bounces-143638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9459C3749
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 05:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5181F21F3A
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 04:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7CC1494A9;
	Mon, 11 Nov 2024 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyRvFfv9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC243AA8
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 04:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298314; cv=none; b=LEO955vBbTIZyUNipz1B3fJXPhp+1f7EWurgNADgLtrHuzeiGZwAcz2W7X9KD+nDa2S/qPKOF471j8GuJ1pr8uJKdGO1ZEPG1g/Ur/YLhMh6Gv9UzpbgsAObVeHyVhuMs0p2Swx/mS6bm88E8s6MxDOuW921tzhThI1S5nNdvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298314; c=relaxed/simple;
	bh=DLATnqdMGEF0WqdmHPcRRNdo+OHNczLANGm8ldMNdG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSjF1cU2JlZA+eZhgn4Xw9Kycdqfu/EPhR+m10SPKGKVyJpz9QW9XYgquplv89olG8PMh67fPPdNy/hHiRMVGCmVW9CKFNt2VNXFVAz0QcWlifLOfUQz6+g/66P4DPpGOhYdiimBlf/0S7H0BIausXiciT10XFjvmmbYuI+mEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyRvFfv9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731298310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2GV+7EwQ9ZLkRfoZhE0lui517nfX5U3dHrCpkmZzho=;
	b=WyRvFfv9q3JdzjVKWHigeNYv17lVooPtTn3eKh17NeRmWve2C/hV+T1kBqTwDoBWIkCVCQ
	hwJHzecelG0ndhWXfKTK6Lm9lBuFTPO73YaFjflhl0+z2PYtW+WjBF19CLmoSCWbi0/L4t
	dZJPwh6DnYxqmlHknpomXfGywCPrqWs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-tgbJJVYQOKOWacYxI98row-1; Sun, 10 Nov 2024 23:11:49 -0500
X-MC-Unique: tgbJJVYQOKOWacYxI98row-1
X-Mimecast-MFC-AGG-ID: tgbJJVYQOKOWacYxI98row
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2e5bd595374so3301589a91.0
        for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 20:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731298308; x=1731903108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2GV+7EwQ9ZLkRfoZhE0lui517nfX5U3dHrCpkmZzho=;
        b=grc/X/tf6pwbbsp6KYFH0lUoKdevMiffXGcKTzd0fzFmVSTTbHeiChwibg7AoWX2OL
         RZmPGpX9tl+GyAx3DS6suSTYu5j6c2E8pCQm7+AUC/uaouHCARJrZRtPUzwbwSi8tS/e
         XWE7qQDVU22ir4TbcwEPlO2t5ID00IBp4oNY2/bNYHq5WmjWcG94EsA0oaUXzPskGbI2
         dcAHvMI4vN0blUSsY3aXGVHM/EhFBzN5bGGts93ZfpJPwtwx1lCepyo3i7Mhc0VXVo5b
         3j/FL6RkqGsraGT/fWSDBux65SnUcrA8O5yGOFnCexZ/UfyiLTeWfYf/ODi7dV64axK/
         kS6A==
X-Forwarded-Encrypted: i=1; AJvYcCX4Aam6I6MQ0u/1jKPPKX9DJnLv8MN6jPOkacCn0wTVee0UBrcKZGCBlmaLZZ0qI5+cvnEBnVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm001g1ITQ+23b8qKQPuf6jRM5U7Prqmq+7TQ9Yn7Dt6ejro9u
	oL5idF4XbrwoE2AsgF89ahI/VcePWoTL8+7+RgspxOZv3ZzIYH5i4InTAkQp1zJiOBfxR2z3IWT
	ykcCSM/ggKGSTVSzWD3CM3m7/DE4YjBwIeF02f4XxwoRn1bSS5C9N1Hh1eSAfy7WbKBQl2vscuw
	cAzEt+69ffQly8l4m7AVbGwLst6ChV
X-Received: by 2002:a17:90b:2d4e:b0:2e2:bdaa:baad with SMTP id 98e67ed59e1d1-2e9b1edc2e4mr17018411a91.7.1731298307830;
        Sun, 10 Nov 2024 20:11:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEc7ZYwHnxrg0FC/Z799Zoc1i4Spe4Nhk9xnNGMzEBDcw/KeGeVkU4qh3S2hfEgAgRusgumV+PhOR6e3ykmQ5M=
X-Received: by 2002:a17:90b:2d4e:b0:2e2:bdaa:baad with SMTP id
 98e67ed59e1d1-2e9b1edc2e4mr17018376a91.7.1731298307416; Sun, 10 Nov 2024
 20:11:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com>
 <20241107085504.63131-4-xuanzhuo@linux.alibaba.com> <1731293994.9676225-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1731293994.9676225-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 12:11:36 +0800
Message-ID: <CACGkMEt8wd=tq0Va=BwmZu20LFv59oegpAD2VzfLM8vaZJw+NA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/13] virtio_ring: packed: record extras for
 indirect buffers
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 11:53=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> On Thu,  7 Nov 2024 16:54:54 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com=
> wrote:
> > The subsequent commit needs to know whether every indirect buffer is
> > premapped or not. So we need to introduce an extra struct for every
> > indirect buffer to record this info.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
>
> Hi, Jason
>
> This also needs a review.

Sorry, I miss this.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks



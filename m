Return-Path: <netdev+bounces-120813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9159C95AD26
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 08:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFC71F22883
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 06:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD3178C60;
	Thu, 22 Aug 2024 06:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSME000o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145552AF0D
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 06:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724306638; cv=none; b=c0AZjx6UMuvMYcTiUWcinx7On6yPowyuS3ZEI8KHfUzPioGrvmeWlhUXDsIf+4hQmoHNZS22reu1L4hd4Dd6PIKWcnefiZ0EkFPhDZGooRI3Lyz9Y95dXaEeTfuVzKCGzTOHBkNcFi9WHJOFKUk0iL6xif2JLjw5RE1gkeDJtWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724306638; c=relaxed/simple;
	bh=A6A4Fe632TYShLqfk32WrMMELcP3NWtAJYeFYitcR44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIEgYNlhnIv/ZXBH1h+hgV7hh7O65Tf47TrTk+m/ebXhfNJglqQIrKcP2AQNg+j9GUnTA3sjbQedBmfGxMjTuwNpDZYspUxtZUS7X7Wixr7ZNlFR22oxk7FE+i37ff6IN7p789PMVtx4p8LATgI4lOH25Xoebm5+hoQntLIS4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSME000o; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bec4fc82b0so2718990a12.1
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 23:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724306635; x=1724911435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6A4Fe632TYShLqfk32WrMMELcP3NWtAJYeFYitcR44=;
        b=bSME000oWPMnQydZRZXV2mKwr+14BbHvtEPSKT/MUAj+SsCdZU5prvCgYxQlPste2n
         EuaC9IX4cNALFcZ69hlYF+C8SWvqsVjVoxMILHCwOeoTPNn7qkrfSXpiOVq6Ysy1nD4S
         g2jLz51eXptzSTRVlZu0qqZVVOk+VSI53neyKQtE7qm4eX2TZPBE+viMjykSY3TGkpd6
         PFbMu3/gutoIpmeLfPP6uKEcTFjnCIiWSpE3shGZKs3xb7nainZ26NixUAfULzRTE0Z7
         rQeV5iI+rCtcFDHkTIUtxTL9+zorLY2mNHya9LFNRDEvAINB8FI6AKufzdRaGdxei16u
         2fVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724306635; x=1724911435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6A4Fe632TYShLqfk32WrMMELcP3NWtAJYeFYitcR44=;
        b=Q3ulW5ATbW1x55KgYYRI8S39ziv2D6Z9pjqj5ino/Sj/LlRaCO1Z8CXz3iSMVOolIl
         xhQnkVKaaC9KwPiYL7OVwNofXXxgrum2u+Y1K8THuQtbK9zZ6WevvmuYGbqNbniBfHQ1
         pAJy3LDgzKh/uH0H3qEgriPnSa9IHTTsjJq5vxD0wj71QdYwlQu5vU91VMD/+fM0ZJLo
         rW/8vivNj/JjZlrVB7II+i67g52TYqQh5Pyc4gUnGwWJxvp0EgBKRcKwveYetu6+1c0C
         /1RxDnYJsqcZm6/uwk/a31F4YETO1B2fxXZrAuSa18BbZrynUqINzvWuoI85N1YVvWJx
         LR2A==
X-Forwarded-Encrypted: i=1; AJvYcCWgeWzeKxT8vRClxRPDYpeNX18+k5u3OmqpseF8n3TNxM81pku4H8QBnKMscIk5dVMk7w/Iz5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YynOS3lxDtJCHlKDy5GGhyAkTPsV6mt6aE1Y1596+PVp4/wgeyJ
	mcJFk1ZG4s6fKwNd4zHAChTj+Y3hTiedQZL1t/hVDVh1LWVsOqeVgN4ycd7qO3OpFYAAb8sfq35
	razzwMvrCSvtUIVfvX/eyDIQRsztoxibNgzOrUGAy4QtnD07jrnaM
X-Google-Smtp-Source: AGHT+IGNfFwTAmIsIllx9KcRV2vWMF9IIN4oRU2yH5xHn4rDW0RJpAFvaGgqE4eyO/Fg6KLLFZkJ9cN2Jikv3AYMafQ=
X-Received: by 2002:a17:907:7f1f:b0:a7d:89ac:9539 with SMTP id
 a640c23a62f3a-a868a5af23cmr176699566b.7.1724306634586; Wed, 21 Aug 2024
 23:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822043609.141992-1-takakura@valinux.co.jp>
In-Reply-To: <20240822043609.141992-1-takakura@valinux.co.jp>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Aug 2024 08:03:41 +0200
Message-ID: <CANn89iJGUCp-4fRJWzwNzakyNZM=_mSNjX=_OUT8WJW-+isAfA@mail.gmail.com>
Subject: Re: [PATCH] netfilter: Don't track counter updates of do_add_counters()
To: takakura@valinux.co.jp
Cc: pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, fw@strlen.de, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 6:36=E2=80=AFAM <takakura@valinux.co.jp> wrote:
>
> From: Ryo Takakura <takakura@valinux.co.jp>
>
> While adding counters in do_add_counters(), we call
> xt_write_recseq_begin/end to indicate that counters are being updated.
> Updates are being tracked so that the counters retrieved by get_counters(=
)
> will reflect concurrent updates.
>
> However, there is no need to track the updates done by do_add_counters() =
as
> both do_add_counters() and get_counters() acquire per ipv4,ipv6,arp mutex
> beforehand which prevents concurrent update and retrieval between the two=
.
>
> Moreover, as the xt_write_recseq_begin/end is shared among ipv4,ipv6,arp,
> do_add_counters() called by one of ipv4,ipv6,arp can falsely delay the
> synchronization of concurrent get_counters() or xt_replace_table() called
> by any other than the one calling do_add_counters().
>
> So remove xt_write_recseq_begin/end from do_add_counters() for ipv4,ipv6,=
arp.

Completely wrong patch.

There is no way we can update pairs of 64bit counters without any
synchronization.

This is per cpu sequence, the 'shared among ipv4,ipv6,arp' part is moot.

We could use cmpxchg128 on 64bit arches, but I suspect there will be
no improvement.


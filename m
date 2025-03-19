Return-Path: <netdev+bounces-176148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B01A6902B
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 15:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB5617AC016
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F4D215F46;
	Wed, 19 Mar 2025 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bME0lWwR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1444215779;
	Wed, 19 Mar 2025 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395081; cv=none; b=cjWe8IsTmO0ZXmyJNLPUPo9r4TvZ2FQYPQdgR/qyEs0oUfw9T8iZDcVszEal/GjmRh03OIUEgTb30K+wCVDxjFHolyX0zCeZAZbNIS3/uR8HgU6EZgvboZ7A9dtX2LB3mIyhMJT4ABTiSvzsiWBCUXXdmoJTDbRfa5+nFYySuls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395081; c=relaxed/simple;
	bh=2AJEoIgnwx+2BuZBgWaFIqoqhvJ8kWnODfck8x3zMm8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=gvDjwXd7gGp0BCPpdejGA1jiNVc97RxSR/JKUgyrrtO8yxqjTVbCBqfgWQGjgWIpK2fUpHfENgVgrukqTDv+8mIzunbVSy+eamJUbfOicHgiIck4K+z2PQiLA9maltwI5lt+GSf+/pKcvB156RCuowDmpCmPv+SAD56C6vct3Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bME0lWwR; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c560c55bc1so672466285a.1;
        Wed, 19 Mar 2025 07:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742395079; x=1742999879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaeDNTznWl+/ieyaP+T9quLxf1UbRfJd5Fm6GY+c9oM=;
        b=bME0lWwRryE0IDThKP6Cogr2CIynuzF1t7gI64fw71Y8t5bw+opiWe//ZEnKMLXi/C
         hyL6Bm/QLRpqVHaqgSkbB8RPayGfjyNrbXIfUuYTqY0vcLNyorQxKbiKiJdgh0uIrQMG
         dSEYedwO3Qvj+pflpdgUY9V0YTYhnSgx1Qdsu1MxoJYMOXu5gW6hHW6LPyHrPkOhkOe5
         3Pe0//mluIJ+YGQw9TnseEsU0W+qOU7/K/L2ReUQCwl9Un4VeussDBBe+2TwTkw1hx2I
         jhsqVTlHgfjdt/aNohSBgsNLfGjLWtwEMoWKX5+/JBVzNgIQFhhO5zbDOwriPRePJJfb
         pQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742395079; x=1742999879;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DaeDNTznWl+/ieyaP+T9quLxf1UbRfJd5Fm6GY+c9oM=;
        b=lx53J4zBr39Y7x8oR7UuVR24Ck4z5fHtE5mfuEG1iklNYUhdBpdCmZus6VfwfEM8Zc
         gOeUn2JntLrExK+meg158m5qBkUfT1q8DRWdsVTxGLuBqabd/a7aNaA2QmxuussJVrMd
         2Ti5BM724BbJD1ptThORzYLTMfLI7L63KBMMz3GyAm24qNO1fAxfWYZFQbP1FhUFNz7v
         KgZvRAu8P826ZtT4oYKqWNlCqMrtX7NqKj1G9MsbepjoWKPhr1Jf/vl7jAYb0IVhUUE3
         xp9XE5RTIW2GG0E8jIDth6iA+iIV51nxwZYzYOzpXmfs8JoudX6pEcSEnQOB5mAf3gzf
         Udkw==
X-Forwarded-Encrypted: i=1; AJvYcCX8WeBSBevZ/lVZr1nvtA98ZuzUSI7DLLNaVGxbMNXIcjFM9of5GkoEZ41txyIsEcBe7TX6lqc+@vger.kernel.org, AJvYcCXYD+XcNjyhkjN1fe2dnuj7MXxtXa3bJG/tnwEJ7y5CPhxzYvbiZVOf/LsTsKjtm8LHu4iBvlAq2vnFXlGrnWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPkOb7+pIvq/avmg++y5iYs9u0OKu7JioRAsjQ68y1OxdAz/Fq
	3xyJPBCNIUUCR2P9D533cPKqlNVho1UqsU2E8PauJ38SCNzHTMp4
X-Gm-Gg: ASbGnctr7gP2vn7K9hDrxs1qa0RmuQ57IZyPKiEjc/IOeEYAF5T8LBbvwuOyTPy16iw
	avOfJ7JoJKsBSGxApaoVO5mmZdMjnyQtEKVoynebt3P8FCMR34Q5lY6wOpEqs/ud/eUzy35mwaC
	iH8VKR5obXevZCVNuhi+ApwXqmZEZaoksbydc0ZfHo1s7hpj1rPO+EO+QMH8h5eNZQP2N0jSF3c
	KC7TGPDllY9jgoGT3WaemkOSs6hiVeCEblwUkVNbJNqpusMAtKeUrYqgnyL6Mu6Jbtdk8XYaw93
	fSfA3KX4a0LZsC5lfgBla7SZI8sV81/PS5tKM2YExB+Wy+WtERz5KqyP+Nq/MIGiA13OWYfoKv2
	I3bTWvguunVnq/LDWU/tPMA==
X-Google-Smtp-Source: AGHT+IE+sINrWwYP3kxcdz6Zhed/3dDNcSrjNxhSxUWAl38OdLuuzkNL8flPr5JyM0Q0eGuk7zN9Pw==
X-Received: by 2002:a05:620a:2954:b0:7c5:5d4b:e62a with SMTP id af79cd13be357-7c5a84a4789mr479446085a.54.1742395078746;
        Wed, 19 Mar 2025 07:37:58 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c5205bsm875218285a.3.2025.03.19.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:37:58 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:37:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Pauli Virtanen <pav@iki.fi>, 
 linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 willemdebruijn.kernel@gmail.com
Message-ID: <67dad6c5b6ce8_594829443@willemb.c.googlers.com.notmuch>
In-Reply-To: <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
References: <cover.1742324341.git.pav@iki.fi>
 <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
Subject: Re: [PATCH v5 1/5] net-timestamp: COMPLETION timestamp on packet tx
 completion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Pauli Virtanen wrote:
> Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software timestamp
> when hardware reports a packet completed.
> 
> Completion tstamp is useful for Bluetooth, as hardware timestamps do not
> exist in the HCI specification except for ISO packets, and the hardware
> has a queue where packets may wait.  In this case the software SND
> timestamp only reflects the kernel-side part of the total latency
> (usually small) and queue length (usually 0 unless HW buffers
> congested), whereas the completion report time is more informative of
> the true latency.
> 
> It may also be useful in other cases where HW TX timestamps cannot be
> obtained and user wants to estimate an upper bound to when the TX
> probably happened.
> 
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
> 
> Notes:
>     v5:
>     - back to decoupled COMPLETION & SND, like in v3
>     - BPF reporting not implemented here
> 
>  Documentation/networking/timestamping.rst | 8 ++++++++
>  include/linux/skbuff.h                    | 7 ++++---
>  include/uapi/linux/errqueue.h             | 1 +
>  include/uapi/linux/net_tstamp.h           | 6 ++++--
>  net/core/skbuff.c                         | 2 ++
>  net/ethtool/common.c                      | 1 +
>  net/socket.c                              | 3 +++
>  7 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
> index 61ef9da10e28..b8fef8101176 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -140,6 +140,14 @@ SOF_TIMESTAMPING_TX_ACK:
>    cumulative acknowledgment. The mechanism ignores SACK and FACK.
>    This flag can be enabled via both socket options and control messages.
>  
> +SOF_TIMESTAMPING_TX_COMPLETION:
> +  Request tx timestamps on packet tx completion.  The completion

Minor: double space above, grammar issue below "receives [packet] a".

> +  timestamp is generated by the kernel when it receives packet a
> +  completion report from the hardware. Hardware may report multiple
> +  packets at once, and completion timestamps reflect the timing of the
> +  report and not actual tx time. This flag can be enabled via both
> +  socket options and control messages.
> +

Otherwise the patch LGTM.


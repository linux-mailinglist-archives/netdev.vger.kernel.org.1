Return-Path: <netdev+bounces-126618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA78197214F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1B11F2483E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D840172BAE;
	Mon,  9 Sep 2024 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY2fTAEC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24F64C74
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904099; cv=none; b=IvXRiT0cQWXZ//drF+2xT3O2w3V+luaUJjrt3TAIaeS2EJEswYxFcnNfIDy2v8ViDclCchOb4LSd6xBcHafY/MwpCxQ0g1YBQagMwGeLMFXJ4+XfsR1h5urZ/CU7ZrBm5SDN8x5yUitzR/0YE8uA9AXAFcVqoz9681Zih0ouZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904099; c=relaxed/simple;
	bh=o8brjgyHGRw3HooC3+9yz7HD99inUVBq6Sw9sn6+loE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nWjDCeczp6kcfdPMGAgQ7gUi4AJJzKSN+YDVQwqAJf8kzET5CeL/V6pbQcTAWBSnXwtFAfX8kSVTOmzUFeMcrN+O95ETyyUr/WE5K0AmRHJul2AJT/PJoJ528Lje4kqCLhOD/kOuP4h9XqHgSGFEGV+JvnMBtW2j3OPKX+cYb6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY2fTAEC; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c51d1df755so25426336d6.1
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 10:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725904096; x=1726508896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQRwqLDVlSa1yWmpHF1c40xUcQOMRQ5N/+kdRYutWuA=;
        b=OY2fTAEC6O8AAcWsPXRS84oldkdsEevPPqUCxWcPZOHEnqvTtlH9KQfugAU/FU3tb0
         /ReLpQ3YpVud297CK/06FKNy3Bixd1nLgObBk8wqByhm+jIJhDvonMiURrplEv4Gcazt
         EgR8jdYDBOwQwSCPTjfBVRMqqOa+rvosRcl3iP4oscUPh3hFvAGPo2iHAcDzCtcAoSCY
         xgo7BmJFexwByQBewBmL+hqvmDnn5jadvnNMJ5eJuQSE0X+Bsu7+NT3Ly1IEC58tRyq1
         xu05ocqGYCD0clnYXEgUVRv6V/SgVjtZN7834xUV2Y+nWs4xd450PvKpn1kPDJ98VsoL
         2hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725904096; x=1726508896;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MQRwqLDVlSa1yWmpHF1c40xUcQOMRQ5N/+kdRYutWuA=;
        b=KbrOc4OqeEhKuDo4zkIHQJQTN0FCPSZ7ehwkMSD7hR2l+EsiSSZKR0JiljFQ3FM+b+
         3VrtCd+nR+0yLWjb85Ltdt/6GWmYaJe8xvRZ6NQ2WEZlunDcSZN9xIk4j8k62HscUSt9
         eAnwhZ+aryiteswbBveaRYB7Xji5XEf5lIKGhPd7t5rPfZylG3yWE3iqb2qRsYxIHdlh
         AN4fWX9p7sZW6ppv49Qwh3NbVZ1AVSDVO3Evs4nnVeKoBuNBK6AJ8g26iQtKRgufJrAZ
         ihl0rDZpYi4CyCfCKcqD7nbWDCoEE9Gu2gMq5HPYyeAfdOvob59VqK4JRPUJWGfbr5al
         c9AA==
X-Forwarded-Encrypted: i=1; AJvYcCVYwqOGnZjlAkoUFmENT7soMro6RAv3HewPelixes5epB5lWeLoYFbkcNE3qmrKRWX8oI7zYqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJotgA+v3/ZhXNjrX71t/rHlZBiZjC+ISGCi8q1hIks/s237rb
	1qSSSvPzPwUgsmKwBo8HEZj3LBibSW25rxp9aRlRfTObBwm+cV8f
X-Google-Smtp-Source: AGHT+IETSjelxKsa2zJEZ5QGP5YWge8NaF9NFArc2/+sP5PnZErfKtQId9tRJrbDvUevbTJ/cphV8A==
X-Received: by 2002:a05:6214:2c01:b0:6c3:55c4:cc1c with SMTP id 6a1803df08f44-6c5282fd513mr112054876d6.1.1725904096451;
        Mon, 09 Sep 2024 10:48:16 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53434746fsm22680966d6.71.2024.09.09.10.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 10:48:15 -0700 (PDT)
Date: Mon, 09 Sep 2024 13:48:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadfed@meta.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Simon Horman <horms@kernel.org>
Cc: Vadim Fedorenko <vadfed@meta.com>, 
 netdev@vger.kernel.org
Message-ID: <66df34df9812d_3d030294d6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240909165046.644417-2-vadfed@meta.com>
References: <20240909165046.644417-1-vadfed@meta.com>
 <20240909165046.644417-2-vadfed@meta.com>
Subject: Re: [PATCH net-next v4 1/3] net_tstamp: add SCM_TS_OPT_ID to provide
 OPT_ID in control message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> SOF_TIMESTAMPING_OPT_ID socket option flag gives a way to correlate TX
> timestamps and packets sent via socket. Unfortunately, there is no way
> to reliably predict socket timestamp ID value in case of error returned
> by sendmsg. For UDP sockets it's impossible because of lockless
> nature of UDP transmit, several threads may send packets in parallel. In
> case of RAW sockets MSG_MORE option makes things complicated. More
> details are in the conversation [1].
> This patch adds new control message type to give user-space
> software an opportunity to control the mapping between packets and
> values by providing ID with each sendmsg for UDP sockets.
> The documentation is also added in this patch.
> 
> [1] https://lore.kernel.org/netdev/CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com/
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Two small points if have to respin for other reasons.

> +++ b/include/net/sock.h
> @@ -952,6 +952,12 @@ enum sock_flags {
>  };
>  
>  #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
> +#define SOCKCM_FLAG_TS_OPT_ID	BIT(31)
> +/*
> + * The highest bit of sk_tsflags is reserved for kernel-internal
> + * SOCKCM_FLAG_TS_OPT_ID. This check is to control that SOF_TIMESTAMPING*
> + * values do not reach this reserved area
> + */

nit: odd to add comment below statement. Also, there is no check here.

>  
>  static inline void sock_copy_flags(struct sock *nsk, const struct sock *osk)
>  {
> @@ -1794,6 +1800,7 @@ struct sockcm_cookie {
>  	u64 transmit_time;
>  	u32 mark;
>  	u32 tsflags;
> +	u32 ts_opt_id;
>  };
>  
>  static inline void sockcm_init(struct sockcm_cookie *sockc,
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
> index 8ce8a39a1e5f..db3df3e74b01 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -135,6 +135,8 @@
>  #define SO_PASSPIDFD		76
>  #define SO_PEERPIDFD		77
>  
> +#define SCM_TS_OPT_ID		78
> +
>  #if !defined(__KERNEL__)
>  
>  #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 468b1239606c..d2a01eaf6731 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2831,6 +2831,9 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>  {
>  	u32 tsflags;
>  
> +	BUILD_BUG_ON_MSG(SOF_TIMESTAMPING_LAST == (1 << 31),
> +			 "SOF_TIMESTAMPING* cannot use BIT(31) because it's reserved for SOCKCM_FLAG_TS_OPT_ID");
> +

nit: No need for song a long line. Regular BUILD_BUG_ON will do.




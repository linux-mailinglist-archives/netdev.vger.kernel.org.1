Return-Path: <netdev+bounces-123980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F35FD96723F
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 16:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800771F20F06
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7B17C8B;
	Sat, 31 Aug 2024 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFjk/gWB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C730AD55
	for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725115804; cv=none; b=gegsyoNG2vakr6pffJKJTwrLT/lt9oZAneOn7D2FuVSr/4wKK22bKCpz0QYZv08zY+x5ENLKMsenSY+lLJx9GuwvMAqKoLkVZyoGaA+mB9LilY6TpXXBUSfwnhhUs8516pYtUmbce0iavwm8vY01MPFrbir2cr4RLGqBjWACp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725115804; c=relaxed/simple;
	bh=QUNFduSl7DARsNrrA2fjH1JLeSw/RknCdiRc8Nd58Ag=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MDsRCeDkOZOdtFF+hizazSJowA1PfSAabzVvhtM4mZNj1gcCLihHzcLHCT3E81mJdMoNRtf8HKvlzS5h+g2WyQbUSFx5B2pUCxCYZR80/IzeyEBYDv92Hs6kS0bXwTthaM3XNtbB3Gpv0qRGASRdLlMqStGm2THYH/z83dhdZ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFjk/gWB; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-498d7ab8fefso1071897137.1
        for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 07:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725115801; x=1725720601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggN6papODKvWuNm4pftWuTd9P89yO+HoQ7Quj6j3qnI=;
        b=KFjk/gWBpB+dsnPkfGMvHt66r8d4zGOGFvwzcxtBxahyJTLrCy3L+aKoOrGVbb2TCe
         3L1iU1N1u52LLMvrpMEpsVX+2QnYi8cLLvBIDz/0JyhRaqehPp7/ic7vHmfPWeCZ7Z0Y
         2vluG/5sqDjx9yW6tu61rqONdhUGJG9kxVEB9WT8l+2wzIw63S2VDt0JGdt2va4wZ++B
         NSTgBO4BH+SMDD1Hu4A5QTXxBMLM1+UByVUpZ5qenOtlSHNwgM60xaDW4MpNkuA2CSif
         AA5JQpb9cLJGLDgJPzu7hoxh+0+v8RZPi0gSB0b2OBWFLHN+nunQuZt2Al6W0z/ZdwEt
         zw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725115801; x=1725720601;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ggN6papODKvWuNm4pftWuTd9P89yO+HoQ7Quj6j3qnI=;
        b=bmWw90hAYkxmnrGERKHaFY3ioaCnpLONs0RiHWqySf3k98glMfBQdJMLLzTTQHMOBu
         eOSKUFXENTjCpnMuS4gWh26WkmVejBa8itdzL0i9/zw5IPMV1n9hn/R3i0lgHmAOy2SJ
         ucD+pf1p64YxW5eTtPiMwDqmGU2SSUMjFKFbx+nxBfElOEA4yvxotQBDhn0VD1Q5ObZR
         bFgigf4tWwnsv6mdTrxzMX6NjFayrUAJPgF2BE4hDatHjLz0mQN23FgyIbwEJLNxS+rW
         vyZRarWbSB7HcqAkDupMfzE/w9xILU8hMSB3qNYG4QHwMobK2l4Lb2tDPJsU5yF89EF5
         Jf7A==
X-Gm-Message-State: AOJu0YzueV7rVB4SKWE8kj+272m03aVt5SufRYZg7BJeJKnbWK2hm4Qj
	EGS+KB3Lumjekyq+zL+l5GtskXrjCfjCoX/EMkSDsVlMBULNzbRu
X-Google-Smtp-Source: AGHT+IESHfZg0LtMVQmQe5BxtkuYExqwn53laKe+y1vcCwfhSB90q24gUNuawahezqSLL4Ka010G9Q==
X-Received: by 2002:a05:6102:e11:b0:49a:211a:f08d with SMTP id ada2fe7eead31-49a7783c730mr2854501137.24.1725115801101;
        Sat, 31 Aug 2024 07:50:01 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c355868209sm9379186d6.38.2024.08.31.07.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 07:49:59 -0700 (PDT)
Date: Sat, 31 Aug 2024 10:49:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com
Cc: netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <66d32d9766371_3fa17629413@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240830153751.86895-2-kerneljasonxing@gmail.com>
References: <20240830153751.86895-1-kerneljasonxing@gmail.com>
 <20240830153751.86895-2-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net-timestamp: filter out report when
 setting SOF_TIMESTAMPING_SOFTWARE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> introduce a new flag SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER in the
> receive path. User can set it with SOF_TIMESTAMPING_SOFTWARE to filter
> out rx timestamp report, especially after a process turns on
> netstamp_needed_key which can time stamp every incoming skb.
> 
> Previously, We found out if an application starts first which turns on
> netstamp_needed_key, then another one only passing SOF_TIMESTAMPING_SOFTWARE
> could also get rx timestamp. Now we handle this case by introducing this
> new flag without breaking users.
> 
> In this way, we have two kinds of combination:
> 1. setting SOF_TIMESTAMPING_SOFTWARE|SOF_TIMESTAMPING_RX_SOFTWARE, it
> will surely allow users to get the rx timestamp report.
> 2. setting SOF_TIMESTAMPING_SOFTWARE|SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER
> while the skb is timestamped, it will stop reporting the rx timestamp.

The one point this commit does not explain is why a process would want
to request software timestamp reporting, but not receive software
timestamp generation. The only use I see is when the application does
request SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE.
 
> Another thing about errqueue in this patch I have a few words to say:
> In this case, we need to handle the egress path carefully, or else
> reporting the tx timestamp will fail. Egress path and ingress path will
> finally call sock_recv_timestamp(). We have to distinguish them.
> Errqueue is a good indicator to reflect the flow direction.

Good find on skb_is_err_queue rather than open-coding PACKET_OUTGOING.

> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> 1. Willem suggested this alternative way to solve the issue, so I
> added his Suggested-by tag here. Thanks!
> ---
>  Documentation/networking/timestamping.rst | 12 ++++++++++++
>  include/uapi/linux/net_tstamp.h           |  3 ++-
>  net/core/sock.c                           |  4 ++++
>  net/ethtool/common.c                      |  1 +
>  net/ipv4/tcp.c                            |  7 +++++--
>  net/socket.c                              |  5 ++++-
>  6 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
> index 5e93cd71f99f..ef2a334d373e 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -266,6 +266,18 @@ SOF_TIMESTAMPING_OPT_TX_SWHW:
>    two separate messages will be looped to the socket's error queue,
>    each containing just one timestamp.
>  
> +SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER:
> +  Used in the receive software timestamp. Enabling the flag along with
> +  SOF_TIMESTAMPING_SOFTWARE will not report the rx timestamp to the
> +  userspace so that it can filter out the case where one process starts
> +  first which turns on netstamp_needed_key through setting generation
> +  flags like SOF_TIMESTAMPING_RX_SOFTWARE, then another one only passing
> +  SOF_TIMESTAMPING_SOFTWARE report flag could also get the rx timestamp.
> +
> +  SOF_TIMESTAMPING_OPT_RX_SOFTWARE_FILTER prevents the application from
> +  being influenced by others and let the application finally choose
> +  whether to report the timestamp in the receive path or not.
> +

nit, so no need to revise, but for next time:

Documentation should describe the current state, not a history of
changes (log), so wording like "finally" does not belong.


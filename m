Return-Path: <netdev+bounces-123317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2E296481F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DFA51F21245
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1071AE86C;
	Thu, 29 Aug 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nrj9J1mB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E41AED5D
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941270; cv=none; b=sLJbmkzLvm5UAuostyEQclUx+cVF/5VpbGZ6d8g/iZsD6lgBY9fAv3WZjVpzMNfXz+oGW7hdwoycujJlO/atrDqLAfc0RdGRaw4j37eVE2lX2TzAiEEvyNypJI/4GkxxYdf0gpmOF/dO989kqX/5q8AZExlpJKNCnkFx0DiLBkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941270; c=relaxed/simple;
	bh=rY92NaB3IEQufhIbuggha/WY2ONDWaf2dJeq0CH+Kyo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pJIKz2DB9axOn7SXYmSobsRMwMTuCOzqIWl+cF4WKO/ab2W+M1zVwKV88+p0pYoP9T4p90wpIXZxWPLvjRa0vuQml+CI0BDxQ4dI3mc2PVftFU22J3kpV4tFy7of84jjFhItH6hktaL3pdyh6jEgotuje0h6/hoP/XMk3cz5m8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nrj9J1mB; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a80511d124so40058185a.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 07:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724941267; x=1725546067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTyleNQXNts2lEgbMY/wuxS9ecKaluVvjjBQna3jpSU=;
        b=Nrj9J1mB3YZwapvx6G4nv0nzi6AFTFbsD988OkyX3itnZuQjT2uAN9u2Yx0Tif7OQD
         ePmMTbdDvb7AK0NweTM4lW5aHVKAtzfslYWPulYoyaARLF7Qw538sOu8/HhP3evTwCgh
         Ls2/O8WGp6J7Mb33/9KFqanvF1Xv7Bp3rfFom7tEBxLsYyNcgc7qdCcUF53kHmN35R9z
         kwoH0AXgHQwBIfLMnCGrl7fC4VrDjIcIuw+6HQO7ItdUPd17dMTZaApjFtoGaTYUEIW4
         f1kyAw1G3NrqhU5Yao5eXxmo/fK9nR0zdpbUZ59mFAaMKFwQcjA54HoEPddWm0B119mY
         9vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941267; x=1725546067;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PTyleNQXNts2lEgbMY/wuxS9ecKaluVvjjBQna3jpSU=;
        b=X1MrEOyOeLP+Uf11Rwh+fRdum+O3y3a7XKPObhK8omYgjX3Advu8qLtRu+Pk0YUEQL
         hb5GV+gwbeVwJWabmya3yFGTiya7HvlVvYs10+wX+wFOyzzAdF3WjmE4HMHu8zQICMCI
         V751/Jxz2MF9U7/Gk9SpsSw934T18N/c4iX73XI1KDZLcDLo60Nx1hDUB4hWpv19axdu
         NhC9iKmWlExKizCSmrDBzAIxvWn9S8gNGuk/GvhrTCFl62y+74WDLvTxnlRRMw93om0v
         bo9/seDzbYtFoog+PDt0ev8BDjrDXBq6IapBRT07YhuFluUXkOmN/f3ipn//n26KyeA8
         4PYw==
X-Gm-Message-State: AOJu0YwuzA8IfillfwwJrfgSdhIi4GhoXICnOk29AIJKw2g+dYnHOrBB
	D+x9ocBCoKrT9hbqdipRaJM4gRow/uRKox/bZ9dS80jUKmaFKH+7xKOA+A==
X-Google-Smtp-Source: AGHT+IGP6WKWFJrj0QakZQTH1ZdWNEKE6vPnVIQq9u2UZU+L7SoInKyBCYJIvxlOvcOmZHGbIoBvRA==
X-Received: by 2002:a05:6214:3185:b0:6b0:7f0c:d30e with SMTP id 6a1803df08f44-6c33e615c62mr35593406d6.10.1724941267246;
        Thu, 29 Aug 2024 07:21:07 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340bfa6c5sm5541866d6.8.2024.08.29.07.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:21:06 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:21:06 -0400
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
Message-ID: <66d083d24aa8c_3895fa294d5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240828160145.68805-3-kerneljasonxing@gmail.com>
References: <20240828160145.68805-1-kerneljasonxing@gmail.com>
 <20240828160145.68805-3-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2 2/2] net: make SOF_TIMESTAMPING_RX_SOFTWARE
 feature per socket
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
> Like the previous patch in this series, we need to make sure that
> we both set SOF_TIMESTAMPING_SOFTWARE and SOF_TIMESTAMPING_RX_SOFTWARE
> flags together so that we can let the user parse the rx timestamp.
> 
> One more important and special thing is that we should take care of
> errqueue recv path because we rely on errqueue to get our timestamps
> for sendmsg(). Or else, If the user wants to read when setting
> SOF_TIMESTAMPING_TX_ACK, something like this, we cannot get timestamps,
> for example, in TCP case. So we should consider those
> SOF_TIMESTAMPING_TX_* flags.
> 
> After this patch, we are able to pass the testcase 6 for IP and UDP
> cases when running ./rxtimestamp binary.
> 
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  Documentation/networking/timestamping.rst |  7 +++++++
>  include/net/sock.h                        |  7 ++++---
>  net/bluetooth/hci_sock.c                  |  4 ++--
>  net/core/sock.c                           |  2 +-
>  net/ipv4/ip_sockglue.c                    |  2 +-
>  net/ipv4/ping.c                           |  2 +-
>  net/ipv6/datagram.c                       |  4 ++--
>  net/l2tp/l2tp_ip.c                        |  2 +-
>  net/l2tp/l2tp_ip6.c                       |  2 +-
>  net/nfc/llcp_sock.c                       |  2 +-
>  net/rxrpc/recvmsg.c                       |  2 +-
>  net/socket.c                              | 11 ++++++++---
>  net/unix/af_unix.c                        |  2 +-
>  13 files changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
> index 5e93cd71f99f..93378b78c6dd 100644
> --- a/Documentation/networking/timestamping.rst
> +++ b/Documentation/networking/timestamping.rst
> @@ -160,6 +160,13 @@ SOF_TIMESTAMPING_RAW_HARDWARE:
>    Report hardware timestamps as generated by
>    SOF_TIMESTAMPING_TX_HARDWARE when available.
>  
> +Please note: previously, if an application starts first which turns on
> +netstamp_needed_key, then another one only passing SOF_TIMESTAMPING_SOFTWARE
> +could also get rx timestamp. Now we handle this case and will not get
> +rx timestamp under this circumstance. We encourage that for each socket
> +we should use the SOF_TIMESTAMPING_RX_SOFTWARE generation flag to time
> +stamp the skb and use SOF_TIMESTAMPING_SOFTWARE report flag to tell
> +the application.

Don't mention previously. Readers will not be aware of when this
Documentation was added.

Also, nit: no "Please note". Else every paragraph can start with that,
as each statement should be noteworthy.

>  
>  1.3.3 Timestamp Options
>  ^^^^^^^^^^^^^^^^^^^^^^^
> diff --git a/include/net/sock.h b/include/net/sock.h
> index cce23ac4d514..b8535692f340 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2600,12 +2600,13 @@ static inline void sock_write_timestamp(struct sock *sk, ktime_t kt)
>  }
>  
>  void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
> -			   struct sk_buff *skb);
> +			   struct sk_buff *skb, bool errqueue);
>  void __sock_recv_wifi_status(struct msghdr *msg, struct sock *sk,
>  			     struct sk_buff *skb);

I suspect that the direction, ingress or egress, and thus whether the
timestamp is to be queued on the error queue or not, can be inferred
without exceptions from skb->pkt_type == PACKET_OUTGOING.

That would avoid all this boilerplate argument passing.


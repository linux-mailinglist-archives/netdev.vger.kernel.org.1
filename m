Return-Path: <netdev+bounces-121904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D5895F2D9
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56925282ACC
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629BA1714B4;
	Mon, 26 Aug 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFFHQ2tP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A362C95
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678695; cv=none; b=cF/FKi0efyzuwKD0AuNfbS0uyxT3Us+YaRDEfO+DejkhDJew5EHTbM32YCivgTRbcTXIs4jCtWoler7qBYIbn7gDmJEztFb5gz2CaXEmsXv6XdEqaMy3Auj8ANG5nvzqhwxfDZC7JmJdh+Ybra4qYq7z/O+PnswuwnWkQjEXPr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678695; c=relaxed/simple;
	bh=wSM+1hPEfnt2E6z5oQ/Omc0Pfn78CBKRbYchKd069+o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dODII2n32xAnc81OQ3SGMDn1Ykz9NmLxiDxSBIiB4zcNGQP5lKQ12JF48v7vW72dgyIDKKZrj27ViyY76NKM5c+49n6FVnP2zCOGe0d5P3SJeswqf4oG5XaSOGsNGuTAf8XOVMJOcZbsNJHbuLyzufPX1BR+fLlGC/hWuXNiMuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFFHQ2tP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a1d81dc0beso265079585a.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 06:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724678692; x=1725283492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8Zg7WV5fXaiKnL1BJnh+CqMjWJd1UxNRRmxApjdvdY=;
        b=AFFHQ2tPM8+t6EGqzNfOO6iixwpVoqq3Wc9aEp+mPr3W6MXWf9v6JB1eyTWAoYxXCj
         4Pdflu8V+hkIZXv+vxgsI1Z5wvEq2VJfsqdg8iAq8I4/eH+HiWMqGRRB85CqWL6NFxK3
         caTT+V+AXb62C2m2nl4Gnz0IAt+Rv/K5mSgX3cvrcx5BocUm7Cr+DwcMVjop/VuH9hXh
         WS+RBzNaAgK85rTdXWeXhrnKiMGxBb8tPaEldxVevmcnJppZrZced6/8tXlhx18t47GI
         Akvluq0uqpp90QRQWdlojAluSMfMftgPeOqIjv5NI7JA72UOL4VYPl+i5bXQeVAlgCI5
         uiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724678692; x=1725283492;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j8Zg7WV5fXaiKnL1BJnh+CqMjWJd1UxNRRmxApjdvdY=;
        b=ICYkr7zF95o5RbVLOnl4UXThSmdV+LI9dCSJ4ots9f1uxCW6CMRxRBY0iWC1SB++Yq
         fDVizv3QcZELh+87IBplIehQeg7Q1Q6HtG3eMj39UI+B/2t+NbgLcOmLoIXkeoimcL1Z
         DdmToZ4NI9d1YA8kWTPOWsF2SrUHMuD+ALt5snKZV+mDH/vpQTqzwgRbYKjExN4XDH/s
         dca6IRN3cUKynsa8f5mX2YQJkkHEUDw7hElu6g3rsBPm60T6aIGGa500uQVncOSjLMLM
         uGqDhq0devVEjShSqpoEKaD/0epcz+4rXI7YOekOGfobuUR7CeRK+4fzTCb6OHB3G8FU
         BEGw==
X-Gm-Message-State: AOJu0YwY7YDdVU5oTsbOlBTp/9f8x9Pk84lU9S/R5vyUH8Mu4Ce6IUph
	hPlVr3SgUZre6v/KbG6kVvVl6aaT5q660Py2acGoTjNGcdcYvNAk
X-Google-Smtp-Source: AGHT+IGTHixGKoL1epuwGXaYSHgTJL9zdPAQWPqCzWiuxgyXLG+D+eorpbwQLd40TUu5y3u6MquxLw==
X-Received: by 2002:a05:620a:4608:b0:795:58aa:1b57 with SMTP id af79cd13be357-7a6897b7f2bmr1124119085a.60.1724678692366;
        Mon, 26 Aug 2024 06:24:52 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f347500sm451036085a.45.2024.08.26.06.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:24:50 -0700 (PDT)
Date: Mon, 26 Aug 2024 09:24:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com
Cc: netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66cc82229bea2_261e53294fd@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240825152440.93054-2-kerneljasonxing@gmail.com>
References: <20240825152440.93054-1-kerneljasonxing@gmail.com>
 <20240825152440.93054-2-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: make SOF_TIMESTAMPING_RX_SOFTWARE
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
> Normally, if we want to record and print the rx timestamp after
> tcp_recvmsg_locked(), we must enable both SOF_TIMESTAMPING_SOFTWARE
> and SOF_TIMESTAMPING_RX_SOFTWARE flags, from which we also can notice
> through running rxtimestamp binary in selftests (see testcase 7).
> 
> However, there is one particular case that fails the selftests with
> "./rxtimestamp: Expected swtstamp to not be set." error printing in
> testcase 6.
> 
> How does it happen? When we keep running a thread starting a socket
> and set SOF_TIMESTAMPING_RX_HARDWARE option first, then running
> ./rxtimestamp, it will fail. The reason is the former thread
> switching on netstamp_needed_key that makes the feature global,
> every skb going through netif_receive_skb_list_internal() function
> will get a current timestamp in net_timestamp_check(). So the skb
> will have timestamp regardless of whether its socket option has
> SOF_TIMESTAMPING_RX_SOFTWARE or not.
> 
> After this patch, we can pass the selftest and control each socket
> as we want when using rx timestamp feature.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 8514257f4ecd..49e73d66c57d 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2235,6 +2235,7 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
>  			struct scm_timestamping_internal *tss)
>  {
>  	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
> +	u32 tsflags = READ_ONCE(sk->sk_tsflags);
>  	bool has_timestamping = false;
>  
>  	if (tss->ts[0].tv_sec || tss->ts[0].tv_nsec) {
> @@ -2274,14 +2275,19 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
>  			}
>  		}
>  
> -		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE)
> +		/* skb may contain timestamp because another socket
> +		 * turned on netstamp_needed_key which allows generate
> +		 * the timestamp. So we need to check the current socket.
> +		 */
> +		if (tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> +		    tsflags & SOF_TIMESTAMPING_RX_SOFTWARE)
>  			has_timestamping = true;
>  		else
>  			tss->ts[0] = (struct timespec64) {0};
>  	}

The current behavior is as described in
Documentation/networking/timestamping.rst:

"The socket option configures timestamp generation for individual
sk_buffs (1.3.1), timestamp reporting to the socket's error
queue (1.3.2)"

SOF_TIMESTAMPING_RX_SOFTWARE is a timestamp generation option.
SOF_TIMESTAMPING_SOFTWARE is a timestamp reporting option.

This patch changes that clearly defined behavior.

On Tx the separation between generation and reporting has value, as it
allows setting the generation on a per packet basis with SCM_TSTAMP_*.

On Rx it is more subtle, but the two are still tested at different
points in the path, and can be updated by setsockopt in between a
packet arrival and a recvmsg().

The interaction between sockets on software timestamping is a
longstanding issue. I don't think there is any urgency to change this
now. This proposed change makes the API less consistent, and may
also affect applications that depend on the current behavior.



Return-Path: <netdev+bounces-240087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD71C70579
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37D243C4C19
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A60302758;
	Wed, 19 Nov 2025 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0GwJd16";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EKL1oxTv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621BF30216F
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763571270; cv=none; b=eB9jv1stUGB8HaUMMNVu08E6nEjqXQehFJnSnr57Ig4Ufn1ljcQjqel7FFNO7Y0E7217qAJG6X2NqBQK0UYi4wcxQwx/ng6JHO9EW5Ql+zvga+LaB3v4E+YnXCE1+nGo+Ah5fzSga7SFrH/zOe7FfTrCEk9KiN//4ZAldMu6aKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763571270; c=relaxed/simple;
	bh=6Drx87rd2S6vqtLc2UQEqHu/AwZAnnmLchlU5R8QGSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaSIb9CErUqsuMugRLHae1JsOOfVo0RVrfkuT3nxjjB0ZsWOxXJw8kRKVo61b/Le7CKO4hZ5q4MvUuK6lyCf25va5gFm46ctva0OY8iKKvpYm0VOcEJXG0B6BTFw01rRJvChK3SJhKr4w/BoaPI8j45VsTCgStSIbLl7VNJLMyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P0GwJd16; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EKL1oxTv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763571267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q7i+Mz78wevuh6Uu7ucpzLg6JjFWyPkNjEckCxSDH8c=;
	b=P0GwJd169LvGmlwNclO4wxZytJ4tT6D3f5t9Lr+Zzb16uxDLWcnKjEAAH9Qbi3XTReDdxR
	vURP+QzVsKo+QC3rKmgOyZ562bozVWE8yHoLbRaJM7YfwTCGuOisjEkOSPdfcpZPAWm2ia
	NZxWRUypx10+FMoIX+3gxhzfeaBzul8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-XeSD-MLjMLm_FLk_hglrxg-1; Wed, 19 Nov 2025 11:54:26 -0500
X-MC-Unique: XeSD-MLjMLm_FLk_hglrxg-1
X-Mimecast-MFC-AGG-ID: XeSD-MLjMLm_FLk_hglrxg_1763571265
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8823acf4db3so196878726d6.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 08:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763571265; x=1764176065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q7i+Mz78wevuh6Uu7ucpzLg6JjFWyPkNjEckCxSDH8c=;
        b=EKL1oxTvBMPF4d1E8o7+uWsCzss87Y/fnc0QSjeFyelAC5YxkPLqnuXRBY0v7wU249
         BDq8dF3LF00inXB4FBwL+0qQmX2IMrG+do7UXY0HvLLw1qOwwku2T99rT3aATwgw4s5Q
         CO35znsKRIQToglojLlPzN/oGSzlUJBQBAZHentrRUjlUv1ymYJjTp/L7R7xnmZz+KSd
         ulLpQgMM5/wp2pmLYLZMXMYw6HZTRy0l91OzOzuH+pXhXefKTggdC78kXmyqWZg/H1c1
         IgTbdQfLVp5e5rhs4xKl1aU+GgyQa87B4WrDepVLmwoiM0ijfOQKrklG9xJwEr7sa1Hk
         No9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763571265; x=1764176065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7i+Mz78wevuh6Uu7ucpzLg6JjFWyPkNjEckCxSDH8c=;
        b=AGh4Oap7JgRHHMvJ3j1FBiOJ30iPp5e69zEqu2Wjxcdhq/vMbkszFClkeXsD/3ycdy
         yUTNsaIyo4Y88e2H3iM1abANaKWWfgKBPITIy+isqp1PKgqKlZcAaL8SE967y9e49fDg
         j3DF9RDdAy2cRsiw9cmJmhhU4PmK+2bF2K20os/v8ND8ML77VfT8hoIgVLCOrkwSv80O
         mFo0DHGpnwylyzgBj0oak9r5JAf+hRaZOCLwIPeVXHr+VgFazDRHgpCdTxqiUoHIFuCt
         dkfVbg3218kk/Mn66ReanJr3OtIQOLaHk74NVcdmuOCNCXhrGPGv4oY7JYoqUeJtgDp9
         ht3w==
X-Forwarded-Encrypted: i=1; AJvYcCWK0PPoBFgZZTp6t+pgBbMYwP+40vi6HYdu8jng1BqWwqOh7JE2ctzK+/pNHP+F8u5yh5n3avI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4z5J6Dmf0aORsMpYuGD8MX5BIIhf6wvhB8N5eo/GmLW63LxS3
	SI+ntDL0cxp+E2Tt51nHI8mPofQ5xjcWxqsWI+Wx4GCJ+wiJvkV4sSmqXuvmHgZThsok5QxKJG8
	GlUpc2NfnRCU89b8Kunp1jH1A0YdkrEcsvD21Zz36ToLa6m5tXK4V16PCqQ==
X-Gm-Gg: ASbGncvf7ObVnJBmY8vsnfHvWUtfsYhZRmaXXBpRuQm/aAuanG7a8aBKzAf4rf8GZZD
	Nrj1j9YIDjVhWEsM1AxTtmD2zWs6JX4tiNGAaHREcuRAEbeU1tO1xfoFKWv+38gjqglU08XR3Vl
	inv8PB/76KUSnBvyHJh6w7aJFcZ809Gg1pYqx0q8XtBvgYBnMb7wKmEZ7SNl+eIUW3fIKO7AbaZ
	ygf/2jeHIv/92yisbiIxA8/EdOyqJ2tq9FYMeaLQ5rAigg7r9mIuc/mXm5ys4hsuWSRGLsdJIAy
	BDTYPgt+ZbNAwOoi97KbTTpl+QNCmB5CIAdTJhApAlB5WHPcI02NjQIDNtcS9xOLGksupXiMR13
	QH3ZRl8CnLp9bDb4f2AVYbsziuql43qItkvSZeqcQ+jeIbGiZSNyL6pg1jCB2Ug==
X-Received: by 2002:a05:6214:2622:b0:880:3ce2:65ad with SMTP id 6a1803df08f44-88292658f3cmr303443706d6.41.1763571265440;
        Wed, 19 Nov 2025 08:54:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk44v06isDGAGdQhuvIG2e1Oku4AF/KluQ2knA4CgjrLpg1l9m1A5GTudXhBWUK9jrtvM4+Q==
X-Received: by 2002:a05:6214:2622:b0:880:3ce2:65ad with SMTP id 6a1803df08f44-88292658f3cmr303443426d6.41.1763571265033;
        Wed, 19 Nov 2025 08:54:25 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882865cff46sm139739426d6.57.2025.11.19.08.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 08:54:24 -0800 (PST)
Date: Wed, 19 Nov 2025 17:54:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	George Zhang <georgezhang@vmware.com>, Andy King <acking@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] vsock: Ignore signal/timeout on connect() if
 already established
Message-ID: <kkqegkw6zqn2nasssskzqikjvphetgd4gsgo6yi5kce2ghnwvt@6kzf3vqqgemh>
References: <20251119-vsock-interrupted-connect-v2-1-70734cf1233f@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251119-vsock-interrupted-connect-v2-1-70734cf1233f@rbox.co>

On Wed, Nov 19, 2025 at 03:02:59PM +0100, Michal Luczaj wrote:
>During connect(), acting on a signal/timeout by disconnecting an already
>established socket leads to several issues:
>
>1. connect() invoking vsock_transport_cancel_pkt() ->
>   virtio_transport_purge_skbs() may race with sendmsg() invoking
>   virtio_transport_get_credit(). This results in a permanently elevated
>   `vvs->bytes_unsent`. Which, in turn, confuses the SOCK_LINGER handling.
>
>2. connect() resetting a connected socket's state may race with socket
>   being placed in a sockmap. A disconnected socket remaining in a sockmap
>   breaks sockmap's assumptions. And gives rise to WARNs.
>
>3. connect() transitioning SS_CONNECTED -> SS_UNCONNECTED allows for a
>   transport change/drop after TCP_ESTABLISHED. Which poses a problem for
>   any simultaneous sendmsg() or connect() and may result in a
>   use-after-free/null-ptr-deref.
>
>Do not disconnect socket on signal/timeout. Keep the logic for unconnected
>sockets: they don't linger, can't be placed in a sockmap, are rejected by
>sendmsg().
>
>[1]: https://lore.kernel.org/netdev/e07fd95c-9a38-4eea-9638-133e38c2ec9b@rbox.co/
>[2]: https://lore.kernel.org/netdev/20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co/
>[3]: https://lore.kernel.org/netdev/60f1b7db-3099-4f6a-875e-af9f6ef194f6@rbox.co/
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
>Changes in v2:
>- Keep changes to minimum, fold in vsock_reset_interrupted() [Stefano]

Thanks for addressing that! LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


>- Link to v1: https://lore.kernel.org/r/20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co
>---
> net/vmw_vsock/af_vsock.c | 40 +++++++++++++++++++++++++++++++---------
> 1 file changed, 31 insertions(+), 9 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 76763247a377..a9ca9c3b87b3 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1661,18 +1661,40 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 		timeout = schedule_timeout(timeout);
> 		lock_sock(sk);
>
>-		if (signal_pending(current)) {
>-			err = sock_intr_errno(timeout);
>-			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>-			sock->state = SS_UNCONNECTED;
>-			vsock_transport_cancel_pkt(vsk);
>-			vsock_remove_connected(vsk);
>-			goto out_wait;
>-		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
>-			err = -ETIMEDOUT;
>+		/* Connection established. Whatever happens to socket once we
>+		 * release it, that's not connect()'s concern. No need to go
>+		 * into signal and timeout handling. Call it a day.
>+		 *
>+		 * Note that allowing to "reset" an already established socket
>+		 * here is racy and insecure.
>+		 */
>+		if (sk->sk_state == TCP_ESTABLISHED)
>+			break;
>+
>+		/* If connection was _not_ established and a signal/timeout came
>+		 * to be, we want the socket's state reset. User space may want
>+		 * to retry.
>+		 *
>+		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>+		 * vsock_connected_table. We keep the binding and the transport
>+		 * assigned.
>+		 */
>+		if (signal_pending(current) || timeout == 0) {
>+			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
>+
>+			/* Listener might have already responded with
>+			 * VIRTIO_VSOCK_OP_RESPONSE. Its handling expects our
>+			 * sk_state == TCP_SYN_SENT, which hereby we break.
>+			 * In such case VIRTIO_VSOCK_OP_RST will follow.
>+			 */
> 			sk->sk_state = TCP_CLOSE;
> 			sock->state = SS_UNCONNECTED;
>+
>+			/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
>+			 * transport->connect().
>+			 */
> 			vsock_transport_cancel_pkt(vsk);
>+
> 			goto out_wait;
> 		}
>
>
>---
>base-commit: 106a67494c53c56f55a2bd0757be0edb6eaa5407
>change-id: 20250815-vsock-interrupted-connect-f92dfa5042cd
>
>Best regards,
>-- 
>Michal Luczaj <mhal@rbox.co>
>



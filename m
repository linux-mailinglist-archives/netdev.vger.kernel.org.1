Return-Path: <netdev+bounces-271086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HN3I4WSwmkXfAQAu9opvQ
	(envelope-from <netdev+bounces-271086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:32:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FF13097C1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 358453036153
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384423FBEC9;
	Tue, 24 Mar 2026 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkfDCxHE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92413FBEBE
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359099; cv=none; b=iF35AKNMNXr202eJ6PAZ7RArxtQtv8CnesY2K+gBWQ/6FRzp6UDBJQsEQ/cegCB4ZY+h+UCN2fRFg0LEzE/V79tIf8FauZOso+jhXeNItGtz3butjK5rhg5rfv8rr9D7tiLZxSZ0TSZu9NiK4azknV7rf/6VlZDWYWk7XosZBbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359099; c=relaxed/simple;
	bh=5KKYSPI3rw/doEDBMB40vif9gXCUEgZMU7+a7r46+3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D68Wx+J7laIbhJuVrZWHtCZZzjz1T1r1FZM+AMPmhdNvlypce0Q+hQnRl0ZM/tNZEtjEMnYluK46aNH+CG6l2WZWePqiaEjZsWmI3NahmVAPutISal5+Nm8pPlWdlBYs54bgje3Vk7bWQQZosiLIQWnK3sRbxvCgQpgsiUuEjRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkfDCxHE; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso4298951eec.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 06:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774359096; x=1774963896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+THgERNXEixU8E55abUJWDlOXGs5Yh00bX0FGl5sGA=;
        b=jkfDCxHE2xPcfT4w+vxI5gDXqX/RpYB3kzqomLIMVh+BzqcwNsktAS2TaLaXylLVx8
         x4FxJwVHsV3lZ1pg5PCGMPhKFACQGRd/r5GYlB7GTs1+YzHZMys3zRkzJOAIOjAqMGKg
         GnN7ffqkvpD0ZVmiPcNZBuYR2mbyL927/DbWnyAwcvIiCFBwiUKBMlYAOyYh/c6BzrJi
         1/y5m9UZq/rRJ4eo/g7bU8vJ4WXgFzMX9rK0A2GEbI/kFqnYur1IU9mKL5yZ7IQD/P+K
         FCT9+Emxn8hbANFiGCwmwkYvOQNzEQ69dtblSZiU0B7Y+BaH0FnU02JvLQpE1ce1FUzF
         BwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774359096; x=1774963896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T+THgERNXEixU8E55abUJWDlOXGs5Yh00bX0FGl5sGA=;
        b=D3AaRafrUMHBzCg8S6Z7B4zCofEbuXIMrDLXnCLUtfCtk2+UHMqfsCFrMEv3To7P9E
         it4vkfYiYKSip44PP/LT6rgMCSpszxFcnPRShFGdzbfPQy0wJm4Pwf55vrM/aPQqDKTQ
         VeKbEd38Eha26hfF71KGm5jE3kDC9WGQT31ife05QajMCYh/7mHbk3I1yqh1GkYWSlSy
         qScvjihDBTonBq4uikIMEQ2wvbwVcL39wdrEbyU8QSyUwkud163Y4Fo314fW6XyXWRH3
         cXMDGQ6tGZRCboljyA9Qc188kbGWT0/Cw/mVuqy8IA0LwhI++dTGFsNo2giChkCLVFN3
         9qAA==
X-Forwarded-Encrypted: i=1; AJvYcCXYGPc8uu1puA/rzxuWQMMTVeA9B4oIHBug0ftK28lAsjF//Aa0JhzR+C+aLJfD/D2cdNJorqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBBJFIYn28liv7aFv9KBP+K99lKs9UcrqUyUWnLHhAm9hUbJpQ
	XxRk8URoHqVrfbXV6AlKVw85CkmfrblslJBBZ4MJrFmqveN7y9AV9m4k
X-Gm-Gg: ATEYQzxnYvGP4SacDQ43NAT0p+0bs71ENB+SS2B1LQZfw9ysSC6AMXDKgU1UUyzWBjQ
	UBSeQo6Ejxq/CgaAAgznhqOXHAEjhF7gXDkdeuE5Jbohrr2nwGUImJjNe0rGK11YdbmldDULu5d
	6Qew3Y0n2sOtZSEXyh3d9wzEVJ4KWkON41H2Yg16VR80S2z20BHdhZM1MGvAZako1qvnoiAZF4G
	2tl4RbUj4nK5ayzROR61Vk/ynyF9u2Jz38vbu/hqUd/dGDmPicEIY0L8Fi5MHb5IpG3Mhx8Byxw
	ybqG7I2pvUsreXLfjUU4RqYVI1gzHgO8IcysyWsAQ6YH9ASQEorH3getc4/ak3ORQEnDGIm+aQc
	Dc0u4Yb4gmIRTzKAXq6JwzD4ghWvpitwUpK35oajNRJsbqDWZdTa3ohenF3q3iRuntaHvDvhbhs
	NDIv8qPRODpvsVPpzu1nPPG986nPuXwJOGyb5b
X-Received: by 2002:a05:7300:80c2:b0:2a4:701a:b9ba with SMTP id 5a478bee46e88-2c14b52e935mr1425760eec.14.1774359095222;
        Tue, 24 Mar 2026 06:31:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17a7c1sm15469884eec.7.2026.03.24.06.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:31:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 24 Mar 2026 06:31:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net 5/5] nfc: rawsock: cancel tx_work before socket
 teardown
Message-ID: <a5c1322d-4a24-4919-92c8-27351a58b692@roeck-us.net>
References: <20260303162346.2071888-1-kuba@kernel.org>
 <20260303162346.2071888-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303162346.2071888-6-kuba@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271086-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,roeck-us.net:mid]
X-Rspamd-Queue-Id: 33FF13097C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, Mar 03, 2026 at 08:23:45AM -0800, Jakub Kicinski wrote:
> In rawsock_release(), cancel any pending tx_work and purge the write
> queue before orphaning the socket.  rawsock_tx_work runs on the system
> workqueue and calls nfc_data_exchange which dereferences the NCI
> device.  Without synchronization, tx_work can race with socket and
> device teardown when a process is killed (e.g. by SIGKILL), leading
> to use-after-free or leaked references.
> 
> Set SEND_SHUTDOWN first so that if tx_work is already running it will
> see the flag and skip transmitting, then use cancel_work_sync to wait
> for any in-progress execution to finish, and finally purge any
> remaining queued skbs.
> 
> Fixes: 23b7869c0fd0 ("NFC: add the NFC socket raw protocol")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/nfc/rawsock.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
> index b049022399ae..f7d7a599fade 100644
> --- a/net/nfc/rawsock.c
> +++ b/net/nfc/rawsock.c
> @@ -67,6 +67,17 @@ static int rawsock_release(struct socket *sock)
>  	if (sock->type == SOCK_RAW)
>  		nfc_sock_unlink(&raw_sk_list, sk);
>  
> +	if (sk->sk_state == TCP_ESTABLISHED) {
> +		/* Prevent rawsock_tx_work from starting new transmits and
> +		 * wait for any in-progress work to finish.  This must happen
> +		 * before the socket is orphaned to avoid a race where
> +		 * rawsock_tx_work runs after the NCI device has been freed.
> +		 */
> +		sk->sk_shutdown |= SEND_SHUTDOWN;
> +		cancel_work_sync(&nfc_rawsock(sk)->tx_work);
> +		rawsock_write_queue_purge(sk);
> +	}
> +

Google's AI agent had the following fedback on this patch:

  Does cancel_work_sync() properly wait for the asynchronous nfc_data_exchange()
  to complete?

  Since rawsock_tx_work() only initiates the exchange and then returns, the work
  item is no longer running or pending while the exchange is in flight. This
  means cancel_work_sync() might return immediately.

  > +		rawsock_write_queue_purge(sk);

  If the hardware completes the data exchange after cancel_work_sync() has
  returned, but before rawsock_write_queue_purge() empties the write queue,
  rawsock_data_exchange_complete() will see a non-empty queue and call
  schedule_work().

  Because cancel_work_sync() has already finished, this newly scheduled tx_work
  could execute after rawsock_release() has freed the socket. Can this lead
  to a use-after-free?

On top of that, I don't see how the this patch change would prevent the
problem it tries to fix if tx_work is running and has proceeded beyond
the SEND_SHUTDOWN check.

My apologies if this is all just noise. If so, please let me know what is
wrong with the analysis to help improve the agent.

Thanks,
Guenter


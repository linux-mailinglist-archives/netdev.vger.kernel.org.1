Return-Path: <netdev+bounces-132867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 667999939CD
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D26B210A8
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1F918C921;
	Mon,  7 Oct 2024 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km6Ky9pB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337218A6DC;
	Mon,  7 Oct 2024 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338892; cv=none; b=N/Y36DUo1TEEa6FsIHinYoSA8jzjb6SQsD5V0yJRMgPaFeGA0xaNTNTTukYuOEiAJPQ0rSp46esxwjwxDXM1jyO/O2os42erEQsBY8lRDV2fTmDsyPmMQhfRiojBO9rGTAzddNTqvVpAUeFr/byzgGhIba2yPWaSxIws/O8igpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338892; c=relaxed/simple;
	bh=3ECBEuhf48U2edFMA9h7Lb96bV6hjLokKxsFQRKNKKQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RJ1o98KIVeL2SObnbuRwkP9iQHRd3l+fFTkZ0yD9K3hnXMn6XaToavHfsea5e0g9PG8/OHPxLsPHjChFXM/1u5PJzHLQbHoXbi9Q21xF/eOQkb9UVnI1FhAgFDqMl/4T/hzv0TRF93rNXZbV/z83eGOfx90ULvKU5p86Vv1aei0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km6Ky9pB; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4583209a17dso50266181cf.1;
        Mon, 07 Oct 2024 15:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728338890; x=1728943690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg04lJ23iOgz6RuSmNEUa30uh2UxM5AjHHkhlk0Qrzc=;
        b=Km6Ky9pBfrBMMRpEu2R+4qgwen42M2jdS0w7Oh0YanmFpSkFAEEXj6z7nGkgZRnM7F
         thIFHepeynSA+anr0EK9euy9f71UW0eqYmGPj3T8nnzMQ+4zEvqjvFRpDy0qL8jRhhsV
         GDHHnxC/p1dRFBQHfw23uxlVwjozlpf/3VZIiEPUaV6bYTjYY94BSZ2eJ+qa1EXDfpwA
         +4qqm+K9mCBpwBQDQntmappxebtUc9WZ8+wSiPMzgwfniYjtG4NotiqfE6V320Hxu04K
         N4ldvzWlGyDg10uip/drS3ilzA/bCPqhJSUZM9E2bvUoVdVycMZWgTdkUA7aIPKbaW0D
         hP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728338890; x=1728943690;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yg04lJ23iOgz6RuSmNEUa30uh2UxM5AjHHkhlk0Qrzc=;
        b=YX8AbM7hIbyS78BYIqwhFUx0FfKNDsxm614nf57bmoYF2zxBoxkA7oKEL8FZR4LyZC
         aAdIv1pgXawJ7vCn6kWJfPe78YH73NjIl2Le6UF7JUn4GD5OtltAEAu15hDEDqaDU0OF
         1pL0CyA0jjjxyKSbv4K9r8WYqtXm4fr7vU6uIqdVv6ie67FRSo9aTVQTSUh9gu+EOkV1
         oAsQNP6NMHMpqVRERXsF9lf/BESCsBCVtqO9twGhzly+eAtoJ499quIUrY8gfSKD3d8Y
         bPwXx9WCqZvm1YwOT0zIMMUsjN0Lh/cE2LpIKfnEio34jRTn2P39NJ5Y1lEMInvjqoHQ
         HA8w==
X-Forwarded-Encrypted: i=1; AJvYcCW2z6JdBeVoXnxdlT21W1pQ+Qo4u3FMLCgEjiFJABAfOE+XnR1YjIXO+vCJlzr7HCORLO4XBvNDC4NlSQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCEVztIkXWTKAOpDjP8J5KY1sMhrG14W2P9OuZirxM7wh2E+SB
	r2CozB+DUQp5wmjcuwNZ7twy47TdFzvbEKMwvAMRY+hO10mBUmcv
X-Google-Smtp-Source: AGHT+IF4AQ+u0ecJq9w8XhEPpSCaHnhId7WtWARh+ExNnI0aMpf8N9IKMN53vqZeA7sO+tKmdWOVHQ==
X-Received: by 2002:a05:622a:1b06:b0:457:21ed:bd11 with SMTP id d75a77b69052e-45d9baed4d9mr200865221cf.37.1728338889598;
        Mon, 07 Oct 2024 15:08:09 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da74e9fcdsm30450211cf.27.2024.10.07.15.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 15:08:09 -0700 (PDT)
Date: Mon, 07 Oct 2024 18:08:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gur Stavi <gur.stavi@huawei.com>, 
 Gur Stavi <gur.stavi@huawei.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <67045bc8a4d4a_1635eb2947d@willemb.c.googlers.com.notmuch>
In-Reply-To: <52a2ac061498e96e69a71e49ecb961b6a17dfff7.1728303615.git.gur.stavi@huawei.com>
References: <cover.1728303615.git.gur.stavi@huawei.com>
 <52a2ac061498e96e69a71e49ecb961b6a17dfff7.1728303615.git.gur.stavi@huawei.com>
Subject: Re: [PATCH net-next v01 1/4] af_packet: allow fanout_add when socket
 is not RUNNING
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gur Stavi wrote:
> PACKET socket can retain its fanout membership through link down and up
> and (obviously) leave a fanout while it is not RUNNING (link down).

Probably just semantics, but a socket cannot leave a fanout group.
__fanout_unlink does remove it from the fanout group on link down
(__unregister_prot_hook). But a subsequent link up will always add it
back.

> However, socket was forbidden from joining a fanout while it was not
> RUNNING.

Your change looks safe to me.

I'm trying to understand where this check came from. Originally it was
this at the start of fanout_add:

+       if (!po->running)
+               return -EINVAL;

Perhaps as indicator of this requirement

    An AF_PACKET socket must be fully bound before it tries to add itself
    to a fanout.  All AF_PACKET sockets trying to join the same fanout
    must all have the same bind settings.

Probably because for the first socket in the fanout group, the group
inherits the relevant bound fields from the socket:

                match->prot_hook.type = po->prot_hook.type;
                match->prot_hook.dev = po->prot_hook.dev;

> This patch allows PACKET socket to join fanout while not RUNNING.
> 
> Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
> ---
>  net/packet/af_packet.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index a705ec214254..c28eee7f6ce0 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1846,21 +1846,21 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
>  	err = -EINVAL;
>  
>  	spin_lock(&po->bind_lock);
> -	if (packet_sock_flag(po, PACKET_SOCK_RUNNING) &&
> -	    match->type == type &&
> +	if (match->type == type &&
>  	    match->prot_hook.type == po->prot_hook.type &&
>  	    match->prot_hook.dev == po->prot_hook.dev) {
>  		err = -ENOSPC;
>  		if (refcount_read(&match->sk_ref) < match->max_num_members) {
> -			__dev_remove_pack(&po->prot_hook);
> -
>  			/* Paired with packet_setsockopt(PACKET_FANOUT_DATA) */
>  			WRITE_ONCE(po->fanout, match);
>  
>  			po->rollover = rollover;
>  			rollover = NULL;
>  			refcount_set(&match->sk_ref, refcount_read(&match->sk_ref) + 1);
> -			__fanout_link(sk, po);
> +			if (packet_sock_flag(po, PACKET_SOCK_RUNNING)) {
> +				__dev_remove_pack(&po->prot_hook);
> +				__fanout_link(sk, po);
> +			}
>  			err = 0;
>  		}
>  	}
> -- 
> 2.45.2
> 




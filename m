Return-Path: <netdev+bounces-104815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D243090E7E7
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D825B216E4
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A96483CDE;
	Wed, 19 Jun 2024 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="iUAozCch"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86868286A
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791795; cv=none; b=h+oDEH7StWBWFn82NM1vitj0nLI0kwwE4doqgGKQv8gliz5X5ihHjn2BbnTs2mt/I/ODBf6H+Pfr2FIhmEKHEgfKleM3WNntePZyujBoiRvWd/zxVWpsl7UwnlvMg3Sy0Ac0dWU2o4PjlS4yqgtNr2iDtFSr6QTo0rfMErKJlRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791795; c=relaxed/simple;
	bh=go0N1DzsnwUSIX3tAlGUzWU5ojSNLuO8X/Rf/c9a+jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAcPdlspHqtMpM9mY2trgsodVdd++jxPJHZQOVElp0pzuvBT281dzyqa5WcLRErbHKZPaJIaEwpdTNXwj4tn3xI8+WA4SKpigDKqZVhZ/H3e8/tfldK+Ds8MQMdk5CB0GjdxZrvf4xeqm9yrK14bpWwFpgQ9X6k5vZ8dKs10LcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=iUAozCch; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4218008c613so49015815e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 03:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718791791; x=1719396591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXZz75hd5uGBGJqUsDcAFXcdIZelqwAK9ojhlaEtNmQ=;
        b=iUAozCchPYny5oL21LMOayEfJkX1bxp7BDjbF1Azf/6/hwObmNgSMahJfV0i/q8hhQ
         T1klyuFy0A3ODf7kILfMslvcpFrmIp4sz+QwUWXnnMvJaimrZwnArasg+BYYVLgcVmnF
         VRSrsw9Bd1xjhhJr7256igpvxCzW+VzJdCSJodCO5wG3fWrYcWQ/iAg68Jilg+dBwA10
         NmqwDuJcwf35aOqfIh8hdyWgqnRYZUn2WBFxI0DQlkfI4ntSTFeIRCq55F7d+n+plic+
         fJhkwAdBJe2t2lUflex9yhHgVlpn8mCqKzQTuZ7IEQxf+aOvOhcHJYIR0NU0p8+qhowv
         cFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718791791; x=1719396591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXZz75hd5uGBGJqUsDcAFXcdIZelqwAK9ojhlaEtNmQ=;
        b=ZVpBTWWdwW/Vz9yQgbsSvHMwpMtOxSPm76KW2hSLXZ1/mLNfcGnbhRolY0Q0oY7tmM
         GZGZGo8gKN3tge39OzVCUMvh3b+dSywgMRzW+0jS0jU9Kg9xCaLXm027EWZvtxDAemUn
         duzn6RSvVY+PBFKxXxsrGzSOuOjlsmolYa2G9evldU58JM2yEYxvn96ly0WqbEEdgsq7
         Q4hX2HrX/ATH93qy9m1vQzPa6K2Q+3NrsNJ1EU9v7YRcrUw3HFVV0XsP0i3gA00hgLQZ
         58FY3SG8SFg06++LLOvyZDko2WjeTrQFVsN3oozJu1HF0LJ1hJM0DF8ecgaELMh2V9K7
         xdOw==
X-Gm-Message-State: AOJu0YxSuIOjj9rD+auBaLDmfqsUnBjsM6gX3+5dbIrCU59crrIdZnnu
	GK9j8LSgzKuYBigh3R2BVjw2vT78fgl57G05GuFxj2ovCX/CjYghXorxZ9oh/zs=
X-Google-Smtp-Source: AGHT+IHFvkihrclMF2NJsgs2fSWvJrLrizWwcUSzCRuHn3PE2s5QfpEXdAaiI6uX4/l2LPecwiMxLw==
X-Received: by 2002:a05:600c:1d17:b0:424:760d:75ce with SMTP id 5b1f17b1804b1-424760d777fmr13098055e9.7.1718791790683;
        Wed, 19 Jun 2024 03:09:50 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe8fb8sm263909255e9.11.2024.06.19.03.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 03:09:50 -0700 (PDT)
Date: Wed, 19 Jun 2024 12:09:45 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <ZnKuafjQt-Y-VokM@nanopsycho.orion>
References: <20240618144456.1688998-1-jiri@resnulli.us>
 <20240618140326-mutt-send-email-mst@kernel.org>
 <ZnJwbKmy923yye0t@nanopsycho.orion>
 <20240619014938-mutt-send-email-mst@kernel.org>
 <ZnKRVS6fDNIwQDEM@nanopsycho.orion>
 <20240619041846-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619041846-mutt-send-email-mst@kernel.org>

Wed, Jun 19, 2024 at 10:23:25AM CEST, mst@redhat.com wrote:
>On Wed, Jun 19, 2024 at 10:05:41AM +0200, Jiri Pirko wrote:
>> >Oh. Right of course. Worth a comment maybe? Just to make sure
>> >we remember not to call __free_old_xmit twice in a row
>> >without reinitializing stats.
>> >Or move the initialization into __free_old_xmit to make it
>> >self-contained ..
>> 
>> Well, the initialization happens in the caller by {0}, Wouldn't
>> memset in __free_old_xmit() add an extra overhead? IDK.
>
>
>Well if I did the below the binary is a bit smaller.
>
>If you have to respin you can include it.
>If not I can submit separately.

Please send it reparately. It's should be a separate patch.

Thanks!

>
>----
>
>
>virtio-net: cleanup __free_old_xmit
>
>Two call sites of __free_old_xmit zero-initialize stats,
>doing it inside __free_old_xmit seems to make compiler's
>job a bit easier:
>
>$ size /tmp/orig/virtio_net.o 
>   text    data     bss     dec     hex filename
>  65857    3892     100   69849   110d9 /tmp/orig/virtio_net.o
>$ size /tmp/new/virtio_net.o 
>   text    data     bss     dec     hex filename
>  65760    3892     100   69752   11078 /tmp/new/virtio_net.o
>
>Couldn't measure any performance impact, unsurprizingly.
>
>Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>---
>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index 283b34d50296..c2ce8de340f7 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -383,6 +383,8 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> 	unsigned int len;
> 	void *ptr;
> 
>+	stats->bytes = stats->packets = 0;

Memset perhaps?

>+
> 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> 		++stats->packets;
> 
>@@ -828,7 +830,7 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> 
> static void free_old_xmit(struct send_queue *sq, bool in_napi)
> {
>-	struct virtnet_sq_free_stats stats = {0};
>+	struct virtnet_sq_free_stats stats;
> 
> 	__free_old_xmit(sq, in_napi, &stats);
> 
>@@ -979,7 +981,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
> 			    int n, struct xdp_frame **frames, u32 flags)
> {
> 	struct virtnet_info *vi = netdev_priv(dev);
>-	struct virtnet_sq_free_stats stats = {0};
>+	struct virtnet_sq_free_stats stats;
> 	struct receive_queue *rq = vi->rq;
> 	struct bpf_prog *xdp_prog;
> 	struct send_queue *sq;
>


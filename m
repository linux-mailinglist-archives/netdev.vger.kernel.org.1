Return-Path: <netdev+bounces-108282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844BB91EA26
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 23:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403252818F1
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B306E83CC8;
	Mon,  1 Jul 2024 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUc3Tq1E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F562AD0C
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 21:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868959; cv=none; b=JCq2l5Ia3IfqRXaepIWs8btmZOuGKlC2F0mbttZGi2FZ4X4A9prQlkVZKm/pSklJsf4ZoGONiuAJZfXHV0SgGa4Af0cpGMsgBRpkgWtWPAQveWW875hTo3Lc/twPHyNBAh4FJFHxtBdwcLcJuvpflBMeHueg2tOXekYejctRMqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868959; c=relaxed/simple;
	bh=5woUV2sBmZSZMLrqxdnTst2+rF9HUiRKC+GDtAYZ18g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XIthZ+a2ig51iwYU4FDTfbEpFxD/EEPPAxMX/MjaVz9gn7YU4k9YBEzL96GPyLYelR56+QcI1V0n8dTqvE74/2qJnLuYhOnAlJVfuLJehXuUT8f8+DvMTe8atgpg1fi3JIAW69xdSOkxro79K1WmNfTbQj8IdXl6Fhca+HsFA3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUc3Tq1E; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b501a4344bso17812016d6.3
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719868957; x=1720473757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPXx0AXX0NWuzDzQ5GVvL/19S446UJqoqNOnVGF8Vn0=;
        b=CUc3Tq1EcF8LJzvwkrYXlGTW23qxzOw3jXtg0ylynhOJzXB0exZMr1jrHDqXrj8VtD
         Yrw7Xfqq471nQ9srrpCIDAdqf/WwUMpka5XiCji/h8uwWhz5x/1m3N+y9ekJA3GtzB8v
         HaAQksEYxMucYMMfAbYNg6a3PYI8HWpOM6KKXxOvBdpl1ibJNlnjpVhtGBb10OqwYzm9
         rerGwEkbCXluYzGyZ7/ujuUARsS6IrJXuGELwMWYI4wTce5ZethRNbZvycMQu1yMwAWP
         CfnRzx3SgK8VjBTeAEAKvkL1z+XwjLeHPyPTR6LqSLyJYPRyBV2XLCSqEZxf6Fy2v505
         W4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719868957; x=1720473757;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fPXx0AXX0NWuzDzQ5GVvL/19S446UJqoqNOnVGF8Vn0=;
        b=VHuO+74xsjLoXXyDeJb7yB32anzSay89kKkgFCNpGcAc97OW37D8YRB0xcZg6NuRjO
         b+yvCBstn8EilaQaWsq4jhT3pguIkkiq2ejCK1HZUbzcEDi5eK5RvzW4SckW1C6p1GIF
         pbhPExwQxn25dvo27wJBwgxK1vUGNIo8KNT7WYMyVycFDXN1UyWk7eXq7NrLLf6rlolO
         1kTpzl9UIS79u+iJExk66vVDUfk+fD07L9dl7ix5thM/Ojx7nUEFKPFK04BVZrWlXcZ1
         T8g1uHAt5i97HVAZL2r5KFK+VWMOvD30KAmxbcLDKT4p4+qsKVHMGnioQNJdGli5sLx2
         RRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoVC1ecN91Df1qn9+UW1suot3h7fgqnr75qsAhfdfIoC6wBeWA5eOZ6llE04YwC+RJi6QMkiV4LreG3vZThS/Bj4tdjq6M
X-Gm-Message-State: AOJu0YwUN+x44OlzJ0tREsk+i0LB25yBYrDyiU1uMUJcmI5cbIWZr20v
	PtywU0WKM82uX8OIIHGF+QTzqevX9qJ59Kp7WloeB+Y8p2sNUxyO
X-Google-Smtp-Source: AGHT+IEELI289ce+wNZahx+69nLN9eE1eaT8+HF6RUOen8WsugjylIGjMTfc/FKm6borwezQZANjBQ==
X-Received: by 2002:a05:6214:300c:b0:6b5:8056:6c80 with SMTP id 6a1803df08f44-6b5b70d3928mr86602876d6.36.1719868956878;
        Mon, 01 Jul 2024 14:22:36 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e368b4dsm37001816d6.28.2024.07.01.14.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:22:36 -0700 (PDT)
Date: Mon, 01 Jul 2024 17:22:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <66831e1c3352a_46fc1294d8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240701202338.2806388-1-zijianzhang@bytedance.com>
References: <20240701202338.2806388-1-zijianzhang@bytedance.com>
Subject: Re: [PATCH] selftests: fix OOM problem in msg_zerocopy selftest
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zijianzhang@ wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>


Remember to append to PATCH net or net-next in the subject line.

Since the title has fix in it, I suppose this should go to net.

As this is a test adjustment, I don't think it should go to stable.
Still, fixes need a Fixes: tag. The below referenced commit is not the
cause. Likely that sysctl could be set to a different value to trigger
this on older kernels too.

This has likely been present since the start of the test, so

Fixes: 07b65c5b31ce ("test: add msg_zerocopy test")

> In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
> on a socket with MSG_ZEROCOPY flag, and it will recv the notifications
> until the socket is not writable. Typically, it will start the receiving
> process after around 30+ sendmsgs. However, because of the commit
> dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale") the sender is
> always writable and does not get any chance to run recv notifications.
> The selftest always exits with OUT_OF_MEMORY because the memory used by
> opt_skb exceeds the core.sysctl_optmem_max.

Regardless of how large you set this sysctl, right? It is suggested to
increase it to at least 128KB.

> We introduce "cfg_notification_limit" to force sender to receive
> notifications after some number of sendmsgs. And, notifications may not
> come in order, because of the reason we present above.

Which reason?

> We have order
> checking code managed by cfg_verbose.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> ---
>  tools/testing/selftests/net/msg_zerocopy.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
> index bdc03a2097e8..7ea5fb28c93d 100644
> --- a/tools/testing/selftests/net/msg_zerocopy.c
> +++ b/tools/testing/selftests/net/msg_zerocopy.c
> @@ -85,6 +85,7 @@ static bool cfg_rx;
>  static int  cfg_runtime_ms	= 4200;
>  static int  cfg_verbose;
>  static int  cfg_waittime_ms	= 500;
> +static int  cfg_notification_limit = 32;
>  static bool cfg_zerocopy;
>  
>  static socklen_t cfg_alen;
> @@ -95,6 +96,7 @@ static char payload[IP_MAXPACKET];
>  static long packets, bytes, completions, expected_completions;
>  static int  zerocopied = -1;
>  static uint32_t next_completion;
> +static uint32_t sends_since_notify;
>  
>  static unsigned long gettimeofday_ms(void)
>  {
> @@ -208,6 +210,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
>  		error(1, errno, "send");
>  	if (cfg_verbose && ret != len)
>  		fprintf(stderr, "send: ret=%u != %u\n", ret, len);
> +	sends_since_notify++;
>  
>  	if (len) {
>  		packets++;
> @@ -435,7 +438,7 @@ static bool do_recv_completion(int fd, int domain)
>  	/* Detect notification gaps. These should not happen often, if at all.
>  	 * Gaps can occur due to drops, reordering and retransmissions.
>  	 */
> -	if (lo != next_completion)
> +	if (cfg_verbose && lo != next_completion)
>  		fprintf(stderr, "gap: %u..%u does not append to %u\n",
>  			lo, hi, next_completion);
>  	next_completion = hi + 1;
> @@ -460,6 +463,7 @@ static bool do_recv_completion(int fd, int domain)
>  static void do_recv_completions(int fd, int domain)
>  {
>  	while (do_recv_completion(fd, domain)) {}
> +	sends_since_notify = 0;
>  }
>  
>  /* Wait for all remaining completions on the errqueue */
> @@ -549,6 +553,9 @@ static void do_tx(int domain, int type, int protocol)
>  		else
>  			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
>  
> +		if (cfg_zerocopy && sends_since_notify >= cfg_notification_limit)
> +			do_recv_completions(fd, domain);
> +
>  		while (!do_poll(fd, POLLOUT)) {
>  			if (cfg_zerocopy)
>  				do_recv_completions(fd, domain);
> @@ -708,7 +715,7 @@ static void parse_opts(int argc, char **argv)
>  
>  	cfg_payload_len = max_payload_len;
>  
> -	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vz")) != -1) {
> +	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
>  		switch (c) {
>  		case '4':
>  			if (cfg_family != PF_UNSPEC)
> @@ -736,6 +743,9 @@ static void parse_opts(int argc, char **argv)
>  			if (cfg_ifindex == 0)
>  				error(1, errno, "invalid iface: %s", optarg);
>  			break;
> +		case 'l':
> +			cfg_notification_limit = strtoul(optarg, NULL, 0);
> +			break;
>  		case 'm':
>  			cfg_cork_mixed = true;
>  			break;
> -- 
> 2.20.1
> 




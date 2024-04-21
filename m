Return-Path: <netdev+bounces-89870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FF08ABFAF
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4ACB1F20CD4
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 15:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8221918637;
	Sun, 21 Apr 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvaIa6cE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9D73D66
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713712613; cv=none; b=jp1kcmRDIs2S9qQCmiN1yLF2+ItWpTaIuPT1FQgyDZpMy/i8JLygy5unsaidEDagxYZjQKEVI/lKN7ZJiTyuRrmCKh66mV/QNACYKfdtctgcxjwI027miEEkYMqZPsafJ2qcbgSTqevLQNjGhEjl3Mg/c8ZM8PTRgvfofsy/NXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713712613; c=relaxed/simple;
	bh=Bm/AqqVjb17cdjP7A5m+0tRsSmPs3IP2OLdehtGl8xk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hIsvOZRTgttDt7GBgK28O4vIdHMwIbHPOgu0ZMaT0E15j9KZMav46ntGAEhZ72emYX3jM+cqu+ECcOQkaMEghUDlhW3iOYqGrvTNr/wLpjwVggpBBd2xFi+Eq+TEVdioAdtMyIZGJjpgvHDFozoxta/SZ6XG0SOO2fN6utLNGjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvaIa6cE; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6eb812370a5so2237079a34.0
        for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 08:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713712611; x=1714317411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuyFGTDOYZW56VQL9IA9goKb4P91MHv7Uue6IbRJ6SI=;
        b=GvaIa6cExXGyALCn296ksx4mOY/cgbcZggV4qX26L/VLNeLEC+7lJt1dImxei8MeQ2
         ULWJaPuqOaEpR+Duft5W31BTBn0k9qkuVpfzaN8JTpLLvPCoywU9P+Wc7g2drOTT3BZt
         HXsvvJEStHEwhdtPg88ZN7zg0ecAuc5zhlZHN59aSkPFgvNWuC8AafO4I9fBtXUogODL
         or4chxYX9liJE0nND/VXymnV3vc62zePElxNBCl6Z+m/A8JrhWeVMxe19wU+fHYA3Scl
         rMwWjtfWiNla8tmqQX2jZu1erDd9F0HxFQ7n/WtZgltsFE2nvk/WnZUgEN+UX/mvONlw
         2VNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713712611; x=1714317411;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JuyFGTDOYZW56VQL9IA9goKb4P91MHv7Uue6IbRJ6SI=;
        b=WCzmFymD30659gNxUjl2Z5Jr/Z9VsJhxjhYTrMeHcudYE/a1yClIUXI6IBwOve6h50
         IE2Xze0v/705v5ATkyfvTABjPXZhi0sh2xHlDNsthw+b7YBZlY4ldcwGBQfv2tRjFHij
         HOhZiK7ZpclCDdsFouWkOwVUAiSd3HxD14OkE0POWIayLc5J20S3Y3ZCslOfUX0Uba/v
         70cSP7kbZhgBMNXzQL/s/zH9VIFiGrGQoTUasfeyWIY4m/ggRZv9YTJ+tayllmZtpPUg
         vOg7J94pODgjbrIanuG+DnR2NzITWozKnbrTAgB6hWjx3+yDDoasX3MeTw6cOheFygJi
         HHIA==
X-Forwarded-Encrypted: i=1; AJvYcCUCZSUEyQr87KNRE9ltCFOEgefriVNrZJ7Kkdr57pwiiW2xF69DAa+NwRYJMpGu98u5M26ueKJ/z0xAgInAMmnf3BwOiQai
X-Gm-Message-State: AOJu0YxWyoFPA+EbDstpSE3pI8T06vcPtlpbzl8ExY+UoEuMtmqBYjcA
	G7l7tFEf/52PSBa2cJP1/bS2l7QCiUymL156aHX++IPheoz/DegA
X-Google-Smtp-Source: AGHT+IELUPNFYNIESlMwH8ljHmCzLK/RIXB3XIscuODrYv6E73uW3y6kitJhS1WMHEksWiIbUAI+Fw==
X-Received: by 2002:a05:6870:8e06:b0:22e:c405:ec76 with SMTP id lw6-20020a0568708e0600b0022ec405ec76mr11396709oab.20.1713712610888;
        Sun, 21 Apr 2024 08:16:50 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id y12-20020a05620a09cc00b0078d4732d92fsm3431856qky.115.2024.04.21.08.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 08:16:50 -0700 (PDT)
Date: Sun, 21 Apr 2024 11:16:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zijianzhang@bytedance.com, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com, 
 Zijian Zhang <zijianzhang@bytedance.com>
Message-ID: <66252de247122_1dff992949f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240419214819.671536-2-zijianzhang@bytedance.com>
References: <20240419214819.671536-1-zijianzhang@bytedance.com>
 <20240419214819.671536-2-zijianzhang@bytedance.com>
Subject: Re: [PATCH net-next v2 1/3] selftests: fix OOM problem in
 msg_zerocopy selftest
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
> 
> In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
> on a socket with MSG_ZEROCOPY flag, and it will recv the notifications
> until the socket is not writable. Typically, it will start the receiving
> process after around 30+ sendmsgs. However, because of the
> commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> the sender is always writable and does not get any chance to run recv
> notifications. The selftest always exits with OUT_OF_MEMORY because the
> memory used by opt_skb exceeds the core.sysctl_optmem_max.
> 
> According to our experiments, this problem can be solved by open the
> DEBUG_LOCKDEP configuration for the kernel.

Not so much solved, as mitigated. 

> But it will makes the
> notificatoins disordered even in good commits before

typo: notifications

We still have no explanation for this behavior, right. OOO
notifications for TCP should be extremely rare.

A completion is queued when both the skb with the send() data was sent
and freed, and the ACK arrived, freeing the clone on the retransmit
queue. This is almost certainly some effect of running over loopback.

OOO being rare is also what makes the notification batch mechanism so
effective for TCP.

> commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale").
> 
> We introduce "cfg_notification_limit" to force sender to receive
> notifications after some number of sendmsgs. And, notifications may not
> come in order, because of the reason we present above. We have order
> checking code managed by cfg_verbose.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> ---
>  tools/testing/selftests/net/msg_zerocopy.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
> index bdc03a2097e8..6c18b07cab30 100644
> --- a/tools/testing/selftests/net/msg_zerocopy.c
> +++ b/tools/testing/selftests/net/msg_zerocopy.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /* Evaluate MSG_ZEROCOPY
>   *
>   * Send traffic between two processes over one of the supported
> @@ -85,6 +86,7 @@ static bool cfg_rx;
>  static int  cfg_runtime_ms	= 4200;
>  static int  cfg_verbose;
>  static int  cfg_waittime_ms	= 500;
> +static int  cfg_notification_limit = 32;
>  static bool cfg_zerocopy;
>  
>  static socklen_t cfg_alen;
> @@ -95,6 +97,8 @@ static char payload[IP_MAXPACKET];
>  static long packets, bytes, completions, expected_completions;
>  static int  zerocopied = -1;
>  static uint32_t next_completion;
> +/* The number of sendmsgs which have not received notified yet */
> +static uint32_t sendmsg_counter;
>  
>  static unsigned long gettimeofday_ms(void)
>  {
> @@ -208,6 +212,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
>  		error(1, errno, "send");
>  	if (cfg_verbose && ret != len)
>  		fprintf(stderr, "send: ret=%u != %u\n", ret, len);
> +	sendmsg_counter++;
>  
>  	if (len) {
>  		packets++;
> @@ -435,7 +440,7 @@ static bool do_recv_completion(int fd, int domain)
>  	/* Detect notification gaps. These should not happen often, if at all.
>  	 * Gaps can occur due to drops, reordering and retransmissions.
>  	 */
> -	if (lo != next_completion)
> +	if (cfg_verbose && lo != next_completion)
>  		fprintf(stderr, "gap: %u..%u does not append to %u\n",
>  			lo, hi, next_completion);
>  	next_completion = hi + 1;
> @@ -460,6 +465,7 @@ static bool do_recv_completion(int fd, int domain)
>  static void do_recv_completions(int fd, int domain)
>  {
>  	while (do_recv_completion(fd, domain)) {}
> +	sendmsg_counter = 0;
>  }
>  
>  /* Wait for all remaining completions on the errqueue */
> @@ -549,6 +555,9 @@ static void do_tx(int domain, int type, int protocol)
>  		else
>  			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
>  
> +		if (cfg_zerocopy && sendmsg_counter >= cfg_notification_limit)
> +			do_recv_completions(fd, domain);
> +
>  		while (!do_poll(fd, POLLOUT)) {
>  			if (cfg_zerocopy)
>  				do_recv_completions(fd, domain);
> @@ -708,7 +717,7 @@ static void parse_opts(int argc, char **argv)
>  
>  	cfg_payload_len = max_payload_len;
>  
> -	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vz")) != -1) {
> +	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vzl:n")) != -1) {

no n defined

please keep lexicographic order
>  		switch (c) {
>  		case '4':
>  			if (cfg_family != PF_UNSPEC)
> @@ -760,6 +769,9 @@ static void parse_opts(int argc, char **argv)
>  		case 'z':
>  			cfg_zerocopy = true;
>  			break;
> +		case 'l':
> +			cfg_notification_limit = strtoul(optarg, NULL, 0);
> +			break;
>  		}
>  	}
>  
> -- 
> 2.20.1
> 




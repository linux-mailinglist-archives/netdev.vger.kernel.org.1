Return-Path: <netdev+bounces-277717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JLyESyg2mnR4QgAu9opvQ
	(envelope-from <netdev+bounces-277717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 21:25:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B07713E17F4
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 21:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B19430D6008
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 19:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093223B893B;
	Sat, 11 Apr 2026 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yu2gl6sh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F77A3019D9
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935139; cv=none; b=NVSk4uea8Hafy2DWu/FbE7Lk3/6+8l9vlz27fZlonWIDhzuZxCN4zUrlHvuAPGTmr0sVnw+VQf0IKnava0cuEz7VRBCocbg9auXPSzjbmdNKlyYO/AdMQ91YWn+OQgU7tdrikhADWanxtags6rHn0FgK76iedFmfY+KknrLozvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935139; c=relaxed/simple;
	bh=eZ0BuFN45RcPL2K0IR7CYqQFjGDCcw/nzXB09U6wkjg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=uWC8XFOa9a7XlfxFiolgm4k3c4grUtRHQh5m9DZM4L+SwpnsGYhoSm3Y96Fb25EI38ryL9etxd5oR0/tmnxPstJpas+GbOLvw1gN/lVjkLTGNl5A3CLXVeQCFvcDhh+Uc6dItUkOFgd915827skJr0RzKcYSy8Z+4JVpXSCtYhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yu2gl6sh; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651bf4a4140so16641d50.0
        for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775935138; x=1776539938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncsctrKFaq1ltBqZz5sBcqCO6oVkRzOBfeOocjpX6vg=;
        b=Yu2gl6sh6d5evQqd6Uasga4fE8iB76X4qDkTLCaRHemD4v/t0GBp/C3rswJhpR0McM
         nc6FN5t2zRajus5tUUtQtMgPrN8IVKyfH0h5tj0/qh5aXVrqP05DbTn7p9dCaBVJT3Te
         7+3ttedCHmBIKkVXMxGfUog28+OM534E9PNV0ta03W8ADa7RnIJcLXxyiYmfBqeHJAW3
         6IyuQfwca3BkEKMmqjisR5ltlYU60xMFZjQX6AsOauhgy5V21IeFEzIm1QtAlOTLn0Aq
         jh5o/4L8azni6DdSvxuJc69zZDso5/tjRBI3yqjkXn/aEhY6gQdgpUxTA5EYWAO5dbzL
         NlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935138; x=1776539938;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ncsctrKFaq1ltBqZz5sBcqCO6oVkRzOBfeOocjpX6vg=;
        b=JPNoaa7hZHUKUS6vZr2ZgzSgBKZsodm8T2GfTv6ERE8dWkz7Y+vKMVtCFNIrpgQTYC
         GWzrN/Sm+RR8k7FvPtD7fDEAsY89e/rJ7NkjZpTEvqMfCSDlxmnqVyBP/CD4qSxpdljq
         AIErWYw3KCQcuMMEbXxKRENTQDqMLVnTHnjT5kzNHiJyd1RAPLHNdU/4qOchkPJUJav7
         qLh+vjJfqZdQF3+qa6C0i2VAf1epxKBvSV1bCWCESQxGm+VEwT6p8VDTL3IB6/KMVT9s
         Ra/y4H8UJGbP9al8voIWIu7/178hZ+jJAEimQDXUUNrhk9b3AWU1bXdAXBDSrLEWcqLM
         247w==
X-Forwarded-Encrypted: i=1; AFNElJ8mW8th7rvSX3Q008/RUh5y6oWcIUvjheG5TVvaa665houohUyta5nnAm/lovsSQI9q3fCf2g8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ZUX6xO3EwTKmR+o9Mh9KbYORAiUHkXnXX00bIBZpjZA/47hW
	6K88w4HZAkZZlsZiXz76YMsRoRp9syWFK8Nc87PxtKK/Lyy1nvvvm8f8
X-Gm-Gg: AeBDieupBGA0H1axVN9302ZMISWfHuTc0PTZ7KGmL/7J+lYp/SUnTdgBs5QtEg5giAS
	Jcwn+FRSZgXcM9jtqAFqieBl3YZJpgj9m2rZofNsTVQDJWXW4dGGBjGKrprIalo9i7khjKIpgPv
	gLHouOhUrz9OrS2Vzb0v2LCh4HZstvMR6MgzFhQSJqTyTVynya7oNTB0ufXtqYX35IpNDB7b7QE
	EQ9d5kN22xQG4l8ZeGRvEgT79YNDwswYOYeVXaPSr0u1sl3RpQlyjH8X/3IDq/5NKgAtci+cf/X
	vMBBxV1ZUH9TIn+fXyl0J8QsHVWhznVz7jmey2jmweXJ5IuM6dMt9YdeNcZeTg7ssdLIx6qDeiU
	nzDlZuYNML8WDc2p4Ts57yrD/i1aNPs1Hqba3XgLTmbkBED4+ESILj32DQ6yV+viuSb+a2GFeFv
	+6Ied2aGjEepowpc0rJW1NvpVck+uNnV8LrLseG2pcl1oMiJZr8uNCaMt170YoNp5bXIQhDPBrD
	7xT
X-Received: by 2002:a05:690e:4382:b0:650:35fc:df2e with SMTP id 956f58d0204a3-65198a67678mr5392997d50.16.1775935137701;
        Sat, 11 Apr 2026 12:18:57 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65197c1dbd8sm3084309d50.14.2026.04.11.12.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 12:18:56 -0700 (PDT)
Date: Sat, 11 Apr 2026 15:18:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Mahesh Bandewar <maheshb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.15ccd7e646278@gmail.com>
In-Reply-To: <20260410215420.1698033-1-kuniyu@google.com>
References: <20260410215420.1698033-1-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next] selftest: net: Use port outside of the
 default ip_local_ports in csum.c.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277717-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B07713E17F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Kuniyuki Iwashima wrote:
> csum.c binds a socket on a fixed port in init_net to test
> the csum offload feature between two machines.
> 
> In our testbed, the test sometimes fails with -EADDRINUSE.
> 
>   bind r: Address already in use
>   bind dgram 6: Address already in use
> 
> The fixed ports (33000, 33001, 34000) are all within the default
> ip_local_ports range (32768 ~ 60999), and other processes may
> happen to be using them.
> 
> Let's use ports outside of the default ip_local_ports range to
> deflake the test.
> 
>   # cat /etc/services | grep -E "(13000|13001|13002)" | echo no service
>   no service
>   # rpm -qf /etc/services
>   setup-2.15.0-28.fc44.noarch
> 
> We could add an option to specify ports if needed.
>
> Suggested-by: Mahesh Bandewar <maheshb@google.com>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  tools/testing/selftests/net/lib/csum.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
> index e28884ce3ab3..4e044689bc37 100644
> --- a/tools/testing/selftests/net/lib/csum.c
> +++ b/tools/testing/selftests/net/lib/csum.c
> @@ -105,9 +105,9 @@ static char *cfg_mac_src;
>  static int cfg_proto = IPPROTO_UDP;
>  static int cfg_payload_char = 'a';
>  static int cfg_payload_len = 100;
> -static uint16_t cfg_port_dst = 34000;

This is paired with wait_port_listen(3400, .. in
tools/testing/selftests/drivers/net/hw/csum.py

It is also used in tools/testing/selftests/drivers/net/hw/tso.py,
which uses rand_port to select a port.

Probably more robust to indeed add an option to specify a port, and
in all callers use rand_port(s).

> -static uint16_t cfg_port_src = 33000;
> -static uint16_t cfg_port_src_encap = 33001;
> +static uint16_t cfg_port_dst = 13000;
> +static uint16_t cfg_port_src = 13001;
> +static uint16_t cfg_port_src_encap = 13002;
>  static unsigned int cfg_random_seed;
>  static int cfg_rcvbuf = 1 << 22;	/* be able to queue large cfg_num_pkt */
>  static bool cfg_send_pfpacket;
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 




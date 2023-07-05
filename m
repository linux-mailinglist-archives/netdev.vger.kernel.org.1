Return-Path: <netdev+bounces-15561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70904748897
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E05B28104B
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF9211CBC;
	Wed,  5 Jul 2023 15:56:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E391D528
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 15:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55A8C433C8;
	Wed,  5 Jul 2023 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688572602;
	bh=JzLAQUPDOXJPxLfN84dScm6T9CeT0pD+A8KgrxBtYWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BZqL5P9bNRDmIWANHdbs0Y80b9MbKC+yrTFdMVebedm/pm20PL9CZ0LwKXIm4fgBE
	 Y69ejPy7KVgr1RLJxDYhOZDldjmykVJcgcjjAqfr2VLew7UMacivRBrCUXBAVuRJ37
	 6By6OmYAMPL0fZne9bH2lz1javnh60vvV/zDfBmxU8M3PEKW1FR4veo3J2b+3fHeRl
	 NmBL4LnqbYUrXt1LOnj4GMoRJnqS+xI1b7aR2jkaIBN5SVJVRK95YxV5p9kzkojR4v
	 gvRMvfZLO/9i7txdy04s7yMreyCPgpD+rsZny60Kmci6MUZLFAUjL3VWWbHDJH2fco
	 iGxb/KzQB8JEg==
Date: Wed, 5 Jul 2023 08:56:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 sergey.senozhatsky@gmail.com, pmladek@suse.com, tj@kernel.or, Dave Jones
 <davej@codemonkey.org.uk>, "open list:NETWORKING DRIVERS"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netconsole: Append kernel version to message
Message-ID: <20230705085640.46ad5c2e@kernel.org>
In-Reply-To: <ZKQ/C7z2RMG5a4XN@gmail.com>
References: <20230703154155.3460313-1-leitao@debian.org>
	<20230703124427.228f7a9e@kernel.org>
	<ZKQ/C7z2RMG5a4XN@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jul 2023 08:47:23 -0700 Breno Leitao wrote:
> This is the code that does it. How does it sound?

More or less :)

> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 4f4f79532c6c..d26bd3b785c4 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -36,6 +36,7 @@
>  #include <linux/inet.h>
>  #include <linux/configfs.h>
>  #include <linux/etherdevice.h>
> +#include <linux/utsname.h>
>  
>  MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
>  MODULE_DESCRIPTION("Console driver for network interfaces");
> @@ -772,8 +773,10 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
>  	const char *header, *body;
>  	int offset = 0;
>  	int header_len, body_len;
> +	int uname_len = 0;

I'd calculate the uname_len here if the option was set.

> -	if (msg_len <= MAX_PRINT_CHUNK) {
> +	if (msg_len <= MAX_PRINT_CHUNK &&
> +	    !IS_ENABLED(CONFIG_NETCONSOLE_UNAME)) {

And then try to fold the path with uname into this. So that we don't
have to separate exit points for the "message is short enough".

>  		netpoll_send_udp(&nt->np, msg, msg_len);
>  		return;
>  	}
> @@ -788,14 +791,31 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
>  	body_len = msg_len - header_len - 1;
>  	body++;
>  
> +	if (IS_ENABLED(CONFIG_NETCONSOLE_UNAME)) {
> +		/* Add uname at the beginning of buffer */
> +		char *uname = init_utsname()->release;

nit: const

> +		/* uname_len contains the length of uname + ',' */
> +		uname_len = strlen(uname) + 1;
> +
> +		if (uname_len + msg_len < MAX_PRINT_CHUNK) {
> +			/* No fragmentation needed */
> +			scnprintf(buf, MAX_PRINT_CHUNK, "%s,%s", uname, msg);
> +			netpoll_send_udp(&nt->np, buf, uname_len + msg_len);
> +			return;
> +		}
> +
> +		/* The data will be fragment, prepending uname */
> +		scnprintf(buf, MAX_PRINT_CHUNK, "%s,", uname);
> +	}
> +
>  	/*
>  	 * Transfer multiple chunks with the following extra header.
>  	 * "ncfrag=<byte-offset>/<total-bytes>"
>  	 */
> -	memcpy(buf, header, header_len);
> +	memcpy(buf + uname_len, header, header_len);

And once done prepping I'd add uname_len to header_len

>  	while (offset < body_len) {
> -		int this_header = header_len;
> +		int this_header = header_len + uname_len;

Last but not least, I do agree with Stephen that this can be
configurable with sysfs at runtime, no need to make it a Kconfig.


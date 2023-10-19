Return-Path: <netdev+bounces-42634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EAF7CFA62
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF4C3B20CE5
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A73225CE;
	Thu, 19 Oct 2023 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bO3RlvNH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7jE69Kg0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52C1A290
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 13:06:42 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827E0F7
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:06:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D7E3321A36;
	Thu, 19 Oct 2023 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1697720799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irXw/srMeT+dYH+sp8YCsw3fD667aRO7MSm4VAMh0KU=;
	b=bO3RlvNHdOFrvQIEcdtueZclxNcDDpm/nR4X05B+mskqkGusTm19j26wp4cTqP2HvY9UzE
	LK8rRTPaQhCZmN/r2VGb7+Dp+0qKgTZloKWzc2xH9J0RakaXMPk/nssI4+oHs7rqnR51Kt
	I8x8TRvYxG9HB/ReTI39Kj6vlHTHiQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1697720799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irXw/srMeT+dYH+sp8YCsw3fD667aRO7MSm4VAMh0KU=;
	b=7jE69Kg0jnb0P56ITn/A8+Hs8W8ZZtHSn3qwsxIGfoM35esuEjrmLv0W5kzxLsha+15NJg
	ZO28JdHZJNXG0AAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C80D01357F;
	Thu, 19 Oct 2023 13:06:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XstMMN8pMWUnVAAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 19 Oct 2023 13:06:39 +0000
Message-ID: <15f85fca-54bc-46c6-b016-0d1761052fe4@suse.de>
Date: Thu, 19 Oct 2023 15:06:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/handshake: fix file ref count in
 handshake_nl_accept_doit()
Content-Language: en-US
To: =?UTF-8?Q?Moritz_Wanzenb=C3=B6ck?= <moritz.wanzenboeck@linbit.com>,
 netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Cc: chuck.lever@oracle.com
References: <20231019125847.276443-1-moritz.wanzenboeck@linbit.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231019125847.276443-1-moritz.wanzenboeck@linbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -7.09
X-Spamd-Result: default: False [-7.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]

On 10/19/23 14:58, Moritz Wanzenböck wrote:
> If req->hr_proto->hp_accept() fail, we call fput() twice:
> Once in the error path, but also a second time because sock->file
> is at that point already associated with the file descriptor. Once
> the task exits, as it would probably do after receiving an error
> reading from netlink, the fd is closed, calling fput() a second time.
> 
> To fix, we move installing the file after the error path for the
> hp_accept() call. In the case of errors we simply put the unused fd.
> In case of success we can use fd_install() to link the sock->file
> to the reserved fd.
> 
> Fixes: 7ea9c1ec66bc ("net/handshake: Fix handshake_dup() ref counting")
> Signed-off-by: Moritz Wanzenböck <moritz.wanzenboeck@linbit.com>
> ---
>   net/handshake/netlink.c | 30 +++++-------------------------
>   1 file changed, 5 insertions(+), 25 deletions(-)
> 
> diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
> index 64a0046dd611..89637e732866 100644
> --- a/net/handshake/netlink.c
> +++ b/net/handshake/netlink.c
> @@ -87,29 +87,6 @@ struct nlmsghdr *handshake_genl_put(struct sk_buff *msg,
>   }
>   EXPORT_SYMBOL(handshake_genl_put);
>   
> -/*
> - * dup() a kernel socket for use as a user space file descriptor
> - * in the current process. The kernel socket must have an
> - * instatiated struct file.
> - *
> - * Implicit argument: "current()"
> - */
> -static int handshake_dup(struct socket *sock)
> -{
> -	struct file *file;
> -	int newfd;
> -
> -	file = get_file(sock->file);
> -	newfd = get_unused_fd_flags(O_CLOEXEC);
> -	if (newfd < 0) {
> -		fput(file);
> -		return newfd;
> -	}
> -
> -	fd_install(newfd, file);
> -	return newfd;
> -}
> -
>   int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
>   {
>   	struct net *net = sock_net(skb->sk);
> @@ -133,17 +110,20 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
>   		goto out_status;
>   
>   	sock = req->hr_sk->sk_socket;
> -	fd = handshake_dup(sock);
> +	fd = get_unused_fd_flags(O_CLOEXEC);
>   	if (fd < 0) {
>   		err = fd;
>   		goto out_complete;
>   	}
> +
>   	err = req->hr_proto->hp_accept(req, info, fd);
>   	if (err) {
> -		fput(sock->file);
> +		put_unused_fd(fd);
>   		goto out_complete;
>   	}
>   
> +	fd_install(fd, get_file(sock->file));
> +
>   	trace_handshake_cmd_accept(net, req, req->hr_sk, fd);
>   	return 0;
>   
??
You sure this works?
With this patch 'fd' won't be available during the 'hp_accept' call,
but I thought that we might want to read from the socket here.
Hmm?

Cheers,

Hannes



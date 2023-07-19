Return-Path: <netdev+bounces-18885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68F3758F6B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75BD1C20C60
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9273CD2EA;
	Wed, 19 Jul 2023 07:47:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87643C8F0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:47:17 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA281736
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:47:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 715D91F8C3;
	Wed, 19 Jul 2023 07:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689752834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZSKyZsi6Ba56vSUwXobHwRYULrUvaiDeyAzsnSksaE=;
	b=HG5nDqx9hJAGsP0OU4csa4qzZU/eAXE44YC668tM6mU3LFXiuCeEnN3TiuX505u2PW5fEe
	r0xSj+PYKBSZvEt6tf7do9nEF8G0or+K1/gBH2IHrt7ync2/2RjrJ2Y0nslVehnFsGyTsg
	CGj64UUVgNO5yhsCYn2RZC8ZigYb66E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689752834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZSKyZsi6Ba56vSUwXobHwRYULrUvaiDeyAzsnSksaE=;
	b=F1IIJVatA0SmWKQxYRtFrUJCM6avimgdstOc3lFOWdfO9ihLi39XlQ89f1g/P2ilMCVLy5
	1G192rOTyN6sYuCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5389713460;
	Wed, 19 Jul 2023 07:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id plu1EgKVt2SYZgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 19 Jul 2023 07:47:14 +0000
Message-ID: <6dc3e2ec-fa9d-32c5-1d44-023d366d329e@suse.de>
Date: Wed, 19 Jul 2023 09:47:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v1 3/7] net/handshake: Add API for sending TLS
 Closure alerts
Content-Language: en-US
To: Chuck Lever <cel@kernel.org>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
References: <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
 <168970680139.5330.16891764300979182957.stgit@oracle-102.nfsv4bat.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <168970680139.5330.16891764300979182957.stgit@oracle-102.nfsv4bat.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/18/23 21:00, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> This helper sends an alert only if a TLS session was established.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   include/net/handshake.h   |    1 +
>   net/handshake/Makefile    |    2 +
>   net/handshake/alert.c     |   62 +++++++++++++++++++++++++++++++++++++++++++++
>   net/handshake/handshake.h |    4 +++
>   net/handshake/tlshd.c     |   23 +++++++++++++++++
>   5 files changed, 91 insertions(+), 1 deletion(-)
>   create mode 100644 net/handshake/alert.c
> 
> diff --git a/include/net/handshake.h b/include/net/handshake.h
> index 2e26e436e85f..bb88dfa6e3c9 100644
> --- a/include/net/handshake.h
> +++ b/include/net/handshake.h
> @@ -40,5 +40,6 @@ int tls_server_hello_x509(const struct tls_handshake_args *args, gfp_t flags);
>   int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
>   
>   bool tls_handshake_cancel(struct sock *sk);
> +void tls_handshake_close(struct socket *sock);
>   
>   #endif /* _NET_HANDSHAKE_H */
> diff --git a/net/handshake/Makefile b/net/handshake/Makefile
> index 247d73c6ff6e..ef4d9a2112bd 100644
> --- a/net/handshake/Makefile
> +++ b/net/handshake/Makefile
> @@ -8,6 +8,6 @@
>   #
>   
>   obj-y += handshake.o
> -handshake-y := genl.o netlink.o request.o tlshd.o trace.o
> +handshake-y := alert.o genl.o netlink.o request.o tlshd.o trace.o
>   
>   obj-$(CONFIG_NET_HANDSHAKE_KUNIT_TEST) += handshake-test.o
> diff --git a/net/handshake/alert.c b/net/handshake/alert.c
> new file mode 100644
> index 000000000000..999d3ffaf3e3
> --- /dev/null
> +++ b/net/handshake/alert.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Handle the TLS Alert protocol
> + *
> + * Author: Chuck Lever <chuck.lever@oracle.com>
> + *
> + * Copyright (c) 2023, Oracle and/or its affiliates.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/socket.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/skbuff.h>
> +#include <linux/inet.h>
> +
> +#include <net/sock.h>
> +#include <net/handshake.h>
> +#include <net/genetlink.h>
> +#include <net/tls.h>
> +#include <net/tls_prot.h>
> +
> +#include "handshake.h"
> +
> +/**
> + * tls_alert_send - send a TLS Alert on a kTLS socket
> + * @sock: open kTLS socket to send on
> + * @level: TLS Alert level
> + * @description: TLS Alert description
> + *
> + * Returns zero on success or a negative errno.
> + */
> +int tls_alert_send(struct socket *sock, u8 level, u8 description)
> +{
> +	u8 record_type = TLS_RECORD_TYPE_ALERT;
> +	u8 buf[CMSG_SPACE(sizeof(record_type))];
> +	struct msghdr msg = { 0 };
> +	struct cmsghdr *cmsg;
> +	struct kvec iov;
> +	u8 alert[2];
> +	int ret;
> +
> +	alert[0] = level;
> +	alert[1] = description;
> +	iov.iov_base = alert;
> +	iov.iov_len = sizeof(alert);
> +
> +	memset(buf, 0, sizeof(buf));
> +	msg.msg_control = buf;
> +	msg.msg_controllen = sizeof(buf);
> +	msg.msg_flags = MSG_DONTWAIT;
> +
> +	cmsg = CMSG_FIRSTHDR(&msg);
> +	cmsg->cmsg_level = SOL_TLS;
> +	cmsg->cmsg_type = TLS_SET_RECORD_TYPE;
> +	cmsg->cmsg_len = CMSG_LEN(sizeof(record_type));
> +	memcpy(CMSG_DATA(cmsg), &record_type, sizeof(record_type));
> +
> +	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, iov.iov_len);
> +	ret = sock_sendmsg(sock, &msg);
> +	return ret < 0 ? ret : 0;
> +}
> diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
> index 4dac965c99df..af1633d5ad73 100644
> --- a/net/handshake/handshake.h
> +++ b/net/handshake/handshake.h
> @@ -41,6 +41,7 @@ struct handshake_req {
>   
>   enum hr_flags_bits {
>   	HANDSHAKE_F_REQ_COMPLETED,
> +	HANDSHAKE_F_REQ_SESSION,
>   };
>   
>   /* Invariants for all handshake requests for one transport layer
> @@ -63,6 +64,9 @@ enum hp_flags_bits {
>   	HANDSHAKE_F_PROTO_NOTIFY,
>   };
>   
> +/* alert.c */
> +int tls_alert_send(struct socket *sock, u8 level, u8 description);
> +
>   /* netlink.c */
>   int handshake_genl_notify(struct net *net, const struct handshake_proto *proto,
>   			  gfp_t flags);
> diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
> index b735f5cced2f..aad3c5b06b03 100644
> --- a/net/handshake/tlshd.c
> +++ b/net/handshake/tlshd.c
> @@ -18,6 +18,7 @@
>   #include <net/sock.h>
>   #include <net/handshake.h>
>   #include <net/genetlink.h>
> +#include <net/tls_prot.h>
>   
>   #include <uapi/linux/keyctl.h>
>   #include <uapi/linux/handshake.h>
> @@ -100,6 +101,9 @@ static void tls_handshake_done(struct handshake_req *req,
>   	if (info)
>   		tls_handshake_remote_peerids(treq, info);
>   
> +	if (!status)
> +		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
> +
>   	treq->th_consumer_done(treq->th_consumer_data, -status,
>   			       treq->th_peerid[0]);
>   }
> @@ -424,3 +428,22 @@ bool tls_handshake_cancel(struct sock *sk)
>   	return handshake_req_cancel(sk);
>   }
>   EXPORT_SYMBOL(tls_handshake_cancel);
> +
> +/**
> + * tls_handshake_close - send a Closure alert
> + * @sock: an open socket
> + *
> + */
> +void tls_handshake_close(struct socket *sock)
> +{
> +	struct handshake_req *req;
> +
> +	req = handshake_req_hash_lookup(sock->sk);
> +	if (!req)
> +		return;
> +	if (!test_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags))
> +		return;
> +	tls_alert_send(sock, TLS_ALERT_LEVEL_WARNING,
> +		       TLS_ALERT_DESC_CLOSE_NOTIFY);
> +}
> +EXPORT_SYMBOL(tls_handshake_close);
> 
Why do we need to check for the 'REQ_SESSION' flag?
Isn't the hash_lookup sufficient here?
And it it safe to just do a 'test_bit' here?
Wouldn't it be better to do

if (test_and_clear_bit()) tls_alert_send()

Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)



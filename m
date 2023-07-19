Return-Path: <netdev+bounces-18887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C52E6758F99
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B941C20B7B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10D2D2F8;
	Wed, 19 Jul 2023 07:52:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD998C8D0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:52:51 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EE71BE3
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:52:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F08EB1F8CD;
	Wed, 19 Jul 2023 07:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689753141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1v468TN4AMZgDIxg3ILZC5YRAoRdjDvIhssgXBNu1Sk=;
	b=XIdGAGk0vioPQeup/8siJWVSKrXWCnkNONIj4Y/9lMgHGSKxfLwhCSZqnJ+D6TAOOFW16C
	9lNFcmC4SyWH9ftNm0Ho7rMg0bMI+zisVTamRXPhSb5bvowiJGsegCM8P8GTaaCaGhIzTp
	uIuKDbeHf0Gcqka2PIBaWcT0gyrtKfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689753141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1v468TN4AMZgDIxg3ILZC5YRAoRdjDvIhssgXBNu1Sk=;
	b=zZz5ptexm2bUC11Ig3qYoGyv6PmaCNV8cykAPFYH4W26i2q131BmdmcrxNLkrXbwwMvIBy
	LPPLj7G8wsOWm9AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D493713460;
	Wed, 19 Jul 2023 07:52:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2F2FMzWWt2SEaQAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 19 Jul 2023 07:52:21 +0000
Message-ID: <8c9399d8-1f2e-5da0-28c2-722f382a5a08@suse.de>
Date: Wed, 19 Jul 2023 09:52:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v1 5/7] net/handshake: Add helpers for parsing
 incoming TLS Alerts
Content-Language: en-US
To: Chuck Lever <cel@kernel.org>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
References: <168970659111.5330.9206348580241518146.stgit@oracle-102.nfsv4bat.org>
 <168970685465.5330.12951636644707988195.stgit@oracle-102.nfsv4bat.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <168970685465.5330.12951636644707988195.stgit@oracle-102.nfsv4bat.org>
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
> Kernel TLS consumers can replace common TLS Alert parsing code with
> these helpers.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   include/net/handshake.h |    4 ++++
>   net/handshake/alert.c   |   46 ++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/include/net/handshake.h b/include/net/handshake.h
> index bb88dfa6e3c9..d0fd6a3898c6 100644
> --- a/include/net/handshake.h
> +++ b/include/net/handshake.h
> @@ -42,4 +42,8 @@ int tls_server_hello_psk(const struct tls_handshake_args *args, gfp_t flags);
>   bool tls_handshake_cancel(struct sock *sk);
>   void tls_handshake_close(struct socket *sock);
>   
> +u8 tls_record_type(const struct sock *sk, const struct cmsghdr *msg);
> +bool tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
> +		    u8 *level, u8 *description);
> +
>   #endif /* _NET_HANDSHAKE_H */
> diff --git a/net/handshake/alert.c b/net/handshake/alert.c
> index 999d3ffaf3e3..93e05d8d599c 100644
> --- a/net/handshake/alert.c
> +++ b/net/handshake/alert.c
> @@ -60,3 +60,49 @@ int tls_alert_send(struct socket *sock, u8 level, u8 description)
>   	ret = sock_sendmsg(sock, &msg);
>   	return ret < 0 ? ret : 0;
>   }
> +
> +/**
> + * tls_record_type - Look for TLS RECORD_TYPE information
> + * @sk: socket (for IP address information)
> + * @cmsg: incoming message to be parsed
> + *
> + * Returns zero or a TLS_RECORD_TYPE value.
> + */
> +u8 tls_record_type(const struct sock *sk, const struct cmsghdr *cmsg)
> +{
> +	u8 record_type;
> +
> +	if (cmsg->cmsg_level != SOL_TLS)
> +		return 0;
> +	if (cmsg->cmsg_type != TLS_GET_RECORD_TYPE)
> +		return 0;
> +
> +	record_type = *((u8 *)CMSG_DATA(cmsg));
> +	return record_type;
> +}
> +EXPORT_SYMBOL(tls_record_type);
> +
tls_process_cmsg() does nearly the same thing; why didn't you update it 
to use your helper?

> +/**
> + * tls_alert_recv - Look for TLS Alert messages
> + * @sk: socket (for IP address information)
> + * @msg: incoming message to be parsed
> + * @level: OUT - TLS AlertLevel value
> + * @description: OUT - TLS AlertDescription value
> + *
> + * Return values:
> + *   %true: @msg contained a TLS Alert; @level and @description filled in
> + *   %false: @msg did not contain a TLS Alert
> + */
> +bool tls_alert_recv(const struct sock *sk, const struct msghdr *msg,
> +		    u8 *level, u8 *description)
> +{
> +	const struct kvec *iov;
> +	u8 *data;
> +
> +	iov = msg->msg_iter.kvec;
> +	data = iov->iov_base;
> +	*level = data[0];
> +	*description = data[1];
> +	return true;
> +}
> +EXPORT_SYMBOL(tls_alert_recv);
> 
Shouldn't we check the type of message here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)


